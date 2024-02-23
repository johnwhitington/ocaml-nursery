let contents_of_file filename =
  let ch = open_in_bin filename in
    try
      let s = really_input_string ch (in_channel_length ch) in
        close_in ch;
        s
    with
      e -> close_in ch; raise e

let () =
  match Sys.argv with
  | [|_; "printparsed"; filename|] ->
      Format.printf "Parsed: %a" Yojson.Safe.pp (Yojson.Safe.from_string (contents_of_file filename))
  | _ -> Printf.eprintf "yojson_example: unknown command line\n"
