/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
[a-zA-Z]+             return 'CHARACTER'
"*"                   return '*'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start start
%% /* language grammar */

start
    : multip EOF
        {return $1;}
    ;

multip
    : multip '*' multip
        {$$ = {
            type: 'multip-P',
            arguments: [
              $1,
              $3
            ]
          };
        }
    | 'NUMBER'
        {$$ = {
              type: 'number',
              arguments: [$1]
            };
         }
    | 'CHARACTER'
        {$$ = {
              type: 'character',
              arguments: [$1]
            };
         }
    ;

variable
    : 'NUMBER'
        {$$ = {
              type: 'number',
              arguments: [$1]
            };
         }
    | 'CHARACTER'
        {$$ = {
              type: 'character',
              arguments: [$1]
            };
         }
    ;