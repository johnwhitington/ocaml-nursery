(* Copy the template files, doing search and replace on EXNAME. *)

(* Replace all instances of x with x' in s *)
let string_replace_all x x' s =
  if x = "" then s else
    let p = ref 0
    and slen = String.length s
    and xlen = String.length x in
      let output = Buffer.create (slen * 2) in
        while !p < slen do
          try
            if String.sub s !p xlen = x
              then (Buffer.add_string output x'; p := !p + xlen)
              else (Buffer.add_char output s.[!p]; incr p)
          with
            _ -> Buffer.add_char output s.[!p]; incr p
        done;
        Buffer.contents output

(* Get a file as a string *)
let contents_of_file filename =
  let ch = open_in_bin filename in
    try
      let s = really_input_string ch (in_channel_length ch) in
        close_in ch;
        s
    with
      e -> close_in ch; raise e

let directory path =
  Printf.printf "dir %S\n" path;
  Sys.mkdir path 0o755

let file fromname toname exname =
  Printf.printf "file %S %S\n" fromname toname;
  let str = contents_of_file fromname in
  let str' = string_replace_all "EXNAME" exname str in
  let fh = open_out_bin toname in
    output_string fh str';
    close_out fh

let instantiate exname =
  let p = Filename.parent_dir_name in
  let c = Filename.concat in
    directory (c (c p "examples") exname);
    directory (c (c (c p "examples") exname) "bin");
    file (c (c p "template") "README.md") (c (c (c p "examples") exname) "README.md") exname;
    file (c (c p "template") "dune-project") (c (c (c p "examples") exname) "dune-project") exname;
    file (c (c p "template") "dune-workspace") (c (c (c p "examples") exname) "dune-workspace") exname;
    file (c (c (c p "template") "bin") "dune") (c (c (c (c p "examples") exname) "bin") "dune") exname;
    file (c (c (c p "template") "bin") "main.ml") (c (c (c (c p "examples") exname) "bin") "main.ml") exname

let () =
  match Sys.argv with
  | [|_; exname|] -> instantiate exname
  | _ -> Printf.eprintf "new: unknown command line\n"
