# Golang: Mastermind

## Environment

- MX Linux 23.3
- Linux 6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.90-1 (2024-05-03) x86_64 GNU/Linux
- go version go1.23.3 linux/amd64


## Setup

```
$ cd MYPATH/mastermind
$ go mod init example.com/mastermind
$ go get github.com/spf13/pflag
```


## Run commands

```
$ go run mmind.go -h
$ go run mmind.go -r
$ go run mmind.go
```

or build and run separately with:

```
$ go build mmind.go
$ ./mmind -h
$ ./mmind -r
$ ./mmind
```

