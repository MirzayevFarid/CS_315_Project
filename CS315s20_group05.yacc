%{
    #include <stdio.h>
%}
%token MAIN
%token COMMENT
%token BOOLEAN
%token INTEGER
%token DOUBLE
%token STRING
%token SET
%token SETOFSETS
%token SET_OF_SET_TYPE
%token SET_TYPE
%token STRING_TYPE
%token INT_TYPE
%token VOID_TYPE
%token DOUBLE_TYPE
%token BOOL_TYPE
%token READ
%token WRITE
%token IF
%token ELSE
%token WHILE
%token RETURN
%token CREATE_OP
%token DELETE_OP
%token UNION_OP
%token INTERSECTION_OP
%token DIFFERENCE_OP
%token COMPLEMENT_OP
%token LP
%token RP
%token LSB
%token RSB
%token LCB
%token RCB
%token NEGATION
%token COMMA
%token MULTIPLICATION
%token DIVISION
%token ADDITION
%token SUBTRACTION
%token AND
%token OR
%token LESS_THAN
%token LESS_OR_EQ
%token GREATER_THAN
%token GREATER_OR_EQ
%token IDENTIFIER
%token EQUALS_OPERATOR
%token NOT_EQUALS_OPERATOR
%token ASSIGNMENT_OPERATOR
%token PROPER_SUBSET_OPERATOR
%token SUBSET_OPERATOR
%token SUPERSET_OPERATOR
%token PROPER_SUPERSET_OPERATOR
%token EQUIVALENT_OPERATOR
%token CARTESIAN_OPERATOR
%token BEGIN_END_SET
%token SEMICOLON
%%
start: MAIN LCB stmnts RCB {printf("Input program is valid.\n");}
stmnts: | stmnt | stmnt non_empty_stmnts
;
non_empty_stmnts: stmnt | stmnt non_empty_stmnts
;
stmnt:      decleration SEMICOLON
          | dec_init_operation SEMICOLON
          | assignment_operation SEMICOLON
          | create SEMICOLON
          | delete SEMICOLON
          | if
          | while
          | funct_definition
          | funct_call SEMICOLON
          | read SEMICOLON
          | write SEMICOLON
          | return SEMICOLON
          | COMMENT
;
decleration: data_type IDENTIFIER
;
dec_init_operation: data_type assignment_operation
                  | set_data_type assignment_operation
;
assignment_operation: IDENTIFIER ASSIGNMENT_OPERATOR assignment_operator_right
;
assignment_operator_right:  IDENTIFIER
                          | var_type
                          | set_type
                          | funct_call
                          | set_operation
;
create: CREATE_OP IDENTIFIER
;
delete: DELETE_OP IDENTIFIER
;
if:      IF LP boolean_expression RP LCB stmnts RCB 
       | IF LP boolean_expression RP LCB stmnts RCB ELSE LCB stmnts RCB
;
while: WHILE LP boolean_expression RP LCB stmnts RCB
;
funct_definition: data_type IDENTIFIER LP function_definition_params RP LCB stmnts RCB
                | set_data_type IDENTIFIER LP function_definition_params RP LCB stmnts RCB
                | VOID_TYPE IDENTIFIER LP function_definition_params RP LCB stmnts RCB
