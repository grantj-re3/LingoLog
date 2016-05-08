#!/usr/bin/ruby
require 'io/console'

puts "Get and show each character as it is typed"
puts "------------------------------------------"
msg = "[Press 'x' to exit]"
puts msg
puts
puts "Dec  Octal Hex   Character"

while true
  s = STDIN.getch
  break if ["x"].include?(s.downcase)
  n = s.ord			# Integer equiv
  str = n < 0x20 ? "" : s	# Do not display control chars
  printf "%3d  \\%03o  0x%02x  '%s'      %s\n", n, n, n, str, msg
end

