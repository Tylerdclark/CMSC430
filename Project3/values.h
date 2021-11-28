/* Name: Tyler Clark
*  Date: 11/13/2021
*  CMSC 430 Project 3
*  This file contains function definitions for the evaluation functions
*/

typedef char *CharPtr;
enum Operators
{
    ADD,
    ARROW,
    DIVIDE,
    EQUAL,
    EXP,
    GREATER,
    GREATER_EQUAL,
    LESS,
    LESS_EQUAL,
    MULTIPLY,
    NOT_EQUAL,
    REM,
    SUBTRACT
};

int evaluateReduction(Operators operator_, int head, int tail);
int evaluateRelational(int left, Operators operator_, int right);
int evaluateArithmetic(int left, Operators operator_, int right);
