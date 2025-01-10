package token

// This file contains package-level variables, functions, etc.
// From an OOP perspective, the content looks like class-level
// variables, functions, etc.

import (
	"example.com/mastermindv2/game/cfg"
	"fmt"

	"math/rand/v2" // v2 pkg available since Go 1.22
	"os"
	"strconv"
	"strings"
	"time"
)

// ////////////////////////////////////////////////////////////////////////////
// Package-level var
// Must initialise with InitAndModConfig() before invoking other functions/methods
var config cfg.Config

// ////////////////////////////////////////////////////////////////////////////
func InitAndModConfig(c *cfg.Config) {
	if c.Seed == cfg.SeedUndefined {
		c.Seed = GetRandomSeed() // Modify the caller's copy of c.Seed
	}
	config = *c // Init our package-level var, config
}

// ////////////////////////////////////////////////////////////////////////////
func GetRandomSeed() int64 {
	return time.Now().UnixNano() // Sort of random (if you don't look too closely)
}

// ////////////////////////////////////////////////////////////////////////////
func NewGamePRNG(seed int64) *rand.Rand {
	src := rand.NewPCG(uint64(seed), 0)
	return rand.New(src)
}

// ////////////////////////////////////////////////////////////////////////////
func MakeSecret() (tokens []string) {
	const strOrderedDigits = "0123456789"
	prng := NewGamePRNG(config.Seed)

	// Tokens are a slice of single-char strings: '0'..'9'
	numUniqDigits := config.MaxDigit + 1
	if config.IsPermitDups {
		for i := 0; i < config.NumTokens; i++ {
			sToken := strconv.Itoa(prng.IntN(numUniqDigits))
			tokens = append(tokens, sToken)
		}

	} else { // no-dups-permitted
		if numUniqDigits >= config.NumTokens {
			// E.g. config.MaxDigit = 5; config.NumTokens = 4
			//   Start:    tokens = [](0 1 2 3 4 5)  // Length: numUniqDigits (5+1=6)
			//   Shuffled: tokens = [](5 2 3 0 1 4)
			//   Subset:   tokens = [](5 2 3 0)      // Length: config.NumTokens (4)
			tokens = strings.Split(strOrderedDigits[:numUniqDigits], "")
			prng.Shuffle(numUniqDigits, func(i, j int) { // Shuffle slice using swap func
				tokens[i], tokens[j] = tokens[j], tokens[i]
			})
			tokens = tokens[:config.NumTokens]

		} else { // no-dups-permitted && numUniqDigits < config.NumTokens
			fmt.Printf("There are %d positions. Digit values are 0-%d (i.e. %d unique values).\n",
				config.NumTokens, config.MaxDigit, numUniqDigits)
			fmt.Println("Hence it is impossible to setup the game unless duplicates are permitted.\nQuitting!")
			os.Exit(0)
		}
	}
	return
}

// ////////////////////////////////////////////////////////////////////////////
func PromptPrefixPadding() string {
	if config.IsEasyHint {
		// 11 = len(" 1 | 0123 | .Bww | ") - len("0123") - len(".Bww")
		return strings.Repeat(" ", config.NumTokens*2+11)
	} else {
		// 22 = len(" 1 | 0123 |  1 Bk, 2 Wh | ") - len("0123")
		return strings.Repeat(" ", config.NumTokens+22)
	}
}
