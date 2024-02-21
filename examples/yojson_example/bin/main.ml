(* For now, just the example from the Yojson docs *)
let json_string = {|
  {"number" : 42,
   "string" : "yes",
   "list": ["for", "sure", 42]}|}

let json = Yojson.Safe.from_string json_string

let () = Format.printf "Parsed to %a" Yojson.Safe.pp json
