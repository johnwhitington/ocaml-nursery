# The OCaml Nursery

Many OCaml libraries have no examples, or perfunctory examples only. This
makes it difficult to get started with a library, particularly if it has an
elaborate interface. A working example, no matter how small, can help a
newcomer get started quickly.

The OCaml Nursery is a place for storing examples for OCaml libraries, prior
to their intended upstreaming - or, if the library author does not wish
accept them, permanently.

One day, it would be nice to have an example for every opam package.

## Running and editing an example

There is a README.md file in each subdirectory of examples. Typically the
source file is `bin/main.ml`, the example can be built and run (or re-run)
with `dune exec bin/main.exe`, and cleaned up with `dune clean`. But, of
course, some examples may have different instructions.

Of course, you will need to install the library for each example first, using
`opam install <library name>`.

The examples so far are all run from the command line - you can see from the
source if a subcommand is needed. But, of course, part or all of the example
can be copy & pasted into OCaml's interactive top level using `#use "topfind"`
then `#require "<library name>"`. With the alternative `utop` top level it is
simpler - you can write `dune utop .`, and the library will be pre-loaded.

## Writing an example

A template for simple dune-built examples is included as `_template`. Just
copy and modify the `dune-project`, `bin/main.ml` and `bin/dune` files
appropriately.

The `dune-workspace` file in this template includes a stanza to turn off
warnings-as-errors. This setting is unhelpful when playing with examples.

Of course, there is no formal requirement to use this template.

## What an example is

- **Examples are different from tests**
 
- **Examples are independent of the library they explain.** not in the documentation. building.

- **Examples are self-contained.**

- **Examples are easy to build.**

- **Examples are easy to edit and play with.**

- **Examples have comments.**

- **Examples use standard techniques.**

- **Examples are easy to keep up to date.**

- **Examples are open licensed.**
