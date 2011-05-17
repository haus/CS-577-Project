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
    
    ref = lhs.gen
    val = rhs.gen
    
    $builder.store(val, ref)
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
    
    testVal      = test.gen
    trueBlock    = $current_function.basic_blocks.append
    falseBlock   = $current_function.basic_blocks.append
    endBlock     = $current_function.basic_blocks.append
    
    $builder.cond(
      $builder.icmp(:eq, testVal, LLVM::Int(1)),
      trueBlock, falseBlock)

    $builder.position_at_end(trueBlock)
    $current_block = trueBlock
    ifTrue.gen
    $builder.br(endBlock)

    $builder.position_at_end(falseBlock)
    $current_block = falseBlock
    ifFalse.gen
    $builder.br(endBlock)
    
    $builder.position_at_end(endBlock)
    $current_block = endBlock
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
  def gen
    puts "Ast::BinOpExp #{OPERATORS[binOp]}"
    
    lhs = left.gen
    rhs = right.gen
    if binOp >= 6
      $builder.send INSTRUCTIONS[binOp], lhs, rhs, next_temp
    else
      $builder.send :icmp, INSTRUCTIONS[binOp], lhs, rhs, next_temp
    end
  end
end

class Ast::UnOpExp
  OPERATORS = ['-', 'not']
  INSTRUCTIONS = [:neg , :not]

  def gen
    puts "Ast::UnOpExp #{OPERATORS[unOp]}"
    
    op = operand.gen

    $builder.send INSTRUCTIONS[unOp], op, next_temp

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

class Ast::VarLvalue
  def gen
    puts "Ast::VarLvalue #{name}"
    return $symbols[name]
  end
end

program.gen
