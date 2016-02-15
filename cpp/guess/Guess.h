#ifndef _Guess_h
#define _Guess_h

#include <string>

class Guess {
  static int MaxDefault;
  static std::string PadMsg;
  int max, target;

  public:
    Guess();
    int getMax();
    void setTarget();
    int getTarget();
    int getGuess(std::string);
    bool isSuccessful(int, int, std::string*);
};

#endif

