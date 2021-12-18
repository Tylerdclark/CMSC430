/* Name: Tyler Clark
*  Date: 11/28/2021
*  CMSC 430 Project 4
*  This file contains the bison parser for the language described in the instructions.
*/

%{

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <math.h>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<Types> symbols;

bool began = false;



%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Types type;
}

%token <iden> IDENTIFIER
%token <type> INT_LITERAL BOOL_LITERAL REAL_LITERAL
%token ADDOP MULOP RELOP REMOP EXPOP ARROWOP ANDOP OROP NOTOP
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS CASE ELSE ENDCASE ENDIF IF OTHERS THEN WHEN REAL
%type <type> type body statement_ statement reductions expression binary relation term factor exponent unary primary case

%%

function:	
	function_header optional_variable body
	;
	
function_header:	
	FUNCTION IDENTIFIER optional_parameter RETURNS type ';'{storeReturnType($5);}
	| error ';'
	;

optional_variable:
	/* empty */
	| optional_variable variable 
	| error ';'
	;

variable:
	IDENTIFIER ':' type IS statement_ { checkAssignment($3, $5, "Variable Initialization");
										symbols.findDuplicate($1, $3);
										symbols.insert($1, $3);}
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
	IDENTIFIER ':' type {symbols.insert($1, $3);}
	;

type:
	INTEGER {$$ = INT_TYPE;} 
	| REAL {$$ = REAL_TYPE;}
	| BOOLEAN {$$ = BOOL_TYPE;}
	;

body:
	BEGIN_ {began = true;} statement_ END ';'
	;
    
statement_:
	statement ';' {if(began) {checkReturnType($1);}}
	| error ';' {$$ = MISMATCH;}
	;
	
statement:
	expression 
	| REDUCE operator reductions ENDREDUCE {$$ = $3;}
	| IF expression THEN {checkIf($2);} statement_ ELSE statement_ ENDIF { checkThenElse($5, $7); if (began == true) {storeReturnType(REAL_TYPE);}}
	| CASE expression {checkCaseExpression($2);} IS cases OTHERS ARROWOP statement_ ENDCASE {checkCaseWhen($8, "Others"); if (began == true) {storeReturnType(REAL_TYPE);}}
	;

operator:
	ADDOP 
	| MULOP 
	;

cases:
	WHEN INT_LITERAL ARROWOP statement_ {storeFirstWhen($4);} optional_case ;

optional_case:
	optional_case case 
  	|
	;

case:
  WHEN INT_LITERAL ARROWOP statement_ {checkCaseWhen($4, "When");};

reductions:
 	/* empty */ {$$ = INT_TYPE;}
	| reductions statement_ {$$ = checkArithmetic($1, $2);}
	;
		    
expression:
	expression OROP binary {checkLogical($1, $3);}
	| binary 
	;

binary:
	binary ANDOP relation {checkLogical($1, $3);}
	| relation
	;

relation:
	relation RELOP term {$$ = checkRelational($1, $3);}
	| term
	;

term:
	term ADDOP factor {$$ = checkArithmetic($1, $3);}
	| factor 
	;
      
factor:
	factor MULOP exponent {$$ = checkArithmetic($1, $3);}
	| factor REMOP exponent {$$ = checkRemainder($1, $3);}
	| exponent
	;

exponent:
	exponent EXPOP unary {$$ = checkArithmetic($1, $3);}
	| exponent '(' unary ')'
	| unary
	;

unary:
	NOTOP primary {$$ = $2;}
	| primary
	;

primary:
	'(' expression ')' {$$ = $2;}
	| INT_LITERAL {$$ = INT_TYPE;}
	| REAL_LITERAL {$$ = REAL_TYPE;}
	| BOOL_LITERAL {$$ = BOOL_TYPE;}
	| IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);}
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
	lastLine();
	return 0;
} 
