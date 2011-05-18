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
  attr_accessor :builder
  
  def initialize(module_name)
    @mod = LLVM::Module.create("fabl")
    @current_function = nil
    @current_block = nil
    @builder = LLVM::Builder.create
    @temp_index = 0
    @symbols = {}
  end

  def next_temp
    returning "t_#{@temp_index}" do
      @temp_index += 1
    end
  end
  
  def add_function(name, *args, &blk)
    @mod.functions.add(name, *args) do |f,*params|
      @current_function = f
      yield f,*params
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
  
  def dump
    @mod.dump
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

end

class Ast::Program
  def gen(context)
    log "Ast::Program"
    
    rtypes.each do |rtype|
      rtype.gen(context)
    end
    
    context.add_function("$main", [], LLVM::Int32) do |main,|
      entry = context.new_block
      context.current_block = entry
      
      body.gen(context)

      # XXX:eo hack, last item must be a vardec, gives return value
      # stupid :)
      ret = context.builder.load context[body.items.to_ary.last.symbol], "return"
      context.builder.ret ret
    end

    context.verify
    context.optimize!
    context.dump

    value = context.execute

    puts "Value: #{value.to_i}"
  end
end

class Ast::RecordTypeDec
  def gen(context)
    log "Ast::RecordTypeDec"
  end
end

class Ast::Block
  def gen(context)
    log "Ast::Block"
    
    items.each do |item|
      item.gen(context)
    end
  end
end

class Ast::VarDec
  def gen(context)
    log "Ast::VarDec #{symbol} #{type}"
    
    value = initializer.gen(context)
    variable = context.builder.alloca(LLVM::Int32, symbol)
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
  def gen(context)
    log "Ast::FuncDec #{name}(#{formals.map {|f| f.name }.join(', ')}) -> #{resultType.name}"
    
    body.gen(context)
  end
end

class Ast::AssignSt
  def gen(context)
    log "Ast::AssignSt #{lhs}"
    
    ref = lhs.gen(context)
    val = rhs.gen(context)
    
    context.builder.store(val, ref)
  end
end

class Ast::CallSt
  def gen(context)
    log "Ast::CallSt #{func} #{args}"
  end
end

class Ast::ReadSt
  def gen(context)
    log "Ast::ReadSt"
    
    targets.each do |target|
      target.gen(context)
    end
  end
end

class Ast::WriteSt 
  def gen(context)
    log "Ast::WriteSt"
    
    exps.each do |exp|
      exp.gen(context)
    end
  end
end

class Ast::IfSt
  def gen(context)
    log "Ast::IfSt #{test}"
    
    test_val      = test.gen(context)
    true_block    = context.new_block
    false_block   = context.new_block
    end_block     = context.new_block
    
    context.builder.cond(context.builder.icmp(:eq, test_val, LLVM::Int1.from_i(1)), 
      true_block, false_block)

    context.current_block = true_block
    ifTrue.gen(context)
    context.builder.br(end_block)

    context.current_block = false_block
    ifFalse.gen(context)
    context.builder.br(end_block)
    
    context.current_block = end_block
  end
end

class Ast::WhileSt 
  def gen(context)
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
    body.gen(context)
    
    context.builder.br(test_block)
    
    context.current_block = exit_block
  end
end

class Ast::LoopSt
  def gen(context)
    log "Ast::LoopSt"
    body_block = context.new_block
    exit_block = context.new_block
    
    context.current_block = body_block
    body.gen(context)
    context.builder.br(body_block)
    
    context.current_block = exit_block
  end
end

class Ast::ForSt 
  def gen(context)
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
    
    current = context.builder.send :load, context[loop_symbol], "loop_val"
    context.builder.cond(context.builder.icmp(:sle, current, loop_stop), 
      body_block, exit_block)
      
    context.current_block = body_block
    body.gen(context)
    
    result = context.builder.send :add, current, loop_step, "loop_temp"
    context.builder.store(result, context[loop_symbol])
    
    context.builder.br(test_block)
    
    context.current_block = exit_block
  end
  
  def loop_symbol
    "#{loopVar}_#{unique}"
  end
end

class Ast::ExitSt 
  def gen(context)
    log "Ast::ExitSt"
    
    #context.builder.br(exit_block)
  end
end

class Ast::ReturnSt
  def gen(context)
    log "Ast::ReturnSt #{returnValue}"
  end
end

class Ast::BlockSt
  def gen(context)
    log "Ast::BlockSt"
    
    body.gen(context)
  end
end

class Ast::BinOpExp
  OPERATORS = ['<', '<=', '>', '>=', '=', '!=', '+', '-', '*', '/', 'div', 'mod', 'and', 'or']
  INSTRUCTIONS = [:slt, :sle, :sgt, :sge, :eq, :ne, :add, :sub, :mul, :fdiv, :sdiv, :srem, :and, :or]
  # Builds an icmp Instruction. Compares lhs to rhs (Instructions)
  # using the given symbol predicate (pred):
  #   :eq  - equal to
  #   :ne  - not equal to
  #   :ugt - unsigned greater than
  #   :uge - unsigned greater than or equal to
  #   :ult - unsigned less than
  #   :ule - unsigned less than or equal to
  #   :sgt - signed greater than
  #   :sge - signed greater than or equal to
  #   :slt - signed less than
  #   :sle - signed less than or equal to
  # @LLVMinst icmp
  # def icmp(pred, lhs, rhs, name = "")
  #   Instruction.from_ptr(C.LLVMBuildICmp(self, pred, lhs, rhs, name))
  # end
  def gen(context)
    log "Ast::BinOpExp #{OPERATORS[binOp]}"
    
    lhs = left.gen(context)
    rhs = right.gen(context)
    if binOp >= 6
      context.builder.send INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
    else
      context.builder.send :icmp, INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
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

    context.builder.load context[lval.symbol], context.next_temp
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
    
    initializers.each do |initializer|
      initializer.gen(context)
    end
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

program.gen(Context.new("fabl"))
