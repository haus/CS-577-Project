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

$mod = LLVM::Module.create("fabl")
$current_function = nil
$current_block = nil
$builder = LLVM::Builder.create
$temp = 0
$symbols = {}

def returning(val)
  yield val
  val
end

def next_temp
  returning "t_#{$temp}" do
    $temp += 1
  end
end

class Ast::Program
  def gen
    puts "Ast::Program"
    
    rtypes.each do |rtype|
      rtype.gen
    end
    
    $mod.functions.add("$main", [LLVM.Void], LLVM::Int32) do |main,|
      $current_function = main
      $current_block = main.basic_blocks.append
      
      $builder.position_at_end($current_block)
      
      body.gen

      ret = $builder.load $symbols[body.items.to_ary.last.name], "return"
      $builder.ret ret
    end
    
    $mod.verify
    $mod.dump

    engine = LLVM::ExecutionEngine.create_jit_compiler($mod)
    value = engine.run_function($mod.functions["$main"])
    puts "Value: #{value.to_i}"
  end
end

class Ast::RecordTypeDec
  def gen
    puts "Ast::RecordTypeDec"
  end
end

class Ast::Block
  def gen
    puts "Ast::Block"
    
    items.each do |item|
      item.gen
    end
  end
end

class Ast::VarDec
  def gen
    puts "Ast::VarDec #{name} #{type}"
    
    value = initializer.gen
    variable = $builder.alloca(LLVM::Int32, name)
    $symbols[name] = variable
    $builder.store(value, variable)
  end
end

class Ast::FuncDecs
  def gen
    decs.each do |dec|
      dec.gen
    end
  end
end

class Ast::FuncDec
  def gen
    puts "Ast::FuncDec #{name}(#{formals.map {|f| f.name }.join(', ')}) -> #{resultType.name}"
    
    body.gen
  end
end

class Ast::AssignSt
  def gen
    puts "Ast::AssignSt #{lhs}"
    
    rhs.gen
  end
end

class Ast::CallSt
  def gen
    puts "Ast::CallSt #{func} #{args}"
  end
end

class Ast::ReadSt
  def gen
    puts "Ast::ReadSt"
    
    targets.each do |target|
      target.gen
    end
  end
end

class Ast::WriteSt 
  def gen
    puts "Ast::WriteSt"
    
    exps.each do |exp|
      exp.gen
    end
  end
end

class Ast::IfSt
  def gen
    puts "Ast::IfSt #{test}"
    
    ifTrue.gen
    ifFalse.gen
  end
end

class Ast::WhileSt 
  def gen
    puts "Ast::WhileSt #{test}"
    
    body.gen
  end
end

class Ast::LoopSt
  def gen
    puts "Ast::LoopSt"
    
    body.gen
  end
end

class Ast::ForSt 
  def gen
    puts "Ast::ForSt #{loopVar} #{start} #{stop} #{step}"
    
    body.gen
  end
end

class Ast::ExitSt 
  def gen
    puts "Ast::ExitSt "
  end
end

class Ast::ReturnSt
  def gen
    puts "Ast::ReturnSt #{returnValue}"
  end
end

class Ast::BlockSt
  def gen
    puts "Ast::BlockSt"
    
    body.gen
  end
end

class Ast::BinOpExp
  OPERATORS = ['<', '<=', '>', '>=', '=', '!=', '+', '-', '*', '/', 'div', 'mod', 'and', 'or']
  INSTRUCTIONS = [nil, nil, nil, nil, nil, nil, :add, :sub, :mul, :fdiv, :sdiv, :srem, :and, :or]
  
  def gen
    puts "Ast::BinOpExp #{OPERATORS[binOp]}"
    
    lhs = left.gen
    rhs = right.gen

    $builder.send INSTRUCTIONS[binOp], lhs, rhs, next_temp
  end
end

class Ast::UnOpExp
  OPERATORS = ['-', 'not']

  def gen
    puts "Ast::UnOpExp #{OPERATORS[unOp]}"
    
    operand.gen
  end
end

class Ast::LvalExp
  def gen
    puts "Ast::LvalExp #{lval}"

    $builder.load $symbols[lval.name], next_temp
  end
end

class Ast::CallExp
  def gen
    puts "Ast::CallExp #{func}"
    
    args.each do |arg|
      arg.gen
    end
  end
end

class Ast::ArrayInit
  def gen
    puts "Ast::ArrayInit"

    count.gen
    value.gen
  end
end

class Ast::ArrayExp
  def gen
    puts "Ast::ArrayExp #{type}"
    
    initializers.each do |initializer|
      initializer.gen
    end
  end
end

class Ast::RecordInit
  def gen
    puts "Ast::RecordInit #{name} #{offset}"
    
    value.gen
  end
end

class Ast::RecordExp
  def gen
    puts "Ast::RecordExp #{typeName}"
    
    initializers.each do |initializer|
      initializer.gen
    end
  end
end

class Ast::IntLitExp
  def gen
    puts "Ast::IntLitExp #{lit}"
    LLVM::Int32.from_i(lit.to_i)
  end
end

class Ast::RealLitExp
  def gen
    puts "Ast::RealLitExp #{lit}"
  end
end

class Ast::StringLitExp
  def gen
    puts "Ast::StringLitExp #{lit}"
  end
end

class Ast::BlockItem
  def gen
    puts "Ast::BlockItem #{self.class}"
  end
end


program.gen
