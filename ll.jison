/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
"if"                  return 'if'
"{"                   return '{'
"}"                   return '}'
";"                   return ';'
'loop'                return 'loop'
','                   return ','
'->'                  return '->'
[0-9]+("."[0-9]+)?\b  return 'NUM'
[a-zA-Z]+             return 'VAR'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"!"                   return '!'
"%"                   return '%'
"("                   return '('
")"                   return ')'
"PI"                  return 'PI'
"="                   return '='
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%right '!'
%right '%'

%start start
%% /* language grammar */

start
    : stagement 'EOF'
        {return $1;}
    | stagement ';'
        {return $1;}
    ;

stagement
    : 'VAR' '=' expression
        {$$ = {
            type: 'assign',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | 'print' factor ';'
        {$$ = {
            type: 'print',
            arguments: [
              $2
            ]
          };
        }
    | 'if' '(' expression ')' '{' stagement '}'
        {$$ = {
            type: 'if-stagement',
            arguments: [
              $3,
              $6
            ]
          };
        }
    | 'loop' '(' 'NUM' '->' 'NUM' ',' 'NUM' ')' '{' stagement '}'
        {$$ = {
            type: 'loop-stagement',
            arguments: [
              $stagement
            ]
          };
        }
    | expression
    ;

expression
    : expression '+' term
        {$$ = {
            type: 'add',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | expression '-' term
        {$$ = {
            type: 'MIN',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | term
    ;

term
    : term '*' factor
        { $$ = {
            type: 'multi',
            argements: [
              $1,
              $3
            ]
          };
        }
    | term '/' factor
        { $$ = {
            type: 'divi',
            argements: [
              $1,
              $3
            ]
          };
        }
    | term '%' factor
        { $$ = {
            type: 'mod',
            argements: [
              $1,
              $3
            ]
          };
        }
    | factor
    ;

factor
    : 'NUM'
        { $$ = {
            type: 'number',
            argements: [
              $1
            ]
          };
        }
    | 'VAR'
        { $$ = {
            type: 'variable',
            arguments: [
              $1
            ]
          };
        }
    | '(' expression ')'
        {return $2;}
    ;