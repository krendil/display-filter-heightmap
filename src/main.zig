const std = @import("std");

const babl = @import("babl");
const gegl = @import("gegl");
const gtk = @import("gtk");
const gobject = @import("gobject");
const gimp = @import("gimp");
const gimpui = @import("gimpui");

var positiveColours: [19]*gegl.Color = undefined;
var negativeColours: [10]*gegl.Color = undefined; 

const DisplayFalseColour = extern struct {
    parent_instance: gimpui.ColorDisplay,

    resolution: c_uint,

    seaLevel: f64,

    private: *Private,

    const Private = struct {
        alloc: std.mem.Allocator = std.heap.c_allocator,
        buffer: ?[][3]f32 = null,

        var offset: c_int = @sizeOf(Private);
    };

    pub const Parent = gimpui.ColorDisplay;

    pub const properties = struct {

        pub const resolution = struct {
            pub const name = "resolution";
            const impl = gobject.ext.defineProperty(name, DisplayFalseColour, c_uint, .{
                .nick = "Gradient Resolution",
                .blurb = "How many samples are taken from the gradient when mapping values",
                .default = 16,
                .minimum = 1,
                .maximum = 65536,
                .accessor = .{ .getter = &getResolution, .setter = &setResolution },
                .construct = true,
            });
        };

        pub const seaLevel = struct {
            pub const name = "seaLevel";
            const impl = gobject.ext.defineProperty(name, DisplayFalseColour, f64, .{
                .nick = "Sea Level",
                .blurb = "What lightness level is considered sea level (0.0–1.0)",
                .default = 0.357,
                .minimum = 0.0,
                .maximum = 1.0,
                .accessor = .{ .getter = &getSeaLevel, .setter = &setSeaLevel },
                .construct = true,
            });
        };

    };

    fn getResolution(self: *const DisplayFalseColour) c_uint {
        return self.resolution;
    }

    fn setResolution(self: *DisplayFalseColour, value: c_uint) void {
        if(self.resolution != value) {
            self.resolution = value;
            self.rebuildBuffer();
        }
    }

    fn getSeaLevel(self: *const DisplayFalseColour) f64 {
        return self.seaLevel;
    }

    fn setSeaLevel(self: *DisplayFalseColour, value: f64) void {
        if(self.seaLevel != value) {
            self.seaLevel = value;
            self.resampleGradient();
        }
    }

    pub fn new() *DisplayFalseColour {
        return gobject.ext.newInstance(DisplayFalseColour, .{ });
    }

    pub fn as(self: *DisplayFalseColour, comptime T: type) *T {
        return gobject.ext.as(T, self);
    }

    fn init(instance: *gobject.TypeInstance, _: *gobject.TypeClass) callconv(.c) void {
        const self: *DisplayFalseColour = @ptrCast(instance);
        self.private = std.heap.c_allocator.create(Private) catch @panic("Out of Memory");
        self.private.* = .{};
    }

    fn finalize(self: *DisplayFalseColour) callconv(.c) void {
        if(self.private.buffer) |buffer| {
            self.private.alloc.free(buffer);
        }
        self.private.alloc.destroy(self.private);
    }

    fn constructed(self: *DisplayFalseColour) callconv(.c) void {
        gobject.Object.virtual_methods.constructed.call(Class.parent, &self.parent_instance);
    }

    fn convertBuffer(
        self: *DisplayFalseColour,
        buffer: *gegl.Buffer,
        area: *gegl.Rectangle
    ) callconv(.c) void {
        if(self.private.buffer) |gradient| {
            const it: *gegl.BufferIterator = buffer.iteratorNew(
                area, 0, babl.format("R'G'B'A float"),
                gegl.AccessMode.flags_readwrite, .none, 1);

            while(it.next() != 0) {
                if(it.f_items) |items| {
                    const dataPtr: [*c][4]f32 = @ptrCast(items);
                    const dataSlice = dataPtr[0..@intCast(it.f_length)];
                    for(dataSlice) |*pixel| {
                        const i: usize = @intFromFloat(std.math.round(pixel[0] * @as(f32, @floatFromInt(self.resolution - 1))));
                        pixel[0..3].* = gradient[i];
                    }
                } else {
                    break;
                }
            }
        }
    }

    // Reallocate the buffer and build a new one at the new resolution
    fn rebuildBuffer(self: *DisplayFalseColour) void {
        if(self.resolution > 0) {
            if(self.private.buffer) |buffer| {
                self.private.alloc.free(buffer);
            }
            self.private.buffer = self.private.alloc.alloc([3]f32, self.resolution) catch @panic("Out of Memory");
            self.resampleGradient();
        }
    }
    
    // Resample the gradient at the same resolution, without reallocating the buffer
    fn resampleGradient(self: *DisplayFalseColour) void {
        if(self.private.buffer) |buffer| {
            const format = babl.format("R'G'B' float");
            var hsv0: [4]f64 = undefined;
            var hsv1: [4]f64 = undefined;
            const mixed = gegl.Color.new("#FFFFFFFF");
            for(buffer, 0..) |*sample, i| {
                const p: f64 = @as(f64, @floatFromInt(i)) / @as(f64, @floatFromInt(self.resolution - 1));
                var mix: f64 = undefined;
                if(p < self.seaLevel) {
                    const point: f64 = (p / self.seaLevel) * @as(f64, @floatFromInt(negativeColours.len - 1));
                    const lower = std.math.floor(point);
                    const upper = std.math.ceil(point);
                    mix = point - lower;
                    negativeColours[@intFromFloat(lower)].getHsva(&hsv0[0], &hsv0[1], &hsv0[2], &hsv1[3], null);
                    negativeColours[@intFromFloat(upper)].getHsva(&hsv1[0], &hsv1[1], &hsv1[2], &hsv1[3], null);
                } else {
                    const point: f64 = ((p - self.seaLevel) / (1 - self.seaLevel)) * @as(f64, @floatFromInt(positiveColours.len - 1));
                    const lower = std.math.floor(point);
                    const upper = std.math.ceil(point);
                    mix = point - lower;
                    positiveColours[@intFromFloat(lower)].getHsva(&hsv0[0], &hsv0[1], &hsv0[2], &hsv1[3], null);
                    positiveColours[@intFromFloat(upper)].getHsva(&hsv1[0], &hsv1[1], &hsv1[2], &hsv1[3], null);
                }
                mixed.setHsva(
                    std.math.lerp(hsv0[0], hsv1[0], mix), // TODO handle hue properly
                    std.math.lerp(hsv0[1], hsv1[1], mix),
                    std.math.lerp(hsv0[2], hsv1[2], mix),
                    1, null
                );
                mixed.getPixel(format, sample);
            }
        }
    }

    pub const Class = extern struct {
        parent_class: Parent.Class,

        var parent: *Parent.Class = undefined;


        pub const Instance = DisplayFalseColour;

        pub fn as(class: *Class, comptime T: type) *T {
            return gobject.ext.as(T, class);
        }

        fn init(ptr: *gobject.TypeClass, _: ?*anyopaque) callconv(.c) void {

            // gobject.TypeClass.adjustPrivateOffset(ptr, &Private.offset);
            const class: *Class = @ptrCast(@alignCast(ptr));

            gobject.ext.registerProperties(class, &.{
                properties.resolution.impl,
                properties.seaLevel.impl,
            });

            gobject.Object.virtual_methods.constructed.implement(class, &constructed);
            gobject.Object.virtual_methods.finalize.implement(class, &finalize);

            gimpui.ColorDisplay.virtual_methods.convert_buffer.implement(class, &convertBuffer);
            // gimpui.ColorDisplay.virtual_methods.configure.implement(class, &configure);
            // gimpui.ColorDisplay.virtual_methods.changed.implement(class, &changed);


            class.parent_class.f_name = "False Colour";
            class.parent_class.f_help_id = "gimp-colordisplay-falsecolour";
            class.parent_class.f_icon_name = "gimp-display-filter";

            parent = @ptrCast(gobject.TypeClass.peekParent(ptr));

            @memcpy(&positiveColours, &[_]*gegl.Color{
                gegl.Color.new("#ACD0A5"),
                gegl.Color.new("#94BF8B"),
                gegl.Color.new("#A8C68F"),
                gegl.Color.new("#BDCC96"),
                gegl.Color.new("#D1D7AB"),
                gegl.Color.new("#E1E4B5"),
                gegl.Color.new("#EFEBC0"),
                gegl.Color.new("#E8E1B6"),
                gegl.Color.new("#DED6A3"),
                gegl.Color.new("#D3CA9D"),
                gegl.Color.new("#CAB982"),
                gegl.Color.new("#C3A76B"),
                gegl.Color.new("#B9985A"),
                gegl.Color.new("#AA8753"),
                gegl.Color.new("#AC9A7C"),
                gegl.Color.new("#BAAE9A"),
                gegl.Color.new("#CAC3B8"),
                gegl.Color.new("#E0DED8"),
                gegl.Color.new("#F5F4F2")
            });

            @memcpy(&negativeColours, &[_]*gegl.Color{
                gegl.Color.new("#71ABD8"),
                gegl.Color.new("#79B2DE"),
                gegl.Color.new("#84B9E3"),
                gegl.Color.new("#8DC1EA"),
                gegl.Color.new("#96C9F0"),
                gegl.Color.new("#A1D2F7"),
                gegl.Color.new("#ACDBFB"),
                gegl.Color.new("#B9E3FF"),
                gegl.Color.new("#C6ECFF"),
                gegl.Color.new("#D8F2FE"),
            });

        }

    };
};


