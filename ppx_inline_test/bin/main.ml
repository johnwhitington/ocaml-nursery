(* ppx_inline_test doesn't work on executables, so this is a library. Run with
   "dune runtest" rather than "dune exec" *)

let rec broken = function
  | ([], []) -> []
  | (x::xs, []) -> xs
  | ([], ys) -> ys
  | (x::xs, y::ys) -> x::y::broken (xs, ys)

let%test _ = broken ([], []) = []

let%test _ = broken ([1; 2; 3], [4; 5; 6]) = [1; 4; 2; 5; 3; 6]

let%test _ = broken ([1; 2; 3], [4; 5]) = [1; 4; 2; 5; 3] (* bug! *)

let%test _ = broken ([1; 2], [3; 4; 5]) = [1; 3; 2; 4; 5]
