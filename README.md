FĀBL
====

An implementation of [FAB](http://web.cecs.pdx.edu/~apt/cs322/fab.pdf) on the [LLVM](http://llvm.org).


Configuration
-------------

To run this code, you'll need to have installed:

- LLVM, built as a shared lib (`./configure --enable-shared`)
- JRuby 1.6 (easiest to install with rvm, `rvm install jruby`)
- the FFI gem, after switching to jruby with `rvm jruby`, `gem install ffi`
- the [llvm-ruby library](https://github.com/jvoorhis/ruby-llvm)

And to run it, type:

`rvm jruby; ruby -J-classpath 'src:src/frontend.jar:.' sandbox/integration.rb`


Organization
------------

- /bm : benchmarks
- /examples : FAB example files
- /ref : the reference implementation
- /sandbox : experiments
- /src : the project


Todo
----

- ✔ document how to run it
- ✔ makefile for AstShim.java


Authors
-------

- Matthaus Litteken <matthaus@cs.pdx.edu>
- Eric O'Connell <eoc@cs.pdx.edu>
