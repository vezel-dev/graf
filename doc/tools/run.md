# gc-run

## NAME

`gc-run` - the Graph Code runner

## SYNOPSIS

`gc-run [input] [-i] [options] [--] [arguments...]`

## DESCRIPTION

`gc-run` executes a Graph Code module, either through just-in-time compilation
or interpretation.

There are a number of requirements for the input module:

* It must have an entry point function with a signature that is compatible with
  the standard C `main` function.
* It must be targeted for the host machine and operating system.
* If it uses an external libc, it must be the same libc that `gc-run` uses.
* If the `-i` option is specified, it can only call external functions if
  `gc-run` is able to find and load libffi on the host machine.
    * Even then, there are edge cases that libffi may not be able to handle.

If the input file name is omitted or it is set to `-`, then input is read from
standard input.

Any arguments/options that are not recognized by `gc-run` will be passed through
as arguments to the executed module. `--` can be used to explicitly end argument
processing by `gc-run` so that all subsequent arguments are passed through.

Any diagnostic messages are written to standard error.

## OPTIONS

* `-h, --help`: Print usage information and exit.
* `-v, --version`: Print version information and exit.
* `-i, --interpret`: Use the interpreter instead of just-in-time compilation.

## EXIT STATUS

If the given module fails to load or execute in some way, the exit code will be
non-zero. Otherwise, the exit code will be whatever is returned by the module.

## ENVIRONMENT

* `NO_COLOR`: If set to a non-empty value, disables colored diagnostic messages.

## STANDARDS

* Graph Code <https://docs.vezel.dev/graf/gc>

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
