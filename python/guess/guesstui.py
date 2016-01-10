#!/usr/bin/env python3
# Usage:  guesstui.py  [ MAX_NUM_IN_RANGE ]
##############################################################################
import sys
import re

from guess import Guess

##############################################################################
class GuessTUI:

  ############################################################################
  def __init__(self):
    self.main()

  ############################################################################
  def main(self):
    game = Guess()
    game.setMaxTarget(sys.argv)
    playAgain = "y"
    regexYes = re.compile(r"^(y|yes)$")

    while regexYes.search(playAgain) != None:
      game.setTarget()
      print("\nI've chosen a number between 1 and %d inclusive. You guess it..." % (game.max()))
      nTurns = 0
      guess = -1
      while guess != game.target():
        nTurns += 1
        padPrompt = " " * ( len(str(999)) - len(str(nTurns)) )
        s = "%s[%d] Enter your guess (1-%d inclusive): " % (padPrompt, nTurns, game.max())
        guess = self.getGuess(s)
        #print("target: %d;  guess: %d" % (game.target(), guess))

        (success, msg) = game.isSuccessful(guess, nTurns)
        print(msg)
      playAgain = input("Do you want to play again? (y/n) ").strip().lower()

  ############################################################################
  def getGuess(self, prompt):
    #sys.stdout.write(prompt)
    #s = sys.stdin.readline()

    while True:
      s = input(prompt)
      if s.isdigit():
        return int(s)

##############################################################################
if __name__ == "__main__":
  GuessTUI()

