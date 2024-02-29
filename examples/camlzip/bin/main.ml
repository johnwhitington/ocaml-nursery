(* CamlZip Zlib and Zip examples *)

(* Compress data using raw zlib. *)
let zlib_compress filename_in filename_out =
  let fh_in = open_in_bin filename_in in
  let fh_out = open_out_bin filename_out in
    Zlib.compress (function b -> input fh_in b 0 (Bytes.length b)) (fun b l -> output fh_out b 0 l);
    close_in fh_in;
    close_out fh_out

(* Uncompress raw zlib data *)
let zlib_uncompress filename_in filename_out =
  let fh_in = open_in_bin filename_in in
  let fh_out = open_out_bin filename_out in
    Zlib.uncompress (function b -> input fh_in b 0 (Bytes.length b)) (fun b l -> output fh_out b 0 l);
    close_in fh_in;
    close_out fh_out

let () =
  match Sys.argv with
  | [|_; "zlibcompress"; filename_in; filename_out|] -> zlib_compress filename_in filename_out
  | [|_; "zlibuncompress"; filename_in; filename_out|] -> zlib_uncompress filename_in filename_out
  (* add zip example *)
  (* add gzip example *)
  | _ -> Printf.eprintf "camlzip example: unknown command line\n"
