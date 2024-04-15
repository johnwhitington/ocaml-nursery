let go () = ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "fileutils example: unknown command line\n"
