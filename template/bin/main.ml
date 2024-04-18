let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "template example: unknown command line\n"
