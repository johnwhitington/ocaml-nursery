let go () =
  (* A Hex value is represented internally as `Hex string *)
  Printf.printf "of_char: %c%c\n" (fst (Hex.of_char 'A')) (snd (Hex.of_char 'A'));
  Printf.printf "to_char: %C\n" (Hex.to_char '4' '1');
  Printf.printf "of_string: `Hex %S\n"
    (match (Hex.of_string "ABCDE") with `Hex x -> x);
  Printf.printf "to_string: %S\n" (Hex.to_string (`Hex "4142434445"));
  Printf.printf "show: %S\n" (Hex.show (`Hex "4142434445"));
  (* similar functions for bytes, cstrict, and bigstring also exist. *)
  Hex.hexdump (Hex.of_string "Mary had a little lamb; its fleece was white as snow.")

let () = go ()
