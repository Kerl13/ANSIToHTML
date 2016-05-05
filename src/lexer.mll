{
    open Lexing
    open Parser

    (* Exception signalant une erreur lexicale *)
    exception Lexing_error of string

    (* retour à la ligne *)
    let newline lexbuf =
        let pos = lexbuf.lex_curr_p in
        lexbuf.lex_curr_p <- {
            pos with pos_lnum = pos.pos_lnum + 1;
            pos_bol = pos.pos_cnum
        }
}

    let digit = ['0'-'9']
    let regular = [^'\027' '\r' '\n' '\b']
    

rule token = parse
    | '\n'              { newline lexbuf; EOL }
    | '\r'              { CR }
    | '\b'              { token lexbuf }
    | '\027' '['        { control_sequence [] lexbuf }
    | '\027' '>'        { token lexbuf } 
    | '\027' '=' _      { token lexbuf } 
    | regular+ as s     { STR s }
    | eof               { EOF }

and control_sequence l = parse
    | "?1h"             { token lexbuf }
    | "?1l"             { token lexbuf }
    | 'K'               { ERRASE_K }
    | 'J'               { ERRASE_J }
    | (digit+ as n) ';' { control_sequence (int_of_string n::l) lexbuf }
    | digit+ as n       { control_sequence (int_of_string n::l) lexbuf } 
    | 'm'               { CMD (List.rev l) }

