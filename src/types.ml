(* Style types *)

type color =
  | Black | White
  | Red | Green | Blue | Yellow | Cyan | Magenta
  | LightGray | LightRed
  | Hex of string
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

let copy_deco d () = {  bold = d.bold ;
                        underlined = d.underlined ;
                        reverse = d.reverse ;
                        hidden = d.hidden }

let copy s () = { color = s.color ;
                  bg = s.bg ;
                  deco = copy_deco s.deco () }

let default_style () = 
  let deco = {  bold = false ;
                underlined = false ;
                reverse = false ;
                hidden = false } in
  { color = White ; bg = NoColor ; deco = deco }

(* Types of ANSI commands *)

type errase_code = Err_K | Err_J

(* Types of parsed files *)

type pword =
  | CtrlSeq of int list 
  | Text of string
  | Cr | Bs
  | Errase of errase_code

type pline = pword list

type pscript = pline list

(* Types of interpreted files *)

type text = { content : string ; properties : style }

type line = text list

type script = line list

