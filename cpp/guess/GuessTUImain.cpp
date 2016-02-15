#include <iostream>
#include <cstdlib>
//#include <stdio.h>
#include <string>
#include <sstream>


#include "GuessTUI.h"
#include "Guess.h"

using namespace std;

/****************************************************************************/
int GuessTUI::main() {		// static
  ostringstream oss;
  string msg = "";
  Guess game = Guess();

  srand(time(NULL));		// Seed the pseudo-random number generator once
  game.setTarget();

  cout << "\nI've chosen a number between 1 and " << game.getMax() << " inclusive. You guess it...\n";
  int nTurns = 0;
  int guess = -1;
  while(guess != game.getTarget()) {
    nTurns++;
    string padPrompt = string(( std::to_string(999).length() - std::to_string(nTurns).length() ), ' ');
    oss.str("");
    oss << padPrompt << "[" << nTurns << "] Enter your guess (1-" << game.getMax() << " inclusive): ";

    guess = game.getGuess( oss.str() );
    game.isSuccessful(guess, nTurns, &msg);
    cout << msg << "\n";
  }
  return 0;
}

/****************************************************************************/
int main () {
  GuessTUI::main();
}

