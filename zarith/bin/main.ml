let go () =
  (* Build something bigger than an OCaml int can hold. *)
  let z = Z.of_int max_int in
  let bigz = Z.mul z z in
    print_endline (Z.to_string bigz);
  (* Go even bigger *)
  let biggerz = Z.shift_left z 100 in
    print_endline (Z.to_string biggerz);
    Printf.printf "This has %i significant bits, of which %i are set\n" (Z.numbits biggerz) (Z.popcount biggerz);
    Printf.printf "Does it fit in an Int64.t? %b\n" (Z.fits_int64 biggerz);
    (* Prime just larger than this (probably) *)
    Printf.printf "Next prime... %s\n" (Z.to_string (Z.nextprime biggerz))

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "zarith example: unknown command line\n"
