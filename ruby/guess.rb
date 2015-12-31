#!/usr/bin/ruby
# guess.rb
##############################################################################
class Guess
  HighStr = {true => "HIGH", false => "LOW"}		# FIXME: "HIGH","LOW"
  MaxDefault = 100
  PadMsg = " " * 6

  attr_reader :max, :target

  ############################################################################
  def initialize
    @max = MaxDefault
    @target = -1
  end

  ############################################################################
  def setMaxTarget(cmdLineArgs)
    @max = MaxDefault
    if cmdLineArgs.length > 0
      m = cmdLineArgs[0].to_i
      @max = m if m > 1
    end
  end

  ############################################################################
  def setTarget
    @target = rand(1 .. @max)
  end

  ############################################################################
  def isSuccessful(guess, nTurns)
    if(guess == @target)
      [true,  sprintf("%s%d is correct, congratulations! You took %d turn(s).", PadMsg, guess, nTurns)]
    else
      [false, sprintf("%s%d is too %s. Try again.", PadMsg, guess, HighStr[guess > @target])]
    end
  end

  ############################################################################
  def to_s
    sprintf "MaxDefault=%d; PadMsg='%s'; HighStr=%s; @max=%d; @target=%d", MaxDefault, PadMsg, HighStr.inspect, @max, @target
  end
end

