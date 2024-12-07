// SPDX-License-Identifier: 0BSD

const std = @import("std");

// TODO: https://github.com/ziglang/zig/issues/14531
const version = "0.1.0-dev";

pub fn build(b: *std.Build) anyerror!void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const enable_aro = b.option(bool, "enable-aro", "Enable Aro C compiler integration (true)") orelse true;
    const enable_ffi = b.option(bool, "enable-ffi", "Enable libffi interpreter integration (true)") orelse true;

    // TODO: https://github.com/ziglang/zig/issues/15373
    const pandoc_prog = b.findProgram(&.{"pandoc"}, &.{}) catch @panic("Could not locate `pandoc` program.");

    const install_tls = b.getInstallStep();
    const check_tls = b.step("check", "Run source code and documentation checks");
    const fmt_tls = b.step("fmt", "Fix source code formatting");
    const test_tls = b.step("test", "Build and run tests");
    const vscode_tls = b.step("vscode", "Build VS Code extension");
    const install_vscode_tls = b.step("install-vscode", "Install VS Code extension");
    const uninstall_vscode_tls = b.step("uninstall-vscode", "Uninstall VS Code extension");

    const npm_install_doc_step = b.addSystemCommand(&.{ "npm", "install" });
    npm_install_doc_step.setName("npm install");

    const npm_exec_markdownlint_cli2_doc_step = b.addSystemCommand(&.{ "npm", "exec", "markdownlint-cli2" });
    npm_exec_markdownlint_cli2_doc_step.setName("npm exec markdownlint-cli2");
    npm_exec_markdownlint_cli2_doc_step.step.dependOn(&npm_install_doc_step.step);

    check_tls.dependOn(&npm_exec_markdownlint_cli2_doc_step.step);

    inline for (.{ npm_install_doc_step, npm_exec_markdownlint_cli2_doc_step }) |step| {
        step.setCwd(b.path("doc"));
    }

    const npm_install_vscode_step = b.addSystemCommand(&.{ "npm", "install" });
    npm_install_vscode_step.setName("npm install");

    const npm_run_build_vscode = b.addSystemCommand(&.{ "npm", "run", "build" });
    npm_run_build_vscode.setName("npm run build");
    npm_run_build_vscode.step.dependOn(&npm_install_vscode_step.step);

    vscode_tls.dependOn(&npm_run_build_vscode.step);

    inline for (.{ npm_install_vscode_step, npm_run_build_vscode }) |step| {
        step.setCwd(b.path(b.pathJoin(&.{ "sup", "vscode" })));
    }

    const code_install_extension_step = b.addSystemCommand(
        &.{ "code", "--install-extension", b.pathJoin(&.{ "vscode", b.fmt("graf-{s}.vsix", .{version}) }) },
    );
    code_install_extension_step.step.dependOn(&npm_run_build_vscode.step);

    install_vscode_tls.dependOn(&code_install_extension_step.step);

    const code_uninstall_extension_step = b.addSystemCommand(&.{ "code", "--uninstall-extension", "vezel.graf" });

    uninstall_vscode_tls.dependOn(&code_uninstall_extension_step.step);

    inline for (.{
        npm_install_doc_step,
        npm_exec_markdownlint_cli2_doc_step,
        npm_install_vscode_step,
        npm_run_build_vscode,
        code_install_extension_step,
        code_uninstall_extension_step,
    }) |step| {
        step.expectExitCode(0);

        // Setting an expected exit code will cause these steps to be cached; ensure that they always run.
        step.has_side_effects = true;
    }

    const fmt_paths = &[_][]const u8{
        "bin",
        "chk",
        "lib",
        "build.zig",
        "build.zig.zon",
    };

    check_tls.dependOn(&b.addFmt(.{
        .paths = fmt_paths,
        .check = true,
    }).step);

    fmt_tls.dependOn(&b.addFmt(.{
        .paths = fmt_paths,
    }).step);

    const graf_mod = b.addModule("graf", .{
        .root_source_file = b.path(b.pathJoin(&.{ "lib", "graf.zig" })),
        .target = target,
        .optimize = optimize,
        // Avoid adding opinionated build options to the module itself as those will be forced on third-party users.
    });

    graf_mod.addImport("mecha", b.dependency("mecha", .{
        .target = target,
        .optimize = optimize,
    }).module("mecha"));

    if (enable_aro) {
        if (b.lazyDependency("aro", .{
            .target = target,
            .optimize = optimize,
        })) |dep| {
            graf_mod.addImport("aro", dep.module("aro"));

            // TODO: These headers should also be installed for third-party users somehow.
            b.installDirectory(.{
                .source_dir = dep.path("include"),
                .install_dir = .header,
                .install_subdir = b.pathJoin(&.{ "graf", "aro" }),
            });
        }
    }

    const t = target.result;

    if (enable_ffi) {
        if (b.systemIntegrationOption("ffi", .{})) {
            graf_mod.linkSystemLibrary("ffi", .{});
        } else {
            // TODO: https://github.com/ziglang/zig/issues/20361
            const libffi_works = !t.isDarwin() and switch (t.cpu.arch) {
                // libffi only supports MSVC for Windows on Arm.
                .aarch64, .aarch64_be => t.os.tag != .windows,
                // TODO: https://github.com/ziglang/zig/issues/10411
                .arm, .armeb => t.getFloatAbi() != .soft and t.os.tag != .windows,
                // TODO: https://github.com/llvm/llvm-project/issues/58377
                .mips, .mipsel, .mips64, .mips64el => false,
                // TODO: https://github.com/ziglang/zig/issues/20376
                .powerpc, .powerpcle => !t.isGnuLibC(),
                // TODO: https://github.com/ziglang/zig/issues/19107
                .riscv32, .riscv64 => !t.isGnuLibC(),
                else => true,
            };

            if (libffi_works) {
                if (b.lazyDependency("ffi", .{
                    .target = target,
                    .optimize = optimize,
                })) |dep| {
                    graf_mod.addImport("ffi", dep.module("ffi"));
                    graf_mod.linkLibrary(dep.artifact("ffi"));
                }
            }
        }
    }

    const stlib_step = b.addStaticLibrary(.{
        // Avoid name clash with the DLL import library on Windows.
        .name = if (t.os.tag == .windows) "libgraf" else "graf",
        .root_source_file = b.path(b.pathJoin(&.{ "lib", "c.zig" })),
        .target = target,
        .optimize = optimize,
        .strip = optimize != .Debug,
    });

    const shlib_step = b.addSharedLibrary(.{
        .name = "graf",
        .root_source_file = b.path(b.pathJoin(&.{ "lib", "c.zig" })),
        .target = target,
        .optimize = optimize,
        .strip = optimize != .Debug,
    });

    // On Linux, undefined symbols are allowed in shared libraries by default; override that.
    shlib_step.linker_allow_shlib_undefined = false;

    inline for (.{ stlib_step, shlib_step }) |step| {
        step.installHeadersDirectory(b.path("inc"), "graf", .{});

        b.installArtifact(step);
    }

    install_tls.dependOn(&b.addInstallLibFile(b.addWriteFiles().add("libgraf.pc", b.fmt(
        \\prefix=${{pcfiledir}}/../..
        \\exec_prefix=${{prefix}}
        \\includedir=${{prefix}}/include/graf
        \\libdir=${{prefix}}/lib
        \\
        \\Name: Graf
        \\Description: A graph-oriented intermediate representation, optimization framework, and machine code generator.
        \\URL: https://docs.vezel.dev/graf
        \\Version: {s}
        \\
        \\Cflags: -I${{includedir}}
        \\Libs: -L${{libdir}} -lgraf
    , .{version})), b.pathJoin(&.{ "pkgconfig", "libgraf.pc" })).step);

    const clap_mod = b.dependency("clap", .{
        .target = target,
        .optimize = optimize,
    }).module("clap");

    inline for (.{
        "as",
        "cc",
        "chk",
        "dis",
        "dot",
        "fmt",
        "ld",
        "mc",
        "opt",
        "run",
    }) |name| {
        if (enable_aro or !std.mem.eql(u8, name, "cc")) {
            const bin_name = b.fmt("gc-{s}", .{name});

            const exe_step = b.addExecutable(.{
                .name = bin_name,
                .root_source_file = b.path(b.pathJoin(&.{ "bin", name, "main.zig" })),
                .target = target,
                .optimize = optimize,
                .strip = optimize != .Debug,
            });

            // PIE is off by default; enable it for hardening purposes.
            exe_step.pie = switch (t.cpu.arch) {
                // TODO: https://github.com/ziglang/zig/issues/20305
                .mips, .mipsel, .mips64, .mips64el => false,
                .powerpc, .powerpcle, .powerpc64, .powerpc64le => false,
                // TODO: https://github.com/ziglang/zig/issues/20306
                .riscv64 => false,
                else => true,
            };

            const exe_mod = &exe_step.root_module;

            exe_mod.addImport("graf", graf_mod);
            exe_mod.addImport("clap", clap_mod);

            b.installArtifact(exe_step);

            const run_exe_step = b.addRunArtifact(exe_step);

            if (b.args) |args| {
                run_exe_step.addArgs(args);
            }

            b.step(bin_name, b.fmt("Build and run `{s}` (pass arguments with `-- <args>`)", .{bin_name}))
                .dependOn(&run_exe_step.step);

            const pandoc_step = b.addSystemCommand(&.{
                pandoc_prog,
                "--standalone",
                "--fail-if-warnings",
                "--shift-heading-level-by=-1",
                "-M",
                b.fmt("title={s}", .{bin_name}),
                "-M",
                "author=Vezel Contributors",
                "-V",
                "section=1",
                "-V",
                "header=Graf",
                "-V",
                b.fmt("footer={s}", .{version}),
            });

            pandoc_step.addFileArg(b.path(b.pathJoin(&.{ "doc", "tools", b.fmt("{s}.md", .{name}) })));

            const man_basename = b.fmt("{s}.1", .{bin_name});
            const man_path = pandoc_step.addPrefixedOutputFileArg("-o", man_basename);

            pandoc_step.expectExitCode(0);

            install_tls.dependOn(&b.addInstallFile(
                man_path,
                b.pathJoin(&.{ "share", "man", "man1", man_basename }),
            ).step);
        }
    }

    const run_test_step = b.addRunArtifact(b.addTest(.{
        .name = "graf-test",
        .root_source_file = b.path(b.pathJoin(&.{ "lib", "graf.zig" })),
        .target = target,
        .optimize = optimize,
    }));

    // Always run tests when requested, even if the binary has not changed.
    run_test_step.has_side_effects = true;

    test_tls.dependOn(&run_test_step.step);

    // TODO: Add tests based on CLI invocation.

    // TODO: Add a fuzz step based on AFL++.
}
