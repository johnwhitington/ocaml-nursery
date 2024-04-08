let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "astring example: unknown command line\n"
