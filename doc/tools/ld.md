# gc-ld

## NAME

`gc-ld` - the Graph Code linker

## SYNOPSIS

`gc-ld [inputs...] [-o <output>] [options]`

## DESCRIPTION

`gc-ld` combines multiple Graph Code modules into a single module.

If no input file names are provided or if any input is set to `-`, then input is
read from standard input. File inputs and standard input can be used in the same
invocation when using `-` as one of the inputs. Additionally, multiple modules
can be concatenated on standard input.

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

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
