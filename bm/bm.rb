#! /usr/bin/env ruby

require 'benchmark'

# for each fab in fablist
# if needs array, add gen'd array to fab then proceed
n = 500
binDirs = ["llvm-binary-noOpt", "llvm-binary-fullOpt", "ref-binary"]
irDirs = ["llvm-ir-noOpt", "llvm-ir-fullOpt"]
fabDir = "fab"

=begin
# Time the binary runs...
binDirs.each do |basedir|
  puts "#{basedir} - #{n} times"
  puts "====================="
  Benchmark.bm(20) do |x|
    Dir.new(basedir).entries.each do |file|
      if File.file?("#{basedir}/#{file}") and file != "primes.bin"
        x.report("#{file}") { for i in 1..n; `"#{basedir}/#{file}"`; end}
      end
    end
  end
  puts "\n"
end

n = 1
# Time the llvm-interpreter...
irDirs.each do |basedir|
  puts "#{basedir} - #{n} times"
  puts "====================="
  Benchmark.bm(20) do |x|
    Dir.new(basedir).entries.each do |file|
      if File.file?("#{basedir}/#{file}") and file != "primes.ll"
        x.report("#{file}") { for i in 1..n; `lli "#{basedir}/#{file}"`; end}
      end
    end
  end
  puts "\n"
end
=end
n = 50
# Time the noop on the ref-interpreter...
puts "Reference Interpreter"
puts "====================="
Benchmark.bm(20) do |x|
  Dir.new("fab").entries.each do |file|
    if File.file?("fab/#{file}") and file != "primes.fab"
      x.report("#{file}") { for i in 1..n; `java -classpath ref-interpreter/frontend.jar:ref-interpreter/interp.jar InterpDriver "fab/#{file}"`; end}
    end
  end
end
puts "\n"

# Primes is slower, so do it less...say 5 times total...
# Time the noop on the ref-interpreter...
n = 5
puts "Primes Results - #{n} times"
puts "====================="
Benchmark.bm(20) do |x|
  x.report("binary-noOpt") { for i in 1..n; `llvm-binary-noOpt/primes.bin`; end}
#  x.report("binary-halfOpt") { for i in 1..n; `llvm-binary-halfOpt/primes.bin`; end}
  x.report("binary-fullOpt") { for i in 1..n; `llvm-binary-fullOpt/primes.bin`; end}
  x.report("ir-noOpt") { for i in 1..n; `lli llvm-ir-noOpt/primes.ll`; end}
#  x.report("ir-halfOpt") { for i in 1..n; `lli llvm-ir-halfOpt/primes.ll`; end}
  x.report("ir-fullOpt") { for i in 1..n; `lli llvm-ir-fullOpt/primes.ll`; end}
  x.report("ref-binary") { for i in 1..n; `ref-binary/primes.bin`; end}
  x.report("ref-interpreter") { for i in 1..n; `java -classpath ref-interpreter/frontend.jar:ref-interpreter/interp.jar InterpDriver "fab/primes.fab"`; end}
end
puts "\n"
