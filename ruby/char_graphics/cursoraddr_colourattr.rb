#!/usr/bin/ruby
#
# Shell Colors: colorizing shell scripts
# http://www.bashguru.com/2010/01/shell-colors-colorizing-shell-scripts.html
#
# ANSI escape code
# https://en.wikipedia.org/wiki/ANSI_escape_code
#
# Chapter 6. ANSI Escape Sequences: Colours and Cursor Movement
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/c327.html
#
# 6.1. Colours
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
#
# 6.2. Cursor Movement
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html
##############################################################################
# Colours
TEXT_COLOUR = {
  :black   => "\033[30m",
  :red     => "\033[31m",
  :green   => "\033[32m",
  :yellow  => "\033[33m",
  :blue    => "\033[34m",
  :magenta => "\033[35m",
  :cyan    => "\033[36m",
  :white   => "\033[37m",
}

##############################################################################
# Text attributes: Except for NORMAL, the attributes below are additive
# (ie. can have bold, underline and reverse video simultaneously). The
# NORMAL attribute resets/disables all currently applicable attributes.
TEXT_ATTRIB = {
  #:clear_screen => "\033[2J",

  :normal    => "\033[0m",		# Reset all attributes below
  :bold      => "\033[1m",
  :underline => "\033[4m",
  :blink     => "\033[5m",		# Does not blink?
  :reverse   => "\033[7m",
}

##############################################################################
def cursor_row_col(row, col)
  printf "\033[%s;%sH", row, col
end

##############################################################################
def set_colour_attr(colour, attrs=[])
  printf TEXT_ATTRIB[:normal]
  attrs.each{|attr| printf TEXT_ATTRIB[attr]}
  printf TEXT_COLOUR[colour]
end

##############################################################################
# Write char-pattern to screen which helps us count to cursor/char position
def init_screen
  #   "    5    10"
  s = "    f    T"
  line1 = s * 6
  100.times{puts line1}
end

##############################################################################
# Main()
##############################################################################
init_screen

config = [
  [  3,  3, :blue,  [:bold, :underline, :reverse] ],
  [  5, 10, :blue,  [:underline] ],
  [  1,  1, :red,   [:reverse]],
  [  2,  2, :green, [:blink] ],
  [ 20,  4, :black, [] ],
]

config.each{|row, col, colour, attrs|
  set_colour_attr(colour, attrs)
  cursor_row_col(row, col)
  printf "##### (%d,%d) %s -- %s #####\n", row, col, colour, attrs.inspect
}

