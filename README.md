FAB-LLVM
========

An implementation of [FAB](http://web.cecs.pdx.edu/~apt/cs322/fab.pdf) on the [LLVM](http://llvm.org).


Configuration
-------------

To run this code, you'll need to have installed:

- LLVM, built as a shared lib (`./configure --enable-shared`)
- JRuby 1.6 (easiest to install with rvm, `rvm install jruby`)
- the FFI gem, after switching to jruby with `rvm jruby`, `gem install ffi`
- the [llvm-ruby library](https://github.com/jvoorhis/ruby-llvm)


Organization
------------

- /bm : benchmarks
- /examples : FAB example files
- /ref : the reference implementation
- /sandbox : experiments
- /src : the project


Authors
-------

Matthaus Litteken <matthaus@cs.pdx.edu>
Eric O'Connell <eoc@cs.pdx.edu>

