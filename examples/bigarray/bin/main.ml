(* The OCaml manual recommends using open on the top-level Bigarray module *)
open Bigarray

(* Print an array of integers *)
let print_ints a =
  for x = 0 to Array1.dim a - 1 do
    (* The .{} syntax accesses a Bigarray element. Array1.get is the alternative. *)
    Printf.printf " %i" a.{x}
  done;
  print_string "\n"

(* Document C_layout choice. *)

let go () =
  (* Create a one-dimensional bigarray, in C format, to store bytes *)
  let a = Array1.create Int8_unsigned C_layout 10 in
    (* Initial contents is unspecified. Let's fill in zeroes *)
    Array1.fill a 0;
    (* And print with our print_ints function *)
    print_string "a:";
    print_ints a;
  (* Alternatively, initialise one with a function. *)
  let b = Array1.init Int8_unsigned C_layout 10 (fun x -> x * 5) in
    print_string "b:";
    print_ints b;
  (* Alternativey, build it from a normal OCaml array. *)
  let c = Array1.of_array Int8_unsigned C_layout [|1; 2; 4; 8; 16; 32; 64; 128; 256|] in
    print_string "c:";
    print_ints c;
    (* (Note that 256 could not be stored in an 8 bit integer, so we see 0.) *)
    for x = 0 to Array1.dim c - 1 do
      c.{x} <- c.{x} / 2
    done;
    print_string "c, halved:";
    print_ints c;
  let d = Array1.sub c 2 3 in
    print_string "using sub, d is:";
    print_ints d;
    d.{0} <- 50;
    print_string "after writing, c is:";
    print_ints c;
    print_string "after writing, d is:";
    print_ints d;
    print_string "50 is in both, so you can see that no copying happened with Array1.sub\n"


(* 2D Arrays *)
(* Slices *)
(* 3D Arrays *)
(* Genarray *)
(* Reshaping *)

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "bigarray example: unknown command Array1.init Int C_layout 100 (fun _ -> 1);;line\n"
