/* Name: Tyler Clark
*  Date: 11/13/2021
*  CMSC 430 Project 2
*  This file contains the function prototypes for the functions that produce the 
*  compilation listing */

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
void lastLine();
void appendError(ErrorCategories errorCategory, string message);

