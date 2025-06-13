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
  (* The printable ASCII charcters as a string, using String.v (which
     initialises a string based on a length and an int -> char function. *)
  let all = String.v ~len:(126 - 32 + 1) (fun x -> Char.of_byte (x + 32)) in
  (* We can print astrings just like normal OCaml strings with %s. *)
  Printf.printf "ASCII Printables: %s\n" all;
  (* And access their members normally too: *)
  Printf.printf "The tenth place is '%c'\n" all.[10];
  (* And use string literals as astrings: *)
  let infix = String.is_infix ~affix:"1234567890" all in
  Printf.printf "1234567890 in the string? %b\n" infix;
  (* Extract a substring of an existing string. NB: In go_string_2 we'll see how
  to use Astring's own substrings to do this more efficiently, without copying. *)
  let upper_case = String.with_index_range ~first:(65 - 32) ~last:(65 - 32 + 26 - 1) all in
  Printf.printf "Upper case: %s\n" upper_case;
  (* String.cut will gives what comes on either side of a substring: *)
  match String.cut ~sep:"Q" upper_case with
  | Some (before, after) -> Printf.printf "Before Q: %s, after Q: %s\n" before after
  | _ -> assert false

(* No-copy substrings *)
let go_string_2 () =
  (* The printable ASCII character as a string, as in go_string_1 above. *)
  let all = String.v ~len:(126 - 32 + 1) (fun x -> Char.of_byte (x + 32)) in
  (* Take a substring. Note that ~stop here is different from ~last in go_string_1 *)
  let sub = String.Sub.v ~start:(65 - 32) ~stop:(65 - 32 + 26) all in
  (* (We could also have used String.sub, which is the same thing) *)
  Printf.printf "sub: %s\n" (String.Sub.to_string sub);
  (* Here is the diagram from the documentation:
       positions  0   1   2   3   4    l-1    l
                  +---+---+---+---+     +-----+
         indices  | 0 | 1 | 2 | 3 | ... | l-1 |
                  +---+---+---+---+     +-----+ 
     In String.sub, for example, 'start' and 'stop' are positions. *)
  (* Or, to print without copying *)
  Printf.printf "sub printed without copying: ";
  for x = 0 to String.Sub.length sub - 1 do Printf.printf "%c" (String.Sub.get sub x) done;
  Printf.printf "\n"

(* Traversing strings *)
let go_string_3 () =
  (* The printable ASCII character as a string, as in go_string_1 above. *)
  let all = String.v ~len:(126 - 32 + 1) (fun x -> Char.of_byte (x + 32)) in
  (* Finding a character *)
  let first_alpha = String.find Char.Ascii.is_alphanum all in
  Printf.printf "first_alpha: %s\n" (match first_alpha with Some x -> string_of_int x | None -> "");
  (* Finding a string *)
  let abc = String.find_sub ~sub:"abc" all in
  Printf.printf "abc: %s\n" (match abc with Some x -> string_of_int x | None -> "");
  (* Mapping *)
  let blanked = String.map (fun x -> if Char.Ascii.is_alphanum x then x else ' ') all in
  Printf.printf "blanked: %s\n" blanked;
  (* Filtering *)
  let alphanumeric = String.filter Char.Ascii.is_alphanum all in
  Printf.printf "alphanumeric: %s\n" alphanumeric

let () =
  match Sys.argv with
  | [|_; "char"|] -> go_char ()
  | [|_; "string1"|] -> go_string_1 ()
  | [|_; "string2"|] -> go_string_2 ()
  | [|_; "string3"|] -> go_string_3 ()
  | _ -> Printf.eprintf "astring example: unknown command line\n"
