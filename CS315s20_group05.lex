%{
#include <stdio.h>
#include <stdlib.h>
int lineNo = 1;
%}
main                main
sign                [+-]
digit               [0-9]
integer             {sign}?{digit}+
double              {sign}?{digit}*(\.)?{digit}+
String              \"[^\"]*\"
alphabetic          [A-Za-z]
alphanumeric        ({alphabetic}|{digit})
identifier          {alphabetic}{alphanumeric}*
comment             \/\/.*\/\/
set                 \$((\ )*[a-zA-Z0-9]*(\ )*)(,(\ )*[a-zA-Z0-9]*)*(\ )*\$
setofsets           \$(\ )*{set}(\ )*(,(\ )*{set}(\ )*)*\$
union               uni
intersection        intx
difference          diff
complement          comp
%%
{main}              return MAIN;
{comment}           return COMMENT;
true|false          return BOOLEAN;
{integer}           return INTEGER;
{double}            return DOUBLE;
{String}            return STRING;
{set}               return SET;
{setofsets}         return SETOFSETS;
create              return CREATE_OP;
delete              return DELETE_OP;
set                 return SET_TYPE;
setofsets           return SET_OF_SET_TYPE;
String              return STRING_TYPE;
int                 return INT_TYPE;
void                return VOID_TYPE;
double              return DOUBLE_TYPE;
bool                return BOOL_TYPE;
read                return READ;
write               return WRITE;
if                  return IF;
else                return ELSE;
while               return WHILE;
return              return RETURN;
{union}             return UNION_OP;
{intersection}      return INTERSECTION_OP;
{difference}        return DIFFERENCE_OP;
{complement}        return COMPLEMENT_OP;
\(                  return LP;
\)                  return RP;
\[                  return LSB;
\]                  return RSB;
\{                  return LCB;
\}                  return RCB;
\!                  return NEGATION;
\,                  return COMMA;
\*                  return MULTIPLICATION;
\/                  return DIVISION;
\+                  return ADDITION;
\-                  return SUBTRACTION;
\&\&                return AND;
\|\|                return OR;
\<                  return LESS_THAN;
\<\=                return LESS_OR_EQ;
\>                  return GREATER_THAN;
\>\=                return GREATER_OR_EQ;
{identifier}        return IDENTIFIER;
\=\=                return EQUALS_OPERATOR;
\!\=                return NOT_EQUALS_OPERATOR;
\=                  return ASSIGNMENT_OPERATOR;
\$\<                return PROPER_SUBSET_OPERATOR;
\$\<\=              return SUBSET_OPERATOR;
\$\>\               return SUPERSET_OPERATOR;
\$\>\=              return PROPER_SUPERSET_OPERATOR;
\$\=\=              return EQUIVALENT_OPERATOR;
\$\*                return CARTESIAN_OPERATOR;
\n                  {
                        lineNo++;
                    }
\;                  return SEMICOLON;
[ \t]               ;
%%
int yywrap() { 
    return 1;
}
