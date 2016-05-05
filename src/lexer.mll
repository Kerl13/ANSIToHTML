{
    open Lexing
    open Parser

    (* Exception signalant une erreur lexicale *)
    exception Lexing_error of string
    let error s c =
      let ascii = int_of_char c in
      raise (Lexing_error (Printf.sprintf "%s: %c (\\%d)." s c ascii))

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
    | '\007'            { token lexbuf } (* BEL *)
    | '\008'            { token lexbuf } (* BS -> ??? *)
    | '\027'            { escaped lexbuf }
    | regular+ as s     { STR s }
    | eof               { EOF }
    | _ as c            { error "Unknown character" c }

and escaped = parse
    | '['               { control_sequence [] lexbuf }
    | '>'               { token lexbuf }
    | '='               { token lexbuf }
    | ']'               { token lexbuf }
    | _ as c            { error "Unknown escaped character" c }

and control_sequence l = parse
    | '?' digit+ 'h'    { token lexbuf } (* ??? *)
    | '?' digit+ 'l'    { token lexbuf } (* ??? *)
    | 'K'               { ERRASE_K }
    | 'J'               { ERRASE_J }
    | (digit+ as n) ';' { control_sequence (int_of_string n::l) lexbuf }
    | digit+ as n       { control_sequence (int_of_string n::l) lexbuf } 
    | 'm'               { CMD (List.rev l) }

