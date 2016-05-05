open Types

let fail s = failwith (s^" not handled yet")

let color256 = function
  | 130 -> RGB (166,73,0)
  | n -> raise (Invalid_argument (string_of_int n))

let rec interp_style style = function
  | [] -> ()
  (* Reset all *)
  | 0::codes -> style.color <- White;
                style.bg    <- NoColor;
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
  (* 8/16 Colors *)
  | 30::codes ->  style.color <- Black;
                  interp_style style codes
  | 31::codes ->  style.color <- Red;
                  interp_style style codes
  | 32::codes ->  style.color <- Green;
                  interp_style style codes
  | 33::codes ->  style.color <- Yellow;
                  interp_style style codes
  | 34::codes ->  style.color <- Blue;
                  interp_style style codes
  | 35::codes ->  style.color <- Magenta;
                  interp_style style codes
  | 36::codes ->  style.color <- Cyan;
                  interp_style style codes
  | 39::codes ->  style.color <- White;
                  interp_style style codes
  | 90::_ | 91::_ | 92::_ | 93::_ | 94::_ | 95::_ | 96::_ -> fail "Light ..."
  | 97::codes ->  style.color <- White;
                  interp_style style codes
  (* Background TODO *)
  (* 88/256 Colors *)
  | 38::5::col::codes ->  style.color <- color256 col;
                          interp_style style codes
  (* Background 88/256 Colors *)
  | 48::5::col::codes ->  style.bg <- color256 col;
                          interp_style style codes
  | n::_ ->  raise (Invalid_argument (string_of_int n))

let print_style style =
  let col = Writer.show_color in
  Printf.printf "{ %s ; %s ; ... }\n" (col style.color) (col style.bg)

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

let interp_line style line = 
  let rec aux (res, rem) = function
    | [] -> cat res rem
    | Cr :: q ->
        aux ([], cat res rem) q
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

