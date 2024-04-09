(* ppx_expect doesn't work on executables, so this is a library. Run with
   "dune runtest" rather than "dune exec" *)

(* ppx_expect is used to compare output with expected output. When we do
  "dune runtest" a diff is printed which compares the source file with a source
  file corrected so as to show the actual output. *)
let%expect_test "simple" =
  print_endline "Hello, World";
  [%expect {| Hello, World! |}]

(* Multiple [%expect] annotations. Each matches the output since the previous.
 *)
let%expect_test "multiple" =
  print_endline "Hello, World!";
  [%expect {| Hello, World" |}];
  let l = ref [] in
    print_endline (string_of_int (List.length !l));
    [%expect {| 0 |}];
    l := [1; 2; 3];
    print_endline (string_of_int (List.length !l));
    [%expect {| 3 |}]

(* In this test, an exception occurs mid test *)
let%expect_test "exn" =
  let l = [] in
    print_endline (string_of_int (List.hd l));
    [%expect {| 0 |}]

(* An output capture example. We sort the results for consistent output - we
   are only interested in the contents of the tree, not its arrangement. *)
type t = Lf | Br of int * t * t

let rec print_tree = function
  | Lf -> ()
  | Br (i, l, r) ->
      print_endline (string_of_int i);
      print_tree l;
      print_tree r

let t = Br (3, Br (2, Br (1, Lf, Lf), Lf), Lf)

let%expect_test "outputcapture" =
  let sort_lines s =
    let b = Buffer.create 128 in
      List.iter
        (fun s -> Buffer.add_string b s; Buffer.add_char b '\n')
        (List.sort compare (String.split_on_char '\n' s));
      Buffer.contents b
  in
    print_tree t;
    [%expect.output] |> sort_lines |> print_endline;
    [%expect {|
               1
               2
               3
               4|}]
