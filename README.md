# The OCaml Nursery

Many OCaml libraries have no examples, or perfunctory examples only. This makes
it difficult to get started with a library, particularly if it has an elaborate
interface. A working example, no matter how small, can help a newcomer get
started quickly.

The OCaml Nursery is a place for storing examples for OCaml libraries, prior to
their intended upstreaming - or, if the library author does not wish accept
them, permanently.

One day, it would be nice to have an example for every opam package.

## Running and editing an example

There is a README.md file in each subdirectory of examples. Typically the
source file is `bin/main.ml`, the example can be built and run (or re-run) with
`dune exec bin/main.exe`, and cleaned up with `dune clean`. But, of course,
some examples may have different instructions.

Of course, you will need to install the library for each example first, using
`opam install <library name>`.

The examples so far are all run from the command line - you can see from the
source if a subcommand is needed. But, of course, part or all of the example
can be copy & pasted into OCaml's interactive top level using `#use "topfind"`
then `#require "<library name>"`. With the alternative `utop` top level it is
simpler - you can write `dune utop .`, and the library will be pre-loaded.

## Writing an example

A template for simple dune-built examples is included as `_template`. Just copy
and modify the `dune-project`, `bin/main.ml` and `bin/dune` files
appropriately.

The `dune-workspace` file in this template includes a stanza to turn off
warnings-as-errors. This setting is unhelpful when playing with examples.

Of course, there is no formal requirement to use this template.

## What an example is

- **Examples are independent of the library they explain.** They do not require
  the source of the library, or any built artefacts.

- **Examples are self-contained.** They require only OCaml, a build system, and
  the library in question to be installed.

- **Examples are easy to build.** They are built in a single command, and do
  not depend on environment. 

- **Examples are easy to edit and play with.** They are of a reasonable size,
  split into chunks, and are commented liberally.

- **Examples use standard techniques.** Both in how the library is used, and in
  how the OCaml code is written.

- **Examples are open licensed.** We use the CC0 1.0 Universal license. Users
  should be able to copy & paste code from the examples without care.

## What an example is not

- **Examples are not tests.** Unlike tests, examples do not care about code
  coverage, cannot be automatically generated, and need not be tightly
  integrated into the source repository.
 
- **Examples are not in the API documentation.** Examples need to be buildable,
  and separate from the API documentation. This is not to say that they might
  then not be automatically imported into the API documentation.

- **Examples need not be comprehensive.** Better a small example than no
  example at all. So long as the basics of an API are introduced, the cliff is
  climbed and the API documentation should thereafter suffice.
