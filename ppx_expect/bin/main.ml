let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go  ()
  | _ -> Printf.eprintf "ppx_expect example: unknown command line\n"
