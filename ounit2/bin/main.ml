(* The authors recommend opening the module, which brings the operators and
   functions into scope. *)
open OUnit2

let l = [1; 2; 3]
let l2 = [4; 5; 6]

let rec append a b =
  match a with
  | [] -> b
  | h::t -> h::append t b

let rec broken_append a b =
  match a with
  | [] -> []
  | h::t -> h::broken_append t b

(* A simple passing test *)
let test_append _ =
  assert_equal (append l l2) [1; 2; 3; 4; 5; 6];
  assert_equal (append [] l) l;
  assert_bool "message when this test fails" (append l [] = l)
  (* Also assert_string, assert_failure, assert_command etc. *)

(* A simple failing test *)
let test_broken_append _ =
  assert_equal (broken_append l l2) [1; 2; 3; 4; 5; 6]

(* >:: names a test. Then we put them in named groups, for organization with
   >:::. *)
let suite =
  "ExampleTests" >:::
    ["test_append" >:: test_append;
     "test_broken_append" >:: test_broken_append]

(* Run the test suite. *)
let go () =
  run_test_tt_main suite

let () = go ()
