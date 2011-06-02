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
MODULE = LLVM::Module.create("fabl")

def returning(val)
  yield val
  val
end

def log(str)
  puts str if DEBUG
end

class Context
  attr_accessor :builder, :current_function, :fns_to_generate
  
  def functions
    @mod.functions
  end

  [:printf, :malloc, :scanf, :_write_int, :_write_string, :_write_bool, :_read_int].each do |accessor_or_delegate|
    define_method accessor_or_delegate do
      instance_variable_get("@#{accessor_or_delegate.to_s}") || @parent.send(accessor_or_delegate)
    end
  end
  
  def initialize(mod, parent = nil)
    @mod = mod
    @parent = parent
    @current_function = nil
    @current_block = nil
    @builder = LLVM::Builder.create
    @temp_index = 0
    @symbols = {}
    @strings = {}
    @globals = {}
    @fns_to_generate = if parent
      parent.fns_to_generate
    else
      []
    end
    
    unless parent
      init_runtime
      init_types
      init_globals
    end
  end
  
  def init_runtime
    @printf = @mod.functions.add("printf", LLVM.Function([LLVM.Pointer(LLVM::Int8)], LLVM::Int32, {:varargs => true}))
    @scanf = @mod.functions.add("scanf", LLVM.Function([LLVM.Pointer(LLVM::Int8)], LLVM::Int32, {:varargs => true}))
    @malloc = @mod.functions.add("malloc", LLVM.Function([LLVM::Int], LLVM.Pointer(LLVM::Int8)))
    @exit = @mod.functions.add("exit", LLVM.Function([LLVM::Int32], LLVM.Void))

    @_read_int = add_fn("_read_int", LLVM.Function([LLVM.Pointer(LLVM::Int32)], LLVM.Void)) do |read_int, int|
      self.current_block = new_block
      int_store = @builder.alloca LLVM::Int32, "int_store"
      int_format_string = strings("%d", "int_format_string")
      @builder.call @scanf, int_format_string, int_store
      int_return = @builder.load int_store, "int_return"
      @builder.store int_return, int

      @builder.ret_void
    end
    
    @_write_int = add_fn("_write_int", LLVM.Function([LLVM::Int32], LLVM.Void)) do |write_int, int|
      self.current_block = new_block
      
      int_format_string = strings("%d\n", "int_format_string")
      @builder.call @printf, int_format_string, int

      @builder.ret_void
    end
    
    @_write_string = add_fn("_write_string", LLVM.Function([LLVM.Pointer(LLVM::Int8)], LLVM.Void)) do |write_string, string|
      self.current_block = new_block

      string_format_string = strings("%s\n", "string_format_string")
      @builder.call @printf, string_format_string, string

      @builder.ret_void
    end

    @_write_bool = add_fn("_write_bool", LLVM.Function([LLVM::Int1], LLVM.Void)) do |write_bool, bool|
      self.current_block = new_block

      true_block = new_block
      false_block = new_block
      return_block = new_block

      @builder.cond(bool,
        true_block,
        false_block
      )

      self.current_block = true_block
      true_string = strings("true", "true_string")
      @builder.call(@_write_string, true_string)
      @builder.br return_block

      self.current_block = false_block
      false_string = strings("false", "false_string")
      @builder.call(@_write_string, false_string)
      @builder.br return_block

      self.current_block = return_block
      @builder.ret_void
    end
  end
  
  def init_types
    @symbols["integer"] = LLVM::Int32
    @symbols["boolean"] = LLVM::Int1
    @symbols["unit"] = LLVM.Void
  end
  
  def init_globals
    @symbols["true"] = Resolver.new(LLVM::Int1.from_i(1), nil)
    @symbols["false"] = Resolver.new(LLVM::Int1.from_i(0), nil)
    @symbols["nil"] = LLVM::Int8.from_i(0)
  end

  def read_int(int)
    @builder.call self._read_int, int
  end
  
  def write_bool(bool)
    @builder.call self._write_bool, bool
  end
  
  def write_int(int)
    @builder.call self._write_int, int
  end
  
  def write_string(string)
    @builder.call self._write_string, string
  end
  
  def exit(value)
    @builder.call @exit, LLVM::Int32.from_i(value)
  end
  
  def strings(str, name = '')
    @strings[str] ||= @builder.global_string_pointer(str, name)
  end
  
  def globals(name, type, value = nil)
    @globals[name] ||= (@mod.globals.named(name) || @mod.globals.add(type, name))

    if value
      @globals[name].initializer = value
      @globals[name].linkage = :internal
    end
    
    @globals[name]
  end

  def next_temp
    returning "t_#{@temp_index}" do
      @temp_index += 1
    end
  end
  
  def add_fn(name, *args, &blk)
    @mod.functions.add(name, *args) do |f,*params|
      @current_function = f
      yield f,*params if blk
    end
  end
  
  def gen_later(func)
    @fns_to_generate << func
  end
  
  def gen_fns
    @fns_to_generate.each do |fn|
      context = Context.new(@mod, self)
      log "..Generating #{fn.symbol}"
      
      llvm_fn = context.add_fn(fn.symbol, fn.args_signature(context), fn.resultType.llvm_type(context)) do |main,|        
        entry_block = context.new_block
        return_block = context.new_block
        
        context.current_block = entry_block
      
        # index into params starting at 1, because the closure is the first parameter
        fn.formals.each_with_index do |arg, i|
          context[arg.symbol] = RefResolver.new(context.builder.alloca(arg.llvm_type(context), arg.symbol), arg) #.llvm_type(context))
          context.builder.store context.current_function.params[i+1], context[arg.symbol].reference
        end
        
        # store the free variables into locals from the closure
        closure = context.builder.bit_cast context.current_function.params[0], fn.closure_arg_type(context)
        fn.freevars.each_with_index do |var, i|
          freevar = context.builder.alloca var.llvm_type(context), var.symbol
          closure_loc = context.builder.gep(closure, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(i)])
          context.builder.store(context.builder.load(closure_loc), freevar)

          # resolve (mutually-)recursive function symbols to their AST node
          if fn.is_fn?(var.symbol)
            context[var.symbol] = RefResolver.new(freevar, fn.function(var.symbol))
          else
            context[var.symbol] = RefResolver.new(freevar, var)
          end
        end
        
        fn.body.gen(context, nil, return_block)
      
        context.builder.br return_block
        context.current_block = return_block
        
        if fn.resultType.respond_to?(:name) and fn.resultType.name == "unit"
          context.builder.ret_void
        else
          context.builder.ret LLVM::Int32.from_i(0)
        end
      end
      
