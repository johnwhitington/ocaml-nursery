let go () =
  let z = Z.zero in
    ()

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "zarith example: unknown command line\n"
