const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const linux = b.standardTargetOptions(.{});
    const windows = b.resolveTargetQuery(.{
        .os_tag = .windows,
        .cpu_arch = .x86_64,
        .abi = .gnu
    });

    const optimize = b.standardOptimizeOption(.{});

    // Now, we will create a dynamic library based on the module we created above.
    // This creates a `std.Build.Step.Compile`, which is the build step responsible
    // for actually invoking the compiler.
    const linlib = b.addSharedLibrary(.{
        .name = "display-filter-heightmap",
        .root_source_file =  b.path("src/main.zig"),
        .target = linux,
        .optimize = optimize,
    });

    linlib.linkSystemLibrary("c");
    linlib.linkSystemLibrary("gimp-3.0");
    linlib.linkSystemLibrary("gimpmodule-3.0");
    linlib.linkSystemLibrary("gimpui-3.0");
    linlib.linkSystemLibrary("gimpwidgets-3.0");

    const gimp = b.dependency("gimp", .{ .target=linux, .optimize=optimize});
    linlib.root_module.addImport("gobject", gimp.module("gobject2"));
    linlib.root_module.addImport("babl", gimp.module("babl0"));
    linlib.root_module.addImport("gegl", gimp.module("gegl0"));
    linlib.root_module.addImport("gimp", gimp.module("gimp3"));
    linlib.root_module.addImport("gimpui", gimp.module("gimpui3"));

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(linlib);


    // Now, we will create a dynamic library based on the module we created above.
    // This creates a `std.Build.Step.Compile`, which is the build step responsible
    // for actually invoking the compiler.
    const winlib = b.addSharedLibrary(.{
        .name = "display-filter-heightmap",
        .root_source_file =  b.path("src/main.zig"),
        .target = windows,
        .optimize = optimize,
    });
    b.addSearchPrefix("/mnt/windows/Program Files/GIMP 3/bin");
    winlib.addLibraryPath( .{ .cwd_relative = "/mnt/windows/Program Files/GIMP 3/bin" } );

    winlib.linkSystemLibrary("c");
    winlib.linkSystemLibrary("libglib-2.0-0");
    winlib.linkSystemLibrary("libgobject-2.0-0");
    winlib.linkSystemLibrary("libbabl-0.1-0");
    winlib.linkSystemLibrary("libgegl-0.4-0");
    winlib.linkSystemLibrary("libgimp-3.0-0");
    winlib.linkSystemLibrary("libgimpmodule-3.0-0");
    winlib.linkSystemLibrary("libgimpui-3.0-0");
    winlib.linkSystemLibrary("libgimpwidgets-3.0-0");


    const gimpw = b.dependency("gimp", .{ .target=windows, .optimize=optimize});
    winlib.root_module.addImport("gobject", gimpw.module("gobject2"));
    winlib.root_module.addImport("babl", gimpw.module("babl0"));
    winlib.root_module.addImport("gegl", gimpw.module("gegl0"));
    winlib.root_module.addImport("gimp", gimpw.module("gimp3"));
    winlib.root_module.addImport("gimpui", gimpw.module("gimpui3"));

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(winlib);

}
