const std = @import("std");

/// A library accessible through the generated bindings.
///
/// While the generated bindings are typically used through modules
/// (e.g. `gobject.module("glib-2.0")`), there are cases where it is
/// useful to have additional information about the libraries exposed
/// to the build script. For example, if any files in the root module
/// of the application want to import a library's C headers directly,
/// it will be necessary to link the library directly to the root module
/// using `Library.linkTo` so the include paths will be available.
pub const Library = struct {
    /// System libraries to be linked using pkg-config.
    system_libraries: []const []const u8,

    /// Links `lib` to `module`.
    pub fn linkTo(_: Library, _: *std.Build.Module) void {
        // module.link_libc = true;
        // for (lib.system_libraries) |system_lib| {
        //     module.linkSystemLibrary(system_lib, .{ .use_pkg_config = .force });
        // }
    }
};

/// Returns a `std.Build.Module` created by compiling the GResources file at `path`.
///
/// This requires the `glib-compile-resources` system command to be available.
pub fn addCompileResources(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) *std.Build.Module {
    const compile_resources, const module = addCompileResourcesInternal(b, target, path);
    compile_resources.addArg("--sourcedir");
    compile_resources.addDirectoryArg(path.dirname());
    compile_resources.addArg("--dependency-file");
    _ = compile_resources.addDepFileOutputArg("gresources-deps");

    return module;
}

fn addCompileResourcesInternal(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    path: std.Build.LazyPath,
) struct { *std.Build.Step.Run, *std.Build.Module } {
    const compile_resources = b.addSystemCommand(&.{ "glib-compile-resources", "--generate-source" });
    compile_resources.addArg("--target");
    const gresources_c = compile_resources.addOutputFileArg("gresources.c");
    compile_resources.addFileArg(path);

    const module = b.createModule(.{ .target = target });
    module.addCSourceFile(.{ .file = gresources_c });
    @This().libraries.gio2.linkTo(module);
    return .{ compile_resources, module };
}

/// Returns a builder for a compiled GResource bundle.
///
/// Calling `CompileResources.build` on the returned builder requires the
/// `glib-compile-resources` system command to be installed.
pub fn buildCompileResources(gobject_dependency: *std.Build.Dependency) CompileResources {
    return .{ .b = gobject_dependency.builder };
}

