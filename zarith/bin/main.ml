let integers () =
  (* Build something bigger than an OCaml int can hold. *)
  let z = Z.of_int max_int in
  let bigz = Z.mul z z in
    print_endline (Z.to_string bigz);
  (* Go even bigger *)
  let biggerz = Z.shift_left z 100 in
    print_endline (Z.to_string biggerz);
    Printf.printf "This has %i significant bits, of which %i are set\n" (Z.numbits biggerz) (Z.popcount biggerz);
    Printf.printf "Does it fit in an Int64.t? %b\n" (Z.fits_int64 biggerz);
    (* Logarithm (as an int, because it is small) *)
    Printf.printf "Logarithm, base two: %i\n" (Z.log2 biggerz);
    (* Prime just larger than this (probably) *)
    Printf.printf "Next prime... %s\n" (Z.to_string (Z.nextprime biggerz));
    (* There are alternative printers: *)
    print_endline "Decimal:";
    print_endline (Z.format "%i" biggerz);
    print_endline "Octal:";
    print_endline (Z.format "%o" biggerz);
    print_endline "Binary:";
    print_endline (Z.format "%b" biggerz);
    print_endline "Hexadecimal:";
    print_endline (Z.format "%0#X" biggerz)

let rationals () =
  ()

let () =
  match Sys.argv with
  | [|_|] -> integers ()
  | [|_; "rationals"|] -> rationals ()
  | _ -> Printf.eprintf "zarith example: unknown command line\n"
