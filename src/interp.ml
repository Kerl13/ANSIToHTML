open Types

let fail s = failwith (s^" not handled yet")

let color256 = function
  (* Primary 3-bit (8 colors) *)
  | 0 -> Hex "000000"
  | 1 -> Hex "800000"
  | 2 -> Hex "008000"
  | 3 -> Hex "808000"
  | 4 -> Hex "000080"
  | 5 -> Hex "800080"
  | 6 -> Hex "008080"
  | 7 -> Hex "c0c0c0"
  (* Equivalent "bright" versions of original 8 colors *)
  | 08 -> Hex "808080"
  | 09 -> Hex "ff0000"
  | 10 -> Hex "00ff00"
  | 11 -> Hex "ffff00"
  | 12 -> Hex "0000ff"
  | 13 -> Hex "ff00ff"
  | 14 -> Hex "00ffff"
  | 15 -> Hex "ffffff"
  (* 8-bit *)
  | 16 ->  Hex "000000"
  | 17 ->  Hex "00005f"
  | 18 ->  Hex "000087"
  | 19 ->  Hex "0000af"
  | 20 ->  Hex "0000d7"
  | 21 ->  Hex "0000ff"
  | 22 ->  Hex "005f00"
  | 23 ->  Hex "005f5f"
  | 24 ->  Hex "005f87"
  | 25 ->  Hex "005faf"
  | 26 ->  Hex "005fd7"
  | 27 ->  Hex "005fff"
  | 28 ->  Hex "008700"
  | 29 ->  Hex "00875f"
  | 30 ->  Hex "008787"
  | 31 ->  Hex "0087af"
  | 32 ->  Hex "0087d7"
  | 33 ->  Hex "0087ff"
  | 34 ->  Hex "00af00"
  | 35 ->  Hex "00af5f"
  | 36 ->  Hex "00af87"
  | 37 ->  Hex "00afaf"
  | 38 ->  Hex "00afd7"
  | 39 ->  Hex "00afff"
  | 40 ->  Hex "00d700"
  | 41 ->  Hex "00d75f"
  | 42 ->  Hex "00d787"
  | 43 ->  Hex "00d7af"
  | 44 ->  Hex "00d7d7"
  | 45 ->  Hex "00d7ff"
  | 46 ->  Hex "00ff00"
  | 47 ->  Hex "00ff5f"
  | 48 ->  Hex "00ff87"
  | 49 ->  Hex "00ffaf"
  | 50 ->  Hex "00ffd7"
  | 51 ->  Hex "00ffff"
  | 52 ->  Hex "5f0000"
  | 53 ->  Hex "5f005f"
  | 54 ->  Hex "5f0087"
  | 55 ->  Hex "5f00af"
  | 56 ->  Hex "5f00d7"
  | 57 ->  Hex "5f00ff"
  | 58 ->  Hex "5f5f00"
  | 59 ->  Hex "5f5f5f"
  | 60 ->  Hex "5f5f87"
  | 61 ->  Hex "5f5faf"
  | 62 ->  Hex "5f5fd7"
  | 63 ->  Hex "5f5fff"
  | 64 ->  Hex "5f8700"
  | 65 ->  Hex "5f875f"
  | 66 ->  Hex "5f8787"
  | 67 ->  Hex "5f87af"
  | 68 ->  Hex "5f87d7"
  | 69 ->  Hex "5f87ff"
  | 70 ->  Hex "5faf00"
  | 71 ->  Hex "5faf5f"
  | 72 ->  Hex "5faf87"
  | 73 ->  Hex "5fafaf"
  | 74 ->  Hex "5fafd7"
  | 75 ->  Hex "5fafff"
  | 76 ->  Hex "5fd700"
  | 77 ->  Hex "5fd75f"
  | 78 ->  Hex "5fd787"
  | 79 ->  Hex "5fd7af"
  | 80 ->  Hex "5fd7d7"
  | 81 ->  Hex "5fd7ff"
  | 82 ->  Hex "5fff00"
  | 83 ->  Hex "5fff5f"
  | 84 ->  Hex "5fff87"
  | 85 ->  Hex "5fffaf"
  | 86 ->  Hex "5fffd7"
  | 87 ->  Hex "5fffff"
  | 88 ->  Hex "870000"
  | 89 ->  Hex "87005f"
  | 90 ->  Hex "870087"
  | 91 ->  Hex "8700af"
  | 92 ->  Hex "8700d7"
  | 93 ->  Hex "8700ff"
  | 94 ->  Hex "875f00"
  | 95 ->  Hex "875f5f"
  | 96 ->  Hex "875f87"
  | 97 ->  Hex "875faf"
  | 98 ->  Hex "875fd7"
  | 99 ->  Hex "875fff"
  | 100 -> Hex "878700"
  | 101 -> Hex "87875f"
  | 102 -> Hex "878787"
  | 103 -> Hex "8787af"
  | 104 -> Hex "8787d7"
  | 105 -> Hex "8787ff"
  | 106 -> Hex "87af00"
  | 107 -> Hex "87af5f"
  | 108 -> Hex "87af87"
  | 109 -> Hex "87afaf"
  | 110 -> Hex "87afd7"
  | 111 -> Hex "87afff"
  | 112 -> Hex "87d700"
  | 113 -> Hex "87d75f"
  | 114 -> Hex "87d787"
  | 115 -> Hex "87d7af"
  | 116 -> Hex "87d7d7"
  | 117 -> Hex "87d7ff"
  | 118 -> Hex "87ff00"
  | 119 -> Hex "87ff5f"
  | 120 -> Hex "87ff87"
  | 121 -> Hex "87ffaf"
  | 122 -> Hex "87ffd7"
  | 123 -> Hex "87ffff"
  | 124 -> Hex "af0000"
  | 125 -> Hex "af005f"
  | 126 -> Hex "af0087"
  | 127 -> Hex "af00af"
  | 128 -> Hex "af00d7"
  | 129 -> Hex "af00ff"
  | 130 -> Hex "af5f00"
  | 131 -> Hex "af5f5f"
  | 132 -> Hex "af5f87"
  | 133 -> Hex "af5faf"
  | 134 -> Hex "af5fd7"
  | 135 -> Hex "af5fff"
  | 136 -> Hex "af8700"
  | 137 -> Hex "af875f"
  | 138 -> Hex "af8787"
  | 139 -> Hex "af87af"
  | 140 -> Hex "af87d7"
  | 141 -> Hex "af87ff"
  | 142 -> Hex "afaf00"
  | 143 -> Hex "afaf5f"
  | 144 -> Hex "afaf87"
  | 145 -> Hex "afafaf"
  | 146 -> Hex "afafd7"
  | 147 -> Hex "afafff"
  | 148 -> Hex "afd700"
  | 149 -> Hex "afd75f"
  | 150 -> Hex "afd787"
  | 151 -> Hex "afd7af"
  | 152 -> Hex "afd7d7"
  | 153 -> Hex "afd7ff"
  | 154 -> Hex "afff00"
  | 155 -> Hex "afff5f"
  | 156 -> Hex "afff87"
  | 157 -> Hex "afffaf"
  | 158 -> Hex "afffd7"
  | 159 -> Hex "afffff"
  | 160 -> Hex "d70000"
  | 161 -> Hex "d7005f"
  | 162 -> Hex "d70087"
  | 163 -> Hex "d700af"
  | 164 -> Hex "d700d7"
  | 165 -> Hex "d700ff"
  | 166 -> Hex "d75f00"
  | 167 -> Hex "d75f5f"
  | 168 -> Hex "d75f87"
  | 169 -> Hex "d75faf"
  | 170 -> Hex "d75fd7"
  | 171 -> Hex "d75fff"
  | 172 -> Hex "d78700"
  | 173 -> Hex "d7875f"
  | 174 -> Hex "d78787"
  | 175 -> Hex "d787af"
  | 176 -> Hex "d787d7"
  | 177 -> Hex "d787ff"
  | 178 -> Hex "d7af00"
  | 179 -> Hex "d7af5f"
  | 180 -> Hex "d7af87"
  | 181 -> Hex "d7afaf"
  | 182 -> Hex "d7afd7"
  | 183 -> Hex "d7afff"
  | 184 -> Hex "d7d700"
  | 185 -> Hex "d7d75f"
  | 186 -> Hex "d7d787"
  | 187 -> Hex "d7d7af"
  | 188 -> Hex "d7d7d7"
  | 189 -> Hex "d7d7ff"
  | 190 -> Hex "d7ff00"
  | 191 -> Hex "d7ff5f"
  | 192 -> Hex "d7ff87"
  | 193 -> Hex "d7ffaf"
  | 194 -> Hex "d7ffd7"
  | 195 -> Hex "d7ffff"
  | 196 -> Hex "ff0000"
  | 197 -> Hex "ff005f"
  | 198 -> Hex "ff0087"
  | 199 -> Hex "ff00af"
  | 200 -> Hex "ff00d7"
  | 201 -> Hex "ff00ff"
  | 202 -> Hex "ff5f00"
  | 203 -> Hex "ff5f5f"
  | 204 -> Hex "ff5f87"
  | 205 -> Hex "ff5faf"
  | 206 -> Hex "ff5fd7"
  | 207 -> Hex "ff5fff"
  | 208 -> Hex "ff8700"
  | 209 -> Hex "ff875f"
  | 210 -> Hex "ff8787"
  | 211 -> Hex "ff87af"
  | 212 -> Hex "ff87d7"
  | 213 -> Hex "ff87ff"
  | 214 -> Hex "ffaf00"
  | 215 -> Hex "ffaf5f"
  | 216 -> Hex "ffaf87"
  | 217 -> Hex "ffafaf"
  | 218 -> Hex "ffafd7"
  | 219 -> Hex "ffafff"
  | 220 -> Hex "ffd700"
  | 221 -> Hex "ffd75f"
  | 222 -> Hex "ffd787"
  | 223 -> Hex "ffd7af"
  | 224 -> Hex "ffd7d7"
  | 225 -> Hex "ffd7ff"
  | 226 -> Hex "ffff00"
  | 227 -> Hex "ffff5f"
  | 228 -> Hex "ffff87"
  | 229 -> Hex "ffffaf"
  | 230 -> Hex "ffffd7"
  | 231 -> Hex "ffffff"
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
  | 37::codes ->  style.color <- LightGray;
                  interp_style style codes
  | 39::codes ->  style.color <- White;
                  interp_style style codes
  | 90::_ | 92::_ | 93::_ | 94::_ | 95::_ | 96::_ -> fail "Light ..."
  | 91::codes ->  style.color <- LightRed;
                  interp_style style codes
  | 97::codes ->  style.color <- White;
                  interp_style style codes
  (* Background TODO *)
  | 41::codes ->  style.bg <- Red;
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

