# gc-mc

## NAME

`gc-mc` - the Graph Code compiler

## SYNOPSIS

`gc-mc [input] [-o <output>] [options]`

## DESCRIPTION

`gc-mc` compiles a Graph Code module into machine code.

If the input file name is omitted or set to `-`, then input is read from
standard input.

If the `-o` option is not specified, then the output method is selected
according to these rules:

* If the input is read from standard input, then the output is written to
  standard output.
* If the input is a file name, then the output is written to the same file name
  but with the extension changed to `.obj` (for COFF), `.spv` (for SPIR-V), or
  `.o` (for all other formats).

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

* COFF <https://learn.microsoft.com/en-us/windows/win32/debug/pe-format>
* ELF <https://man7.org/linux/man-pages/man5/elf.5.html>
* Graph Code <https://docs.vezel.dev/graf/gc>
* Mach-O <https://github.com/aidansteele/osx-abi-macho-file-format-reference>
* SPIR-V <https://registry.khronos.org/SPIR-V/specs/unified1/SPIRV.html>
* WebAssembly <https://webassembly.github.io/spec/core/binary/index.html>

## REPORTING BUGS

<https://github.com/vezel-dev/graf/issues>

## COPYRIGHT

Copyright © Vezel Contributors
