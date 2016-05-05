open Types

let show_color = function
  | White -> "white"
  | Black -> "black"
  | Red -> "red"
  | Green -> "green"
  | Blue -> "blue"
  | Yellow -> "yellow"
  | Cyan -> "cyan"
  | Magenta -> "magenta"
  | LightGray -> "light-gray"
  | LightRed -> "light-red"
  | RGB _ -> raise (Invalid_argument "show_color: RGB")
  | NoColor -> "nocolor"

let print_style style =
  let col = show_color in
  Printf.printf "{ %s ; %s ; ... }\n" (col style.color) (col style.bg)

let get_color (styles, classes) = function
  | RGB(r,g,b) ->
      Printf.sprintf "color: rgb(%d,%d,%d);" r g b::styles,
      classes
  | col -> 
      styles ,
      (show_color col)::classes

let get_bgcolor (styles, classes) = function
  | RGB(r,g,b) ->
      Printf.sprintf "background: rgb(%d,%d,%d);" r g b::styles,
      classes
  | col -> 
      styles ,
      ("bg-"^(show_color col))::classes

let get_deco (styles, classes) deco = 
  let add s b l = if b then s::l else l in
  let (&) f g = fun x -> f (g x) in
  let classes = 
    ((add "bold " deco.bold) &
    (add "underlined " deco.underlined) &
    (add "hidden " deco.hidden)) classes in
  styles, classes

let write_text oc txt =
  (* Getting attributes
   * (styles*classes) *)
  let attr = if txt.properties.deco.reverse then
    let attr = get_bgcolor ([],[]) txt.properties.color in
    get_color attr txt.properties.bg
  else
    let attr = get_color ([],[]) txt.properties.color in
    get_bgcolor attr txt.properties.bg in
  let attr = get_deco attr txt.properties.deco in
  (* Printing *)
  let styles = String.concat " " (fst attr) in
  let classes = String.concat " " (snd attr) in
  Printf.fprintf oc
   "<span style=\"%s\" class=\"%s\">%s</span>" styles classes txt.content

let write_line oc line =
  List.iter (write_text oc) (List.rev line);
  Printf.fprintf oc "\n"

let write_script oc script =
  let ic = open_in "data/header.html" in
  let rec copy () =
    try
      let line = input_line ic in
      Printf.fprintf oc "%s\n" line;
      copy ()
    with End_of_file -> () in copy ();
  close_in ic;
  Printf.fprintf oc "<body>\n<pre>\n";
  List.iter (write_line oc) script;
  Printf.fprintf oc "</pre>\n</body>"

