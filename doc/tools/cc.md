# gc-cc

## NAME

`gc-cc` - the Graf-based C compiler

## SYNOPSIS

`gc-cc [input] [-s <standard>] [-p] [-e] [-i <include>] [-o <output>] [options]`

## DESCRIPTION

`gc-cc` compiles C code using the Aro C compiler frontend and the Graf compiler
infrastructure. C89 through C23 are supported.

Note that `gc-cc` is primarily used as a way to field-test the Graf compiler
infrastructure; it is not a production-quality C compiler in the same capacity
as e.g. GCC or Clang. As such, its option spellings are slightly different than
those compilers.

If the input file name is omitted or set to `-`, then input is read from
standard input.

If the `-o` option is not specified, then the output method is selected
according to these rules:

* If the input is read from standard input, then the output is written to
  standard output.
* If the input is a file name, then the output is written to the same file name
  but with the extension changed to `.gcm`.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.
* `-s, --standard <standard>`: Set the C language standard (`c23` (default),
  `c17`, `c11`, `c99`, `c89`).
* `-p, --pedantic`: Disable C language extensions.
* `-e, --error`: Enable treating warnings as errors.
* `-d, --define <name[=value]>`: Define a macro as if `#define` was used.
* `-u, --undefine <name>`: Undefine a macro as if `#undef` was used.
* `-i, --include <include>`: Add a preprocessor include search path.
* `--isystem <include>`: Add a preprocessor include search path and consider it
  to contain system headers.
* `-t, --target <triple>`: Set the target triple. Defaults to the host machine's
  detected triple.
* `-c, --cpu <cpu>`: Set the target CPU model and features. Defaults to either
  `baseline` or `native` depending on the usage of `-t`.
* `-o, --output <output>`: Set the output file name. If set to `-`, then output
  is written to standard output.

## EXIT STATUS

On success, the exit code will be 0. If an error occurs, the exit code will be
non-zero.

## ENVIRONMENT

* `NO_COLOR`: If set to a non-empty value, disables colored diagnostic messages.

## STANDARDS

* C89
* C99
* C11
* C17
* C23
* Graph Code <https://docs.vezel.dev/graf/gc>.

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