// GimpModuleInfo declares these non-const for some reason
var purpose = "False colour display filter".*;
var author = "David Osborne <david.osborne@protonmail.com>".*;
var version = "v0.1".*;
var copyright = "(c) 2025, released under the GPL".*;
var date = "May 16, 2025".*;
var display_falsecolour_info: gimp.ModuleInfo =
.{
    .f_abi_version = gimp.MODULE_ABI_VERSION,
    .f_purpose = &purpose,
    .f_author = &author,
    .f_version = &version,
    .f_copyright = &copyright,
    .f_date = &date,
};


export fn gimp_module_query (_: *gobject.TypeModule) callconv(.C) *gimp.ModuleInfo
{
    return &display_falsecolour_info;
}

export fn gimp_module_register(module: *gobject.TypeModule) callconv(.C) bool
{
    const typeInfo = gobject.TypeInfo{
        .f_class_size = @sizeOf(DisplayFalseColour.Class),
        .f_base_init = null,
        .f_base_finalize = null,
        .f_class_init = &DisplayFalseColour.Class.init,
        .f_class_finalize = null,
        .f_class_data = null,
        .f_instance_size = @sizeOf(DisplayFalseColour),
        .f_n_preallocs = 0,      // n_preallocs
        .f_instance_init = &DisplayFalseColour.init,
        .f_value_table = null    // value_table
      };

    _ = module.registerType(
        gobject.ext.typeFor(gimpui.ColorDisplay),
        "DisplayFalseColor",
        &typeInfo,
        .{}
    );


    return true;
}

