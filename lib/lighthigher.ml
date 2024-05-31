open Types

let print_local_info { start; finish; payload } =
  Brr.Console.(
    log [ ("start = ", start, "finish = ", finish, "payload = ", payload) ])

let print_infos infos = List.iter print_local_info infos

let deconstruct element =
  let rec loop element acc =
    let children = Brr.El.children element in
    List.fold_left
      (fun (i, acc, text) child ->
        if Brr.El.is_el child then loop child (i, acc, text)
        else
          let t = Brr.El.txt_text child in
          let new_elem = Brr.El.span [ Brr.El.txt t ] in
          Brr.El.insert_siblings `Replace child [ new_elem ];
          let j = i + String.length (Jstr.to_string t) in
          let elem = { start = i; finish = j; payload = new_elem } in
          (j, elem :: acc, text ^ Jstr.to_string t))
      acc children
  in
  loop element (0, [], "")

(* let impl ~infos txt = *)
(*   let l = *)
(*     infos *)
(*     |> List.sort *)
(*          (fun { start = l1; finish = e1; _ } { start = l2; finish = e2; _ } -> *)
(*            if l1 = l2 then compare e2 e1 *)
(*              (\* If two intervals open at the same time, we open *)
(*                 first the one that closes last *\) *)
(*            else compare l1 l2) *)
(*   in *)
(*   let get_src a b = *)
(*     let in_bound x = min (max x 0) (String.length txt) in *)
(*     let a = in_bound a and b = in_bound b in *)
(*     let a, b = (min a b, max a b) in *)
(*     String.sub txt a (b - a) *)
(*   in *)
(*   let plain_code = function *)
(*     | "" -> [] *)
(*     | s -> [ Types.Source_page.Plain_code s ] *)
(*   in *)
(*   let min (a : int) b = if a < b then a else b in *)
(*   let rec extract from to_ list aux = *)
(*     match list with *)
(*     | (k, (loc_start, loc_end)) :: q when loc_start < to_ -> *)
(*         let loc_end = min loc_end to_ in *)
(*         (\* In case of inconsistent [a  [b    a] b] *)
(*            we do                   [a  [b  b]a] *\) *)
(*         let initial = plain_code (get_src from loc_start) in *)
(*         let next, q = extract loc_start loc_end q [] in *)
(*         extract loc_end to_ q *)
(*           ([ Types.Source_page.Tagged_code (k, List.rev next) ] @ initial @ aux) *)
(*     | q -> (plain_code (get_src from to_) @ aux, q) *)
(*   in *)
(*   let doc, _ = extract 0 (String.length txt) l [] in *)
(*   List.rev doc *)

let do_infos ~div_infos ~tmate_infos txt =
  let compare_infos { start = l1; finish = e1; _ }
      { start = l2; finish = e2; _ } =
    if l1 = l2 then compare e2 e1
      (* If two intervals open at the same time, we open
         first the one that closes last *)
    else compare l1 l2
  in
  let sorted_insert s e =
    let rec aux s e acc =
      match s with
      | [] -> List.rev_append acc [ e ]
      | e2 :: q when compare_infos e e2 < 1 -> List.rev_append acc (e :: e2 :: q)
      | e2 :: q -> aux q e (e2 :: acc)
    in
    aux s e []
  in
  let sort_infos x = List.sort compare_infos x in
  let div_infos = sort_infos div_infos in
  let tmate_infos = sort_infos tmate_infos in

  let get_src a b =
    let in_bound x = min (max x 0) (String.length txt) in
    let a = in_bound a and b = in_bound b in
    let a, b = (min a b, max a b) in
    String.sub txt a (b - a)
  in
  let plain_code = function "" -> [] | s -> [ Brr.El.txt' s ] in
  let rec extract from to_ list aux =
    match list with
    | { start = loc_start; finish = loc_end; payload = classes } :: q
      when loc_start < to_ ->
        let loc_end, q =
          if loc_end <= to_ then (loc_end, q)
          else
            ( to_,
              sorted_insert q
                { start = to_; finish = loc_end; payload = classes } )
          (* min loc_end to_ *)
        in
        (* In case of inconsistent [a  [b    a]   b]
           we do                   [a  [b  b]a] *)
        (* TODO: do                 [a  [b  b]a][b b] *)
        let initial = plain_code (get_src from loc_start) in
        let next, q = extract loc_start loc_end q [] in
        let aux =
          let at =
            (classes |> (* List.map *) Jstr.v |> (* List.map *) Brr.At.class')
            :: [ Brr.At.class' (Jstr.v "token") ]
          in
          [ Brr.El.span ~at (List.rev next) ] @ initial @ aux
        in
        extract loc_end to_ q aux
    | q -> (plain_code (get_src from to_) @ aux, q)
  in
  let rec extract_divs div_list tm_list =
    match div_list with
    | { start = loc_start; finish = loc_end; payload = e } :: q ->
        let next, tm_list = extract loc_start loc_end tm_list [] in
        let () = Brr.El.set_children e (List.rev next) in
        extract_divs q tm_list
    | _ -> ()
  in
  extract_divs div_infos tmate_infos

(* let hilite_info_to_info = failwith "" *)

let hl element =
  let grammar =
    let classes =
      Brr.El.at (Jstr.v "class") element
      |> Option.map Jstr.to_string |> Option.value ~default:""
      |> String.split_on_char ' '
    in
    let grammar_name =
      List.find_map
        (fun s ->
          if String.starts_with s ~prefix:"language-" then
            let l = String.length "language-" in
            Some (String.sub s l (String.length s - l))
          else None)
        classes
    in
    let grammar_name = Option.value grammar_name ~default:"ocaml" in
    Ocaml_prism.Grammar.of_name grammar_name
  in
  let _, div_infos, txt = deconstruct element in
  (* let tmate_infos = Text_mate.syntax_highlighting_locs txt in *)
  let tmate_infos = Prism.to_infos grammar txt in
  do_infos ~div_infos ~tmate_infos txt
