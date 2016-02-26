#ifndef _Guess_h
#define _Guess_h

#include <string>
#include <map>

class Guess {
  static int MaxDefault;
  static std::string PadMsg;
  static std::map <bool, std::string> high_str;

  int max, target;

  public:
    Guess();
    int getMax();
    void setTarget();
    int getTarget();
    bool isSuccessful(int, int, std::string*);
};

#endif

