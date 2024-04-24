# The OCaml Nursery

Many OCaml libraries have no examples, or perfunctory examples only. This
makes it difficult to get started with a library, particularly if it has an
elaborate interface. A working example, no matter how small, can help a
newcomer get started quickly.

The OCaml Nursery is a place for storing examples for OCaml libraries, prior
to their intended upstreaming -- or, if the library author does not wish
accept them, permanently.

One day, it would be nice to have an example for every OCaml package.

## Running and editing an example

There is a README.md file in each subdirectory of examples. Typically the
source file is `bin/main.ml`, the example can be built and run (or re-run)
with `dune exec bin/main.exe`, and cleaned up with `dune clean`. But, of
course, some examples may have different instructions.

## Writing an example

A template for simple dune-built examples is included as `_template`. Just
copy and modify the `dune-project`, `bin/main.ml` and `bin/dune` files
appropriately.

The `dune-workspace` file in this template includes a stanza to turn off
warnings-as-errors. This setting is unhelpful when playing with examples.

Of course, there is no formal requirement to use this template.

## What an example is (not)

- *Examples are not tests.*
 
- Examples are not in the documentation.

- Examples are independent of the library they explain.

- Examples are self-contained.

- Examples have comments.

- Examples are easy to build.

- Examples are easy to keep up to date.

- Examples use standard techniques.

- Examples are easy to edit and play with.

- Examples are open licensed.

- Examples may be any size.

(mention command line, copy & paste into top level and so on)
