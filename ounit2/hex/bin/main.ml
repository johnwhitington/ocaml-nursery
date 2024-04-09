let go () =
  Printf.printf "of_char: %c%c\n" (fst (Hex.of_char 'A')) (snd (Hex.of_char 'A'));
  Printf.printf "to_char: %C\n" (Hex.to_char '4' '1');
  Printf.printf "of_string: `Hex %S\n"
    (match (Hex.of_string "ABCDE") with `Hex x -> x);
  Printf.printf "to_string: %S\n" (Hex.to_string (`Hex "4142434445"));
  (* similar functions for bytes, cstrict, and bigstring also exist. *)
  Hex.hexdump (Hex.of_string "Mary had a little lamb; it's fleece was white as snow.")

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "hex example: unknown command line\n"
