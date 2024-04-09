(* ppx_expect doesn't work on executables, so this is a library. Run with
   "dune runtest" rather than "dune exec" *)

let%expect_test "addition" =
  Printf.printf "%d" (1 + 2);
  [%expect {| 4 |}]
