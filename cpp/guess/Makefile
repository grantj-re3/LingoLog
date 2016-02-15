# Simple Makefile for C++
# Target: guess

CC=g++
# Language standard "c++11" gives method std::to_string().
CFLAGS=-std=c++11 -c -Wall

all: guess

guess: GuessTUImain.o Guess.o
	$(CC) GuessTUImain.o Guess.o -o guess

GuessTUImain.o: GuessTUImain.cpp
	$(CC) $(CFLAGS) GuessTUImain.cpp

Guess.o: Guess.cpp
	$(CC) $(CFLAGS) Guess.cpp

clean:
	rm -f *.o guess
