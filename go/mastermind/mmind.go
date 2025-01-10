package main

import (
	"bufio"
	"fmt"
	"strconv"
	"strings"

	"math/rand/v2" // v2 pkg available since Go 1.22
	"os"

	"errors"
	flag "github.com/spf13/pflag" // pflag allows both --flag & -f
	"path/filepath"
	"regexp"
)

// ////////////////////////////////////////////////////////////////////////////
const strOrderedDigits = "0123456789"

type IsDoneKey int

const (
	IDKTokens IsDoneKey = iota
	IDKSecrets
)

type WhatInput int

const (
	WITokens WhatInput = iota
	WIQuit
	WINone
)

// ////////////////////////////////////////////////////////////////////////////
type Config struct {
	numTokens    int
	maxDigit     int
	isPermitDups bool
	isShowSecret bool
}

var config Config // Global configuration

// ////////////////////////////////////////////////////////////////////////////
func MakeSecretTokens() (tokens []string) {
	// Tokens are a slice of single-char strings: '0'..'9'
	numUniqDigits := config.maxDigit + 1
	if config.isPermitDups {
		for i := 0; i < config.numTokens; i++ {
			sToken := strconv.Itoa(rand.IntN(numUniqDigits))
			tokens = append(tokens, sToken)
		}

	} else { // no-dups-permitted
		if numUniqDigits >= config.numTokens {
			// E.g. config.maxDigit = 5; config.numTokens = 4
			//   Start:    tokens = [](0 1 2 3 4 5)  // Length: numUniqDigits (5+1=6)
			//   Shuffled: tokens = [](5 2 3 0 1 4)
			//   Subset:   tokens = [](5 2 3 0)      // Length: config.numTokens (4)
			tokens = strings.Split(strOrderedDigits[:numUniqDigits], "")
			rand.Shuffle(numUniqDigits, func(i, j int) { // Shuffle slice using swap func
				tokens[i], tokens[j] = tokens[j], tokens[i]
			})
			tokens = tokens[:config.numTokens]

		} else { // no-dups-permitted && numUniqDigits < config.numTokens
			fmt.Printf("There are %d positions. Digit values are 0-%d (i.e. %d unique values).\n",
				config.numTokens, config.maxDigit, numUniqDigits)
			fmt.Println("Hence it is impossible to setup the game unless duplicates are permitted.\nQuitting!")
			os.Exit(0)
		}
	}
	return
}

// ////////////////////////////////////////////////////////////////////////////
func AreTokensOk(tokens []string) bool {
	for _, token := range tokens {
		digit, err := strconv.Atoi(token)
		if err != nil {
			fmt.Printf("     Expected range is 0-%d, but got non-numeric character '%s'. Try again.\n", config.maxDigit, token)
			fmt.Printf("%s", PromptPrefixPadding())
			return false
		}
		if digit > config.maxDigit {
			fmt.Printf("     Expected range is 0-%d, but got digit %d. Try again.\n", config.maxDigit, digit)
			fmt.Printf("%s", PromptPrefixPadding())
			return false
		}
	}
	if len(tokens) != config.numTokens {
		fmt.Printf("     Expected %d digits, but got %d. Try again.\n", config.numTokens, len(tokens))
		fmt.Printf("%s", PromptPrefixPadding())
		return false
	}
	return true
}

// ////////////////////////////////////////////////////////////////////////////
func GetUserTokens() (what WhatInput, tokens []string) {
	what = WITokens
	// Tokens are a slice of single-char strings: '0'..'9'
	for {
		fmt.Printf("Enter %d digits in range 0-%d (or 'quit'|'q'): ", config.numTokens, config.maxDigit)
		scanner := bufio.NewScanner(os.Stdin)
		if scanner.Scan(); scanner.Err() != nil {
			continue
		}
		line := strings.TrimSpace(scanner.Text())
		if lc := strings.ToLower(line); lc == "q" || lc == "quit" {
			return WIQuit, nil
		}
		tokens = strings.Split(line, "")
		if !AreTokensOk(tokens) {
			continue
		}
		return
	}
	return WINone, nil // Never gets here!
}

