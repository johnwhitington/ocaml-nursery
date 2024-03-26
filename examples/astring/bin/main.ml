(* It's recommended to use open here. This introduces strf, replaces ^ and the
   Char and String modules. *)
open Astring

(* Char module, which represents single bytes (i.e 0x00...0xFF). *)
let go_char () =
  let c1 = Char.of_byte 65 in
  let c2 = Char.of_byte 92 in
  let c3 = Char.of_byte 255 in
    Printf.printf
      "c1 = %s, c2 = %s, c3 = %s\n"
      (Char.Ascii.escape c1) (Char.Ascii.escape c2) (Char.Ascii.escape c3);
    Printf.printf
      "which are ASCII? c1 %b, c2 %b, c3 %b\n"
      (Char.Ascii.is_valid c1) (Char.Ascii.is_valid c2) (Char.Ascii.is_valid c3)

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
