open Sexplib      (* For Sexplib.Sexp.to_string *)
open Sexplib.Std  (* To bring int_of_sexp etc required by [@@deriving sexp] *)

(* Define a tree type, adding an @@deriving annotation *)
type tree =
  | Lf
  | Br of tree * int * tree [@@deriving sexp]

(* This will be rendered as sexp as follows:

      - The int will be converted to a Sexp.Atom using string_of_int
      - The constructors Lf and Br will be converted to Sexp.Atoms
      - Br values will be Sexp.List of the three values (the left
        tree, the integer, the right tree)
   
   Two functions, sexp_of_tree and tree_of_sexp will be generated
   automatically. *)

let rec sum = function
  | Lf -> 0
  | Br (l, x, r) -> sum l + x + sum r

let go () =
  (* Use the automatically-generated function sexp_of_tree to print our tree *)
  print_endline (Sexp.to_string (sexp_of_tree (Br (Lf, 1, Br (Lf, 4, Lf)))));
  (* Use the automatically-generated function tree_of_sexp to sum a sexp *)
  let tree =
    tree_of_sexp (List [Atom "Br";
                        List [Atom "Br"; Atom "Lf"; Atom "7"; Atom "Lf"];
                        Atom "10";
                        List [Atom "Br"; Atom "Lf"; Atom "12"; Atom "Lf"]])
  in
    Printf.printf "sum: %i\n" (sum tree)

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "ppx_sexp_conv example: unknown command line\n"
