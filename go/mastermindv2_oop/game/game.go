package game

import (
	"example.com/mastermindv2/game/cfg"
	tkn "example.com/mastermindv2/game/token"

	"fmt"
	"os"
	"regexp"
	"strings"
	"time"
)

// ////////////////////////////////////////////////////////////////////////////
var config cfg.Config // Package level var

// ////////////////////////////////////////////////////////////////////////////
func ShowRules() {
	helpText := `
	The rules of MasterMind can be found on the web, for example at:
	- https://www.wikihow.com/Play-Mastermind; or
	- https://www.geekyhobbies.com/mastermind-board-game-rules-and-instructions-for-how-to-play/

	This program is the codemaker and you (the user) are the codebreaker.
	Instead of coloured code pegs, the program will use digits in the
	range 0 to 5 inclusive (or 0 to 'max-digit'). See '-h' option.

	The number of positions (or holes) is given by 'num-pos'. If 'num-pos'
	is 4, then your guesses should be 4 digits, e.g. 3524 or 2201.
	See '-h' option.

	The secret may contain repeated/duplicate digits (e.g. 4222) or not
	(e.g. 0524) as per 'allow-dups'. See '-h' option.

	Hints: "2 Bk" means 2 digits are in the correct position (i.e. Black peg).
	       "1 Wh" means 1 digit is in the wrong position (i.e. White peg).

	Alternatively, 'easy-hints' show exactly which digits are in the correct
	or wrong position. E.g. guess 3052 and easy-hint '.Bw.' means 0 is in
	the correct position and 5 is a correct digit in the wrong position.
	See '-h' option.

	A GameId string is shown at the start of the game. If you wish to play
	the same game later, you can paste the GameId string after the 'gameid'
	option when you invoke the game. See '-h' option.

	GameId, 5 parameter format: 998877:4:5:t:f
	GameId, 4 parameter format: 998877:4:5:t
	  where the parameters are:
	    {id}:{num-pos}:{max-digit}:{allow-dups}:{easy-hints}
	  and the fifth parameter (i.e. easy-hints) is optional

	How does the GameId work?
	To play the same game you need an identifier for the game (id) and
	an identical configuration. The 5 parameter format prepares exactly
	the same game. The 4 parameter format does the same but allows you
	to determine if easy-hints are enabled/disabled.

`
	re, _ := regexp.Compile("(?m)^\t")           // (?m) where m-flag is multi-line mode
	helpText = re.ReplaceAllString(helpText, "") // Change indent
	fmt.Println(helpText)
	os.Exit(0)
}

// ////////////////////////////////////////////////////////////////////////////
func showMoveHistory(tdMap map[string]*tkn.Details) {
	// Lookup token Details by GuessNum (int).
	// This behaves similar to a slice except:
	// - Our indices are 1..len (not 0..len-1) because GuessNum starts at 1
	// - We can populate indices in any order
	tdMapByGuessNum := make(map[int]*tkn.Details, len(tdMap))

	for _, ptd := range tdMap {
		tdMapByGuessNum[ptd.GuessNum] = ptd
	}

	fmt.Println("Showing history:")
	for i := 1; i <= len(tdMapByGuessNum); i++ {
		tdMapByGuessNum[i].ShowFeedback()
		if i < len(tdMapByGuessNum) {
			// Append newline for all but the most recent feedback
			fmt.Println()
		}
	}
}

// ////////////////////////////////////////////////////////////////////////////
func ShowPreamble(secretTokens []string) {
	fmt.Println("M A S T E R   M I N D")
	fmt.Println("=====================\n")

	fmt.Println("Enter 'q' or 'quit' to quit the game.")
	fmt.Println("Enter 'h' or 'history' to show all guesses so far.")
	fmt.Println("\nGameID:", cfg.ConfigToGameId(config))

	if config.IsPermitDups {
		fmt.Println("Duplicate digits ARE permitted in the secret.")
	} else {
		fmt.Println("Duplicate digits are NOT permitted in the secret.")
	}
	if config.IsShowSecret {
		fmt.Printf("SECRET: %s\n", strings.Join(secretTokens, ""))
	}
}

