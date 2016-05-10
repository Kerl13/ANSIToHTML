open Types

let default_fg = Hex "FFFFFF"
let default_bg = Hex "111111"

let (%) n k =
  let r = n mod k in
  if r < 0 then r + k else r

let calc factor = function
  | 0 -> 0
  | n -> (n/factor)*40 + 55

let color256 = function
  (* Primary 3-bit (8 colors) *)
  | 0 -> Hex "000000"
  | 1 -> Hex "dc0000"
  | 2 -> Hex "00cd00"
  | 3 -> Hex "cdcd00"
  | 4 -> Hex "0000ee"
  | 5 -> Hex "cd00cd"
  | 6 -> Hex "00cdcd"
  | 7 -> Hex "e5e5e5"
  (* Equivalent "bright" versions of original 8 colors *)
  | 08 -> Hex "7f7f7f"
  | 09 -> Hex "ff0000"
  | 10 -> Hex "00ff00"
  | 11 -> Hex "ffff00"
  | 12 -> Hex "5c5cff"
  | 13 -> Hex "ff00ff"
  | 14 -> Hex "00ffff"
  | 15 -> Hex "ffffff"
  (* 8-bit *)
  | n when (n > 15 && n < 232) ->
      let n = n - 16 in
      let b' = n % 6 in let b = calc 1 b' in
      let g' = (n-b')%36 in let g = calc 6 g' in
      let r' = n-b'-g' in let r = calc 36 r' in
      Hex (Printf.sprintf "%02x%02x%02x" r g b)
  (* Grey scale *)
  | 232 -> Hex "080808"
  | 233 -> Hex "121212"
  | 234 -> Hex "1c1c1c"
  | 235 -> Hex "262626"
  | 236 -> Hex "303030"
  | 237 -> Hex "3a3a3a"
  | 238 -> Hex "444444"
  | 239 -> Hex "4e4e4e"
  | 240 -> Hex "585858"
  | 241 -> Hex "626262"
  | 242 -> Hex "6c6c6c"
  | 243 -> Hex "767676"
  | 244 -> Hex "808080"
  | 245 -> Hex "8a8a8a"
  | 246 -> Hex "949494"
  | 247 -> Hex "9e9e9e"
  | 248 -> Hex "a8a8a8"
  | 249 -> Hex "b2b2b2"
  | 250 -> Hex "bcbcbc"
  | 251 -> Hex "c6c6c6"
  | 252 -> Hex "d0d0d0"
  | 253 -> Hex "dadada"
  | 254 -> Hex "e4e4e4"
  | 255 -> Hex "eeeeee"
  | n -> raise (Invalid_argument ("Color256: "^(string_of_int n)))

