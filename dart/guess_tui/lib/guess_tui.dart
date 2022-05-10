import 'dart:io';
import 'package:guess_tui/guess.dart';
import 'package:format/format.dart';

//////////////////////////////////////////////////////////////////////////////
// - An enum is a special kind of class and an extension of the Enum class.
// - Dart does not (yet) support nested classes so enum must be defined outside
//   a class definition.
// - If you have several classes defined in separate files, and you want
//   them to manipulate objects of enum E, then you can put enum E into
//   a separate package file and import the package into each class.
//   Alternatively, if enum E "belongs-to" only class A, put the enum
//   definition within the class A file so it is always available when the
//   class A file is imported.
enum GuessInputType {
  quit, guess
}

//////////////////////////////////////////////////////////////////////////////
class GuessTUI {

  ////////////////////////////////////////////////////////////////////////////
  static Map<GuessInputType, int> getInputAttrs(String prompt) {
    while(true) {              // Get a valid integer
      stdout.write(prompt);
      var s = stdin.readLineSync();
      if (s == null) continue;
      if (s.toLowerCase() == "q") {
        return {GuessInputType.quit: -1};
      }
      try {
        return {GuessInputType.guess: int.parse(s)};
      } catch (e) {
        continue;
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  static void playGame(List<String> args) {
    var game = Guess();
    game.setMaxTarget(args);

    var playAgain;
    final regex_yes = RegExp(r'^\s*(y|yes)\s*$', caseSensitive: false);
    do {
      game.setTarget();
      print("\nI've chosen a number between 1 and ${game.max} inclusive. You guess it...");
      var nTurns = 0;
      var guess = -1;
      while(guess != game.target) {             // Each guess
        var padPrompt = " " * (999.toString().length - (nTurns+1).toString().length);
        var prompt = '{}[{:d}] Enter your guess (1-{:d} inclusive): '.format(padPrompt, nTurns+1, game.max);
        var attr = getInputAttrs(prompt);
        switch(attr.keys.first) {
          case GuessInputType.quit:
            print("Quitting!");
            exit(0);
          case GuessInputType.guess:
            guess = attr.values.first;
        }

        nTurns++;
        var successMsg = game.isSuccessful(guess, nTurns);
        print(successMsg.values.first);
      }

      stdout.write("Do you want to play again? (y/n) ");
      playAgain = stdin.readLineSync();
    } while(regex_yes.hasMatch(playAgain));
  }
}

