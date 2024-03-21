(* The OCaml manual recommends using open on the top-level Bigarray module *)
open Bigarray

(* Bigarray is a module for numerical arrays of unlimited size and various
   dimensions, with the ability to interact without copying with C and FORTRAN
   programs, space-efficient memory layout and some interesting non-copy
   operations such as extracting subarrays. *)

(* One-dimensional bigarrays *)

(* Print an array of integers *)
let print_ints a =
  for x = 0 to Array1.dim a - 1 do
    (* The .{} syntax accesses a Bigarray element. Array1.get is the alternative. *)
    Printf.printf " %i" a.{x}
  done;
  print_string "\n"

let go_1 () =
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

(* 2D bigarrays *)
let print_2d a =
  for x = 1 to Array2.dim1 a do (* We are in FORTRAN mode, arrays start at 1! *)
    for y = 1 to Array2.dim2 a do (* Array2.dim<n> functions return the dimensions. *)
      Printf.printf " %Li" a.{x, y}
    done;
    print_string "\n"
  done

let print_int64s a =
  for x = 0 to Array1.dim a - 1 do Printf.printf " %Li" a.{x} done;
  print_string "\n"

let go_2 () = 
  (* Initialise a 2D array in Fortran_layout *)
  let a = Array2.init Int64 Fortran_layout 5 3 (fun x y -> Int64.mul (Int64.of_int x) (Int64.of_int y)) in
    print_string "a:\n";
    print_2d a;
  (* We can create an equivalent C layout bigarray with no copying *)
  let b = Array2.change_layout a C_layout in
  let size = Array2.size_in_bytes b in
    Printf.printf "The data in our 2D array takes up %i bytes\n" size;
  (* Pull a slice from our C layout bigarray, no copying involved *)
  let slice = Array2.slice_left b 0 in
  print_string "slice:";
  print_int64s slice;
  (* Build an Array2 from an ordinary OCaml matrix (array of arrays). Note that
     the sharing in the original array is destroyed. *)
  let from_array = Array2.of_array Int64 Fortran_layout (let x = [|0L; 1L; 2L|] in [|x; x; x|]) in
  print_string "from_array:\n";
  print_2d from_array

(* 3D bigarrays *)
let go_3 () =
  (* An exercise for the reader... *)
  ()

(* bigarrays with any number of dimensions 0..16 *)
let go_gen () =
  (* Initialise a Genarray of four dimensions of size 2, 3, 4 and 5. *)
  let a = Genarray.init Int C_layout [|2; 3; 4; 5|] (Array.fold_left ( + ) 0) in
  (* Print it out *)
  print_string "a:";
  for p = 0 to Genarray.nth_dim a 0 - 1 do
  for q = 0 to Genarray.nth_dim a 1 - 1 do
  for r = 0 to Genarray.nth_dim a 2 - 1 do
  for s = 0 to Genarray.nth_dim a 3 - 1 do
    Printf.printf " %i" (Genarray.get a [|p; q; r; s|])
  done
  done
  done
  done;
  print_string "\n";
  (* Reshape to a one dimensional Genarray *)
  let b = reshape a [|2 * 3 * 4 * 5|] in 
  (* Convert to an Array1 *)
  let c = array1_of_genarray b in
  (* Now we can print it with our print_ints function *)
  print_string "c:";
  print_ints c

let () =
  match Sys.argv with
  | [|_; "1"|] | [|_|] -> go_1 ()
  | [|_; "2"|] -> go_2 ()
  | [|_; "3"|] -> go_3 ()
  | [|_; "gen"|] -> go_gen ()
  | _ -> Printf.eprintf "bigarray example: unknown command\n"