#      @fns_to_generate.unshift(*context.fns_to_generate)
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
    @mod.dump
  end
  
  def engine
    LLVM::ExecutionEngine.create_jit_compiler(@mod)
  end
  
  def execute
    @engine ||= engine
    @engine.run_function(@mod.functions['main'])
  end
  
  def [](symbol)
    @symbols[symbol] || @parent[symbol]
  end
  
  def []=(symbol, value)
    @symbols[symbol] = value
  end
  
  def llvm_type(type)
    if Ast.is_boolean_type(type)
      LLVM::Int1
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
    
    log "Generating $main()"
    context.add_fn("$main", [], LLVM::Int32) do |main,|
      entry_block = context.new_block
      return_block = context.new_block
      context.current_block = entry_block
      
      body.gen(context, nil, return_block)
      
      context.builder.br return_block
      context.current_block = return_block

      context.builder.ret LLVM::Int32.from_i(0)
    end

    log "Generating child functions"
    fns = context.gen_fns
    
    log "Functions: #{fns}"
    
    log "Generating main()"
    context.add_fn("main", [], LLVM::Int32) do |main,|
      entry_block = context.new_block
      context.current_block = entry_block

      fns.each do |fn|
        context.globals("__#{fn.symbol}__", fn.llvm_type(context), context.functions[fn.symbol])
      end
      
      context.builder.ret context.builder.call(context.functions['$main'])
    end

    context.verify
    # context.optimize!
    context.dump('fabl.s')

    context.execute
  end
  
