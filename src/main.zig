
const gegl = @cImport({
    @cInclude("gegl.h");
});
const gtk = @import("gtk");
const gobject = @import("gobject");
const gimp = @cImport({
    @cInclude("gtk/gtk.h");
    @cInclude("gimp.h");
    @cInclude("gimpcolor.h");
    @cInclude("gimpconfig.h");
    @cInclude("gimpmath.h");
    @cInclude("gimpmodule.h");
    @cInclude("gimpwidgets.h");
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
        _: *gimp.GimpColorDisplay,
        _: *gegl.GeglBuffer,
        _: *gegl.GeglRectangle
    ) callconv(.c) void {
    }

    fn configure(_: *gimp.GimpColorDisplay) callconv(.c) ?*gtk.Widget {
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



// GType              cdisplay_contrast_get_type        (void);
//
// static void        cdisplay_contrast_set_property    (GObject          *object,
//                                                       guint             property_id,
//                                                       const GValue     *value,
//                                                       GParamSpec       *pspec);
// static void        cdisplay_contrast_get_property    (GObject          *object,
//                                                       guint             property_id,
//                                                       GValue           *value,
//                                                       GParamSpec       *pspec);
//
// static void        cdisplay_contrast_convert_buffer  (GimpColorDisplay *display,
//                                                       GeglBuffer       *buffer,
//                                                       GeglRectangle    *area);
// static void        cdisplay_contrast_set_contrast    (CdisplayContrast *contrast,
//                                                       gdouble           value);

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


// G_DEFINE_DYNAMIC_TYPE (CdisplayContrast, cdisplay_contrast,
//                        GIMP_TYPE_COLOR_DISPLAY)
//
//
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


//
// static void
// cdisplay_contrast_class_init (CdisplayContrastClass *klass)
// {
//   GObjectClass          *object_class  = G_OBJECT_CLASS (klass);
//   GimpColorDisplayClass *display_class = GIMP_COLOR_DISPLAY_CLASS (klass);
//
//   object_class->get_property     = cdisplay_contrast_get_property;
//   object_class->set_property     = cdisplay_contrast_set_property;
//
//   GIMP_CONFIG_PROP_DOUBLE (object_class, PROP_CONTRAST,
//                            "contrast",
//                            _("Contrast cycles"),
//                            NULL,
//                            0.01, 10.0, DEFAULT_CONTRAST,
//                            0);
//
//   display_class->name            = _("Contrast");
//   display_class->help_id         = "gimp-colordisplay-contrast";
//   display_class->icon_name       = GIMP_ICON_DISPLAY_FILTER_CONTRAST;
//
//   display_class->convert_buffer  = cdisplay_contrast_convert_buffer;
// }
//
// static void
// cdisplay_contrast_class_finalize (CdisplayContrastClass *klass)
// {
// }
//
// static void
// cdisplay_contrast_init (CdisplayContrast *contrast)
// {
// }
//
// static void
// cdisplay_contrast_get_property (GObject    *object,
//                                 guint       property_id,
//                                 GValue     *value,
//                                 GParamSpec *pspec)
// {
//   CdisplayContrast *contrast = CDISPLAY_CONTRAST (object);
//
//   switch (property_id)
//     {
//     case PROP_CONTRAST:
//       g_value_set_double (value, contrast->contrast);
//       break;
//     default:
//       G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
//       break;
//     }
// }
//
// static void
// cdisplay_contrast_set_property (GObject      *object,
//                                 guint         property_id,
//                                 const GValue *value,
//                                 GParamSpec   *pspec)
// {
//   CdisplayContrast *contrast = CDISPLAY_CONTRAST (object);
//
//   switch (property_id)
//     {
//     case PROP_CONTRAST:
//       cdisplay_contrast_set_contrast (contrast, g_value_get_double (value));
//       break;
//     default:
//       G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
//       break;
//     }
// }
//
// static void
// cdisplay_contrast_convert_buffer (GimpColorDisplay *display,
//                                   GeglBuffer       *buffer,
//                                   GeglRectangle    *area)
// {
//   CdisplayContrast   *contrast = CDISPLAY_CONTRAST (display);
//   GeglBufferIterator *iter;
//   gfloat              c;
//
//   c = contrast->contrast * 2 * G_PI;
//
//   iter = gegl_buffer_iterator_new (buffer, area, 0,
//                                    babl_format ("R'G'B'A float"),
//                                    GEGL_ACCESS_READWRITE, GEGL_ABYSS_NONE, 1);
//
//   while (gegl_buffer_iterator_next (iter))
//     {
//       gfloat *data  = iter->items[0].data;
//       gint    count = iter->length;
//
//       while (count--)
//         {
//           *data = 0.5 * (1.0 + sin (c * *data)); data++;
//           *data = 0.5 * (1.0 + sin (c * *data)); data++;
//           *data = 0.5 * (1.0 + sin (c * *data)); data++;
//
//           data++;
//         }
//     }
// }
//
// static void
// cdisplay_contrast_set_contrast (CdisplayContrast *contrast,
//                                 gdouble           value)
// {
//   if (value <= 0.0)
//     value = 1.0;
//
//   if (value != contrast->contrast)
//     {
//       contrast->contrast = value;
//
//       g_object_notify (G_OBJECT (contrast), "contrast");
//       gimp_color_display_changed (GIMP_COLOR_DISPLAY (contrast));
//     }
// }
