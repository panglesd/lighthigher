open Webapi

external replaceChildren : Dom.Node.t array -> unit = "replaceChildren"
[@@mel.variadic] [@@mel.send.pipe: Dom.Element.t]

type 'info local_info = { start : int; finish : int; payload : 'info }

let print_local_info { start; finish; payload } =
  Js.log [ ("start = ", start, "finish = ", finish, "payload = ", payload) ]

let print_infos infos = List.iter print_local_info infos
let () = ignore print_infos
let is_el node = Dom.Node.nodeType node = Dom.Element

let parse_infos payload element =
  let rec loop element acc =
    let children = Dom.Element.childNodes element |> Dom.NodeList.toArray in
    Array.fold_left
      (fun (i, acc, txt) child ->
        let j, acc, txt =
          if is_el child then
            loop (Dom.Element.ofNode child |> Option.get) (i, acc, txt)
          else
            let child = Dom.Text.ofNode child |> Option.get in
            let new_txt = Dom.Text.textContent child in
            let j = i + String.length new_txt in
            (j, acc, new_txt :: txt)
        in
        let acc =
          match payload child txt with
          | None -> acc
          | Some payload ->
              let elem = { start = i; finish = j; payload } in
              elem :: acc
        in
        (j, acc, txt))
      acc children
  in
  let _, payload, text = loop element (0, [], []) in
  (payload, String.concat "" (List.rev text))

let deconstruct element =
  let payload node text =
    if is_el node then None
    else
      let node = Dom.Text.ofNode node |> Option.get in
      let text = text |> String.concat "" in
      let new_elem = Dom.Document.createElement "span" Dom.document in
      let new_text = Dom.Document.createTextNode text Dom.document in
      let () = Dom.Element.appendChild new_text new_elem in
      let parent = Dom.Text.parentElement node |> Option.get in
      let _ = Dom.Element.replaceChild new_elem node parent in
      Some new_elem
  in
  parse_infos payload element

let deconstruct_classes element =
  let payload node _text =
    if is_el node then
      let child = Dom.Element.ofNode node |> Option.get in
      Some (Dom.Element.className child)
    else None
  in
  parse_infos payload element

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
  let plain_code = function
    | "" -> []
    | s -> [ Dom.Document.createTextNode s Dom.document |> Dom.Text.asNode ]
  in
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
        (* TODO: do                [a  [b  b]a][b b] *)
        let initial = plain_code (get_src from loc_start) in
        let next, q = extract loc_start loc_end q [] in
        let aux =
          let at = classes in
          let children = List.rev next in
          let span = Dom.Document.createElement "span" Dom.document in
          List.iter (fun c -> Dom.Element.appendChild c span) children;
          Dom.Element.setClassName span at;
          [ span |> Dom.Element.asNode ] @ initial @ aux
        in
        extract loc_end to_ q aux
    | q -> (plain_code (get_src from to_) @ aux, q)
  in
  let rec extract_divs div_list tm_list =
    match div_list with
    | { start = loc_start; finish = loc_end; payload = e } :: q ->
        let next, tm_list = extract loc_start loc_end tm_list [] in
        let () = replaceChildren (List.rev next |> Array.of_list) e in
        extract_divs q tm_list
    | _ -> ()
  in
  extract_divs div_infos tmate_infos

let hl f element =
  let div_infos, txt = deconstruct element in
  let new_elem = Dom.Document.createElement "div" Dom.document in
  let s = f txt in
  Dom.Element.setInnerHTML new_elem s;
  let tmate_infos, _ = deconstruct_classes new_elem in
  do_infos ~div_infos ~tmate_infos txt

let () = [%mel.raw "window.lighthigh = hl"]
