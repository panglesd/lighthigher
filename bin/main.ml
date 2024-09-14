(* let els = *)
(*   Brr.El.fold_find_by_selector *)
(*     (fun elem acc -> elem :: acc) *)
(*     (Jstr.v "pre>code[class^='language-']") *)
(*     [] *)

(* let _j, local_infos, txt = Lighthigher.deconstruct el *)
(* let () = Format.printf "Txt is: %s\n%!" txt *)
(* let () = Lighthigher.print_infos local_infos *)
(* let () = print_endline "Hello, World2!" *)


(* let () = List.iter Lighthigher.hl els *)

let lh f elem = Lighthigher.hl f elem

let () = Jv.set Jv.global "lighthigh" (Jv.callback ~arity:2 lh)
