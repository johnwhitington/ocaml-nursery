# The OCaml Nursery

Many OCaml libraries have no or perfunctory examples. The OCaml Nursery is a
place for storing examples for OCaml libraries, prior to their intended
upstreaming.

## Running and editing an example

In the absence of other instructions in the README.md file in each example
directory, you can build the example program from within the directory with
`dune build` and run it with `dune exec <directory name>` (for example, `dune
exec example_yojson`). Edit the example by loading `bin/main.ml` into your text
editor, the run `dune build` again to update the executable.

## Writing new examples

