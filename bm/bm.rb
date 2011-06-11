#! /usr/bin/env ruby

require 'benchmark'

# for each fab in fablist
# if needs array, add gen'd array to fab then proceed
n = ARGV[0].to_i
binDirs = ["llvm-binary-noOpt", "llvm-binary-halfOpt", "llvm-binary-fullOpt"]
irDirs = ["llvm-ir-noOpt", "llvm-ir-halfOpt", "llvm-ir-fullOpt"]
refDir = "ref-binary"


# Time the binary runs...
binDirs.each do |basedir|
  puts "#{basedir} - #{n} times"
  puts "===================="
  Benchmark.bm(20) do |x|
    Dir.new(basedir).entries.each do |file|
      if File.file?("#{basedir}/#{file}") and file != "primes.bin"
        x.report("#{file}") { for i in 1..n; `"#{basedir}/#{file}"`; end}
      end
    end
  end
  puts "\n"
end

# Time the llvm-interpreter...
irDirs.each do |basedir|
  puts "#{basedir} - #{n} times"
  puts "===================="
  Benchmark.bm(20) do |x|
    Dir.new(basedir).entries.each do |file|
      if File.file?("#{basedir}/#{file}") and file != "primes.ll"
        x.report("#{file}") { for i in 1..n; `lli "#{basedir}/#{file}"`; end}
      end
    end
  end
  puts "\n"
end

