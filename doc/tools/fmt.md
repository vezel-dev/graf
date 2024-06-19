# gc-fmt

## NAME

`gc-fmt` - the Graph Code formatter

## SYNOPSIS

`gc-fmt [inputs...] [-c] [options]`

## DESCRIPTION

`gc-fmt` formats textual Graph Code into canonical form. The canonical form is
opinionated and unconfigurable.

If no input file or directory names are provided or if the only input is `-`,
then input is read from standard input and formatted text is written to standard
output. (If `-` is used, it must be the only input.) Otherwise, formatting is
performed in-place to the file names given as well as any files ending in `.gc`
found (recursively) within any directory names given.

Any diagnostic messages are written to standard error.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.
* `-c, --check`: Enable listing non-conforming files rather than applying
  formatting.

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
