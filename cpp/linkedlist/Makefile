# Simple Makefile for C++
# Target: llist

CC=g++
# Language standard "c++11" gives method std::to_string().
CFLAGS=-c -Wall

all: llist

llist: llist.o
	$(CC) llist.o -o llist

llist.o: llist.cpp
	$(CC) $(CFLAGS) llist.cpp

clean:
	rm -f *.o llist
