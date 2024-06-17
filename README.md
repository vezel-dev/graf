# Graf

<div align="center">
    <img src="graf.svg"
         width="128"
         alt="Graf" />
</div>

<p align="center">
    <strong>
        A graph-oriented intermediate representation, optimization framework,
        and machine code generator.
    </strong>
</p>

<div align="center">

[![License](https://img.shields.io/github/license/vezel-dev/graf?color=brown)](LICENSE-0BSD)
[![Commits](https://img.shields.io/github/commit-activity/m/vezel-dev/graf/master?label=commits&color=slateblue)](https://github.com/vezel-dev/graf/commits/master)
[![Build](https://img.shields.io/github/actions/workflow/status/vezel-dev/graf/build.yml?branch=master)](https://github.com/vezel-dev/graf/actions/workflows/build.yml)
[![Discussions](https://img.shields.io/github/discussions/vezel-dev/graf?color=teal)](https://github.com/vezel-dev/graf/discussions)
[![Discord](https://img.shields.io/badge/discord-chat-7289da?logo=discord)](https://discord.gg/wtzCfaX2Nj)
[![Zulip](https://img.shields.io/badge/zulip-chat-394069?logo=zulip)](https://vezel.zulipchat.com)

</div>

--------------------------------------------------------------------------------

> [!WARNING]
> This is currently in-development vaporware.

**Graf** is a graph-oriented compiler infrastructure written in Zig. Chiefly, it
provides the Graph Code intermediate representation, a simple optimization
framework, and a machine code generator.

Graph Code is based on the [RVSDG](https://dl.acm.org/doi/abs/10.1145/3391902),
a novel IR that has a number of desirable properties such as explicit data and
state dependencies, inherent static-single assignment form, strong
canonicalization, and whole-program representation.

Optimization is primarily based on
[e-graphs and equality saturation](https://dl.acm.org/doi/10.1145/3434304). In
addition to being a natural fit for the RVSDG, this results in a cohesive
framework for discovering rewrites and losslessly adding them to the IR, thus
avoiding the phase-ordering problem.

For more information, please visit the
[project home page](https://docs.vezel.dev/graf).

## Building

You will need Zig, Pandoc, and Node.js installed. Simply run `zig build` to
build artifacts. Run `zig build --help` for a list of configurable options and
optional build steps.

## License

This project is licensed under the terms found in
[`LICENSE-0BSD`](LICENSE-0BSD).
