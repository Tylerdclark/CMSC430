/* Name: Tyler Clark */
/* Date: 11/13/2021 */
/* CMSC 430 Project 2 */
/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		(\-\-.*\n)|(\/\/.*\n)  
line		[\n]
id		[A-Za-z]([_]?[A-Za-z0-9])*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
real		[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"	{ ECHO; return(RELOP); }
">"     { ECHO; return(RELOP); }
">="    { ECHO; return(RELOP); }
"<="    { ECHO; return(RELOP); }
"="     { ECHO; return(RELOP); }
"/="    { ECHO; return(RELOP); }
"+"|"-"		{ ECHO; return(ADDOP); }
"*"|"/"		{ ECHO; return(MULOP); }
"=>"	{ECHO; yylval.oper = ARROW; return(ARROW); }
"**"	{ ECHO; return(EXPOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
if		{ ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
or		{ ECHO; return(OROP); }
not		{ ECHO; return(NOTOP); }
rem		{ ECHO; return(REMOP); }
true|false	{ ECHO; return(BOOL_LITERAL); }
{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{real}		{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
