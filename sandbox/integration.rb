require 'java'
require 'src/frontend.jar'

include_class 'Ast'
include_class 'AstShim'

program = AstShim::giveMeAST('examples/hanoi.fab')

print program.to_pretty(0)