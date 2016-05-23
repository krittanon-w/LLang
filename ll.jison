%{
  var say = 'hello';
%}

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
"\n"                  return ''
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
    : statementseq
        {
          return $1;
        }
    ;
statementseq
    : statementseq statement
        {
          $$ = node('stmtseq',null,$1,$statement);
        }
    | statement
        {
          $$ = $1;
        }
    ;

opt_newlines
    : %empty
    | opt_newlines 'EOF'
    ;

newlines
    : '\n'
    ;

statement
    : 'print' factor
        {
          $$ = node('print',$2,null,null);
        }
    | 'if' '(' expression ')' '{' statement '}'
        {
          $$ = node('loop','if',$3,$6);
        }
    | 'loop' '(' 'NUM' '->' 'NUM' ')' '{' statement '}'
        {
          $$ = node('loop',[$3,$6],null,$6);
        }
    | expression ';'
        {$$ = $1;}
    ;

expression
    : expression '+' term
        {
          $$ = node('add','+',$1,$3);
        }
    | expression '-' term
        {
          $$ = node('minus','+',$1,$3);
        }
    | 'VAR' '=' expression
        {
          $$ = node('assign','=',$1,$3);
        }
    | term
    ;

term
    : term '*' factor
        {
          $$ = node('miuti','*',$1,$3);
        }
    | term '/' factor
        {
          $$ = node('divide','/',$1,$3);
        }
    | term '%' factor
        {
          $$ = node('mod','%',$1,$3);
        }
    | factor
    ;

factor
    : 'NUM'
        {
          $$ = node('number',$1,null,null);
        }
    | 'VAR'
        {
          $$ = node('variable',$1,null,null);
        }
    | '(' expression ')'
        { $$ = $2}
    ;
%%

function node(type,value,left_node,right_node){
  return {
    type:type,
    value: value,
    left:left_node,
    right:right_node
  }
}

parser.test = function(){
  return 'hello jison';
}