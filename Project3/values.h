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

double evaluateReduction(Operators operator_, double head, double tail);
double evaluateRelational(double left, Operators operator_, double right);
double evaluateArithmetic(double left, Operators operator_, double right);
double evaluateIfElse(double expression, double ifStatement, double elseStatement);

