import scala.util.Random

class Guess {
  private val highStr = Map(true  -> "HIGH", false -> "LOW")
  private val maxDefault = 100
  private val rand = new Random()
  private val padMsg = " " * 6

  private var _max = -1
  private var _target = -1

  ////////////////////////////////////////////////////////////////////////////
  // Set the upper limit of the range: 1..max inclusive.
  // Optionally allow user to set max via command line
  ////////////////////////////////////////////////////////////////////////////
  def setMaxTarget(cmdLineArgs: Array[String]) {
    _max = if(cmdLineArgs.length > 0) {		// Try to use first command line arg to set max
      try {
        val m = cmdLineArgs(0).toInt 
        if(m > 1) m else maxDefault
      } catch { case e : Throwable => maxDefault }
    } else maxDefault
  }

  ////////////////////////////////////////////////////////////////////////////
  def max = _max

  ////////////////////////////////////////////////////////////////////////////
  def target = _target

  ////////////////////////////////////////////////////////////////////////////
  def setTarget { _target = rand.nextInt(_max) + 1 }      // 1..game.max inclusive

  ////////////////////////////////////////////////////////////////////////////
  // Return 2-tuple based on guess.
  // - success (true/false)
  // - text message
  ////////////////////////////////////////////////////////////////////////////
  def isSuccessful(guess: Int, nTurns: Int): (Boolean, String) = {
    if(guess == _target)
      (true,  padMsg + guess + " is correct, congratulations! You took " + nTurns + " turn(s).")
    else
      (false, padMsg + guess + " is too " + highStr(guess > _target) + ". Try again.")
  }

}

