require 'java'
require 'rubygems'
require 'ruby-debug'
require 'src/frontend.jar'

$: << 'lib'

require 'llvm/core'
require 'llvm/execution_engine'
require 'llvm/transforms/scalar'

LLVM.init_x86

include_class 'Ast'
include_class 'AstShim'
include_class 'Check'

source = ARGV[0] || 'examples/if.fab'
program = AstShim::giveMeAST(source)
Check.check(program)

DEBUG = true

def returning(val)
  yield val
  val
end

def log(str)
  puts str if DEBUG
end

class Context
  attr_accessor :builder, :printf, :malloc
  
  def initialize(module_name)
    @mod = LLVM::Module.create("fabl")
    @current_function = nil
    @current_block = nil
    @builder = LLVM::Builder.create
    @temp_index = 0
    @symbols = {}
    
    init_runtime
  end
  
  def init_runtime
    @printf = @mod.functions.add("printf", LLVM.Function([LLVM.Pointer(LLVM::Int8)], LLVM::Int32, {:varargs => true}))
    @malloc = @mod.functions.add("malloc", LLVM.Function([LLVM::Int32], LLVM.Pointer(LLVM::Int8)))
  end
  
  def write_int(value)
    @print_int = @builder.global_string_pointer("%d\n")
    @builder.call @printf, @print_int, value
  end

  def next_temp
    returning "t_#{@temp_index}" do
      @temp_index += 1
    end
  end
  
  def add_function(name, *args, &blk)
    @mod.functions.add(name, *args) do |f,*params|
      @current_function = f
      yield f,*params if blk
    end
  end

  def new_block
    @current_function.basic_blocks.append
  end
  
  def current_block=(block)
    @current_block = block
    @builder.position_at_end(block)
  end
  
  def optimize!
    @engine ||= engine
    @fpm = LLVM::FunctionPassManager.new(@engine, @mod)
    @fpm << 'mem2reg'
    @fpm << 'constprop'
    @fpm << 'simplifycfg'
    @fpm << 'adce'
    @mod.functions.each {|f| @fpm.run(f) }
  end
  
  def verify
    @mod.verify
  end
  
  def dump(file = nil)
    save_stderr = $stderr
    if file
      $stderr = File.open(file, "w")
    end
    @mod.dump
    if file
      $stderr.close
    end
  ensure
    $stderr = save_stderr
  end
  
  def engine
    LLVM::ExecutionEngine.create_jit_compiler(@mod)
  end
  
  def execute
    @engine ||= engine
    @engine.run_function(@mod.functions['$main'])
  end
  
  def [](symbol)
    @symbols[symbol]
  end
  
  def []=(symbol, value)
    @symbols[symbol] = value
  end
  
  def llvm_type(type)
    if Ast.is_boolean_type(type)
      LLVM::Int8
    elsif Ast.is_integer_type(type)
      LLVM::Int32
    else
      LLVM::Pointer(LLVM::Int8)
    end
  end

end

class Ast::Program
  def gen(context)
    log "Ast::Program"
    
    rtypes.each do |rtype|
      rtype.gen(context)
    end
    
    context.add_function("$main", [], LLVM::Int32) do |main,|
      entry = context.new_block
      return_block = context.new_block
      context.current_block = entry
      
      body.gen(context, nil, return_block)
      
      context.builder.br return_block
      context.current_block = return_block

      # XXX:eo hack, last item must be a vardec, gives return value
      # stupid :)
      ret = context.builder.load context[body.items.to_ary.last.symbol], "return"
      context.builder.ret ret
    end

    context.verify
    context.optimize!
    context.dump('fabl.s')

    value = context.execute
    
    log "Value: #{value.to_i}"
  end
end

class Ast::RecordTypeDec
  def gen(context)
    log "Ast::RecordTypeDec"
  end
end

class Ast::Block
  def gen(context, exit_block, return_block)
    log "Ast::Block"
        
    items.each do |item|
      if item.class.ancestors.include?(Ast::St)
        item.gen(context, exit_block, return_block)
      else
        item.gen(context)
      end
    end
  end
end

class Ast::VarDec
  def gen(context)
    log "Ast::VarDec #{symbol} #{type}"
    
    value = initializer.gen(context)
    variable = context.builder.alloca(context.llvm_type(type), symbol)
    context[symbol] = variable
    context.builder.store(value, variable)
  end
  
  def symbol
    "#{name}_#{unique}"
  end
end

class Ast::FuncDecs
  def gen(context)
    decs.each do |dec|
      dec.gen(context)
    end
  end
end

class Ast::FuncDec
  def gen(context, exit_block, return_block)
    log "Ast::FuncDec #{name}(#{formals.map {|f| f.name }.join(', ')}) -> #{resultType.name}"
    
    body.gen(context)
  end
end

class Ast::AssignSt
  def gen(context, exit_block, return_block)
    log "Ast::AssignSt #{lhs}"
    
    ref = lhs.gen(context)
    val = rhs.gen(context)
    
    context.builder.store(val, ref)
  end
end

