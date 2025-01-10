# Golang: Mastermind version 2

This version includes several new features including:
- GameID allowing the same game to be setup again | easy-hint feature
- multiple packages | multiple files in a single package (folder)
- the *token* package which has object-oriented programming features:
  class-level variables, functions, etc. | instance-level variables,
  functions, etc.
- solving the compiler error: *import cycle not allowed* (see hint.go) |
  seeding the pseudo-random number generator (PRNG) | writing to a file |
  time and elapsed time
- a Makefile to assist development


## Environment

- MX Linux 23.3
- Linux 6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.90-1 (2024-05-03) x86_64 GNU/Linux
- go version go1.23.3 linux/amd64


## Setup

```
$ cd MYPATH/mastermindv2_oop
$ go mod init example.com/mastermindv2
$ go get github.com/spf13/pflag
```


## Build and run separately with:

```
$ make build
$ go build .	# Or 'make build'
$ ./mastermindv2 -h
$ ./mastermindv2 -r
$ ./mastermindv2
```

