(* Parts modified from Upstream Zarith with license
   https://github.com/ocaml/Zarith/blob/master/LICENSE therefore this whole
   file falls under that license. *)

let integers () =
  (* Build something bigger than an OCaml int can hold. *)
  let z = Z.of_int max_int in
  let bigz = Z.mul z z in
    print_endline (Z.to_string bigz);
  (* Go even bigger *)
  let biggerz = Z.shift_left z 100 in
    print_endline (Z.to_string biggerz);
    Printf.printf "This has %i significant bits, of which %i are set\n" (Z.numbits biggerz) (Z.popcount biggerz);
    Printf.printf "Does it fit in an Int64.t? %b\n" (Z.fits_int64 biggerz);
    (* Logarithm (as an int, because it is small) *)
    Printf.printf "Logarithm, base two: %i\n" (Z.log2 biggerz);
    (* Prime just larger than this (probably) *)
    Printf.printf "Next prime... %s\n" (Z.to_string (Z.nextprime biggerz));
    (* There are alternative printers: *)
    print_endline "Decimal:";
    print_endline (Z.format "%i" biggerz);
    print_endline "Octal:";
    print_endline (Z.format "%o" biggerz);
    print_endline "Binary:";
    print_endline (Z.format "%b" biggerz);
    print_endline "Hexadecimal:";
    print_endline (Z.format "%0#X" biggerz)

let rationals () =
  (* 1 / 100 *)
  let q = Q.make (Z.of_int 1) (Z.of_int 100) in
  (* Or, more easily 1 / 1000 *)
  let q2 = Q.of_ints 1 1000 in
  (* Or, even more easily 1 / 10000 *)
  let open Q in
  let q3 = 1 // 10000 in
  (* Or, from a string *)
  let q4 = Q.of_string "1/10000" in
    (* Show parts *)
    Printf.printf "Parts of q3: %s, %s\n" (Z.to_string q3.num) (Z.to_string q3.den);
    (* Printing *)
    Q.print q3;
    print_newline ();
    (* Arithmetic *)
    let q5 = Q.mul q3 q4 in
      print_endline "Multiplied:";
      Q.print q5;
      print_newline ();
      Printf.printf "As a float: %f\n" (Q.to_float q4)

let digits_of_pi n =
  let zero = Z.zero
  and one = Z.one
  and three = Z.of_int 3
  and four = Z.of_int 4
  and ten = Z.of_int 10
  and neg_ten = Z.of_int (-10) in
  
  (* Linear Fractional (aka Mobius) Transformations *)
  let module LFT =
    struct
      let floor_ev (q, r, s, t) x =
        Z.((q * x + r) / (s * x + t))

      let unit = (one, zero, zero, one)

      let comp (q, r, s, t) (q', r', s', t') =
        Z.(q * q' + r * s', q * r' + r * t',
           s * q' + t * s', s * r' + t * t')
    end
  in

  let next z = LFT.floor_ev z three in

  let safe z n = (n = LFT.floor_ev z four) in

  let prod z n = LFT.comp (ten, Z.(neg_ten * n), zero, one) z in

  let cons z k =
    let den = 2 * k + 1 in
      LFT.comp z (Z.of_int k, Z.of_int (2 * den), zero, Z.of_int den)
  in

  let rec digit k z n row col =
    if n > 0 then
      let y = next z in
      if safe z y then
        if col = 10 then (
          let row = row + 10 in
          Printf.printf "\t:%i\n%a" row Z.output y;
          digit k (prod z y) (n - 1) row 1
        )
        else (
          Printf.printf "%a" Z.output y;
          digit k (prod z y) (n - 1) row (col + 1)
        )
      else digit (k + 1) (cons z k) n row col
    else
      Printf.printf "%*s\t:%i\n" (10 - col) "" (row + col)
  in
    digit 1 LFT.unit n 0 0

let () =
  match Sys.argv with
  | [|_; "integers"|] -> integers ()
  | [|_; "rationals"|] -> rationals ()
  | [|_; "digits_of_pi"; n|] -> digits_of_pi (int_of_string n)
  | _ -> Printf.eprintf "zarith example: unknown command line\n"
