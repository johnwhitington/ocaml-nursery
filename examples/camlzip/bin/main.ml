let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "camlzip example: unknown command line\n"
