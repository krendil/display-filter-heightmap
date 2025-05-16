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

    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimp"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpcolor"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpconfig"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpmath"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpmodule"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpui"});
    lib.addSystemIncludePath(.{ .cwd_relative = "/usr/include/gimp-3.0/libgimpwidgets"});

    const gobject = b.dependency("gobject", .{});
    lib.root_module.addImport("gdk", gobject.module("gdk3"));
    lib.root_module.addImport("glib", gobject.module("glib2"));
    lib.root_module.addImport("gobject", gobject.module("gobject2"));
    lib.root_module.addImport("gtk", gobject.module("gtk3"));

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
