let go warnings =
  (* Set the logging level *)
  Logs.set_level (if warnings then Some Logs.Warning else Some Logs.Error);
  (* Set up the reporter, before calling Logs.err *)
  Logs.set_reporter (Logs.format_reporter ());
  let n = 20 in
    (* Log a warning using a format string *)
    if n > 5 then
      Logs.warn (fun m -> m "The number is almost too high: %i" n);
    if n > 10 then
      (* Log an error using a format string. *)
      Logs.err (fun m -> m "The number was too high: %i" n);
      (* Set exit code based on error count. *)
      exit (if Logs.err_count () > 0 then 1 else 0)

let () =
  match Sys.argv with
  | [|_; "all"|] -> go true
  | [|_; "errors"|] -> go false
  | _ -> Printf.eprintf "logs example: unknown command line\n"
