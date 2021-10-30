// Compiler Theory and Design
// Dr. Duane J. Jarc

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>
#include <queue> // Will be used for the queue of err

using namespace std;

#include "listing.h"

static int lineNumber;
static queue<string> errorQueue;
static int totalErrors[] = {0, 0, 0}; // 0 = lexical, 1 = syntax, 2 = semantic
static void displayErrors();
static void clear(queue<int> &q);

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ", lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ", lineNumber);
}

void lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	int total = totalErrors[0] + totalErrors[1] + totalErrors[2];

	if (total > 0)
	{
		printf("Lexical Errors: %d\n", totalErrors[0]);
		printf("Syntax Errors: %d\n", totalErrors[1]);
		printf("Semantic Errors: %d\n", totalErrors[2]);
	}
	else
	{
		printf("Compiled Successfully\n");
	}
}

void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = {"Lexical Error, Invalid Character ", "",
						 "Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
						 "Semantic Error, Undeclared "};

	errorQueue.push(messages[errorCategory] + message);
	totalErrors[errorCategory]++;
}

void displayErrors()
{

	while (!errorQueue.empty())
	{
		printf("%s\n", errorQueue.front().c_str());
		errorQueue.pop();
	}
}
