let go () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "ppx_inline_test example: unknown command line\n"