end

class Ast::IdType
  def llvm_type(context)
    type.llvm_type(context)
  end
  
  def symbol
    "#{name}_#{unique}"
  end
end

class Ast::NamedType
  def llvm_type(context)
    context[name]
  end
end

class Ast::ArrayType
  def llvm_type(context)
    LLVM::Pointer(LLVM.Struct(LLVM::Int32, LLVM::Array(elementType.llvm_type(context), 0)))
  end
end

class Ast::RecordTypeDec
  def llvm_type(context)
    return context[name]
  end
  
  def gen(context)
    log "Ast::RecordTypeDec"
    
    elems = all_components.map do |i|
      i.type.llvm_type(context)
    end
    
    context[name] = LLVM::Type.struct(elems, false)
  end
end

# eek, arrowtypes and funcdecs don't have the same type signature
# because functions take a closure as their first argument, and because
# we don't know what the freevars will be, the arrow type adds a "dummy"
# i8* to the front of the arg list, which would need to be bitcast to
# the actual type of the function's closure
class Ast::ArrowType
  def llvm_type(context)
    LLVM.Pointer(LLVM.Function(args_signature(context), resultType.llvm_type(context)))
    # LLVM.Function(args_signature(context), resultType.llvm_type(context))
  end
  
  def args_signature(context)
    argTypes.map {|f| f.llvm_type(context) }
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

class Resolver
  attr_reader :ref
  
  def initialize(value, ref)
    @value, @ref = value, ref
  end
  
  def value(context)
    @value
  end
  
  def type(context)
    ref.llvm_type(context)
  end
end

class RefResolver < Resolver
  def value(context)
    context.builder.load @value
  end
  
  def reference
    @value
  end
end
    

class Ast::VarDec
  def gen(context)
    log "Ast::VarDec #{symbol} #{type}"
    resolver = initializer.gen(context)
    variable = context.builder.alloca(resolver.type(context), symbol)
    context.builder.store(resolver.value(context), variable)

    context[symbol] = RefResolver.new(variable, resolver.ref)
  end
  
  def llvm_type(context)
    type.llvm_type(context)
  end
  
  def symbol
    "#{name}_#{unique}"
  end
end

class Ast::FuncDecs
  def gen(context)
    log "Ast::FuncDecs"
    
    decs.each do |dec|
      dec.gen(context, self)
    end
  end
end

class Ast::FuncDec
  def gen(context, funcdecs)
    log "Ast::FuncDec #{name}"
    @funcdecs = funcdecs.decs.inject({}) {|decs, dec| decs[dec.symbol] = dec; decs }
    context[symbol] = RefResolver.new(context.globals("__#{symbol}__", llvm_type(context)), self)
    context.gen_later(self)
  end
  
  def is_fn?(symbol)
    !!@funcdecs[symbol]
  end
  
  def function(symbol)
    @funcdecs[symbol]
  end
  
  def llvm_type(context)
    LLVM.Pointer(LLVM.Function(args_signature(context), resultType.llvm_type(context)))
  end
  
  def args_signature(context)
    formals.map {|f| f.llvm_type(context) }.unshift closure_arg_type(context)
  end
  
  def closure_arg_type(context)
    LLVM.Pointer(closure_type(context))
  end
  
  def closure_type(context)
    LLVM.Struct(*freevars.map {|v| v.llvm_type(context) })
  end
  
  def mk_closure(context)
    closure_loc_tmp = context.builder.call context.malloc, closure_type(context).size
    closure_loc = context.builder.bit_cast closure_loc_tmp, closure_arg_type(context) 
    
    freevars.each_with_index do |var, i|
      freevar_loc = context.builder.gep(closure_loc, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(i)])
      context.builder.store(context[var.symbol].value(context), freevar_loc)
    end
    
    closure_loc
  end
  
  def real_freevars
    freevars.reject {|v| v.symbol == symbol }
  end
  
  def symbol
    "#{name}_#{unique}"
  end
