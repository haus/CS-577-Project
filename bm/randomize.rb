# This file produces an arbitrary amount of random ints for a fab array declaration

out = String.new
out << "{"

0.upto(4998) do |x|
  out << "#{rand(50000)}, "
end

out << "#{rand(50000)}}"

puts out