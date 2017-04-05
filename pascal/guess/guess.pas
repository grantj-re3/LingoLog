program GuessHighLow;

//////////////////////////////////////////////////////////////////////////////
// http://www.freepascal.org/docs-html/rtl/index.html
// http://www.freepascal.org/docs-html/rtl/sysutils/index.html
uses sysutils;		// For Format(), Trim(), LowerCase()

const
  MaxDefault = 4;

type
  GuessStatusType = record
    isSuccess: boolean;
    msg: string  
  end;

//////////////////////////////////////////////////////////////////////////////
function GuessStatus(guess, target, nTurns: integer): GuessStatusType;

const
  HighStr: array[false..true] of string = ('LOW', 'HIGH');
  PadMsg = '      ';

begin
  GuessStatus.isSuccess := guess = target;
  if GuessStatus.isSuccess then
    GuessStatus.msg := Format('%d is correct, congratulations! You took %d turn(s).', [target, nTurns])
  else
    GuessStatus.msg := Format('%s%d is too %s. Try again.', [PadMsg, guess, HighStr[guess > target]]);
end;

//////////////////////////////////////////////////////////////////////////////
function GetGuess(prompt: string): integer;

var
  guess_str: string;

begin
  GetGuess := -1;
  while GetGuess < 0 do
  begin
    Write(prompt);
    Readln(guess_str);
    GetGuess := StrToIntDef(guess_str, -1);
  end;
end;

//////////////////////////////////////////////////////////////////////////////
function SetMaxTarget: integer;

begin
  SetMaxTarget := -1;			// Assume max not given as command line arg.
  if ParamCount > 0 then		// Attempt to extract from command line arg.
    SetMaxTarget := StrToIntDef(ParamStr(1), -1);

  if SetMaxTarget < 0 then		// Else, use default value.
    SetMaxTarget := MaxDefault;
end;

//////////////////////////////////////////////////////////////////////////////
procedure PlayGame(max: integer);

var
  guess, target, nTurns: integer;
  prompt: string;
  status: GuessStatusType;

begin
  target := 1 + Random(max);
  nTurns := 0;
  Writeln;
  Writeln('I''ve chosen a number between 1 and ', max, ' inclusive. You guess it...');

  repeat
    nTurns := nTurns + 1;
    prompt := Format(
      '%5s Enter your guess (1-%d inclusive): ',
      [Format('[%d]', [nTurns]), max]
    );
    guess := GetGuess(prompt);

    status := GuessStatus(guess, target, nTurns);
    Writeln(status.msg);
  until status.isSuccess;
end;

//////////////////////////////////////////////////////////////////////////////
procedure GameWrapper;

var
  max: integer;
  answer: string;

begin
  Randomize();
  max := SetMaxTarget;
  repeat
    PlayGame(max);

    Write('Do you want to play again? (y/n) ');
    Readln(answer);
    answer := LowerCase(Trim(answer));
  until (answer <> 'y') and (answer <> 'yes');
end;

//////////////////////////////////////////////////////////////////////////////
begin
  GameWrapper;
end.

