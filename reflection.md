FABL Presentation
-----------------

- Matthaus Litteken <mlitteken@cs.pdx.edu>
- Eric O'Connell <eoc@cs.pdx.edu>

Resources & Platforms
=====================

We decided to build from the type-checked AST emitted by the reference implementation of FAB from CS322. We were interested in using an alternative to Java for the implementation of the compiler, and so wrote it using JRuby in order to have direct access to the AST object. We also decided that, rather than generate LLVM-IR as ascii text, we would use the API, which fortunately is available to JRuby through the Ruby FFI. 

<!-- We had a type-checked AST from the reference typechecker of CS322. Since this was a java object, no llvm/java API, so we use jRuby with FFI bindings to LLVM. This worked well, after resolving access-qualifier issues (made everything public). -->

Installation & Running
======================

(haus please check)

* Install LLVM 2.9: http://llvm.org/
* Install JRuby: http://www.jruby.org/
* using JRuby, `gem install ffi` and `gem install ruby-debug`
* in the root of the source tree, jruby -J-classpath .:src:src/frontend.jar sandbox/integration.rb path/to/file.fab [none|half|full] [true|false]

The Design
==========

The compiler walks the AST, generating code for all top-level code and remembering functions to be generated later. <!-- Although this process could have worked, due to some short-sightedness a suitable mechanism for binding functions was not completed as part of this work; a possible solution will be discussed in the Future Work section. --> We began our process by integrating the AST with JRuby. In order to do this, we had to modify Ast.java to add 'public' access qualifiers to all fields and methods, because although we were using Ruby's ability to re-open classes and add methods to them, the specific implementation which JRuby uses seems to insert a class shim, which rendered the package variables inaccessible to our code.

The actual walk of the AST was performed by functions which we added to the Java AST objects using the aformentioned open classes of Ruby. These ended up being quite similar, though slightly less indirect, than the visitor pattern methods we wrote in CS322. Each of these gen() methods took a context as a parmater, which handled some of the LLVM-related bookkeeping (such as setting the current function & basic block) and maintaining a symbol table. The symbol table in the main branch simply resolved names to memory addresses (allocated by the LLVM alloca instruction), however in the unfinished 'closure' branch it was necessary to add "Resolvers" which mapped symbols to a tuple of (memory address, AST node) in order to preserve type information.

<!-- For better or for worse (that is to say, for worse) we chose to do an AST-walking-compiler. This works for the most part, but the code has gotten pretty messy. Probably would transform the AST into a simplified, native-Ruby (or other host-language) representation. Still, were able to quickly bootstrap most of the FAB language quickly.

Symbol table maps references to AST nodes, which aids in Type generation. 

Still working on closures, ugh. -->

Results
=======

(* insert fanciness here *)

LLVM optimizations are impressive, considering how easy it is to employ them. Simple to add, etc. Benchmarking is in progress, so no performance comparisons yet.

Reflections
===========

After some initial hiccups in getting all of the components to talk to each other, the early development of FABL proceeded at a speedy pace. We began by simply re-writing the pretty-printer in JRuby by walking the AST and printing each node. The actual functionality was brought up starting from emitting integer constants, then simple arithmetic operations. In order to verify that arithmetic was working before any infrastructure was in place, a shim was inserted into the code generation which caused the value of the last VarDec node to be returned by the main function, which could then be printed out as a result of the JIT execution. 

The remaining functionality was built up generally from simple, straight-line code up towards more complex control structures. One particular challenge was in bringing up some of the runtime support like input, output, and memory allocation. Fortunately we were able to leverage on top of LLVM's linkage with libc, which allowed us to directly call printf, scanf, and malloc from within our generated code. We chose to wrap these directly in "hand-generated" LLVM functions which were then called from the code generators, for example in WriteSt. As a note, we did not implement any garbage collection (or error-checking for malloc!) so allocation will occur until available memory is consumed.

Adding closures to this implementation proved to be an extremely difficult challenge for a variety of reasons. One major problem seemed to be that the level of abstraction at which we were working was not high enough; mostly due to the decision to work directly from the AST. The AST is not linearized, in other words, function declarations are still nested, so not all functions are known at the time of code generation. As time was closing in on the deadline, we believe that a potential workaround to this would be to pre-generate all function pointers ahead of time (with empty function bodies) which could then be bound to the call sites in closure records. The compilation would proceed in this manner:

* walk the entire AST without generating any code
* as function declarations are encountered, create empty LLVM functions for them
* bind these function pointers into the closure records as they are encountered during regular code generation

We think this would be a suitable workaround which would enable us to avoid the full linearization process with just a simple pre-processing phase.

One other major challenge in this project has been ensuring that we generate the correct types; LLVM IR is fully typed, and in fact its API depends on having the correct types available during code generation: if an operation is performed on an instruction of the wrong type, in general the process will segfault. One particular instruction which proved unruly was getElementPointer. <!-- haus: fill in gep experience? :) -->

LLVM's IR is strongly-typed. Constructing type signatures for a function which takes itself is "fun".. llvm-ruby's API is fairly well-adapted to Ruby idioms. However, as we were working on the project, some improvements have been made to the development branch would make some of the code nicer.

Future Work
===========

We would like to complete the work to support full FAB function-calling semantics including closures and mutual-recursion. In addition, in order to test more of LLVM's optimization infrastructure, real numbers would open up the door to more numerical testing. LLVM includes primitives for assisting with garbage collection, although it does not provide a garbage collector.

Reals, functions, closures, garbage collection, looking into order of  optimization, figuring out IPO, cleaning up & commenting the code.