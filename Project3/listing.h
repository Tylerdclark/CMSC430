/* Name: Tyler Clark
*  Date: 11/28/2021
*  CMSC 430 Project 3
*  This file contains the function prototypes for the functions that produce the 
*  compilation listing */

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

