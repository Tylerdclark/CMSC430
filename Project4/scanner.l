/* Name: Tyler Clark */
/* Date: 11/28/2021 */
/* CMSC 430 Project 4 */
/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;

#include "types.h"
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
and		{ ECHO; return(ANDOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
end		{ ECHO; return(END); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
if		{ ECHO; return(IF); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
not		{ ECHO; return(NOTOP); }
or		{ ECHO; return(OROP); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
reduce		{ ECHO; return(REDUCE); }
returns		{ ECHO; return(RETURNS); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
"<"	        { ECHO; return(RELOP); }
">"             { ECHO; return(RELOP); }
">="            { ECHO; return(RELOP); }
"<="            { ECHO; return(RELOP); }
"="             { ECHO; return(RELOP); }
"/="            { ECHO; return(RELOP); }
"+"    	        { ECHO; return(ADDOP); }
"-"	        { ECHO; return(ADDOP); }
"*"	        { ECHO; return(MULOP); }
"/"	        { ECHO; return(MULOP); }
"=>"	        { ECHO; return(ARROWOP); }
"**"	        { ECHO; return(EXPOP); }
rem	        { ECHO; return(REMOP); }
true            { ECHO; return(BOOL_LITERAL); }
false           { ECHO; return(BOOL_LITERAL); }
{id}	        { 
                ECHO; 
                yylval.iden = (CharPtr)malloc(yyleng + 1); 
                strcpy(yylval.iden, yytext); 
                return(IDENTIFIER);}
{int}	        { 
                ECHO; 
                yylval.type = INT_TYPE; 
                return(INT_LITERAL); }
{real}	        { 
                ECHO; 
                yylval.type = REAL_TYPE; 
                return(REAL_LITERAL); }
{punc}	        { 
                ECHO; 
                return(yytext[0]); }
.	        { 
                ECHO; 
                appendError(LEXICAL, yytext); }
%%