// ////////////////////////////////////////////////////////////////////////////
func GetGameSummary(numGuesses int, start time.Time) string {
	const timeFmt = "2006-01-02 15:04 MST"
	end := time.Now()
	elapsed := end.Sub(start)
	re := regexp.MustCompile(`\.\d+s`) // Replace "57.123s" with "57s"
	approxElapsed := re.ReplaceAllString(fmt.Sprintf("%s", elapsed), "s")

	header := []string{
		fmt.Sprintf("%-28s", "GameId"),
		fmt.Sprintf("%-21s", "EndTime"),
		fmt.Sprintf("%s", "Elapsed"),
		fmt.Sprintf("%s", "NumGuesses"),

		// Config fields
		fmt.Sprintf("%s", "NumPos"),
		fmt.Sprintf("%s", "MaxDigit"),
		fmt.Sprintf("%s", "AllowDups"),
		fmt.Sprintf("%s", "EasyHints"),

		fmt.Sprintf("%s", "Cheat"),
	}
	values := []string{
		fmt.Sprintf("%-28s", cfg.ConfigToGameId(config)),
		fmt.Sprintf("%-21s", end.Format(timeFmt)),
		fmt.Sprintf("%7s", approxElapsed),
		fmt.Sprintf("%10d", numGuesses),

		// Config fields
		fmt.Sprintf("%6d", config.NumTokens),
		fmt.Sprintf("%8d", config.MaxDigit),
		fmt.Sprintf("%9t", config.IsPermitDups),
		fmt.Sprintf("%9t", config.IsEasyHint),

		fmt.Sprintf("%5t", config.IsShowSecret),
	}
	return strings.Join(header, " | ") + "\n" + strings.Join(values, " | ") + "\n"
}

// ////////////////////////////////////////////////////////////////////////////
func GetOutfile() string {
	// Assumes we are running a compiled file. Unexpected/temp path for "go run xxxx.go"
	exePath, err := os.Executable()
	if err != nil {
		fmt.Println("Failed to find path to write file:", err)
		os.Exit(0)
	}
	return exePath + ".txt"
}

// ////////////////////////////////////////////////////////////////////////////
func SaveGameSummary(numGuesses int, start time.Time) {
	outFile := GetOutfile()
	file, err := os.Create(outFile)
	if err != nil {
		fmt.Println("Failed to create file:", err)
		os.Exit(0)
	}
	defer file.Close()

	_, err = file.WriteString(GetGameSummary(numGuesses, start))
	if err != nil {
		fmt.Println("Failed to write to file:", err)
		os.Exit(0)
	}
}

// ////////////////////////////////////////////////////////////////////////////
func Play() {
	config = cfg.ProcessCmdLineOpts()
	if config.IsShowRules {
		ShowRules()
	}
	tkn.InitAndModConfig(&config) // *May* update config.Seed
	secretTokens := tkn.MakeSecret()
	ShowPreamble(secretTokens)

	fmt.Printf("%s", tkn.PromptPrefixPadding())
	tdMap := make(map[string]*tkn.Details, 10) // Lookup token Details by guess-tokens (converted to string)
	start := time.Now()
	for numGuesses := 1; true; numGuesses++ {
		td := tkn.Details{GuessNum: numGuesses, PtrSecret: &secretTokens}
		what := td.GetUserTokens()
		if what == tkn.WIQuit {
			fmt.Printf("Quitting!  The secret was %s\n", strings.Join(secretTokens, ""))
			os.Exit(0)

		} else if what == tkn.WIHistory {
			showMoveHistory(tdMap)
			numGuesses-- // Showing history is not a guess. Undo increment.

		} else if tdMap[td.StrTokens] != nil {
			fmt.Printf("     You've entered this before at guess #%d. Try a new guess.\n%s",
				tdMap[td.StrTokens].GuessNum, tkn.PromptPrefixPadding())
			numGuesses-- // Not a new guess. Undo increment.

		} else {
			td.CalcFeedback()
			td.ShowFeedback()
			tdMap[td.StrTokens] = &td
			if td.GameOver() {
				fmt.Printf("CONGRATULATIONS, you guessed the secret in %d turn(s)!\n", numGuesses)
				SaveGameSummary(numGuesses, start)
				break
			}
		}
	}
}
