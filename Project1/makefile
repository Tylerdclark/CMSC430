#  Name: Tyler Clark
#  Date: 10/31/2021
#  CMSC 430 Project 1
#  This makefile will compile the project and provides a clean command

# ./compile < input.txt
compile: scanner.o listing.o
	g++ -o compile scanner.o listing.o
	
scanner.o: scanner.c listing.h tokens.h
	g++ -c scanner.c
# -d for flex debugging
scanner.c: scanner.l
	flex scanner.l
	mv lex.yy.c scanner.c

listing.o: listing.cc listing.h
	g++ -c listing.cc
# "make clean" to remove object files, lexemes, and executable
clean:
	rm -f compile *.o lexemes.txt scanner.c