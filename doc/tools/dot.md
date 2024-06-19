# gc-dot

## NAME

`gc-dot` - the Graph Code visualizer

## SYNOPSIS

`gc-dot [input] [-o <output>] [options]`

## DESCRIPTION

`gc-dot` assists in visualizing a Graph Code module by generating a graph in the
Graphviz DOT language.

If the input file name is omitted or it is set to `-`, then input is read from
standard input.

If the `-o` option is not specified, then the output method is selected
according to these rules:

* If the input is read from standard input, then the output is written to
  standard output.
* If the input is a file name, then the output is written to the same file name
  but with the extension changed to `.dot`.

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

* DOT <https://graphviz.org/doc/info/lang.html>
* Graph Code <https://docs.vezel.dev/graf/gc>

## EXAMPLES

* Visualize textual Graph Code: `gc-as main.gc -o - | gc-dot | xdot`
* Visualize a Graph Code module: `gc-dot main.gcm -o - | xdot`

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
