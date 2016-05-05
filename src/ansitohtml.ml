let () =
  let ic = open_in "test/test.ansi" in
  let buf = Lexing.from_channel ic in
  let script = Parser.file Lexer.token buf in
  let script = Interp.interp_script script in
  Writer.write_script stdout script

