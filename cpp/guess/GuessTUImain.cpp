#include <iostream>
#include <cstdlib>
#include <string>
#include <sstream>
#include <regex>
#include <locale>

#include "GuessTUI.h"
#include "Guess.h"

using namespace std;

/****************************************************************************/
int GuessTUI::getGuess(string prompt) {	// static
  string guess_str;
  int guess;

  while(true) {
    cout << prompt;
    cin >> guess_str;
    guess = atoi( guess_str.c_str() );
    if(guess > 0) return guess;
  }
}

/****************************************************************************/
int GuessTUI::main() {		// static
  ostringstream oss;
  string msg = "";
  // Only partial support for regex on g++ 4.8.x as per URL
  // https://gcc.gnu.org/onlinedocs/gcc-4.8.5/libstdc++/manual/manual/status.html
  // regex_constants::icase doesn't appear to work on 4.8.x
  regex re ("(y|yes)");
  Guess game = Guess();

  srand(time(NULL));		// Seed the pseudo-random number generator once
  string playAgain = "n";
  do {
    game.setTarget();
    cout << "\nI've chosen a number between 1 and " << game.getMax() << " inclusive. You guess it...\n";
    int nTurns = 0;
    int guess = -1;
    while(guess != game.getTarget()) {
      nTurns++;
      string padPrompt = string(( std::to_string(999).length() - std::to_string(nTurns).length() ), ' ');
      oss.str("");
      oss << padPrompt << "[" << nTurns << "] Enter your guess (1-" << game.getMax() << " inclusive): ";

      guess = getGuess( oss.str() );
      game.isSuccessful(guess, nTurns, &msg);
      cout << msg << "\n";
    }
    cout << "Do you want to play again? (y/n) ";
    cin >> playAgain;
    for(std::string::size_type i=0; i<playAgain.length(); i++)
      playAgain[i] = tolower(playAgain[i]);	// Convert to lower case
  } while (regex_match(playAgain, re));
  return 0;
}

/****************************************************************************/
int main () {
  GuessTUI::main();
}

