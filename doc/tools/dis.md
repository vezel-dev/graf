# gc-dis

## NAME

`gc-dis` - the Graph Code disassembler

## SYNOPSIS

`gc-dis [input] [-o <output>] [options]`

## DESCRIPTION

`gc-dis` disassembles a Graph Code module into textual Graph Code.

If the input file name is omitted or it is set to `-`, then input is read from
standard input.

If the `-o` option is not specified, then the output method is selected
according to these rules:

* If the input is read from standard input, then the output is written to
  standard output.
* If the input is a file name, then the output is written to the same file name
  but with the extension changed to `.gc`.

Any diagnostic messages are written to standard error.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.
* `-o, --output <output>`: Set the output file name. If set to `-`, then output
  is written to standard output.

## EXIT STATUS

On success, the exit code will be 0. If an error occurs, the exit code will be
non-zero.

## ENVIRONMENT

* `NO_COLOR`: If set to a non-empty value, disables colored diagnostic messages.

## STANDARDS

* Graph Code <https://docs.vezel.dev/graf/gc>

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
