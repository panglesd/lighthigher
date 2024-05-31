let el = Brr.El.find_first_by_selector (Jstr.v "#elem") |> Option.get
let _j, local_infos, txt = Lighthigher.deconstruct el
let () = Format.printf "Txt is: %s\n%!" txt
let () = Lighthigher.print_infos local_infos
let () = print_endline "Hello, World2!"
