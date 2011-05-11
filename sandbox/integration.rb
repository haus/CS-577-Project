require 'java'
require 'rubygems'
require 'ruby-debug'
require 'src/frontend.jar'

include_class 'Ast'
include_class 'AstShim'

source = ARGV[0] || 'examples/if.fab'
program = AstShim::giveMeAST(source)
print program.to_pretty(0)
print "\n"
print program.java_class.declared_field("rtypes")#getInstanceVariable("rtypes")

class Foo
  include Ast::TypeExpVisitor
end

print "\n"