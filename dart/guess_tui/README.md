
# Dart - guess_tui (guess-the-number game with text user-interface)

## References

- https://dart.dev/samples
- https://dart.dev/guides/language/language-tour
- https://dart.dev/guides/libraries/library-tour
- https://dart.dev/guides/language/effective-dart/style
- https://github.com/smartherd/DartTutorial

- https://dart.dev/tools/pub/package-layout
- https://dart.dev/tools/pub/cmd
- https://dart.dev/tools/pub/cmd/pub-add
- https://dart.dev/tools/pub/cmd/pub-remove
- https://dart.dev/tools/pub/pubspec
- https://semver.org/spec/v2.0.0-rc.1.html

- https://dart.dev/tools/dart-create
- https://dart.dev/tools/dart-run
- https://pub.dev/packages/format
- https://pub.dev/packages/sprintf

- https://api.dart.dev/be/136593/dart-io/dart-io-library.html
- https://api.dart.dev/stable/2.16.1/dart-math/Random-class.html
- https://api.dart.dev/stable/2.15.1/dart-core/Map-class.html
- https://api.dart.dev/stable/2.17.0/dart-core/RegExp-class.html
- https://www.w3schools.com/jsref/jsref_obj_regexp.asp

## Commands

Creates the "lib" directory. Use this template

```
$ dart create -t console-full guess_tui
```

Which version of dart am I using?  2.18.0-x

```
$ egrep -A1 ^environment pubspec.yaml
environment:
  sdk: '>=2.18.0-edge.a5a7b4c801b7d8ecf44bdc25cd0b1e7c6e48b7f9 <3.0.0'
```

Add the format package so I can invoke the statement:
> import 'package:format/format.dart';
See "Installing" tab at https://pub.dev/packages/format.
This command updates pubspec.yaml (and hence pubspec.lock)

```
$ dart pub add format
```

## To run the code (under Linux)

Get any required packages, compile and run with *dart run*

```
$ cd LingoLog/dart/guess_tui
$ dart run

# ...or to change the maximum value of the secret number to, say 1,000
$ dart run guess_tui 1000
```

