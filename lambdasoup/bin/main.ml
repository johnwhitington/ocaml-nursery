(* Extract text from HTML file, write to stdout *)

(* Bring $, $?, $$ opeators only into scope. *)
open Soup.Infix

(* Extract a title from an HTML file and print it. We use the optional forms
   throughout. *)
let extract () =
  let soup = Soup.parse (Soup.read_file "example.html") in
  let title_node = soup $? "title" in
  match title_node with
  | Some tn ->
      begin match Soup.leaf_text tn with
      | Some lt -> Printf.printf "Title: %S\n" lt
      | None -> Printf.printf "No leaf text in title."
      end
  | None -> Printf.printf "No leaf text"

(* Now the same with exception-raising forms. Much simpler, but coarser error
   reporting. *)
let extract_exn () =
  try
    Printf.printf
      "Title: %S\n"
      (Soup.read_file "example.html" |> Soup.parse $ "title" |> Soup.R.leaf_text)
  with
    e ->
      Printf.printf "Lambdasoup exception: %s\n" (Printexc.to_string e)

let () =
  match Sys.argv with
  | [|_; "extract"|] -> extract ()
  | [|_; "extract_exn"|] -> extract_exn ()
  | _ -> Printf.eprintf "lambdasoup example: unknown command line\n"
