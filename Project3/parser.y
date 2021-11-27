/* Name: Tyler Clark
*  Date: 11/13/2021
*  CMSC 430 Project 2
*  This file contains the bison parser for the language described in the instructions.
*/

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<int> symbols;

int result;
%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Operators oper;
	int value;
}

%token <iden> IDENTIFIER
%token <value> INT_LITERAL BOOL_LITERAL REAL_LITERAL
%token <oper> ADDOP MULOP RELOP REMOP 
%token ANDOP EXPOP OROP NOTOP
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS ARROW CASE ELSE ENDCASE ENDIF IF OTHERS THEN WHEN REAL

%type <value> body statement_ statement reductions expression binary relation term factor exponent unary primary case
%type <oper> operator

%%

function:	
	function_header optional_variable body	{result = $3;}
	;
	
function_header:	
	FUNCTION IDENTIFIER optional_parameter RETURNS type ';'
	| error ';'
	;

optional_variable:
	/* empty */
	| optional_variable variable 
	| error ';'
	;

variable:
	IDENTIFIER ':' type IS statement_ 
	;

optional_parameter:
	/* empty */
	| parameter_list 
	;

parameter_list:
	parameter_list ',' parameter 
	| parameter 
	;

parameter:
	IDENTIFIER ':' type 
	;

type:
	INTEGER 
	| REAL
	| BOOLEAN 
	;

body:
	BEGIN_ statement_ END ';' 
	;
    
statement_:
	statement ';' 
	| error ';' 
	;
	
statement:
	expression 
	| REDUCE operator reductions ENDREDUCE 
	| IF expression THEN statement_ ELSE statement_ ENDIF
	| CASE expression IS case OTHERS ARROW statement_ ENDCASE
	;

operator:
	ADDOP 
	| MULOP 
	;

case: 
	/* empty */
	| case WHEN INT_LITERAL ARROW statement_
	;

reductions:
 	/* empty */
	| reductions statement_ 
	;
		    
expression:
	expression OROP binary 
	| binary 
	;

binary:
	binary ANDOP relation
	| relation
	;

relation:
	relation RELOP term 
	| term
	;

term:
	term ADDOP factor 
	| factor 
	;
      
factor:
	factor MULOP exponent 
	| factor REMOP exponent
	| exponent
	;

exponent:
	exponent EXPOP unary
	| exponent '(' unary ')'
	| unary
	;

unary:
	NOTOP primary
	| primary
	;

primary:
	'(' expression ')' 
	| INT_LITERAL
	| REAL_LITERAL
	| BOOL_LITERAL 
	| IDENTIFIER 
	;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	return 0;
} 
