const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    // Now, we will create a dynamic library based on the module we created above.
    // This creates a `std.Build.Step.Compile`, which is the build step responsible
    // for actually invoking the compiler.
    const lib = b.addSharedLibrary(.{
        .name = "display-filter-false-colour",
        .root_source_file =  b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.linkSystemLibrary("c");
    lib.linkSystemLibrary("gtk+-3.0");
    lib.linkSystemLibrary("gimp-3.0");
    lib.linkSystemLibrary("gimpmodule-3.0");
    lib.linkSystemLibrary("gimpui-3.0");
    lib.linkSystemLibrary("gimpwidgets-3.0");

    // lib.addIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0"});
    // lib.addIncludePath(.{ .cwd_relative = "/usr/include/gegl-0.4"});
    // lib.addIncludePath(.{ .cwd_relative = "/usr/include/babl-0.1"});


    const gimp = b.dependency("gimp", .{});
    lib.root_module.addImport("gdk", gimp.module("gdk3"));
    lib.root_module.addImport("glib", gimp.module("glib2"));
    lib.root_module.addImport("gobject", gimp.module("gobject2"));
    lib.root_module.addImport("gtk", gimp.module("gtk3"));
    lib.root_module.addImport("babl", gimp.module("babl0"));
    lib.root_module.addImport("gegl", gimp.module("gegl0"));
    lib.root_module.addImport("gimp", gimp.module("gimp3"));
    lib.root_module.addImport("gimpui", gimp.module("gimpui3"));

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    // // Creates a step for unit testing. This only builds the test executable
    // // but does not run it.
    // const unit_tests = b.addTest(.{
    //     .root_module = lib_mod,
    // });
    //
    // const build_unit_tests = b.addInstallArtifact(unit_tests, .{});
    // const build_test_step = b.step("buildtest", "Build unit tests");
    // build_test_step.dependOn(&build_unit_tests.step);
    //
    // const run_unit_tests = b.addRunArtifact(unit_tests);
    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&run_unit_tests.step);
}
