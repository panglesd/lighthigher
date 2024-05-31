let token_stream_to_infos (s : Ocaml_prism.Token.stream) =
  let rec continue acc i toks =
    match toks with
    | [] -> (acc, i)
    | Ocaml_prism.Token.String s :: toks ->
        let i = i + String.length (Jstr.to_string s) in
        continue acc i toks
    | Token { type_; content = String s } :: toks ->
        let finish = i + String.length (Jstr.to_string s) in
        let acc =
          Types.{ start = i; finish; payload = Jstr.to_string type_ } :: acc
        in
        continue acc finish toks
    | Token { type_; content = Ocaml_prism.Token.Stream s } :: toks ->
        let acc, finish = continue acc i (Array.to_list s) in
        let acc =
          Types.{ start = i; finish; payload = Jstr.to_string type_ } :: acc
        in
        continue acc finish toks
  in

  fst @@ continue [] 0 (Array.to_list s)

let to_infos grammar txt =
  let tokens = Ocaml_prism.tokenize (Jstr.v txt) grammar in
  token_stream_to_infos tokens
