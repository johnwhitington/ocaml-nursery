(* Fileutils provides two modules:
     - FilePath is used for platform-agnostic file path manipulation, providing
       more functionality than the Standard Library Filename module
     - FileUtil implements some of the POSIX file manipulation programs such
       as cp and rm, but implemented in pure, portable OCaml.
*)

let go () =
  let filename = "dune" in
    Printf.printf "Current dir %S\n"
      FilePath.current_dir;
    Printf.printf "Parent dir %S\n"
      FilePath.parent_dir;
    Printf.printf "Make a filename from parts: %S\n"
      (FilePath.make_filename ["one"; "two"; "three"]);
    Printf.printf "Simplify a filename: %S\n"
      (FilePath.reduce (FilePath.make_filename [FilePath.current_dir; "one"]));
    Printf.printf "Replace an extension: %S\n"
      (FilePath.replace_extension "foo.jpg" "jpeg");
    Printf.printf "Making a PATH string: %S\n"
      (FilePath.string_of_path ["one"; FilePath.make_filename ["two"; "three"]])

let () =
  match Sys.argv with
  | [|_|] -> go ()
  | _ -> Printf.eprintf "fileutils example: unknown command line\n"
