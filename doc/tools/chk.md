# gc-chk

## NAME

`gc-chk` - the Graph Code checker

## SYNOPSIS

`gc-chk [input] [options]`

## DESCRIPTION

`gc-chk` runs an exhaustive set of validity checks on a Graph Code module. This
can be useful, for example, to verify the correctness of module writing code or
optimizations/transformations.

Note that the Graf library and other Graf tools generally assume that input
Graph Code already passes the validity checks performed by `gc-chk`.

If the input file name is omitted or it is set to `-`, then input is read from
standard input.

Any diagnostic messages are written to standard error.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.

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
