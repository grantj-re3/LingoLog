#!/usr/bin/ruby
# Usage:  guesstui.rb  [ MAX_NUM_IN_RANGE ]
##############################################################################
# Add dirs to the library path
$: << File.expand_path(".", File.dirname(__FILE__))
require 'guess'

##############################################################################
# Guess - Text User Interface
##############################################################################
class GuessTUI

  ############################################################################
  # Get integer guess from user
  ############################################################################
  def self.getGuess(prompt)
    while true
      printf prompt
      guess = STDIN.readline.strip.to_i
      return guess if guess > 0
    end
  end

  ############################################################################
  # Game: Guess the integer between 1-max
  ############################################################################
  def self.main
    game = Guess.new
    game.setMaxTarget(ARGV)
    playAgain = "n"

    begin
      game.setTarget
      printf("\nI've chosen a number between 1 and %d inclusive. You guess it...\n", game.max)
      nTurns = 0
      guess = -1  
      while guess != game.target		# Each guess
        nTurns += 1
        padPrompt = " " * (999.to_s.length - nTurns.to_s.length)
        guess = getGuess("#{padPrompt}[#{nTurns}] Enter your guess (1-#{game.max} inclusive): ")
        success, msg = game.isSuccessful(guess, nTurns)
        puts msg
      end

      printf "Do you want to play again? (y/n) "
      playAgain = STDIN.readline.strip.downcase
    end while playAgain =~ /^(y|yes)$/
  end
end

##############################################################################
GuessTUI.main

