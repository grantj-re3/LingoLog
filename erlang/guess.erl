#!/usr/bin/env escript
% guess.erl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-module(guess).
-export([main/1, main/0]).

maxTargetDefault() -> 100.

padMsg() ->    lists:duplicate(6, " ").
regexYes() -> "^ *(y|yes) *$".
highStr(IsHigh) ->
  if
    IsHigh -> "HIGH";		% IsHigh =:= true
    true -> "LOW"		% IsHigh =:= false
  end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main/1: 1 command line arg
main([Arg1Str]) ->
  try
    guessIntInit( list_to_integer(Arg1Str) )
  catch _:_ ->
    guessIntInit( maxTargetDefault() )
  end;

% main/1: 0,2,3,... command line args
main(_) -> guessIntInit( maxTargetDefault() ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main() -> guessIntInit( maxTargetDefault() ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
guessIntInit(MaxTarget) ->
  % Initialise seed for random number generator
  {R1,R2,R3} = now(),
  random:seed(R1, R2, R3),
  guessInt(MaxTarget).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
guessInt(MaxTarget) ->
  % Generate a random integer
  Target = 1 + trunc( random:uniform() * float(MaxTarget) ),
  io:format("\nI've chosen a number between 1 and ~w inclusive. You guess it...\n", [MaxTarget]),
  NTurns = 0,
  nextGuess(Target, MaxTarget, NTurns + 1),

  Line = io:get_line("Do you want to play again? (y/n) ") -- "\n",	% Read stdin; strip newline
  case re:run(string:to_lower(Line), regexYes()) of
    {match, _} -> guessInt(MaxTarget);
    nomatch -> init:stop()
  end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nextGuess(Target, MaxTarget, NTurns) ->
  PadPrompt = lists:duplicate(string:len(integer_to_list(999)) - string:len(integer_to_list(NTurns)), " "),
  io:format("~s[~w] Enter your guess (1-~w inclusive): ", [PadPrompt, NTurns, MaxTarget]),
  % Obtain guess from user
  Line = io:get_line("") -- "\n",	% Read stdin; strip newline
  {Guess, _} = string:to_integer(Line),

  if
    Guess =:= error ->
      nextGuess(Target, MaxTarget, NTurns);		% Do not increment count for invalid guess

    Guess =:= Target ->
      io:format("~s~w is correct, congratulations! You took ~w turn(s).\n", [padMsg(), Guess, NTurns]);

    true ->
      io:format("~s~w is too ~s. Try again.\n", [padMsg(), Guess, highStr(Guess > Target)]),
      nextGuess(Target, MaxTarget, NTurns + 1)
  end.

