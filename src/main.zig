
const gegl = @cImport({
    @cInclude("gegl.h");
});
const gtk = @import("gtk");
const gobject = @import("gobject");
const gimp = @cImport({
    @cInclude("gtk/gtk.h");
    @cInclude("libgimp/gimp.h");
    @cInclude("libgimp/gimpui.h");
    @cInclude("libgimpcolor/gimpcolor.h");
    @cInclude("libgimpconfig/gimpconfig.h");
    @cInclude("libgimpmath/gimpmath.h");
    @cInclude("libgimpmodule/gimpmodule.h");
    @cInclude("libgimpwidgets/gimpwidgets.h");
});

// #include "libgimpcolor/gimpcolor.h"
// #include "libgimpconfig/gimpconfig.h"
// #include "libgimpmath/gimpmath.h"
// #include "libgimp/gimp.h"
// #include "libgimpwidgets/gimpwidgets.h"
//
// #include "libgimp/libgimp-intl.h"

const DisplayFalseColour = extern struct {
    parent_instance: gimp.GimpColorDisplay,

    gradient: *gimp.GimpGradient,

    pub const Parent = gimp.GimpColorDisplay;

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
        buffer: *gegl.GeglBuffer,
        area: *gegl.GeglRectangle
    ) callconv(.c) void {
        const it: *gegl.GeglBufferIterator = gegl.gegl_buffer_iterator_new(
            buffer, area, 0, gegl.babl_format("R'G'B'A float"),
            gegl.GEGL_ACCESS_READWRITE, gegl.GEGL_ABYSS_NONE, 1);

        while(gegl.gegl_buffer_iterator_next(it) != 0) {
            const dataPtr: [*c][4]f32 = @alignCast(@ptrCast(it.items()[0].data));
            const dataSlice = dataPtr[0..@intCast(it.length)];
            for(dataSlice) |*pixel| {
                pixel[0..3].* = self.mapColour(0);
            }
        }
    }

    fn mapColour(_: *const DisplayFalseColour, value: f32) [3]f32 {
        return .{value, value, value};
    }

    fn configure(_: *DisplayFalseColour) callconv(.c) ?*gtk.Widget {
        //const gradientPicker = gimp.gimp_gradient_chooser_new("Gradient", "Gradient", self.gradient);
        //return @ptrCast(gradientPicker);
        return null;
    }

    fn changed(_: *gimp.GimpColorDisplay) callconv(.c) void {
    }

    fn setProperty(_: *DisplayFalseColour, _: u32, _: ?*const gobject.Value, _: ?*gobject.ParamSpec) callconv(.c) void {
    }

    fn getProperty(_: *DisplayFalseColour, _: u32, _: *gobject.Value, _: ?*gobject.ParamSpec) callconv(.c) void {
    }


    pub const Class = extern struct {
        parent_class: gimp.GimpColorDisplayClass,
        pub const Instance = DisplayFalseColour;

        pub fn as(class: *Class, comptime T: type) *T {
            return gobject.ext.as(T, class);
        }

        fn init(ptr: *gobject.TypeClass, _: ?*anyopaque) callconv(.c) void {
            const class: *Class = @ptrCast(@alignCast(ptr));
            // const displayClass = class.as(gimp.GimpColorDisplayClass);
            class.parent_class.convert_buffer = @ptrCast(&convertBuffer);
            class.parent_class.configure = @ptrCast(&configure);
            class.parent_class.changed = @ptrCast(&changed);

            class.parent_class.name = "False Colour";
            class.parent_class.help_id = "gimp-colordisplay-falsecolour";
            class.parent_class.icon_name = "gimp-display-filter";

            class.parent_class.parent_class.set_property = @ptrCast(&setProperty);
            class.parent_class.parent_class.get_property = @ptrCast(&getProperty);
        }
    };
};


// GimpModule declares these non-const for some reason

var purpose = "False colour display filter".*;
var author = "David Osborne <david.osborne@protonmail.com>".*;
var version = "v0.1".*;
var copyright = "(c) 2025, released under the GPL".*;
var date = "May 16, 2025".*;
var display_falsecolour_info: gimp.GimpModuleInfo =
.{
    .abi_version = gimp.GIMP_MODULE_ABI_VERSION,
    .purpose = &purpose,
    .author = &author,
    .version = &version,
    .copyright = &copyright,
    .date = &date,
};


export fn gimp_module_query (_: *gobject.TypeModule) callconv(.C) *gimp.GimpModuleInfo
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
        gimp.gimp_color_display_get_type(),
        "DisplayFalseColor",
        &typeInfo,
        .{}
    );

    return true;
}

