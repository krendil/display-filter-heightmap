const std = @import("std");

const babl = @import("babl");
const gegl = @import("gegl");
const gtk = @import("gtk");
const gobject = @import("gobject");
const gimp = @import("gimp");
const gimpui = @import("gimpui");

// #include "libgimpcolor/gimpcolor.h"
// #include "libgimpconfig/gimpconfig.h"
// #include "libgimpmath/gimpmath.h"
// #include "libgimp/gimp.h"
// #include "libgimpwidgets/gimpwidgets.h"
//
// #include "libgimp/libgimp-intl.h"

fn getDefaultGradient() *gimp.Gradient {
    const rainbowN = gimp.Gradient.getByName("Full Saturation Spectrum CCW");
    if(rainbowN) |rainbow| {
        return rainbow;
    } else {
        return gimp.Gradient.new();
    }
}
const defaultGradient = getDefaultGradient();

const DisplayFalseColour = extern struct {
    parent_instance: gimpui.ColorDisplay,

    gradient: ?*gimp.Gradient,

    pub const Parent = gimpui.ColorDisplay;

    pub const properties = struct {

        pub const gradient = struct {
            pub const name = "gradient";
            const impl = gobject.ext.defineProperty(name, DisplayFalseColour, ?*gimp.Gradient, .{
                .nick = "Gradient",
                .blurb = "The gradient to map values to",
                .default = null,
                .accessor = gobject.ext.fieldAccessor(DisplayFalseColour, "gradient")
            });
        };
    };

    // pub const getGObjectType = gobject.ext.defineClass(DisplayFalseColour, .{
    //     .classInit = &Class.init,
    // });


    pub fn new() *DisplayFalseColour {
        return gobject.ext.newInstance(DisplayFalseColour, .{ });
    }

    pub fn as(self: *DisplayFalseColour, comptime T: type) *T {
        return gobject.ext.as(T, self);
    }

    fn convertBuffer(
        self: *DisplayFalseColour,
        buffer: *gegl.Buffer,
        area: *gegl.Rectangle
    ) callconv(.c) void {
        const it: *gegl.BufferIterator = buffer.iteratorNew(
            area, 0, babl.format("R'G'B'A float"),
            gegl.AccessMode.flags_readwrite, .none, 1);

        while(it.next() != 0) {
            if(it.f_items) |items| {
                const dataPtr: [*c][4]f32 = @ptrCast(items);
                const dataSlice = dataPtr[0..@intCast(it.f_length)];
                for(dataSlice) |*pixel| {
                    // @memcpy(pixel[0..12], std.mem.sliceAsBytes(self.mapColour(0)));
                    pixel[0..3].* = self.mapColour(0);
                }
            } else {
                break;
            }
        }
    }

    fn mapColour(_: *const DisplayFalseColour, value: f32) [3] f32 {
        return .{value, value, value};
    }

    fn configure(_: *DisplayFalseColour) callconv(.c) *gtk.Widget {
        // const gradientPicker = gimpui.propGradientChooserNew(self.as(gobject.Object), "gradient", "Gradient");
        // return gradientPicker;
        return gtk.Button.newWithLabel("Test").as(gtk.Widget);
    }

    fn changed(_: *DisplayFalseColour) callconv(.c) void {
    }

    fn setProperty(_: *DisplayFalseColour, _: u32, _: ?*const gobject.Value, _: ?*gobject.ParamSpec) callconv(.c) void {
    }

    fn getProperty(_: *DisplayFalseColour, _: u32, _: *gobject.Value, _: ?*gobject.ParamSpec) callconv(.c) void {
    }


    pub const Class = extern struct {
        parent_class: Parent.Class,
        pub const Instance = DisplayFalseColour;

        pub fn as(class: *Class, comptime T: type) *T {
            return gobject.ext.as(T, class);
        }

        fn init(ptr: *gobject.TypeClass, _: ?*anyopaque) callconv(.c) void {
            const class: *Class = @ptrCast(@alignCast(ptr));

            gobject.ext.registerProperties(class, &.{
                properties.gradient.impl,
            });

            gimpui.ColorDisplay.virtual_methods.convert_buffer.implement(class, &convertBuffer);
            // gimpui.ColorDisplay.virtual_methods.configure.implement(class, &configure);
            // gimpui.ColorDisplay.virtual_methods.changed.implement(class, &changed);


            class.parent_class.f_name = "False Colour";
            class.parent_class.f_help_id = "gimp-colordisplay-falsecolour";
            class.parent_class.f_icon_name = "gimp-display-filter";

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
        .f_instance_init = null,
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

