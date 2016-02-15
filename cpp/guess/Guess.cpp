#include <iostream>
#include <cstdlib>
#include <string>
#include <sstream>

#include "Guess.h"

using namespace std;

/****************************************************************************/
/*
  HighStr = {true => "HIGH", false => "LOW"}	// FIXME: Add assoc array
 */

int Guess::MaxDefault = 7;
string Guess::PadMsg = string(6, ' ');

/****************************************************************************/
Guess::Guess() {
  max = Guess::MaxDefault;
  target = -1;
}

/****************************************************************************/
int Guess::getMax() {
  return max;
}

/****************************************************************************/
void Guess::setTarget() {
  target = (rand() % max) + 1;		// Random number in 1..max
}

/****************************************************************************/
int Guess::getTarget() {
  return target;
}

/****************************************************************************/
int Guess::getGuess(string prompt) {
  int guess;
  cout << prompt;
  cin >> guess;
  return guess;
}

/****************************************************************************/
bool Guess::isSuccessful(int guess, int nTurns, std::string *msg) {	// FIXME: Use bool in caller? See other progs?
  ostringstream oss;
  bool isEqual = (guess == target);

  if(isEqual)
    oss << Guess::PadMsg << guess << " is correct, congratulations! You took " << nTurns << " turn(s).";
  else
    oss << Guess::PadMsg << guess << " is too " << (guess > target ? "HIGH" : "LOW") << ". Try again.";

  *msg = oss.str();
  return isEqual;
}

