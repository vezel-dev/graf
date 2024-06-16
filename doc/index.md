# Home

{% hint style="warning" %}
This is currently in-development vaporware.
{% endhint %}

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

<!-- TODO: Write a lengthier introduction. -->