class Ast::CallSt
  def gen(context, exit_block, return_block)
    log "Ast::CallSt #{func} #{args}"
  end
end

class Ast::ReadSt
  def gen(context, exit_block, return_block)
    log "Ast::ReadSt"
    
    targets.each do |target|
      target.gen(context)
    end
  end
end

class Ast::WriteSt 
  def gen(context, exit_block, return_block)
    log "Ast::WriteSt"
    exps.each do |exp|
      value = exp.gen(context)
      puts exp.class.to_s
      context.write_int(value)
    end
  end
end

class Ast::IfSt
  def gen(context, exit_block, return_block)
    log "Ast::IfSt #{test}"
    
    test_val      = test.gen(context)
    true_block    = context.new_block
    false_block   = context.new_block
    end_block     = context.new_block
    
    context.builder.cond(context.builder.icmp(:eq, test_val, LLVM::Int1.from_i(1)), 
      true_block, false_block)

    context.current_block = true_block
    ifTrue.gen(context, exit_block, return_block)
    context.builder.br(end_block)

    context.current_block = false_block
    ifFalse.gen(context, exit_block, return_block)
    context.builder.br(end_block)
    
    context.current_block = end_block
  end
end

class Ast::WhileSt 
  def gen(context, exit_block, return_block)
    log "Ast::WhileSt #{test}"
    
    test_block = context.new_block
    body_block = context.new_block
    exit_block = context.new_block

    context.builder.br(test_block)

    context.current_block = test_block
    test_val = test.gen(context)
    
    context.builder.cond(context.builder.icmp(:eq, test_val, LLVM::Int1.from_i(1)), 
      body_block, exit_block)
    
    context.current_block = body_block
    body.gen(context, exit_block, return_block)
    
    context.builder.br(test_block)
    
    context.current_block = exit_block
  end
end

class Ast::LoopSt
  def gen(context, exit_block, return_block)
    log "Ast::LoopSt"
    
    body_block = context.new_block
    exit_block = context.new_block
    
    context.builder.br(body_block)
    
    context.current_block = body_block
    body.gen(context, exit_block, return_block)

    context.builder.br(body_block)
    
    context.current_block = exit_block
  end
end

class Ast::ForSt 
  def gen(context, exit_block, return_block)
    log "Ast::ForSt #{loop_symbol} #{start} #{stop} #{step}"

    test_block = context.new_block
    body_block = context.new_block
    exit_block = context.new_block

    loop_start = start.gen(context)
    loop_step = step.gen(context)
    loop_stop = stop.gen(context)

    # Assign start to loopVar
    context.builder.store(loop_start, context[loop_symbol])
    context.builder.br(test_block)
    
    context.current_block = test_block
    
    current = context.builder.load context[loop_symbol], "loop_val"
    context.builder.cond(context.builder.icmp(:sle, current, loop_stop), 
      body_block, exit_block)
      
    context.current_block = body_block
    body.gen(context, exit_block, return_block)
    
    result = context.builder.add current, loop_step, "loop_temp"
    context.builder.store(result, context[loop_symbol])
    
    context.builder.br(test_block)
    
    context.current_block = exit_block
  end
  
  def loop_symbol
    "#{loopVar}_#{unique}"
  end
end

class Ast::ExitSt 
  def gen(context, exit_block, return_block)
    log "Ast::ExitSt"
    
    if exit_block
      exit_st = context.new_block
      context.builder.br(exit_st)
      context.current_block = exit_st
      context.builder.br(exit_block)
      context.current_block = context.new_block
    end
    
  end
end

class Ast::ReturnSt
  def gen(context, exit_block, return_block)
    log "Ast::ReturnSt #{returnValue}"
  end
end

class Ast::BlockSt
  def gen(context, exit_block, return_block)
    log "Ast::BlockSt"
    
    body.gen(context, exit_block, return_block)
  end
end

class Ast::BinOpExp
  OPERATORS = ['<', '<=', '>', '>=', '=', '!=', '+', '-', '*', '/', 'div', 'mod', 'and', 'or']
  INSTRUCTIONS = [:slt, :sle, :sgt, :sge, :eq, :ne, :add, :sub, :mul, :fdiv, :sdiv, :srem, :and, :or]

  def gen(context)
    log "Ast::BinOpExp #{OPERATORS[binOp]}"
    
    lhs = left.gen(context)
    rhs = right.gen(context)
    if binOp >= 6
      context.builder.send INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
    else
      context.builder.icmp INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
    end
  end
end

class Ast::UnOpExp
  OPERATORS = ['-', 'not']
  INSTRUCTIONS = [:neg , :not]

  def gen(context)
    log "Ast::UnOpExp #{OPERATORS[unOp]}"
    
    op = operand.gen(context)

    context.builder.send INSTRUCTIONS[unOp], op, context.next_temp
  end
end

class Ast::LvalExp
  def gen(context)
    log "Ast::LvalExp #{lval}"

    context.builder.load lval.gen(context), context.next_temp
  end
end

class Ast::CallExp
  def gen(context)
    log "Ast::CallExp #{func}"
    
    args.each do |arg|
      arg.gen(context)
    end
  end
