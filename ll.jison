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
"="                   return '='
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex
/* end lexical */

%{
  //console.log('hello');
%}

%right '='
%left '+' '-'
%left '*' '/' '%'

%start program
%% /* language grammar */
program
    : statementseq 'EOF'
        {
          return $1;
        }
    ;
statementseq
    : statementseq statement
        {$$ = {
            type: 'statementseq',
            arguments: [
              $1,
              $2
            ]
          };
        }
    | statement
        {
          $$ = $1;
        }
    ;

statement
    : 'print' factor
        {$$ = {
            type: 'print',
            arguments: [
              $2
            ]
          };
        }
    | 'if' '(' expression ')' '{' statement '}'
        {$$ = {
            type: 'if-statement',
            arguments: [
              $3,
              $6
            ]
          };
        }
    | 'loop' '(' 'NUM' '->' 'NUM' ')' '{' statement '}'
        {$$ = {
            type: 'loop-statement',
            arguments: [
              $statement
            ]
          };
        }
    | 'VAR' '=' statement
        {$$ = {
            type: 'assign',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | expression ';'
        {$$ = $1;}
    ;

expression
    : expression '+' term
        { $$ = {
            type:'multi',
            value: '+',
            left:$1,
            right:$3
          };
        }
    | expression '-' term
        { $$ = {
            type: 'minus',
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
            arguments: [
              $1,
              $3
            ]
          };
        }
    | term '/' factor
        { $$ = {
            type: 'divide',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | term '%' factor
        { $$ = {
            type: 'mod',
            arguments: [
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
            type:'number',
            value: parseInt($1),
            left:null,
            right:null
          };
        }
    | 'VAR'
        { $$ = {
            type:'variable',
            value: $1,
            left:null,
            right:null
          };
        }
    | '(' expression ')'
        { $$ = $2}
    ;
%%