type 'info local_info = { start : int; finish : int; payload : 'info }

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
          (j, elem :: acc, Jstr.to_string t :: text))
      acc children
  in
  let _, payload, text = loop element (0, [], []) in
  (payload, String.concat "" (List.rev text))

let deconstruct_classes element =
  let rec loop element acc =
    let children = Brr.El.children element in
    List.fold_left
      (fun (i, acc) child ->
        if Brr.El.is_el child then
          let j, acc = loop child (i, acc) in
          let classes = Brr.El.at Brr.At.Name.class' child in
          match classes with
          | None -> (j, acc)
          | Some classes ->
              let elem = { start = i; finish = j; payload = classes } in
              (j, elem :: acc)
        else
          let t = Brr.El.txt_text child in
          let j = i + String.length (Jstr.to_string t) in
          (j, acc))
      acc children
  in
  let _, payload = loop element (0, []) in
  payload

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
            (classes |> Brr.At.class') :: [ Brr.At.class' (Jstr.v "token") ]
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

let hl f element =
  let div_infos, txt = deconstruct element in
  let new_elem = Brr.El.div [] in
  let s = Jv.apply f [| Jv.of_string txt |] in
  Jv.set (Brr.El.to_jv new_elem) "innerHTML" s;
  let tmate_infos = deconstruct_classes new_elem in
  print_infos tmate_infos;
  do_infos ~div_infos ~tmate_infos txt
