/* Name: Tyler Clark
*  Date: 10/31/2021
*  CMSC 430 Project 1
*  This file contains the function prototypes for the functions that produce the 
*  compilation listing */

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine(); ///< Prints the first line of the listing >
void nextLine();
void lastLine();
void appendError(ErrorCategories errorCategory, string message);