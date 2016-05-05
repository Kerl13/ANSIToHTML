(* Style types *)

type color =
  | Black | White
  | Red | Green | Blue | Yellow | Cyan | Magenta
  | RGB of int * int * int
  | NoColor

type deco = {
  mutable bold : bool ;
  mutable underlined : bool ;
  mutable reverse : bool ;
  mutable hidden : bool }

type style = {
  mutable color : color ;
  mutable bg    : color ;
  deco          : deco }

let copy s () = {  color = s.color ;
                bg = s.bg ;
                deco = s.deco }

let default_style () = 
  let deco = {  bold = false ;
                underlined = false ;
                reverse = false ;
                hidden = false } in
  { color = White ; bg = NoColor ; deco = deco }

(* Types of parsed files *)

type pword = CtrlSeq of int list | Text of string | Cr

type pline = pword list

type pscript = pline list

(* Types of interpreted files *)

type text = { content : string ; properties : style }

type line = text list

type script = line list

