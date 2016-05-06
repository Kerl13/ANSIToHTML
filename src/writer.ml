open Types

let get_color style = function
  | Hex hcode ->
      Printf.sprintf "color: #%s;" hcode :: style
  | NoColor ->
      assert false

let get_bgcolor style = function
  | Hex hcode ->
      Printf.sprintf "background: #%s;" hcode :: style
  | NoColor ->
      Printf.sprintf "background: transparent" :: style

let get_deco classes deco = 
  let add s b l = if b then s::l else l in
  let (&) f g = fun x -> f (g x) in
  ((add "bold " deco.bold) &
  (add "underlined " deco.underlined) &
  (add "hidden " deco.hidden)) classes

let write_text oc txt =
  (* Getting attributes
   * (styles*classes) *)
  let style = if txt.properties.deco.reverse then
    let style = get_bgcolor [] txt.properties.color in
    get_color style txt.properties.bg
  else
    let style = get_color [] txt.properties.color in
    get_bgcolor style txt.properties.bg in
  let classes = get_deco [] txt.properties.deco in
  (* Printing *)
  let style = String.concat " " style in
  let classes = String.concat " " classes in
  Printf.fprintf oc
   "<span style=\"%s\" class=\"%s\">%s</span>" style classes txt.content

let write_line oc line =
  List.iter (write_text oc) (List.rev line);
  Printf.fprintf oc "\n"

let write_script oc script =
  Printf.fprintf oc "<pre>\n";
  List.iter (write_line oc) script;
  Printf.fprintf oc "</pre>\n"

let write_header oc = 
  let ic = open_in "data/header.html" in
  let rec copy () =
    try
      let line = input_line ic in
      Printf.fprintf oc "%s\n" line;
      copy ()
    with End_of_file -> () in copy ();
  close_in ic

let write_footer oc = Printf.fprintf oc "</body>\n</html>\n\n"

