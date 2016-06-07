#!/usr/bin/ruby
#
# References re non-blocking read:
#   http://stackoverflow.com/questions/946738/detect-key-press-non-blocking-w-o-getc-gets-in-ruby
#   http://blog.x-aeon.com/2014/03/26/how-to-read-one-non-blocking-key-press-in-ruby/
##############################################################################
WRAP_EACH_CHAR = false
WRAP_MODE = WRAP_EACH_CHAR ? :wrap_each_char : nil

##############################################################################
# Unix non-blocking read
def getkey_nonblock(mode=nil)
  case mode

  when :wrap_each_char
    # This is the documented solution, but in my scenario:
    # - chars are echoed to the screen (because most of the time
    #   the program is in normal terminal mode)
    # - I do not want chars echoed to the screen
    system('stty raw -echo')		# => Raw mode, no echo
    int_char = (STDIN.read_nonblock(1).ord rescue nil)
    system('stty -raw echo')		# => Reset terminal mode
    return int_char

  when :begin
    # In this mode, you will need to terminate output with "\r\n"
    # to achieve normal terminal behaviour. Eg.
    #   printf "My output\r\n"
    system('stty raw -echo')		# => Raw mode, no echo

  when :end
    system('stty -raw echo')		# => Reset terminal mode

  else
    int_char = (STDIN.read_nonblock(1).ord rescue nil)
    return int_char

  end
end

##############################################################################
# Main()
##############################################################################
puts "Get and show each character as it is typed"
puts "------------------------------------------"
msg = "[Press 'x' to exit]"
puts msg
puts
puts "Dec  Octal Hex   Character"

getkey_nonblock(:begin) unless WRAP_EACH_CHAR
while true
  n = getkey_nonblock(WRAP_MODE)	# nil if no key press
  while n
    s = n.chr
    if ["x"].include?(s.downcase)
      getkey_nonblock(:end) unless WRAP_EACH_CHAR
      exit
    end
    str = n < 0x20 ? "" : s		# Do not display control chars
    printf "%3d  \\%03o  0x%02x  '%s'      %s\r\n", n, n, n, str, msg
    n = getkey_nonblock(WRAP_MODE)	# nil if no key press
  end
  printf "Sleeping...\r\n"
  sleep 1
end

