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

def returning(val)
  yield val
  val
end

class Context
  attr_accessor :builder, :symbols
  
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
    returning @current_function.basic_blocks.append do |b|
      @current_block = b
      @builder.position_at_end b
    end
  end
  
  def verify
    @mod.verify
  end
  
  def dump
    @mod.dump
  end
  
  def execute
    @engine = LLVM::ExecutionEngine.create_jit_compiler(@mod)
    @engine.run_function(@mod.functions['$main'])
  end

end

class Ast::Program
  def gen(context)
    puts "Ast::Program"
    
    rtypes.each do |rtype|
      rtype.gen(context)
    end

    # $mod.functions.add("$main", [LLVM.Void], LLVM::Int32) do |main,|
    #   $current_function = main
    #   $current_block = main.basic_blocks.append
    #   
    #   $builder.position_at_end($current_block)
    
    context.add_function("$main", [LLVM.Void], LLVM::Int32) do |main,|
      entry = context.new_block
      body.gen(context)

      ret = context.builder.load context.symbols[body.items.to_ary.last.name], "return"
      context.builder.ret ret
    end

    context.verify
    context.dump

    value = context.execute

    puts "Value: #{value.to_i}"
  end
end

class Ast::RecordTypeDec
  def gen(context)
    puts "Ast::RecordTypeDec"
  end
end

class Ast::Block
  def gen(context)
    puts "Ast::Block"
    
    items.each do |item|
      item.gen(context)
    end
  end
end

class Ast::VarDec
  def gen(context)
    puts "Ast::VarDec #{name} #{type}"
    
    value = initializer.gen(context)
    variable = context.builder.alloca(LLVM::Int32, name)
    context.symbols[name] = variable
    context.builder.store(value, variable)
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
    puts "Ast::FuncDec #{name}(#{formals.map {|f| f.name }.join(', ')}) -> #{resultType.name}"
    
    body.gen(context)
  end
end

class Ast::AssignSt
  def gen(context)
    puts "Ast::AssignSt #{lhs}"
    
    rhs.gen(context)
  end
end

class Ast::CallSt
  def gen(context)
    puts "Ast::CallSt #{func} #{args}"
  end
end

class Ast::ReadSt
  def gen(context)
    puts "Ast::ReadSt"
    
    targets.each do |target|
      target.gen(context)
    end
  end
end

class Ast::WriteSt 
  def gen(context)
    puts "Ast::WriteSt"
    
    exps.each do |exp|
      exp.gen(context)
    end
  end
end

class Ast::IfSt
  def gen(context)
    puts "Ast::IfSt #{test}"
    
    ifTrue.gen(context)
    ifFalse.gen(context)
  end
end

class Ast::WhileSt 
  def gen(context)
    puts "Ast::WhileSt #{test}"
    
    body.gen(context)
  end
end

class Ast::LoopSt
  def gen(context)
    puts "Ast::LoopSt"
    
    body.gen(context)
  end
end

class Ast::ForSt 
  def gen(context)
    puts "Ast::ForSt #{loopVar} #{start} #{stop} #{step}"
    
    body.gen(context)
  end
end

class Ast::ExitSt 
  def gen(context)
    puts "Ast::ExitSt "
  end
end

class Ast::ReturnSt
  def gen(context)
    puts "Ast::ReturnSt #{returnValue}"
  end
end

class Ast::BlockSt
  def gen(context)
    puts "Ast::BlockSt"
    
    body.gen(context)
  end
end

class Ast::BinOpExp
  OPERATORS = ['<', '<=', '>', '>=', '=', '!=', '+', '-', '*', '/', 'div', 'mod', 'and', 'or']
  INSTRUCTIONS = [nil, nil, nil, nil, nil, nil, :add, :sub, :mul, :fdiv, :sdiv, :srem, :and, :or]
  
  def gen(context)
    puts "Ast::BinOpExp #{OPERATORS[binOp]}"
    
    lhs = left.gen(context)
    rhs = right.gen(context)

    context.builder.send INSTRUCTIONS[binOp], lhs, rhs, context.next_temp
  end
end

class Ast::UnOpExp
  OPERATORS = ['-', 'not']

  def gen(context)
    puts "Ast::UnOpExp #{OPERATORS[unOp]}"
    
    operand.gen(context)
  end
end

class Ast::LvalExp
  def gen(context)
    puts "Ast::LvalExp #{lval}"

    context.builder.load context.symbols[lval.name], context.next_temp
  end
end

class Ast::CallExp
  def gen(context)
    puts "Ast::CallExp #{func}"
    
    args.each do |arg|
      arg.gen(context)
    end
  end
end

class Ast::ArrayInit
  def gen(context)
    puts "Ast::ArrayInit"

    count.gen(context)
    value.gen(context)
  end
end

class Ast::ArrayExp
  def gen(context)
    puts "Ast::ArrayExp #{type}"
    
    initializers.each do |initializer|
      initializer.gen(context)
    end
  end
end

class Ast::RecordInit
  def gen(context)
    puts "Ast::RecordInit #{name} #{offset}"
    
    value.gen(context)
  end
end

class Ast::RecordExp
  def gen(context)
    puts "Ast::RecordExp #{typeName}"
    
    initializers.each do |initializer|
      initializer.gen(context)
    end
  end
end

class Ast::IntLitExp
  def gen(context)
    puts "Ast::IntLitExp #{lit}"
    LLVM::Int32.from_i(lit.to_i)
  end
end

class Ast::RealLitExp
  def gen(context)
    puts "Ast::RealLitExp #{lit}"
  end
end

class Ast::StringLitExp
  def gen(context)
    puts "Ast::StringLitExp #{lit}"
  end
end

class Ast::BlockItem
  def gen(context)
    puts "Ast::BlockItem #{self.class}"
  end
end


program.gen(Context.new("fabl"))
