#!/usr/bin/ruby
# encoding: utf-8
#
# See:
# - https://en.wikipedia.org/wiki/Box-drawing_character
# - https://en.wikipedia.org/wiki/Playing_cards_in_Unicode
# - https://en.wikipedia.org/wiki/Unicode
# - http://stackoverflow.com/questions/21171782/convert-a-unicode-string-to-characters-in-ruby
#   * http://www.joelonsoftware.com/articles/Unicode.html
#   * http://graysoftinc.com/character-encodings/understanding-m17n-multilingualization
##############################################################################
# VT100 single-line box chars
VBOX = {
  :mode_begin   => "\e(0",
  :mode_end     => "\e(B",

  :horiz        => "\x71",
  :vert         => "\x78",

  :top_left     => "\x6c",
  :top_right    => "\x6b",
  :bottom_left  => "\x6d",
  :bottom_right => "\x6a",
}

# UTF8 single-line box chars
UBOX = {
  :horiz        => "\u2500",
  :vert         => "\u2502",

  :top_left     => "\u250c",
  :top_right    => "\u2510",
  :bottom_left  => "\u2514",
  :bottom_right => "\u2518",
}

# UTF8 double-line box chars
UBOX2 = {
  :horiz        => "\u2550",
  :vert         => "\u2551",

  :top_left     => "\u2554",
  :top_right    => "\u2557",
  :bottom_left  => "\u255a",
  :bottom_right => "\u255d",
}

##############################################################################
TEXT_ATTRIB = {
  :normal    => "\033[0m",		# Reset all attributes below
  :bold      => "\033[1m",
  :underline => "\033[4m",
  :blink     => "\033[5m",		# Does not blink?
  :reverse   => "\033[7m",
}

##############################################################################
# UTF8 black-card suit chars
BSUIT = {
  :spade        => "\u2660",
  :heart        => "\u2665",
  :diamond      => "\u2666",
  :club         => "\u2663",
}

# UTF8 white-card suit chars
# These seem very faint on my xterm
WSUIT = {
  :spade        => "\u2664",
  :heart        => "\u2661",
  :diamond      => "\u2662",
  :club         => "\u2667",
}

# UTF8 white-card suit chars (fudge)
# Try suits with inverse video
BSUIT2 = BSUIT.inject({}){|h,(suit,val)| h[suit] = TEXT_ATTRIB[:reverse] + val + TEXT_ATTRIB[:normal]; h}

# ASCII card suit chars (fudge)
ASUIT = {
  :spade        => "s",
  :heart        => "h",
  :diamond      => "d",
  :club         => "c",
}

# ASCII card suit chars (fudge)
# Try suits with inverse video
ASUIT2 = ASUIT.inject({}){|h,(suit,val)| h[suit] = TEXT_ATTRIB[:reverse] + val + TEXT_ATTRIB[:normal]; h}

##############################################################################
# Custom suit: choose suit-strings from above
SUIT = {
  :spade        => BSUIT[:spade],
  :heart        => BSUIT2[:heart],
  :diamond      => BSUIT2[:diamond],
  :club         => BSUIT[:club],
}

##############################################################################
def show_vbox
  card_value = "J"
  card_suit1 = ASUIT2[:spade]
  card_suit2 = ASUIT2[:club]
  puts
  puts "VT100 single-line box chars"

  printf "%s%s%s%s%s%s\n", VBOX[:mode_begin], VBOX[:top_left], VBOX[:horiz], VBOX[:horiz], VBOX[:top_right], VBOX[:mode_end]
  printf "%s%s%s%s%s%s%s%s\n", VBOX[:mode_begin], VBOX[:vert], VBOX[:mode_end],
    card_value, card_suit1, VBOX[:mode_begin], VBOX[:vert], VBOX[:mode_end]
  printf "%s%s%s%s%s%s%s%s\n", VBOX[:mode_begin], VBOX[:vert], VBOX[:mode_end],
    card_suit2, card_value, VBOX[:mode_begin], VBOX[:vert], VBOX[:mode_end]
  printf "%s%s%s%s%s%s\n", VBOX[:mode_begin], VBOX[:bottom_left], VBOX[:horiz], VBOX[:horiz], VBOX[:bottom_right], VBOX[:mode_end]
end

##############################################################################
def show_ubox
  card_value = "Q"
  card_suit1 = SUIT[:spade]
  card_suit2 = SUIT[:heart]
  puts
  puts "UTF8 single-line box chars"

  printf "%s%s%s%s\n", UBOX[:top_left], UBOX[:horiz], UBOX[:horiz], UBOX[:top_right]
  printf "%s%s%s%s\n", UBOX[:vert], card_value, card_suit1, UBOX[:vert]
  printf "%s%s%s%s\n", UBOX[:vert], card_suit2, card_value, UBOX[:vert]
  printf "%s%s%s%s\n", UBOX[:bottom_left], UBOX[:horiz], UBOX[:horiz], UBOX[:bottom_right]
end

##############################################################################
def show_ubox2
  card_value = "K"
  card_suit1 = SUIT[:diamond]
  card_suit2 = SUIT[:club]
  puts
  puts "UTF8 double-line box chars"

  printf "%s%s%s%s\n", UBOX2[:top_left], UBOX2[:horiz], UBOX2[:horiz], UBOX2[:top_right]
  printf "%s%s%s%s\n", UBOX2[:vert], card_value, card_suit1, UBOX2[:vert]
  printf "%s%s%s%s\n", UBOX2[:vert], card_suit2, card_value, UBOX2[:vert]
  printf "%s%s%s%s\n", UBOX2[:bottom_left], UBOX2[:horiz], UBOX2[:horiz], UBOX2[:bottom_right]
end

##############################################################################
def show_card_deck_chars
  puts
  puts "UTF8 Unicode 6.0 or newer (Works ok for me)"
  ch = "\u2660"
  8.times{printf("[%s] ", ch); ch.next!}
  puts
  
  puts
  puts "UTF8 Unicode 7.0 or newer (Does NOT work for me)"
  ch = "\u1f0a1"
  13.times{printf("[%s] ", ch); ch.next!}
  puts
end

##############################################################################
# Main()
##############################################################################
show_card_deck_chars
show_vbox
show_ubox
show_ubox2

