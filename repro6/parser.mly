%token <int> INT

%start <int> main

%%

main:
| i = INT { i }