;
function_definition_params: | funct_param | funct_param COMMA non_empty_function_definition_params
;
non_empty_function_definition_params: funct_param | funct_param COMMA non_empty_function_definition_params
;
funct_param: data_type IDENTIFIER | set_data_type IDENTIFIER
;
funct_call: IDENTIFIER LP function_call_params RP
;
function_call_params: | IDENTIFIER | IDENTIFIER COMMA non_empty_function_call_params
;
non_empty_function_call_params: IDENTIFIER | IDENTIFIER COMMA non_empty_function_call_params
;
read: READ LP IDENTIFIER RP
;
write: WRITE LP IDENTIFIER RP | WRITE LP var_type RP | WRITE LP set_type RP
;
return: RETURN var_type | RETURN set_type | RETURN funct_call | RETURN IDENTIFIER
;
boolean_expression: boolean_logical_expression | bool_set_operation
;
boolean_logical_expression: var_type logical_operands var_type
                | IDENTIFIER logical_operands var_type
                | var_type logical_operands IDENTIFIER
                | IDENTIFIER logical_operands IDENTIFIER
                | var_type NEGATION logical_operands var_type
                | IDENTIFIER NEGATION logical_operands var_type
                | var_type NEGATION logical_operands IDENTIFIER
                | IDENTIFIER NEGATION logical_operands IDENTIFIER  
                | IDENTIFIER
                | NEGATION IDENTIFIER
                | BOOLEAN
                | NEGATION BOOLEAN
;
bool_set_operation:   set_type set_bool_operator set_type
                    | IDENTIFIER set_bool_operator set_type
                    | set_type set_bool_operator IDENTIFIER
                    | IDENTIFIER set_bool_operator IDENTIFIER
                    | set_type NEGATION set_bool_operator set_type
                    | IDENTIFIER NEGATION set_bool_operator set_type
                    | set_type NEGATION set_bool_operator IDENTIFIER
                    | IDENTIFIER NEGATION set_bool_operator IDENTIFIER                    
;
logical_operands:      MULTIPLICATION
                     | DIVISION
                     | ADDITION
                     | SUBTRACTION
                     | AND
                     | OR
                     | LESS_THAN   
                     | LESS_OR_EQ
                     | GREATER_THAN
                     | GREATER_OR_EQ
                     | EQUALS_OPERATOR
                     | NOT_EQUALS_OPERATOR
;
set_bool_operator:    PROPER_SUBSET_OPERATOR 
                    | SUBSET_OPERATOR
                    | PROPER_SUPERSET_OPERATOR
                    | SUPERSET_OPERATOR
                    | EQUIVALENT_OPERATOR
                    | CARTESIAN_OPERATOR
;
set_operation: union_operation
             | intersection_operation
             | difference_operation
             | complement_operation
             | cartesian_operation
;
union_operation:  IDENTIFIER UNION_OP IDENTIFIER
                | IDENTIFIER UNION_OP set_type
                | set_type UNION_OP IDENTIFIER
                | set_type UNION_OP set_type
;
intersection_operation:  IDENTIFIER INTERSECTION_OP IDENTIFIER
                |  IDENTIFIER INTERSECTION_OP set_type
                |  set_type INTERSECTION_OP IDENTIFIER
                |  set_type INTERSECTION_OP set_type
;
difference_operation:  IDENTIFIER DIFFERENCE_OP IDENTIFIER
                |  IDENTIFIER DIFFERENCE_OP set_type
                |  set_type DIFFERENCE_OP IDENTIFIER
                |  set_type DIFFERENCE_OP set_type
;
complement_operation:  IDENTIFIER COMPLEMENT_OP IDENTIFIER
                |  IDENTIFIER COMPLEMENT_OP set_type
                |  set_type COMPLEMENT_OP IDENTIFIER
                |  set_type COMPLEMENT_OP set_type
;
cartesian_operation:  IDENTIFIER CARTESIAN_OPERATOR IDENTIFIER
                |  IDENTIFIER CARTESIAN_OPERATOR set_type
                |  set_type CARTESIAN_OPERATOR IDENTIFIER
                |  set_type CARTESIAN_OPERATOR set_type
;
set_type: SET | SETOFSETS
;
var_type:     INTEGER
            | DOUBLE
            | BOOLEAN
            | STRING
;
data_type:  INT_TYPE 
          | DOUBLE_TYPE 
          | STRING_TYPE 
          | BOOL_TYPE
;
set_data_type: SET_TYPE | SET_OF_SET_TYPE
;
%%
#include "lex.yy.c"
yyerror(char *s) { printf("[line: %d] Error occured on line %s \n", lineNo, s); }
main() {
  return yyparse();
}
