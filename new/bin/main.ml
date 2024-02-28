(* Copy the template files, doing search and replace on EXNAME. *)
let instantiate libraryname = ()

let () =
  match Sys.argv with
  | [|_; libraryname|] -> instantiate libraryname
  | _ -> Printf.eprintf "new: unknown command line\n"
