open Writer

let standalone = ref false
let ifiles = Hashtbl.create 17
let ofile = ref "out.html"

let add_ifile f = 
  if Sys.file_exists f then Hashtbl.add ifiles f ()
  else begin
    Printf.eprintf "File %s doesn't exist.\n" f;
    exit 1
  end

let options = [
  "-s", Arg.Set standalone, 
  " produce a standalone html file.";
  "-i", Arg.String add_ifile,
  "<file>  Set an input file";
  "-o", Arg.String (fun f -> ofile := f),
  "<file>  Set the output file. `out.html` if not specified."
  ]

let usage = "usage: main [-s] [-i file1, -i file2, ...] [-o file]"

let () =
  (* Command line parsing *)
  Arg.parse options (fun _ -> Arg.usage options usage) usage;

  (* Check that at least one input file has been set *)
  if Hashtbl.length ifiles = 0 then begin
    Printf.eprintf "No input file given.\n";
    exit 1
  end;

  (* Open output file *)
  let oc = open_out !ofile in
  if !standalone then write_header oc;

  (* Parse the input files and write the resulting html in the output file *)
  let compile f () = 
    let ic = open_in f in
    let buffer = Lexing.from_channel ic in
    let script = Parser.file Lexer.token buffer in
    close_in ic;
    let script = Interp.interp_script script in
    Printf.fprintf oc "\n<!-- %s -->\n\n" f;
    write_script oc script in
  Hashtbl.iter compile ifiles;
  
  (* Close output file *)
  if !standalone then write_footer oc;
  close_out oc;
  exit 0

