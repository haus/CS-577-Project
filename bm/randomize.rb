# This file produces an arbitrary amount of random ints for a fab array declaration

out = String.new
out << "{"

0.upto(ARGV[0].to_i - 1) do |x|
  out << "#{rand(50000)}, "
end

out << "#{rand(50000)}}"

puts out