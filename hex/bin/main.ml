let go () = ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "hex example: unknown command line\n"