end

class Ast::AssignSt
  def gen(context, exit_block, return_block)
    log "Ast::AssignSt #{lhs}"
    
    ref = lhs.gen(context).reference
    val = rhs.gen(context).value(context)
    
    context.builder.store(val, ref)
  end
end

class Ast::CallSt
  def gen(context, exit_block, return_block)
    log "Ast::CallSt #{func} #{args.map{|a| a.inspect}}"
    
    resolver = func.gen(context)
    fn = resolver.value(context)
    if args.length == 0
      context.builder.call fn, resolver.ref.mk_closure(context)
    else
      context.builder.call(fn, *args.map {|a| a.gen(context).value(context) }.unshift(resolver.ref.mk_closure(context)))
    end
  end
end

class Ast::ReadSt
  def gen(context, exit_block, return_block)
    log "Ast::ReadSt"
    
    targets.each do |target|
      value = target.gen(context)
      
      case target.type.name
        when 'integer' then context.read_int(value)
      end
    end
  end
end

class Ast::WriteSt 
  def gen(context, exit_block, return_block)
    log "Ast::WriteSt"
    exps.each do |exp|
      value = exp.gen(context).value(context)
      
      case exp.type.name
        when 'integer' then context.write_int(value)
        when 'boolean' then context.write_bool(value)
        when '?string' then context.write_string(value)
      end
      
    end
  end
end

