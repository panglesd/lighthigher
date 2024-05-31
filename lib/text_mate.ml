open Types

let ocaml_grammar = TmLanguage.of_yojson_exn Language_jsons.ocaml

let ocaml_interface_grammar =
  TmLanguage.of_yojson_exn Language_jsons.ocaml_interface

let t =
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t ocaml_interface_grammar;
  TmLanguage.add_grammar t ocaml_grammar;
  t

let rec highlight_tokens start i spans = function
  | [] -> (spans, start + i)
  | tok :: toks -> (
      let j = TmLanguage.ending tok in
      assert (j > i);
      match TmLanguage.scopes tok with
      | [] -> highlight_tokens start j spans toks
      | scopes ->
          highlight_tokens start j
            ({ start = start + i; finish = start + j; payload = scopes }
            :: spans)
            toks)

let highlight_string t grammar stack str =
  let lines = String.split_on_char '\n' str in
  let rec loop i stack acc = function
    | [] -> List.rev acc
    | line :: lines ->
        (* Some patterns don't work if there isn't a newline *)
        let line = line ^ "\n" in
        let tokens, stack = TmLanguage.tokenize_exn t grammar stack line in
        let spans, tot = highlight_tokens i 0 [] tokens in
        loop tot stack (spans :: acc) lines
  in
  List.concat @@ loop 0 stack [] lines

let syntax_highlighting_locs src =
  try highlight_string t ocaml_grammar TmLanguage.empty src
  with TmLanguage.Error _ -> (* TODO: propertly report the error *) []