/// A builder for a compiled GResource bundle.
pub const CompileResources = struct {
    b: *std.Build,
    groups: std.ArrayListUnmanaged(*Group) = .{},

    var build_gresources_xml_exe: ?*std.Build.Step.Compile = null;

    /// Builds the GResource bundle as a module. The module must be imported
    /// into the compilation for the resources to be loaded.
    pub fn build(cr: CompileResources, target: std.Build.ResolvedTarget) *std.Build.Module {
        const run = cr.b.addRunArtifact(build_gresources_xml_exe orelse exe: {
            const exe = cr.b.addExecutable(.{
                .name = "build-gresources-xml",
                .root_source_file = cr.b.path("build/build_gresources_xml.zig"),
                .target = cr.b.graph.host,
                .optimize = .Debug,
            });
            build_gresources_xml_exe = exe;
            break :exe exe;
        });

        for (cr.groups.items) |group| {
            run.addArg(cr.b.fmt("--prefix={s}", .{group.prefix}));
            for (group.files.items) |file| {
                run.addArg(cr.b.fmt("--alias={s}", .{file.name}));
                if (file.options.compressed) {
                    run.addArg("--compressed");
                }
                for (file.options.preprocess) |preprocessor| {
                    run.addArg(cr.b.fmt("--preprocess={s}", .{preprocessor.name()}));
                }
                run.addPrefixedFileArg("--path=", file.path);
            }
        }
        const xml = run.addPrefixedOutputFileArg("--output=", "gresources.xml");

        _, const module = addCompileResourcesInternal(cr.b, target, xml);
        return module;
    }

    /// Adds a group of resources showing a common prefix.
    pub fn addGroup(cr: *CompileResources, prefix: []const u8) *Group {
        const group = cr.b.allocator.create(Group) catch @panic("OOM");
        group.* = .{ .owner = cr, .prefix = prefix };
        cr.groups.append(cr.b.allocator, group) catch @panic("OOM");
        return group;
    }

    pub const Group = struct {
        owner: *CompileResources,
        prefix: []const u8,
        files: std.ArrayListUnmanaged(File) = .{},

        /// Adds the file at `path` as a resource named `name` (within the
        /// prefix of the containing group).
        pub fn addFile(g: *Group, name: []const u8, path: std.Build.LazyPath, options: File.Options) void {
            g.files.append(g.owner.b.allocator, .{
                .name = name,
                .path = path,
                .options = options,
            }) catch @panic("OOM");
        }
    };

    pub const File = struct {
        name: []const u8,
        path: std.Build.LazyPath,
        options: Options = .{},

        pub const Options = struct {
            compressed: bool = false,
            preprocess: []const Preprocessor = &.{},
        };

        pub const Preprocessor = union(enum) {
            xml_stripblanks,
            json_stripblanks,
            other: []const u8,

            pub fn name(p: Preprocessor) []const u8 {
                return switch (p) {
                    .xml_stripblanks => "xml-stripblanks",
                    .json_stripblanks => "json-stripblanks",
                    .other => |s| s,
                };
            }
        };
    };
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const docs_step = b.step("docs", "Generate documentation");
    const test_step = b.step("test", "Run tests");

    const compat = b.createModule(.{
        .root_source_file = b.path("src/compat/compat.zig"),
        .target = target,
        .optimize = optimize,
    });

    const gimpui3 = b.addModule("gimpui3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gimpui3", "gimpui3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gimpui3.linkTo(gimpui3);
    gimpui3.addImport("compat", compat);

    const gimpui3_test = b.addTest(.{
        .root_module = gimpui3,
    });
    test_step.dependOn(&b.addRunArtifact(gimpui3_test).step);

    const cairo1 = b.addModule("cairo1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "cairo1", "cairo1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.cairo1.linkTo(cairo1);
    cairo1.addImport("compat", compat);

    const cairo1_test = b.addTest(.{
        .root_module = cairo1,
    });
    test_step.dependOn(&b.addRunArtifact(cairo1_test).step);

    const gobject2 = b.addModule("gobject2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gobject2", "gobject2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gobject2.linkTo(gobject2);
    gobject2.addImport("compat", compat);

    const gobject2_test = b.addTest(.{
        .root_module = gobject2,
    });
    test_step.dependOn(&b.addRunArtifact(gobject2_test).step);

    const glib2 = b.addModule("glib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "glib2", "glib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.glib2.linkTo(glib2);
    glib2.addImport("compat", compat);

    const glib2_test = b.addTest(.{
        .root_module = glib2,
    });
    test_step.dependOn(&b.addRunArtifact(glib2_test).step);

    const pango1 = b.addModule("pango1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "pango1", "pango1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.pango1.linkTo(pango1);
    pango1.addImport("compat", compat);

    const pango1_test = b.addTest(.{
        .root_module = pango1,
    });
    test_step.dependOn(&b.addRunArtifact(pango1_test).step);

    const harfbuzz0 = b.addModule("harfbuzz0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "harfbuzz0", "harfbuzz0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.harfbuzz0.linkTo(harfbuzz0);
    harfbuzz0.addImport("compat", compat);

    const harfbuzz0_test = b.addTest(.{
        .root_module = harfbuzz0,
    });
    test_step.dependOn(&b.addRunArtifact(harfbuzz0_test).step);

    const freetype22 = b.addModule("freetype22", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "freetype22", "freetype22" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.freetype22.linkTo(freetype22);
    freetype22.addImport("compat", compat);

    const freetype22_test = b.addTest(.{
        .root_module = freetype22,
    });
    test_step.dependOn(&b.addRunArtifact(freetype22_test).step);

    const gio2 = b.addModule("gio2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gio2", "gio2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gio2.linkTo(gio2);
    gio2.addImport("compat", compat);

    const gio2_test = b.addTest(.{
        .root_module = gio2,
    });
    test_step.dependOn(&b.addRunArtifact(gio2_test).step);

    const gmodule2 = b.addModule("gmodule2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gmodule2", "gmodule2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gmodule2.linkTo(gmodule2);
    gmodule2.addImport("compat", compat);

    const gmodule2_test = b.addTest(.{
        .root_module = gmodule2,
    });
    test_step.dependOn(&b.addRunArtifact(gmodule2_test).step);

    const gtk3 = b.addModule("gtk3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gtk3", "gtk3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gtk3.linkTo(gtk3);
    gtk3.addImport("compat", compat);

    const gtk3_test = b.addTest(.{
        .root_module = gtk3,
    });
    test_step.dependOn(&b.addRunArtifact(gtk3_test).step);

    const xlib2 = b.addModule("xlib2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "xlib2", "xlib2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.xlib2.linkTo(xlib2);
    xlib2.addImport("compat", compat);

    const xlib2_test = b.addTest(.{
        .root_module = xlib2,
    });
    test_step.dependOn(&b.addRunArtifact(xlib2_test).step);

    const gdk3 = b.addModule("gdk3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdk3", "gdk3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdk3.linkTo(gdk3);
    gdk3.addImport("compat", compat);

    const gdk3_test = b.addTest(.{
        .root_module = gdk3,
    });
    test_step.dependOn(&b.addRunArtifact(gdk3_test).step);

    const gdkpixbuf2 = b.addModule("gdkpixbuf2", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gdkpixbuf2", "gdkpixbuf2" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gdkpixbuf2.linkTo(gdkpixbuf2);
    gdkpixbuf2.addImport("compat", compat);

    const gdkpixbuf2_test = b.addTest(.{
        .root_module = gdkpixbuf2,
    });
    test_step.dependOn(&b.addRunArtifact(gdkpixbuf2_test).step);

    const atk1 = b.addModule("atk1", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "atk1", "atk1" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.atk1.linkTo(atk1);
    atk1.addImport("compat", compat);

    const atk1_test = b.addTest(.{
        .root_module = atk1,
    });
    test_step.dependOn(&b.addRunArtifact(atk1_test).step);

    const gimp3 = b.addModule("gimp3", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gimp3", "gimp3" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gimp3.linkTo(gimp3);
    gimp3.addImport("compat", compat);

    const gimp3_test = b.addTest(.{
        .root_module = gimp3,
    });
    test_step.dependOn(&b.addRunArtifact(gimp3_test).step);

    const gegl0 = b.addModule("gegl0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "gegl0", "gegl0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.gegl0.linkTo(gegl0);
    gegl0.addImport("compat", compat);

    const gegl0_test = b.addTest(.{
        .root_module = gegl0,
    });
    test_step.dependOn(&b.addRunArtifact(gegl0_test).step);

    const babl0 = b.addModule("babl0", .{
        .root_source_file = b.path(b.pathJoin(&.{ "src", "babl0", "babl0" ++ ".zig" })),
        .target = target,
        .optimize = optimize,
    });
    libraries.babl0.linkTo(babl0);
    babl0.addImport("compat", compat);

    const babl0_test = b.addTest(.{
        .root_module = babl0,
    });
    test_step.dependOn(&b.addRunArtifact(babl0_test).step);

    gimpui3.addImport("cairo1", cairo1);
    gimpui3.addImport("gobject2", gobject2);
    gimpui3.addImport("glib2", glib2);
    gimpui3.addImport("pango1", pango1);
    gimpui3.addImport("harfbuzz0", harfbuzz0);
    gimpui3.addImport("freetype22", freetype22);
    gimpui3.addImport("gio2", gio2);
    gimpui3.addImport("gmodule2", gmodule2);
    gimpui3.addImport("gtk3", gtk3);
    gimpui3.addImport("xlib2", xlib2);
    gimpui3.addImport("gdk3", gdk3);
    gimpui3.addImport("gdkpixbuf2", gdkpixbuf2);
    gimpui3.addImport("atk1", atk1);
    gimpui3.addImport("gimp3", gimp3);
    gimpui3.addImport("gegl0", gegl0);
    gimpui3.addImport("babl0", babl0);
    gimpui3.addImport("gimpui3", gimpui3);
    cairo1.addImport("gobject2", gobject2);
    cairo1.addImport("glib2", glib2);
    cairo1.addImport("cairo1", cairo1);
    gobject2.addImport("glib2", glib2);
    gobject2.addImport("gobject2", gobject2);
    glib2.addImport("glib2", glib2);
    pango1.addImport("cairo1", cairo1);
    pango1.addImport("gobject2", gobject2);
    pango1.addImport("glib2", glib2);
    pango1.addImport("harfbuzz0", harfbuzz0);
    pango1.addImport("freetype22", freetype22);
    pango1.addImport("gio2", gio2);
    pango1.addImport("gmodule2", gmodule2);
    pango1.addImport("pango1", pango1);
    harfbuzz0.addImport("freetype22", freetype22);
    harfbuzz0.addImport("gobject2", gobject2);
    harfbuzz0.addImport("glib2", glib2);
    harfbuzz0.addImport("harfbuzz0", harfbuzz0);
    freetype22.addImport("freetype22", freetype22);
    gio2.addImport("gobject2", gobject2);
    gio2.addImport("glib2", glib2);
    gio2.addImport("gmodule2", gmodule2);
    gio2.addImport("gio2", gio2);
    gmodule2.addImport("glib2", glib2);
    gmodule2.addImport("gmodule2", gmodule2);
    gtk3.addImport("xlib2", xlib2);
    gtk3.addImport("gdk3", gdk3);
    gtk3.addImport("cairo1", cairo1);
    gtk3.addImport("gobject2", gobject2);
    gtk3.addImport("glib2", glib2);
    gtk3.addImport("pango1", pango1);
    gtk3.addImport("harfbuzz0", harfbuzz0);
    gtk3.addImport("freetype22", freetype22);
    gtk3.addImport("gio2", gio2);
    gtk3.addImport("gmodule2", gmodule2);
    gtk3.addImport("gdkpixbuf2", gdkpixbuf2);
    gtk3.addImport("atk1", atk1);
    gtk3.addImport("gtk3", gtk3);
    xlib2.addImport("xlib2", xlib2);
    gdk3.addImport("cairo1", cairo1);
    gdk3.addImport("gobject2", gobject2);
    gdk3.addImport("glib2", glib2);
    gdk3.addImport("pango1", pango1);
    gdk3.addImport("harfbuzz0", harfbuzz0);
    gdk3.addImport("freetype22", freetype22);
    gdk3.addImport("gio2", gio2);
    gdk3.addImport("gmodule2", gmodule2);
    gdk3.addImport("gdkpixbuf2", gdkpixbuf2);
    gdk3.addImport("gdk3", gdk3);
    gdkpixbuf2.addImport("gio2", gio2);
    gdkpixbuf2.addImport("gobject2", gobject2);
    gdkpixbuf2.addImport("glib2", glib2);
    gdkpixbuf2.addImport("gmodule2", gmodule2);
    gdkpixbuf2.addImport("gdkpixbuf2", gdkpixbuf2);
    atk1.addImport("gobject2", gobject2);
    atk1.addImport("glib2", glib2);
    atk1.addImport("atk1", atk1);
    gimp3.addImport("cairo1", cairo1);
    gimp3.addImport("gobject2", gobject2);
    gimp3.addImport("glib2", glib2);
    gimp3.addImport("pango1", pango1);
    gimp3.addImport("harfbuzz0", harfbuzz0);
    gimp3.addImport("freetype22", freetype22);
    gimp3.addImport("gio2", gio2);
    gimp3.addImport("gmodule2", gmodule2);
    gimp3.addImport("gegl0", gegl0);
    gimp3.addImport("babl0", babl0);
    gimp3.addImport("gdkpixbuf2", gdkpixbuf2);
    gimp3.addImport("gimp3", gimp3);
    gegl0.addImport("gobject2", gobject2);
    gegl0.addImport("glib2", glib2);
    gegl0.addImport("babl0", babl0);
    gegl0.addImport("gegl0", gegl0);
    babl0.addImport("babl0", babl0);
    const docs_mod = b.createModule(.{
        .root_source_file = b.path("src/root/root.zig"),
        .target = target,
        .optimize = .Debug,
    });
    const docs_obj = b.addObject(.{
        .name = "docs",
        .root_module = docs_mod,
    });
    const install_docs = b.addInstallDirectory(.{
        .source_dir = docs_obj.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });
    docs_step.dependOn(&install_docs.step);
    docs_mod.addImport("gimpui3", gimpui3);
    docs_mod.addImport("cairo1", cairo1);
    docs_mod.addImport("gobject2", gobject2);
    docs_mod.addImport("glib2", glib2);
    docs_mod.addImport("pango1", pango1);
    docs_mod.addImport("harfbuzz0", harfbuzz0);
    docs_mod.addImport("freetype22", freetype22);
    docs_mod.addImport("gio2", gio2);
    docs_mod.addImport("gmodule2", gmodule2);
    docs_mod.addImport("gtk3", gtk3);
    docs_mod.addImport("xlib2", xlib2);
    docs_mod.addImport("gdk3", gdk3);
    docs_mod.addImport("gdkpixbuf2", gdkpixbuf2);
    docs_mod.addImport("atk1", atk1);
    docs_mod.addImport("gimp3", gimp3);
    docs_mod.addImport("gegl0", gegl0);
    docs_mod.addImport("babl0", babl0);
}

pub const libraries = struct {
    pub const gimpui3: Library = .{
        .system_libraries = &.{"gimpui-3.0"},
    };

    pub const cairo1: Library = .{
        .system_libraries = &.{"cairo-gobject"},
    };

    pub const gobject2: Library = .{
        .system_libraries = &.{"gobject-2.0"},
    };

    pub const glib2: Library = .{
        .system_libraries = &.{"glib-2.0"},
    };

    pub const pango1: Library = .{
        .system_libraries = &.{"pango"},
    };

    pub const harfbuzz0: Library = .{
        .system_libraries = &.{ "harfbuzz", "harfbuzz-gobject" },
    };

    pub const freetype22: Library = .{
        .system_libraries = &.{},
    };

    pub const gio2: Library = .{
        .system_libraries = &.{ "gio-2.0", "gio-unix-2.0" },
    };

    pub const gmodule2: Library = .{
        .system_libraries = &.{"gmodule-2.0"},
    };

    pub const gtk3: Library = .{
        .system_libraries = &.{"gtk+-3.0"},
    };

    pub const xlib2: Library = .{
        .system_libraries = &.{},
    };

    pub const gdk3: Library = .{
        .system_libraries = &.{"gdk-3.0"},
    };

    pub const gdkpixbuf2: Library = .{
        .system_libraries = &.{"gdk-pixbuf-2.0"},
    };

    pub const atk1: Library = .{
        .system_libraries = &.{"atk"},
    };

    pub const gimp3: Library = .{
        .system_libraries = &.{"gimp-3.0"},
    };

    pub const gegl0: Library = .{
        .system_libraries = &.{"gegl-0.4"},
    };

    pub const babl0: Library = .{
        .system_libraries = &.{"babl-0.1"},
    };
};
