open Types
open Colors

let fail s = failwith (s^" not handled yet")

let rec interp_style style = function
  | [] -> ()
  (* Reset all *)
  | 0::codes -> style.color <- default_fg;
                style.bg    <- default_bg;
                style.deco.bold <- false;
                style.deco.underlined <- false;
                style.deco.reverse <- false;
                style.deco.hidden <- false;
                interp_style style codes
  (* Formatting *)
  | 1::codes -> style.deco.bold <- true;
                interp_style style codes
  | 2::_     -> fail "Dim"
  | 4::codes -> style.deco.underlined <- true;
                interp_style style codes
  | 5::_     -> fail "Blink"
  | 7::codes -> style.deco.reverse <- true;
                interp_style style codes
  | 8::codes -> style.deco.hidden <- true;
                interp_style style codes
  (* Reset *)
  | 21::codes ->  style.deco.bold <- false;
                  interp_style style codes
  | 22::_     ->  fail "Dim"
  | 24::codes ->  style.deco.underlined <- false;
                  interp_style style codes
  | 25::_     ->  fail "Blink" 
  | 27::codes ->  style.deco.reverse <- false;
                  interp_style style codes
  | 28::codes ->  style.deco.hidden <- false;
                  interp_style style codes
  (* Foreground: 8/16 colors *)
  | n::codes when (n >= 30 && n < 38) ->
                  style.color <- color256 (n-30);
                  interp_style style codes
  | 39::codes ->  style.color <- default_fg;
                  interp_style style codes
  | n::codes when (n >= 90 && n <= 97) ->
                  style.color <- color256 (n-82);
                  interp_style style codes
  (* Background: 8/16 colors *)
  | n::codes when (n >= 40 && n < 48) ->
                  style.bg <- color256 (n-40);
                  interp_style style codes
  | 49::codes ->  style.bg <- default_bg;
                  interp_style style codes
  | n::codes when (n >= 100 && n <= 107) ->
                  style.bg <- color256 (n-92);
                  interp_style style codes
  (* 88/256 Colors *)
  | 38::5::col::codes ->  style.color <- color256 col;
                          interp_style style codes
  (* Background 88/256 Colors *)
  | 48::5::col::codes ->  style.bg <- color256 col;
                          interp_style style codes
  | n::_ ->  raise (Invalid_argument (string_of_int n))

let cont w (res, rem) =
  let rec del_len len = function
    | [] -> []
    | w'::q ->
        let len' = String.length w'.content in
        if len' < len then
          del_len (len - len') q
        else if len' = len then
          q
        else begin
          let w'' = {
            content = String.sub w'.content len (len' - len) ;
            properties = w'.properties } in
          w''::q
        end in
  (w::res, del_len (String.length w.content) rem)

let rec cat res = function
  | [] -> res
  | t::q -> cat (t::res) q

let cat_rev res rem = cat rem res

let backspace = function
  | [] -> []
  | w::res ->
      let len = String.length w.content in
      if len > 1 then
        let w' = {  content = String.sub w.content 0 (len-1) ;
                    properties = copy w.properties () } in
        w'::res
      else res

let interp_line style line = 
  let rec aux (res, rem) = function
    | [] -> cat res rem
    (* FIXME : Err_J shouldn't be handled like that *)
    | Errase Err_K :: q | Errase Err_J :: q ->
        aux (res, []) q
    | Cr :: q ->
        aux ([], cat_rev res rem) q
    | Bs :: q -> aux (backspace res, rem) q
    | Text txt :: q ->
        let style' = copy style () in
        aux (cont { content = txt ; properties = style' } (res, rem)) q
    | CtrlSeq ctrl :: q ->
        interp_style style ctrl;
        aux (res, rem) q in
  aux ([], []) line

let interp_script (s : pscript) : script =
  let style = default_style () in
  List.map (interp_line style) s

