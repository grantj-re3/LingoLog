package token

// This file contains a struct & associated methods.
// From an OOP perspective, the content looks like
// instance-level variables, functions, etc.

import (
	"bufio"
	"example.com/mastermindv2/game/token/hint"
	"fmt"

	"os"
	"strconv"
	"strings"
)

// ////////////////////////////////////////////////////////////////////////////
type Details struct {
	GuessNum  int
	Tokens    []string
	StrTokens string
	PtrSecret *[]string

	matchPosCount int      // Number of matches in the correct position
	matchCount    int      // Number of matches in the wrong position
	posHint       []string // Elements are: Positional hint chars above
}

// ////////////////////////////////////////////////////////////////////////////
type WhatInput int

const (
	WITokens WhatInput = iota
	WIQuit
	WIHistory
	WINone
)

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) areTokensOk() bool {
	for _, token := range ptd.Tokens {
		digit, err := strconv.Atoi(token)
		if err != nil {
			fmt.Printf("     Expected range is 0-%d, but got non-numeric character '%s'. Try again.\n", config.MaxDigit, token)
			fmt.Printf("%s", PromptPrefixPadding())
			return false
		}
		if digit > config.MaxDigit {
			fmt.Printf("     Expected range is 0-%d, but got digit %d. Try again.\n", config.MaxDigit, digit)
			fmt.Printf("%s", PromptPrefixPadding())
			return false
		}
	}
	if len(ptd.Tokens) != config.NumTokens {
		fmt.Printf("     Expected %d digits, but got %d. Try again.\n", config.NumTokens, len(ptd.Tokens))
		fmt.Printf("%s", PromptPrefixPadding())
		return false
	}
	return true
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) GetUserTokens() WhatInput {
	for {
		fmt.Printf("Enter %d digits in range 0-%d (or 'q','h'): ", config.NumTokens, config.MaxDigit)
		scanner := bufio.NewScanner(os.Stdin)
		if scanner.Scan(); scanner.Err() != nil {
			continue
		}
		ptd.StrTokens = strings.TrimSpace(scanner.Text())
		if lc := strings.ToLower(ptd.StrTokens); lc == "q" || lc == "quit" {
			return WIQuit
		} else if lc == "h" || lc == "history" {
			return WIHistory
		}

		ptd.Tokens = strings.Split(ptd.StrTokens, "")
		if !ptd.areTokensOk() {
			continue
		}

		return WITokens
	}
	return WINone // Never gets here!
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) calcMatchPosCount() {
	ptd.posHint = make([]string, config.NumTokens)
	for i := range ptd.posHint {
		ptd.posHint[i] = hint.PHNone
	}

	// IF same token in same position THEN matchPosCount++
	ptd.matchPosCount = 0
	for i, token := range ptd.Tokens {
		secret := (*ptd.PtrSecret)[i]
		if token == secret { // We have a match
			ptd.posHint[i] = hint.PHGoodPos
			ptd.matchPosCount++
		}
	}
	return
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) calcMatchCount() {
	// You must invoke calcMatchPosCount() before this function!

	// IF same token in different position THEN matchCount++
	ptd.matchCount = 0
	for i, secret := range *ptd.PtrSecret {
		if ptd.posHint[i] == hint.PHGoodPos {
			// Skip! We already have a match for this element of the secret
			continue
		}
		for j, token := range ptd.Tokens {
			if i == j {
				// Skip! Already processed in calcMatchPosCount()
				continue
			}
			if ptd.posHint[j] != hint.PHNone {
				// Skip! We already have a match for this element of the secret
				continue
			}
			if token == secret { // We have a match
				ptd.posHint[j] = hint.PHBadPos
				ptd.matchCount++

				// Stop the (inner) tokens loop and ...
				// move to processing the next secret element (outer loop)
				break
			}
		}
	}
	return
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) CalcFeedback() {
	ptd.calcMatchPosCount()
	ptd.calcMatchCount()
	return
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) ShowFeedback() {
	var hint string
	if config.IsEasyHint {
		hint = fmt.Sprintf("%s", strings.Join(ptd.posHint, ""))
	} else {
		hint = fmt.Sprintf("%2d Bk,%2d Wh", ptd.matchPosCount, ptd.matchCount)
	}
	fmt.Printf("%2d | %s | %s | ", ptd.GuessNum, strings.Join(ptd.Tokens, ""), hint)
}

// ////////////////////////////////////////////////////////////////////////////
func (ptd *Details) GameOver() bool {
	return ptd.matchPosCount == config.NumTokens
}
