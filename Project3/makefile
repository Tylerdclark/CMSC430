#  Name: Tyler Clark
#  Date: 11/28/2021
#  CMSC 430 Project 3
#  This makefile will compile the project and provides a clean command

compile: scanner.o parser.o listing.o values.o
	g++ -o compile scanner.o parser.o listing.o values.o
	
scanner.o: scanner.c values.h listing.h tokens.h
	g++ -c scanner.c

scanner.c: scanner.l	
	flex scanner.l
	mv lex.yy.c scanner.c

parser.o: parser.c values.h listing.h symbols.h
	g++ -c parser.c

parser.c tokens.h: parser.y
	bison -d -v parser.y
	mv parser.tab.c parser.c
	cp parser.tab.h tokens.h

listing.o: listing.cc listing.h
	g++ -c listing.cc

values.o: values.cc values.h
	g++ -c values.cc

clean:
	rm -f compile *.o scanner.c parser.c parser.output parser.tab.h tokens.h