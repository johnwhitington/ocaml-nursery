let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "easy-format example: unknown command line\n"
