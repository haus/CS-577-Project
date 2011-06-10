#! /usr/bin/env ruby

require 'benchmark'

# for each fab in fablist
# if needs array, add gen'd array to fab then proceed
basedir = "bm"
dirs = {"llvm-binary-noOpt", "llvm-binary-halfOpt", "llvm-binary-fullOpt"}

Dir.new(basedir).entries.each do |file|

# compile interp time

# compile execute time

# print results