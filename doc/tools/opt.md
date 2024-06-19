# gc-opt

## NAME

`gc-opt` - the Graph Code optimizer

## SYNOPSIS

`gc-opt [input] [-o <output>] [options]`

## DESCRIPTION

`gc-opt` loads a Graph Code module, optimizes it, and outputs the resulting
module.

If the input file name is omitted or set to `-`, then input is read from
standard input.

If the `-o` option is not specified, then the output is written to standard
output.

Any diagnostic messages are written to standard error.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.
* `-o, --output <output>`: Set the output file name. If set to `-`, then output
  is written to standard output (equivalent to omitting the option).

## EXIT STATUS

On success, the exit code will be 0. If an error occurs, the exit code will be
non-zero.

## ENVIRONMENT

* `NO_COLOR`: If set to a non-empty value, disables colored diagnostic messages.

## STANDARDS

* Graph Code <https://docs.vezel.dev/graf/gc>

## EXAMPLES

* Optimize textual Graph Code in-place:
  `gc-as main.gc -o - | gc-opt | gc-dis -o main.gc`

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