class Ast::IfSt
  def gen(context, exit_block, return_block)
    log "Ast::IfSt #{test}"
    
    test_val      = test.gen(context).value(context)
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
    
    context.builder.cond(context.builder.icmp(:eq, test_val.value(context), LLVM::Int1.from_i(1)), 
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

    loop_start = start.gen(context).value(context)
    loop_step = step.gen(context).value(context)
    loop_stop = stop.gen(context).value(context)

    # Assign start to loopVar
    context.builder.store(loop_start, context[loop_symbol].reference)
    context.builder.br(test_block)
    
    context.current_block = test_block
    
    context.builder.cond(context.builder.icmp(:sle, context[loop_symbol].value(context), loop_stop), 
      body_block, exit_block)
      
    context.current_block = body_block
    body.gen(context, exit_block, return_block)
    
    result = context.builder.add context[loop_symbol].value(context), loop_step, "loop_temp"
    context.builder.store(result, context[loop_symbol].reference)
    
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

    if (returnValue != nil)
      context.builder.ret returnValue.gen(context).value(context)
    end
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
    lhs = left.gen(context).value(context)
    rhs = right.gen(context).value(context)
    result = if binOp >= 6
      context.builder.send INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
    else
      context.builder.icmp INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
    end
    Resolver.new(result, self)
  end
  
  def llvm_type(context)
    type.llvm_type(context)
  end
end

class Ast::UnOpExp
  OPERATORS = ['-', 'not']
  INSTRUCTIONS = [:neg , :not]

  def gen(context)
    log "Ast::UnOpExp #{OPERATORS[unOp]}"
    
    op = operand.gen(context)

    result = context.builder.send INSTRUCTIONS[unOp], op.value(context), context.next_temp
    Resolver.new(result, self)
  end
end

class Ast::LvalExp
  SPECIAL_VALUES = ["true", "false", "nil", "unit"]
  
  def gen(context)
    log "Ast::LvalExp #{lval}"

    if lval.is_a? Ast::VarLvalue
      SPECIAL_VALUES.include?(lval.name) and return context[lval.name]
    end

    lval.gen(context)
    # context.builder.load lval.gen(context).value, context.next_temp
  end
end

class Ast::CallExp
  def gen(context)
    log "Ast::CallExp #{func}"
    
    @resolver = func.gen(context)
    fn = @resolver.value(context)

    result = if args.length == 0
      context.builder.call fn
    else
      context.builder.call(fn, *args.map {|a| a.gen(context).value(context) }.unshift(@resolver.ref.mk_closure(context)))
    end
    Resolver.new(result, self)
  end
  
  def llvm_type(context)
    @resolver.ref.llvm_type(context)
  end
end

class Ast::ArrayInit
  def gen_count(context, array_size)
    cnt = count.gen(context)
    
    new_count = context.builder.alloca LLVM::Int32, "new_count"
    context.builder.store cnt, new_count
    
    negative_count = context.new_block
    continue = context.new_block
    
    context.builder.cond(
      context.builder.icmp(:sge, cnt, LLVM::Int32.from_i(0)),
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

    new_count
  end

  def gen_value(context, array_base, count, array_index)
    value = self.value.gen(context)
    counter = context.builder.alloca LLVM::Int32, "counter"
    context.builder.store LLVM::Int32.from_i(0), counter
    
    test_block = context.new_block
    store_block = context.new_block
    continue_block = context.new_block
    
    context.builder.br test_block
    
    context.current_block = test_block
    
    current_count = context.builder.load(counter)
    
    context.builder.cond(
      context.builder.icmp(:sge, current_count, context.builder.load(count)),
      continue_block,
      store_block
    )
    
    context.current_block = store_block
    
    current_index = context.builder.load array_index, "current_index"
    ptr = context.builder.gep(array_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(1), current_index])
    context.builder.store(value, ptr)
    
    new_index = context.builder.add current_index, LLVM::Int32.from_i(1), "new_index"
    context.builder.store(new_index, array_index)
    new_count = context.builder.add current_count, LLVM::Int32.from_i(1), "new_count"
    context.builder.store(new_count, counter)
    
    context.builder.br test_block
    
    context.current_block = continue_block
  end
end

class Ast::ArrayExp
  
  def gen(context)
    log "Ast::ArrayExp #{type}"

    # allocate a variable to hold array size, then iterate over each initializer,
    # saving the count and incrementing the @array_size
    @array_size = allocate_size(context)
    counts = initializers.map {|i| i.gen_count(context, @array_size) }
    @element_size = initializers[0].value.gen(context).type.size

    # malloc the number of bytes required for the array & store the size -4 bytes
    # before the beginning of the array
    @array_base = allocate_array(context)
    store_size(context)
    
    # allocate a variable to hold the initialization index, then iterate over each
    # initializer and store its value in the appropriate index(es) of the array
    array_index = allocate_initialization_index(context)
    initializers.each_with_index {|initializer, i| initializer.gen_value(context, @array_base, counts[i], array_index) }

    @array_base
  end
  
  def allocate_size(context)
    returning(context.builder.alloca LLVM::Int32, "array_size") do |array_size|
      context.builder.store LLVM::Int32.from_i(0), array_size
    end
  end
  
  def allocate_initialization_index(context)
    returning(context.builder.alloca LLVM::Int32, "array_index") do |array_index|
      context.builder.store LLVM::Int32.from_i(0), array_index
    end
  end
  
  def size_in_bytes(context)
    current_size = context.builder.load @array_size, "current_size"
    array_bytes = context.builder.mul current_size, @element_size, "array_bytes"
    count_size = LLVM::Int32.from_i(4)
    context.builder.add array_bytes, count_size, "total_bytes"
  end
  
  def allocate_array(context)
    array_loc_tmp = context.builder.call context.malloc, size_in_bytes(context)
    array_loc_tmp_bitcast = context.builder.bit_cast array_loc_tmp, 
      LLVM::Pointer(LLVM.Struct(LLVM::Int32, LLVM::Array(type.llvm_type(context), 0))), "array_loc_tmp_bitcast"

    array_loc = context.builder.alloca LLVM::Pointer(LLVM.Struct(LLVM::Int32, LLVM::Array(type.llvm_type(context), 0))), "array_loc"
    context.builder.store array_loc_tmp_bitcast, array_loc
    context.builder.load array_loc, "array_base"
  end
  
  def store_size(context)
    ptr = context.builder.gep(@array_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(0)])
    context.builder.store(context.builder.load(@array_size), ptr)
  end