end

class Ast::ArrayInit
  def gen(context)
    log "Ast::ArrayInit"

    count.gen(context)
    value.gen(context)
  end
end

class Ast::ArrayExp
  def gen(context)
    log "Ast::ArrayExp #{type}"
    
    vals = []
    array_size = context.builder.alloca LLVM::Int32, "array_size"
    context.builder.store LLVM::Int32.from_i(0), array_size
    
    counts = initializers.inject([]) do |cs, initializer|
      count = initializer.count.gen(context)
      
      new_count = context.builder.alloca LLVM::Int32, "new_count"
      context.builder.store count, new_count
      
      negative_count = context.new_block
      continue = context.new_block
      
      context.builder.cond(
        context.builder.icmp(:sge, count, LLVM::Int32.from_i(0)),
        continue,
        negative_count
      )
      
      context.current_block = negative_count
      context.builder.store LLVM::Int32.from_i(0), new_count
      context.builder.br continue
      
      context.current_block = continue

      current_size = context.builder.load array_size, "current_size"
      increment = context.builder.load new_count, "increment"
      new_size = context.builder.add current_size, increment, "new_size"
      context.builder.store new_size, array_size

      cs << new_count
    end
    
    current_size = context.builder.load array_size, "current_size"
    element_size = LLVM::Int32.from_i(4)
    array_bytes = context.builder.mul current_size, element_size, "array_bytes"
    count_size = LLVM::Int32.from_i(4)
    total_bytes = context.builder.add array_bytes, count_size, "total_bytes"
    
    array_loc_tmp = context.builder.call context.malloc, total_bytes
    array_loc = context.builder.alloca LLVM::Pointer(LLVM::Array(LLVM::Int32, 0)), "array_loc"
    array_loc_tmp_bitcast = context.builder.bit_cast array_loc_tmp, LLVM::Pointer(LLVM::Array(LLVM::Int32, 0)), "array_loc_tmp_bitcast"
    context.builder.store array_loc_tmp_bitcast, array_loc
    
    array_base = context.builder.load array_loc, "array_base"
    ptr = context.builder.gep(array_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(0)])
    context.builder.store(current_size, ptr)
    
    array_index = context.builder.alloca LLVM::Int32, "array_index"
    context.builder.store LLVM::Int32.from_i(1), array_index
    
    initializers.each_with_index do |initializer, i|
      log "Initializer value: #{initializer.value}"
      value = initializer.value.gen(context)
      counter = context.builder.alloca LLVM::Int32, "counter"
      context.builder.store LLVM::Int32.from_i(0), counter
      
      store_block = context.new_block
      continue_block = context.new_block
      
      context.builder.cond(
        context.builder.icmp(:sge, counter, counts[i]),
        continue_block,
        store_block
      )
      
      context.current_block = store_block
      
      current_index = context.builder.load array_index, "current_index"
      ptr = context.builder.gep(array_base, [LLVM::Int32.from_i(0), current_index])
      context.builder.store(value, ptr)
      new_index = context.builder.add current_index, LLVM::Int32.from_i(1), "new_index"
      context.builder.store(new_index, array_index)
      context.builder.br continue_block
      
      context.current_block = continue_block

      count = counts[i]
    end
    
    context.builder.load array_loc
    # log counts.inspect
  end
end

class Ast::RecordInit
  def gen(context)
    log "Ast::RecordInit #{name} #{offset}"
    
    value.gen(context)
  end
end

class Ast::RecordExp
  def gen(context)
    log "Ast::RecordExp #{typeName}"
    
    initializers.each do |initializer|
      initializer.gen(context)
    end
  end
end

class Ast::IntLitExp
  def gen(context)
    log "Ast::IntLitExp #{lit}"
    LLVM::Int32.from_i(lit.to_i)
  end
end

class Ast::RealLitExp
  def gen(context)
    log "Ast::RealLitExp #{lit}"
  end
end

class Ast::StringLitExp
  def gen(context)
    log "Ast::StringLitExp #{lit}"
  end
end

class Ast::BlockItem
  def gen(context)
    log "Ast::BlockItem #{self.class}"
  end
end

class Ast::VarLvalue
  def gen(context)
    log "Ast::VarLvalue #{symbol}"
    return context[symbol]
  end
  
  def symbol
    "#{name}_#{unique}"
  end
end

class Ast::ArrayDerefLvalue
  def gen(context)
    log "Ast::ArrayDerefLvalue"
    
    array_index = index.gen(context)
    array_loc_tmp = array.gen(context)
    array_loc = context.builder.bit_cast array_loc_tmp, LLVM::Pointer(LLVM::Pointer(LLVM::Array(LLVM::Int32, 0))), "array_loc"
    array_base = context.builder.load array_loc, "array_base"
    actual_index = context.builder.add LLVM::Int32.from_i(1), array_index
    element_ptr = context.builder.gep array_base, [LLVM::Int32.from_i(0), actual_index]
  end
end

program.gen(Context.new("fabl"))
