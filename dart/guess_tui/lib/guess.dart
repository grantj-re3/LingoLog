import 'dart:math';
import 'package:format/format.dart';

//////////////////////////////////////////////////////////////////////////////
class Guess {
  // Class vars
  static const maxDefault = 100;    // Compile-time const
  static final padMsg = " " * 6;
  static const highStr = {
    true:   "HIGH",
    false:  "LOW",
  };

  // Instance vars
  int max = maxDefault;
  int target = -1;

  ////////////////////////////////////////////////////////////////////////////
  // Contructor
  ////////////////////////////////////////////////////////////////////////////
  Guess() {
  }

  ////////////////////////////////////////////////////////////////////////////
  void setMaxTarget(cmdLineArgs) {
    try {
      max = int.parse(cmdLineArgs[0]);
      } catch (e) {
      max = maxDefault;
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  void setTarget() => target = Random().nextInt(max) + 1;   // target = 1..max

  ////////////////////////////////////////////////////////////////////////////
  Map<bool, String> isSuccessful(guess, nTurns) {
    return {
      if (guess == target)
        true:   "{}{} is correct, congratulations! You took {} turn(s).".format(padMsg, guess, nTurns)
      else
        false:  "{}{} is too {}. Try again.".format(padMsg, guess, highStr[guess > target])
    };
  }

}

