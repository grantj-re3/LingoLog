# guess.py
##############################################################################
import random

##############################################################################
class Guess:

  highStr = {True: "HIGH", False: "LOW"}
  maxDefault = 100
  padMsg = " " * 6

  ############################################################################
  def __init__(self):
    self._max = -1
    self._target = -1

  ############################################################################
  def setMaxTarget(self, cmdLineArgs):
    self._max = Guess.maxDefault
    if len(cmdLineArgs) > 1:
      if cmdLineArgs[1].isdigit():
        m = int(cmdLineArgs[1])
        if m > 1:
          self._max = m

  ############################################################################
  def max(self):
    return self._max

  ############################################################################
  def target(self):
    return self._target

  ############################################################################
  def setTarget(self):
    self._target = 1 + int(random.random() * self._max)	# 1 to _max inclusive

  ############################################################################
  def isSuccessful(self, guess, nTurns):
    if(guess == self._target):
      return (True,  "%s%d is correct, congratulations! You took %d turn(s)." % (Guess.padMsg, guess, nTurns))
    else:
      return (False, "%s%d is too %s. Try again." % (Guess.padMsg, guess, Guess.highStr[guess > self._target]))

  ############################################################################
  def to_s(self):
    s = "maxDefault=%d; padMsg='%s'; highStr='%s'; _max=%d; _target=%d" % (Guess.maxDefault, Guess.padMsg, str(Guess.highStr), self._max, self._target)
    return s