end

class Ast::RecordExp
  def size_in_bytes(context)    
    @values = Array.new
    @record_bytes = context.builder.alloca LLVM::Int, "record_bytes"
    current_bytes = context.builder.alloca LLVM::Int, "current_bytes"
    context.builder.store LLVM::Int.from_i(0), @record_bytes
    initializers.each do |initializer|
      @values[initializer.offset] = initializer.value.gen(context)
      context.builder.store @values[initializer.offset].type.size, current_bytes
      context.builder.load current_bytes, "current_bytes"
      @record_bytes = context.builder.add current_bytes, @record_bytes, "record_bytes"
    end
  end

  def allocate(context)
    size_in_bytes(context)
    context.builder.load @record_bytes, "record_bytes"
    record_loc_tmp = context.builder.call context.malloc, @record_bytes
    record_loc_tmp_bitcast = context.builder.bit_cast record_loc_tmp, LLVM::Pointer(LLVM.Struct(*@elems)), "record_loc_tmp_bitcast"

    @record_loc = context.builder.alloca LLVM::Pointer(LLVM::Type.struct(@elems, false)), "record_loc"
    context.builder.store record_loc_tmp_bitcast, @record_loc
    @record_base = context.builder.load @record_loc, "record_base"
  end
  
  def gen(context)
    log "Ast::RecordExp #{typeName}"
    
    @elems = initializers.map do |i|
      i.type.llvm_type(context)
    end

    allocate(context)
    
    initializers.each do |initializer|
      ptr = context.builder.gep(@record_base, [LLVM::Int.from_i(0), LLVM::Int32.from_i(initializer.offset)])
      context.builder.store(@values[initializer.offset], ptr)
    end

    @record_base
  end
end

class Ast::IntLitExp
  def gen(context)
    log "Ast::IntLitExp #{lit}"
    Resolver.new(LLVM::Int32.from_i(lit.to_i), self)
  end
  
  def llvm_type(context)
    LLVM::Int32
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
    Resolver.new(context.strings(lit), self)
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
    array_loc = array.gen(context)
    array_base = context.builder.load array_loc, "array_base"
    
    boundscheck(context, array_base, array_index)
    
    actual_index = context.builder.add LLVM::Int32.from_i(0), array_index
    element_ptr = context.builder.gep array_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(1), actual_index]
  end
  
  def boundscheck(context, array_base, array_index)
    error_block = context.new_block
    okay_block = context.new_block
    
    array_size_ptr = context.builder.gep array_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(0)]
    array_size = context.builder.load array_size_ptr

    # using unsigned trick!
    context.builder.cond(
      context.builder.icmp(:ult, array_index, array_size),
      okay_block,
      error_block
    )
    
    context.current_block = error_block
    context.write_string(context.strings("Invalid array index!"))
    context.exit(-1)
    context.builder.br okay_block
    
    context.current_block = okay_block
  end
end

class Ast::RecordDerefLvalue
  def gen(context)
    log "Ast::RecordDerefLvalue"
    
    record_loc_tmp = record.gen(context)
    record_loc = context.builder.bit_cast record_loc_tmp, LLVM::Pointer(LLVM::Pointer(context[typeDec.name])), "record_loc"
    record_base = context.builder.load record_loc, "record_base"
    
    record_element_ptr = context.builder.gep record_base, [LLVM::Int32.from_i(0), LLVM::Int32.from_i(offset)]
  end
end

program.gen(Context.new(MODULE))
