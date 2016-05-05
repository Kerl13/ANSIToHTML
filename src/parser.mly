
%{
    open Types
%}


%token <int list> CMD
%token <string> STR
%token EOL EOF CR

/* Points d'entrée de la grammaire */
%start file

/* Types des valeurs renvoyées par l'analyseur syntaxique */
%type <Types.pscript> file

%%

file: f = separated_nonempty_list(EOL, line) ; EOF { f }

line: l = word* { l }

word:
  | codes = CMD { CtrlSeq codes }
  | text = STR { Text text }
  | CR { Cr }


