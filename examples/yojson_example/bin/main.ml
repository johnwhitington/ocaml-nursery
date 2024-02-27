let contents_of_file filename =
  let ch = open_in_bin filename in
    try
      let s = really_input_string ch (in_channel_length ch) in
        close_in ch;
        s
    with
      e -> close_in ch; raise e

(* Create some JSON in line as a string *)
let json_string =
  {|{"Number" : 1,
     "String" : "yes",
     "List": ["containing", "different", "types", 35.4]}|}

(* Print as parse tree *)
let print_parse_tree () =
  Format.printf "%a\n" Yojson.Safe.pp (Yojson.Safe.from_string json_string)
  
(* Print as JSON *)
let prettyprint () =
  Printf.printf "%s\n" (Yojson.Safe.pretty_to_string (Yojson.Safe.from_string json_string))

(* Read some JSON from a file, and add up all numbers in it. *)
let sum_floats = List.fold_left ( +. ) 0.

let rec sum_json : Yojson.Safe.t -> float = function
  | `Float f -> f
  | `Int i -> float_of_int i
  | `String _ -> 0.
  | `List l -> sum_floats (List.map sum_json l)
  | `Assoc l -> sum_floats (List.map sum_json (List.map snd l))
  | _ -> failwith "unexpected construct in sum_json"
  
let sum filename =
  Printf.printf "%f\n" (sum_json (Yojson.Safe.from_string (contents_of_file filename)))

(* Read some JSON from a file, and process it and produce new JSON, and write to file. *)
let process in_filename out_filename = ()

(* 6. Different kinds of JSON *)

(* 7. Dealing with errors *)

(* 8. Different kinds of prettyprinting *)

let () =
  match Sys.argv with
  | [|_; "print_parse_tree"|] -> print_parse_tree ()
  | [|_; "prettyprint"|] -> prettyprint ()
  | [|_; "sum"; filename|] -> sum filename
  | [|_; "process"; in_filename; out_filename|] -> process in_filename out_filename
  | _ -> Printf.eprintf "yojson_example: unknown command line\n"
