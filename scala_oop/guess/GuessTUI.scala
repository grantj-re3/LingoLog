// Guess - Text User Interface
object GuessTUI {

  ////////////////////////////////////////////////////////////////////////////
  // Get integer guess from user
  ////////////////////////////////////////////////////////////////////////////
  def getGuess(prompt: String): Int = {
    var readOk = true			// FIXME
    var guess = -1
    do {
      print(prompt)
      readOk = true
      try { guess = Console.readInt } catch { 
        case e : Throwable => readOk = false 
      }
    } while(!readOk)
    guess
  }

  ////////////////////////////////////////////////////////////////////////////
  // Game: Guess the integer between 1-max
  ////////////////////////////////////////////////////////////////////////////
  def main(args: Array[String]) {
    val game = new Guess
    game.setMaxTarget(args)
    var playAgain = "n"
    val regexYes = """^ *(y|yes) *$""".r

    do {					// Each game
      game.setTarget
      println("\nI've chosen a number between 1 and " + game.max + " inclusive. You guess it...")
      var nTurns = 0
      var guess = -1				// Initialise to an invalid guess
      while(guess != game.target) {		// Each guess
        nTurns += 1
        val padPrompt = " " * (999.toString.length - nTurns.toString.length)
        guess = getGuess(padPrompt + "[" + nTurns + "] Enter your guess (1-" + game.max + " inclusive): ")
        //print("      Guess " + guess)

        val (success, msg) = game.isSuccessful(guess, nTurns)
        println(msg)
      }

      playAgain = Console.readLine("Do you want to play again? (y/n) ").toLowerCase
    } while(regexYes.findFirstIn(playAgain) != None)
  }
}