// ////////////////////////////////////////////////////////////////////////////
func getMatchPosCount(tokens, secretTokens []string, isDone map[IsDoneKey][]bool) (matchPosCount int) {
	// IF same token in same position THEN matchPosCount++
	matchPosCount = 0
	for i, token := range tokens {
		secret := secretTokens[i]
		if token == secret { // We have a match
			isDone[IDKTokens][i] = true
			isDone[IDKSecrets][i] = true
			matchPosCount++
		}
	}
	return
}

// ////////////////////////////////////////////////////////////////////////////
func getMatchCount(tokens, secretTokens []string, isDone map[IsDoneKey][]bool) (matchCount int) {
	// IF same token in different position THEN matchCount++
	matchCount = 0
	for i, token := range tokens {
		isSkipProcessingToken := false
		if !isDone[IDKTokens][i] {

			for j, secret := range secretTokens {
				if isSkipProcessingToken {
					break
				}
				if !isDone[IDKSecrets][j] && i != j {
					if token == secret { // We have a match
						isDone[IDKTokens][i] = true
						isDone[IDKSecrets][j] = true
						matchCount++

						isSkipProcessingToken = true
					}
				}
			} // for secret
		}
	} // for token
	return
}

// ////////////////////////////////////////////////////////////////////////////
func GetFeedback(tokens, secretTokens []string) (matchPosCount int, matchCount int) {
	// Create map of bool slices; initially all elements are false.
	// If we find tokens[i] == secretTokens[j] then we set isDone[IDKTokens][i] and
	// isDone[IDKSecrets][j] true so we don't examine them anymore.
	isDone := map[IsDoneKey][]bool{
		IDKTokens:  make([]bool, config.numTokens),
		IDKSecrets: make([]bool, config.numTokens),
	}
	// matchPosCount (matchCount) = number of matches in the correct (wrong) position
	matchPosCount = getMatchPosCount(tokens, secretTokens, isDone)
	matchCount = getMatchCount(tokens, secretTokens, isDone)
	return
}

// ////////////////////////////////////////////////////////////////////////////
func PromptPrefixPadding() string {
	return strings.Repeat(" ", config.numTokens+22)
}

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

