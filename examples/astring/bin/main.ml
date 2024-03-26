(* Char module *)
let go_char () =
  ()

(* String module, basics. *)
let go_string_1 () =
  ()

(* No-copy substrings *)
let go_string_2 () =
  ()

(* Traversing strings *)
let go_string_3 () =
  ()

let () =
  match Sys.argv with
  | [|_; "char"|] -> go_char ()
  | [|_; "string1"|] -> go_string_1 ()
  | [|_; "string2"|] -> go_string_2 ()
  | [|_; "string3"|] -> go_string_3 ()
  | _ -> Printf.eprintf "astring example: unknown command line\n"