`
	re, _ := regexp.Compile("(?m)^\t")           // (?m) where m-flag is multi-line mode
	helpText = re.ReplaceAllString(helpText, "") // Change indent
	fmt.Println(helpText)
	os.Exit(0)
}

// ////////////////////////////////////////////////////////////////////////////
func SetupCmdLineFlags() {
	// Improve the look of the text auto-generated by the pflag module
	flag.Usage = func() { // Re-define the Usage var
		fmt.Fprintf(os.Stderr, "Usage of %s:\n", filepath.Base(os.Args[0]))
		flag.PrintDefaults()
	}
	flag.ErrHelp = errors.New("") // Redefine ErrHelp
}

// ////////////////////////////////////////////////////////////////////////////
func VerifyCmdLineOpts() {
	if config.numTokens < 1 {
		fmt.Printf("Error: num-pos is %d, but must be at least 1\n", config.numTokens)
		os.Exit(1)
	}
	if config.maxDigit < 1 || config.maxDigit > 9 {
		fmt.Printf("Error: max-digit is %d, but must be between 1 and 9 inclusive\n", config.maxDigit)
		os.Exit(1)
	}
}

// ////////////////////////////////////////////////////////////////////////////
func ProcessCmdLineOpts() {
	SetupCmdLineFlags()

	var numTokens, maxDigit int
	var isPermitDups, isShowSecret bool
	var isGame0, isGame1, isGame2, isGame3, isGame4, isGame5, isShowRules bool

	flag.IntVarP(&numTokens, "num-pos", "n", 4, "Number of digit positions (e.g. 4 positions would be 3524 or 2201")
	flag.IntVarP(&maxDigit, "max-digit", "m", 5, "Maximum digit (i.e. each digit can range from 0 to 'max-digit')")
	flag.BoolVarP(&isPermitDups, "allow-dups", "d", false, "Allow the secret to contain duplicate digits (e.g. 4212)")
	flag.BoolVarP(&isShowSecret, "cheat", "c", false, "Cheat by showing the secret set of digits")
	flag.BoolVarP(&isShowRules, "rules", "r", false, "Show the rules of the game")

	flag.BoolVarP(&isGame0, "game-adv-dups", "0", false, "Advanced game: 5 positions; max digit 7; with duplicate digits")
	flag.BoolVarP(&isGame1, "game-adv-nodups", "1", false, "Advanced game: 5 positions; max digit 7; no duplicate digits")
	flag.BoolVarP(&isGame2, "game-classic-dups", "2", false, "Classic game:  4 positions; max digit 5; with duplicate digits")
	flag.BoolVarP(&isGame3, "game-classic-nodups", "3", false, "Classic game:  4 positions; max digit 5; no duplicate digits")
	flag.BoolVarP(&isGame4, "game-kids-dups", "4", false, "Kids game:     3 positions; max digit 5; with duplicate digits")
	flag.BoolVarP(&isGame5, "game-kids-nodups", "5", false, "Kids game:     3 positions; max digit 5; no duplicate digits")
	flag.Parse()

	switch {
	case isShowRules:
		ShowRules()
	case isGame0:
		config = Config{numTokens: 5, maxDigit: 7, isPermitDups: true, isShowSecret: isShowSecret}
	case isGame1:
		config = Config{numTokens: 5, maxDigit: 7, isPermitDups: false, isShowSecret: isShowSecret}
	case isGame2:
		config = Config{numTokens: 4, maxDigit: 5, isPermitDups: true, isShowSecret: isShowSecret}
	case isGame3:
		config = Config{numTokens: 4, maxDigit: 5, isPermitDups: false, isShowSecret: isShowSecret}
	case isGame4:
		config = Config{numTokens: 3, maxDigit: 5, isPermitDups: true, isShowSecret: isShowSecret}
	case isGame5:
		config = Config{numTokens: 3, maxDigit: 5, isPermitDups: false, isShowSecret: isShowSecret}
	default:
		config = Config{numTokens: numTokens, maxDigit: maxDigit, isPermitDups: isPermitDups, isShowSecret: isShowSecret}
	}
	VerifyCmdLineOpts()
}

// ////////////////////////////////////////////////////////////////////////////
func PlayGame() {
	fmt.Println("M A S T E R   M I N D")
	fmt.Println("=====================\n")

	ProcessCmdLineOpts()
	if config.isPermitDups {
		fmt.Println("Duplicate digits ARE permitted in the secret.")
	} else {
		fmt.Println("Duplicate digits are NOT permitted in the secret.")
	}

	secretTokens := MakeSecretTokens()
	if config.isShowSecret {
		fmt.Printf("SECRET: %s\n", strings.Join(secretTokens, ""))
	}

	fmt.Printf("%s", PromptPrefixPadding())
	for numGuesses := 1; true; numGuesses++ {
		what, tokens := GetUserTokens()
		if what == WIQuit {
			fmt.Printf("Quitting!  The secret was %s\n", strings.Join(secretTokens, ""))
			os.Exit(0)
		}
		matchPosCount, matchCount := GetFeedback(tokens, secretTokens)
		fmt.Printf("%2d | %s | %2d Bk,%2d Wh | ", numGuesses, strings.Join(tokens, ""), matchPosCount, matchCount)
		if matchPosCount == config.numTokens {
			fmt.Printf("CONGRATULATIONS, you cracked the secret in %d turns!\n", numGuesses)
			break
		}
	}
}

// ////////////////////////////////////////////////////////////////////////////
func main() {
	PlayGame()
}
