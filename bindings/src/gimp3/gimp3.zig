pub const ext = @import("ext.zig");
const gimp = @This();

const std = @import("std");
const compat = @import("compat");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const pango = @import("pango1");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
const gegl = @import("gegl0");
const babl = @import("babl0");
const gdkpixbuf = @import("gdkpixbuf2");
/// This type is simply a wrapper around `babl.Object` when used as
/// a color format.
///
/// The only reason of this wrapper is to be able to assign a `gobject.Type` to
/// Babl formats, e.g. to have typed `GValue`, which is mostly used
/// internally by our plug-in protocol.
///
/// There is no reason whatsoever to use this type directly.
pub const BablFormat = *const babl.Object;

/// A boxed type which is nothing more than an alias to a `NULL`-terminated array
/// of `gegl.Color`.
///
/// The code fragments in the following example show the use of a property of
/// type `GIMP_TYPE_COLOR_ARRAY` with `gobject.ObjectClass.installProperty`,
/// `gobject.Object.set` and `gobject.Object.get`.
///
/// ```C
/// g_object_class_install_property (object_class,
///                                  PROP_COLORS,
///                                  g_param_spec_boxed ("colors",
///                                                      _("Colors"),
///                                                      _("List of colors"),
///                                                      GIMP_TYPE_COLOR_ARRAY,
///                                                      G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS));
///
/// GeglColor *colors[] = { gegl_color_new ("red"), gegl_color_new ("blue"), NULL };
///
/// g_object_set (obj, "colors", colors, NULL);
///
/// GeglColors **colors;
///
/// g_object_get (obj, "colors", &colors, NULL);
/// gimp_color_array_free (colors);
/// ```
pub const ColorArray = **gegl.Color;

/// A boxed type which is nothing more than an alias to a `NULL`-terminated array
/// of `gobject.Object`. No reference is being hold on contents
/// because core objects are owned by `libgimp`.
///
/// The reason of existence for this alias is to have common arrays of
/// objects as a boxed type easy to use as plug-in's procedure argument.
///
/// You should never have to interact with this type directly, though
/// `gimp.coreObjectArrayGetLength` might be convenient.
pub const CoreObjectArray = **gobject.Object;

/// Batch procedures implement an interpreter able to run commands as input.
///
/// In particular, batch procedures will be available on the command line
/// through the `--batch-interpreter` option to switch the chosen interpreter.
/// Then any command given through the `--batch` option will have to be in the
/// chosen language.
///
/// It makes GIMP usable on the command line, but also to process small scripts
/// (without making full-featured plug-ins), fully in command line without
/// graphical interface.
pub const BatchProcedure = opaque {
    pub const Parent = gimp.Procedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.BatchProcedureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new batch interpreter procedure named `name` which will call
    /// `run_func` when invoked.
    ///
    /// See `gimp.Procedure.new` for information about `proc_type`.
    ///
    /// `gimp.BatchProcedure` is a `gimp.Procedure` subclass that makes it easier
    /// to write batch interpreter procedures.
    ///
    /// It automatically adds the standard
    ///
    /// (`gimp.RunMode`, `gchar`)
    ///
    /// arguments of a batch procedure. It is possible to add additional
    /// arguments.
    ///
    /// When invoked via `gimp.Procedure.run`, it unpacks these standard
    /// arguments and calls `run_func` which is a `gimp.BatchFunc`. The "args"
    /// `gimp.ValueArray` of `GimpRunSaveFunc` only contains additionally added
    /// arguments.
    extern fn gimp_batch_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_interpreter_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_run_func: gimp.BatchFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.BatchProcedure;
    pub const new = gimp_batch_procedure_new;

    /// Returns the procedure's interpreter name, as set with
    /// `BatchProcedure.setInterpreterName`.
    extern fn gimp_batch_procedure_get_interpreter_name(p_procedure: *BatchProcedure) [*:0]const u8;
    pub const getInterpreterName = gimp_batch_procedure_get_interpreter_name;

    /// Associates an interpreter name with a batch procedure.
    ///
    /// This name can be used for any public-facing strings, such as
    /// graphical interface labels or command line usage. E.g. the command
    /// line interface could list all available interface, displaying both a
    /// procedure name and a "pretty printing" title.
    ///
    /// Note that since the format name is public-facing, it is recommended
    /// to localize it at runtime, for instance through gettext, like:
    ///
    /// ```c
    /// gimp_batch_procedure_set_interpreter_name (procedure, _("Python 3"));
    /// ```
    ///
    /// Some language would indeed localize even some technical terms or
    /// acronyms, even if sometimes just to rewrite them with the local
    /// writing system.
    extern fn gimp_batch_procedure_set_interpreter_name(p_procedure: *BatchProcedure, p_interpreter_name: [*:0]const u8) void;
    pub const setInterpreterName = gimp_batch_procedure_set_interpreter_name;

    extern fn gimp_batch_procedure_get_type() usize;
    pub const getGObjectType = gimp_batch_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.BatchProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.BatchProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BatchProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Installable object used by painting and stroking tools.
pub const Brush = opaque {
    pub const Parent = gimp.Resource;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.BrushClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the brush with the given name.
    ///
    /// Return an existing brush having the given name. Returns `NULL` when
    /// no brush exists of that name.
    extern fn gimp_brush_get_by_name(p_name: [*:0]const u8) ?*gimp.Brush;
    pub const getByName = gimp_brush_get_by_name;

    /// Create a new generated brush having default parameters.
    ///
    /// Creates a new, parametric brush.
    extern fn gimp_brush_new(p_name: [*:0]const u8) *gimp.Brush;
    pub const new = gimp_brush_new;

    /// Gets the rotation angle of a generated brush.
    ///
    /// Gets the angle of rotation for a generated brush. Returns an error
    /// when called for a non-parametric brush.
    extern fn gimp_brush_get_angle(p_brush: *Brush, p_angle: *f64) c_int;
    pub const getAngle = gimp_brush_get_angle;

    /// Gets the aspect ratio of a generated brush.
    ///
    /// Gets the aspect ratio of a generated brush. Returns an error when
    /// called for a non-parametric brush. The aspect ratio is a double
    /// between 0.0 and 1000.0.
    extern fn gimp_brush_get_aspect_ratio(p_brush: *Brush, p_aspect_ratio: *f64) c_int;
    pub const getAspectRatio = gimp_brush_get_aspect_ratio;

    /// Gets pixel data of the brush within the bounding box specified by `max_width`
    /// and `max_height`. The data will be scaled down so that it fits within this
    /// size without changing its ratio. If the brush is smaller than this size to
    /// begin with, it will not be scaled up.
    ///
    /// If `max_width` or `max_height` are `NULL`, the buffer is returned in the brush's
    /// native size.
    ///
    /// When the brush is parametric or a raster mask, only the mask (as returned by
    /// `gimp.Brush.getMask`) will be set. The returned buffer will be NULL.
    ///
    /// Make sure you called `gegl.init` before calling any function using
    /// `GEGL`.
    extern fn gimp_brush_get_buffer(p_brush: *Brush, p_max_width: c_int, p_max_height: c_int, p_format: *const babl.Object) *gegl.Buffer;
    pub const getBuffer = gimp_brush_get_buffer;

    /// Gets the hardness of a generated brush.
    ///
    /// Gets the hardness of a generated brush. The hardness of a brush is
    /// the amount its intensity fades at the outside edge, as a double
    /// between 0.0 and 1.0. Returns an error when called for a
    /// non-parametric brush.
    extern fn gimp_brush_get_hardness(p_brush: *Brush, p_hardness: *f64) c_int;
    pub const getHardness = gimp_brush_get_hardness;

    /// Gets information about the brush.
    ///
    /// Gets information about the brush: brush extents (width and height),
    /// color depth and mask depth (bpp). The color bpp is zero when the
    /// brush is parametric versus raster.
    extern fn gimp_brush_get_info(p_brush: *Brush, p_width: *c_int, p_height: *c_int, p_mask_bpp: *c_int, p_color_bpp: *c_int) c_int;
    pub const getInfo = gimp_brush_get_info;

    /// Gets mask data of the brush within the bounding box specified by `max_width`
    /// and `max_height`. The data will be scaled down so that it fits within this
    /// size without changing its ratio. If the brush is smaller than this size to
    /// begin with, it will not be scaled up.
    ///
    /// If `max_width` or `max_height` are `NULL`, the buffer is returned in the brush's
    /// native size.
    ///
    /// Make sure you called `gegl.init` before calling any function using
    /// `GEGL`.
    extern fn gimp_brush_get_mask(p_brush: *Brush, p_max_width: c_int, p_max_height: c_int, p_format: *const babl.Object) *gegl.Buffer;
    pub const getMask = gimp_brush_get_mask;

    /// Gets the radius of a generated brush.
    ///
    /// Gets the radius of a generated brush. Returns an error when called
    /// for a non-parametric brush.
    extern fn gimp_brush_get_radius(p_brush: *Brush, p_radius: *f64) c_int;
    pub const getRadius = gimp_brush_get_radius;

    /// Gets the shape of a generated brush.
    ///
    /// Gets the shape of a generated brush. Returns an error when called
    /// for a non-parametric brush. The choices for shape are Circle
    /// (GIMP_BRUSH_GENERATED_CIRCLE), Square (GIMP_BRUSH_GENERATED_SQUARE),
    /// and Diamond (GIMP_BRUSH_GENERATED_DIAMOND). Other shapes might be
    /// added in the future.
    extern fn gimp_brush_get_shape(p_brush: *Brush, p_shape: *gimp.BrushGeneratedShape) c_int;
    pub const getShape = gimp_brush_get_shape;

    /// Gets the brush spacing, the stamping frequency.
    ///
    /// Returns the spacing setting for the brush. Spacing is an integer
    /// between 0 and 1000 which represents a percentage of the maximum of
    /// the width and height of the mask. Both parametric and raster brushes
    /// have a spacing.
    extern fn gimp_brush_get_spacing(p_brush: *Brush) c_int;
    pub const getSpacing = gimp_brush_get_spacing;

    /// Gets the number of spikes for a generated brush.
    ///
    /// Gets the number of spikes for a generated brush. Returns an error
    /// when called for a non-parametric brush.
    extern fn gimp_brush_get_spikes(p_brush: *Brush, p_spikes: *c_int) c_int;
    pub const getSpikes = gimp_brush_get_spikes;

    /// Whether the brush is generated (parametric versus raster).
    ///
    /// Returns TRUE when brush is parametric.
    extern fn gimp_brush_is_generated(p_brush: *Brush) c_int;
    pub const isGenerated = gimp_brush_is_generated;

    /// Sets the rotation angle of a generated brush.
    ///
    /// Sets the rotation angle for a generated brush. Sets the angle modulo
    /// 180, in the range [-180.0, 180.0]. Returns the clamped value.
    /// Returns an error when brush is non-parametric or not editable.
    extern fn gimp_brush_set_angle(p_brush: *Brush, p_angle_in: f64, p_angle_out: *f64) c_int;
    pub const setAngle = gimp_brush_set_angle;

    /// Sets the aspect ratio of a generated brush.
    ///
    /// Sets the aspect ratio for a generated brush. Clamps aspect ratio to
    /// [0.0, 1000.0]. Returns the clamped value. Returns an error when
    /// brush is non-parametric or not editable.
    extern fn gimp_brush_set_aspect_ratio(p_brush: *Brush, p_aspect_ratio_in: f64, p_aspect_ratio_out: *f64) c_int;
    pub const setAspectRatio = gimp_brush_set_aspect_ratio;

    /// Sets the hardness of a generated brush.
    ///
    /// Sets the hardness for a generated brush. Clamps hardness to [0.0,
    /// 1.0]. Returns the clamped value. Returns an error when brush is
    /// non-parametric or not editable.
    extern fn gimp_brush_set_hardness(p_brush: *Brush, p_hardness_in: f64, p_hardness_out: *f64) c_int;
    pub const setHardness = gimp_brush_set_hardness;

    /// Sets the radius of a generated brush.
    ///
    /// Sets the radius for a generated brush. Clamps radius to [0.0,
    /// 32767.0]. Returns the clamped value. Returns an error when brush is
    /// non-parametric or not editable.
    extern fn gimp_brush_set_radius(p_brush: *Brush, p_radius_in: f64, p_radius_out: *f64) c_int;
    pub const setRadius = gimp_brush_set_radius;

    /// Sets the shape of a generated brush.
    ///
    /// Sets the shape of a generated brush. Returns an error when brush is
    /// non-parametric or not editable. The choices for shape are Circle
    /// (GIMP_BRUSH_GENERATED_CIRCLE), Square (GIMP_BRUSH_GENERATED_SQUARE),
    /// and Diamond (GIMP_BRUSH_GENERATED_DIAMOND).
    extern fn gimp_brush_set_shape(p_brush: *Brush, p_shape_in: gimp.BrushGeneratedShape, p_shape_out: *gimp.BrushGeneratedShape) c_int;
    pub const setShape = gimp_brush_set_shape;

    /// Sets the brush spacing.
    ///
    /// Set the spacing for the brush. The spacing must be an integer
    /// between 0 and 1000. Both parametric and raster brushes have a
    /// spacing. Returns an error when the brush is not editable. Create a
    /// new or copied brush or to get an editable brush.
    extern fn gimp_brush_set_spacing(p_brush: *Brush, p_spacing: c_int) c_int;
    pub const setSpacing = gimp_brush_set_spacing;

    /// Sets the number of spikes for a generated brush.
    ///
    /// Sets the number of spikes for a generated brush. Clamps spikes to
    /// [2,20]. Returns the clamped value. Returns an error when brush is
    /// non-parametric or not editable.
    extern fn gimp_brush_set_spikes(p_brush: *Brush, p_spikes_in: c_int, p_spikes_out: *c_int) c_int;
    pub const setSpikes = gimp_brush_set_spikes;

    extern fn gimp_brush_get_type() usize;
    pub const getGObjectType = gimp_brush_get_type;

    extern fn g_object_ref(p_self: *gimp.Brush) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Brush) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Brush, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions for manipulating channels.
pub const Channel = extern struct {
    pub const Parent = gimp.Drawable;
    pub const Implements = [_]type{};
    pub const Class = gimp.ChannelClass;
    f_parent_instance: gimp.Drawable,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `gimp.Channel` representing `channel_id`. This function
    /// calls `gimp.Item.getById` and returns the item if it is channel
    /// or `NULL` otherwise.
    extern fn gimp_channel_get_by_id(p_channel_id: i32) ?*gimp.Channel;
    pub const getById = gimp_channel_get_by_id;

    /// Create a new channel.
    ///
    /// This procedure creates a new channel with the specified `width`,
    /// `height`, `name`, `opacity` and `color`.
    ///
    /// Other attributes, such as channel visibility, should be set with
    /// explicit procedure calls.
    ///
    /// The new channel still needs to be added to the image, as this is not
    /// automatic. Add the new channel with
    /// `gimp.Image.insertChannel`.
    ///
    /// The channel's contents are undefined initially.
    extern fn gimp_channel_new(p_image: *gimp.Image, p_name: [*:0]const u8, p_width: c_int, p_height: c_int, p_opacity: f64, p_color: *gegl.Color) *gimp.Channel;
    pub const new = gimp_channel_new;

    /// Create a new channel from a color component
    ///
    /// This procedure creates a new channel from a color component.
    /// The new channel still needs to be added to the image, as this is not
    /// automatic. Add the new channel with `gimp.Image.insertChannel`.
    /// Other attributes, such as channel visibility, should be set with
    /// explicit procedure calls.
    extern fn gimp_channel_new_from_component(p_image: *gimp.Image, p_component: gimp.ChannelType, p_name: [*:0]const u8) *gimp.Channel;
    pub const newFromComponent = gimp_channel_new_from_component;

    /// Combine two channel masks.
    ///
    /// This procedure combines two channel masks. The result is stored in
    /// the first channel.
    extern fn gimp_channel_combine_masks(p_channel1: *Channel, p_channel2: *gimp.Channel, p_operation: gimp.ChannelOps, p_offx: c_int, p_offy: c_int) c_int;
    pub const combineMasks = gimp_channel_combine_masks;

    /// Copy a channel.
    ///
    /// This procedure copies the specified channel and returns the copy.
    /// The new channel still needs to be added to the image, as this is not
    /// automatic. Add the new channel with `gimp.Image.insertChannel`.
    extern fn gimp_channel_copy(p_channel: *Channel) *gimp.Channel;
    pub const copy = gimp_channel_copy;

    /// Get the compositing color of the specified channel.
    ///
    /// This procedure returns the specified channel's compositing color.
    extern fn gimp_channel_get_color(p_channel: *Channel) *gegl.Color;
    pub const getColor = gimp_channel_get_color;

    /// Get the opacity of the specified channel.
    ///
    /// This procedure returns the specified channel's opacity.
    extern fn gimp_channel_get_opacity(p_channel: *Channel) f64;
    pub const getOpacity = gimp_channel_get_opacity;

    /// Get the composite method of the specified channel.
    ///
    /// This procedure returns the specified channel's composite method. If
    /// it is TRUE, then the channel is composited with the image so that
    /// masked regions are shown. Otherwise, selected regions are shown.
    extern fn gimp_channel_get_show_masked(p_channel: *Channel) c_int;
    pub const getShowMasked = gimp_channel_get_show_masked;

    /// Set the compositing color of the specified channel.
    ///
    /// This procedure sets the specified channel's compositing color.
    extern fn gimp_channel_set_color(p_channel: *Channel, p_color: *gegl.Color) c_int;
    pub const setColor = gimp_channel_set_color;

    /// Set the opacity of the specified channel.
    ///
    /// This procedure sets the specified channel's opacity.
    extern fn gimp_channel_set_opacity(p_channel: *Channel, p_opacity: f64) c_int;
    pub const setOpacity = gimp_channel_set_opacity;

    /// Set the composite method of the specified channel.
    ///
    /// This procedure sets the specified channel's composite method. If it
    /// is TRUE, then the channel is composited with the image so that
    /// masked regions are shown. Otherwise, selected regions are shown.
    extern fn gimp_channel_set_show_masked(p_channel: *Channel, p_show_masked: c_int) c_int;
    pub const setShowMasked = gimp_channel_set_show_masked;

    extern fn gimp_channel_get_type() usize;
    pub const getGObjectType = gimp_channel_get_type;

    extern fn g_object_ref(p_self: *gimp.Channel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Channel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Channel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Choice = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ChoiceClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const sensitivity_changed = struct {
            pub const name = "sensitivity-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Choice, p_instance))),
                    gobject.signalLookup("sensitivity-changed", Choice.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn gimp_choice_new() *gimp.Choice;
    pub const new = gimp_choice_new;

    extern fn gimp_choice_new_with_values(p_nick: [*:0]const u8, p_id: c_int, p_label: [*:0]const u8, p_help: [*:0]const u8, ...) *gimp.Choice;
    pub const newWithValues = gimp_choice_new_with_values;

    /// This procedure adds a new possible value to `choice` list of values.
    /// The `id` is an optional integer identifier. This can be useful for instance
    /// when you want to work with different enum values mapped to each `nick`.
    extern fn gimp_choice_add(p_choice: *Choice, p_nick: [*:0]const u8, p_id: c_int, p_label: [*:0]const u8, p_help: [*:0]const u8) void;
    pub const add = gimp_choice_add;

    /// Returns the documentation strings for `nick`.
    extern fn gimp_choice_get_documentation(p_choice: *Choice, p_nick: [*:0]const u8, p_label: *[*:0]const u8, p_help: *[*:0]const u8) c_int;
    pub const getDocumentation = gimp_choice_get_documentation;

    /// Returns the longer documentation for `nick`.
    extern fn gimp_choice_get_help(p_choice: *Choice, p_nick: [*:0]const u8) [*:0]const u8;
    pub const getHelp = gimp_choice_get_help;

    extern fn gimp_choice_get_id(p_choice: *Choice, p_nick: [*:0]const u8) c_int;
    pub const getId = gimp_choice_get_id;

    extern fn gimp_choice_get_label(p_choice: *Choice, p_nick: [*:0]const u8) [*:0]const u8;
    pub const getLabel = gimp_choice_get_label;

    /// This procedure checks if the given `nick` is valid and refers to
    /// an existing choice.
    extern fn gimp_choice_is_valid(p_choice: *Choice, p_nick: [*:0]const u8) c_int;
    pub const isValid = gimp_choice_is_valid;

    /// This procedure returns the list of nicks allowed for `choice`.
    extern fn gimp_choice_list_nicks(p_choice: *Choice) *glib.List;
    pub const listNicks = gimp_choice_list_nicks;

    /// Change the sensitivity of a possible `nick`. Technically a non-sensitive `nick`
    /// means it cannot be chosen anymore (so `gimp.Choice.isValid` will
    /// return `FALSE`; nevertheless `gimp.Choice.listNicks` and other
    /// functions to get information about a choice will still function).
    extern fn gimp_choice_set_sensitive(p_choice: *Choice, p_nick: [*:0]const u8, p_sensitive: c_int) void;
    pub const setSensitive = gimp_choice_set_sensitive;

    extern fn gimp_choice_get_type() usize;
    pub const getGObjectType = gimp_choice_get_type;

    extern fn g_object_ref(p_self: *gimp.Choice) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Choice) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Choice, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Color management settings.
pub const ColorConfig = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.ColorConfigClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const cmyk_profile = struct {
            pub const name = "cmyk-profile";

            pub const Type = ?*gimp.ConfigPath;
        };

        pub const display_optimize = struct {
            pub const name = "display-optimize";

            pub const Type = c_int;
        };

        pub const display_profile = struct {
            pub const name = "display-profile";

            pub const Type = ?*gimp.ConfigPath;
        };

        pub const display_profile_from_gdk = struct {
            pub const name = "display-profile-from-gdk";

            pub const Type = c_int;
        };

        pub const display_rendering_intent = struct {
            pub const name = "display-rendering-intent";

            pub const Type = gimp.ColorRenderingIntent;
        };

        pub const display_use_black_point_compensation = struct {
            pub const name = "display-use-black-point-compensation";

            pub const Type = c_int;
        };

        pub const gray_profile = struct {
            pub const name = "gray-profile";

            pub const Type = ?*gimp.ConfigPath;
        };

        pub const mode = struct {
            pub const name = "mode";

            pub const Type = gimp.ColorManagementMode;
        };

        pub const out_of_gamut_color = struct {
            pub const name = "out-of-gamut-color";

            pub const Type = ?*gegl.Color;
        };

        pub const rgb_profile = struct {
            pub const name = "rgb-profile";

            pub const Type = ?*gimp.ConfigPath;
        };

        pub const show_hsv = struct {
            pub const name = "show-hsv";

            pub const Type = c_int;
        };

        pub const show_rgb_u8 = struct {
            pub const name = "show-rgb-u8";

            pub const Type = c_int;
        };

        pub const simulation_gamut_check = struct {
            pub const name = "simulation-gamut-check";

            pub const Type = c_int;
        };

        pub const simulation_optimize = struct {
            pub const name = "simulation-optimize";

            pub const Type = c_int;
        };

        pub const simulation_profile = struct {
            pub const name = "simulation-profile";

            pub const Type = ?*gimp.ConfigPath;
        };

        pub const simulation_rendering_intent = struct {
            pub const name = "simulation-rendering-intent";

            pub const Type = gimp.ColorRenderingIntent;
        };

        pub const simulation_use_black_point_compensation = struct {
            pub const name = "simulation-use-black-point-compensation";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gimp_color_config_get_cmyk_color_profile(p_config: *ColorConfig, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const getCmykColorProfile = gimp_color_config_get_cmyk_color_profile;

    extern fn gimp_color_config_get_display_bpc(p_config: *ColorConfig) c_int;
    pub const getDisplayBpc = gimp_color_config_get_display_bpc;

    extern fn gimp_color_config_get_display_color_profile(p_config: *ColorConfig, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const getDisplayColorProfile = gimp_color_config_get_display_color_profile;

    extern fn gimp_color_config_get_display_intent(p_config: *ColorConfig) gimp.ColorRenderingIntent;
    pub const getDisplayIntent = gimp_color_config_get_display_intent;

    extern fn gimp_color_config_get_display_optimize(p_config: *ColorConfig) c_int;
    pub const getDisplayOptimize = gimp_color_config_get_display_optimize;

    extern fn gimp_color_config_get_display_profile_from_gdk(p_config: *ColorConfig) c_int;
    pub const getDisplayProfileFromGdk = gimp_color_config_get_display_profile_from_gdk;

    extern fn gimp_color_config_get_gray_color_profile(p_config: *ColorConfig, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const getGrayColorProfile = gimp_color_config_get_gray_color_profile;

    extern fn gimp_color_config_get_mode(p_config: *ColorConfig) gimp.ColorManagementMode;
    pub const getMode = gimp_color_config_get_mode;

    extern fn gimp_color_config_get_out_of_gamut_color(p_config: *ColorConfig) *gegl.Color;
    pub const getOutOfGamutColor = gimp_color_config_get_out_of_gamut_color;

    extern fn gimp_color_config_get_rgb_color_profile(p_config: *ColorConfig, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const getRgbColorProfile = gimp_color_config_get_rgb_color_profile;

    extern fn gimp_color_config_get_simulation_bpc(p_config: *ColorConfig) c_int;
    pub const getSimulationBpc = gimp_color_config_get_simulation_bpc;

    extern fn gimp_color_config_get_simulation_color_profile(p_config: *ColorConfig, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const getSimulationColorProfile = gimp_color_config_get_simulation_color_profile;

    extern fn gimp_color_config_get_simulation_gamut_check(p_config: *ColorConfig) c_int;
    pub const getSimulationGamutCheck = gimp_color_config_get_simulation_gamut_check;

    extern fn gimp_color_config_get_simulation_intent(p_config: *ColorConfig) gimp.ColorRenderingIntent;
    pub const getSimulationIntent = gimp_color_config_get_simulation_intent;

    extern fn gimp_color_config_get_simulation_optimize(p_config: *ColorConfig) c_int;
    pub const getSimulationOptimize = gimp_color_config_get_simulation_optimize;

    extern fn gimp_color_config_get_type() usize;
    pub const getGObjectType = gimp_color_config_get_type;

    extern fn g_object_ref(p_self: *gimp.ColorConfig) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ColorConfig) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorConfig, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Definitions and Functions relating to LCMS.
pub const ColorProfile = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ColorProfileClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function takes a `babl.Object` format and returns the lcms format to
    /// be used with that `format`. It also returns a `babl.Object` format to be
    /// used instead of the passed `format`, which usually is the same as
    /// `format`, unless lcms doesn't support `format`.
    ///
    /// Note that this function currently only supports RGB, RGBA, R'G'B',
    /// R'G'B'A, Y, YA, Y', Y'A and the cairo-RGB24 and cairo-ARGB32 formats.
    extern fn gimp_color_profile_get_lcms_format(p_format: *const babl.Object, p_lcms_format: *u32) ?*const babl.Object;
    pub const getLcmsFormat = gimp_color_profile_get_lcms_format;

    /// This function creates a grayscale `gimp.ColorProfile` with the
    /// D50 ICC profile illuminant as the profile white point and the
    /// LAB companding curve as the TRC.
    extern fn gimp_color_profile_new_d50_gray_lab_trc() *gimp.ColorProfile;
    pub const newD50GrayLabTrc = gimp_color_profile_new_d50_gray_lab_trc;

    extern fn gimp_color_profile_new_d65_gray_linear() *gimp.ColorProfile;
    pub const newD65GrayLinear = gimp_color_profile_new_d65_gray_linear;

    /// This function creates a grayscale `gimp.ColorProfile` with an
    /// sRGB TRC. See `gimp.ColorProfile.newRgbSrgb`.
    extern fn gimp_color_profile_new_d65_gray_srgb_trc() *gimp.ColorProfile;
    pub const newD65GraySrgbTrc = gimp_color_profile_new_d65_gray_srgb_trc;

    /// This function opens an ICC color profile from `file`.
    extern fn gimp_color_profile_new_from_file(p_file: *gio.File, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const newFromFile = gimp_color_profile_new_from_file;

    /// This function opens an ICC color profile from memory. On error,
    /// `NULL` is returned and `error` is set.
    extern fn gimp_color_profile_new_from_icc_profile(p_data: [*]const u8, p_length: usize, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const newFromIccProfile = gimp_color_profile_new_from_icc_profile;

    /// This function creates a GimpColorProfile from a cmsHPROFILE. On
    /// error, `NULL` is returned and `error` is set. The passed
    /// `lcms_profile` pointer is not retained by the created
    /// `gimp.ColorProfile`.
    extern fn gimp_color_profile_new_from_lcms_profile(p_lcms_profile: ?*anyopaque, p_error: ?*?*glib.Error) ?*gimp.ColorProfile;
    pub const newFromLcmsProfile = gimp_color_profile_new_from_lcms_profile;

    /// This function creates a profile compatible with AbobeRGB (1998).
    extern fn gimp_color_profile_new_rgb_adobe() *gimp.ColorProfile;
    pub const newRgbAdobe = gimp_color_profile_new_rgb_adobe;

    /// This function is a replacement for `cmsCreate_sRGBProfile` and
    /// returns an sRGB profile that is functionally the same as the
    /// ArgyllCMS sRGB.icm profile. "Functionally the same" means it has
    /// the same red, green, and blue colorants and the V4 "chad"
    /// equivalent of the ArgyllCMS V2 white point. The profile TRC is also
    /// functionally equivalent to the ArgyllCMS sRGB.icm TRC and is the
    /// same as the LCMS sRGB built-in profile TRC.
    ///
    /// The actual primaries in the sRGB specification are
    /// red xy:   {0.6400, 0.3300, 1.0}
    /// green xy: {0.3000, 0.6000, 1.0}
    /// blue xy:  {0.1500, 0.0600, 1.0}
    ///
    /// The sRGB primaries given below are "pre-quantized" to compensate
    /// for hexadecimal quantization during the profile-making process.
    /// Unless the profile-making code compensates for this quantization,
    /// the resulting profile's red, green, and blue colorants will deviate
    /// slightly from the correct XYZ values.
    ///
    /// LCMS2 doesn't compensate for hexadecimal quantization. The
    /// "pre-quantized" primaries below were back-calculated from the
    /// ArgyllCMS sRGB.icm profile. The resulting sRGB profile's colorants
    /// exactly matches the ArgyllCMS sRGB.icm profile colorants.
    extern fn gimp_color_profile_new_rgb_srgb() *gimp.ColorProfile;
    pub const newRgbSrgb = gimp_color_profile_new_rgb_srgb;

    /// This function creates a profile for babl_model("RGB"). Please
    /// somebody write something smarter here.
    extern fn gimp_color_profile_new_rgb_srgb_linear() *gimp.ColorProfile;
    pub const newRgbSrgbLinear = gimp_color_profile_new_rgb_srgb_linear;

    extern fn gimp_color_profile_get_copyright(p_profile: *ColorProfile) [*:0]const u8;
    pub const getCopyright = gimp_color_profile_get_copyright;

    extern fn gimp_color_profile_get_description(p_profile: *ColorProfile) [*:0]const u8;
    pub const getDescription = gimp_color_profile_get_description;

    /// This function takes a `gimp.ColorProfile` and a `babl.Object` format and
    /// returns a new `babl.Object` format with `profile`'s RGB primaries and TRC,
    /// and `format`'s pixel layout.
    extern fn gimp_color_profile_get_format(p_profile: *ColorProfile, p_format: *const babl.Object, p_intent: gimp.ColorRenderingIntent, p_error: ?*?*glib.Error) ?*const babl.Object;
    pub const getFormat = gimp_color_profile_get_format;

    /// This function returns `profile` as ICC profile data. The returned
    /// memory belongs to `profile` and must not be modified or freed.
    extern fn gimp_color_profile_get_icc_profile(p_profile: *ColorProfile, p_length: *usize) [*]const u8;
    pub const getIccProfile = gimp_color_profile_get_icc_profile;

    /// This function returns a string containing `profile`'s "title", a
    /// string that can be used to label the profile in a user interface.
    ///
    /// Unlike `gimp.ColorProfile.getDescription`, this function always
    /// returns a string (as a fallback, it returns "(unnamed profile)").
    extern fn gimp_color_profile_get_label(p_profile: *ColorProfile) [*:0]const u8;
    pub const getLabel = gimp_color_profile_get_label;

    /// This function returns `profile`'s cmsHPROFILE. The returned
    /// value belongs to `profile` and must not be modified or freed.
    extern fn gimp_color_profile_get_lcms_profile(p_profile: *ColorProfile) ?*anyopaque;
    pub const getLcmsProfile = gimp_color_profile_get_lcms_profile;

    extern fn gimp_color_profile_get_manufacturer(p_profile: *ColorProfile) [*:0]const u8;
    pub const getManufacturer = gimp_color_profile_get_manufacturer;

    extern fn gimp_color_profile_get_model(p_profile: *ColorProfile) [*:0]const u8;
    pub const getModel = gimp_color_profile_get_model;

    /// This function returns the `babl.Object` space of `profile`, for the
    /// specified `intent`.
    extern fn gimp_color_profile_get_space(p_profile: *ColorProfile, p_intent: gimp.ColorRenderingIntent, p_error: ?*?*glib.Error) ?*const babl.Object;
    pub const getSpace = gimp_color_profile_get_space;

    /// This function return a string containing a multi-line summary of
    /// `profile`'s description, model, manufacturer and copyright, to be
    /// used as detailed information about the profile in a user
    /// interface.
    extern fn gimp_color_profile_get_summary(p_profile: *ColorProfile) [*:0]const u8;
    pub const getSummary = gimp_color_profile_get_summary;

    extern fn gimp_color_profile_is_cmyk(p_profile: *ColorProfile) c_int;
    pub const isCmyk = gimp_color_profile_is_cmyk;

    /// Compares two profiles.
    extern fn gimp_color_profile_is_equal(p_profile1: *ColorProfile, p_profile2: *gimp.ColorProfile) c_int;
    pub const isEqual = gimp_color_profile_is_equal;

    extern fn gimp_color_profile_is_gray(p_profile: *ColorProfile) c_int;
    pub const isGray = gimp_color_profile_is_gray;

    /// This function determines is the ICC profile represented by a GimpColorProfile
    /// is a linear RGB profile or not, some profiles that are LUTs though linear
    /// will also return FALSE;
    extern fn gimp_color_profile_is_linear(p_profile: *ColorProfile) c_int;
    pub const isLinear = gimp_color_profile_is_linear;

    extern fn gimp_color_profile_is_rgb(p_profile: *ColorProfile) c_int;
    pub const isRgb = gimp_color_profile_is_rgb;

    /// This function creates a new RGB `gimp.ColorProfile` with a linear TRC
    /// and `profile`'s RGB chromacities and whitepoint.
    extern fn gimp_color_profile_new_linear_from_color_profile(p_profile: *ColorProfile) ?*gimp.ColorProfile;
    pub const newLinearFromColorProfile = gimp_color_profile_new_linear_from_color_profile;

    /// This function creates a new RGB `gimp.ColorProfile` with a sRGB gamma
    /// TRC and `profile`'s RGB chromacities and whitepoint.
    extern fn gimp_color_profile_new_srgb_trc_from_color_profile(p_profile: *ColorProfile) ?*gimp.ColorProfile;
    pub const newSrgbTrcFromColorProfile = gimp_color_profile_new_srgb_trc_from_color_profile;

    /// This function saves `profile` to `file` as ICC profile.
    extern fn gimp_color_profile_save_to_file(p_profile: *ColorProfile, p_file: *gio.File, p_error: ?*?*glib.Error) c_int;
    pub const saveToFile = gimp_color_profile_save_to_file;

    extern fn gimp_color_profile_get_type() usize;
    pub const getGObjectType = gimp_color_profile_get_type;

    extern fn g_object_ref(p_self: *gimp.ColorProfile) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ColorProfile) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorProfile, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Definitions and Functions relating to LCMS.
pub const ColorTransform = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ColorTransformClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const progress = struct {
            pub const name = "progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorTransform, p_instance))),
                    gobject.signalLookup("progress", ColorTransform.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This function checks if a GimpColorTransform is needed at all.
    extern fn gimp_color_transform_can_gegl_copy(p_src_profile: *gimp.ColorProfile, p_dest_profile: *gimp.ColorProfile) c_int;
    pub const canGeglCopy = gimp_color_transform_can_gegl_copy;

    /// This function creates an color transform.
    ///
    /// The color transform is determined exclusively by `src_profile` and
    /// `dest_profile`. The color spaces of `src_format` and `dest_format` are
    /// ignored, the formats are only used to decide between what pixel
    /// encodings to transform.
    ///
    /// Note: this function used to return `NULL` if
    /// `gimp.ColorTransform.canGeglCopy` returned `TRUE` for
    /// `src_profile` and `dest_profile`. This is no longer the case because
    /// special care has to be taken not to perform multiple implicit color
    /// transforms caused by babl formats with color spaces. Now, it always
    /// returns a non-`NULL` transform and the code takes care of doing only
    /// exactly the requested color transform.
    extern fn gimp_color_transform_new(p_src_profile: *gimp.ColorProfile, p_src_format: *const babl.Object, p_dest_profile: *gimp.ColorProfile, p_dest_format: *const babl.Object, p_rendering_intent: gimp.ColorRenderingIntent, p_flags: gimp.ColorTransformFlags) ?*gimp.ColorTransform;
    pub const new = gimp_color_transform_new;

    /// This function creates a simulation / proofing color transform.
    ///
    /// See `gimp.ColorTransform.new` about the color spaces to transform
    /// between.
    extern fn gimp_color_transform_new_proofing(p_src_profile: *gimp.ColorProfile, p_src_format: *const babl.Object, p_dest_profile: *gimp.ColorProfile, p_dest_format: *const babl.Object, p_proof_profile: *gimp.ColorProfile, p_proof_intent: gimp.ColorRenderingIntent, p_display_intent: gimp.ColorRenderingIntent, p_flags: gimp.ColorTransformFlags) ?*gimp.ColorTransform;
    pub const newProofing = gimp_color_transform_new_proofing;

    /// This function transforms buffer into another buffer.
    ///
    /// See `gimp.ColorTransform.new`: only the pixel encoding of
    /// `src_buffer`'s and `dest_buffer`'s formats honored, their color
    /// spaces are ignored. The transform always takes place between the
    /// color spaces determined by `transform`'s color profiles.
    extern fn gimp_color_transform_process_buffer(p_transform: *ColorTransform, p_src_buffer: *gegl.Buffer, p_src_rect: *const gegl.Rectangle, p_dest_buffer: *gegl.Buffer, p_dest_rect: *const gegl.Rectangle) void;
    pub const processBuffer = gimp_color_transform_process_buffer;

    /// This function transforms a contiguous line of pixels.
    ///
    /// See `gimp.ColorTransform.new`: only the pixel encoding of
    /// `src_format` and `dest_format` is honored, their color spaces are
    /// ignored. The transform always takes place between the color spaces
    /// determined by `transform`'s color profiles.
    extern fn gimp_color_transform_process_pixels(p_transform: *ColorTransform, p_src_format: *const babl.Object, p_src_pixels: ?*const anyopaque, p_dest_format: *const babl.Object, p_dest_pixels: ?*anyopaque, p_length: usize) void;
    pub const processPixels = gimp_color_transform_process_pixels;

    extern fn gimp_color_transform_get_type() usize;
    pub const getGObjectType = gimp_color_transform_get_type;

    extern fn g_object_ref(p_self: *gimp.ColorTransform) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ColorTransform) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorTransform, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ConfigPath = opaque {
    pub const Parent = gobject.TypeInstance;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ConfigPath;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Paths as stored in gimprc and other config files have to be treated
    /// special.  The string may contain special identifiers such as for
    /// example ${gimp_dir} that have to be substituted before use. Also
    /// the user's filesystem may be in a different encoding than UTF-8
    /// (which is what is used for the gimprc). This function does the
    /// variable substitution for you and can also attempt to convert to
    /// the filesystem encoding.
    ///
    /// To reverse the expansion, use `gimp.ConfigPath.unexpand`.
    extern fn gimp_config_path_expand(p_path: [*:0]const u8, p_recode: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const expand = gimp_config_path_expand;

    /// Paths as stored in the gimprc have to be treated special. The
    /// string may contain special identifiers such as for example
    /// ${gimp_dir} that have to be substituted before use. Also the user's
    /// filesystem may be in a different encoding than UTF-8 (which is what
    /// is used for the gimprc).
    ///
    /// This function runs `path` through `gimp.ConfigPath.expand` and
    /// `gimp.Path.parse`, then turns the filenames returned by
    /// `gimp.Path.parse` into GFile using `gio.fileNewForPath`.
    extern fn gimp_config_path_expand_to_files(p_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*glib.List;
    pub const expandToFiles = gimp_config_path_expand_to_files;

    /// The inverse operation of `gimp.ConfigPath.expand`
    ///
    /// This function takes a `path` and tries to substitute the first
    /// elements by well-known special identifiers such as for example
    /// ${gimp_dir}. The unexpanded path can then be stored in gimprc and
    /// other config files.
    ///
    /// If `recode` is `TRUE` then `path` is in local filesystem encoding,
    /// if `recode` is `FALSE` then `path` is assumed to be UTF-8.
    extern fn gimp_config_path_unexpand(p_path: [*:0]const u8, p_recode: c_int, p_error: ?*?*glib.Error) ?[*:0]u8;
    pub const unexpand = gimp_config_path_unexpand;

    extern fn gimp_config_path_get_type() usize;
    pub const getGObjectType = gimp_config_path_get_type;

    pub fn as(p_instance: *ConfigPath, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions to create, delete and flush displays (views) on an image.
pub const Display = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.DisplayClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns a `gimp.Display` representing `display_id`.
    ///
    /// Note: in most use cases, you should not need to retrieve a
    /// `gimp.Display` by its ID, which is mostly internal data and not
    /// reusable across sessions. Use the appropriate functions for your use
    /// case instead.
    extern fn gimp_display_get_by_id(p_display_id: i32) ?*gimp.Display;
    pub const getById = gimp_display_get_by_id;

    /// Returns TRUE if the display ID is valid.
    ///
    /// This procedure checks if the given display ID is valid and refers to
    /// an existing display.
    ///
    /// *Note*: in most use cases, you should not use this function. If you
    /// got a `gimp.Display` from the API, you should trust it is
    /// valid. This function is mostly for internal usage.
    extern fn gimp_display_id_is_valid(p_display_id: c_int) c_int;
    pub const idIsValid = gimp_display_id_is_valid;

    /// Returns the display to be used for plug-in windows.
    ///
    /// This is a constant value given at plug-in configuration time.
    /// Will return `NULL` if GIMP has been started with no GUI, either
    /// via "--no-interface" flag, or a console build.
    extern fn gimp_display_name() [*:0]const u8;
    pub const name = gimp_display_name;

    /// Create a new display for the specified image.
    ///
    /// Creates a new display for the specified image. If the image already
    /// has a display, another is added. Multiple displays are handled
    /// transparently by GIMP. The newly created display is returned and can
    /// be subsequently destroyed with a call to `gimp.Display.delete`. This
    /// procedure only makes sense for use with the GIMP UI, and will result
    /// in an execution error if called when GIMP has no UI.
    extern fn gimp_display_new(p_image: *gimp.Image) *gimp.Display;
    pub const new = gimp_display_new;

    /// Delete the specified display.
    ///
    /// This procedure removes the specified display. If this is the last
    /// remaining display for the underlying image, then the image is
    /// deleted also. Note that the display is closed no matter if the image
    /// is dirty or not. Better save the image before calling this
    /// procedure.
    extern fn gimp_display_delete(p_display: *Display) c_int;
    pub const delete = gimp_display_delete;

    /// Note: in most use cases, you should not need a display's ID which is
    /// mostly internal data and not reusable across sessions.
    extern fn gimp_display_get_id(p_display: *Display) i32;
    pub const getId = gimp_display_get_id;

    /// Get a handle to the native window for an image display.
    ///
    /// This procedure returns a handle to the native window for a given
    /// image display.
    /// It can be different types of data depending on the platform you are
    /// running on. For example in the X backend of GDK, a native window
    /// handle is an Xlib XID whereas on Wayland, it is a string handle. A
    /// value of NULL is returned for an invalid display or if this function
    /// is unimplemented for the windowing system that is being used.
    extern fn gimp_display_get_window_handle(p_display: *Display) *glib.Bytes;
    pub const getWindowHandle = gimp_display_get_window_handle;

    /// Returns TRUE if the display is valid.
    ///
    /// This procedure checks if the given display is valid and refers to
    /// an existing display.
    extern fn gimp_display_is_valid(p_display: *Display) c_int;
    pub const isValid = gimp_display_is_valid;

    /// Present the specified display.
    ///
    /// This procedure presents the specified display at the top of the
    /// display stack.
    extern fn gimp_display_present(p_display: *Display) c_int;
    pub const present = gimp_display_present;

    extern fn gimp_display_get_type() usize;
    pub const getGObjectType = gimp_display_get_type;

    extern fn g_object_ref(p_self: *gimp.Display) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Display) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Display, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions to manipulate drawables.
pub const Drawable = extern struct {
    pub const Parent = gimp.Item;
    pub const Implements = [_]type{};
    pub const Class = gimp.DrawableClass;
    f_parent_instance: gimp.Item,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `gimp.Drawable` representing `drawable_id`. This function
    /// calls `gimp.Item.getById` and returns the item if it is drawable
    /// or `NULL` otherwise.
    extern fn gimp_drawable_get_by_id(p_drawable_id: i32) ?*gimp.Drawable;
    pub const getById = gimp_drawable_get_by_id;

    /// This procedure appends the specified drawable effect at the top of the
    /// effect list of `drawable`.
    ///
    /// The `drawable` argument must be the same as the one used when you
    /// created the effect with `gimp.DrawableFilter.new`.
    /// Some effects may be slower than others to render. In order to
    /// minimize processing time, it is preferred to customize the
    /// operation's arguments as received with
    /// `gimp.DrawableFilter.getConfig` before adding the effect.
    extern fn gimp_drawable_append_filter(p_drawable: *Drawable, p_filter: *gimp.DrawableFilter) void;
    pub const appendFilter = gimp_drawable_append_filter;

    /// Utility function which combines `gimp.DrawableFilter.new`
    /// followed by setting arguments for the
    /// `gimp.DrawableFilterConfig` returned by
    /// `gimp.DrawableFilter.getConfig`, and finally appending with
    /// `gimp.Drawable.appendFilter`
    ///
    /// The variable arguments are couples of an argument name followed by a
    /// value, NULL-terminated, such as:
    ///
    /// ```C
    /// filter = gimp_drawable_append_new_filter (drawable,
    ///                                           GIMP_LAYER_MODE_REPLACE, 1.0,
    ///                                           "gegl:gaussian-blur", "My Gaussian Blur",
    ///                                           "std-dev-x", 2.5,
    ///                                           "std-dev-y", 2.5,
    ///                                           "abyss-policy", "clamp",
    ///                                           NULL);
    /// ```
    extern fn gimp_drawable_append_new_filter(p_drawable: *Drawable, p_operation_name: [*:0]const u8, p_name: [*:0]const u8, p_mode: gimp.LayerMode, p_opacity: f64, ...) *gimp.DrawableFilter;
    pub const appendNewFilter = gimp_drawable_append_new_filter;

    /// Modify brightness/contrast in the specified drawable.
    ///
    /// This procedures allows the brightness and contrast of the specified
    /// drawable to be modified. Both 'brightness' and 'contrast' parameters
    /// are defined between -1.0 and 1.0.
    extern fn gimp_drawable_brightness_contrast(p_drawable: *Drawable, p_brightness: f64, p_contrast: f64) c_int;
    pub const brightnessContrast = gimp_drawable_brightness_contrast;

    /// Modify the color balance of the specified drawable.
    ///
    /// Modify the color balance of the specified drawable. There are three
    /// axis which can be modified: cyan-red, magenta-green, and
    /// yellow-blue. Negative values increase the amount of the former,
    /// positive values increase the amount of the latter. Color balance can
    /// be controlled with the 'transfer_mode' setting, which allows
    /// shadows, mid-tones, and highlights in an image to be affected
    /// differently. The 'preserve-lum' parameter, if TRUE, ensures that the
    /// luminosity of each pixel remains fixed.
    extern fn gimp_drawable_color_balance(p_drawable: *Drawable, p_transfer_mode: gimp.TransferMode, p_preserve_lum: c_int, p_cyan_red: f64, p_magenta_green: f64, p_yellow_blue: f64) c_int;
    pub const colorBalance = gimp_drawable_color_balance;

    /// Render the drawable as a grayscale image seen through a colored
    /// glass.
    ///
    /// Desaturates the drawable, then tints it with the specified color.
    /// This tool is only valid on RGB color images. It will not operate on
    /// grayscale drawables.
    extern fn gimp_drawable_colorize_hsl(p_drawable: *Drawable, p_hue: f64, p_saturation: f64, p_lightness: f64) c_int;
    pub const colorizeHsl = gimp_drawable_colorize_hsl;

    /// Modifies the intensity curve(s) for specified drawable.
    ///
    /// Modifies the intensity mapping for one channel in the specified
    /// drawable. The channel can be either an intensity component, or the
    /// value. The 'values' parameter is an array of doubles which
    /// explicitly defines how each pixel value in the drawable will be
    /// modified. Use the `gimp.Drawable.curvesSpline` function to modify
    /// intensity levels with Catmull Rom splines.
    extern fn gimp_drawable_curves_explicit(p_drawable: *Drawable, p_channel: gimp.HistogramChannel, p_num_values: usize, p_values: [*]const f64) c_int;
    pub const curvesExplicit = gimp_drawable_curves_explicit;

    /// Modifies the intensity curve(s) for specified drawable.
    ///
    /// Modifies the intensity mapping for one channel in the specified
    /// drawable. The channel can be either an intensity component, or the
    /// value. The 'points' parameter is an array of doubles which define a
    /// set of control points which describe a Catmull Rom spline which
    /// yields the final intensity curve. Use the
    /// `gimp.Drawable.curvesExplicit` function to explicitly modify
    /// intensity levels.
    extern fn gimp_drawable_curves_spline(p_drawable: *Drawable, p_channel: gimp.HistogramChannel, p_num_points: usize, p_points: [*]const f64) c_int;
    pub const curvesSpline = gimp_drawable_curves_spline;

    /// Desaturate the contents of the specified drawable, with the
    /// specified formula.
    ///
    /// This procedure desaturates the contents of the specified drawable,
    /// with the specified formula. This procedure only works on drawables
    /// of type RGB color.
    extern fn gimp_drawable_desaturate(p_drawable: *Drawable, p_desaturate_mode: gimp.DesaturateMode) c_int;
    pub const desaturate = gimp_drawable_desaturate;

    /// Fill the area by a seed fill starting at the specified coordinates.
    ///
    /// This procedure does a seed fill at the specified coordinates, using
    /// various parameters from the current context.
    /// In the case of merged sampling, the x and y coordinates are relative
    /// to the image's origin; otherwise, they are relative to the
    /// drawable's origin.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetOpacity`, `gimp.contextSetPaintMode`,
    /// `gimp.contextSetForeground`, `gimp.contextSetBackground`,
    /// `gimp.contextSetPattern`, `gimp.contextSetSampleThreshold`,
    /// `gimp.contextSetSampleMerged`,
    /// `gimp.contextSetSampleCriterion`,
    /// `gimp.contextSetDiagonalNeighbors`, `gimp.contextSetAntialias`.
    extern fn gimp_drawable_edit_bucket_fill(p_drawable: *Drawable, p_fill_type: gimp.FillType, p_x: f64, p_y: f64) c_int;
    pub const editBucketFill = gimp_drawable_edit_bucket_fill;

    /// Clear selected area of drawable.
    ///
    /// This procedure clears the specified drawable. If the drawable has an
    /// alpha channel, the cleared pixels will become transparent. If the
    /// drawable does not have an alpha channel, cleared pixels will be set
    /// to the background color. This procedure only affects regions within
    /// a selection if there is a selection active.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetBackground`.
    extern fn gimp_drawable_edit_clear(p_drawable: *Drawable) c_int;
    pub const editClear = gimp_drawable_edit_clear;

    /// Fill selected area of drawable.
    ///
    /// This procedure fills the specified drawable according to fill mode.
    /// This procedure only affects regions within a selection if there is a
    /// selection active. If you want to fill the whole drawable, regardless
    /// of the selection, use `gimp.Drawable.fill`.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetOpacity`, `gimp.contextSetPaintMode`,
    /// `gimp.contextSetForeground`, `gimp.contextSetBackground`,
    /// `gimp.contextSetPattern`.
    extern fn gimp_drawable_edit_fill(p_drawable: *Drawable, p_fill_type: gimp.FillType) c_int;
    pub const editFill = gimp_drawable_edit_fill;

    /// Draw a gradient between the starting and ending coordinates with the
    /// specified gradient type.
    ///
    /// This tool requires information on the gradient type. It creates the
    /// specified variety of gradient using the starting and ending
    /// coordinates as defined for each gradient type. For shapeburst
    /// gradient types, the context's distance metric is also relevant and
    /// can be updated with `gimp.contextSetDistanceMetric`.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetOpacity`, `gimp.contextSetPaintMode`,
    /// `gimp.contextSetForeground`, `gimp.contextSetBackground`,
    /// `gimp.contextSetGradient` and all gradient property settings,
    /// `gimp.contextSetDistanceMetric`.
    extern fn gimp_drawable_edit_gradient_fill(p_drawable: *Drawable, p_gradient_type: gimp.GradientType, p_offset: f64, p_supersample: c_int, p_supersample_max_depth: c_int, p_supersample_threshold: f64, p_dither: c_int, p_x1: f64, p_y1: f64, p_x2: f64, p_y2: f64) c_int;
    pub const editGradientFill = gimp_drawable_edit_gradient_fill;

    /// Stroke the specified item
    ///
    /// This procedure strokes the specified item, painting along its
    /// outline (e.g. along a path, or along a channel's boundary), with the
    /// active paint method and brush, or using a plain line with
    /// configurable properties.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetOpacity`, `gimp.contextSetPaintMode`,
    /// `gimp.contextSetPaintMethod`, `gimp.contextSetStrokeMethod`,
    /// `gimp.contextSetForeground`, `gimp.contextSetBrush` and all
    /// brush property settings, `gimp.contextSetGradient` and all
    /// gradient property settings, `gimp.contextSetLineWidth` and all
    /// line property settings, `gimp.contextSetAntialias`.
    extern fn gimp_drawable_edit_stroke_item(p_drawable: *Drawable, p_item: *gimp.Item) c_int;
    pub const editStrokeItem = gimp_drawable_edit_stroke_item;

    /// Stroke the current selection
    ///
    /// This procedure strokes the current selection, painting along the
    /// selection boundary with the active paint method and brush, or using
    /// a plain line with configurable properties. The paint is applied to
    /// the specified drawable regardless of the active selection.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetOpacity`, `gimp.contextSetPaintMode`,
    /// `gimp.contextSetPaintMethod`, `gimp.contextSetStrokeMethod`,
    /// `gimp.contextSetForeground`, `gimp.contextSetBrush` and all
    /// brush property settings, `gimp.contextSetGradient` and all
    /// gradient property settings, `gimp.contextSetLineWidth` and all
    /// line property settings, `gimp.contextSetAntialias`.
    extern fn gimp_drawable_edit_stroke_selection(p_drawable: *Drawable) c_int;
    pub const editStrokeSelection = gimp_drawable_edit_stroke_selection;

    /// Equalize the contents of the specified drawable.
    ///
    /// This procedure equalizes the contents of the specified drawable.
    /// Each intensity channel is equalized independently. The equalized
    /// intensity is given as inten' = (255 - inten). The 'mask_only' option
    /// specifies whether to adjust only the area of the image within the
    /// selection bounds, or the entire image based on the histogram of the
    /// selected area. If there is no selection, the entire image is
    /// adjusted based on the histogram for the entire image.
    extern fn gimp_drawable_equalize(p_drawable: *Drawable, p_mask_only: c_int) c_int;
    pub const equalize = gimp_drawable_equalize;

    /// Extract a color model component.
    ///
    /// Extract a color model component.
    extern fn gimp_drawable_extract_component(p_drawable: *Drawable, p_component: c_int, p_invert: c_int, p_linear: c_int) c_int;
    pub const extractComponent = gimp_drawable_extract_component;

    /// Fill the drawable with the specified fill mode.
    ///
    /// This procedure fills the drawable. If the fill mode is foreground
    /// the current foreground color is used. If the fill mode is
    /// background, the current background color is used. If the fill type
    /// is white, then white is used. Transparent fill only affects layers
    /// with an alpha channel, in which case the alpha channel is set to
    /// transparent. If the drawable has no alpha channel, it is filled to
    /// white. No fill leaves the drawable's contents undefined.
    /// This procedure is unlike `gimp.Drawable.editFill` or the bucket
    /// fill tool because it fills regardless of a selection. Its main
    /// purpose is to fill a newly created drawable before adding it to the
    /// image. This operation cannot be undone.
    extern fn gimp_drawable_fill(p_drawable: *Drawable, p_fill_type: gimp.FillType) c_int;
    pub const fill = gimp_drawable_fill;

    /// Extract the foreground of a drawable using a given trimap.
    ///
    /// Image Segmentation by Uniform Color Clustering, see
    /// https://www.inf.fu-berlin.de/inst/pubs/tr-b-05-07.pdf
    extern fn gimp_drawable_foreground_extract(p_drawable: *Drawable, p_mode: gimp.ForegroundExtractMode, p_mask: *gimp.Drawable) c_int;
    pub const foregroundExtract = gimp_drawable_foreground_extract;

    /// Free the specified drawable's shadow data (if it exists).
    ///
    /// This procedure is intended as a memory saving device. If any shadow
    /// memory has been allocated, it will be freed automatically when the
    /// drawable is removed from the image, or when the plug-in procedure
    /// which allocated it returns.
    extern fn gimp_drawable_free_shadow(p_drawable: *Drawable) c_int;
    pub const freeShadow = gimp_drawable_free_shadow;

    /// Returns the bytes per pixel.
    ///
    /// This procedure returns the number of bytes per pixel.
    extern fn gimp_drawable_get_bpp(p_drawable: *Drawable) c_int;
    pub const getBpp = gimp_drawable_get_bpp;

    /// Returns a `gegl.Buffer` of a specified drawable. The buffer can be used
    /// like any other GEGL buffer. Its data will we synced back with the core
    /// drawable when the buffer gets destroyed, or when `gegl.Buffer.flush`
    /// is called.
    extern fn gimp_drawable_get_buffer(p_drawable: *Drawable) *gegl.Buffer;
    pub const getBuffer = gimp_drawable_get_buffer;

    /// Returns the list of filters applied to the drawable.
    ///
    /// This procedure returns the list of filters which are currently
    /// applied non-destructively to `drawable`. The order of filters is from
    /// topmost to bottommost.
    extern fn gimp_drawable_get_filters(p_drawable: *Drawable) [*]*gimp.DrawableFilter;
    pub const getFilters = gimp_drawable_get_filters;

    /// Returns the `babl.Object` format of the drawable.
    extern fn gimp_drawable_get_format(p_drawable: *Drawable) *const babl.Object;
    pub const getFormat = gimp_drawable_get_format;

    /// Returns the height of the drawable.
    ///
    /// This procedure returns the specified drawable's height in pixels.
    extern fn gimp_drawable_get_height(p_drawable: *Drawable) c_int;
    pub const getHeight = gimp_drawable_get_height;

    /// Returns the offsets for the drawable.
    ///
    /// This procedure returns the specified drawable's offsets. This only
    /// makes sense if the drawable is a layer since channels are anchored.
    /// The offsets of a channel will be returned as 0.
    extern fn gimp_drawable_get_offsets(p_drawable: *Drawable, p_offset_x: *c_int, p_offset_y: *c_int) c_int;
    pub const getOffsets = gimp_drawable_get_offsets;

    /// Gets the value of the pixel at the specified coordinates.
    ///
    /// This procedure gets the pixel value at the specified coordinates.
    extern fn gimp_drawable_get_pixel(p_drawable: *Drawable, p_x_coord: c_int, p_y_coord: c_int) *gegl.Color;
    pub const getPixel = gimp_drawable_get_pixel;

    /// Returns a `gegl.Buffer` of a specified drawable's shadow tiles. The
    /// buffer can be used like any other GEGL buffer. Its data will we
    /// synced back with the core drawable's shadow tiles when the buffer
    /// gets destroyed, or when `gegl.Buffer.flush` is called.
    extern fn gimp_drawable_get_shadow_buffer(p_drawable: *Drawable) *gegl.Buffer;
    pub const getShadowBuffer = gimp_drawable_get_shadow_buffer;

    /// Retrieves a thumbnail pixbuf for the drawable identified by
    /// `drawable`. The thumbnail will be not larger than the requested
    /// size.
    extern fn gimp_drawable_get_sub_thumbnail(p_drawable: *Drawable, p_src_x: c_int, p_src_y: c_int, p_src_width: c_int, p_src_height: c_int, p_dest_width: c_int, p_dest_height: c_int, p_alpha: gimp.PixbufTransparency) *gdkpixbuf.Pixbuf;
    pub const getSubThumbnail = gimp_drawable_get_sub_thumbnail;

    /// Retrieves thumbnail data for the drawable identified by `drawable`.
    /// The thumbnail will be not larger than the requested size.
    extern fn gimp_drawable_get_sub_thumbnail_data(p_drawable: *Drawable, p_src_x: c_int, p_src_y: c_int, p_src_width: c_int, p_src_height: c_int, p_dest_width: c_int, p_dest_height: c_int, p_actual_width: *c_int, p_actual_height: *c_int, p_bpp: *c_int) *glib.Bytes;
    pub const getSubThumbnailData = gimp_drawable_get_sub_thumbnail_data;

    /// Retrieves a thumbnail pixbuf for the drawable identified by
    /// `drawable`. The thumbnail will be not larger than the requested
    /// size.
    extern fn gimp_drawable_get_thumbnail(p_drawable: *Drawable, p_width: c_int, p_height: c_int, p_alpha: gimp.PixbufTransparency) *gdkpixbuf.Pixbuf;
    pub const getThumbnail = gimp_drawable_get_thumbnail;

    /// Retrieves thumbnail data for the drawable identified by `drawable`.
    /// The thumbnail will be not larger than the requested size.
    extern fn gimp_drawable_get_thumbnail_data(p_drawable: *Drawable, p_width: c_int, p_height: c_int, p_actual_width: *c_int, p_actual_height: *c_int, p_bpp: *c_int) ?*glib.Bytes;
    pub const getThumbnailData = gimp_drawable_get_thumbnail_data;

    /// Returns the `babl.Object` thumbnail format of the drawable.
    extern fn gimp_drawable_get_thumbnail_format(p_drawable: *Drawable) *const babl.Object;
    pub const getThumbnailFormat = gimp_drawable_get_thumbnail_format;

    /// Returns the width of the drawable.
    ///
    /// This procedure returns the specified drawable's width in pixels.
    extern fn gimp_drawable_get_width(p_drawable: *Drawable) c_int;
    pub const getWidth = gimp_drawable_get_width;

    /// Returns TRUE if the drawable has an alpha channel.
    ///
    /// This procedure returns whether the specified drawable has an alpha
    /// channel. This can only be true for layers, and the associated type
    /// will be one of: { RGBA , GRAYA, INDEXEDA }.
    extern fn gimp_drawable_has_alpha(p_drawable: *Drawable) c_int;
    pub const hasAlpha = gimp_drawable_has_alpha;

    /// Returns information on the intensity histogram for the specified
    /// drawable.
    ///
    /// This tool makes it possible to gather information about the
    /// intensity histogram of a drawable. A channel to examine is first
    /// specified. This can be either value, red, green, or blue, depending
    /// on whether the drawable is of type color or grayscale. Second, a
    /// range of intensities are specified. The `gimp.Drawable.histogram`
    /// function returns statistics based on the pixels in the drawable that
    /// fall under this range of values. Mean, standard deviation, median,
    /// number of pixels, and percentile are all returned. Additionally, the
    /// total count of pixels in the image is returned. Counts of pixels are
    /// weighted by any associated alpha values and by the current selection
    /// mask. That is, pixels that lie outside an active selection mask will
    /// not be counted. Similarly, pixels with transparent alpha values will
    /// not be counted. The returned mean, std_dev and median are in the
    /// range (0..255) for 8-bit images or if the plug-in is not
    /// precision-aware, and in the range (0.0..1.0) otherwise.
    extern fn gimp_drawable_histogram(p_drawable: *Drawable, p_channel: gimp.HistogramChannel, p_start_range: f64, p_end_range: f64, p_mean: *f64, p_std_dev: *f64, p_median: *f64, p_pixels: *f64, p_count: *f64, p_percentile: *f64) c_int;
    pub const histogram = gimp_drawable_histogram;

    /// Modify hue, lightness, and saturation in the specified drawable.
    ///
    /// This procedure allows the hue, lightness, and saturation in the
    /// specified drawable to be modified. The 'hue-range' parameter
    /// provides the capability to limit range of affected hues. The
    /// 'overlap' parameter provides blending into neighboring hue channels
    /// when rendering.
    extern fn gimp_drawable_hue_saturation(p_drawable: *Drawable, p_hue_range: gimp.HueRange, p_hue_offset: f64, p_lightness: f64, p_saturation: f64, p_overlap: f64) c_int;
    pub const hueSaturation = gimp_drawable_hue_saturation;

    /// Invert the contents of the specified drawable.
    ///
    /// This procedure inverts the contents of the specified drawable. Each
    /// intensity channel is inverted independently. The inverted intensity
    /// is given as inten' = (255 - inten). If 'linear' is TRUE, the
    /// drawable is inverted in linear space.
    extern fn gimp_drawable_invert(p_drawable: *Drawable, p_linear: c_int) c_int;
    pub const invert = gimp_drawable_invert;

    /// Returns whether the drawable is a grayscale type.
    ///
    /// This procedure returns TRUE if the specified drawable is of type {
    /// Gray, GrayA }.
    extern fn gimp_drawable_is_gray(p_drawable: *Drawable) c_int;
    pub const isGray = gimp_drawable_is_gray;

    /// Returns whether the drawable is an indexed type.
    ///
    /// This procedure returns TRUE if the specified drawable is of type {
    /// Indexed, IndexedA }.
    extern fn gimp_drawable_is_indexed(p_drawable: *Drawable) c_int;
    pub const isIndexed = gimp_drawable_is_indexed;

    /// Returns whether the drawable is an RGB type.
    ///
    /// This procedure returns TRUE if the specified drawable is of type {
    /// RGB, RGBA }.
    extern fn gimp_drawable_is_rgb(p_drawable: *Drawable) c_int;
    pub const isRgb = gimp_drawable_is_rgb;

    /// Modifies intensity levels in the specified drawable.
    ///
    /// This tool allows intensity levels in the specified drawable to be
    /// remapped according to a set of parameters. The low/high input levels
    /// specify an initial mapping from the source intensities. The gamma
    /// value determines how intensities between the low and high input
    /// intensities are interpolated. A gamma value of 1.0 results in a
    /// linear interpolation. Higher gamma values result in more high-level
    /// intensities. Lower gamma values result in more low-level
    /// intensities. The low/high output levels constrain the final
    /// intensity mapping--that is, no final intensity will be lower than
    /// the low output level and no final intensity will be higher than the
    /// high output level. This tool is only valid on RGB color and
    /// grayscale images.
    extern fn gimp_drawable_levels(p_drawable: *Drawable, p_channel: gimp.HistogramChannel, p_low_input: f64, p_high_input: f64, p_clamp_input: c_int, p_gamma: f64, p_low_output: f64, p_high_output: f64, p_clamp_output: c_int) c_int;
    pub const levels = gimp_drawable_levels;

    /// Automatically modifies intensity levels in the specified drawable.
    ///
    /// This procedure allows intensity levels in the specified drawable to
    /// be remapped according to a set of guessed parameters. It is
    /// equivalent to clicking the \"Auto\" button in the Levels tool.
    extern fn gimp_drawable_levels_stretch(p_drawable: *Drawable) c_int;
    pub const levelsStretch = gimp_drawable_levels_stretch;

    /// Find the bounding box of the current selection in relation to the
    /// specified drawable.
    ///
    /// This procedure returns whether there is a selection. If there is
    /// one, the upper left and lower right-hand corners of its bounding box
    /// are returned. These coordinates are specified relative to the
    /// drawable's origin, and bounded by the drawable's extents. Please
    /// note that the pixel specified by the lower right-hand coordinate of
    /// the bounding box is not part of the selection. The selection ends at
    /// the upper left corner of this pixel. This means the width of the
    /// selection can be calculated as (x2 - x1), its height as (y2 - y1).
    /// Note that the returned boolean does NOT correspond with the returned
    /// region being empty or not, it always returns whether the selection
    /// is non_empty. See `gimp.Drawable.maskIntersect` for a boolean
    /// return value which is more useful in most cases.
    extern fn gimp_drawable_mask_bounds(p_drawable: *Drawable, p_x1: *c_int, p_y1: *c_int, p_x2: *c_int, p_y2: *c_int) c_int;
    pub const maskBounds = gimp_drawable_mask_bounds;

    /// Find the bounding box of the current selection in relation to the
    /// specified drawable.
    ///
    /// This procedure returns whether there is an intersection between the
    /// drawable and the selection. Unlike `gimp.Drawable.maskBounds`, the
    /// intersection's bounds are returned as x, y, width, height.
    /// If there is no selection this function returns TRUE and the returned
    /// bounds are the extents of the whole drawable.
    extern fn gimp_drawable_mask_intersect(p_drawable: *Drawable, p_x: *c_int, p_y: *c_int, p_width: *c_int, p_height: *c_int) c_int;
    pub const maskIntersect = gimp_drawable_mask_intersect;

    /// This procedure applies the specified drawable effect on `drawable`
    /// and merge it (therefore before any non-destructive effects are
    /// computed).
    ///
    /// The `drawable` argument must be the same as the one used when you
    /// created the effect with `gimp.DrawableFilter.new`.
    /// Once this is run, `filter` is not valid anymore and you should not
    /// try to do anything with it. In particular, you must customize the
    /// operation's arguments as received with
    /// `gimp.DrawableFilter.getConfig` or set the filter's opacity
    /// and blend mode before merging the effect.
    extern fn gimp_drawable_merge_filter(p_drawable: *Drawable, p_filter: *gimp.DrawableFilter) void;
    pub const mergeFilter = gimp_drawable_merge_filter;

    /// Merge the layer effect filters to the specified drawable.
    ///
    /// This procedure combines the contents of the drawable's filter stack
    /// (for export) with the specified drawable.
    extern fn gimp_drawable_merge_filters(p_drawable: *Drawable) c_int;
    pub const mergeFilters = gimp_drawable_merge_filters;

    /// Utility function which combines `gimp.DrawableFilter.new`
    /// followed by setting arguments for the
    /// `gimp.DrawableFilterConfig` returned by
    /// `gimp.DrawableFilter.getConfig`, and finally applying the
    /// effect to `drawable` with `gimp.Drawable.mergeFilter`
    ///
    /// The variable arguments are couples of an argument name followed by a
    /// value, NULL-terminated, such as:
    ///
    /// ```C
    /// filter = gimp_drawable_merge_new_filter (drawable,
    ///                                          GIMP_LAYER_MODE_REPLACE, 1.0,
    ///                                          "gegl:gaussian-blur", "My Gaussian Blur",
    ///                                          "std-dev-x", 2.5,
    ///                                          "std-dev-y", 2.5,
    ///                                          "abyss-policy", "clamp",
    ///                                          NULL);
    /// ```
    extern fn gimp_drawable_merge_new_filter(p_drawable: *Drawable, p_operation_name: [*:0]const u8, p_name: [*:0]const u8, p_mode: gimp.LayerMode, p_opacity: f64, ...) void;
    pub const mergeNewFilter = gimp_drawable_merge_new_filter;

    /// Merge the shadow buffer with the specified drawable.
    ///
    /// This procedure combines the contents of the drawable's shadow buffer
    /// (for temporary processing) with the specified drawable. The 'undo'
    /// parameter specifies whether to add an undo step for the operation.
    /// Requesting no undo is useful for such applications as 'auto-apply'.
    extern fn gimp_drawable_merge_shadow(p_drawable: *Drawable, p_undo: c_int) c_int;
    pub const mergeShadow = gimp_drawable_merge_shadow;

    /// Offset the drawable by the specified amounts in the X and Y
    /// directions
    ///
    /// This procedure offsets the specified drawable by the amounts
    /// specified by 'offset_x' and 'offset_y'. If 'wrap_around' is set to
    /// TRUE, then portions of the drawable which are offset out of bounds
    /// are wrapped around. Alternatively, the undefined regions of the
    /// drawable can be filled with transparency or the background color, as
    /// specified by the 'fill-type' parameter.
    extern fn gimp_drawable_offset(p_drawable: *Drawable, p_wrap_around: c_int, p_fill_type: gimp.OffsetType, p_color: *gegl.Color, p_offset_x: c_int, p_offset_y: c_int) c_int;
    pub const offset = gimp_drawable_offset;

    /// Posterize the specified drawable.
    ///
    /// This procedures reduces the number of shades allows in each
    /// intensity channel to the specified 'levels' parameter.
    extern fn gimp_drawable_posterize(p_drawable: *Drawable, p_levels: c_int) c_int;
    pub const posterize = gimp_drawable_posterize;

    /// Sets the value of the pixel at the specified coordinates.
    ///
    /// This procedure sets the pixel value at the specified coordinates.
    /// Note that this function is not undoable, you should use it only on
    /// drawables you just created yourself.
    extern fn gimp_drawable_set_pixel(p_drawable: *Drawable, p_x_coord: c_int, p_y_coord: c_int, p_color: *gegl.Color) c_int;
    pub const setPixel = gimp_drawable_set_pixel;

    /// Perform shadows and highlights correction.
    ///
    /// This filter allows adjusting shadows and highlights in the image
    /// separately. The implementation closely follow its counterpart in the
    /// Darktable photography software.
    extern fn gimp_drawable_shadows_highlights(p_drawable: *Drawable, p_shadows: f64, p_highlights: f64, p_whitepoint: f64, p_radius: f64, p_compress: f64, p_shadows_ccorrect: f64, p_highlights_ccorrect: f64) c_int;
    pub const shadowsHighlights = gimp_drawable_shadows_highlights;

    /// Threshold the specified drawable.
    ///
    /// This procedures generates a threshold map of the specified drawable.
    /// All pixels between the values of 'low_threshold' and
    /// 'high_threshold', on the scale of 'channel' are replaced with white,
    /// and all other pixels with black.
    extern fn gimp_drawable_threshold(p_drawable: *Drawable, p_channel: gimp.HistogramChannel, p_low_threshold: f64, p_high_threshold: f64) c_int;
    pub const threshold = gimp_drawable_threshold;

    /// Returns the drawable's type.
    ///
    /// This procedure returns the drawable's type.
    extern fn gimp_drawable_type(p_drawable: *Drawable) gimp.ImageType;
    pub const @"type" = gimp_drawable_type;

    /// Returns the drawable's type with alpha.
    ///
    /// This procedure returns the drawable's type as if had an alpha
    /// channel. If the type is currently Gray, for instance, the returned
    /// type would be GrayA. If the drawable already has an alpha channel,
    /// the drawable's type is simply returned.
    extern fn gimp_drawable_type_with_alpha(p_drawable: *Drawable) gimp.ImageType;
    pub const typeWithAlpha = gimp_drawable_type_with_alpha;

    /// Update the specified region of the drawable.
    ///
    /// This procedure updates the specified region of the drawable. The (x,
    /// y) coordinate pair is relative to the drawable's origin, not to the
    /// image origin. Therefore, the entire drawable can be updated using
    /// (0, 0, width, height).
    extern fn gimp_drawable_update(p_drawable: *Drawable, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) c_int;
    pub const update = gimp_drawable_update;

    extern fn gimp_drawable_get_type() usize;
    pub const getGObjectType = gimp_drawable_get_type;

    extern fn g_object_ref(p_self: *gimp.Drawable) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Drawable) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Drawable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Operations on drawable filters: creation, editing.
pub const DrawableFilter = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.DrawableFilterClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gimp_drawable_filter_get_by_id(p_filter_id: i32) ?*gimp.DrawableFilter;
    pub const getById = gimp_drawable_filter_get_by_id;

    /// Returns `TRUE` if the drawable filter ID is valid.
    ///
    /// This procedure checks if the given drawable filter ID is valid and
    /// refers to an existing filter.
    extern fn gimp_drawable_filter_id_is_valid(p_filter_id: c_int) c_int;
    pub const idIsValid = gimp_drawable_filter_id_is_valid;

    /// Create a new drawable filter.
    ///
    /// This procedure creates a new filter for the specified operation on
    /// `drawable`.
    /// The new effect still needs to be either added or merged to `drawable`
    /// later. Add the effect non-destructively with
    /// `gimp.Drawable.appendFilter`.
    /// Currently only layers can have non-destructive effects. The effects
    /// must be merged for all other types of drawable.
    extern fn gimp_drawable_filter_new(p_drawable: *gimp.Drawable, p_operation_name: [*:0]const u8, p_name: ?[*:0]const u8) *gimp.DrawableFilter;
    pub const new = gimp_drawable_filter_new;

    /// Delete a drawable filter.
    ///
    /// This procedure deletes the specified filter. This must not be done
    /// if the drawable whose this filter was applied to was already deleted
    /// or if the drawable was already removed from the image.
    /// Do not use anymore the `filter` object after having deleted it.
    extern fn gimp_drawable_filter_delete(p_filter: *DrawableFilter) c_int;
    pub const delete = gimp_drawable_filter_delete;

    /// Get the blending mode of the specified filter.
    ///
    /// This procedure returns the specified filter's mode.
    extern fn gimp_drawable_filter_get_blend_mode(p_filter: *DrawableFilter) gimp.LayerMode;
    pub const getBlendMode = gimp_drawable_filter_get_blend_mode;

    /// Get the `gimp.Config` with properties that match `filter`'s arguments.
    ///
    /// The config object will be created at the first call of this method
    /// and its properties will be synced with the settings of this filter as
    /// set in the core application.
    ///
    /// Further changes to the config's properties are not synced back
    /// immediately with the core application. Use
    /// `gimp.Drawable.update` to trigger an actual update.
    extern fn gimp_drawable_filter_get_config(p_filter: *DrawableFilter) *gimp.DrawableFilterConfig;
    pub const getConfig = gimp_drawable_filter_get_config;

    extern fn gimp_drawable_filter_get_id(p_filter: *DrawableFilter) i32;
    pub const getId = gimp_drawable_filter_get_id;

    /// Get a drawable filter's name.
    ///
    /// This procedure returns the specified filter's name.
    /// Since it is not possible to set a drawable filter's name yet, this
    /// will be the operation's name. Eventually this filter's name will be
    /// a free form field so do not rely on this information for any
    /// processing.
    extern fn gimp_drawable_filter_get_name(p_filter: *DrawableFilter) [*:0]u8;
    pub const getName = gimp_drawable_filter_get_name;

    /// Get the opacity of the specified filter.
    ///
    /// This procedure returns the specified filter's opacity.
    extern fn gimp_drawable_filter_get_opacity(p_filter: *DrawableFilter) f64;
    pub const getOpacity = gimp_drawable_filter_get_opacity;

    /// Get a drawable filter's operation name.
    ///
    /// This procedure returns the specified filter's operation name.
    extern fn gimp_drawable_filter_get_operation_name(p_filter: *DrawableFilter) [*:0]u8;
    pub const getOperationName = gimp_drawable_filter_get_operation_name;

    /// Get the visibility of the specified filter.
    ///
    /// This procedure returns the specified filter's visibility.
    extern fn gimp_drawable_filter_get_visible(p_filter: *DrawableFilter) c_int;
    pub const getVisible = gimp_drawable_filter_get_visible;

    /// Returns TRUE if the `drawable_filter` is valid.
    ///
    /// This procedure checks if the given filter is valid and refers to an
    /// existing `gimp.DrawableFilter`.
    extern fn gimp_drawable_filter_is_valid(p_filter: *DrawableFilter) c_int;
    pub const isValid = gimp_drawable_filter_is_valid;

    /// When a filter has one or several auxiliary inputs, you can use this
    /// function to set them.
    ///
    /// The change is not synced immediately with the core application.
    /// Use `gimp.Drawable.update` to trigger an actual update.
    extern fn gimp_drawable_filter_set_aux_input(p_filter: *DrawableFilter, p_input_pad_name: [*:0]const u8, p_input: *gimp.Drawable) void;
    pub const setAuxInput = gimp_drawable_filter_set_aux_input;

    /// This procedure sets the blend mode of `filter`.
    ///
    /// The change is not synced immediately with the core application.
    /// Use `gimp.Drawable.update` to trigger an actual update.
    extern fn gimp_drawable_filter_set_blend_mode(p_filter: *DrawableFilter, p_mode: gimp.LayerMode) void;
    pub const setBlendMode = gimp_drawable_filter_set_blend_mode;

    /// This procedure sets the opacity of `filter` on a range from 0.0
    /// (transparent) to 1.0 (opaque).
    ///
    /// The change is not synced immediately with the core application.
    /// Use `gimp.Drawable.update` to trigger an actual update.
    extern fn gimp_drawable_filter_set_opacity(p_filter: *DrawableFilter, p_opacity: f64) void;
    pub const setOpacity = gimp_drawable_filter_set_opacity;

    /// Set the visibility of the specified filter.
    ///
    /// This procedure sets the specified filter's visibility.
    /// The drawable won't be immediately rendered. Use
    /// `gimp.Drawable.update` to trigger an update.
    extern fn gimp_drawable_filter_set_visible(p_filter: *DrawableFilter, p_visible: c_int) c_int;
    pub const setVisible = gimp_drawable_filter_set_visible;

    /// Syncs the `gimp.Config` with properties that match `filter`'s arguments.
    /// This procedure updates the settings of the specified filter all at
    /// once, including the arguments of the `gimp.DrawableFilterConfig`
    /// obtained with `gimp.DrawableFilter.getConfig` as well as the
    /// blend mode and opacity.
    ///
    /// In particular, if the image is displayed, rendering will be frozen
    /// and will happen only once for all changed settings.
    extern fn gimp_drawable_filter_update(p_filter: *DrawableFilter) void;
    pub const update = gimp_drawable_filter_update;

    extern fn gimp_drawable_filter_get_type() usize;
    pub const getGObjectType = gimp_drawable_filter_get_type;

    extern fn g_object_ref(p_self: *gimp.DrawableFilter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.DrawableFilter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawableFilter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The base class for `DrawableFilter` specific config objects.
///
/// A drawable filter config is created by a `DrawableFilter` using
/// `DrawableFilter.getConfig` and its properties match the
/// filter's arguments in number, order and type.
pub const DrawableFilterConfig = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.DrawableFilterConfigClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_drawable_filter_config_get_type() usize;
    pub const getGObjectType = gimp_drawable_filter_config_get_type;

    extern fn g_object_ref(p_self: *gimp.DrawableFilterConfig) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.DrawableFilterConfig) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawableFilterConfig, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A class holding generic export options.
///
/// Note: right now, GIMP does not provide any generic export option to
/// manipulate, and there is practically no reason for you to create this
/// object yourself. In Export PDB procedure, or again in functions such
/// as `gimp.fileSave`, you may just pass `NULL`.
///
/// In the future, this object will enable to pass various generic
/// options, such as ability to crop or resize images at export time.
pub const ExportOptions = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ExportOptionsClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// What `ExportCapabilities` are supported.
        pub const capabilities = struct {
            pub const name = "capabilities";

            pub const Type = gimp.ExportCapabilities;
        };
    };

    pub const signals = struct {};

    /// Takes an image to be exported, possibly creating a temporary copy
    /// modified according to export settings in `options` (such as the
    /// capabilities of the export format).
    ///
    /// If necessary, a copy is created, converted and modified, `image`
    /// changed to point to the new image and the procedure returns
    /// `gimp.@"ExportReturn.EXPORT"`.
    /// In this case, you must take care of deleting the created image using
    /// `Image.delete` once the image has been exported, unless you
    /// were planning to display it with `Display.new`, or you will leak
    /// memory.
    ///
    /// If `gimp.@"ExportReturn.IGNORE"` is returned, then `image` is still the
    /// original image. You should neither modify it, nor should you delete
    /// it in the end. If you wish to temporarily modify the image before
    /// export anyway, call `Image.duplicate` when
    /// `gimp.@"ExportReturn.IGNORE"` was returned.
    extern fn gimp_export_options_get_image(p_options: *ExportOptions, p_image: **gimp.Image) gimp.ExportReturn;
    pub const getImage = gimp_export_options_get_image;

    extern fn gimp_export_options_get_type() usize;
    pub const getGObjectType = gimp_export_options_get_type;

    extern fn g_object_ref(p_self: *gimp.ExportOptions) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ExportOptions) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ExportOptions, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Export procedures implement image export.
///
/// Registered export procedures will be automatically available in the export
/// interfaces and functions of GIMP. The detection (to decide which file is
/// redirected to which plug-in procedure) depends on the various methods set
/// with `FileProcedure` API.
pub const ExportProcedure = opaque {
    pub const Parent = gimp.FileProcedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.ExportProcedureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// What `gimp.ExportCapabilities` are supported
        pub const capabilities = struct {
            pub const name = "capabilities";

            pub const Type = gimp.ExportCapabilities;
        };

        /// Whether the export procedure supports storing a comment.
        pub const supports_comment = struct {
            pub const name = "supports-comment";

            pub const Type = c_int;
        };

        /// Whether the export procedure supports EXIF.
        pub const supports_exif = struct {
            pub const name = "supports-exif";

            pub const Type = c_int;
        };

        /// Whether the export procedure supports IPTC.
        pub const supports_iptc = struct {
            pub const name = "supports-iptc";

            pub const Type = c_int;
        };

        /// Whether the export procedure supports ICC color profiles.
        pub const supports_profile = struct {
            pub const name = "supports-profile";

            pub const Type = c_int;
        };

        /// Whether the export procedure supports storing a thumbnail.
        pub const supports_thumbnail = struct {
            pub const name = "supports-thumbnail";

            pub const Type = c_int;
        };

        /// Whether the export procedure supports XMP.
        pub const supports_xmp = struct {
            pub const name = "supports-xmp";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new export procedure named `name` which will call `run_func`
    /// when invoked.
    ///
    /// See `gimp.Procedure.new` for information about `proc_type`.
    ///
    /// `gimp.ExportProcedure` is a `gimp.Procedure` subclass that makes it easier
    /// to write file export procedures.
    ///
    /// It automatically adds the standard
    ///
    /// (`gimp.RunMode`, `gimp.Image`, `gio.File`, `gimp.ExportOptions`)
    ///
    /// arguments of an export procedure. It is possible to add additional
    /// arguments.
    ///
    /// When invoked via `gimp.Procedure.run`, it unpacks these standard
    /// arguments and calls `run_func` which is a `gimp.RunExportFunc`. The
    /// `gimp.ProcedureConfig` of `gimp.RunExportFunc` only contains additionally added
    /// arguments.
    ///
    /// If `export_metadata` is TRUE, then the class will also handle the metadata
    /// export if the format is supported by our backend. This requires you to also
    /// set appropriate MimeType with `gimp.FileProcedure.setMimeTypes`.
    extern fn gimp_export_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_export_metadata: c_int, p_run_func: gimp.RunExportFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.ExportProcedure;
    pub const new = gimp_export_procedure_new;

    extern fn gimp_export_procedure_get_support_comment(p_procedure: *ExportProcedure) c_int;
    pub const getSupportComment = gimp_export_procedure_get_support_comment;

    extern fn gimp_export_procedure_get_support_exif(p_procedure: *ExportProcedure) c_int;
    pub const getSupportExif = gimp_export_procedure_get_support_exif;

    extern fn gimp_export_procedure_get_support_iptc(p_procedure: *ExportProcedure) c_int;
    pub const getSupportIptc = gimp_export_procedure_get_support_iptc;

    extern fn gimp_export_procedure_get_support_profile(p_procedure: *ExportProcedure) c_int;
    pub const getSupportProfile = gimp_export_procedure_get_support_profile;

    extern fn gimp_export_procedure_get_support_thumbnail(p_procedure: *ExportProcedure) c_int;
    pub const getSupportThumbnail = gimp_export_procedure_get_support_thumbnail;

    extern fn gimp_export_procedure_get_support_xmp(p_procedure: *ExportProcedure) c_int;
    pub const getSupportXmp = gimp_export_procedure_get_support_xmp;

    /// Sets default `gimp.ExportCapabilities` for image export.
    ///
    /// `capabilities` and `get_capabilities_func` are overlapping arguments.
    /// Either set `capabilities` if your format capabilities are stable or
    /// `get_capabilities_func` if they depend on other options.
    /// If `get_capabilities_func` is set, `capabilities` must be 0.
    ///
    /// If set, `get_capabilities_func` will be called every time an argument
    /// in the `gimp.ProcedureConfig` is edited and it will be used to
    /// edit the export capabilities dynamically.
    extern fn gimp_export_procedure_set_capabilities(p_procedure: *ExportProcedure, p_capabilities: gimp.ExportCapabilities, p_get_capabilities_func: ?gimp.ExportGetCapabilitiesFunc, p_get_capabilities_data: ?*anyopaque, p_get_capabilities_data_destroy: ?glib.DestroyNotify) void;
    pub const setCapabilities = gimp_export_procedure_set_capabilities;

    /// Determine whether `procedure` supports exporting a comment. By default,
    /// it won't (so there is usually no reason to run this function with
    /// `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-comment" in the end
    ///   of the argument list of `procedure`, with relevant blurb and
    ///   description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportComment`.
    extern fn gimp_export_procedure_set_support_comment(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportComment = gimp_export_procedure_set_support_comment;

    /// Determine whether `procedure` supports exporting Exif data. By default,
    /// it won't (so there is usually no reason to run this function with
    /// `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-exif" in the
    ///   end of the argument list of `procedure`, with relevant blurb and
    ///   description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportExif`.
    extern fn gimp_export_procedure_set_support_exif(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportExif = gimp_export_procedure_set_support_exif;

    /// Determine whether `procedure` supports exporting IPTC data. By default,
    /// it won't (so there is usually no reason to run this function with
    /// `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-iptc" in the
    ///   end of the argument list of `procedure`, with relevant blurb and
    ///   description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportIptc`.
    extern fn gimp_export_procedure_set_support_iptc(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportIptc = gimp_export_procedure_set_support_iptc;

    /// Determine whether `procedure` supports exporting ICC color profiles. By
    /// default, it won't (so there is usually no reason to run this function
    /// with `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-color-profile" in
    ///   the end of the argument list of `procedure`, with relevant blurb and
    ///   description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportColorProfile`.
    extern fn gimp_export_procedure_set_support_profile(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportProfile = gimp_export_procedure_set_support_profile;

    /// Determine whether `procedure` supports exporting a thumbnail. By default,
    /// it won't (so there is usually no reason to run this function with
    /// `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-thumbnail" in the
    ///   end of the argument list of `procedure`, with relevant blurb
    ///   and description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportThumbnail`.
    extern fn gimp_export_procedure_set_support_thumbnail(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportThumbnail = gimp_export_procedure_set_support_thumbnail;

    /// Determine whether `procedure` supports exporting XMP data. By default,
    /// it won't (so there is usually no reason to run this function with
    /// `FALSE`).
    ///
    /// This will have several consequences:
    ///
    /// - Automatically adds a standard argument "include-xmp" in the
    ///   end of the argument list of `procedure`, with relevant blurb and
    ///   description.
    /// - If used with other gimp_export_procedure_set_support_*() functions,
    ///   they will always be ordered the same (the order of the calls don't
    ///   matter), keeping all export procedures consistent.
    /// - Generated GimpExportProcedureDialog will contain the metadata
    ///   options, once again always in the same order and with consistent
    ///   GUI style across plug-ins.
    /// - API from `ProcedureConfig` will automatically process these
    ///   properties to decide whether to export a given metadata or not.
    ///
    /// By default, the value will be `exportXmp`.
    extern fn gimp_export_procedure_set_support_xmp(p_procedure: *ExportProcedure, p_supports: c_int) void;
    pub const setSupportXmp = gimp_export_procedure_set_support_xmp;

    extern fn gimp_export_procedure_get_type() usize;
    pub const getGObjectType = gimp_export_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.ExportProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ExportProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ExportProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// File procedures implement file support. They cannot be created directly.
/// Instead, you will create an instance of one of the sublasses (such as export
/// or load procedures). This provides a common interface for file-related
/// functions on these objects.
pub const FileProcedure = extern struct {
    pub const Parent = gimp.Procedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.FileProcedureClass;
    f_parent_instance: gimp.Procedure,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the procedure's extensions as set with
    /// `FileProcedure.setExtensions`.
    extern fn gimp_file_procedure_get_extensions(p_procedure: *FileProcedure) [*:0]const u8;
    pub const getExtensions = gimp_file_procedure_get_extensions;

    /// Returns the procedure's format name, as set with
    /// `FileProcedure.setFormatName`.
    extern fn gimp_file_procedure_get_format_name(p_procedure: *FileProcedure) [*:0]const u8;
    pub const getFormatName = gimp_file_procedure_get_format_name;

    /// Returns the procedure's 'handles remote' flags as set with
    /// `FileProcedure.setHandlesRemote`.
    extern fn gimp_file_procedure_get_handles_remote(p_procedure: *FileProcedure) c_int;
    pub const getHandlesRemote = gimp_file_procedure_get_handles_remote;

    /// Returns the procedure's magics as set with `FileProcedure.setMagics`.
    extern fn gimp_file_procedure_get_magics(p_procedure: *FileProcedure) [*:0]const u8;
    pub const getMagics = gimp_file_procedure_get_magics;

    /// Returns the procedure's mime-type as set with
    /// `FileProcedure.setMimeTypes`.
    extern fn gimp_file_procedure_get_mime_types(p_procedure: *FileProcedure) [*:0]const u8;
    pub const getMimeTypes = gimp_file_procedure_get_mime_types;

    /// Returns the procedure's prefixes as set with
    /// `FileProcedure.setPrefixes`.
    extern fn gimp_file_procedure_get_prefixes(p_procedure: *FileProcedure) [*:0]const u8;
    pub const getPrefixes = gimp_file_procedure_get_prefixes;

    /// Returns the procedure's priority as set with
    /// `FileProcedure.setPriority`.
    extern fn gimp_file_procedure_get_priority(p_procedure: *FileProcedure) c_int;
    pub const getPriority = gimp_file_procedure_get_priority;

    /// Registers the given list of extensions as something this procedure can
    /// handle.
    extern fn gimp_file_procedure_set_extensions(p_procedure: *FileProcedure, p_extensions: [*:0]const u8) void;
    pub const setExtensions = gimp_file_procedure_set_extensions;

    /// Associates a format name with a file handler procedure.
    ///
    /// This name can be used for any public-facing strings, such as
    /// graphical interface labels. An example usage would be
    /// `GimpExportProcedureDialog` title looking like "Export Image as `s`".
    ///
    /// Note that since the format name is public-facing, it is recommended
    /// to localize it at runtime, for instance through gettext, like:
    ///
    /// ```c
    /// gimp_file_procedure_set_format_name (procedure, _("JPEG"));
    /// ```
    ///
    /// Some language would indeed localize even some technical terms or
    /// acronyms, even if sometimes just to rewrite them with the local
    /// writing system.
    extern fn gimp_file_procedure_set_format_name(p_procedure: *FileProcedure, p_format_name: [*:0]const u8) void;
    pub const setFormatName = gimp_file_procedure_set_format_name;

    /// Registers a file procedure as capable of handling arbitrary remote
    /// URIs via GIO.
    ///
    /// When `handles_remote` is set to `TRUE`, the procedure will get a
    /// `gio.File` passed that can point to a remote file.
    ///
    /// When `handles_remote` is set to `FALSE`, the procedure will get a
    /// local `gio.File` passed and can use `gio.File.getPath` to get
    /// to a filename that can be used with whatever non-GIO means of dealing with
    /// the file.
    extern fn gimp_file_procedure_set_handles_remote(p_procedure: *FileProcedure, p_handles_remote: c_int) void;
    pub const setHandlesRemote = gimp_file_procedure_set_handles_remote;

    /// Registers the list of magic file information this procedure can handle.
    extern fn gimp_file_procedure_set_magics(p_procedure: *FileProcedure, p_magics: [*:0]const u8) void;
    pub const setMagics = gimp_file_procedure_set_magics;

    /// Associates MIME types with a file handler procedure.
    ///
    /// Registers MIME types for a file handler procedure. This allows GIMP
    /// to determine the MIME type of the file opened or saved using this
    /// procedure. It is recommended that only one MIME type is registered
    /// per file procedure; when registering more than one MIME type, GIMP
    /// will associate the first one with files opened or saved with this
    /// procedure.
    extern fn gimp_file_procedure_set_mime_types(p_procedure: *FileProcedure, p_mime_types: [*:0]const u8) void;
    pub const setMimeTypes = gimp_file_procedure_set_mime_types;

    /// It should almost never be necessary to register prefixes with file
    /// procedures, because most sorts of URIs should be handled by GIO.
    extern fn gimp_file_procedure_set_prefixes(p_procedure: *FileProcedure, p_prefixes: [*:0]const u8) void;
    pub const setPrefixes = gimp_file_procedure_set_prefixes;

    /// Sets the priority of a file handler procedure.
    ///
    /// When more than one procedure matches a given file, the procedure with the
    /// lowest priority is used; if more than one procedure has the lowest priority,
    /// it is unspecified which one of them is used. The default priority for file
    /// handler procedures is 0.
    extern fn gimp_file_procedure_set_priority(p_procedure: *FileProcedure, p_priority: c_int) void;
    pub const setPriority = gimp_file_procedure_set_priority;

    extern fn gimp_file_procedure_get_type() usize;
    pub const getGObjectType = gimp_file_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.FileProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.FileProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FileProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Installable object used by text tools.
pub const Font = opaque {
    pub const Parent = gimp.Resource;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.FontClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a font with the given name.
    ///
    /// If several fonts are named identically, the one which is returned by
    /// this function should be considered random. This can be used when you
    /// know you won't have multiple fonts of this name or that you don't
    /// want to choose (non-interactive scripts, etc.).
    /// If you need more control, you should use `fontsGetList`
    /// instead.
    /// Returns `NULL` when no font exists of that name.
    extern fn gimp_font_get_by_name(p_name: [*:0]const u8) ?*gimp.Font;
    pub const getByName = gimp_font_get_by_name;

    /// Returns a `pango.FontDescription` representing `font`.
    extern fn gimp_font_get_pango_font_description(p_font: *Font) *pango.FontDescription;
    pub const getPangoFontDescription = gimp_font_get_pango_font_description;

    extern fn gimp_font_get_type() usize;
    pub const getGObjectType = gimp_font_get_type;

    extern fn g_object_ref(p_self: *gimp.Font) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Font) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Font, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Installable object used by the gradient rendering tool.
pub const Gradient = opaque {
    pub const Parent = gimp.Resource;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.GradientClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the gradient with the given name.
    ///
    /// Returns an existing gradient having the given name. Returns `NULL`
    /// when no gradient exists of that name.
    extern fn gimp_gradient_get_by_name(p_name: [*:0]const u8) ?*gimp.Gradient;
    pub const getByName = gimp_gradient_get_by_name;

    /// Creates a new gradient
    ///
    /// Creates a new gradient having no segments.
    extern fn gimp_gradient_new(p_name: [*:0]const u8) *gimp.Gradient;
    pub const new = gimp_gradient_new;

    /// Sample the gradient in custom positions.
    ///
    /// Samples the color of the gradient at positions from a list. The left
    /// endpoint of the gradient corresponds to position 0.0, and the right
    /// endpoint corresponds to 1.0. Returns a list of colors, one for each
    /// sample.
    extern fn gimp_gradient_get_custom_samples(p_gradient: *Gradient, p_num_samples: usize, p_positions: [*]const f64, p_reverse: c_int) [*]*gegl.Color;
    pub const getCustomSamples = gimp_gradient_get_custom_samples;

    /// Gets the number of segments of the gradient
    ///
    /// Gets the number of segments of the gradient
    extern fn gimp_gradient_get_number_of_segments(p_gradient: *Gradient) c_int;
    pub const getNumberOfSegments = gimp_gradient_get_number_of_segments;

    /// Sample the gradient in uniform parts.
    ///
    /// Samples colors uniformly across the gradient. It returns a list of
    /// colors for each sample. The minimum number of samples to take is 2,
    /// in which case the returned colors will correspond to the `{ 0.0, 1.0
    /// }` positions in the gradient. For example, if the number of samples
    /// is 3, the procedure will return the colors at positions `{ 0.0, 0.5,
    /// 1.0 }`.
    extern fn gimp_gradient_get_uniform_samples(p_gradient: *Gradient, p_num_samples: c_int, p_reverse: c_int) [*]*gegl.Color;
    pub const getUniformSamples = gimp_gradient_get_uniform_samples;

    /// Gets the gradient segment's blending function
    ///
    /// Gets the blending function of the segment at the index.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_blending_function(p_gradient: *Gradient, p_segment: c_int, p_blend_func: *gimp.GradientSegmentType) c_int;
    pub const segmentGetBlendingFunction = gimp_gradient_segment_get_blending_function;

    /// Gets the gradient segment's coloring type
    ///
    /// Gets the coloring type of the segment at the index.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_coloring_type(p_gradient: *Gradient, p_segment: c_int, p_coloring_type: *gimp.GradientSegmentColor) c_int;
    pub const segmentGetColoringType = gimp_gradient_segment_get_coloring_type;

    /// Gets the left endpoint color of the segment
    ///
    /// Gets the left endpoint color of the indexed segment of the gradient.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_left_color(p_gradient: *Gradient, p_segment: c_int) *gegl.Color;
    pub const segmentGetLeftColor = gimp_gradient_segment_get_left_color;

    /// Gets the left endpoint position of a segment
    ///
    /// Gets the position of the left endpoint of the segment of the
    /// gradient.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_left_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: *f64) c_int;
    pub const segmentGetLeftPos = gimp_gradient_segment_get_left_pos;

    /// Gets the midpoint position of the segment
    ///
    /// Gets the position of the midpoint of the segment of the gradient.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_middle_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: *f64) c_int;
    pub const segmentGetMiddlePos = gimp_gradient_segment_get_middle_pos;

    /// Gets the right endpoint color of the segment
    ///
    /// Gets the color of the right endpoint color of the segment of the
    /// gradient.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_right_color(p_gradient: *Gradient, p_segment: c_int) *gegl.Color;
    pub const segmentGetRightColor = gimp_gradient_segment_get_right_color;

    /// Gets the right endpoint position of the segment
    ///
    /// Gets the position of the right endpoint of the segment of the
    /// gradient.
    /// Returns an error when the segment index is out of range.
    extern fn gimp_gradient_segment_get_right_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: *f64) c_int;
    pub const segmentGetRightPos = gimp_gradient_segment_get_right_pos;

    /// Blend the colors of the segment range.
    ///
    /// Blends the colors (but not the opacity) of the range of segments.
    /// The colors' transition will then be uniform across the range.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_blend_colors(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeBlendColors = gimp_gradient_segment_range_blend_colors;

    /// Blend the opacity of the segment range.
    ///
    /// Blends the opacity (but not the colors) of the range of segments.
    /// The opacity's transition will then be uniform across the range.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_blend_opacity(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeBlendOpacity = gimp_gradient_segment_range_blend_opacity;

    /// Delete the segment range
    ///
    /// Deletes a range of segments.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable. Deleting all the segments is undefined behavior.
    extern fn gimp_gradient_segment_range_delete(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeDelete = gimp_gradient_segment_range_delete;

    /// Flip the segment range
    ///
    /// Reverses the order of segments in a range, and swaps the left and
    /// right colors in each segment. As if the range as a 1D line were
    /// rotated in a plane.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_flip(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeFlip = gimp_gradient_segment_range_flip;

    /// Move the position of an entire segment range by a delta.
    ///
    /// Moves the position of an entire segment range by a delta. The actual
    /// delta (which is returned) will be limited by the control points of
    /// the neighboring segments.
    /// Returns the actual delta. Returns an error when a segment index is
    /// out of range, or gradient is not editable.
    extern fn gimp_gradient_segment_range_move(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int, p_delta: f64, p_control_compress: c_int) f64;
    pub const segmentRangeMove = gimp_gradient_segment_range_move;

    /// Uniformly redistribute the segment range's handles
    ///
    /// Redistributes the handles of the segment range of the gradient, so
    /// they'll be evenly spaced. A handle is where two segments meet.
    /// Segments will then have the same width.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_redistribute_handles(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeRedistributeHandles = gimp_gradient_segment_range_redistribute_handles;

    /// Replicate the segment range
    ///
    /// Replicates a segment range a given number of times. Instead of the
    /// original segment range, several smaller scaled copies of it will
    /// appear in equal widths.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_replicate(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int, p_replicate_times: c_int) c_int;
    pub const segmentRangeReplicate = gimp_gradient_segment_range_replicate;

    /// Sets the blending function of a range of segments
    ///
    /// Sets the blending function of a range of segments.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_set_blending_function(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int, p_blending_function: gimp.GradientSegmentType) c_int;
    pub const segmentRangeSetBlendingFunction = gimp_gradient_segment_range_set_blending_function;

    /// Sets the coloring type of a range of segments
    ///
    /// Sets the coloring type of a range of segments.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_set_coloring_type(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int, p_coloring_type: gimp.GradientSegmentColor) c_int;
    pub const segmentRangeSetColoringType = gimp_gradient_segment_range_set_coloring_type;

    /// Splits each segment in the segment range at midpoint
    ///
    /// Splits each segment in the segment range at its midpoint.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_split_midpoint(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int) c_int;
    pub const segmentRangeSplitMidpoint = gimp_gradient_segment_range_split_midpoint;

    /// Splits each segment in the segment range uniformly
    ///
    /// Splits each segment in the segment range uniformly into to the
    /// number of parts given.
    /// Returns an error when a segment index is out of range, or gradient
    /// is not editable.
    extern fn gimp_gradient_segment_range_split_uniform(p_gradient: *Gradient, p_start_segment: c_int, p_end_segment: c_int, p_split_parts: c_int) c_int;
    pub const segmentRangeSplitUniform = gimp_gradient_segment_range_split_uniform;

    /// Sets the left endpoint color of a segment
    ///
    /// Sets the color of the left endpoint the indexed segment of the
    /// gradient. The alpha channel of the `gegl.Color` is taken into
    /// account.
    /// Returns an error when gradient is not editable or index is out of
    /// range.
    extern fn gimp_gradient_segment_set_left_color(p_gradient: *Gradient, p_segment: c_int, p_color: *gegl.Color) c_int;
    pub const segmentSetLeftColor = gimp_gradient_segment_set_left_color;

    /// Sets the left endpoint position of the segment
    ///
    /// Sets the position of the left endpoint of the segment of the
    /// gradient. The final position will be the given fraction from the
    /// midpoint to the left to the midpoint of the current segment.
    /// Returns the final position. Returns an error when gradient is not
    /// editable or segment index is out of range.
    extern fn gimp_gradient_segment_set_left_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: f64, p_final_pos: *f64) c_int;
    pub const segmentSetLeftPos = gimp_gradient_segment_set_left_pos;

    /// Sets the midpoint position of the segment
    ///
    /// Sets the midpoint position of the segment of the gradient. The final
    /// position will be the given fraction between the two endpoints of the
    /// segment.
    /// Returns the final position. Returns an error when gradient is not
    /// editable or segment index is out of range.
    extern fn gimp_gradient_segment_set_middle_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: f64, p_final_pos: *f64) c_int;
    pub const segmentSetMiddlePos = gimp_gradient_segment_set_middle_pos;

    /// Sets the right endpoint color of the segment
    ///
    /// Sets the right endpoint color of the segment of the gradient. The
    /// alpha channel of the `gegl.Color` is taken into account.
    /// Returns an error when gradient is not editable or segment index is
    /// out of range.
    extern fn gimp_gradient_segment_set_right_color(p_gradient: *Gradient, p_segment: c_int, p_color: *gegl.Color) c_int;
    pub const segmentSetRightColor = gimp_gradient_segment_set_right_color;

    /// Sets the right endpoint position of the segment
    ///
    /// Sets the right endpoint position of the segment of the gradient. The
    /// final position will be the given fraction from the midpoint of the
    /// current segment to the midpoint of the segment to the right.
    /// Returns the final position. Returns an error when gradient is not
    /// editable or segment index is out of range.
    extern fn gimp_gradient_segment_set_right_pos(p_gradient: *Gradient, p_segment: c_int, p_pos: f64, p_final_pos: *f64) c_int;
    pub const segmentSetRightPos = gimp_gradient_segment_set_right_pos;

    extern fn gimp_gradient_get_type() usize;
    pub const getGObjectType = gimp_gradient_get_type;

    extern fn g_object_ref(p_self: *gimp.Gradient) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Gradient) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Gradient, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Operations on a group layer.
pub const GroupLayer = opaque {
    pub const Parent = gimp.Layer;
    pub const Implements = [_]type{};
    pub const Class = gimp.GroupLayerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `gimp.GroupLayer` representing `layer_id`. This function calls
    /// `gimp.Item.getById` and returns the item if it is a group layer or
    /// `NULL` otherwise.
    extern fn gimp_group_layer_get_by_id(p_layer_id: i32) ?*gimp.GroupLayer;
    pub const getById = gimp_group_layer_get_by_id;

    /// Create a new group layer.
    ///
    /// This procedure creates a new group layer with a given `name`. If
    /// `name` is `NULL`, GIMP will choose a name using its default layer name
    /// algorithm.
    ///
    /// The new group layer still needs to be added to the image, as this is
    /// not automatic. Add the new layer with the
    /// `Image.insertLayer` method.
    /// Other attributes such as layer mask, modes and offsets should be set
    /// with explicit procedure calls.
    ///
    /// Other procedures useful with group layers:
    /// `Image.reorderItem`, `Item.getParent`,
    /// `Item.getChildren`, `Item.isGroup`.
    extern fn gimp_group_layer_new(p_image: *gimp.Image, p_name: ?[*:0]const u8) *gimp.GroupLayer;
    pub const new = gimp_group_layer_new;

    /// Merge the passed group layer's layers into one normal layer.
    ///
    /// This procedure combines the layers of the passed group layer into a
    /// single normal layer, replacing the group.
    /// The group layer is expected to be attached to an image.
    extern fn gimp_group_layer_merge(p_group_layer: *GroupLayer) *gimp.Layer;
    pub const merge = gimp_group_layer_merge;

    extern fn gimp_group_layer_get_type() usize;
    pub const getGObjectType = gimp_group_layer_get_type;

    extern fn g_object_ref(p_self: *gimp.GroupLayer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.GroupLayer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GroupLayer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Operations on complete images: creation, resizing/rescaling, and
/// operations involving multiple layers.
pub const Image = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ImageClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Set dither matrix for conversion to indexed
    ///
    /// This procedure sets the dither matrix used when converting images to
    /// INDEXED mode with positional dithering.
    extern fn gimp_image_convert_set_dither_matrix(p_width: c_int, p_height: c_int, p_matrix: *glib.Bytes) c_int;
    pub const convertSetDitherMatrix = gimp_image_convert_set_dither_matrix;

    extern fn gimp_image_get_by_id(p_image_id: i32) ?*gimp.Image;
    pub const getById = gimp_image_get_by_id;

    /// Returns TRUE if the image ID is valid.
    ///
    /// This procedure checks if the given image ID is valid and refers to
    /// an existing image.
    extern fn gimp_image_id_is_valid(p_image_id: c_int) c_int;
    pub const idIsValid = gimp_image_id_is_valid;

    /// Retrieves a thumbnail from metadata if present.
    extern fn gimp_image_metadata_load_thumbnail(p_file: *gio.File, p_error: ?*?*glib.Error) ?*gimp.Image;
    pub const metadataLoadThumbnail = gimp_image_metadata_load_thumbnail;

    /// Creates a new image with the specified width, height, and type.
    ///
    /// Creates a new image, undisplayed, with the specified extents and
    /// type. A layer should be created and added before this image is
    /// displayed, or subsequent calls to `gimp.Display.new` with this image
    /// as an argument will fail. Layers can be created using the
    /// `gimp.Layer.new` commands. They can be added to an image using the
    /// `gimp.Image.insertLayer` command.
    ///
    /// If your image's type if INDEXED, a palette must also be set with
    /// `gimp.Image.setPalette`. An indexed image without a palette
    /// will output unexpected colors.
    extern fn gimp_image_new(p_width: c_int, p_height: c_int, p_type: gimp.ImageBaseType) *gimp.Image;
    pub const new = gimp_image_new;

    /// Creates a new image with the specified width, height, type and
    /// precision.
    ///
    /// Creates a new image, undisplayed with the specified extents, type
    /// and precision. Indexed images can only be created at
    /// GIMP_PRECISION_U8_NON_LINEAR precision. See `gimp.Image.new` for
    /// further details.
    extern fn gimp_image_new_with_precision(p_width: c_int, p_height: c_int, p_type: gimp.ImageBaseType, p_precision: gimp.Precision) *gimp.Image;
    pub const newWithPrecision = gimp_image_new_with_precision;

    /// Add a horizontal guide to an image.
    ///
    /// This procedure adds a horizontal guide to an image. It takes the
    /// input image and the y-position of the new guide as parameters. It
    /// returns the guide ID of the new guide.
    extern fn gimp_image_add_hguide(p_image: *Image, p_yposition: c_int) c_uint;
    pub const addHguide = gimp_image_add_hguide;

    /// Add a sample point to an image.
    ///
    /// This procedure adds a sample point to an image. It takes the input
    /// image and the position of the new sample points as parameters. It
    /// returns the sample point ID of the new sample point.
    extern fn gimp_image_add_sample_point(p_image: *Image, p_position_x: c_int, p_position_y: c_int) c_uint;
    pub const addSamplePoint = gimp_image_add_sample_point;

    /// Add a vertical guide to an image.
    ///
    /// This procedure adds a vertical guide to an image. It takes the input
    /// image and the x-position of the new guide as parameters. It returns
    /// the guide ID of the new guide.
    extern fn gimp_image_add_vguide(p_image: *Image, p_xposition: c_int) c_uint;
    pub const addVguide = gimp_image_add_vguide;

    /// Add a parasite to an image.
    ///
    /// This procedure attaches a parasite to an image. It has no return
    /// values.
    extern fn gimp_image_attach_parasite(p_image: *Image, p_parasite: *const gimp.Parasite) c_int;
    pub const attachParasite = gimp_image_attach_parasite;

    /// Remove empty borders from the image
    ///
    /// Remove empty borders from the `image` based on empty borders of the
    /// input `drawable`.
    ///
    /// The input drawable serves as a base for detecting cropping extents
    /// (transparency or background color).
    /// With a `NULL` input drawable, the image itself will serve as a base
    /// for detecting cropping extents.
    extern fn gimp_image_autocrop(p_image: *Image, p_drawable: ?*gimp.Drawable) c_int;
    pub const autocrop = gimp_image_autocrop;

    /// Crop the selected layers based on empty borders of the input
    /// drawable
    ///
    /// Crop the selected layers of the input `image` based on empty borders
    /// of the input `drawable`.
    /// The input drawable serves as a base for detecting cropping extents
    /// (transparency or background color), and is not necessarily among the
    /// cropped layers (the current selected layers).
    /// With a `NULL` input drawable, the image itself will serve as a base
    /// for detecting cropping extents.
    extern fn gimp_image_autocrop_selected_layers(p_image: *Image, p_drawable: ?*gimp.Drawable) c_int;
    pub const autocropSelectedLayers = gimp_image_autocrop_selected_layers;

    /// Set the image dirty count to 0.
    ///
    /// This procedure sets the specified image's dirty count to 0, allowing
    /// operations to occur without having a 'dirtied' image. This is
    /// especially useful for creating and loading images which should not
    /// initially be considered dirty, even though layers must be created,
    /// filled, and installed in the image. Note that save plug-ins must NOT
    /// call this function themselves after saving the image.
    extern fn gimp_image_clean_all(p_image: *Image) c_int;
    pub const cleanAll = gimp_image_clean_all;

    /// Convert the image's layers to a color profile
    ///
    /// This procedure converts from the image's color profile (or the
    /// default profile if none is set) to the given color profile.
    ///
    /// Only RGB and grayscale color profiles are accepted, according to the
    /// image's type.
    extern fn gimp_image_convert_color_profile(p_image: *Image, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) c_int;
    pub const convertColorProfile = gimp_image_convert_color_profile;

    /// Convert the image's layers to a color profile
    ///
    /// This procedure converts from the image's color profile (or the
    /// default RGB or grayscale profile if none is set) to an ICC profile
    /// specified by 'file'. Only RGB and grayscale color profiles are
    /// accepted, according to the image's type.
    extern fn gimp_image_convert_color_profile_from_file(p_image: *Image, p_file: *gio.File, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) c_int;
    pub const convertColorProfileFromFile = gimp_image_convert_color_profile_from_file;

    /// Convert specified image to grayscale
    ///
    /// This procedure converts the specified image to grayscale. This
    /// process requires an image in RGB or Indexed color mode.
    extern fn gimp_image_convert_grayscale(p_image: *Image) c_int;
    pub const convertGrayscale = gimp_image_convert_grayscale;

    /// Convert specified image to and Indexed image
    ///
    /// This procedure converts the specified image to 'indexed' color. This
    /// process requires an image in RGB or Grayscale mode. The
    /// 'palette_type' specifies what kind of palette to use, A type of '0'
    /// means to use an optimal palette of 'num_cols' generated from the
    /// colors in the image. A type of '1' means to re-use the previous
    /// palette (not currently implemented). A type of '2' means to use the
    /// so-called WWW-optimized palette. Type '3' means to use only black
    /// and white colors. A type of '4' means to use a palette from the gimp
    /// palettes directories. The 'dither type' specifies what kind of
    /// dithering to use. '0' means no dithering, '1' means standard
    /// Floyd-Steinberg error diffusion, '2' means Floyd-Steinberg error
    /// diffusion with reduced bleeding, '3' means dithering based on pixel
    /// location ('Fixed' dithering).
    extern fn gimp_image_convert_indexed(p_image: *Image, p_dither_type: gimp.ConvertDitherType, p_palette_type: gimp.ConvertPaletteType, p_num_cols: c_int, p_alpha_dither: c_int, p_remove_unused: c_int, p_palette: [*:0]const u8) c_int;
    pub const convertIndexed = gimp_image_convert_indexed;

    /// Convert the image to the specified precision
    ///
    /// This procedure converts the image to the specified precision. Note
    /// that indexed images cannot be converted and are always in
    /// GIMP_PRECISION_U8.
    extern fn gimp_image_convert_precision(p_image: *Image, p_precision: gimp.Precision) c_int;
    pub const convertPrecision = gimp_image_convert_precision;

    /// Convert specified image to RGB color
    ///
    /// This procedure converts the specified image to RGB color. This
    /// process requires an image in Grayscale or Indexed color mode. No
    /// image content is lost in this process aside from the colormap for an
    /// indexed image.
    extern fn gimp_image_convert_rgb(p_image: *Image) c_int;
    pub const convertRgb = gimp_image_convert_rgb;

    /// Crop the image to the specified extents.
    ///
    /// This procedure crops the image so that it's new width and height are
    /// equal to the supplied parameters. Offsets are also provided which
    /// describe the position of the previous image's content. All channels
    /// and layers within the image are cropped to the new image extents;
    /// this includes the image selection mask. If any parameters are out of
    /// range, an error is returned.
    extern fn gimp_image_crop(p_image: *Image, p_new_width: c_int, p_new_height: c_int, p_offx: c_int, p_offy: c_int) c_int;
    pub const crop = gimp_image_crop;

    /// Delete the specified image.
    ///
    /// If there are no displays associated with this image it will be
    /// deleted. This means that you can not delete an image through the PDB
    /// that was created by the user. If the associated display was however
    /// created through the PDB and you know the display ID, you may delete
    /// the display. Removal of the last associated display will then delete
    /// the image.
    extern fn gimp_image_delete(p_image: *Image) c_int;
    pub const delete = gimp_image_delete;

    /// Deletes a guide from an image.
    ///
    /// This procedure takes an image and a guide ID as input and removes
    /// the specified guide from the specified image.
    extern fn gimp_image_delete_guide(p_image: *Image, p_guide: c_uint) c_int;
    pub const deleteGuide = gimp_image_delete_guide;

    /// Deletes a sample point from an image.
    ///
    /// This procedure takes an image and a sample point ID as input and
    /// removes the specified sample point from the specified image.
    extern fn gimp_image_delete_sample_point(p_image: *Image, p_sample_point: c_uint) c_int;
    pub const deleteSamplePoint = gimp_image_delete_sample_point;

    /// Removes a parasite from an image.
    ///
    /// This procedure detaches a parasite from an image. It has no return
    /// values.
    extern fn gimp_image_detach_parasite(p_image: *Image, p_name: [*:0]const u8) c_int;
    pub const detachParasite = gimp_image_detach_parasite;

    /// Duplicate the specified image
    ///
    /// This procedure duplicates the specified image, copying all layers,
    /// channels, and image information.
    extern fn gimp_image_duplicate(p_image: *Image) *gimp.Image;
    pub const duplicate = gimp_image_duplicate;

    /// save a path as an SVG file.
    ///
    /// This procedure creates an SVG file to save a Path object, that is, a
    /// path. The resulting file can be edited using a vector graphics
    /// application, or later reloaded into GIMP. Pass `NULL` as the 'path'
    /// argument to export all paths in the image.
    extern fn gimp_image_export_path_to_file(p_image: *Image, p_file: *gio.File, p_path: ?*gimp.Path) c_int;
    pub const exportPathToFile = gimp_image_export_path_to_file;

    /// Save a path as an SVG string.
    ///
    /// This procedure works like `gimp.Image.exportPathToFile`
    /// but creates a string rather than a file. The string is
    /// NULL-terminated and holds a complete XML document. Pass `NULL` as the
    /// 'path' argument to export all paths in the image.
    extern fn gimp_image_export_path_to_string(p_image: *Image, p_path: ?*gimp.Path) [*:0]u8;
    pub const exportPathToString = gimp_image_export_path_to_string;

    /// Find next guide on an image.
    ///
    /// This procedure takes an image and a guide ID as input and finds the
    /// guide ID of the successor of the given guide ID in the image's guide
    /// list. If the supplied guide ID is 0, the procedure will return the
    /// first Guide. The procedure will return 0 if given the final guide ID
    /// as an argument or the image has no guides.
    extern fn gimp_image_find_next_guide(p_image: *Image, p_guide: c_int) c_uint;
    pub const findNextGuide = gimp_image_find_next_guide;

    /// Find next sample point on an image.
    ///
    /// This procedure takes an image and a sample point ID as input and
    /// finds the sample point ID of the successor of the given sample point
    /// ID in the image's sample point list. If the supplied sample point ID
    /// is 0, the procedure will return the first sample point. The
    /// procedure will return 0 if given the final sample point ID as an
    /// argument or the image has no sample points.
    extern fn gimp_image_find_next_sample_point(p_image: *Image, p_sample_point: c_uint) c_uint;
    pub const findNextSamplePoint = gimp_image_find_next_sample_point;

    /// Flatten all visible layers into a single layer. Discard all
    /// invisible layers.
    ///
    /// This procedure combines the visible layers in a manner analogous to
    /// merging with the CLIP_TO_IMAGE merge type. Non-visible layers are
    /// discarded, and the resulting image is stripped of its alpha channel.
    extern fn gimp_image_flatten(p_image: *Image) *gimp.Layer;
    pub const flatten = gimp_image_flatten;

    /// Flips the image horizontally or vertically.
    ///
    /// This procedure flips (mirrors) the image.
    extern fn gimp_image_flip(p_image: *Image, p_flip_type: gimp.OrientationType) c_int;
    pub const flip = gimp_image_flip;

    /// Return the drawable the floating selection is attached to.
    ///
    /// This procedure returns the drawable the image's floating selection
    /// is attached to, if it exists. If it doesn't exist, -1 is returned as
    /// the drawable ID.
    extern fn gimp_image_floating_sel_attached_to(p_image: *Image) *gimp.Drawable;
    pub const floatingSelAttachedTo = gimp_image_floating_sel_attached_to;

    /// Freeze the image's channel list.
    ///
    /// This procedure freezes the channel list of the image, suppressing
    /// any updates to the Channels dialog in response to changes to the
    /// image's channels. This can significantly improve performance while
    /// applying changes affecting the channel list.
    ///
    /// Each call to `gimp.Image.freezeChannels` should be matched by a
    /// corresponding call to `gimp.Image.thawChannels`, undoing its
    /// effects.
    extern fn gimp_image_freeze_channels(p_image: *Image) c_int;
    pub const freezeChannels = gimp_image_freeze_channels;

    /// Freeze the image's layer list.
    ///
    /// This procedure freezes the layer list of the image, suppressing any
    /// updates to the Layers dialog in response to changes to the image's
    /// layers. This can significantly improve performance while applying
    /// changes affecting the layer list.
    ///
    /// Each call to `gimp.Image.freezeLayers` should be matched by a
    /// corresponding call to `gimp.Image.thawLayers`, undoing its effects.
    extern fn gimp_image_freeze_layers(p_image: *Image) c_int;
    pub const freezeLayers = gimp_image_freeze_layers;

    /// Freeze the image's path list.
    ///
    /// This procedure freezes the path list of the image, suppressing any
    /// updates to the Paths dialog in response to changes to the image's
    /// path. This can significantly improve performance while applying
    /// changes affecting the path list.
    ///
    /// Each call to `gimp.Image.freezePaths` should be matched by a
    /// corresponding call to gimp_image_thaw_paths (), undoing its effects.
    extern fn gimp_image_freeze_paths(p_image: *Image) c_int;
    pub const freezePaths = gimp_image_freeze_paths;

    /// Get the base type of the image.
    ///
    /// This procedure returns the image's base type. Layers in the image
    /// must be of this subtype, but can have an optional alpha channel.
    extern fn gimp_image_get_base_type(p_image: *Image) gimp.ImageBaseType;
    pub const getBaseType = gimp_image_get_base_type;

    /// Find a channel with a given name in an image.
    ///
    /// This procedure returns the channel with the given name in the
    /// specified image.
    extern fn gimp_image_get_channel_by_name(p_image: *Image, p_name: [*:0]const u8) *gimp.Channel;
    pub const getChannelByName = gimp_image_get_channel_by_name;

    /// Find a channel with a given tattoo in an image.
    ///
    /// This procedure returns the channel with the given tattoo in the
    /// specified image.
    extern fn gimp_image_get_channel_by_tattoo(p_image: *Image, p_tattoo: c_uint) *gimp.Channel;
    pub const getChannelByTattoo = gimp_image_get_channel_by_tattoo;

    /// Returns the list of channels contained in the specified image.
    ///
    /// This procedure returns the list of channels contained in the
    /// specified image. This does not include the selection mask, or layer
    /// masks. The order is from topmost to bottommost. Note that
    /// \"channels\" are custom channels and do not include the image's
    /// color components.
    extern fn gimp_image_get_channels(p_image: *Image) [*]*gimp.Channel;
    pub const getChannels = gimp_image_get_channels;

    /// Returns the image's color profile
    ///
    /// This procedure returns the image's color profile, or NULL if the
    /// image has no color profile assigned.
    extern fn gimp_image_get_color_profile(p_image: *Image) *gimp.ColorProfile;
    pub const getColorProfile = gimp_image_get_color_profile;

    /// Returns if the specified image's image component is active.
    ///
    /// This procedure returns if the specified image's image component
    /// (i.e. Red, Green, Blue intensity channels in an RGB image) is active
    /// or inactive -- whether or not it can be modified. If the specified
    /// component is not valid for the image type, an error is returned.
    extern fn gimp_image_get_component_active(p_image: *Image, p_component: gimp.ChannelType) c_int;
    pub const getComponentActive = gimp_image_get_component_active;

    /// Returns if the specified image's image component is visible.
    ///
    /// This procedure returns if the specified image's image component
    /// (i.e. Red, Green, Blue intensity channels in an RGB image) is
    /// visible or invisible -- whether or not it can be seen. If the
    /// specified component is not valid for the image type, an error is
    /// returned.
    extern fn gimp_image_get_component_visible(p_image: *Image, p_component: gimp.ChannelType) c_int;
    pub const getComponentVisible = gimp_image_get_component_visible;

    /// Get the default mode for newly created layers of this image.
    ///
    /// Returns the default mode for newly created layers of this image.
    extern fn gimp_image_get_default_new_layer_mode(p_image: *Image) gimp.LayerMode;
    pub const getDefaultNewLayerMode = gimp_image_get_default_new_layer_mode;

    /// Returns the color profile that is used for the image.
    ///
    /// This procedure returns the color profile that is actually used for
    /// this image, which is the profile returned by
    /// `gimp.Image.getColorProfile` if the image has a profile
    /// assigned, or the default profile from preferences, for the given
    /// color space, if no profile is assigned to the image. If there is no
    /// default profile configured in preferences either, a generated default
    /// profile is returned.
    extern fn gimp_image_get_effective_color_profile(p_image: *Image) *gimp.ColorProfile;
    pub const getEffectiveColorProfile = gimp_image_get_effective_color_profile;

    /// Returns the exported file for the specified image.
    ///
    /// This procedure returns the file associated with the specified image
    /// if the image was exported a non-native GIMP format. If the image was
    /// not exported, this procedure returns `NULL`.
    extern fn gimp_image_get_exported_file(p_image: *Image) *gio.File;
    pub const getExportedFile = gimp_image_get_exported_file;

    /// Returns the file for the specified image.
    ///
    /// This procedure returns the file associated with the specified image.
    /// The image has a file only if it was loaded or imported from a file
    /// or has since been saved or exported. Otherwise, this function
    /// returns `NULL`. See also gimp-image-get-imported-file to get the
    /// current file if it was imported from a non-GIMP file format and not
    /// yet saved, or gimp-image-get-exported-file if the image has been
    /// exported to a non-GIMP file format.
    extern fn gimp_image_get_file(p_image: *Image) *gio.File;
    pub const getFile = gimp_image_get_file;

    /// Return the floating selection of the image.
    ///
    /// This procedure returns the image's floating selection, if it exists.
    /// If it doesn't exist, -1 is returned as the layer ID.
    extern fn gimp_image_get_floating_sel(p_image: *Image) *gimp.Layer;
    pub const getFloatingSel = gimp_image_get_floating_sel;

    /// Get orientation of a guide on an image.
    ///
    /// This procedure takes an image and a guide ID as input and returns
    /// the orientations of the guide.
    extern fn gimp_image_get_guide_orientation(p_image: *Image, p_guide: c_uint) gimp.OrientationType;
    pub const getGuideOrientation = gimp_image_get_guide_orientation;

    /// Get position of a guide on an image.
    ///
    /// This procedure takes an image and a guide ID as input and returns
    /// the position of the guide relative to the top or left of the image.
    extern fn gimp_image_get_guide_position(p_image: *Image, p_guide: c_uint) c_int;
    pub const getGuidePosition = gimp_image_get_guide_position;

    /// Return the height of the image
    ///
    /// This procedure returns the image's height. This value is independent
    /// of any of the layers in this image. This is the \"canvas\" height.
    extern fn gimp_image_get_height(p_image: *Image) c_int;
    pub const getHeight = gimp_image_get_height;

    extern fn gimp_image_get_id(p_image: *Image) i32;
    pub const getId = gimp_image_get_id;

    /// Returns the imported file for the specified image.
    ///
    /// This procedure returns the file associated with the specified image
    /// if the image was imported from a non-native Gimp format. If the
    /// image was not imported, or has since been saved in the native Gimp
    /// format, this procedure returns `NULL`.
    extern fn gimp_image_get_imported_file(p_image: *Image) *gio.File;
    pub const getImportedFile = gimp_image_get_imported_file;

    /// Returns the position of the item in its level of its item tree.
    ///
    /// This procedure determines the position of the specified item in its
    /// level in its item tree in the image. If the item doesn't exist in
    /// the image, or the item is not part of an item tree, an error is
    /// returned.
    extern fn gimp_image_get_item_position(p_image: *Image, p_item: *gimp.Item) c_int;
    pub const getItemPosition = gimp_image_get_item_position;

    /// Find a layer with a given name in an image.
    ///
    /// This procedure returns the layer with the given name in the
    /// specified image.
    extern fn gimp_image_get_layer_by_name(p_image: *Image, p_name: [*:0]const u8) *gimp.Layer;
    pub const getLayerByName = gimp_image_get_layer_by_name;

    /// Find a layer with a given tattoo in an image.
    ///
    /// This procedure returns the layer with the given tattoo in the
    /// specified image.
    extern fn gimp_image_get_layer_by_tattoo(p_image: *Image, p_tattoo: c_uint) *gimp.Layer;
    pub const getLayerByTattoo = gimp_image_get_layer_by_tattoo;

    /// Returns the list of root layers contained in the specified image.
    ///
    /// This procedure returns the list of root layers contained in the
    /// specified image. The order of layers is from topmost to bottommost.
    /// Note that this is not the full list of layers, but only the root
    /// layers, i.e. layers with no parents themselves. If you need all
    /// layers, it is up to you to verify that any of these layers is a
    /// group layer with `gimp.Item.isGroup` and to obtain its children
    /// with `gimp.Item.getChildren` (possibly recursively checking if
    /// these have children too).
    extern fn gimp_image_get_layers(p_image: *Image) [*]*gimp.Layer;
    pub const getLayers = gimp_image_get_layers;

    /// Returns the image's metadata.
    ///
    /// Returns exif/iptc/xmp metadata from the image.
    extern fn gimp_image_get_metadata(p_image: *Image) ?*gimp.Metadata;
    pub const getMetadata = gimp_image_get_metadata;

    /// Returns the specified image's name.
    ///
    /// This procedure returns the image's name. If the image has a filename
    /// or an URI, then the returned name contains the filename's or URI's
    /// base name (the last component of the path). Otherwise it is the
    /// translated string \"Untitled\". The returned name is formatted like
    /// the image name in the image window title, it may contain '[]',
    /// '(imported)' etc. and should only be used to label user interface
    /// elements. Never use it to construct filenames.
    extern fn gimp_image_get_name(p_image: *Image) [*:0]u8;
    pub const getName = gimp_image_get_name;

    /// Returns the image's colormap
    ///
    /// This procedure returns the image's colormap as a `gimp.Palette`. If
    /// the image is not in Indexed color mode, `NULL` is returned.
    extern fn gimp_image_get_palette(p_image: *Image) *gimp.Palette;
    pub const getPalette = gimp_image_get_palette;

    /// Look up a parasite in an image
    ///
    /// Finds and returns the parasite that was previously attached to an
    /// image.
    extern fn gimp_image_get_parasite(p_image: *Image, p_name: [*:0]const u8) *gimp.Parasite;
    pub const getParasite = gimp_image_get_parasite;

    /// List all parasites.
    ///
    /// Returns a list of the names of all currently attached parasites.
    /// These names can later be used to get the actual `gimp.Parasite` with
    /// `gimp.Image.getParasite` when needed.
    extern fn gimp_image_get_parasite_list(p_image: *Image) [*][*:0]u8;
    pub const getParasiteList = gimp_image_get_parasite_list;

    /// Find a path with a given name in an image.
    ///
    /// This procedure returns the path with the given name in the specified
    /// image.
    extern fn gimp_image_get_path_by_name(p_image: *Image, p_name: [*:0]const u8) *gimp.Path;
    pub const getPathByName = gimp_image_get_path_by_name;

    /// Find a path with a given tattoo in an image.
    ///
    /// This procedure returns the path with the given tattoo in the
    /// specified image.
    extern fn gimp_image_get_path_by_tattoo(p_image: *Image, p_tattoo: c_uint) *gimp.Path;
    pub const getPathByTattoo = gimp_image_get_path_by_tattoo;

    /// Returns the list of paths contained in the specified image.
    ///
    /// This procedure returns the list of paths contained in the specified
    /// image.
    extern fn gimp_image_get_paths(p_image: *Image) [*]*gimp.Path;
    pub const getPaths = gimp_image_get_paths;

    /// Get the precision of the image.
    ///
    /// This procedure returns the image's precision.
    extern fn gimp_image_get_precision(p_image: *Image) gimp.Precision;
    pub const getPrecision = gimp_image_get_precision;

    /// Returns the specified image's resolution.
    ///
    /// This procedure returns the specified image's resolution in dots per
    /// inch. This value is independent of any of the layers in this image.
    extern fn gimp_image_get_resolution(p_image: *Image, p_xresolution: *f64, p_yresolution: *f64) c_int;
    pub const getResolution = gimp_image_get_resolution;

    /// Get position of a sample point on an image.
    ///
    /// This procedure takes an image and a sample point ID as input and
    /// returns the position of the sample point relative to the top and
    /// left of the image.
    extern fn gimp_image_get_sample_point_position(p_image: *Image, p_sample_point: c_uint, p_position_y: *c_int) c_int;
    pub const getSamplePointPosition = gimp_image_get_sample_point_position;

    /// Returns the specified image's selected channels.
    ///
    /// This procedure returns the list of selected channels in the
    /// specified image.
    extern fn gimp_image_get_selected_channels(p_image: *Image) [*]*gimp.Channel;
    pub const getSelectedChannels = gimp_image_get_selected_channels;

    /// Get the image's selected drawables
    ///
    /// This procedure returns the list of selected drawable in the
    /// specified image. This can be either layers, channels, or a layer
    /// mask.
    /// The active drawables are the active image channels. If there are
    /// none, these are the active image layers. If the active image layer
    /// has a layer mask and the layer mask is in edit mode, then the layer
    /// mask is the active drawable.
    extern fn gimp_image_get_selected_drawables(p_image: *Image) [*]*gimp.Drawable;
    pub const getSelectedDrawables = gimp_image_get_selected_drawables;

    /// Returns the specified image's selected layers.
    ///
    /// This procedure returns the list of selected layers in the specified
    /// image.
    extern fn gimp_image_get_selected_layers(p_image: *Image) [*]*gimp.Layer;
    pub const getSelectedLayers = gimp_image_get_selected_layers;

    /// Returns the specified image's selected paths.
    ///
    /// This procedure returns the list of selected paths in the specified
    /// image.
    extern fn gimp_image_get_selected_paths(p_image: *Image) [*]*gimp.Path;
    pub const getSelectedPaths = gimp_image_get_selected_paths;

    /// Returns the specified image's selection.
    ///
    /// This will always return a valid ID for a selection -- which is
    /// represented as a channel internally.
    extern fn gimp_image_get_selection(p_image: *Image) *gimp.Selection;
    pub const getSelection = gimp_image_get_selection;

    /// Returns whether the image has Black Point Compensation enabled for
    /// its simulation
    ///
    /// This procedure returns whether the image has Black Point
    /// Compensation enabled for its simulation
    extern fn gimp_image_get_simulation_bpc(p_image: *Image) c_int;
    pub const getSimulationBpc = gimp_image_get_simulation_bpc;

    /// Returns the image's simulation rendering intent
    ///
    /// This procedure returns the image's simulation rendering intent.
    extern fn gimp_image_get_simulation_intent(p_image: *Image) gimp.ColorRenderingIntent;
    pub const getSimulationIntent = gimp_image_get_simulation_intent;

    /// Returns the image's simulation color profile
    ///
    /// This procedure returns the image's simulation color profile, or NULL if
    /// the image has no simulation color profile assigned.
    extern fn gimp_image_get_simulation_profile(p_image: *Image) *gimp.ColorProfile;
    pub const getSimulationProfile = gimp_image_get_simulation_profile;

    /// Returns the tattoo state associated with the image.
    ///
    /// This procedure returns the tattoo state of the image. Use only by
    /// save/load plug-ins that wish to preserve an images tattoo state.
    /// Using this function at other times will produce unexpected results.
    extern fn gimp_image_get_tattoo_state(p_image: *Image) c_uint;
    pub const getTattooState = gimp_image_get_tattoo_state;

    /// Retrieves a thumbnail pixbuf for `image`.
    /// The thumbnail will be not larger than the requested size.
    extern fn gimp_image_get_thumbnail(p_image: *Image, p_width: c_int, p_height: c_int, p_alpha: gimp.PixbufTransparency) *gdkpixbuf.Pixbuf;
    pub const getThumbnail = gimp_image_get_thumbnail;

    /// Get a thumbnail of an image.
    ///
    /// This function gets data from which a thumbnail of an image preview
    /// can be created. Maximum x or y dimension is 1024 pixels. The pixels
    /// are returned in RGB[A] or GRAY[A] format. The bpp return value
    /// gives the number of bytes per pixel in the image.
    extern fn gimp_image_get_thumbnail_data(p_image: *Image, p_width: *c_int, p_height: *c_int, p_bpp: *c_int) *glib.Bytes;
    pub const getThumbnailData = gimp_image_get_thumbnail_data;

    /// Returns the specified image's unit.
    ///
    /// This procedure returns the specified image's unit. This value is
    /// independent of any of the layers in this image. See the
    /// gimp_unit_*() procedure definitions for the valid range of unit IDs
    /// and a description of the unit system.
    extern fn gimp_image_get_unit(p_image: *Image) *gimp.Unit;
    pub const getUnit = gimp_image_get_unit;

    /// Return the width of the image
    ///
    /// This procedure returns the image's width. This value is independent
    /// of any of the layers in this image. This is the \"canvas\" width.
    extern fn gimp_image_get_width(p_image: *Image) c_int;
    pub const getWidth = gimp_image_get_width;

    /// Returns the XCF file for the specified image.
    ///
    /// This procedure returns the XCF file associated with the image. If
    /// there is no such file, this procedure returns `NULL`.
    extern fn gimp_image_get_xcf_file(p_image: *Image) *gio.File;
    pub const getXcfFile = gimp_image_get_xcf_file;

    /// Sets the background color of an image's grid.
    ///
    /// This procedure gets the background color of an image's grid.
    extern fn gimp_image_grid_get_background_color(p_image: *Image) *gegl.Color;
    pub const gridGetBackgroundColor = gimp_image_grid_get_background_color;

    /// Sets the foreground color of an image's grid.
    ///
    /// This procedure gets the foreground color of an image's grid.
    extern fn gimp_image_grid_get_foreground_color(p_image: *Image) *gegl.Color;
    pub const gridGetForegroundColor = gimp_image_grid_get_foreground_color;

    /// Gets the offset of an image's grid.
    ///
    /// This procedure retrieves the horizontal and vertical offset of an
    /// image's grid. It takes the image as parameter.
    extern fn gimp_image_grid_get_offset(p_image: *Image, p_xoffset: *f64, p_yoffset: *f64) c_int;
    pub const gridGetOffset = gimp_image_grid_get_offset;

    /// Gets the spacing of an image's grid.
    ///
    /// This procedure retrieves the horizontal and vertical spacing of an
    /// image's grid. It takes the image as parameter.
    extern fn gimp_image_grid_get_spacing(p_image: *Image, p_xspacing: *f64, p_yspacing: *f64) c_int;
    pub const gridGetSpacing = gimp_image_grid_get_spacing;

    /// Gets the style of an image's grid.
    ///
    /// This procedure retrieves the style of an image's grid.
    extern fn gimp_image_grid_get_style(p_image: *Image) gimp.GridStyle;
    pub const gridGetStyle = gimp_image_grid_get_style;

    /// Gets the background color of an image's grid.
    ///
    /// This procedure sets the background color of an image's grid.
    extern fn gimp_image_grid_set_background_color(p_image: *Image, p_bgcolor: *gegl.Color) c_int;
    pub const gridSetBackgroundColor = gimp_image_grid_set_background_color;

    /// Gets the foreground color of an image's grid.
    ///
    /// This procedure sets the foreground color of an image's grid.
    extern fn gimp_image_grid_set_foreground_color(p_image: *Image, p_fgcolor: *gegl.Color) c_int;
    pub const gridSetForegroundColor = gimp_image_grid_set_foreground_color;

    /// Sets the offset of an image's grid.
    ///
    /// This procedure sets the horizontal and vertical offset of an image's
    /// grid.
    extern fn gimp_image_grid_set_offset(p_image: *Image, p_xoffset: f64, p_yoffset: f64) c_int;
    pub const gridSetOffset = gimp_image_grid_set_offset;

    /// Sets the spacing of an image's grid.
    ///
    /// This procedure sets the horizontal and vertical spacing of an
    /// image's grid.
    extern fn gimp_image_grid_set_spacing(p_image: *Image, p_xspacing: f64, p_yspacing: f64) c_int;
    pub const gridSetSpacing = gimp_image_grid_set_spacing;

    /// Sets the style unit of an image's grid.
    ///
    /// This procedure sets the style of an image's grid. It takes the image
    /// and the new style as parameters.
    extern fn gimp_image_grid_set_style(p_image: *Image, p_style: gimp.GridStyle) c_int;
    pub const gridSetStyle = gimp_image_grid_set_style;

    /// Import paths from an SVG file.
    ///
    /// This procedure imports paths from an SVG file. SVG elements other
    /// than paths and basic shapes are ignored.
    extern fn gimp_image_import_paths_from_file(p_image: *Image, p_file: *gio.File, p_merge: c_int, p_scale: c_int, p_paths: *[*]*gimp.Path) c_int;
    pub const importPathsFromFile = gimp_image_import_paths_from_file;

    /// Import paths from an SVG string.
    ///
    /// This procedure works like `gimp.Image.importPathsFromFile`
    /// but takes a string rather than reading the SVG from a file. This
    /// allows you to write scripts that generate SVG and feed it to GIMP.
    extern fn gimp_image_import_paths_from_string(p_image: *Image, p_string: [*:0]const u8, p_length: c_int, p_merge: c_int, p_scale: c_int, p_paths: *[*]*gimp.Path) c_int;
    pub const importPathsFromString = gimp_image_import_paths_from_string;

    /// Add the specified channel to the image.
    ///
    /// This procedure adds the specified channel to the image at the given
    /// position. Since channel groups are not currently supported, the
    /// parent argument must always be 0. The position argument specifies
    /// the location of the channel inside the stack, starting from the top
    /// (0) and increasing. If the position is specified as -1, then the
    /// channel is inserted above the active channel.
    extern fn gimp_image_insert_channel(p_image: *Image, p_channel: *gimp.Channel, p_parent: ?*gimp.Channel, p_position: c_int) c_int;
    pub const insertChannel = gimp_image_insert_channel;

    /// Add the specified layer to the image.
    ///
    /// This procedure adds the specified layer to the image at the given
    /// position. If the specified parent is a valid layer group (See
    /// `gimp.Item.isGroup` and `gimp_layer_group_new`) then the layer is
    /// added inside the group. If the parent is 0, the layer is added
    /// inside the main stack, outside of any group. The position argument
    /// specifies the location of the layer inside the stack (or the group,
    /// if a valid parent was supplied), starting from the top (0) and
    /// increasing. If the position is specified as -1 and the parent is
    /// specified as 0, then the layer is inserted above the active layer,
    /// or inside the group if the active layer is a layer group. The layer
    /// type must be compatible with the image base type.
    extern fn gimp_image_insert_layer(p_image: *Image, p_layer: *gimp.Layer, p_parent: ?*gimp.Layer, p_position: c_int) c_int;
    pub const insertLayer = gimp_image_insert_layer;

    /// Add the specified path to the image.
    ///
    /// This procedure adds the specified path to the image at the given
    /// position. Since path groups are not currently supported, the parent
    /// argument must always be 0. The position argument specifies the
    /// location of the path inside the stack, starting from the top (0) and
    /// increasing. If the position is specified as -1, then the path is
    /// inserted above the active path.
    extern fn gimp_image_insert_path(p_image: *Image, p_path: *gimp.Path, p_parent: ?*gimp.Path, p_position: c_int) c_int;
    pub const insertPath = gimp_image_insert_path;

    /// Checks if the image has unsaved changes.
    ///
    /// This procedure checks the specified image's dirty count to see if it
    /// needs to be saved. Note that saving the image does not automatically
    /// set the dirty count to 0, you need to call `gimp.Image.cleanAll`
    /// after calling a save procedure to make the image clean.
    extern fn gimp_image_is_dirty(p_image: *Image) c_int;
    pub const isDirty = gimp_image_is_dirty;

    /// Returns TRUE if the image is valid.
    ///
    /// This procedure checks if the given image is valid and refers to
    /// an existing image.
    extern fn gimp_image_is_valid(p_image: *Image) c_int;
    pub const isValid = gimp_image_is_valid;

    /// Returns the list of channels contained in the specified image.
    ///
    /// This procedure returns the list of channels contained in the
    /// specified image. This does not include the selection mask, or layer
    /// masks. The order is from topmost to bottommost. Note that
    /// "channels" are custom channels and do not include the image's
    /// color components.
    extern fn gimp_image_list_channels(p_image: *Image) *glib.List;
    pub const listChannels = gimp_image_list_channels;

    /// Returns the list of layers contained in the specified image.
    ///
    /// This procedure returns the list of layers contained in the specified
    /// image. The order of layers is from topmost to bottommost.
    extern fn gimp_image_list_layers(p_image: *Image) *glib.List;
    pub const listLayers = gimp_image_list_layers;

    /// Returns the list of paths contained in the specified image.
    ///
    /// This procedure returns the list of paths contained in the
    /// specified image.
    extern fn gimp_image_list_paths(p_image: *Image) *glib.List;
    pub const listPaths = gimp_image_list_paths;

    /// Returns the list of channels selected in the specified image.
    ///
    /// This procedure returns the list of channels selected in the specified
    /// image.
    extern fn gimp_image_list_selected_channels(p_image: *Image) *glib.List;
    pub const listSelectedChannels = gimp_image_list_selected_channels;

    /// Returns the list of drawables selected in the specified image.
    ///
    /// This procedure returns the list of drawables selected in the specified
    /// image.
    /// These can be either a list of layers or a list of channels (a list mixing
    /// layers and channels is not possible), or it can be a layer mask (a list
    /// containing only a layer mask as single item), if a layer mask is in edit
    /// mode.
    extern fn gimp_image_list_selected_drawables(p_image: *Image) *glib.List;
    pub const listSelectedDrawables = gimp_image_list_selected_drawables;

    /// Returns the list of layers selected in the specified image.
    ///
    /// This procedure returns the list of layers selected in the specified
    /// image.
    extern fn gimp_image_list_selected_layers(p_image: *Image) *glib.List;
    pub const listSelectedLayers = gimp_image_list_selected_layers;

    /// Returns the list of paths selected in the specified image.
    ///
    /// This procedure returns the list of paths selected in the specified
    /// image.
    extern fn gimp_image_list_selected_paths(p_image: *Image) *glib.List;
    pub const listSelectedPaths = gimp_image_list_selected_paths;

    /// Lower the specified item in its level in its item tree
    ///
    /// This procedure lowers the specified item one step in the item tree.
    /// The procedure call will fail if there is no item below it.
    extern fn gimp_image_lower_item(p_image: *Image, p_item: *gimp.Item) c_int;
    pub const lowerItem = gimp_image_lower_item;

    /// Lower the specified item to the bottom of its level in its item tree
    ///
    /// This procedure lowers the specified item to bottom of its level in
    /// the item tree. It will not move the layer if there is no layer below
    /// it.
    extern fn gimp_image_lower_item_to_bottom(p_image: *Image, p_item: *gimp.Item) c_int;
    pub const lowerItemToBottom = gimp_image_lower_item_to_bottom;

    /// Merge the layer passed and the first visible layer below.
    ///
    /// This procedure combines the passed layer and the first visible layer
    /// below it using the specified merge type. A merge type of
    /// EXPAND_AS_NECESSARY expands the final layer to encompass the areas
    /// of the visible layers. A merge type of CLIP_TO_IMAGE clips the final
    /// layer to the extents of the image. A merge type of
    /// CLIP_TO_BOTTOM_LAYER clips the final layer to the size of the
    /// bottommost layer.
    extern fn gimp_image_merge_down(p_image: *Image, p_merge_layer: *gimp.Layer, p_merge_type: gimp.MergeType) *gimp.Layer;
    pub const mergeDown = gimp_image_merge_down;

    /// Merge the visible image layers into one.
    ///
    /// This procedure combines the visible layers into a single layer using
    /// the specified merge type. A merge type of EXPAND_AS_NECESSARY
    /// expands the final layer to encompass the areas of the visible
    /// layers. A merge type of CLIP_TO_IMAGE clips the final layer to the
    /// extents of the image. A merge type of CLIP_TO_BOTTOM_LAYER clips the
    /// final layer to the size of the bottommost layer.
    extern fn gimp_image_merge_visible_layers(p_image: *Image, p_merge_type: gimp.MergeType) *gimp.Layer;
    pub const mergeVisibleLayers = gimp_image_merge_visible_layers;

    /// Filters the `metadata` retrieved from the image with
    /// `gimp.Image.metadataSavePrepare`, taking into account the
    /// passed `flags`.
    ///
    /// *Note: There is normally no need to call this function because it's
    /// already called by `ExportProcedure` after the ``run``
    /// callback.*
    ///
    /// Note that the `image` passed to this function might be different
    /// from the image passed to ``gimp.Image.metadataSavePrepare``, due
    /// to whatever file export conversion happened in the meantime
    ///
    /// This can be used as an alternative to core metadata handling when you
    /// want to save metadata yourself and you need only filtering
    /// processing.
    extern fn gimp_image_metadata_save_filter(p_image: *Image, p_mime_type: [*:0]const u8, p_metadata: *gimp.Metadata, p_flags: gimp.MetadataSaveFlags, p_file: *gio.File, p_error: ?*?*glib.Error) ?*gimp.Metadata;
    pub const metadataSaveFilter = gimp_image_metadata_save_filter;

    /// Gets the image metadata for storing it in an exported file.
    ///
    /// *Note: There is normally no need to call this function because it's
    /// already called by `ExportProcedure` at the start and the
    /// metadata is passed to the ``run`` callback.*
    ///
    /// *You may call it separately for instance if you set `export_metadata`
    /// to `NULL` in `gimp.ExportProcedure.new` to prevent `libgimp`
    /// from trying to store the metadata in the exported file, yet you wish
    /// to process and store the metadata yourself using custom API.*
    ///
    /// The `suggested_flags` are determined from what kind of metadata (Exif,
    /// XMP, ...) is actually present in the image and the preferences for
    /// metadata exporting.
    /// The calling application may still ignore `suggested_flags`, for
    /// instance to follow the settings from a previous export in the same
    /// session, or a previous export of the same image. But it should not
    /// override the preferences without a good reason since it is a data
    /// leak.
    ///
    /// The suggested value for `gimp.@"MetadataSaveFlags.THUMBNAIL"` is
    /// determined by whether there was a thumbnail in the previously
    /// imported image.
    extern fn gimp_image_metadata_save_prepare(p_image: *Image, p_mime_type: [*:0]const u8, p_suggested_flags: *gimp.MetadataSaveFlags) *gimp.Metadata;
    pub const metadataSavePrepare = gimp_image_metadata_save_prepare;

    /// Determine the color at the given coordinates
    ///
    /// This tool determines the color at the specified coordinates. The
    /// returned color is an RGB triplet even for grayscale and indexed
    /// drawables. If the coordinates lie outside of the extents of the
    /// specified drawables, then an error is returned. All drawables must
    /// belong to the image and be of the same type.
    /// If only one drawable is given and it has an alpha channel, the
    /// algorithm examines the alpha value of the drawable at the
    /// coordinates. If the alpha value is completely transparent (0), then
    /// an error is returned. With several drawables specified, the
    /// composite image with only these drawables is used.
    /// If the sample_merged parameter is TRUE, the data of the composite
    /// image will be used instead of that for the specified drawables. This
    /// is equivalent to sampling for colors after merging all visible
    /// layers. In the case of a merged sampling, the supplied drawables are
    /// ignored.
    extern fn gimp_image_pick_color(p_image: *Image, p_drawables: [*]*const gimp.Drawable, p_x: f64, p_y: f64, p_sample_merged: c_int, p_sample_average: c_int, p_average_radius: f64, p_color: **gegl.Color) c_int;
    pub const pickColor = gimp_image_pick_color;

    /// Find the layer visible at the specified coordinates.
    ///
    /// This procedure finds the layer which is visible at the specified
    /// coordinates. Layers which do not qualify are those whose extents do
    /// not pass within the specified coordinates, or which are transparent
    /// at the specified coordinates. This procedure will return -1 if no
    /// layer is found.
    extern fn gimp_image_pick_correlate_layer(p_image: *Image, p_x: c_int, p_y: c_int) *gimp.Layer;
    pub const pickCorrelateLayer = gimp_image_pick_correlate_layer;

    /// Execute the color profile conversion policy.
    ///
    /// Process the image according to the color profile policy as set in
    /// Preferences.
    /// If GIMP is running as a GUI and interactive is TRUE, a dialog may be
    /// presented to the user depending on the policy. Otherwise, if the
    /// policy does not mandate the conversion to perform, the conversion to
    /// the preferred RGB or grayscale profile will happen, defaulting to
    /// built-in profiles if no preferred profiles were set in
    /// `Preferences`.
    /// This function should be used only if you want to follow user
    /// settings. If you intend to convert to a specific profile, call
    /// preferably `gimp.Image.convertColorProfile`. And if you wish to
    /// leave whatever profile an image has, do not call any of these
    /// functions.
    /// Finally it is unnecessary to call this function in a format load
    /// procedure because this is called automatically by the core code when
    /// loading any image. You should only call this function explicitly
    /// when loading an image through a PDB call.
    extern fn gimp_image_policy_color_profile(p_image: *Image, p_interactive: c_int) c_int;
    pub const policyColorProfile = gimp_image_policy_color_profile;

    /// Execute the \"Orientation\" metadata policy.
    ///
    /// Process the image according to the rotation policy as set in
    /// Preferences. If GIMP is running as a GUI and interactive is TRUE, a
    /// dialog may be presented to the user depending on the set policy.
    /// Otherwise, if the policy does not mandate the action to perform, the
    /// image will be rotated following the Orientation metadata.
    /// If you wish absolutely to rotate a loaded image following the
    /// Orientation metadata, do not use this function and process the
    /// metadata yourself. Indeed even with `interactive` to FALSE, user
    /// settings may leave the image unrotated.
    /// Finally it is unnecessary to call this function in a format load
    /// procedure because this is called automatically by the core code when
    /// loading any image. You should only call this function explicitly
    /// when loading an image through a PDB call.
    extern fn gimp_image_policy_rotate(p_image: *Image, p_interactive: c_int) c_int;
    pub const policyRotate = gimp_image_policy_rotate;

    /// Raise the specified item in its level in its item tree
    ///
    /// This procedure raises the specified item one step in the item tree.
    /// The procedure call will fail if there is no item above it.
    extern fn gimp_image_raise_item(p_image: *Image, p_item: *gimp.Item) c_int;
    pub const raiseItem = gimp_image_raise_item;

    /// Raise the specified item to the top of its level in its item tree
    ///
    /// This procedure raises the specified item to top of its level in the
    /// item tree. It will not move the item if there is no item above it.
    extern fn gimp_image_raise_item_to_top(p_image: *Image, p_item: *gimp.Item) c_int;
    pub const raiseItemToTop = gimp_image_raise_item_to_top;

    /// Remove the specified channel from the image.
    ///
    /// This procedure removes the specified channel from the image. If the
    /// channel doesn't exist, an error is returned.
    extern fn gimp_image_remove_channel(p_image: *Image, p_channel: *gimp.Channel) c_int;
    pub const removeChannel = gimp_image_remove_channel;

    /// Remove the specified layer from the image.
    ///
    /// This procedure removes the specified layer from the image. If the
    /// layer doesn't exist, an error is returned. If there are no layers
    /// left in the image, this call will fail. If this layer is the last
    /// layer remaining, the image will become empty and have no active
    /// layer.
    extern fn gimp_image_remove_layer(p_image: *Image, p_layer: *gimp.Layer) c_int;
    pub const removeLayer = gimp_image_remove_layer;

    /// Remove the specified path from the image.
    ///
    /// This procedure removes the specified path from the image. If the
    /// path doesn't exist, an error is returned.
    extern fn gimp_image_remove_path(p_image: *Image, p_path: *gimp.Path) c_int;
    pub const removePath = gimp_image_remove_path;

    /// Reorder the specified item within its item tree
    ///
    /// Reorders or moves item within an item tree. Requires parent is `NULL`
    /// or a GroupLayer, else returns error. When parent is not `NULL` and
    /// item is in parent, reorders item within parent group. When parent is
    /// not `NULL` and item is not in parent, moves item into parent group.
    /// When parent is `NULL`, moves item from current parent to top level.
    ///
    /// Requires item is in same tree as not `NULL` parent, else returns
    /// error. Layers, Channels, and Paths are in separate trees.
    ///
    /// Requires item is not ancestor of parent, else returns error, to
    /// preclude cycles.
    extern fn gimp_image_reorder_item(p_image: *Image, p_item: *gimp.Item, p_parent: ?*gimp.Item, p_position: c_int) c_int;
    pub const reorderItem = gimp_image_reorder_item;

    /// Resize the image to the specified extents.
    ///
    /// This procedure resizes the image so that it's new width and height
    /// are equal to the supplied parameters. Offsets are also provided
    /// which describe the position of the previous image's content. All
    /// channels within the image are resized according to the specified
    /// parameters; this includes the image selection mask. All layers
    /// within the image are repositioned according to the specified
    /// offsets.
    extern fn gimp_image_resize(p_image: *Image, p_new_width: c_int, p_new_height: c_int, p_offx: c_int, p_offy: c_int) c_int;
    pub const resize = gimp_image_resize;

    /// Resize the image to fit all layers.
    ///
    /// This procedure resizes the image to the bounding box of all layers
    /// of the image. All channels within the image are resized to the new
    /// size; this includes the image selection mask. All layers within the
    /// image are repositioned to the new image area.
    extern fn gimp_image_resize_to_layers(p_image: *Image) c_int;
    pub const resizeToLayers = gimp_image_resize_to_layers;

    /// Rotates the image by the specified degrees.
    ///
    /// This procedure rotates the image.
    extern fn gimp_image_rotate(p_image: *Image, p_rotate_type: gimp.RotationType) c_int;
    pub const rotate = gimp_image_rotate;

    /// Scale the image using the default interpolation method.
    ///
    /// This procedure scales the image so that its new width and height are
    /// equal to the supplied parameters. All layers and channels within the
    /// image are scaled according to the specified parameters; this
    /// includes the image selection mask. The interpolation method used can
    /// be set with `gimp.contextSetInterpolation`.
    extern fn gimp_image_scale(p_image: *Image, p_new_width: c_int, p_new_height: c_int) c_int;
    pub const scale = gimp_image_scale;

    /// Create a selection by selecting all pixels (in the specified
    /// drawable) with the same (or similar) color to that specified.
    ///
    /// This tool creates a selection over the specified image. A by-color
    /// selection is determined by the supplied color under the constraints
    /// of the current context settings. Essentially, all pixels (in the
    /// drawable) that have color sufficiently close to the specified color
    /// (as determined by the threshold and criterion context values) are
    /// included in the selection. To select transparent regions, the color
    /// specified must also have minimum alpha.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`, `gimp.contextSetSampleMerged`,
    /// `gimp.contextSetSampleCriterion`,
    /// `gimp.contextSetSampleThreshold`,
    /// `gimp.contextSetSampleTransparent`.
    ///
    /// In the case of a merged sampling, the supplied drawable is ignored.
    extern fn gimp_image_select_color(p_image: *Image, p_operation: gimp.ChannelOps, p_drawable: *gimp.Drawable, p_color: *gegl.Color) c_int;
    pub const selectColor = gimp_image_select_color;

    /// Create a selection by selecting all pixels around specified
    /// coordinates with the same (or similar) color to that at the
    /// coordinates.
    ///
    /// This tool creates a contiguous selection over the specified image. A
    /// contiguous color selection is determined by a seed fill under the
    /// constraints of the current context settings. Essentially, the color
    /// at the specified coordinates (in the drawable) is measured and the
    /// selection expands outwards from that point to any adjacent pixels
    /// which are not significantly different (as determined by the
    /// threshold and criterion context settings). This process continues
    /// until no more expansion is possible. If antialiasing is turned on,
    /// the final selection mask will contain intermediate values based on
    /// close misses to the threshold bar at pixels along the seed fill
    /// boundary.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`, `gimp.contextSetSampleMerged`,
    /// `gimp.contextSetSampleCriterion`,
    /// `gimp.contextSetSampleThreshold`,
    /// `gimp.contextSetSampleTransparent`,
    /// `gimp.contextSetDiagonalNeighbors`.
    ///
    /// In the case of a merged sampling, the supplied drawable is ignored.
    /// If the sample is merged, the specified coordinates are relative to
    /// the image origin; otherwise, they are relative to the drawable's
    /// origin.
    extern fn gimp_image_select_contiguous_color(p_image: *Image, p_operation: gimp.ChannelOps, p_drawable: *gimp.Drawable, p_x: f64, p_y: f64) c_int;
    pub const selectContiguousColor = gimp_image_select_contiguous_color;

    /// Create an elliptical selection over the specified image.
    ///
    /// This tool creates an elliptical selection over the specified image.
    /// The elliptical region can be either added to, subtracted from, or
    /// replace the contents of the previous selection mask.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`.
    extern fn gimp_image_select_ellipse(p_image: *Image, p_operation: gimp.ChannelOps, p_x: f64, p_y: f64, p_width: f64, p_height: f64) c_int;
    pub const selectEllipse = gimp_image_select_ellipse;

    /// Transforms the specified item into a selection
    ///
    /// This procedure renders the item's outline into the current selection
    /// of the image the item belongs to. What exactly the item's outline is
    /// depends on the item type: for layers, it's the layer's alpha
    /// channel, for vectors the vector's shape.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`.
    extern fn gimp_image_select_item(p_image: *Image, p_operation: gimp.ChannelOps, p_item: *gimp.Item) c_int;
    pub const selectItem = gimp_image_select_item;

    /// Create a polygonal selection over the specified image.
    ///
    /// This tool creates a polygonal selection over the specified image.
    /// The polygonal region can be either added to, subtracted from, or
    /// replace the contents of the previous selection mask. The polygon is
    /// specified through an array of floating point numbers and its length.
    /// The length of array must be 2n, where n is the number of points.
    /// Each point is defined by 2 floating point values which correspond to
    /// the x and y coordinates. If the final point does not connect to the
    /// starting point, a connecting segment is automatically added.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`.
    extern fn gimp_image_select_polygon(p_image: *Image, p_operation: gimp.ChannelOps, p_num_segs: usize, p_segs: [*]const f64) c_int;
    pub const selectPolygon = gimp_image_select_polygon;

    /// Create a rectangular selection over the specified image;
    ///
    /// This tool creates a rectangular selection over the specified image.
    /// The rectangular region can be either added to, subtracted from, or
    /// replace the contents of the previous selection mask.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetFeather`, `gimp.contextSetFeatherRadius`.
    extern fn gimp_image_select_rectangle(p_image: *Image, p_operation: gimp.ChannelOps, p_x: f64, p_y: f64, p_width: f64, p_height: f64) c_int;
    pub const selectRectangle = gimp_image_select_rectangle;

    /// Create a rectangular selection with round corners over the specified
    /// image;
    ///
    /// This tool creates a rectangular selection with round corners over
    /// the specified image. The rectangular region can be either added to,
    /// subtracted from, or replace the contents of the previous selection
    /// mask.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetAntialias`, `gimp.contextSetFeather`,
    /// `gimp.contextSetFeatherRadius`.
    extern fn gimp_image_select_round_rectangle(p_image: *Image, p_operation: gimp.ChannelOps, p_x: f64, p_y: f64, p_width: f64, p_height: f64, p_corner_radius_x: f64, p_corner_radius_y: f64) c_int;
    pub const selectRoundRectangle = gimp_image_select_round_rectangle;

    /// Sets the image's color profile
    ///
    /// This procedure sets the image's color profile.
    extern fn gimp_image_set_color_profile(p_image: *Image, p_profile: ?*gimp.ColorProfile) c_int;
    pub const setColorProfile = gimp_image_set_color_profile;

    /// Sets the image's color profile from an ICC file
    ///
    /// This procedure sets the image's color profile from a file containing
    /// an ICC profile, or unsets it if NULL is passed as 'file'. This
    /// procedure does no color conversion. However, it will change the
    /// pixel format of all layers to contain the babl space matching the
    /// profile. You must call this procedure before adding layers to the
    /// image.
    extern fn gimp_image_set_color_profile_from_file(p_image: *Image, p_file: *gio.File) c_int;
    pub const setColorProfileFromFile = gimp_image_set_color_profile_from_file;

    /// Sets if the specified image's image component is active.
    ///
    /// This procedure sets if the specified image's image component (i.e.
    /// Red, Green, Blue intensity channels in an RGB image) is active or
    /// inactive -- whether or not it can be modified. If the specified
    /// component is not valid for the image type, an error is returned.
    extern fn gimp_image_set_component_active(p_image: *Image, p_component: gimp.ChannelType, p_active: c_int) c_int;
    pub const setComponentActive = gimp_image_set_component_active;

    /// Sets if the specified image's image component is visible.
    ///
    /// This procedure sets if the specified image's image component (i.e.
    /// Red, Green, Blue intensity channels in an RGB image) is visible or
    /// invisible -- whether or not it can be seen. If the specified
    /// component is not valid for the image type, an error is returned.
    extern fn gimp_image_set_component_visible(p_image: *Image, p_component: gimp.ChannelType, p_visible: c_int) c_int;
    pub const setComponentVisible = gimp_image_set_component_visible;

    /// Sets the specified XCF image's file.
    ///
    /// This procedure sets the specified image's file.
    /// This is to set the XCF file associated with your image. In
    /// particular, do not use this function to set the imported file in
    /// file import plug-ins. This is done by the core process.
    extern fn gimp_image_set_file(p_image: *Image, p_file: *gio.File) c_int;
    pub const setFile = gimp_image_set_file;

    /// Set the image's metadata.
    ///
    /// Sets exif/iptc/xmp metadata on the image, or deletes it if
    /// `metadata` is `NULL`.
    extern fn gimp_image_set_metadata(p_image: *Image, p_metadata: *gimp.Metadata) c_int;
    pub const setMetadata = gimp_image_set_metadata;

    /// Set the image's colormap to a copy of `palette`
    ///
    /// This procedure changes the image's colormap to an exact copy of
    /// `palette` and returns the palette of `image`.
    /// If the image is not in Indexed color mode, nothing happens and `NULL`
    /// is returned.
    extern fn gimp_image_set_palette(p_image: *Image, p_new_palette: *gimp.Palette) *gimp.Palette;
    pub const setPalette = gimp_image_set_palette;

    /// Sets the specified image's resolution.
    ///
    /// This procedure sets the specified image's resolution in dots per
    /// inch. This value is independent of any of the layers in this image.
    /// No scaling or resizing is performed.
    extern fn gimp_image_set_resolution(p_image: *Image, p_xresolution: f64, p_yresolution: f64) c_int;
    pub const setResolution = gimp_image_set_resolution;

    /// Sets the specified image's selected channels.
    ///
    /// The channels are set as the selected channels in the image. Any
    /// previous selected layers or channels are unselected. An exception is
    /// a previously existing floating selection, in which case this
    /// procedure will return an execution error.
    extern fn gimp_image_set_selected_channels(p_image: *Image, p_channels: [*]*const gimp.Channel) c_int;
    pub const setSelectedChannels = gimp_image_set_selected_channels;

    /// Sets the specified image's selected layers.
    ///
    /// The layers are set as the selected layers in the image. Any previous
    /// selected layers or channels are unselected. An exception is a
    /// previously existing floating selection, in which case this procedure
    /// will return an execution error.
    extern fn gimp_image_set_selected_layers(p_image: *Image, p_layers: [*]*const gimp.Layer) c_int;
    pub const setSelectedLayers = gimp_image_set_selected_layers;

    /// Sets the specified image's selected paths.
    ///
    /// The paths are set as the selected paths in the image.
    extern fn gimp_image_set_selected_paths(p_image: *Image, p_paths: [*]*const gimp.Path) c_int;
    pub const setSelectedPaths = gimp_image_set_selected_paths;

    /// Sets whether the image has Black Point Compensation enabled for its
    /// simulation
    ///
    /// This procedure whether the image has Black Point Compensation
    /// enabled for its simulation
    extern fn gimp_image_set_simulation_bpc(p_image: *Image, p_bpc: c_int) c_int;
    pub const setSimulationBpc = gimp_image_set_simulation_bpc;

    /// Sets the image's simulation rendering intent
    ///
    /// This procedure sets the image's simulation rendering intent.
    extern fn gimp_image_set_simulation_intent(p_image: *Image, p_intent: gimp.ColorRenderingIntent) c_int;
    pub const setSimulationIntent = gimp_image_set_simulation_intent;

    /// Sets the image's simulation color profile
    ///
    /// This procedure sets the image's simulation color profile.
    extern fn gimp_image_set_simulation_profile(p_image: *Image, p_profile: ?*gimp.ColorProfile) c_int;
    pub const setSimulationProfile = gimp_image_set_simulation_profile;

    /// Sets the image's simulation color profile from an ICC file
    ///
    /// This procedure sets the image's simulation color profile from a file
    /// containing an ICC profile, or unsets it if NULL is passed as 'file'.
    /// This procedure does no color conversion.
    extern fn gimp_image_set_simulation_profile_from_file(p_image: *Image, p_file: *gio.File) c_int;
    pub const setSimulationProfileFromFile = gimp_image_set_simulation_profile_from_file;

    /// Set the tattoo state associated with the image.
    ///
    /// This procedure sets the tattoo state of the image. Use only by
    /// save/load plug-ins that wish to preserve an images tattoo state.
    /// Using this function at other times will produce unexpected results.
    /// A full check of uniqueness of states in layers, channels and paths
    /// will be performed by this procedure and a execution failure will be
    /// returned if this fails. A failure will also be returned if the new
    /// tattoo state value is less than the maximum tattoo value from all of
    /// the tattoos from the paths, layers and channels. After the image
    /// data has been loaded and all the tattoos have been set then this is
    /// the last procedure that should be called. If effectively does a
    /// status check on the tattoo values that have been set to make sure
    /// that all is OK.
    extern fn gimp_image_set_tattoo_state(p_image: *Image, p_tattoo_state: c_uint) c_int;
    pub const setTattooState = gimp_image_set_tattoo_state;

    /// Sets the specified image's unit.
    ///
    /// This procedure sets the specified image's unit. No scaling or
    /// resizing is performed. This value is independent of any of the
    /// layers in this image. See the gimp_unit_*() procedure definitions
    /// for the valid range of unit IDs and a description of the unit
    /// system.
    extern fn gimp_image_set_unit(p_image: *Image, p_unit: *gimp.Unit) c_int;
    pub const setUnit = gimp_image_set_unit;

    /// The channels are set as the selected channels in the image. Any previous
    /// selected layers or channels are unselected. An exception is a previously
    /// existing floating selection, in which case this procedure will return an
    /// execution error.
    extern fn gimp_image_take_selected_channels(p_image: *Image, p_channels: *glib.List) c_int;
    pub const takeSelectedChannels = gimp_image_take_selected_channels;

    /// The layers are set as the selected layers in the image. Any previous
    /// selected layers or channels are unselected. An exception is a previously
    /// existing floating selection, in which case this procedure will return an
    /// execution error.
    extern fn gimp_image_take_selected_layers(p_image: *Image, p_layers: *glib.List) c_int;
    pub const takeSelectedLayers = gimp_image_take_selected_layers;

    /// The paths are set as the selected paths in the image. Any previous
    /// selected paths are unselected.
    extern fn gimp_image_take_selected_paths(p_image: *Image, p_paths: *glib.List) c_int;
    pub const takeSelectedPaths = gimp_image_take_selected_paths;

    /// Thaw the image's channel list.
    ///
    /// This procedure thaws the channel list of the image, re-enabling
    /// updates to the Channels dialog.
    ///
    /// This procedure should match a corresponding call to
    /// `gimp.Image.freezeChannels`.
    extern fn gimp_image_thaw_channels(p_image: *Image) c_int;
    pub const thawChannels = gimp_image_thaw_channels;

    /// Thaw the image's layer list.
    ///
    /// This procedure thaws the layer list of the image, re-enabling
    /// updates to the Layers dialog.
    ///
    /// This procedure should match a corresponding call to
    /// `gimp.Image.freezeLayers`.
    extern fn gimp_image_thaw_layers(p_image: *Image) c_int;
    pub const thawLayers = gimp_image_thaw_layers;

    /// Thaw the image's path list.
    ///
    /// This procedure thaws the path list of the image, re-enabling updates
    /// to the Paths dialog.
    ///
    /// This procedure should match a corresponding call to
    /// `gimp.Image.freezePaths`.
    extern fn gimp_image_thaw_paths(p_image: *Image) c_int;
    pub const thawPaths = gimp_image_thaw_paths;

    /// Disable the image's undo stack.
    ///
    /// This procedure disables the image's undo stack, allowing subsequent
    /// operations to ignore their undo steps. This is generally called in
    /// conjunction with `gimp.Image.undoEnable` to temporarily disable an
    /// image undo stack. This is advantageous because saving undo steps can
    /// be time and memory intensive.
    extern fn gimp_image_undo_disable(p_image: *Image) c_int;
    pub const undoDisable = gimp_image_undo_disable;

    /// Enable the image's undo stack.
    ///
    /// This procedure enables the image's undo stack, allowing subsequent
    /// operations to store their undo steps. This is generally called in
    /// conjunction with `gimp.Image.undoDisable` to temporarily disable an
    /// image undo stack.
    extern fn gimp_image_undo_enable(p_image: *Image) c_int;
    pub const undoEnable = gimp_image_undo_enable;

    /// Freeze the image's undo stack.
    ///
    /// This procedure freezes the image's undo stack, allowing subsequent
    /// operations to ignore their undo steps. This is generally called in
    /// conjunction with `gimp.Image.undoThaw` to temporarily disable an
    /// image undo stack. This is advantageous because saving undo steps can
    /// be time and memory intensive. `gimp.Image.undoFreeze` /
    /// `gimp.Image.undoThaw` and `gimp.Image.undoDisable` /
    /// `gimp.Image.undoEnable` differ in that the former does not free up
    /// all undo steps when undo is thawed, so is more suited to interactive
    /// in-situ previews. It is important in this case that the image is
    /// back to the same state it was frozen in before thawing, else 'undo'
    /// behavior is undefined.
    extern fn gimp_image_undo_freeze(p_image: *Image) c_int;
    pub const undoFreeze = gimp_image_undo_freeze;

    /// Finish a group undo.
    ///
    /// This function must be called once for each
    /// `gimp.Image.undoGroupStart` call that is made.
    extern fn gimp_image_undo_group_end(p_image: *Image) c_int;
    pub const undoGroupEnd = gimp_image_undo_group_end;

    /// Starts a group undo.
    ///
    /// This function is used to start a group undo--necessary for logically
    /// combining two or more undo operations into a single operation. This
    /// call must be used in conjunction with a `gimp.Image.undoGroupEnd`
    /// call.
    extern fn gimp_image_undo_group_start(p_image: *Image) c_int;
    pub const undoGroupStart = gimp_image_undo_group_start;

    /// Check if the image's undo stack is enabled.
    ///
    /// This procedure checks if the image's undo stack is currently enabled
    /// or disabled. This is useful when several plug-ins or scripts call
    /// each other and want to check if their caller has already used
    /// `gimp.Image.undoDisable` or `gimp.Image.undoFreeze`.
    extern fn gimp_image_undo_is_enabled(p_image: *Image) c_int;
    pub const undoIsEnabled = gimp_image_undo_is_enabled;

    /// Thaw the image's undo stack.
    ///
    /// This procedure thaws the image's undo stack, allowing subsequent
    /// operations to store their undo steps. This is generally called in
    /// conjunction with `gimp.Image.undoFreeze` to temporarily freeze an
    /// image undo stack. `gimp.Image.undoThaw` does NOT free the undo
    /// stack as `gimp.Image.undoEnable` does, so is suited for situations
    /// where one wishes to leave the undo stack in the same state in which
    /// one found it despite non-destructively playing with the image in the
    /// meantime. An example would be in-situ plug-in previews. Balancing
    /// freezes and thaws and ensuring image consistency is the
    /// responsibility of the caller.
    extern fn gimp_image_undo_thaw(p_image: *Image) c_int;
    pub const undoThaw = gimp_image_undo_thaw;

    /// Unsets the active channel in the specified image.
    ///
    /// If an active channel exists, it is unset. There then exists no
    /// active channel, and if desired, one can be set through a call to
    /// 'Set Active Channel'. No error is returned in the case of no
    /// existing active channel.
    extern fn gimp_image_unset_active_channel(p_image: *Image) c_int;
    pub const unsetActiveChannel = gimp_image_unset_active_channel;

    extern fn gimp_image_get_type() usize;
    pub const getGObjectType = gimp_image_get_type;

    extern fn g_object_ref(p_self: *gimp.Image) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Image) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Image, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `Procedure` subclass that makes it easier to write standard plug-in
/// procedures that operate on drawables.
///
/// It automatically adds the standard
///
/// ( `RunMode`, `Image`, `Drawable` )
///
/// arguments of an image procedure. It is possible to add additional
/// arguments.
///
/// When invoked via `Procedure.run`, it unpacks these standard
/// arguments and calls `run_func` which is a `RunImageFunc`. The
/// "args" `ValueArray` of `RunImageFunc` only contains
/// additionally added arguments.
pub const ImageProcedure = opaque {
    pub const Parent = gimp.Procedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.ImageProcedureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new image procedure named `name` which will call `run_func`
    /// when invoked.
    ///
    /// See `Procedure.new` for information about `proc_type`.
    extern fn gimp_image_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_run_func: gimp.RunImageFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.ImageProcedure;
    pub const new = gimp_image_procedure_new;

    extern fn gimp_image_procedure_get_type() usize;
    pub const getGObjectType = gimp_image_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.ImageProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ImageProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ImageProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions to manipulate items.
pub const Item = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ItemClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns a `gimp.Item` representing `item_id`. Since `gimp.Item` is an
    /// abstract class, the real object type will actually be the proper
    /// subclass.
    ///
    /// Note: in most use cases, you should not need to retrieve a `gimp.Item`
    /// by its ID, which is mostly internal data and not reusable across
    /// sessions. Use the appropriate functions for your use case instead.
    extern fn gimp_item_get_by_id(p_item_id: i32) ?*gimp.Item;
    pub const getById = gimp_item_get_by_id;

    /// Returns whether the item ID is a channel.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a channel.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_channel(p_item_id: c_int) c_int;
    pub const idIsChannel = gimp_item_id_is_channel;

    /// Returns whether the item ID is a drawable.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a drawable.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_drawable(p_item_id: c_int) c_int;
    pub const idIsDrawable = gimp_item_id_is_drawable;

    /// Returns whether the item ID is a group layer.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a group
    /// layer.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_group_layer(p_item_id: c_int) c_int;
    pub const idIsGroupLayer = gimp_item_id_is_group_layer;

    /// Returns whether the item ID is a layer.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a layer.
    ///
    /// *Note*: in most use cases, you should not use this function. If the
    /// goal is to verify the accurate type for a `gimp.Item`, you
    /// should either use `gimp.Item.isLayer` or the specific
    /// type-checking methods for the used language.
    ///
    /// For instance, in C:
    ///
    /// ```C
    /// if (GIMP_IS_LAYER (item))
    ///   do_something ();
    /// ```
    ///
    /// Or in the Python binding, you could run:
    ///
    /// ```py3
    /// if isinstance(item, Gimp.Layer):
    ///   `do_something`
    /// ```
    extern fn gimp_item_id_is_layer(p_item_id: c_int) c_int;
    pub const idIsLayer = gimp_item_id_is_layer;

    /// Returns whether the item ID is a layer mask.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a layer
    /// mask.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_layer_mask(p_item_id: c_int) c_int;
    pub const idIsLayerMask = gimp_item_id_is_layer_mask;

    /// Returns whether the item ID is a path.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a path.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_path(p_item_id: c_int) c_int;
    pub const idIsPath = gimp_item_id_is_path;

    /// Returns whether the item ID is a selection.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a
    /// selection.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_selection(p_item_id: c_int) c_int;
    pub const idIsSelection = gimp_item_id_is_selection;

    /// Returns whether the item ID is a text layer.
    ///
    /// This procedure returns `TRUE` if the specified item ID is a text
    /// layer.
    ///
    /// *Note*: in most use cases, you should not use this function. See
    /// `gimp.Item.idIsLayer` for a discussion on alternatives.
    extern fn gimp_item_id_is_text_layer(p_item_id: c_int) c_int;
    pub const idIsTextLayer = gimp_item_id_is_text_layer;

    /// Returns `TRUE` if the item ID is valid.
    ///
    /// This procedure checks if the given item ID is valid and refers to an
    /// existing item.
    ///
    /// *Note*: in most use cases, you should not use this function. If you
    /// got a `gimp.Item` from the API, you should trust it is valid.
    /// This function is mostly for internal usage.
    extern fn gimp_item_id_is_valid(p_item_id: c_int) c_int;
    pub const idIsValid = gimp_item_id_is_valid;

    /// Add a parasite to an item.
    ///
    /// This procedure attaches a parasite to an item. It has no return
    /// values.
    extern fn gimp_item_attach_parasite(p_item: *Item, p_parasite: *const gimp.Parasite) c_int;
    pub const attachParasite = gimp_item_attach_parasite;

    /// Delete a item.
    ///
    /// This procedure deletes the specified item. This must not be done if
    /// the image containing this item was already deleted or if the item
    /// was already removed from the image. The only case in which this
    /// procedure is useful is if you want to get rid of a item which has
    /// not yet been added to an image.
    extern fn gimp_item_delete(p_item: *Item) c_int;
    pub const delete = gimp_item_delete;

    /// Removes a parasite from an item.
    ///
    /// This procedure detaches a parasite from an item. It has no return
    /// values.
    extern fn gimp_item_detach_parasite(p_item: *Item, p_name: [*:0]const u8) c_int;
    pub const detachParasite = gimp_item_detach_parasite;

    /// Returns the item's list of children.
    ///
    /// This procedure returns the list of items which are children of the
    /// specified item. The order is topmost to bottommost.
    extern fn gimp_item_get_children(p_item: *Item) [*]*gimp.Item;
    pub const getChildren = gimp_item_get_children;

    /// Get the color tag of the specified item.
    ///
    /// This procedure returns the specified item's color tag.
    extern fn gimp_item_get_color_tag(p_item: *Item) gimp.ColorTag;
    pub const getColorTag = gimp_item_get_color_tag;

    /// Returns whether the item is expanded.
    ///
    /// This procedure returns `TRUE` if the specified item is expanded.
    extern fn gimp_item_get_expanded(p_item: *Item) c_int;
    pub const getExpanded = gimp_item_get_expanded;

    /// Note: in most use cases, you should not need an item's ID which is
    /// mostly internal data and not reusable across sessions.
    extern fn gimp_item_get_id(p_item: *Item) i32;
    pub const getId = gimp_item_get_id;

    /// Returns the item's image.
    ///
    /// This procedure returns the item's image.
    extern fn gimp_item_get_image(p_item: *Item) *gimp.Image;
    pub const getImage = gimp_item_get_image;

    /// Get the 'lock content' state of the specified item.
    ///
    /// This procedure returns the specified item's lock content state.
    extern fn gimp_item_get_lock_content(p_item: *Item) c_int;
    pub const getLockContent = gimp_item_get_lock_content;

    /// Get the 'lock position' state of the specified item.
    ///
    /// This procedure returns the specified item's lock position state.
    extern fn gimp_item_get_lock_position(p_item: *Item) c_int;
    pub const getLockPosition = gimp_item_get_lock_position;

    /// Get the 'lock visibility' state of the specified item.
    ///
    /// This procedure returns the specified item's lock visibility state.
    extern fn gimp_item_get_lock_visibility(p_item: *Item) c_int;
    pub const getLockVisibility = gimp_item_get_lock_visibility;

    /// Get the name of the specified item.
    ///
    /// This procedure returns the specified item's name.
    extern fn gimp_item_get_name(p_item: *Item) [*:0]u8;
    pub const getName = gimp_item_get_name;

    /// Look up a parasite in an item
    ///
    /// Finds and returns the parasite that is attached to an item.
    extern fn gimp_item_get_parasite(p_item: *Item, p_name: [*:0]const u8) *gimp.Parasite;
    pub const getParasite = gimp_item_get_parasite;

    /// List all parasites.
    ///
    /// Returns a list of all parasites currently attached the an item.
    extern fn gimp_item_get_parasite_list(p_item: *Item) [*][*:0]u8;
    pub const getParasiteList = gimp_item_get_parasite_list;

    /// Returns the item's parent item.
    ///
    /// This procedure returns the item's parent item, if any.
    extern fn gimp_item_get_parent(p_item: *Item) *gimp.Item;
    pub const getParent = gimp_item_get_parent;

    /// Get the tattoo of the specified item.
    ///
    /// This procedure returns the specified item's tattoo. A tattoo is a
    /// unique and permanent identifier attached to a item that can be used
    /// to uniquely identify a item within an image even between sessions.
    extern fn gimp_item_get_tattoo(p_item: *Item) c_uint;
    pub const getTattoo = gimp_item_get_tattoo;

    /// Get the visibility of the specified item.
    ///
    /// This procedure returns the specified item's visibility.
    extern fn gimp_item_get_visible(p_item: *Item) c_int;
    pub const getVisible = gimp_item_get_visible;

    /// Returns whether the item is a channel.
    ///
    /// This procedure returns TRUE if the specified item is a channel.
    extern fn gimp_item_is_channel(p_item: *Item) c_int;
    pub const isChannel = gimp_item_is_channel;

    /// Returns whether the item is a drawable.
    ///
    /// This procedure returns TRUE if the specified item is a drawable.
    extern fn gimp_item_is_drawable(p_item: *Item) c_int;
    pub const isDrawable = gimp_item_is_drawable;

    /// Returns whether the item is a group item.
    ///
    /// This procedure returns `TRUE` if the specified item is a group item
    /// which can have children.
    extern fn gimp_item_is_group(p_item: *Item) c_int;
    pub const isGroup = gimp_item_is_group;

    /// Returns whether the item is a group layer.
    ///
    /// This procedure returns TRUE if the specified item is a group
    /// layer.
    extern fn gimp_item_is_group_layer(p_item: *Item) c_int;
    pub const isGroupLayer = gimp_item_is_group_layer;

    /// Returns whether the item is a layer.
    ///
    /// This procedure returns TRUE if the specified item is a layer.
    extern fn gimp_item_is_layer(p_item: *Item) c_int;
    pub const isLayer = gimp_item_is_layer;

    /// Returns whether the item is a layer mask.
    ///
    /// This procedure returns TRUE if the specified item is a layer
    /// mask.
    extern fn gimp_item_is_layer_mask(p_item: *Item) c_int;
    pub const isLayerMask = gimp_item_is_layer_mask;

    /// Returns whether the item is a path.
    ///
    /// This procedure returns TRUE if the specified item is a path.
    extern fn gimp_item_is_path(p_item: *Item) c_int;
    pub const isPath = gimp_item_is_path;

    /// Returns whether the item is a selection.
    ///
    /// This procedure returns TRUE if the specified item is a selection.
    extern fn gimp_item_is_selection(p_item: *Item) c_int;
    pub const isSelection = gimp_item_is_selection;

    /// Returns whether the item is a text layer.
    ///
    /// This procedure returns TRUE if the specified item is a text
    /// layer.
    extern fn gimp_item_is_text_layer(p_item: *Item) c_int;
    pub const isTextLayer = gimp_item_is_text_layer;

    /// Returns TRUE if the item is valid.
    ///
    /// This procedure checks if the given item is valid and refers to an
    /// existing item.
    extern fn gimp_item_is_valid(p_item: *Item) c_int;
    pub const isValid = gimp_item_is_valid;

    /// Returns the item's list of children.
    ///
    /// This procedure returns the list of items which are children of the
    /// specified item. The order is topmost to bottommost.
    extern fn gimp_item_list_children(p_item: *Item) *glib.List;
    pub const listChildren = gimp_item_list_children;

    /// Set the color tag of the specified item.
    ///
    /// This procedure sets the specified item's color tag.
    extern fn gimp_item_set_color_tag(p_item: *Item, p_color_tag: gimp.ColorTag) c_int;
    pub const setColorTag = gimp_item_set_color_tag;

    /// Sets the expanded state of the item.
    ///
    /// This procedure expands or collapses the item.
    extern fn gimp_item_set_expanded(p_item: *Item, p_expanded: c_int) c_int;
    pub const setExpanded = gimp_item_set_expanded;

    /// Set the 'lock content' state of the specified item.
    ///
    /// This procedure sets the specified item's lock content state.
    extern fn gimp_item_set_lock_content(p_item: *Item, p_lock_content: c_int) c_int;
    pub const setLockContent = gimp_item_set_lock_content;

    /// Set the 'lock position' state of the specified item.
    ///
    /// This procedure sets the specified item's lock position state.
    extern fn gimp_item_set_lock_position(p_item: *Item, p_lock_position: c_int) c_int;
    pub const setLockPosition = gimp_item_set_lock_position;

    /// Set the 'lock visibility' state of the specified item.
    ///
    /// This procedure sets the specified item's lock visibility state.
    extern fn gimp_item_set_lock_visibility(p_item: *Item, p_lock_visibility: c_int) c_int;
    pub const setLockVisibility = gimp_item_set_lock_visibility;

    /// Set the name of the specified item.
    ///
    /// This procedure sets the specified item's name.
    extern fn gimp_item_set_name(p_item: *Item, p_name: [*:0]const u8) c_int;
    pub const setName = gimp_item_set_name;

    /// Set the tattoo of the specified item.
    ///
    /// This procedure sets the specified item's tattoo. A tattoo is a
    /// unique and permanent identifier attached to a item that can be used
    /// to uniquely identify a item within an image even between sessions.
    extern fn gimp_item_set_tattoo(p_item: *Item, p_tattoo: c_uint) c_int;
    pub const setTattoo = gimp_item_set_tattoo;

    /// Set the visibility of the specified item.
    ///
    /// This procedure sets the specified item's visibility.
    extern fn gimp_item_set_visible(p_item: *Item, p_visible: c_int) c_int;
    pub const setVisible = gimp_item_set_visible;

    /// Transform the specified item in 2d.
    ///
    /// This procedure transforms the specified item.
    ///
    /// The transformation is done by scaling by the x and y scale factors
    /// about the point (source_x, source_y), then rotating around the same
    /// point, then translating that point to the new position (dest_x,
    /// dest_y).
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then transformed as
    /// specified. The return value is the ID of the transformed floating
    /// selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be transformed according to the specified parameters.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_2d(p_item: *Item, p_source_x: f64, p_source_y: f64, p_scale_x: f64, p_scale_y: f64, p_angle: f64, p_dest_x: f64, p_dest_y: f64) *gimp.Item;
    pub const transform2d = gimp_item_transform_2d;

    /// Flip the specified item around a given line.
    ///
    /// This procedure flips the specified item.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then flipped. The axis to
    /// flip around is specified by specifying two points from that line.
    /// The return value is the ID of the flipped floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be flipped around the specified axis. The return value
    /// will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_flip(p_item: *Item, p_x0: f64, p_y0: f64, p_x1: f64, p_y1: f64) *gimp.Item;
    pub const transformFlip = gimp_item_transform_flip;

    /// Flip the specified item either vertically or horizontally.
    ///
    /// This procedure flips the specified item.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then flipped. If auto_center
    /// is set to TRUE, the flip is around the selection's center.
    /// Otherwise, the coordinate of the axis needs to be specified. The
    /// return value is the ID of the flipped floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be flipped around its center if auto_center is set to
    /// TRUE, otherwise the coordinate of the axis needs to be specified.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_flip_simple(p_item: *Item, p_flip_type: gimp.OrientationType, p_auto_center: c_int, p_axis: f64) *gimp.Item;
    pub const transformFlipSimple = gimp_item_transform_flip_simple;

    /// Transform the specified item in 2d.
    ///
    /// This procedure transforms the specified item.
    ///
    /// The transformation is done by assembling a 3x3 matrix from the
    /// coefficients passed.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then transformed as
    /// specified. The return value is the ID of the transformed floating
    /// selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be transformed according to the specified matrix.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_matrix(p_item: *Item, p_coeff_0_0: f64, p_coeff_0_1: f64, p_coeff_0_2: f64, p_coeff_1_0: f64, p_coeff_1_1: f64, p_coeff_1_2: f64, p_coeff_2_0: f64, p_coeff_2_1: f64, p_coeff_2_2: f64) *gimp.Item;
    pub const transformMatrix = gimp_item_transform_matrix;

    /// Perform a possibly non-affine transformation on the specified item.
    ///
    /// This procedure performs a possibly non-affine transformation on the
    /// specified item by allowing the corners of the original bounding box
    /// to be arbitrarily remapped to any values.
    ///
    /// The 4 coordinates specify the new locations of each corner of the
    /// original bounding box. By specifying these values, any affine
    /// transformation (rotation, scaling, translation) can be affected.
    /// Additionally, these values can be specified such that the resulting
    /// transformed item will appear to have been projected via a
    /// perspective transform.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then transformed as
    /// specified. The return value is the ID of the transformed floating
    /// selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be transformed according to the specified mapping.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_perspective(p_item: *Item, p_x0: f64, p_y0: f64, p_x1: f64, p_y1: f64, p_x2: f64, p_y2: f64, p_x3: f64, p_y3: f64) *gimp.Item;
    pub const transformPerspective = gimp_item_transform_perspective;

    /// Rotate the specified item about given coordinates through the
    /// specified angle.
    ///
    /// This function rotates the specified item.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then rotated by the
    /// specified amount. If auto_center is set to TRUE, the rotation is
    /// around the selection's center. Otherwise, the coordinate of the
    /// center point needs to be specified. The return value is the ID of
    /// the rotated floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be rotated around its center if auto_center is set to
    /// TRUE, otherwise the coordinate of the center point needs to be
    /// specified.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_rotate(p_item: *Item, p_angle: f64, p_auto_center: c_int, p_center_x: f64, p_center_y: f64) *gimp.Item;
    pub const transformRotate = gimp_item_transform_rotate;

    /// Rotate the specified item about given coordinates through the
    /// specified angle.
    ///
    /// This function rotates the specified item.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then rotated by the
    /// specified amount. If auto_center is set to TRUE, the rotation is
    /// around the selection's center. Otherwise, the coordinate of the
    /// center point needs to be specified. The return value is the ID of
    /// the rotated floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be rotated around its center if auto_center is set to
    /// TRUE, otherwise the coordinate of the center point needs to be
    /// specified.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_rotate_simple(p_item: *Item, p_rotate_type: gimp.RotationType, p_auto_center: c_int, p_center_x: f64, p_center_y: f64) *gimp.Item;
    pub const transformRotateSimple = gimp_item_transform_rotate_simple;

    /// Scale the specified item.
    ///
    /// This procedure scales the specified item.
    ///
    /// The 2 coordinates specify the new locations of the top-left and
    /// bottom-roght corners of the original bounding box.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then scaled as specified.
    /// The return value is the ID of the scaled floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be scaled according to the specified coordinates.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_scale(p_item: *Item, p_x0: f64, p_y0: f64, p_x1: f64, p_y1: f64) *gimp.Item;
    pub const transformScale = gimp_item_transform_scale;

    /// Shear the specified item about its center by the specified
    /// magnitude.
    ///
    /// This procedure shears the specified item.
    ///
    /// The shear type parameter indicates whether the shear will be applied
    /// horizontally or vertically. The magnitude can be either positive or
    /// negative and indicates the extent (in pixels) to shear by.
    ///
    /// If a selection exists and the item is a drawable, the portion of the
    /// drawable which lies under the selection is cut from the drawable and
    /// made into a floating selection which is then sheared as specified.
    /// The return value is the ID of the sheared floating selection.
    ///
    /// If there is no selection or the item is not a drawable, the entire
    /// item will be sheared according to the specified parameters.
    /// The return value will be equal to the item ID supplied as input.
    ///
    /// This procedure is affected by the following context setters:
    /// `gimp.contextSetInterpolation`,
    /// `gimp.contextSetTransformDirection`,
    /// `gimp.contextSetTransformResize`.
    extern fn gimp_item_transform_shear(p_item: *Item, p_shear_type: gimp.OrientationType, p_magnitude: f64) *gimp.Item;
    pub const transformShear = gimp_item_transform_shear;

    /// Translate the item by the specified offsets.
    ///
    /// This procedure translates the item by the amounts specified in the
    /// off_x and off_y arguments. These can be negative, and are considered
    /// offsets from the current position. The offsets will be rounded to
    /// the nearest pixel unless the item is a path.
    extern fn gimp_item_transform_translate(p_item: *Item, p_off_x: f64, p_off_y: f64) *gimp.Item;
    pub const transformTranslate = gimp_item_transform_translate;

    extern fn gimp_item_get_type() usize;
    pub const getGObjectType = gimp_item_get_type;

    extern fn g_object_ref(p_self: *gimp.Item) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Item) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Item, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Operations on a single layer.
pub const Layer = extern struct {
    pub const Parent = gimp.Drawable;
    pub const Implements = [_]type{};
    pub const Class = gimp.LayerClass;
    f_parent_instance: gimp.Drawable,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Get the specified mask's layer.
    ///
    /// This procedure returns the specified mask's layer , or -1 if none
    /// exists.
    extern fn gimp_layer_from_mask(p_mask: *gimp.LayerMask) *gimp.Layer;
    pub const fromMask = gimp_layer_from_mask;

    /// Returns a `gimp.Layer` representing `layer_id`. This function calls
    /// `gimp.Item.getById` and returns the item if it is layer or `NULL`
    /// otherwise.
    extern fn gimp_layer_get_by_id(p_layer_id: i32) ?*gimp.Layer;
    pub const getById = gimp_layer_get_by_id;

    /// Create a new layer.
    ///
    /// This procedure creates a new layer with the specified `width`,
    /// `height` and `type`. If `name` is `NULL`, a default layer name will be
    /// used. `opacity` and `mode` are also supplied parameters.
    ///
    /// The new layer still needs to be added to the image as this is not
    /// automatic. Add the new layer with the `Image.insertLayer`
    /// method.
    ///
    /// Other attributes such as layer mask modes and offsets should be set
    /// with explicit procedure calls.
    extern fn gimp_layer_new(p_image: *gimp.Image, p_name: ?[*:0]const u8, p_width: c_int, p_height: c_int, p_type: gimp.ImageType, p_opacity: f64, p_mode: gimp.LayerMode) *gimp.Layer;
    pub const new = gimp_layer_new;

    /// Create a new layer by copying an existing drawable.
    ///
    /// This procedure creates a new layer as a copy of the specified
    /// drawable. The new layer still needs to be added to the image, as
    /// this is not automatic. Add the new layer with the
    /// `gimp.Image.insertLayer` command. Other attributes such as layer
    /// mask modes, and offsets should be set with explicit procedure calls.
    extern fn gimp_layer_new_from_drawable(p_drawable: *gimp.Drawable, p_dest_image: *gimp.Image) *gimp.Layer;
    pub const newFromDrawable = gimp_layer_new_from_drawable;

    /// Create a new layer from a `gdkpixbuf.Pixbuf`.
    ///
    /// This procedure creates a new layer from the given `gdkpixbuf.Pixbuf`.  The
    /// image has to be an RGB image and just like with `gimp.Layer.new`
    /// you will still need to add the layer to it.
    ///
    /// If you pass `progress_end` > `progress_start` to this function,
    /// `gimp.progressUpdate` will be called for. You have to call
    /// `gimp.progressInit` beforehand then.
    extern fn gimp_layer_new_from_pixbuf(p_image: *gimp.Image, p_name: [*:0]const u8, p_pixbuf: *gdkpixbuf.Pixbuf, p_opacity: f64, p_mode: gimp.LayerMode, p_progress_start: f64, p_progress_end: f64) *gimp.Layer;
    pub const newFromPixbuf = gimp_layer_new_from_pixbuf;

    /// Create a new layer from a `cairo.Surface`.
    ///
    /// This procedure creates a new layer from the given
    /// `cairo.Surface`. The image has to be an RGB image and just like
    /// with `gimp.Layer.new` you will still need to add the layer to it.
    ///
    /// If you pass `progress_end` > `progress_start` to this function,
    /// `gimp.progressUpdate` will be called for. You have to call
    /// `gimp.progressInit` beforehand then.
    extern fn gimp_layer_new_from_surface(p_image: *gimp.Image, p_name: [*:0]const u8, p_surface: *cairo.Surface, p_progress_start: f64, p_progress_end: f64) *gimp.Layer;
    pub const newFromSurface = gimp_layer_new_from_surface;

    /// Create a new layer from what is visible in an image.
    ///
    /// This procedure creates a new layer from what is visible in the given
    /// image. The new layer still needs to be added to the destination
    /// image, as this is not automatic. Add the new layer with the
    /// `gimp.Image.insertLayer` command. Other attributes such as layer
    /// mask modes, and offsets should be set with explicit procedure calls.
    extern fn gimp_layer_new_from_visible(p_image: *gimp.Image, p_dest_image: *gimp.Image, p_name: ?[*:0]const u8) *gimp.Layer;
    pub const newFromVisible = gimp_layer_new_from_visible;

    /// Add an alpha channel to the layer if it doesn't already have one.
    ///
    /// This procedure adds an additional component to the specified layer
    /// if it does not already possess an alpha channel. An alpha channel
    /// makes it possible to clear and erase to transparency, instead of the
    /// background color. This transforms layers of type RGB to RGBA, GRAY
    /// to GRAYA, and INDEXED to INDEXEDA.
    extern fn gimp_layer_add_alpha(p_layer: *Layer) c_int;
    pub const addAlpha = gimp_layer_add_alpha;

    /// Add a layer mask to the specified layer.
    ///
    /// This procedure adds a layer mask to the specified layer. Layer masks
    /// serve as an additional alpha channel for a layer. This procedure
    /// will fail if a number of prerequisites aren't met. The layer cannot
    /// already have a layer mask. The specified mask must exist and have
    /// the same dimensions as the layer. The layer must have been created
    /// for use with the specified image and the mask must have been created
    /// with the procedure 'gimp-layer-create-mask'.
    extern fn gimp_layer_add_mask(p_layer: *Layer, p_mask: *gimp.LayerMask) c_int;
    pub const addMask = gimp_layer_add_mask;

    /// Copy a layer.
    ///
    /// This procedure copies the specified layer and returns the copy. The
    /// newly copied layer is for use within the original layer's image. It
    /// should not be subsequently added to any other image.
    extern fn gimp_layer_copy(p_layer: *Layer) *gimp.Layer;
    pub const copy = gimp_layer_copy;

    /// Create a layer mask for the specified layer.
    ///
    /// This procedure creates a layer mask for the specified layer.
    /// Layer masks serve as an additional alpha channel for a layer.
    /// Different types of masks are allowed for initialisation:
    /// - white mask (leaves the layer fully visible);
    /// - black mask (gives the layer complete transparency);
    /// - the layer's alpha channel (either a copy, or a transfer, which
    /// leaves the layer fully visible, but which may be more useful than a
    /// white mask);
    /// - the current selection;
    /// - a grayscale copy of the layer;
    /// - or a copy of the active channel.
    ///
    /// The layer mask still needs to be added to the layer. This can be
    /// done with a call to `gimp.Layer.addMask`.
    ///
    /// `gimp.Layer.createMask` will fail if there are no active channels
    /// on the image, when called with 'ADD-CHANNEL-MASK'. It will return a
    /// black mask when called with 'ADD-ALPHA-MASK' or
    /// 'ADD-ALPHA-TRANSFER-MASK' on a layer with no alpha channels, or with
    /// 'ADD-SELECTION-MASK' when there is no selection on the image.
    extern fn gimp_layer_create_mask(p_layer: *Layer, p_mask_type: gimp.AddMaskType) *gimp.LayerMask;
    pub const createMask = gimp_layer_create_mask;

    /// Remove the alpha channel from the layer if it has one.
    ///
    /// This procedure removes the alpha channel from a layer, blending all
    /// (partially) transparent pixels in the layer against the background
    /// color. This transforms layers of type RGBA to RGB, GRAYA to GRAY,
    /// and INDEXEDA to INDEXED.
    extern fn gimp_layer_flatten(p_layer: *Layer) c_int;
    pub const flatten = gimp_layer_flatten;

    /// Get the apply mask setting of the specified layer.
    ///
    /// This procedure returns the specified layer's apply mask setting. If
    /// the value is TRUE, then the layer mask for this layer is currently
    /// being composited with the layer's alpha channel.
    extern fn gimp_layer_get_apply_mask(p_layer: *Layer) c_int;
    pub const getApplyMask = gimp_layer_get_apply_mask;

    /// Get the blend space of the specified layer.
    ///
    /// This procedure returns the specified layer's blend space.
    extern fn gimp_layer_get_blend_space(p_layer: *Layer) gimp.LayerColorSpace;
    pub const getBlendSpace = gimp_layer_get_blend_space;

    /// Get the composite mode of the specified layer.
    ///
    /// This procedure returns the specified layer's composite mode.
    extern fn gimp_layer_get_composite_mode(p_layer: *Layer) gimp.LayerCompositeMode;
    pub const getCompositeMode = gimp_layer_get_composite_mode;

    /// Get the composite space of the specified layer.
    ///
    /// This procedure returns the specified layer's composite space.
    extern fn gimp_layer_get_composite_space(p_layer: *Layer) gimp.LayerColorSpace;
    pub const getCompositeSpace = gimp_layer_get_composite_space;

    /// Get the edit mask setting of the specified layer.
    ///
    /// This procedure returns the specified layer's edit mask setting. If
    /// the value is TRUE, then the layer mask for this layer is currently
    /// active, and not the layer.
    extern fn gimp_layer_get_edit_mask(p_layer: *Layer) c_int;
    pub const getEditMask = gimp_layer_get_edit_mask;

    /// Get the lock alpha channel setting of the specified layer.
    ///
    /// This procedure returns the specified layer's lock alpha channel
    /// setting.
    extern fn gimp_layer_get_lock_alpha(p_layer: *Layer) c_int;
    pub const getLockAlpha = gimp_layer_get_lock_alpha;

    /// Get the specified layer's mask if it exists.
    ///
    /// This procedure returns the specified layer's mask, or -1 if none
    /// exists.
    extern fn gimp_layer_get_mask(p_layer: *Layer) *gimp.LayerMask;
    pub const getMask = gimp_layer_get_mask;

    /// Get the combination mode of the specified layer.
    ///
    /// This procedure returns the specified layer's combination mode.
    extern fn gimp_layer_get_mode(p_layer: *Layer) gimp.LayerMode;
    pub const getMode = gimp_layer_get_mode;

    /// Get the opacity of the specified layer.
    ///
    /// This procedure returns the specified layer's opacity.
    extern fn gimp_layer_get_opacity(p_layer: *Layer) f64;
    pub const getOpacity = gimp_layer_get_opacity;

    /// Get the show mask setting of the specified layer.
    ///
    /// This procedure returns the specified layer's show mask setting. This
    /// controls whether the layer or its mask is visible. TRUE indicates
    /// that the mask should be visible. If the layer has no mask, then this
    /// function returns an error.
    extern fn gimp_layer_get_show_mask(p_layer: *Layer) c_int;
    pub const getShowMask = gimp_layer_get_show_mask;

    /// Is the specified layer a floating selection?
    ///
    /// This procedure returns whether the layer is a floating selection.
    /// Floating selections are special cases of layers which are attached
    /// to a specific drawable.
    extern fn gimp_layer_is_floating_sel(p_layer: *Layer) c_int;
    pub const isFloatingSel = gimp_layer_is_floating_sel;

    /// Remove the specified layer mask from the layer.
    ///
    /// This procedure removes the specified layer mask from the layer. If
    /// the mask doesn't exist, an error is returned.
    extern fn gimp_layer_remove_mask(p_layer: *Layer, p_mode: gimp.MaskApplyMode) c_int;
    pub const removeMask = gimp_layer_remove_mask;

    /// Resize the layer to the specified extents.
    ///
    /// This procedure resizes the layer so that its new width and height
    /// are equal to the supplied parameters. Offsets are also provided
    /// which describe the position of the previous layer's content. This
    /// operation only works if the layer has been added to an image.
    extern fn gimp_layer_resize(p_layer: *Layer, p_new_width: c_int, p_new_height: c_int, p_offx: c_int, p_offy: c_int) c_int;
    pub const resize = gimp_layer_resize;

    /// Resize a layer to the image size.
    ///
    /// This procedure resizes the layer so that it's new width and height
    /// are equal to the width and height of its image container.
    extern fn gimp_layer_resize_to_image_size(p_layer: *Layer) c_int;
    pub const resizeToImageSize = gimp_layer_resize_to_image_size;

    /// Scale the layer using the default interpolation method.
    ///
    /// This procedure scales the layer so that its new width and height are
    /// equal to the supplied parameters. The 'local-origin' parameter
    /// specifies whether to scale from the center of the layer, or from the
    /// image origin. This operation only works if the layer has been added
    /// to an image. The interpolation method used can be set with
    /// `gimp.contextSetInterpolation`.
    extern fn gimp_layer_scale(p_layer: *Layer, p_new_width: c_int, p_new_height: c_int, p_local_origin: c_int) c_int;
    pub const scale = gimp_layer_scale;

    /// Set the apply mask setting of the specified layer.
    ///
    /// This procedure sets the specified layer's apply mask setting. This
    /// controls whether the layer's mask is currently affecting the alpha
    /// channel. If there is no layer mask, this function will return an
    /// error.
    extern fn gimp_layer_set_apply_mask(p_layer: *Layer, p_apply_mask: c_int) c_int;
    pub const setApplyMask = gimp_layer_set_apply_mask;

    /// Set the blend space of the specified layer.
    ///
    /// This procedure sets the specified layer's blend space.
    extern fn gimp_layer_set_blend_space(p_layer: *Layer, p_blend_space: gimp.LayerColorSpace) c_int;
    pub const setBlendSpace = gimp_layer_set_blend_space;

    /// Set the composite mode of the specified layer.
    ///
    /// This procedure sets the specified layer's composite mode.
    extern fn gimp_layer_set_composite_mode(p_layer: *Layer, p_composite_mode: gimp.LayerCompositeMode) c_int;
    pub const setCompositeMode = gimp_layer_set_composite_mode;

    /// Set the composite space of the specified layer.
    ///
    /// This procedure sets the specified layer's composite space.
    extern fn gimp_layer_set_composite_space(p_layer: *Layer, p_composite_space: gimp.LayerColorSpace) c_int;
    pub const setCompositeSpace = gimp_layer_set_composite_space;

    /// Set the edit mask setting of the specified layer.
    ///
    /// This procedure sets the specified layer's edit mask setting. This
    /// controls whether the layer or it's mask is currently active for
    /// editing. If the specified layer has no layer mask, then this
    /// procedure will return an error.
    extern fn gimp_layer_set_edit_mask(p_layer: *Layer, p_edit_mask: c_int) c_int;
    pub const setEditMask = gimp_layer_set_edit_mask;

    /// Set the lock alpha channel setting of the specified layer.
    ///
    /// This procedure sets the specified layer's lock alpha channel
    /// setting.
    extern fn gimp_layer_set_lock_alpha(p_layer: *Layer, p_lock_alpha: c_int) c_int;
    pub const setLockAlpha = gimp_layer_set_lock_alpha;

    /// Set the combination mode of the specified layer.
    ///
    /// This procedure sets the specified layer's combination mode.
    extern fn gimp_layer_set_mode(p_layer: *Layer, p_mode: gimp.LayerMode) c_int;
    pub const setMode = gimp_layer_set_mode;

    /// Set the layer offsets.
    ///
    /// This procedure sets the offsets for the specified layer. The offsets
    /// are relative to the image origin and can be any values. This
    /// operation is valid only on layers which have been added to an image.
    extern fn gimp_layer_set_offsets(p_layer: *Layer, p_offx: c_int, p_offy: c_int) c_int;
    pub const setOffsets = gimp_layer_set_offsets;

    /// Set the opacity of the specified layer.
    ///
    /// This procedure sets the specified layer's opacity.
    extern fn gimp_layer_set_opacity(p_layer: *Layer, p_opacity: f64) c_int;
    pub const setOpacity = gimp_layer_set_opacity;

    /// Set the show mask setting of the specified layer.
    ///
    /// This procedure sets the specified layer's show mask setting. This
    /// controls whether the layer or its mask is visible. TRUE indicates
    /// that the mask should be visible. If there is no layer mask, this
    /// function will return an error.
    extern fn gimp_layer_set_show_mask(p_layer: *Layer, p_show_mask: c_int) c_int;
    pub const setShowMask = gimp_layer_set_show_mask;

    extern fn gimp_layer_get_type() usize;
    pub const getGObjectType = gimp_layer_get_type;

    extern fn g_object_ref(p_self: *gimp.Layer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Layer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Layer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayerMask = opaque {
    pub const Parent = gimp.Channel;
    pub const Implements = [_]type{};
    pub const Class = gimp.LayerMaskClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `gimp.LayerMask` representing `layer_mask_id`. This function
    /// calls `gimp.Item.getById` and returns the item if it is
    /// layer_mask or `NULL` otherwise.
    extern fn gimp_layer_mask_get_by_id(p_layer_mask_id: i32) ?*gimp.LayerMask;
    pub const getById = gimp_layer_mask_get_by_id;

    extern fn gimp_layer_mask_get_type() usize;
    pub const getGObjectType = gimp_layer_mask_get_type;

    extern fn g_object_ref(p_self: *gimp.LayerMask) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.LayerMask) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LayerMask, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `Procedure` subclass that makes it easier to write file load
/// procedures.
///
/// It automatically adds the standard
///
/// ( `RunMode`, `gio.File` )
///
/// arguments and the standard
///
/// ( `Image` )
///
/// return value of a load procedure. It is possible to add additional
/// arguments.
///
/// When invoked via `Procedure.run`, it unpacks these standard
/// arguments and calls `run_func` which is a `RunImageFunc`. The
/// "args" `ValueArray` of `RunImageFunc` only contains
/// additionally added arguments.
pub const LoadProcedure = extern struct {
    pub const Parent = gimp.FileProcedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.LoadProcedureClass;
    f_parent_instance: gimp.FileProcedure,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new load procedure named `name` which will call `run_func`
    /// when invoked.
    ///
    /// See `gimp.Procedure.new` for information about `proc_type`.
    extern fn gimp_load_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_run_func: gimp.RunLoadFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.LoadProcedure;
    pub const new = gimp_load_procedure_new;

    /// Returns the procedure's 'handles raw' flag as set with
    /// `GimpLoadProcedure.setHandlesRaw`.
    extern fn gimp_load_procedure_get_handles_raw(p_procedure: *LoadProcedure) c_int;
    pub const getHandlesRaw = gimp_load_procedure_get_handles_raw;

    /// Returns the procedure's thumbnail loader procedure as set with
    /// `GimpLoadProcedure.setThumbnailLoader`.
    extern fn gimp_load_procedure_get_thumbnail_loader(p_procedure: *LoadProcedure) [*:0]const u8;
    pub const getThumbnailLoader = gimp_load_procedure_get_thumbnail_loader;

    /// Registers a load procedure as capable of handling raw digital camera loads.
    ///
    /// Note that you cannot call this function on `VectorLoadProcedure`
    /// subclass objects.
    extern fn gimp_load_procedure_set_handles_raw(p_procedure: *LoadProcedure, p_handles_raw: c_int) void;
    pub const setHandlesRaw = gimp_load_procedure_set_handles_raw;

    /// Associates a thumbnail loader with a file load procedure.
    ///
    /// Some file formats allow for embedded thumbnails, other file formats
    /// contain a scalable image or provide the image data in different
    /// resolutions. A file plug-in for such a format may register a
    /// special procedure that allows GIMP to load a thumbnail preview of
    /// the image. This procedure is then associated with the standard
    /// load procedure using this function.
    extern fn gimp_load_procedure_set_thumbnail_loader(p_procedure: *LoadProcedure, p_thumbnail_proc: [*:0]const u8) void;
    pub const setThumbnailLoader = gimp_load_procedure_set_thumbnail_loader;

    extern fn gimp_load_procedure_get_type() usize;
    pub const getGObjectType = gimp_load_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.LoadProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.LoadProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LoadProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions to (de)serialize a given memory size.
pub const Memsize = opaque {
    pub const Parent = gobject.TypeInstance;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Memsize;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Parses a string representation of a memory size as returned by
    /// `gimp.Memsize.serialize`.
    extern fn gimp_memsize_deserialize(p_string: [*:0]const u8, p_memsize: *u64) c_int;
    pub const deserialize = gimp_memsize_deserialize;

    /// Creates a string representation of a given memory size. This string
    /// can be parsed by `gimp.Memsize.deserialize` and can thus be used in
    /// config files. It should not be displayed to the user. If you need a
    /// nice human-readable string please use `glib.formatSize`.
    extern fn gimp_memsize_serialize(p_memsize: u64) [*:0]u8;
    pub const serialize = gimp_memsize_serialize;

    extern fn gimp_memsize_get_type() usize;
    pub const getGObjectType = gimp_memsize_get_type;

    pub fn as(p_instance: *Memsize, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Basic functions for handling `gimp.Metadata` objects.
pub const Metadata = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.MetadataClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Deserializes a string of XML that has been created by
    /// `gimp.Metadata.serialize`.
    extern fn gimp_metadata_deserialize(p_metadata_xml: [*:0]const u8) *gimp.Metadata;
    pub const deserialize = gimp_metadata_deserialize;

    /// Generate Version 4 UUID/GUID.
    extern fn gimp_metadata_get_guid() [*:0]u8;
    pub const getGuid = gimp_metadata_get_guid;

    /// Returns whether `tag` is supported in a file of type `mime_type`.
    extern fn gimp_metadata_is_tag_supported(p_tag: [*:0]const u8, p_mime_type: [*:0]const u8) c_int;
    pub const isTagSupported = gimp_metadata_is_tag_supported;

    /// Loads `gimp.Metadata` from `file`.
    extern fn gimp_metadata_load_from_file(p_file: *gio.File, p_error: ?*?*glib.Error) ?*gimp.Metadata;
    pub const loadFromFile = gimp_metadata_load_from_file;

    /// Creates a new `gimp.Metadata` instance.
    extern fn gimp_metadata_new() *gimp.Metadata;
    pub const new = gimp_metadata_new;

    extern fn gimp_metadata_add_xmp_history(p_metadata: *Metadata, p_state_status: [*:0]u8) void;
    pub const addXmpHistory = gimp_metadata_add_xmp_history;

    /// Duplicates a `gimp.Metadata` instance.
    extern fn gimp_metadata_duplicate(p_metadata: *Metadata) *gimp.Metadata;
    pub const duplicate = gimp_metadata_duplicate;

    /// Returns values based on Exif.Photo.ColorSpace, Xmp.exif.ColorSpace,
    /// Exif.Iop.InteroperabilityIndex, Exif.Nikon3.ColorSpace,
    /// Exif.Canon.ColorSpace of `metadata`.
    extern fn gimp_metadata_get_colorspace(p_metadata: *Metadata) gimp.MetadataColorspace;
    pub const getColorspace = gimp_metadata_get_colorspace;

    /// Returns values based on Exif.Image.XResolution,
    /// Exif.Image.YResolution and Exif.Image.ResolutionUnit of `metadata`.
    extern fn gimp_metadata_get_resolution(p_metadata: *Metadata, p_xres: ?*f64, p_yres: ?*f64, p_unit: ?**gimp.Unit) c_int;
    pub const getResolution = gimp_metadata_get_resolution;

    /// Saves `metadata` to `file`.
    extern fn gimp_metadata_save_to_file(p_metadata: *Metadata, p_file: *gio.File, p_error: ?*?*glib.Error) c_int;
    pub const saveToFile = gimp_metadata_save_to_file;

    /// Serializes `metadata` into an XML string that can later be deserialized
    /// using `gimp.Metadata.deserialize`.
    extern fn gimp_metadata_serialize(p_metadata: *Metadata) [*:0]u8;
    pub const serialize = gimp_metadata_serialize;

    /// Sets Exif.Image.BitsPerSample on `metadata`.
    extern fn gimp_metadata_set_bits_per_sample(p_metadata: *Metadata, p_bits_per_sample: c_int) void;
    pub const setBitsPerSample = gimp_metadata_set_bits_per_sample;

    /// Sets Exif.Photo.ColorSpace, Xmp.exif.ColorSpace,
    /// Exif.Iop.InteroperabilityIndex, Exif.Nikon3.ColorSpace,
    /// Exif.Canon.ColorSpace of `metadata`.
    extern fn gimp_metadata_set_colorspace(p_metadata: *Metadata, p_colorspace: gimp.MetadataColorspace) void;
    pub const setColorspace = gimp_metadata_set_colorspace;

    /// Sets `Iptc.Application2.DateCreated`, `Iptc.Application2.TimeCreated`,
    /// `Exif.Image.DateTime`, `Exif.Image.DateTimeOriginal`,
    /// `Exif.Photo.DateTimeOriginal`, `Exif.Photo.DateTimeDigitized`,
    /// `Exif.Photo.OffsetTime`, `Exif.Photo.OffsetTimeOriginal`,
    /// `Exif.Photo.OffsetTimeDigitized`, `Xmp.xmp.CreateDate`, `Xmp.xmp.ModifyDate`,
    /// `Xmp.xmp.MetadataDate`, `Xmp.photoshop.DateCreated` of `metadata`.
    extern fn gimp_metadata_set_creation_date(p_metadata: *Metadata, p_datetime: *glib.DateTime) void;
    pub const setCreationDate = gimp_metadata_set_creation_date;

    /// Sets the tags from a piece of Exif data on `metadata`.
    extern fn gimp_metadata_set_from_exif(p_metadata: *Metadata, p_exif_data: [*]const u8, p_exif_data_length: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setFromExif = gimp_metadata_set_from_exif;

    /// Sets the tags from a piece of IPTC data on `metadata`.
    extern fn gimp_metadata_set_from_iptc(p_metadata: *Metadata, p_iptc_data: [*]const u8, p_iptc_data_length: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setFromIptc = gimp_metadata_set_from_iptc;

    /// Sets the tags from a piece of XMP data on `metadata`.
    extern fn gimp_metadata_set_from_xmp(p_metadata: *Metadata, p_xmp_data: [*]const u8, p_xmp_data_length: c_int, p_error: ?*?*glib.Error) c_int;
    pub const setFromXmp = gimp_metadata_set_from_xmp;

    /// Sets Exif.Image.ImageWidth and Exif.Image.ImageLength on `metadata`.
    /// If already present, also sets Exif.Photo.PixelXDimension and
    /// Exif.Photo.PixelYDimension.
    extern fn gimp_metadata_set_pixel_size(p_metadata: *Metadata, p_width: c_int, p_height: c_int) void;
    pub const setPixelSize = gimp_metadata_set_pixel_size;

    /// Sets Exif.Image.XResolution, Exif.Image.YResolution and
    /// Exif.Image.ResolutionUnit of `metadata`.
    extern fn gimp_metadata_set_resolution(p_metadata: *Metadata, p_xres: f64, p_yres: f64, p_unit: *gimp.Unit) void;
    pub const setResolution = gimp_metadata_set_resolution;

    extern fn gimp_metadata_get_type() usize;
    pub const getGObjectType = gimp_metadata_get_type;

    extern fn g_object_ref(p_self: *gimp.Metadata) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Metadata) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Metadata, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimp.Module` is a generic mechanism to dynamically load modules into
/// GIMP. It is a `gobject.TypeModule` subclass, implementing module loading
/// using `gmodule.Module`.  `gimp.Module` does not know which functionality is
/// implemented by the modules, it just provides a framework to get
/// arbitrary `gobject.Type` implementations loaded from disk.
pub const Module = extern struct {
    pub const Parent = gobject.TypeModule;
    pub const Implements = [_]type{gobject.TypePlugin};
    pub const Class = gimp.ModuleClass;
    f_parent_instance: gobject.TypeModule,

    pub const virtual_methods = struct {
        pub const modified = struct {
            pub fn call(p_class: anytype, p_module: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Module.Class, p_class).f_modified.?(gobject.ext.as(Module, p_module));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_module: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Module.Class, p_class).f_modified = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const auto_load = struct {
            pub const name = "auto-load";

            pub const Type = c_int;
        };

        pub const on_disk = struct {
            pub const name = "on-disk";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// This function is never called directly. Use `GIMP_MODULE_ERROR` instead.
    extern fn gimp_module_error_quark() glib.Quark;
    pub const errorQuark = gimp_module_error_quark;

    extern fn gimp_module_query(p_module: *gobject.TypeModule) *const gimp.ModuleInfo;
    pub const query = gimp_module_query;

    extern fn gimp_module_register(p_module: *gobject.TypeModule) c_int;
    pub const register = gimp_module_register;

    /// Creates a new `gimp.Module` instance.
    extern fn gimp_module_new(p_file: *gio.File, p_auto_load: c_int, p_verbose: c_int) *gimp.Module;
    pub const new = gimp_module_new;

    /// Returns whether this `module` in automatically loaded at startup.
    extern fn gimp_module_get_auto_load(p_module: *Module) c_int;
    pub const getAutoLoad = gimp_module_get_auto_load;

    /// Returns `gio.File` of the `module`,
    extern fn gimp_module_get_file(p_module: *Module) *gio.File;
    pub const getFile = gimp_module_get_file;

    extern fn gimp_module_get_info(p_module: *Module) *const gimp.ModuleInfo;
    pub const getInfo = gimp_module_get_info;

    extern fn gimp_module_get_last_error(p_module: *Module) [*:0]const u8;
    pub const getLastError = gimp_module_get_last_error;

    extern fn gimp_module_get_state(p_module: *Module) gimp.ModuleState;
    pub const getState = gimp_module_get_state;

    extern fn gimp_module_is_loaded(p_module: *Module) c_int;
    pub const isLoaded = gimp_module_is_loaded;

    extern fn gimp_module_is_on_disk(p_module: *Module) c_int;
    pub const isOnDisk = gimp_module_is_on_disk;

    /// Queries the module without actually registering any of the types it
    /// may implement. After successful query, `gimp.Module.getInfo` can be
    /// used to get further about the module.
    extern fn gimp_module_query_module(p_module: *Module) c_int;
    pub const queryModule = gimp_module_query_module;

    /// Sets the `auto_load` property of the module
    extern fn gimp_module_set_auto_load(p_module: *Module, p_auto_load: c_int) void;
    pub const setAutoLoad = gimp_module_set_auto_load;

    extern fn gimp_module_get_type() usize;
    pub const getGObjectType = gimp_module_get_type;

    extern fn g_object_ref(p_self: *gimp.Module) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Module) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Module, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Keeps a list of `gimp.Module`'s found in a given searchpath.
pub const ModuleDB = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = gimp.ModuleDBClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimp.ModuleDB` instance. The `verbose` parameter will be
    /// passed to the created `gimp.Module` instances using `gimp.Module.new`.
    extern fn gimp_module_db_new(p_verbose: c_int) *gimp.ModuleDB;
    pub const new = gimp_module_db_new;

    /// Return the `G_SEARCHPATH_SEPARATOR` delimited list of module filenames
    /// which are excluded from auto-loading.
    extern fn gimp_module_db_get_load_inhibit(p_db: *ModuleDB) [*:0]const u8;
    pub const getLoadInhibit = gimp_module_db_get_load_inhibit;

    /// Returns the 'verbose' setting of `db`.
    extern fn gimp_module_db_get_verbose(p_db: *ModuleDB) c_int;
    pub const getVerbose = gimp_module_db_get_verbose;

    /// Scans the directories contained in `module_path` and creates a
    /// `gimp.Module` instance for every loadable module contained in the
    /// directories.
    extern fn gimp_module_db_load(p_db: *ModuleDB, p_module_path: [*:0]const u8) void;
    pub const load = gimp_module_db_load;

    /// Does the same as `gimp.ModuleDB.load`, plus removes all `gimp.Module`
    /// instances whose modules have been deleted from disk.
    ///
    /// Note that the `gimp.Module`'s will just be removed from the internal
    /// list and not freed as this is not possible with `gobject.TypeModule`
    /// instances which actually implement types.
    extern fn gimp_module_db_refresh(p_db: *ModuleDB, p_module_path: [*:0]const u8) void;
    pub const refresh = gimp_module_db_refresh;

    /// Sets the `load_inhibit` flag for all `gimp.Module`'s which are kept
    /// by `db` (using `gimp_module_set_load_inhibit`).
    extern fn gimp_module_db_set_load_inhibit(p_db: *ModuleDB, p_load_inhibit: [*:0]const u8) void;
    pub const setLoadInhibit = gimp_module_db_set_load_inhibit;

    /// Sets the 'verbose' setting of `db`.
    extern fn gimp_module_db_set_verbose(p_db: *ModuleDB, p_verbose: c_int) void;
    pub const setVerbose = gimp_module_db_set_verbose;

    extern fn gimp_module_db_get_type() usize;
    pub const getGObjectType = gimp_module_db_get_type;

    extern fn g_object_ref(p_self: *gimp.ModuleDB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ModuleDB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ModuleDB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Provides access to the Procedural DataBase (PDB).
pub const PDB = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.PDBClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Dumps the current contents of the procedural database
    ///
    /// This procedure dumps the contents of the procedural database to the
    /// specified `file`. The file will contain all of the information
    /// provided for each registered procedure.
    extern fn gimp_pdb_dump_to_file(p_pdb: *PDB, p_file: *gio.File) c_int;
    pub const dumpToFile = gimp_pdb_dump_to_file;

    /// Retrieves the error message from the last procedure call.
    ///
    /// If a procedure call fails, then it might pass an error message with
    /// the return values. Plug-ins that are using the libgimp C wrappers
    /// don't access the procedure return values directly. Thus `gimp.PDB`
    /// stores the error message and makes it available with this
    /// function. The next procedure call unsets the error message again.
    ///
    /// The returned string is owned by `pdb` and must not be freed or
    /// modified.
    extern fn gimp_pdb_get_last_error(p_pdb: *PDB) [*:0]const u8;
    pub const getLastError = gimp_pdb_get_last_error;

    /// Retrieves the status from the last procedure call.
    extern fn gimp_pdb_get_last_status(p_pdb: *PDB) gimp.PDBStatusType;
    pub const getLastStatus = gimp_pdb_get_last_status;

    /// This function returns the `Procedure` which is registered
    /// with `procedure_name` if it exists, or returns `NULL` otherwise.
    ///
    /// The returned `Procedure` is owned by `pdb` and must not be modified.
    extern fn gimp_pdb_lookup_procedure(p_pdb: *PDB, p_procedure_name: [*:0]const u8) ?*gimp.Procedure;
    pub const lookupProcedure = gimp_pdb_lookup_procedure;

    /// This function checks if a procedure exists in the procedural
    /// database.
    extern fn gimp_pdb_procedure_exists(p_pdb: *PDB, p_procedure_name: [*:0]const u8) c_int;
    pub const procedureExists = gimp_pdb_procedure_exists;

    /// Queries the procedural database for its contents using regular
    /// expression matching.
    ///
    /// This function queries the contents of the procedural database. It
    /// is supplied with eight arguments matching procedures on
    ///
    /// { name, blurb, help, help-id, authors, copyright, date, procedure type}.
    ///
    /// This is accomplished using regular expression matching. For
    /// instance, to find all procedures with "jpeg" listed in the blurb,
    /// all seven arguments can be supplied as ".*", except for the second,
    /// which can be supplied as ".*jpeg.*". There are two return arguments
    /// for this procedure. The first is the number of procedures matching
    /// the query. The second is a concatenated list of procedure names
    /// corresponding to those matching the query. If no matching entries
    /// are found, then the returned string is NULL and the number of
    /// entries is 0.
    extern fn gimp_pdb_query_procedures(p_pdb: *PDB, p_name: [*:0]const u8, p_blurb: [*:0]const u8, p_help: [*:0]const u8, p_help_id: [*:0]const u8, p_authors: [*:0]const u8, p_copyright: [*:0]const u8, p_date: [*:0]const u8, p_proc_type: [*:0]const u8) [*][*:0]u8;
    pub const queryProcedures = gimp_pdb_query_procedures;

    /// Generates a unique temporary PDB name.
    ///
    /// This function generates a temporary PDB entry name that is
    /// guaranteed to be unique.
    extern fn gimp_pdb_temp_procedure_name(p_pdb: *PDB) [*:0]u8;
    pub const tempProcedureName = gimp_pdb_temp_procedure_name;

    extern fn gimp_pdb_get_type() usize;
    pub const getGObjectType = gimp_pdb_get_type;

    extern fn g_object_ref(p_self: *gimp.PDB) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.PDB) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PDB, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Installable object, a small set of colors a user can choose from.
pub const Palette = opaque {
    pub const Parent = gimp.Resource;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.PaletteClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the palette with the given name.
    ///
    /// Returns an existing palette having the given name. Returns `NULL`
    /// when no palette exists of that name.
    extern fn gimp_palette_get_by_name(p_name: [*:0]const u8) ?*gimp.Palette;
    pub const getByName = gimp_palette_get_by_name;

    /// Creates a new palette
    ///
    /// Creates a new palette. The new palette has no color entries. You
    /// must add color entries for a user to choose. The actual name might
    /// be different than the requested name, when the requested name is
    /// already in use.
    extern fn gimp_palette_new(p_name: [*:0]const u8) *gimp.Palette;
    pub const new = gimp_palette_new;

    /// Appends an entry to the palette.
    ///
    /// Appends an entry to the palette. Neither color nor name must be
    /// unique within the palette. When name is the empty string, this sets
    /// the entry name to \"Untitled\". Returns the index of the entry.
    /// Returns an error when palette is not editable.
    extern fn gimp_palette_add_entry(p_palette: *Palette, p_entry_name: ?[*:0]const u8, p_color: *gegl.Color, p_entry_num: *c_int) c_int;
    pub const addEntry = gimp_palette_add_entry;

    /// Deletes an entry from the palette.
    ///
    /// This function will fail and return `FALSE` if the index is out or
    /// range or if the palette is not editable.
    /// Additionally if the palette belongs to an indexed image, it will
    /// only be possible to delete palette colors not in use in the image.
    extern fn gimp_palette_delete_entry(p_palette: *Palette, p_entry_num: c_int) c_int;
    pub const deleteEntry = gimp_palette_delete_entry;

    /// Get the count of colors in the palette.
    ///
    /// Returns the number of colors in the palette.
    extern fn gimp_palette_get_color_count(p_palette: *Palette) c_int;
    pub const getColorCount = gimp_palette_get_color_count;

    /// This procedure returns a palette's colormap as an array of bytes with
    /// all colors converted to a given Babl `format`.
    ///
    /// The byte-size of the returned colormap depends on the number of
    /// colors and on the bytes-per-pixel size of `format`. E.g. that the
    /// following equality is ensured:
    ///
    /// ```C
    /// num_bytes == num_colors * babl_format_get_bytes_per_pixel (format)
    /// ```
    ///
    /// Therefore `num_colors` and `num_bytes` are kinda redundant since both
    /// indicate the size of the return value in a different way. You may
    /// both set them to `NULL` but not at the same time.
    extern fn gimp_palette_get_colormap(p_palette: *Palette, p_format: *const babl.Object, p_num_colors: ?*c_int, p_num_bytes: ?*usize) [*]u8;
    pub const getColormap = gimp_palette_get_colormap;

    /// Gets colors in the palette.
    ///
    /// Returns an array of colors in the palette. Free the returned array
    /// with `gimp.colorArrayFree`.
    extern fn gimp_palette_get_colors(p_palette: *Palette) [*]*gegl.Color;
    pub const getColors = gimp_palette_get_colors;

    /// Gets the number of columns used to display the palette
    ///
    /// Gets the preferred number of columns to display the palette.
    extern fn gimp_palette_get_columns(p_palette: *Palette) c_int;
    pub const getColumns = gimp_palette_get_columns;

    /// Gets the color of an entry in the palette.
    ///
    /// Returns the color of the entry at the given zero-based index into
    /// the palette. Returns `NULL` when the index is out of range.
    extern fn gimp_palette_get_entry_color(p_palette: *Palette, p_entry_num: c_int) *gegl.Color;
    pub const getEntryColor = gimp_palette_get_entry_color;

    /// Gets the name of an entry in the palette.
    ///
    /// Gets the name of the entry at the zero-based index into the palette.
    /// Returns an error when the index is out of range.
    extern fn gimp_palette_get_entry_name(p_palette: *Palette, p_entry_num: c_int, p_entry_name: *[*:0]u8) c_int;
    pub const getEntryName = gimp_palette_get_entry_name;

    /// This procedure sets the entries in the specified palette in one go,
    /// though they must all be in the same `format`.
    ///
    /// The number of entries depens on the `num_bytes` size of `colormap` and
    /// the bytes-per-pixel size of `format`.
    /// The procedure will fail if `num_bytes` is not an exact multiple of the
    /// number of bytes per pixel of `format`.
    extern fn gimp_palette_set_colormap(p_palette: *Palette, p_format: *const babl.Object, p_colormap: *u8, p_num_bytes: usize) c_int;
    pub const setColormap = gimp_palette_set_colormap;

    /// Sets the number of columns used to display the palette
    ///
    /// Set the number of colors shown per row when the palette is
    /// displayed. Returns an error when the palette is not editable. The
    /// maximum allowed value is 64.
    extern fn gimp_palette_set_columns(p_palette: *Palette, p_columns: c_int) c_int;
    pub const setColumns = gimp_palette_set_columns;

    /// Sets the color of an entry in the palette.
    ///
    /// Sets the color of the entry at the zero-based index into the
    /// palette. Returns an error when the index is out of range. Returns an
    /// error when the palette is not editable.
    extern fn gimp_palette_set_entry_color(p_palette: *Palette, p_entry_num: c_int, p_color: *gegl.Color) c_int;
    pub const setEntryColor = gimp_palette_set_entry_color;

    /// Sets the name of an entry in the palette.
    ///
    /// Sets the name of the entry at the zero-based index into the palette.
    /// Returns an error if the index is out or range. Returns an error if
    /// the palette is not editable.
    extern fn gimp_palette_set_entry_name(p_palette: *Palette, p_entry_num: c_int, p_entry_name: ?[*:0]const u8) c_int;
    pub const setEntryName = gimp_palette_set_entry_name;

    extern fn gimp_palette_get_type() usize;
    pub const getGObjectType = gimp_palette_get_type;

    extern fn g_object_ref(p_self: *gimp.Palette) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Palette) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Palette, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamArray = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamArray;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_array_get_type() usize;
    pub const getGObjectType = gimp_param_array_get_type;

    pub fn as(p_instance: *ParamArray, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamBrush = opaque {
    pub const Parent = gimp.ParamResource;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamBrush;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_brush_get_type() usize;
    pub const getGObjectType = gimp_param_brush_get_type;

    pub fn as(p_instance: *ParamBrush, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamChannel = opaque {
    pub const Parent = gimp.ParamDrawable;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamChannel;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_channel_get_type() usize;
    pub const getGObjectType = gimp_param_channel_get_type;

    pub fn as(p_instance: *ParamChannel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamChoice = opaque {
    pub const Parent = gobject.ParamSpecString;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamChoice;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_choice_get_type() usize;
    pub const getGObjectType = gimp_param_choice_get_type;

    pub fn as(p_instance: *ParamChoice, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamColor = opaque {
    pub const Parent = gimp.ParamObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamColor;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_color_get_type() usize;
    pub const getGObjectType = gimp_param_color_get_type;

    pub fn as(p_instance: *ParamColor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamConfigPath = opaque {
    pub const Parent = gobject.ParamSpecString;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamConfigPath;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_config_path_get_type() usize;
    pub const getGObjectType = gimp_param_config_path_get_type;

    pub fn as(p_instance: *ParamConfigPath, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamCoreObjectArray = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamCoreObjectArray;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_core_object_array_get_type() usize;
    pub const getGObjectType = gimp_param_core_object_array_get_type;

    pub fn as(p_instance: *ParamCoreObjectArray, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamDisplay = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamDisplay;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_display_get_type() usize;
    pub const getGObjectType = gimp_param_display_get_type;

    pub fn as(p_instance: *ParamDisplay, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamDoubleArray = opaque {
    pub const Parent = gimp.ParamArray;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamDoubleArray;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_double_array_get_type() usize;
    pub const getGObjectType = gimp_param_double_array_get_type;

    pub fn as(p_instance: *ParamDoubleArray, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamDrawable = opaque {
    pub const Parent = gimp.ParamItem;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamDrawable;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_drawable_get_type() usize;
    pub const getGObjectType = gimp_param_drawable_get_type;

    pub fn as(p_instance: *ParamDrawable, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamDrawableFilter = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamDrawableFilter;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_drawable_filter_get_type() usize;
    pub const getGObjectType = gimp_param_drawable_filter_get_type;

    pub fn as(p_instance: *ParamDrawableFilter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamExportOptions = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamExportOptions;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_export_options_get_type() usize;
    pub const getGObjectType = gimp_param_export_options_get_type;

    pub fn as(p_instance: *ParamExportOptions, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamFile = opaque {
    pub const Parent = gimp.ParamObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamFile;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_file_get_type() usize;
    pub const getGObjectType = gimp_param_file_get_type;

    pub fn as(p_instance: *ParamFile, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamFont = opaque {
    pub const Parent = gimp.ParamResource;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamFont;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_font_get_type() usize;
    pub const getGObjectType = gimp_param_font_get_type;

    pub fn as(p_instance: *ParamFont, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamGradient = opaque {
    pub const Parent = gimp.ParamResource;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamGradient;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_gradient_get_type() usize;
    pub const getGObjectType = gimp_param_gradient_get_type;

    pub fn as(p_instance: *ParamGradient, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamGroupLayer = opaque {
    pub const Parent = gimp.ParamLayer;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamGroupLayer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_group_layer_get_type() usize;
    pub const getGObjectType = gimp_param_group_layer_get_type;

    pub fn as(p_instance: *ParamGroupLayer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamImage = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamImage;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_image_get_type() usize;
    pub const getGObjectType = gimp_param_image_get_type;

    pub fn as(p_instance: *ParamImage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamInt32Array = opaque {
    pub const Parent = gimp.ParamArray;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamInt32Array;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_int32_array_get_type() usize;
    pub const getGObjectType = gimp_param_int32_array_get_type;

    pub fn as(p_instance: *ParamInt32Array, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamItem = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamItem;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_item_get_type() usize;
    pub const getGObjectType = gimp_param_item_get_type;

    pub fn as(p_instance: *ParamItem, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamLayer = opaque {
    pub const Parent = gimp.ParamDrawable;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamLayer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_layer_get_type() usize;
    pub const getGObjectType = gimp_param_layer_get_type;

    pub fn as(p_instance: *ParamLayer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamLayerMask = opaque {
    pub const Parent = gimp.ParamChannel;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamLayerMask;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_layer_mask_get_type() usize;
    pub const getGObjectType = gimp_param_layer_mask_get_type;

    pub fn as(p_instance: *ParamLayerMask, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamMatrix2 = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamMatrix2;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_matrix2_get_type() usize;
    pub const getGObjectType = gimp_param_matrix2_get_type;

    pub fn as(p_instance: *ParamMatrix2, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamMatrix3 = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamMatrix3;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_matrix3_get_type() usize;
    pub const getGObjectType = gimp_param_matrix3_get_type;

    pub fn as(p_instance: *ParamMatrix3, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamMemsize = opaque {
    pub const Parent = gobject.ParamSpecUInt64;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamMemsize;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_memsize_get_type() usize;
    pub const getGObjectType = gimp_param_memsize_get_type;

    pub fn as(p_instance: *ParamMemsize, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamObject = opaque {
    pub const Parent = gobject.ParamSpecObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamObject;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_object_get_type() usize;
    pub const getGObjectType = gimp_param_object_get_type;

    pub fn as(p_instance: *ParamObject, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamPalette = opaque {
    pub const Parent = gimp.ParamResource;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamPalette;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_palette_get_type() usize;
    pub const getGObjectType = gimp_param_palette_get_type;

    pub fn as(p_instance: *ParamPalette, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamParasite = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamParasite;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_parasite_get_type() usize;
    pub const getGObjectType = gimp_param_parasite_get_type;

    pub fn as(p_instance: *ParamParasite, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamPath = opaque {
    pub const Parent = gimp.ParamItem;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamPath;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_path_get_type() usize;
    pub const getGObjectType = gimp_param_path_get_type;

    pub fn as(p_instance: *ParamPath, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamPattern = opaque {
    pub const Parent = gimp.ParamResource;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamPattern;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_pattern_get_type() usize;
    pub const getGObjectType = gimp_param_pattern_get_type;

    pub fn as(p_instance: *ParamPattern, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamResource = opaque {
    pub const Parent = gimp.ParamObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamResource;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_resource_get_type() usize;
    pub const getGObjectType = gimp_param_resource_get_type;

    pub fn as(p_instance: *ParamResource, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSelection = opaque {
    pub const Parent = gimp.ParamChannel;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamSelection;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_selection_get_type() usize;
    pub const getGObjectType = gimp_param_selection_get_type;

    pub fn as(p_instance: *ParamSelection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamTextLayer = opaque {
    pub const Parent = gimp.ParamLayer;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamTextLayer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_text_layer_get_type() usize;
    pub const getGObjectType = gimp_param_text_layer_get_type;

    pub fn as(p_instance: *ParamTextLayer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamUnit = opaque {
    pub const Parent = gimp.ParamObject;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamUnit;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_unit_get_type() usize;
    pub const getGObjectType = gimp_param_unit_get_type;

    pub fn as(p_instance: *ParamUnit, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamValueArray = opaque {
    pub const Parent = gobject.ParamSpecBoxed;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamValueArray;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_param_value_array_get_type() usize;
    pub const getGObjectType = gimp_param_value_array_get_type;

    pub fn as(p_instance: *ParamValueArray, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions for querying and manipulating path.
pub const Path = opaque {
    pub const Parent = gimp.Item;
    pub const Implements = [_]type{};
    pub const Class = gimp.PathClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function frees the memory allocated for the list and the strings
    /// it contains.
    extern fn gimp_path_free(p_path: *glib.List) void;
    pub const free = gimp_path_free;

    /// Returns a `gimp.Path` representing `path_id`. This function
    /// calls `gimp.Item.getById` and returns the item if it is a path
    /// or `NULL` otherwise.
    extern fn gimp_path_get_by_id(p_path_id: i32) ?*gimp.Path;
    pub const getById = gimp_path_get_by_id;

    /// Note that you have to `glib.free` the returned string.
    extern fn gimp_path_get_user_writable_dir(p_path: *glib.List) [*:0]u8;
    pub const getUserWritableDir = gimp_path_get_user_writable_dir;

    extern fn gimp_path_parse(p_path: [*:0]const u8, p_max_paths: c_int, p_check: c_int, p_check_failed: **glib.List) *glib.List;
    pub const parse = gimp_path_parse;

    extern fn gimp_path_to_str(p_path: *glib.List) [*:0]u8;
    pub const toStr = gimp_path_to_str;

    /// Creates a new empty path object.
    ///
    /// Creates a new empty path object. The path object needs to be added
    /// to the image using `gimp.Image.insertPath`.
    extern fn gimp_path_new(p_image: *gimp.Image, p_name: [*:0]const u8) *gimp.Path;
    pub const new = gimp_path_new;

    /// Creates a new path object from a text layer.
    ///
    /// Creates a new path object from a text layer. The path object needs
    /// to be added to the image using `gimp.Image.insertPath`.
    extern fn gimp_path_new_from_text_layer(p_image: *gimp.Image, p_layer: *gimp.Layer) *gimp.Path;
    pub const newFromTextLayer = gimp_path_new_from_text_layer;

    /// Extends a bezier stroke with a conic bezier spline.
    ///
    /// Extends a bezier stroke with a conic bezier spline. Actually a cubic
    /// bezier spline gets added that realizes the shape of a conic bezier
    /// spline.
    extern fn gimp_path_bezier_stroke_conicto(p_path: *Path, p_stroke_id: c_int, p_x0: f64, p_y0: f64, p_x1: f64, p_y1: f64) c_int;
    pub const bezierStrokeConicto = gimp_path_bezier_stroke_conicto;

    /// Extends a bezier stroke with a cubic bezier spline.
    ///
    /// Extends a bezier stroke with a cubic bezier spline.
    extern fn gimp_path_bezier_stroke_cubicto(p_path: *Path, p_stroke_id: c_int, p_x0: f64, p_y0: f64, p_x1: f64, p_y1: f64, p_x2: f64, p_y2: f64) c_int;
    pub const bezierStrokeCubicto = gimp_path_bezier_stroke_cubicto;

    /// Extends a bezier stroke with a lineto.
    ///
    /// Extends a bezier stroke with a lineto.
    extern fn gimp_path_bezier_stroke_lineto(p_path: *Path, p_stroke_id: c_int, p_x0: f64, p_y0: f64) c_int;
    pub const bezierStrokeLineto = gimp_path_bezier_stroke_lineto;

    /// Adds a bezier stroke describing an ellipse the path object.
    ///
    /// Adds a bezier stroke describing an ellipse on the path object.
    extern fn gimp_path_bezier_stroke_new_ellipse(p_path: *Path, p_x0: f64, p_y0: f64, p_radius_x: f64, p_radius_y: f64, p_angle: f64) c_int;
    pub const bezierStrokeNewEllipse = gimp_path_bezier_stroke_new_ellipse;

    /// Adds a bezier stroke with a single moveto to the path object.
    ///
    /// Adds a bezier stroke with a single moveto to the path object.
    extern fn gimp_path_bezier_stroke_new_moveto(p_path: *Path, p_x0: f64, p_y0: f64) c_int;
    pub const bezierStrokeNewMoveto = gimp_path_bezier_stroke_new_moveto;

    /// Copy a path object.
    ///
    /// This procedure copies the specified path object and returns the
    /// copy.
    extern fn gimp_path_copy(p_path: *Path) *gimp.Path;
    pub const copy = gimp_path_copy;

    /// List the strokes associated with the passed path.
    ///
    /// Returns an Array with the stroke-IDs associated with the passed
    /// path.
    extern fn gimp_path_get_strokes(p_path: *Path, p_num_strokes: *usize) [*]c_int;
    pub const getStrokes = gimp_path_get_strokes;

    /// remove the stroke from a path object.
    ///
    /// Remove the stroke from a path object.
    extern fn gimp_path_remove_stroke(p_path: *Path, p_stroke_id: c_int) c_int;
    pub const removeStroke = gimp_path_remove_stroke;

    /// closes the specified stroke.
    ///
    /// Closes the specified stroke.
    extern fn gimp_path_stroke_close(p_path: *Path, p_stroke_id: c_int) c_int;
    pub const strokeClose = gimp_path_stroke_close;

    /// flips the given stroke.
    ///
    /// Rotates the given stroke around given center by angle (in degrees).
    extern fn gimp_path_stroke_flip(p_path: *Path, p_stroke_id: c_int, p_flip_type: gimp.OrientationType, p_axis: f64) c_int;
    pub const strokeFlip = gimp_path_stroke_flip;

    /// flips the given stroke about an arbitrary axis.
    ///
    /// Flips the given stroke about an arbitrary axis. Axis is defined by
    /// two coordinates in the image (in pixels), through which the flipping
    /// axis passes.
    extern fn gimp_path_stroke_flip_free(p_path: *Path, p_stroke_id: c_int, p_x1: f64, p_y1: f64, p_x2: f64, p_y2: f64) c_int;
    pub const strokeFlipFree = gimp_path_stroke_flip_free;

    /// Measure the length of the given stroke.
    ///
    /// Measure the length of the given stroke.
    extern fn gimp_path_stroke_get_length(p_path: *Path, p_stroke_id: c_int, p_precision: f64) f64;
    pub const strokeGetLength = gimp_path_stroke_get_length;

    /// Get point at a specified distance along the stroke.
    ///
    /// This will return the x,y position of a point at a given distance
    /// along the stroke. The distance will be obtained by first digitizing
    /// the curve internally and then walking along the curve. For a closed
    /// stroke the start of the path is the first point on the path that was
    /// created. This might not be obvious. If the stroke is not long
    /// enough, a \"valid\" flag will be FALSE.
    extern fn gimp_path_stroke_get_point_at_dist(p_path: *Path, p_stroke_id: c_int, p_dist: f64, p_precision: f64, p_x_point: *f64, p_y_point: *f64, p_slope: *f64, p_valid: *c_int) c_int;
    pub const strokeGetPointAtDist = gimp_path_stroke_get_point_at_dist;

    /// returns the control points of a stroke.
    ///
    /// returns the control points of a stroke. The interpretation of the
    /// coordinates returned depends on the type of the stroke. For Gimp 2.4
    /// this is always a bezier stroke, where the coordinates are the
    /// control points.
    extern fn gimp_path_stroke_get_points(p_path: *Path, p_stroke_id: c_int, p_num_points: *usize, p_controlpoints: *[*]f64, p_closed: *c_int) gimp.PathStrokeType;
    pub const strokeGetPoints = gimp_path_stroke_get_points;

    /// returns polygonal approximation of the stroke.
    ///
    /// returns polygonal approximation of the stroke.
    extern fn gimp_path_stroke_interpolate(p_path: *Path, p_stroke_id: c_int, p_precision: f64, p_num_coords: *usize, p_closed: *c_int) [*]f64;
    pub const strokeInterpolate = gimp_path_stroke_interpolate;

    /// Adds a stroke of a given type to the path object.
    ///
    /// Adds a stroke of a given type to the path object. The coordinates of
    /// the control points can be specified. For now only strokes of the
    /// type GIMP_PATH_STROKE_TYPE_BEZIER are supported. The control points
    /// are specified as a pair of double values for the x- and
    /// y-coordinate. The Bezier stroke type needs a multiple of three
    /// control points. Each Bezier segment endpoint (anchor, A) has two
    /// additional control points (C) associated. They are specified in the
    /// order CACCACCAC...
    extern fn gimp_path_stroke_new_from_points(p_path: *Path, p_type: gimp.PathStrokeType, p_num_points: usize, p_controlpoints: [*]const f64, p_closed: c_int) c_int;
    pub const strokeNewFromPoints = gimp_path_stroke_new_from_points;

    /// reverses the specified stroke.
    ///
    /// Reverses the specified stroke.
    extern fn gimp_path_stroke_reverse(p_path: *Path, p_stroke_id: c_int) c_int;
    pub const strokeReverse = gimp_path_stroke_reverse;

    /// rotates the given stroke.
    ///
    /// Rotates the given stroke around given center by angle (in degrees).
    extern fn gimp_path_stroke_rotate(p_path: *Path, p_stroke_id: c_int, p_center_x: f64, p_center_y: f64, p_angle: f64) c_int;
    pub const strokeRotate = gimp_path_stroke_rotate;

    /// scales the given stroke.
    ///
    /// Scale the given stroke.
    extern fn gimp_path_stroke_scale(p_path: *Path, p_stroke_id: c_int, p_scale_x: f64, p_scale_y: f64) c_int;
    pub const strokeScale = gimp_path_stroke_scale;

    /// translate the given stroke.
    ///
    /// Translate the given stroke.
    extern fn gimp_path_stroke_translate(p_path: *Path, p_stroke_id: c_int, p_off_x: f64, p_off_y: f64) c_int;
    pub const strokeTranslate = gimp_path_stroke_translate;

    extern fn gimp_path_get_type() usize;
    pub const getGObjectType = gimp_path_get_type;

    extern fn g_object_ref(p_self: *gimp.Path) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Path) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Path, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Installable object used by fill and clone tools.
pub const Pattern = opaque {
    pub const Parent = gimp.Resource;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.PatternClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the pattern with the given name.
    ///
    /// Returns an existing pattern having the given name. Returns `NULL`
    /// when no pattern exists of that name.
    extern fn gimp_pattern_get_by_name(p_name: [*:0]const u8) ?*gimp.Pattern;
    pub const getByName = gimp_pattern_get_by_name;

    /// Gets pixel data of the pattern within the bounding box specified by `max_width`
    /// and `max_height`. The data will be scaled down so that it fits within this
    /// size without changing its ratio. If the pattern is smaller than this size to
    /// begin with, it will not be scaled up.
    ///
    /// If `max_width` or `max_height` are `NULL`, the buffer is returned in the pattern's
    /// native size.
    ///
    /// Make sure you called `gegl.init` before calling any function using
    /// `GEGL`.
    extern fn gimp_pattern_get_buffer(p_pattern: *Pattern, p_max_width: c_int, p_max_height: c_int, p_format: *const babl.Object) *gegl.Buffer;
    pub const getBuffer = gimp_pattern_get_buffer;

    /// Gets information about the pattern.
    ///
    /// Gets information about the pattern: the pattern extents (width and
    /// height) and bytes per pixel.
    extern fn gimp_pattern_get_info(p_pattern: *Pattern, p_width: *c_int, p_height: *c_int, p_bpp: *c_int) c_int;
    pub const getInfo = gimp_pattern_get_info;

    extern fn gimp_pattern_get_type() usize;
    pub const getGObjectType = gimp_pattern_get_type;

    extern fn g_object_ref(p_self: *gimp.Pattern) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Pattern) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Pattern, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The base class for plug-ins to derive from.
///
/// GimpPlugIn manages the plug-in's `Procedure` objects. The procedures a
/// plug-in implements are registered with GIMP by returning a list of their
/// names from either `GimpPlugIn.virtual_methods.query_procedures` or
/// `GimpPlugIn.virtual_methods.init_procedures`.
///
/// Every GIMP plug-in has to be implemented as a subclass and make it known to
/// the libgimp infrastructure and the main GIMP application by passing its
/// `GType` to `MAIN`.
///
/// `MAIN` passes the 'argc' and 'argv' of the platform's `main` function,
/// along with the `GType`, to `main`, which creates an instance of the
/// plug-in's `GimpPlugIn` subclass and calls its virtual functions, depending
/// on how the plug-in was called by GIMP.
///
/// There are 3 different ways GIMP calls a plug-in: "query", "init" and "run".
///
/// The plug-in is called in "query" mode once after it was installed, or when
/// the cached plug-in information in the config file "pluginrc" needs to be
/// recreated. In "query" mode, `GimpPlugIn.virtual_methods.query_procedures` is called
/// and returns a list of procedure names the plug-in implements. This is the
/// "normal" place to register procedures, because the existence of most
/// procedures doesn't depend on things that change between GIMP sessions.
///
/// The plug-in is called in "init" mode at each GIMP startup, and
/// `PlugIn.virtual_methods.init_procedures` is called and returns a list of procedure
/// names this plug-in implements. This only happens if the plug-in actually
/// implements `GimpPlugIn.virtual_methods.init_procedures`. A plug-in only needs to
/// implement init_procedures if the existence of its procedures can change
/// between GIMP sessions, for example if they depend on the presence of
/// external tools, or hardware like scanners, or online services, or whatever
/// variable circumstances.
///
/// In order to register the plug-in's procedures with the main GIMP application
/// in the plug-in's "query" and "init" modes, `PlugIn` calls
/// `PlugIn.virtual_methods.create_procedure` on all procedure names in the exact order of
/// the list returned by `PlugIn.virtual_methods.query_procedures` or
/// `PlugIn.virtual_methods.init_procedures` and then registers the returned
/// `Procedure`.
///
/// The plug-in is called in "run" mode whenever one of the procedures it
/// implements is called by either the main GIMP application or any other
/// plug-in. In "run" mode, one of the procedure names returned by
/// `PlugIn.virtual_methods.query_procedures` or `PlugIn.virtual_methods.init_procedures` is passed
/// to `PlugIn.virtual_methods.create_procedure` which must return a `Procedure` for
/// the passed name. The procedure is then executed by calling
/// `Procedure.run`.
///
/// In any of the three modes, `PlugIn.virtual_methods.quit` is called before the plug-in
/// process exits, so the plug-in can perform whatever cleanup necessary.
pub const PlugIn = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.PlugInClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// This method must be overridden by all plug-ins and return a newly
        /// allocated `gimp.Procedure` named `name`.
        ///
        /// This method will be called for every `name` as returned by
        /// `PlugIn.virtual_methods.query_procedures` and `PlugIn.virtual_methods.init_procedures` so care
        /// must be taken to handle them all.  Upon procedure registration,
        /// `PlugIn.virtual_methods.create_procedure` will be called in the order of the lists
        /// returned by `PlugIn.virtual_methods.query_procedures` and
        /// `PlugIn.virtual_methods.init_procedures`
        pub const create_procedure = struct {
            pub fn call(p_class: anytype, p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure_name: [*:0]const u8) *gimp.Procedure {
                return gobject.ext.as(PlugIn.Class, p_class).f_create_procedure.?(gobject.ext.as(PlugIn, p_plug_in), p_procedure_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure_name: [*:0]const u8) callconv(.c) *gimp.Procedure) void {
                gobject.ext.as(PlugIn.Class, p_class).f_create_procedure = @ptrCast(p_implementation);
            }
        };

        /// This method can be overridden by all plug-ins to return a newly allocated
        /// list of allocated strings naming procedures registered by this plug-in.
        /// It is different from `PlugIn.virtual_methods.query_procedures` in that init happens
        /// at every startup, whereas query happens only once in the life of a plug-in
        /// (right after installation or update). Hence `PlugIn.virtual_methods.init_procedures`
        /// typically returns procedures dependent to runtime conditions (such as the
        /// presence of a third-party tool), whereas `PlugIn.virtual_methods.query_procedures`
        /// would usually return procedures that are always available unconditionally.
        ///
        /// Most of the time, you only want to override
        /// `PlugIn.virtual_methods.query_procedures` and leave `PlugIn.virtual_methods.init_procedures`
        /// untouched.
        pub const init_procedures = struct {
            pub fn call(p_class: anytype, p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.List {
                return gobject.ext.as(PlugIn.Class, p_class).f_init_procedures.?(gobject.ext.as(PlugIn, p_plug_in));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.List) void {
                gobject.ext.as(PlugIn.Class, p_class).f_init_procedures = @ptrCast(p_implementation);
            }
        };

        /// This method can be overridden by all plug-ins to return a newly allocated
        /// list of allocated strings naming the procedures registered by this
        /// plug-in. See documentation of `PlugIn.virtual_methods.init_procedures` for
        /// differences.
        pub const query_procedures = struct {
            pub fn call(p_class: anytype, p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.List {
                return gobject.ext.as(PlugIn.Class, p_class).f_query_procedures.?(gobject.ext.as(PlugIn, p_plug_in));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.List) void {
                gobject.ext.as(PlugIn.Class, p_class).f_query_procedures = @ptrCast(p_implementation);
            }
        };

        /// This method can be overridden by a plug-in which needs to perform some
        /// actions upon quitting.
        pub const quit = struct {
            pub fn call(p_class: anytype, p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(PlugIn.Class, p_class).f_quit.?(gobject.ext.as(PlugIn, p_plug_in));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(PlugIn.Class, p_class).f_quit = @ptrCast(p_implementation);
            }
        };

        /// This method can be overridden by all plug-ins to customize
        /// internationalization of the plug-in.
        ///
        /// This method will be called before initializing, querying or running
        /// `procedure_name` (respectively with `PlugIn.virtual_methods.init_procedures`,
        /// `PlugIn.virtual_methods.query_procedures` or with the ``run`` function set in
        /// ``gimp.ImageProcedure.new``).
        ///
        /// By default, GIMP plug-ins look up gettext compiled message catalogs
        /// in the subdirectory `locale/` under the plug-in folder (same folder
        /// as ``gimp.getProgname``) with a text domain equal to the plug-in
        /// name (regardless `procedure_name`). It is unneeded to override this
        /// method if you follow this localization scheme.
        ///
        /// If you wish to disable localization or localize with another system,
        /// simply set the method to `NULL`, or possibly implement this method
        /// to do something useful for your usage while returning `FALSE`.
        ///
        /// If you wish to tweak the `gettext_domain` or the `catalog_dir`, return
        /// `TRUE` and allocate appropriate `gettext_domain` and/or `catalog_dir`
        /// (these use the default if set `NULL`).
        ///
        /// Note that `catalog_dir` must be a relative path, encoded as UTF-8,
        /// subdirectory of the directory of ``gimp.getProgname``.
        /// The domain names "gimp30-std-plug-ins", "gimp30-script-fu" and
        /// "gimp30-python" are reserved and can only be used with a `NULL`
        /// `catalog_dir`. These will use the translation catalogs installed for
        /// core plug-ins, so you are not expected to use these for your
        /// plug-ins, except if you are making a core plug-in. More domain
        /// names may become reserved so we discourage using a gettext domain
        /// starting with "gimp30-".
        ///
        /// When localizing your plug-in this way, GIMP also binds
        /// `gettext_domain` to the UTF-8 encoding.
        pub const set_i18n = struct {
            pub fn call(p_class: anytype, p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure_name: [*:0]const u8, p_gettext_domain: ?*[*:0]u8, p_catalog_dir: ?*[*:0]u8) c_int {
                return gobject.ext.as(PlugIn.Class, p_class).f_set_i18n.?(gobject.ext.as(PlugIn, p_plug_in), p_procedure_name, p_gettext_domain, p_catalog_dir);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_plug_in: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure_name: [*:0]const u8, p_gettext_domain: ?*[*:0]u8, p_catalog_dir: ?*[*:0]u8) callconv(.c) c_int) void {
                gobject.ext.as(PlugIn.Class, p_class).f_set_i18n = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The program name as usually found on argv[0]
        pub const program_name = struct {
            pub const name = "program-name";

            pub const Type = ?[*:0]u8;
        };

        /// The `glib.IOChannel` to read from GIMP
        pub const read_channel = struct {
            pub const name = "read-channel";

            pub const Type = ?*glib.IOChannel;
        };

        /// The `glib.IOChannel` to write to GIMP
        pub const write_channel = struct {
            pub const name = "write-channel";

            pub const Type = ?*glib.IOChannel;
        };
    };

    pub const signals = struct {};

    /// Returns the default top directory for GIMP plug-ins and modules. If
    /// the environment variable GIMP3_PLUGINDIR exists, that is used.  It
    /// should be an absolute pathname. Otherwise, on Unix the compile-time
    /// defined directory is used. On Windows, the installation directory
    /// as deduced from the executable's full filename is used.
    ///
    /// Note that the actual directories used for GIMP plug-ins and modules
    /// can be overridden by the user in the preferences dialog.
    ///
    /// In config files such as gimprc, the string ${gimp_plug_in_dir}
    /// expands to this directory.
    ///
    /// The returned string is owned by GIMP and must not be modified or
    /// freed. The returned string is in the encoding used for filenames by
    /// GLib, which isn't necessarily UTF-8. (On Windows it always is
    /// UTF-8.)
    extern fn gimp_plug_in_directory() [*:0]const u8;
    pub const directory = gimp_plug_in_directory;

    /// Returns a `gio.File` in the plug-in directory, or the plug-in directory
    /// itself if `first_element` is `NULL`.
    ///
    /// See also: `gimp.PlugIn.directory`.
    extern fn gimp_plug_in_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
    pub const directoryFile = gimp_plug_in_directory_file;

    /// Generic `glib.Quark` error domain for plug-ins. Plug-ins are welcome to
    /// create their own domain when they want to handle advanced error
    /// handling. Often, you just want to pass an error message to the core.
    /// This domain can be used for such simple usage.
    ///
    /// See `glib.Error` for information on error domains.
    extern fn gimp_plug_in_error_quark() glib.Quark;
    pub const errorQuark = gimp_plug_in_error_quark;

    /// Add a new sub-menu to the GIMP menus.
    ///
    /// This function installs a sub-menu which does not belong to any
    /// procedure at the location `menu_path`.
    ///
    /// For translations of `menu_label` to work properly, `menu_label`
    /// should only be marked for translation but passed to this function
    /// untranslated, for example using N_("Submenu"). GIMP will look up
    /// the translation in the textdomain registered for the plug-in.
    ///
    /// See also: `gimp.Procedure.addMenuPath`.
    extern fn gimp_plug_in_add_menu_branch(p_plug_in: *PlugIn, p_menu_path: [*:0]const u8, p_menu_label: [*:0]const u8) void;
    pub const addMenuBranch = gimp_plug_in_add_menu_branch;

    /// This function adds a temporary procedure to `plug_in`. It is usually
    /// called from a `GIMP_PDB_PROC_TYPE_PERSISTENT` procedure's
    /// `Procedure.virtual_methods.run`.
    ///
    /// A temporary procedure is a procedure which is only available while
    /// one of your plug-in's "real" procedures is running.
    ///
    /// The procedure's type _must_ be
    /// `GIMP_PDB_PROC_TYPE_TEMPORARY` or the function will fail.
    ///
    /// NOTE: Normally, plug-in communication is triggered by the plug-in
    /// and the GIMP core only responds to the plug-in's requests. You must
    /// explicitly enable receiving of temporary procedure run requests
    /// using either `PlugIn.persistentEnable` or
    /// `PlugIn.persistentProcess`. See their respective
    /// documentation for details.
    extern fn gimp_plug_in_add_temp_procedure(p_plug_in: *PlugIn, p_procedure: *gimp.Procedure) void;
    pub const addTempProcedure = gimp_plug_in_add_temp_procedure;

    /// Retrieves the active error handler for procedure calls.
    ///
    /// This procedure retrieves the currently active error handler for
    /// procedure calls made by the calling plug-in. See
    /// `gimp_plugin_set_pdb_error_handler` for details.
    extern fn gimp_plug_in_get_pdb_error_handler(p_plug_in: *PlugIn) gimp.PDBErrorHandler;
    pub const getPdbErrorHandler = gimp_plug_in_get_pdb_error_handler;

    /// This function retrieves a temporary procedure from `plug_in` by the
    /// procedure's `procedure_name`.
    extern fn gimp_plug_in_get_temp_procedure(p_plug_in: *PlugIn, p_procedure_name: [*:0]const u8) ?*gimp.Procedure;
    pub const getTempProcedure = gimp_plug_in_get_temp_procedure;

    /// This function retrieves the list of temporary procedure of `plug_in` as
    /// added with `PlugIn.addTempProcedure`.
    extern fn gimp_plug_in_get_temp_procedures(p_plug_in: *PlugIn) *glib.List;
    pub const getTempProcedures = gimp_plug_in_get_temp_procedures;

    /// Enables asynchronous processing of messages from the main GIMP
    /// application.
    ///
    /// Normally, a plug-in is not called by GIMP except for the call to
    /// the procedure it implements. All subsequent communication is
    /// triggered by the plug-in and all messages sent from GIMP to the
    /// plug-in are just answers to requests the plug-in made.
    ///
    /// If the plug-in however registered temporary procedures using
    /// `PlugIn.addTempProcedure`, it needs to be able to receive
    /// requests to execute them. Usually this will be done by running
    /// `PlugIn.persistentProcess` in an endless loop.
    ///
    /// If the plug-in cannot use `PlugIn.persistentProcess`, i.e. if
    /// it has a GUI and is hanging around in a `glib.MainLoop`, it
    /// must call `PlugIn.persistentEnable`.
    ///
    /// Note that the plug-in does not need to be a
    /// `gimp.@"PDBProcType.PERSISTENT"` to register temporary procedures.
    ///
    /// See also: `PlugIn.addTempProcedure`.
    extern fn gimp_plug_in_persistent_enable(p_plug_in: *PlugIn) void;
    pub const persistentEnable = gimp_plug_in_persistent_enable;

    /// Processes one message sent by GIMP and returns.
    ///
    /// Call this function in an endless loop after calling
    /// `gimp.Procedure.persistentReady` to process requests for
    /// running temporary procedures.
    ///
    /// See `PlugIn.persistentEnable` for an asynchronous way of
    /// doing the same if running an endless loop is not an option.
    ///
    /// See also: `PlugIn.addTempProcedure`.
    extern fn gimp_plug_in_persistent_process(p_plug_in: *PlugIn, p_timeout: c_uint) void;
    pub const persistentProcess = gimp_plug_in_persistent_process;

    /// This function removes a temporary procedure from `plug_in` by the
    /// procedure's `procedure_name`.
    extern fn gimp_plug_in_remove_temp_procedure(p_plug_in: *PlugIn, p_procedure_name: [*:0]const u8) void;
    pub const removeTempProcedure = gimp_plug_in_remove_temp_procedure;

    /// Set a help domain and path for the `plug_in`.
    ///
    /// This function registers user documentation for the calling plug-in
    /// with the GIMP help system. The `domain_uri` parameter points to the
    /// root directory where the plug-in help is installed. For each
    /// supported language there should be a file called 'gimp-help.xml'
    /// that maps the help IDs to the actual help files.
    ///
    /// This function can only be called in the
    /// `PlugIn.virtual_methods.query_procedures` function of a plug-in.
    extern fn gimp_plug_in_set_help_domain(p_plug_in: *PlugIn, p_domain_name: [*:0]const u8, p_domain_uri: *gio.File) void;
    pub const setHelpDomain = gimp_plug_in_set_help_domain;

    /// Sets an error handler for procedure calls.
    ///
    /// This procedure changes the way that errors in procedure calls are
    /// handled. By default GIMP will raise an error dialog if a procedure
    /// call made by a plug-in fails. Using this procedure the plug-in can
    /// change this behavior. If the error handler is set to
    /// `GIMP_PDB_ERROR_HANDLER_PLUGIN`, then the plug-in is responsible for
    /// calling `gimp.PDB.getLastError` and handling the error whenever
    /// one if its procedure calls fails. It can do this by displaying the
    /// error message or by forwarding it in its own return values.
    extern fn gimp_plug_in_set_pdb_error_handler(p_plug_in: *PlugIn, p_handler: gimp.PDBErrorHandler) void;
    pub const setPdbErrorHandler = gimp_plug_in_set_pdb_error_handler;

    extern fn gimp_plug_in_get_type() usize;
    pub const getGObjectType = gimp_plug_in_get_type;

    extern fn g_object_ref(p_self: *gimp.PlugIn) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.PlugIn) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PlugIn, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Procedures are registered functions which can be run across GIMP ecosystem.
/// They can be created by plug-ins and can then run by the core application
/// when called from menus (or through other interaction depending on specific
/// procedure subclasses).
///
/// A plug-in can also run procedures created by the core, but also the ones
/// created by other plug-ins (see `PDB`).
pub const Procedure = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ProcedureClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// called when a `gimp.Config` object is created using
        ///   `gimp.Procedure.createConfig`.
        pub const create_config = struct {
            pub fn call(p_class: anytype, p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_args: **gobject.ParamSpec, p_n_args: c_int) *gimp.ProcedureConfig {
                return gobject.ext.as(Procedure.Class, p_class).f_create_config.?(gobject.ext.as(Procedure, p_procedure), p_args, p_n_args);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_args: **gobject.ParamSpec, p_n_args: c_int) callconv(.c) *gimp.ProcedureConfig) void {
                gobject.ext.as(Procedure.Class, p_class).f_create_config = @ptrCast(p_implementation);
            }
        };

        /// called to install the procedure with the main GIMP
        ///   application. This is an implementation detail and must never
        ///   be called by any plug-in code.
        pub const install = struct {
            pub fn call(p_class: anytype, p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Procedure.Class, p_class).f_install.?(gobject.ext.as(Procedure, p_procedure));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Procedure.Class, p_class).f_install = @ptrCast(p_implementation);
            }
        };

        /// called when the procedure is executed via `gimp.Procedure.run`.
        ///   the default implementation simply calls the procedure's `gimp.RunFunc`,
        ///   `gimp.Procedure` subclasses are free to modify the passed `args` and
        ///   call their own, subclass-specific run functions.
        pub const run = struct {
            pub fn call(p_class: anytype, p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_args: *const gimp.ValueArray) *gimp.ValueArray {
                return gobject.ext.as(Procedure.Class, p_class).f_run.?(gobject.ext.as(Procedure, p_procedure), p_args);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_args: *const gimp.ValueArray) callconv(.c) *gimp.ValueArray) void {
                gobject.ext.as(Procedure.Class, p_class).f_run = @ptrCast(p_implementation);
            }
        };

        pub const set_sensitivity = struct {
            pub fn call(p_class: anytype, p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sensitivity_mask: c_int) c_int {
                return gobject.ext.as(Procedure.Class, p_class).f_set_sensitivity.?(gobject.ext.as(Procedure, p_procedure), p_sensitivity_mask);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sensitivity_mask: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Procedure.Class, p_class).f_set_sensitivity = @ptrCast(p_implementation);
            }
        };

        /// called to uninstall the procedure from the main GIMP
        ///   application. This is an implementation detail and must never
        ///   be called by any plug-in code.
        pub const uninstall = struct {
            pub fn call(p_class: anytype, p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Procedure.Class, p_class).f_uninstall.?(gobject.ext.as(Procedure, p_procedure));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_procedure: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Procedure.Class, p_class).f_uninstall = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const plug_in = struct {
            pub const name = "plug-in";

            pub const Type = ?*gimp.PlugIn;
        };

        pub const procedure_type = struct {
            pub const name = "procedure-type";

            pub const Type = gimp.PDBProcType;
        };
    };

    pub const signals = struct {};

    /// Creates a new procedure named `name` which will call `run_func` when
    /// invoked.
    ///
    /// The `name` parameter is mandatory and should be unique, or it will
    /// overwrite an already existing procedure (overwrite procedures only
    /// if you know what you're doing).
    ///
    /// `proc_type` should be `gimp.@"PDBProcType.PLUGIN"` for "normal" plug-ins.
    ///
    /// Using `gimp.@"PDBProcType.PERSISTENT"` means that the plug-in will
    /// add temporary procedures. Therefore, the GIMP core will wait until
    /// the `GIMP_PDB_PROC_TYPE_PERSISTENT` procedure has called
    /// `Procedure.persistentReady`, which means that the procedure
    /// has done its initialization, installed its temporary procedures and
    /// is ready to run.
    ///
    /// *Not calling `Procedure.persistentReady` from a
    /// `GIMP_PDB_PROC_TYPE_PERSISTENT` procedure will cause the GIMP core to
    /// lock up.*
    ///
    /// Additionally, a `GIMP_PDB_PROC_TYPE_PERSISTENT` procedure with no
    /// arguments added is an "automatic" extension that will be
    /// automatically started on each GIMP startup.
    ///
    /// `gimp.@"PDBProcType.TEMPORARY"` must be used for temporary procedures
    /// that are created during a plug-ins lifetime. They must be added to
    /// the `gimp.PlugIn` using `PlugIn.addTempProcedure`.
    ///
    /// `run_func` is called via `Procedure.run`.
    ///
    /// For `GIMP_PDB_PROC_TYPE_PLUGIN` and `GIMP_PDB_PROC_TYPE_PERSISTENT`
    /// procedures the call of `run_func` is basically the lifetime of the
    /// plug-in.
    extern fn gimp_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_run_func: gimp.RunFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.Procedure;
    pub const new = gimp_procedure_new;

    /// Add a new boolean argument to `procedure`.
    extern fn gimp_procedure_add_boolean_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addBooleanArgument = gimp_procedure_add_boolean_argument;

    /// Add a new boolean auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_boolean_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addBooleanAuxArgument = gimp_procedure_add_boolean_aux_argument;

    /// Add a new boolean return value to `procedure`.
    extern fn gimp_procedure_add_boolean_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addBooleanReturnValue = gimp_procedure_add_boolean_return_value;

    /// Add a new `gimp.Brush` argument to `procedure`.
    extern fn gimp_procedure_add_brush_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Brush, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addBrushArgument = gimp_procedure_add_brush_argument;

    /// Add a new `gimp.Brush` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_brush_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Brush, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addBrushAuxArgument = gimp_procedure_add_brush_aux_argument;

    /// Add a new `gimp.Brush` return value to `procedure`.
    extern fn gimp_procedure_add_brush_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addBrushReturnValue = gimp_procedure_add_brush_return_value;

    /// Add a new `glib.Bytes` argument to `procedure`.
    extern fn gimp_procedure_add_bytes_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addBytesArgument = gimp_procedure_add_bytes_argument;

    /// Add a new `glib.Bytes` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_bytes_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addBytesAuxArgument = gimp_procedure_add_bytes_aux_argument;

    /// Add a new `glib.Bytes` return value to `procedure`.
    extern fn gimp_procedure_add_bytes_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addBytesReturnValue = gimp_procedure_add_bytes_return_value;

    /// Add a new `gimp.Channel` argument to `procedure`.
    extern fn gimp_procedure_add_channel_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addChannelArgument = gimp_procedure_add_channel_argument;

    /// Add a new `gimp.Channel` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_channel_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addChannelAuxArgument = gimp_procedure_add_channel_aux_argument;

    /// Add a new `gimp.Channel` return value to `procedure`.
    extern fn gimp_procedure_add_channel_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addChannelReturnValue = gimp_procedure_add_channel_return_value;

    /// Add a new `gimp.Choice` argument to `procedure`.
    extern fn gimp_procedure_add_choice_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_choice: *gimp.Choice, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addChoiceArgument = gimp_procedure_add_choice_argument;

    /// Add a new `gimp.Choice` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_choice_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_choice: *gimp.Choice, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addChoiceAuxArgument = gimp_procedure_add_choice_aux_argument;

    /// Add a new `gimp.Choice` return value to `procedure`.
    extern fn gimp_procedure_add_choice_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_choice: *gimp.Choice, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addChoiceReturnValue = gimp_procedure_add_choice_return_value;

    /// Add a new `gegl.Color` argument to `procedure`.
    extern fn gimp_procedure_add_color_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: *gegl.Color, p_flags: gobject.ParamFlags) void;
    pub const addColorArgument = gimp_procedure_add_color_argument;

    /// Add a new `gegl.Color` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_color_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: *gegl.Color, p_flags: gobject.ParamFlags) void;
    pub const addColorAuxArgument = gimp_procedure_add_color_aux_argument;

    /// Add a new `gegl.Color` argument to `procedure` from a string representation.
    extern fn gimp_procedure_add_color_from_string_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addColorFromStringArgument = gimp_procedure_add_color_from_string_argument;

    /// Add a new `gegl.Color` auxiliary argument to `procedure` from a string representation.
    extern fn gimp_procedure_add_color_from_string_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addColorFromStringAuxArgument = gimp_procedure_add_color_from_string_aux_argument;

    /// Add a new `gegl.Color` return value to `procedure` from a string representation.
    extern fn gimp_procedure_add_color_from_string_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addColorFromStringReturnValue = gimp_procedure_add_color_from_string_return_value;

    /// Add a new `gegl.Color` return value to `procedure`.
    extern fn gimp_procedure_add_color_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_has_alpha: c_int, p_value: *gegl.Color, p_flags: gobject.ParamFlags) void;
    pub const addColorReturnValue = gimp_procedure_add_color_return_value;

    /// Add a new object array argument to `procedure`.
    extern fn gimp_procedure_add_core_object_array_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_object_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addCoreObjectArrayArgument = gimp_procedure_add_core_object_array_argument;

    /// Add a new object array auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_core_object_array_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_object_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addCoreObjectArrayAuxArgument = gimp_procedure_add_core_object_array_aux_argument;

    /// Add a new object array return value to `procedure`.
    extern fn gimp_procedure_add_core_object_array_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_object_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addCoreObjectArrayReturnValue = gimp_procedure_add_core_object_array_return_value;

    /// Add a new `gimp.Display` argument to `procedure`.
    extern fn gimp_procedure_add_display_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDisplayArgument = gimp_procedure_add_display_argument;

    /// Add a new `gimp.Display` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_display_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDisplayAuxArgument = gimp_procedure_add_display_aux_argument;

    /// Add a new `gimp.Display` return value to `procedure`.
    extern fn gimp_procedure_add_display_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDisplayReturnValue = gimp_procedure_add_display_return_value;

    /// Add a new floating-point in double precision argument to `procedure`.
    extern fn gimp_procedure_add_double_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: f64, p_max: f64, p_value: f64, p_flags: gobject.ParamFlags) void;
    pub const addDoubleArgument = gimp_procedure_add_double_argument;

    /// Add a new double array argument to `procedure`.
    extern fn gimp_procedure_add_double_array_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addDoubleArrayArgument = gimp_procedure_add_double_array_argument;

    /// Add a new double array auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_double_array_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addDoubleArrayAuxArgument = gimp_procedure_add_double_array_aux_argument;

    /// Add a new double array return value to `procedure`.
    extern fn gimp_procedure_add_double_array_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addDoubleArrayReturnValue = gimp_procedure_add_double_array_return_value;

    /// Add a new floating-point in double precision auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_double_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: f64, p_max: f64, p_value: f64, p_flags: gobject.ParamFlags) void;
    pub const addDoubleAuxArgument = gimp_procedure_add_double_aux_argument;

    /// Add a new floating-point in double precision return value to `procedure`.
    extern fn gimp_procedure_add_double_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: f64, p_max: f64, p_value: f64, p_flags: gobject.ParamFlags) void;
    pub const addDoubleReturnValue = gimp_procedure_add_double_return_value;

    /// Add a new `gimp.Drawable` argument to `procedure`.
    extern fn gimp_procedure_add_drawable_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDrawableArgument = gimp_procedure_add_drawable_argument;

    /// Add a new `gimp.Drawable` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_drawable_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDrawableAuxArgument = gimp_procedure_add_drawable_aux_argument;

    /// Add a new `gimp.Drawable` return value to `procedure`.
    extern fn gimp_procedure_add_drawable_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addDrawableReturnValue = gimp_procedure_add_drawable_return_value;

    /// Add a new enum argument to `procedure`.
    extern fn gimp_procedure_add_enum_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_enum_type: usize, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addEnumArgument = gimp_procedure_add_enum_argument;

    /// Add a new enum auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_enum_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_enum_type: usize, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addEnumAuxArgument = gimp_procedure_add_enum_aux_argument;

    /// Add a new enum return value to `procedure`.
    extern fn gimp_procedure_add_enum_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_enum_type: usize, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addEnumReturnValue = gimp_procedure_add_enum_return_value;

    /// Add a new `gio.File` argument to `procedure`.
    extern fn gimp_procedure_add_file_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_action: gimp.FileChooserAction, p_none_ok: c_int, p_default_file: ?*gio.File, p_flags: gobject.ParamFlags) void;
    pub const addFileArgument = gimp_procedure_add_file_argument;

    /// Add a new `gio.File` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_file_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_action: gimp.FileChooserAction, p_none_ok: c_int, p_default_file: ?*gio.File, p_flags: gobject.ParamFlags) void;
    pub const addFileAuxArgument = gimp_procedure_add_file_aux_argument;

    /// Add a new `gio.File` return value to `procedure`.
    extern fn gimp_procedure_add_file_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addFileReturnValue = gimp_procedure_add_file_return_value;

    /// Add a new `gimp.Font` argument to `procedure`.
    extern fn gimp_procedure_add_font_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Font, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addFontArgument = gimp_procedure_add_font_argument;

    /// Add a new `gimp.Font` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_font_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Font, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addFontAuxArgument = gimp_procedure_add_font_aux_argument;

    /// Add a new `gimp.Font` return value to `procedure`.
    extern fn gimp_procedure_add_font_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addFontReturnValue = gimp_procedure_add_font_return_value;

    /// Add a new `gimp.Gradient` argument to `procedure`.
    extern fn gimp_procedure_add_gradient_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Gradient, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addGradientArgument = gimp_procedure_add_gradient_argument;

    /// Add a new `gimp.Gradient` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_gradient_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Gradient, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addGradientAuxArgument = gimp_procedure_add_gradient_aux_argument;

    /// Add a new `gimp.Gradient` return value to `procedure`.
    extern fn gimp_procedure_add_gradient_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addGradientReturnValue = gimp_procedure_add_gradient_return_value;

    /// Add a new `GroupLayer` argument to `procedure`.
    extern fn gimp_procedure_add_group_layer_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addGroupLayerArgument = gimp_procedure_add_group_layer_argument;

    /// Add a new `GroupLayer` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_group_layer_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addGroupLayerAuxArgument = gimp_procedure_add_group_layer_aux_argument;

    /// Add a new `GroupLayer` return value to `procedure`.
    extern fn gimp_procedure_add_group_layer_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addGroupLayerReturnValue = gimp_procedure_add_group_layer_return_value;

    /// Add a new `gimp.Image` argument to `procedure`.
    extern fn gimp_procedure_add_image_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addImageArgument = gimp_procedure_add_image_argument;

    /// Add a new `gimp.Image` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_image_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addImageAuxArgument = gimp_procedure_add_image_aux_argument;

    /// Add a new `gimp.Image` return value to `procedure`.
    extern fn gimp_procedure_add_image_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addImageReturnValue = gimp_procedure_add_image_return_value;

    /// Add a new integer array argument to `procedure`.
    extern fn gimp_procedure_add_int32_array_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addInt32ArrayArgument = gimp_procedure_add_int32_array_argument;

    /// Add a new integer array auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_int32_array_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addInt32ArrayAuxArgument = gimp_procedure_add_int32_array_aux_argument;

    /// Add a new integer array return value to `procedure`.
    extern fn gimp_procedure_add_int32_array_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addInt32ArrayReturnValue = gimp_procedure_add_int32_array_return_value;

    /// Add a new integer argument to `procedure`.
    extern fn gimp_procedure_add_int_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_int, p_max: c_int, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addIntArgument = gimp_procedure_add_int_argument;

    /// Add a new integer auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_int_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_int, p_max: c_int, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addIntAuxArgument = gimp_procedure_add_int_aux_argument;

    /// Add a new integer return value to `procedure`.
    extern fn gimp_procedure_add_int_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_int, p_max: c_int, p_value: c_int, p_flags: gobject.ParamFlags) void;
    pub const addIntReturnValue = gimp_procedure_add_int_return_value;

    /// Add a new `gimp.Item` argument to `procedure`.
    extern fn gimp_procedure_add_item_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addItemArgument = gimp_procedure_add_item_argument;

    /// Add a new `gimp.Item` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_item_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addItemAuxArgument = gimp_procedure_add_item_aux_argument;

    /// Add a new `gimp.Item` return value to `procedure`.
    extern fn gimp_procedure_add_item_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addItemReturnValue = gimp_procedure_add_item_return_value;

    /// Add a new `gimp.Layer` argument to `procedure`.
    extern fn gimp_procedure_add_layer_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerArgument = gimp_procedure_add_layer_argument;

    /// Add a new `gimp.Layer` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_layer_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerAuxArgument = gimp_procedure_add_layer_aux_argument;

    /// Add a new `gimp.LayerMask` argument to `procedure`.
    extern fn gimp_procedure_add_layer_mask_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerMaskArgument = gimp_procedure_add_layer_mask_argument;

    /// Add a new `gimp.LayerMask` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_layer_mask_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerMaskAuxArgument = gimp_procedure_add_layer_mask_aux_argument;

    /// Add a new `gimp.LayerMask` return value to `procedure`.
    extern fn gimp_procedure_add_layer_mask_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerMaskReturnValue = gimp_procedure_add_layer_mask_return_value;

    /// Add a new `gimp.Layer` return value to `procedure`.
    extern fn gimp_procedure_add_layer_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addLayerReturnValue = gimp_procedure_add_layer_return_value;

    /// Adds a menu path to the procedure. Only procedures which have a menu
    /// label can add a menu path.
    ///
    /// Menu paths are untranslated paths to known menus and submenus with the
    /// syntax `<Prefix>/Path/To/Submenu`, for example `<Image>/Layer/Transform`.
    /// GIMP will localize these.
    /// Nevertheless you should localize unknown parts of the path. For instance, say
    /// you want to create procedure to create customized layers and add a `Create`
    /// submenu which you want to localize from your plug-in with gettext. You could
    /// call:
    ///
    /// ```C
    /// path = g_build_path ("/", "<Image>/Layer", _("Create"), NULL);
    /// gimp_procedure_add_menu_path (procedure, path);
    /// g_free (path);
    /// ```
    ///
    /// See also: `gimp.PlugIn.addMenuBranch`.
    ///
    /// GIMP menus also have a concept of named section. For instance, say you are
    /// creating a plug-in which you want to show next to the "Export", "Export As"
    /// plug-ins in the File menu. You would add it to the menu path "File/[Export]".
    /// If you actually wanted to create a submenu called "[Export]" (with square
    /// brackets), double the brackets: "File/[[Export]]"
    ///
    /// See also: https://gitlab.gnome.org/GNOME/gimp/-/blob/master/menus/image-menu.ui.in.in
    ///
    /// This function will place your procedure to the bottom of the selected path or
    /// section. Order is not assured relatively to other plug-ins.
    extern fn gimp_procedure_add_menu_path(p_procedure: *Procedure, p_menu_path: [*:0]const u8) void;
    pub const addMenuPath = gimp_procedure_add_menu_path;

    /// Add a new `gimp.Palette` argument to `procedure`.
    extern fn gimp_procedure_add_palette_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Palette, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPaletteArgument = gimp_procedure_add_palette_argument;

    /// Add a new `gimp.Palette` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_palette_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Palette, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPaletteAuxArgument = gimp_procedure_add_palette_aux_argument;

    /// Add a new `gimp.Palette` return value to `procedure`.
    extern fn gimp_procedure_add_palette_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addPaletteReturnValue = gimp_procedure_add_palette_return_value;

    /// Add a new param argument to `procedure`.
    extern fn gimp_procedure_add_param_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_param_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addParamArgument = gimp_procedure_add_param_argument;

    /// Add a new param auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_param_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_param_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addParamAuxArgument = gimp_procedure_add_param_aux_argument;

    /// Add a new param return value to `procedure`.
    extern fn gimp_procedure_add_param_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_param_type: usize, p_flags: gobject.ParamFlags) void;
    pub const addParamReturnValue = gimp_procedure_add_param_return_value;

    /// Add a new `gimp.Parasite` argument to `procedure`.
    extern fn gimp_procedure_add_parasite_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addParasiteArgument = gimp_procedure_add_parasite_argument;

    /// Add a new `gimp.Parasite` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_parasite_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addParasiteAuxArgument = gimp_procedure_add_parasite_aux_argument;

    /// Add a new `gimp.Parasite` return value to `procedure`.
    extern fn gimp_procedure_add_parasite_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addParasiteReturnValue = gimp_procedure_add_parasite_return_value;

    /// Add a new `gimp.Path` argument to `procedure`.
    extern fn gimp_procedure_add_path_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPathArgument = gimp_procedure_add_path_argument;

    /// Add a new `gimp.Path` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_path_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPathAuxArgument = gimp_procedure_add_path_aux_argument;

    /// Add a new `gimp.Path` return value to `procedure`.
    extern fn gimp_procedure_add_path_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPathReturnValue = gimp_procedure_add_path_return_value;

    /// Add a new `gimp.Pattern` argument to `procedure`.
    extern fn gimp_procedure_add_pattern_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Pattern, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPatternArgument = gimp_procedure_add_pattern_argument;

    /// Add a new `gimp.Pattern` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_pattern_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Pattern, p_default_to_context: c_int, p_flags: gobject.ParamFlags) void;
    pub const addPatternAuxArgument = gimp_procedure_add_pattern_aux_argument;

    /// Add a new `gimp.Pattern` return value to `procedure`.
    extern fn gimp_procedure_add_pattern_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addPatternReturnValue = gimp_procedure_add_pattern_return_value;

    /// Add a new `gimp.Resource` argument to `procedure`.
    extern fn gimp_procedure_add_resource_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Resource, p_flags: gobject.ParamFlags) void;
    pub const addResourceArgument = gimp_procedure_add_resource_argument;

    /// Add a new `gimp.Resource` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_resource_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_default_value: ?*gimp.Resource, p_flags: gobject.ParamFlags) void;
    pub const addResourceAuxArgument = gimp_procedure_add_resource_aux_argument;

    /// Add a new `gimp.Resource` return value to `procedure`.
    extern fn gimp_procedure_add_resource_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addResourceReturnValue = gimp_procedure_add_resource_return_value;

    /// Add a new `gimp.Selection` argument to `procedure`.
    extern fn gimp_procedure_add_selection_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addSelectionArgument = gimp_procedure_add_selection_argument;

    /// Add a new `gimp.Selection` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_selection_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addSelectionAuxArgument = gimp_procedure_add_selection_aux_argument;

    /// Add a new `gimp.Selection` return value to `procedure`.
    extern fn gimp_procedure_add_selection_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addSelectionReturnValue = gimp_procedure_add_selection_return_value;

    /// Add a new string argument to `procedure`.
    extern fn gimp_procedure_add_string_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringArgument = gimp_procedure_add_string_argument;

    /// Add a new string array argument to `procedure`.
    extern fn gimp_procedure_add_string_array_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringArrayArgument = gimp_procedure_add_string_array_argument;

    /// Add a new string array auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_string_array_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringArrayAuxArgument = gimp_procedure_add_string_array_aux_argument;

    /// Add a new string array return value to `procedure`.
    extern fn gimp_procedure_add_string_array_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringArrayReturnValue = gimp_procedure_add_string_array_return_value;

    /// Add a new string auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_string_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringAuxArgument = gimp_procedure_add_string_aux_argument;

    /// Add a new string return value to `procedure`.
    extern fn gimp_procedure_add_string_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_value: [*:0]const u8, p_flags: gobject.ParamFlags) void;
    pub const addStringReturnValue = gimp_procedure_add_string_return_value;

    /// Add a new `gimp.TextLayer` argument to `procedure`.
    extern fn gimp_procedure_add_text_layer_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addTextLayerArgument = gimp_procedure_add_text_layer_argument;

    /// Add a new `gimp.TextLayer` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_text_layer_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addTextLayerAuxArgument = gimp_procedure_add_text_layer_aux_argument;

    /// Add a new `gimp.TextLayer` return value to `procedure`.
    extern fn gimp_procedure_add_text_layer_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) void;
    pub const addTextLayerReturnValue = gimp_procedure_add_text_layer_return_value;

    /// Add a new unsigned integer argument to `procedure`.
    extern fn gimp_procedure_add_uint_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_uint, p_max: c_uint, p_value: c_uint, p_flags: gobject.ParamFlags) void;
    pub const addUintArgument = gimp_procedure_add_uint_argument;

    /// Add a new unsigned integer auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_uint_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_uint, p_max: c_uint, p_value: c_uint, p_flags: gobject.ParamFlags) void;
    pub const addUintAuxArgument = gimp_procedure_add_uint_aux_argument;

    /// Add a new unsigned integer return value to `procedure`.
    extern fn gimp_procedure_add_uint_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_min: c_uint, p_max: c_uint, p_value: c_uint, p_flags: gobject.ParamFlags) void;
    pub const addUintReturnValue = gimp_procedure_add_uint_return_value;

    /// Add a new `gimp.Unit` argument to `procedure`.
    extern fn gimp_procedure_add_unit_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_show_pixels: c_int, p_show_percent: c_int, p_value: *gimp.Unit, p_flags: gobject.ParamFlags) void;
    pub const addUnitArgument = gimp_procedure_add_unit_argument;

    /// Add a new `gimp.Unit` auxiliary argument to `procedure`.
    extern fn gimp_procedure_add_unit_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_show_pixels: c_int, p_show_percent: c_int, p_value: *gimp.Unit, p_flags: gobject.ParamFlags) void;
    pub const addUnitAuxArgument = gimp_procedure_add_unit_aux_argument;

    /// Add a new `gimp.Unit` return value to `procedure`.
    extern fn gimp_procedure_add_unit_return_value(p_procedure: *Procedure, p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: ?[*:0]const u8, p_show_pixels: c_int, p_show_percent: c_int, p_value: *gimp.Unit, p_flags: gobject.ParamFlags) void;
    pub const addUnitReturnValue = gimp_procedure_add_unit_return_value;

    /// Create a `gimp.Config` with properties that match `procedure`'s arguments, to be
    /// used in `Procedure.runConfig` method.
    extern fn gimp_procedure_create_config(p_procedure: *Procedure) *gimp.ProcedureConfig;
    pub const createConfig = gimp_procedure_create_config;

    /// Searches the `procedure`'s arguments for a `gobject.ParamSpec` called `name`.
    extern fn gimp_procedure_find_argument(p_procedure: *Procedure, p_name: [*:0]const u8) *gobject.ParamSpec;
    pub const findArgument = gimp_procedure_find_argument;

    /// Searches the `procedure`'s auxiliary arguments for a `gobject.ParamSpec`
    /// called `name`.
    extern fn gimp_procedure_find_aux_argument(p_procedure: *Procedure, p_name: [*:0]const u8) *gobject.ParamSpec;
    pub const findAuxArgument = gimp_procedure_find_aux_argument;

    /// Searches the `procedure`'s return values for a `gobject.ParamSpec` called
    /// `name`.
    extern fn gimp_procedure_find_return_value(p_procedure: *Procedure, p_name: [*:0]const u8) *gobject.ParamSpec;
    pub const findReturnValue = gimp_procedure_find_return_value;

    extern fn gimp_procedure_get_argument_sync(p_procedure: *Procedure, p_arg_name: [*:0]const u8) gimp.ArgumentSync;
    pub const getArgumentSync = gimp_procedure_get_argument_sync;

    extern fn gimp_procedure_get_arguments(p_procedure: *Procedure, p_n_arguments: *c_int) [*]*gobject.ParamSpec;
    pub const getArguments = gimp_procedure_get_arguments;

    extern fn gimp_procedure_get_authors(p_procedure: *Procedure) [*:0]const u8;
    pub const getAuthors = gimp_procedure_get_authors;

    extern fn gimp_procedure_get_aux_arguments(p_procedure: *Procedure, p_n_arguments: *c_int) [*]*gobject.ParamSpec;
    pub const getAuxArguments = gimp_procedure_get_aux_arguments;

    extern fn gimp_procedure_get_blurb(p_procedure: *Procedure) [*:0]const u8;
    pub const getBlurb = gimp_procedure_get_blurb;

    extern fn gimp_procedure_get_copyright(p_procedure: *Procedure) [*:0]const u8;
    pub const getCopyright = gimp_procedure_get_copyright;

    extern fn gimp_procedure_get_date(p_procedure: *Procedure) [*:0]const u8;
    pub const getDate = gimp_procedure_get_date;

    extern fn gimp_procedure_get_help(p_procedure: *Procedure) [*:0]const u8;
    pub const getHelp = gimp_procedure_get_help;

    extern fn gimp_procedure_get_help_id(p_procedure: *Procedure) [*:0]const u8;
    pub const getHelpId = gimp_procedure_get_help_id;

    /// Gets the file of the icon if one was set for `procedure`.
    extern fn gimp_procedure_get_icon_file(p_procedure: *Procedure) ?*gio.File;
    pub const getIconFile = gimp_procedure_get_icon_file;

    /// Gets the name of the icon if one was set for `procedure`.
    extern fn gimp_procedure_get_icon_name(p_procedure: *Procedure) ?[*:0]const u8;
    pub const getIconName = gimp_procedure_get_icon_name;

    /// Gets the `gdkpixbuf.Pixbuf` of the icon if an icon was set this way for
    /// `procedure`.
    extern fn gimp_procedure_get_icon_pixbuf(p_procedure: *Procedure) ?*gdkpixbuf.Pixbuf;
    pub const getIconPixbuf = gimp_procedure_get_icon_pixbuf;

    /// Gets the type of data set as `procedure`'s icon. Depending on the
    /// result, you can call the relevant specific function, such as
    /// `Procedure.getIconName`.
    extern fn gimp_procedure_get_icon_type(p_procedure: *Procedure) gimp.IconType;
    pub const getIconType = gimp_procedure_get_icon_type;

    /// This function retrieves the list of image types the procedure can
    /// operate on. See `gimp.Procedure.setImageTypes`.
    extern fn gimp_procedure_get_image_types(p_procedure: *Procedure) [*:0]const u8;
    pub const getImageTypes = gimp_procedure_get_image_types;

    extern fn gimp_procedure_get_menu_label(p_procedure: *Procedure) [*:0]const u8;
    pub const getMenuLabel = gimp_procedure_get_menu_label;

    extern fn gimp_procedure_get_menu_paths(p_procedure: *Procedure) *glib.List;
    pub const getMenuPaths = gimp_procedure_get_menu_paths;

    extern fn gimp_procedure_get_name(p_procedure: *Procedure) [*:0]const u8;
    pub const getName = gimp_procedure_get_name;

    extern fn gimp_procedure_get_plug_in(p_procedure: *Procedure) *gimp.PlugIn;
    pub const getPlugIn = gimp_procedure_get_plug_in;

    extern fn gimp_procedure_get_proc_type(p_procedure: *Procedure) gimp.PDBProcType;
    pub const getProcType = gimp_procedure_get_proc_type;

    extern fn gimp_procedure_get_return_values(p_procedure: *Procedure, p_n_return_values: *c_int) [*]*gobject.ParamSpec;
    pub const getReturnValues = gimp_procedure_get_return_values;

    extern fn gimp_procedure_get_sensitivity_mask(p_procedure: *Procedure) c_int;
    pub const getSensitivityMask = gimp_procedure_get_sensitivity_mask;

    /// Provide the information if `procedure` is an internal procedure. Only
    /// a procedure looked up in the `gimp.PDB` can be internal.
    /// Procedures created by a plug-in in particular are never internal.
    extern fn gimp_procedure_is_internal(p_procedure: *Procedure) c_int;
    pub const isInternal = gimp_procedure_is_internal;

    /// Format the expected return values from procedures.
    extern fn gimp_procedure_new_return_values(p_procedure: *Procedure, p_status: gimp.PDBStatusType, p_error: ?*glib.Error) *gimp.ValueArray;
    pub const newReturnValues = gimp_procedure_new_return_values;

    /// Notify the main GIMP application that the persistent procedure has
    /// been properly initialized and is ready to run.
    ///
    /// This function _must_ be called from every procedure's `RunFunc`
    /// that was created as `gimp.@"PDBProcType.PERSISTENT"`.
    ///
    /// Subsequently, extensions can process temporary procedure run
    /// requests using either `PlugIn.persistentEnable` or
    /// `PlugIn.persistentProcess`.
    ///
    /// See also: `Procedure.new`.
    extern fn gimp_procedure_persistent_ready(p_procedure: *Procedure) void;
    pub const persistentReady = gimp_procedure_persistent_ready;

    /// Runs the procedure named `procedure_name` with arguments given as
    /// list of `(name, value)` pairs, terminated by `NULL`.
    ///
    /// The order of arguments does not matter and if any argument is missing, its
    /// default value will be used. The value type must correspond to the argument
    /// type as registered for `procedure_name`.
    extern fn gimp_procedure_run(p_procedure: *Procedure, p_first_arg_name: [*:0]const u8, ...) *gimp.ValueArray;
    pub const run = gimp_procedure_run;

    /// Runs `procedure`, calling the run_func given in `Procedure.new`.
    ///
    /// Create `config` at default values with
    /// `gimp.Procedure.createConfig` then set any argument you wish
    /// to change from defaults with `gobject.Object.set`.
    ///
    /// If `config` is `NULL`, the default arguments of `procedure` will be used.
    extern fn gimp_procedure_run_config(p_procedure: *Procedure, p_config: ?*gimp.ProcedureConfig) *gimp.ValueArray;
    pub const runConfig = gimp_procedure_run_config;

    /// Runs `procedure` with arguments names and values, given in the order as passed
    /// to `Procedure.run`.
    extern fn gimp_procedure_run_valist(p_procedure: *Procedure, p_first_arg_name: [*:0]const u8, p_args: std.builtin.VaList) *gimp.ValueArray;
    pub const runValist = gimp_procedure_run_valist;

    /// When the procedure's `run` function exits, a `gimp.Procedure`'s arguments
    /// or auxiliary arguments can be automatically synced with a `gimp.Parasite` of
    /// the `gimp.Image` the procedure is running on.
    ///
    /// In order to enable this, set `sync` to `GIMP_ARGUMENT_SYNC_PARASITE`.
    ///
    /// Currently, it is possible to sync a string argument of type
    /// `gobject.ParamSpecString` with an image parasite of the same name, for
    /// example the "gimp-comment" parasite in file save procedures.
    extern fn gimp_procedure_set_argument_sync(p_procedure: *Procedure, p_arg_name: [*:0]const u8, p_sync: gimp.ArgumentSync) void;
    pub const setArgumentSync = gimp_procedure_set_argument_sync;

    /// Sets various attribution strings on `procedure`.
    extern fn gimp_procedure_set_attribution(p_procedure: *Procedure, p_authors: [*:0]const u8, p_copyright: [*:0]const u8, p_date: [*:0]const u8) void;
    pub const setAttribution = gimp_procedure_set_attribution;

    /// Sets various documentation strings on `procedure`:
    ///
    /// * `blurb` is used for instance as the `procedure`'s tooltip when represented in
    ///   the UI such as a menu entry.
    /// * `help` is a free-form text that's meant as additional documentation for
    ///   developers of scripts and plug-ins. If the `blurb` and the argument names
    ///   and descriptions are enough for a quite self-explanatory procedure, you may
    ///   set `help` to `NULL`, rather than setting an uninformative `help` (avoid
    ///   setting the same text as `blurb` or redundant information).
    ///
    /// Plug-ins are responsible for their own translations. You are expected to send
    /// localized strings of `blurb` and `help` to GIMP if your plug-in is
    /// internationalized.
    extern fn gimp_procedure_set_documentation(p_procedure: *Procedure, p_blurb: [*:0]const u8, p_help: ?[*:0]const u8, p_help_id: ?[*:0]const u8) void;
    pub const setDocumentation = gimp_procedure_set_documentation;

    /// Sets the icon for `procedure` to the contents of an image file.
    extern fn gimp_procedure_set_icon_file(p_procedure: *Procedure, p_file: ?*gio.File) void;
    pub const setIconFile = gimp_procedure_set_icon_file;

    /// Sets the icon for `procedure` to the icon referenced by `icon_name`.
    extern fn gimp_procedure_set_icon_name(p_procedure: *Procedure, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = gimp_procedure_set_icon_name;

    /// Sets the icon for `procedure` to `pixbuf`.
    extern fn gimp_procedure_set_icon_pixbuf(p_procedure: *Procedure, p_pixbuf: ?*gdkpixbuf.Pixbuf) void;
    pub const setIconPixbuf = gimp_procedure_set_icon_pixbuf;

    /// This is a comma separated list of image types, or actually drawable
    /// types, that this procedure can deal with. Wildcards are possible
    /// here, so you could say "RGB\*" instead of "RGB, RGBA" or "\*" for all
    /// image types.
    ///
    /// Supported types are "RGB", "GRAY", "INDEXED" and their variants
    /// with alpha.
    extern fn gimp_procedure_set_image_types(p_procedure: *Procedure, p_image_types: [*:0]const u8) void;
    pub const setImageTypes = gimp_procedure_set_image_types;

    /// Sets the label to use for the `procedure`'s menu entry, The
    /// location(s) where to register in the menu hierarchy is chosen using
    /// `gimp.Procedure.addMenuPath`.
    ///
    /// Plug-ins are responsible for their own translations. You are expected to send
    /// localized strings to GIMP if your plug-in is internationalized.
    extern fn gimp_procedure_set_menu_label(p_procedure: *Procedure, p_menu_label: [*:0]const u8) void;
    pub const setMenuLabel = gimp_procedure_set_menu_label;

    /// Sets the cases when `procedure` is supposed to be sensitive or not.
    ///
    /// Note that it will be used by the core to determine whether to show a
    /// procedure as sensitive (hence forbid running it otherwise), yet it
    /// will not forbid thid-party plug-ins for instance to run manually your
    /// registered procedure. Therefore you should still handle non-supported
    /// cases appropriately by returning with `GIMP_PDB_EXECUTION_ERROR` and a
    /// suitable error message.
    ///
    /// Similarly third-party plug-ins should verify they are allowed to call
    /// a procedure with `Procedure.getSensitivityMask` when running
    /// with dynamic contents.
    ///
    /// Note that by default, a procedure works on an image with one or more
    /// drawables selected. Hence not setting the mask, setting it with 0 or
    /// setting it with `GIMP_PROCEDURE_SENSITIVE_DRAWABLE |
    /// GIMP_PROCEDURE_SENSITIVE_DRAWABLES` are equivalent.
    extern fn gimp_procedure_set_sensitivity_mask(p_procedure: *Procedure, p_sensitivity_mask: c_int) void;
    pub const setSensitivityMask = gimp_procedure_set_sensitivity_mask;

    extern fn gimp_procedure_get_type() usize;
    pub const getGObjectType = gimp_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.Procedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Procedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Procedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The base class for `Procedure` specific config objects and the main
/// interface to manage aspects of `Procedure`'s arguments such as
/// persistency of the last used arguments across GIMP sessions.
///
/// A procedure config is created by a `Procedure` using
/// `Procedure.createConfig` and its properties match the
/// procedure's arguments and auxiliary arguments in number, order and
/// type.
///
/// It implements the `Config` interface and therefore has all its
/// serialization and deserialization features.
pub const ProcedureConfig = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.ProcedureConfigClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const procedure = struct {
            pub const name = "procedure";

            pub const Type = ?*gimp.Procedure;
        };
    };

    pub const signals = struct {};

    /// A utility function which will get the current string value of a
    /// `GimpParamSpecChoice` property in `config` and convert it to the
    /// integer ID mapped to this value.
    /// This makes it easy to work with an Enum type locally, within a plug-in code.
    extern fn gimp_procedure_config_get_choice_id(p_config: *ProcedureConfig, p_property_name: [*:0]const u8) c_int;
    pub const getChoiceId = gimp_procedure_config_get_choice_id;

    /// A function for bindings to get a `ColorArray` property. Getting
    /// these with `gobject.Object.get` or `gobject.Object.getProperty` won't
    /// [work for the time being](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492)
    /// so all our boxed array types must be set and get using these
    /// alternative functions instead.
    ///
    /// C plug-ins should just use `gobject.Object.get`.
    extern fn gimp_procedure_config_get_color_array(p_config: *ProcedureConfig, p_property_name: [*:0]const u8) [*]*gegl.Color;
    pub const getColorArray = gimp_procedure_config_get_color_array;

    /// A function for bindings to get a `CoreObjectArray` property. Getting
    /// these with `gobject.Object.get` or `gobject.Object.getProperty` won't
    /// [work for the time being](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492)
    /// so all our boxed array types must be set and get using alternative
    /// functions instead.
    ///
    /// C plug-ins should just use `gobject.Object.get`.
    extern fn gimp_procedure_config_get_core_object_array(p_config: *ProcedureConfig, p_property_name: [*:0]const u8) [*]*gobject.Object;
    pub const getCoreObjectArray = gimp_procedure_config_get_core_object_array;

    /// This function returns the `Procedure` which created `config`, see
    /// `Procedure.createConfig`.
    extern fn gimp_procedure_config_get_procedure(p_config: *ProcedureConfig) *gimp.Procedure;
    pub const getProcedure = gimp_procedure_config_get_procedure;

    /// *Note: There is normally no need to call this function because it's
    /// already called by `ExportProcedure` after the ``run`` callback.*
    ///
    /// *Only use this function if the `Metadata` passed as argument of a
    /// `ExportProcedure`'s `run` method needs to be written at a specific
    /// point of the export, other than its end.*
    ///
    /// This function syncs back `config`'s export properties to the
    /// metadata's `MetadataSaveFlags` and writes the metadata to
    /// `file`.
    ///
    /// The metadata is only ever written once. If this function has been
    /// called explicitly, it will do nothing when called a second time at the end of
    /// the ``run`` callback.
    extern fn gimp_procedure_config_save_metadata(p_config: *ProcedureConfig, p_exported_image: *gimp.Image, p_file: *gio.File) void;
    pub const saveMetadata = gimp_procedure_config_save_metadata;

    /// A function for bindings to set a `ColorArray` property. Setting
    /// these with `gobject.Object.set` or `gobject.Object.setProperty` won't
    /// [work for the time being](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492)
    /// so all our boxed array types must be set and get using these
    /// alternative functions instead.
    ///
    /// C plug-ins should just use `gobject.Object.set`.
    extern fn gimp_procedure_config_set_color_array(p_config: *ProcedureConfig, p_property_name: [*:0]const u8, p_colors: [*]*gegl.Color, p_n_colors: usize) void;
    pub const setColorArray = gimp_procedure_config_set_color_array;

    /// A function for bindings to set a `CoreObjectArray` property. Setting
    /// these with `gobject.Object.set` or `gobject.Object.setProperty` won't
    /// [work for the time being](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492)
    /// so all our boxed array types must be set and get using alternative
    /// functions instead.
    ///
    /// C plug-ins should just use `gobject.Object.set`.
    extern fn gimp_procedure_config_set_core_object_array(p_config: *ProcedureConfig, p_property_name: [*:0]const u8, p_objects: [*]*gobject.Object, p_n_objects: usize) void;
    pub const setCoreObjectArray = gimp_procedure_config_set_core_object_array;

    extern fn gimp_procedure_config_get_type() usize;
    pub const getGObjectType = gimp_procedure_config_get_type;

    extern fn g_object_ref(p_self: *gimp.ProcedureConfig) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ProcedureConfig) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ProcedureConfig, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions to manipulate resources.
pub const Resource = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimp.ResourceClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Returns a `gimp.Resource` representing `resource_id`. Since `gimp.Resource` is an
    /// abstract class, the real object type will actually be the proper
    /// subclass.
    ///
    /// Note: in most use cases, you should not need to retrieve a
    /// `gimp.Resource` by its ID, which is mostly internal data and not
    /// reusable across sessions. Use the appropriate functions for your use
    /// case instead.
    extern fn gimp_resource_get_by_id(p_resource_id: i32) ?*gimp.Resource;
    pub const getById = gimp_resource_get_by_id;

    /// Returns the resource with the given `resource_type` and
    /// `resource_name`.
    extern fn gimp_resource_get_by_name(p_resource_type: usize, p_resource_name: [*:0]const u8) ?*gimp.Resource;
    pub const getByName = gimp_resource_get_by_name;

    /// Returns whether the resource ID is a brush.
    ///
    /// This procedure returns TRUE if the specified resource ID is a brush.
    extern fn gimp_resource_id_is_brush(p_resource_id: c_int) c_int;
    pub const idIsBrush = gimp_resource_id_is_brush;

    /// Returns whether the resource ID is a font.
    ///
    /// This procedure returns TRUE if the specified resource ID is a font.
    extern fn gimp_resource_id_is_font(p_resource_id: c_int) c_int;
    pub const idIsFont = gimp_resource_id_is_font;

    /// Returns whether the resource ID is a gradient.
    ///
    /// This procedure returns TRUE if the specified resource ID is a
    /// gradient.
    extern fn gimp_resource_id_is_gradient(p_resource_id: c_int) c_int;
    pub const idIsGradient = gimp_resource_id_is_gradient;

    /// Returns whether the resource ID is a palette.
    ///
    /// This procedure returns TRUE if the specified resource ID is a
    /// palette.
    extern fn gimp_resource_id_is_palette(p_resource_id: c_int) c_int;
    pub const idIsPalette = gimp_resource_id_is_palette;

    /// Returns whether the resource ID is a pattern.
    ///
    /// This procedure returns TRUE if the specified resource ID is a
    /// pattern.
    extern fn gimp_resource_id_is_pattern(p_resource_id: c_int) c_int;
    pub const idIsPattern = gimp_resource_id_is_pattern;

    /// Returns TRUE if the resource ID is valid.
    ///
    /// This procedure checks if the given resource ID is valid and refers
    /// to an existing resource.
    ///
    /// *Note*: in most use cases, you should not use this function. If you
    /// got a `gimp.Resource` from the API, you should trust it is
    /// valid. This function is mostly for internal usage.
    extern fn gimp_resource_id_is_valid(p_resource_id: c_int) c_int;
    pub const idIsValid = gimp_resource_id_is_valid;

    /// Deletes a resource.
    ///
    /// Deletes a resource. Returns an error if the resource is not
    /// deletable. Deletes the resource's data. You should not use the
    /// resource afterwards.
    extern fn gimp_resource_delete(p_resource: *Resource) c_int;
    pub const delete = gimp_resource_delete;

    /// Duplicates a resource.
    ///
    /// Returns a copy having a different, unique ID.
    extern fn gimp_resource_duplicate(p_resource: *Resource) *gimp.Resource;
    pub const duplicate = gimp_resource_duplicate;

    /// Note: in most use cases, you should not need a resource's ID which is
    /// mostly internal data and not reusable across sessions.
    extern fn gimp_resource_get_id(p_resource: *Resource) i32;
    pub const getId = gimp_resource_get_id;

    /// Returns the resource's name.
    ///
    /// This procedure returns the resource's name.
    extern fn gimp_resource_get_name(p_resource: *Resource) [*:0]u8;
    pub const getName = gimp_resource_get_name;

    /// Returns whether the resource is a brush.
    ///
    /// This procedure returns TRUE if the specified resource is a brush.
    extern fn gimp_resource_is_brush(p_resource: *Resource) c_int;
    pub const isBrush = gimp_resource_is_brush;

    /// Whether the resource can be edited.
    ///
    /// Returns TRUE if you have permission to change the resource.
    extern fn gimp_resource_is_editable(p_resource: *Resource) c_int;
    pub const isEditable = gimp_resource_is_editable;

    /// Returns whether the resource is a font.
    ///
    /// This procedure returns TRUE if the specified resource is a font.
    extern fn gimp_resource_is_font(p_resource: *Resource) c_int;
    pub const isFont = gimp_resource_is_font;

    /// Returns whether the resource is a gradient.
    ///
    /// This procedure returns TRUE if the specified resource is a gradient.
    extern fn gimp_resource_is_gradient(p_resource: *Resource) c_int;
    pub const isGradient = gimp_resource_is_gradient;

    /// Returns whether the resource is a palette.
    ///
    /// This procedure returns TRUE if the specified resource is a palette.
    extern fn gimp_resource_is_palette(p_resource: *Resource) c_int;
    pub const isPalette = gimp_resource_is_palette;

    /// Returns whether the resource is a pattern.
    ///
    /// This procedure returns TRUE if the specified resource is a pattern.
    extern fn gimp_resource_is_pattern(p_resource: *Resource) c_int;
    pub const isPattern = gimp_resource_is_pattern;

    /// Returns TRUE if the resource is valid.
    ///
    /// This procedure checks if the given resource is valid and refers to an
    /// existing resource.
    extern fn gimp_resource_is_valid(p_resource: *Resource) c_int;
    pub const isValid = gimp_resource_is_valid;

    /// Renames a resource. When the name is in use, renames to a unique
    /// name.
    ///
    /// Renames a resource. When the proposed name is already used, GIMP
    /// generates a unique name.
    extern fn gimp_resource_rename(p_resource: *Resource, p_new_name: [*:0]const u8) c_int;
    pub const rename = gimp_resource_rename;

    extern fn gimp_resource_get_type() usize;
    pub const getGObjectType = gimp_resource_get_type;

    extern fn g_object_ref(p_self: *gimp.Resource) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Resource) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Resource, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions for manipulating selections.
pub const Selection = opaque {
    pub const Parent = gimp.Channel;
    pub const Implements = [_]type{};
    pub const Class = gimp.SelectionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Select all of the image.
    ///
    /// This procedure sets the selection mask to completely encompass the
    /// image. Every pixel in the selection channel is set to 255.
    extern fn gimp_selection_all(p_image: *gimp.Image) c_int;
    pub const all = gimp_selection_all;

    /// Border the image's selection
    ///
    /// This procedure borders the selection. Bordering creates a new
    /// selection which is defined along the boundary of the previous
    /// selection at every point within the specified radius.
    extern fn gimp_selection_border(p_image: *gimp.Image, p_radius: c_int) c_int;
    pub const border = gimp_selection_border;

    /// Find the bounding box of the current selection.
    ///
    /// This procedure returns whether there is a selection for the
    /// specified image. If there is one, the upper left and lower right
    /// corners of the bounding box are returned. These coordinates are
    /// relative to the image. Please note that the pixel specified by the
    /// lower right coordinate of the bounding box is not part of the
    /// selection. The selection ends at the upper left corner of this
    /// pixel. This means the width of the selection can be calculated as
    /// (x2 - x1), its height as (y2 - y1).
    extern fn gimp_selection_bounds(p_image: *gimp.Image, p_non_empty: *c_int, p_x1: *c_int, p_y1: *c_int, p_x2: *c_int, p_y2: *c_int) c_int;
    pub const bounds = gimp_selection_bounds;

    /// Feather the image's selection
    ///
    /// This procedure feathers the selection. Feathering is implemented
    /// using a gaussian blur.
    extern fn gimp_selection_feather(p_image: *gimp.Image, p_radius: f64) c_int;
    pub const feather = gimp_selection_feather;

    /// Float the selection from the specified drawable with initial offsets
    /// as specified.
    ///
    /// This procedure determines the region of the specified drawable that
    /// lies beneath the current selection. The region is then cut from the
    /// drawable and the resulting data is made into a new layer which is
    /// instantiated as a floating selection. The offsets allow initial
    /// positioning of the new floating selection.
    extern fn gimp_selection_float(p_image: *gimp.Image, p_drawables: [*]*gimp.Drawable, p_offx: c_int, p_offy: c_int) *gimp.Layer;
    pub const float = gimp_selection_float;

    /// Remove holes from the image's selection
    ///
    /// This procedure removes holes from the selection, that can come from
    /// selecting a patchy area with the Fuzzy Select Tool. In technical
    /// terms this procedure floods the selection. See the Algorithms page
    /// in the developer wiki for details.
    extern fn gimp_selection_flood(p_image: *gimp.Image) c_int;
    pub const flood = gimp_selection_flood;

    /// Returns a `gimp.Selection` representing `selection_id`. This function
    /// calls `gimp.Item.getById` and returns the item if it is selection
    /// or `NULL` otherwise.
    extern fn gimp_selection_get_by_id(p_selection_id: i32) ?*gimp.Selection;
    pub const getById = gimp_selection_get_by_id;

    /// Grow the image's selection
    ///
    /// This procedure grows the selection. Growing involves expanding the
    /// boundary in all directions by the specified pixel amount.
    extern fn gimp_selection_grow(p_image: *gimp.Image, p_steps: c_int) c_int;
    pub const grow = gimp_selection_grow;

    /// Invert the selection mask.
    ///
    /// This procedure inverts the selection mask. For every pixel in the
    /// selection channel, its new value is calculated as (255 - old-value).
    extern fn gimp_selection_invert(p_image: *gimp.Image) c_int;
    pub const invert = gimp_selection_invert;

    /// Determine whether the selection is empty.
    ///
    /// This procedure returns TRUE if the selection for the specified image
    /// is empty.
    extern fn gimp_selection_is_empty(p_image: *gimp.Image) c_int;
    pub const isEmpty = gimp_selection_is_empty;

    /// Deselect the entire image.
    ///
    /// This procedure deselects the entire image. Every pixel in the
    /// selection channel is set to 0.
    extern fn gimp_selection_none(p_image: *gimp.Image) c_int;
    pub const none = gimp_selection_none;

    /// Copy the selection mask to a new channel.
    ///
    /// This procedure copies the selection mask and stores the content in a
    /// new channel. The new channel is automatically inserted into the
    /// image's list of channels.
    extern fn gimp_selection_save(p_image: *gimp.Image) *gimp.Channel;
    pub const save = gimp_selection_save;

    /// Sharpen the selection mask.
    ///
    /// This procedure sharpens the selection mask. For every pixel in the
    /// selection channel, if the value is &gt; 127, the new pixel is
    /// assigned a value of 255. This removes any \"anti-aliasing\" that
    /// might exist in the selection mask's boundary.
    extern fn gimp_selection_sharpen(p_image: *gimp.Image) c_int;
    pub const sharpen = gimp_selection_sharpen;

    /// Shrink the image's selection
    ///
    /// This procedure shrinks the selection. Shrinking involves trimming
    /// the existing selection boundary on all sides by the specified number
    /// of pixels.
    extern fn gimp_selection_shrink(p_image: *gimp.Image, p_steps: c_int) c_int;
    pub const shrink = gimp_selection_shrink;

    /// Translate the selection by the specified offsets.
    ///
    /// This procedure actually translates the selection for the specified
    /// image by the specified offsets. Regions that are translated from
    /// beyond the bounds of the image are set to empty. Valid regions of
    /// the selection which are translated beyond the bounds of the image
    /// because of this call are lost.
    extern fn gimp_selection_translate(p_image: *gimp.Image, p_offx: c_int, p_offy: c_int) c_int;
    pub const translate = gimp_selection_translate;

    /// Find the value of the selection at the specified coordinates.
    ///
    /// This procedure returns the value of the selection at the specified
    /// coordinates. If the coordinates lie out of bounds, 0 is returned.
    extern fn gimp_selection_value(p_image: *gimp.Image, p_x: c_int, p_y: c_int) c_int;
    pub const value = gimp_selection_value;

    extern fn gimp_selection_get_type() usize;
    pub const getGObjectType = gimp_selection_get_type;

    extern fn g_object_ref(p_self: *gimp.Selection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Selection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Selection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions for querying and manipulating text layers.
pub const TextLayer = opaque {
    pub const Parent = gimp.Layer;
    pub const Implements = [_]type{};
    pub const Class = gimp.TextLayerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a `gimp.TextLayer` representing `layer_id`. This function calls
    /// `gimp.Item.getById` and returns the item if it is layer or `NULL`
    /// otherwise.
    extern fn gimp_text_layer_get_by_id(p_layer_id: i32) ?*gimp.TextLayer;
    pub const getById = gimp_text_layer_get_by_id;

    /// Creates a new text layer.
    ///
    /// This procedure creates a new text layer displaying the specified
    /// `text`. By default the width and height of the layer will be
    /// determined by the `text` contents, the `font`, `size` and `unit`.
    ///
    /// The new layer still needs to be added to the image as this is not
    /// automatic. Add the new layer with the `Image.insertLayer`
    /// method.
    ///
    /// The arguments are kept as simple as necessary for the basic case.
    /// All text attributes, however, can be modified with the appropriate
    /// `gimp_text_layer_set_*()` procedures.
    extern fn gimp_text_layer_new(p_image: *gimp.Image, p_text: [*:0]const u8, p_font: *gimp.Font, p_size: f64, p_unit: *gimp.Unit) *gimp.TextLayer;
    pub const new = gimp_text_layer_new;

    /// Check if antialiasing is used in the text layer.
    ///
    /// This procedure checks if antialiasing is enabled in the specified
    /// text layer.
    extern fn gimp_text_layer_get_antialias(p_layer: *TextLayer) c_int;
    pub const getAntialias = gimp_text_layer_get_antialias;

    /// Get the base direction used for rendering the text layer.
    ///
    /// This procedure returns the base direction used for rendering the
    /// text in the text layer
    extern fn gimp_text_layer_get_base_direction(p_layer: *TextLayer) gimp.TextDirection;
    pub const getBaseDirection = gimp_text_layer_get_base_direction;

    /// Get the color of the text in a text layer.
    ///
    /// This procedure returns the color of the text in a text layer.
    extern fn gimp_text_layer_get_color(p_layer: *TextLayer) *gegl.Color;
    pub const getColor = gimp_text_layer_get_color;

    /// Get the font from a text layer as string.
    ///
    /// This procedure returns the font from a text layer.
    extern fn gimp_text_layer_get_font(p_layer: *TextLayer) *gimp.Font;
    pub const getFont = gimp_text_layer_get_font;

    /// Get the font size from a text layer.
    ///
    /// This procedure returns the size of the font which is used in a text
    /// layer. You will receive the size as a double 'font-size' in 'unit'
    /// units.
    extern fn gimp_text_layer_get_font_size(p_layer: *TextLayer, p_unit: **gimp.Unit) f64;
    pub const getFontSize = gimp_text_layer_get_font_size;

    /// Get information about hinting in the specified text layer.
    ///
    /// This procedure provides information about the hinting that is being
    /// used in a text layer. Hinting can be optimized for fidelity or
    /// contrast or it can be turned entirely off.
    extern fn gimp_text_layer_get_hint_style(p_layer: *TextLayer) gimp.TextHintStyle;
    pub const getHintStyle = gimp_text_layer_get_hint_style;

    /// Get the line indentation of text layer.
    ///
    /// This procedure returns the indentation of the first line in a text
    /// layer.
    extern fn gimp_text_layer_get_indent(p_layer: *TextLayer) f64;
    pub const getIndent = gimp_text_layer_get_indent;

    /// Get the text justification information of the text layer.
    ///
    /// This procedure returns the alignment of the lines in the text layer
    /// relative to each other.
    extern fn gimp_text_layer_get_justification(p_layer: *TextLayer) gimp.TextJustification;
    pub const getJustification = gimp_text_layer_get_justification;

    /// Check if kerning is used in the text layer.
    ///
    /// This procedure checks if kerning is enabled in the specified text
    /// layer.
    extern fn gimp_text_layer_get_kerning(p_layer: *TextLayer) c_int;
    pub const getKerning = gimp_text_layer_get_kerning;

    /// Get the language used in the text layer.
    ///
    /// This procedure returns the language string which is set for the text
    /// in the text layer.
    extern fn gimp_text_layer_get_language(p_layer: *TextLayer) [*:0]u8;
    pub const getLanguage = gimp_text_layer_get_language;

    /// Get the letter spacing used in a text layer.
    ///
    /// This procedure returns the additional spacing between the single
    /// glyphs in a text layer.
    extern fn gimp_text_layer_get_letter_spacing(p_layer: *TextLayer) f64;
    pub const getLetterSpacing = gimp_text_layer_get_letter_spacing;

    /// Get the spacing between lines of text.
    ///
    /// This procedure returns the line-spacing between lines of text in a
    /// text layer.
    extern fn gimp_text_layer_get_line_spacing(p_layer: *TextLayer) f64;
    pub const getLineSpacing = gimp_text_layer_get_line_spacing;

    /// Get the markup from a text layer as string.
    ///
    /// This procedure returns the markup of the styles from a text layer.
    /// The markup will be in the form of Pango's markup - See
    /// https://www.pango.org/ for more information about Pango and its
    /// markup.
    extern fn gimp_text_layer_get_markup(p_layer: *TextLayer) [*:0]u8;
    pub const getMarkup = gimp_text_layer_get_markup;

    /// Get the text from a text layer as string.
    ///
    /// This procedure returns the text from a text layer as a string.
    extern fn gimp_text_layer_get_text(p_layer: *TextLayer) [*:0]u8;
    pub const getText = gimp_text_layer_get_text;

    /// Resize the box of a text layer.
    ///
    /// This procedure changes the width and height of a text layer while
    /// keeping it as a text layer and not converting it to a bitmap like
    /// `gimp.Layer.resize` would do.
    extern fn gimp_text_layer_resize(p_layer: *TextLayer, p_width: f64, p_height: f64) c_int;
    pub const resize = gimp_text_layer_resize;

    /// Enable/disable anti-aliasing in a text layer.
    ///
    /// This procedure enables or disables anti-aliasing of the text in a
    /// text layer.
    extern fn gimp_text_layer_set_antialias(p_layer: *TextLayer, p_antialias: c_int) c_int;
    pub const setAntialias = gimp_text_layer_set_antialias;

    /// Set the base direction in the text layer.
    ///
    /// This procedure sets the base direction used in applying the Unicode
    /// bidirectional algorithm when rendering the text.
    extern fn gimp_text_layer_set_base_direction(p_layer: *TextLayer, p_direction: gimp.TextDirection) c_int;
    pub const setBaseDirection = gimp_text_layer_set_base_direction;

    /// Set the color of the text in the text layer.
    ///
    /// This procedure sets the text color in the text layer 'layer'.
    extern fn gimp_text_layer_set_color(p_layer: *TextLayer, p_color: *gegl.Color) c_int;
    pub const setColor = gimp_text_layer_set_color;

    /// Set the font of a text layer.
    ///
    /// This procedure modifies the font used in the specified text layer.
    extern fn gimp_text_layer_set_font(p_layer: *TextLayer, p_font: *gimp.Font) c_int;
    pub const setFont = gimp_text_layer_set_font;

    /// Set the font size.
    ///
    /// This procedure changes the font size of a text layer. The size of
    /// your font will be a double 'font-size' of 'unit' units.
    extern fn gimp_text_layer_set_font_size(p_layer: *TextLayer, p_font_size: f64, p_unit: *gimp.Unit) c_int;
    pub const setFontSize = gimp_text_layer_set_font_size;

    /// Control how font outlines are hinted in a text layer.
    ///
    /// This procedure sets the hint style for font outlines in a text
    /// layer. This controls whether to fit font outlines to the pixel grid,
    /// and if so, whether to optimize for fidelity or contrast.
    extern fn gimp_text_layer_set_hint_style(p_layer: *TextLayer, p_style: gimp.TextHintStyle) c_int;
    pub const setHintStyle = gimp_text_layer_set_hint_style;

    /// Set the indentation of the first line in a text layer.
    ///
    /// This procedure sets the indentation of the first line in the text
    /// layer.
    extern fn gimp_text_layer_set_indent(p_layer: *TextLayer, p_indent: f64) c_int;
    pub const setIndent = gimp_text_layer_set_indent;

    /// Set the justification of the text in a text layer.
    ///
    /// This procedure sets the alignment of the lines in the text layer
    /// relative to each other.
    extern fn gimp_text_layer_set_justification(p_layer: *TextLayer, p_justify: gimp.TextJustification) c_int;
    pub const setJustification = gimp_text_layer_set_justification;

    /// Enable/disable kerning in a text layer.
    ///
    /// This procedure enables or disables kerning in a text layer.
    extern fn gimp_text_layer_set_kerning(p_layer: *TextLayer, p_kerning: c_int) c_int;
    pub const setKerning = gimp_text_layer_set_kerning;

    /// Set the language of the text layer.
    ///
    /// This procedure sets the language of the text in text layer. For some
    /// scripts the language has an influence of how the text is rendered.
    extern fn gimp_text_layer_set_language(p_layer: *TextLayer, p_language: [*:0]const u8) c_int;
    pub const setLanguage = gimp_text_layer_set_language;

    /// Adjust the letter spacing in a text layer.
    ///
    /// This procedure sets the additional spacing between the single glyphs
    /// in a text layer.
    extern fn gimp_text_layer_set_letter_spacing(p_layer: *TextLayer, p_letter_spacing: f64) c_int;
    pub const setLetterSpacing = gimp_text_layer_set_letter_spacing;

    /// Adjust the line spacing in a text layer.
    ///
    /// This procedure sets the additional spacing used between lines a text
    /// layer.
    extern fn gimp_text_layer_set_line_spacing(p_layer: *TextLayer, p_line_spacing: f64) c_int;
    pub const setLineSpacing = gimp_text_layer_set_line_spacing;

    /// Set the markup for a text layer from a string.
    ///
    /// This procedure sets the markup of the styles for a text layer. The
    /// markup should be in the form of Pango's markup - See
    /// https://docs.gtk.org/Pango/pango_markup.html for a reference.
    /// Note that GIMP's text tool does not support all of Pango markup. Any
    /// unsupported markup will still be applied to your text layer, yet
    /// would be dropped as soon as you edit text with the tool.
    extern fn gimp_text_layer_set_markup(p_layer: *TextLayer, p_markup: [*:0]const u8) c_int;
    pub const setMarkup = gimp_text_layer_set_markup;

    /// Set the text of a text layer.
    ///
    /// This procedure changes the text of a text layer.
    extern fn gimp_text_layer_set_text(p_layer: *TextLayer, p_text: [*:0]const u8) c_int;
    pub const setText = gimp_text_layer_set_text;

    extern fn gimp_text_layer_get_type() usize;
    pub const getGObjectType = gimp_text_layer_get_type;

    extern fn g_object_ref(p_self: *gimp.TextLayer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.TextLayer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TextLayer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ThumbnailProcedure = opaque {
    pub const Parent = gimp.Procedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.ThumbnailProcedureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new thumbnail procedure named `name` which will call `run_func`
    /// when invoked.
    ///
    /// See `gimp.Procedure.new` for information about `proc_type`.
    ///
    /// `gimp.ThumbnailProcedure` is a `gimp.Procedure` subclass that makes it easier
    /// to write file thumbnail procedures.
    ///
    /// It automatically adds the standard
    ///
    /// (`gio.File`, size)
    ///
    /// arguments and the standard
    ///
    /// (`gimp.Image`, image-width, image-height, `gimp.ImageType`, num-layers)
    ///
    /// return value of a thumbnail procedure. It is possible to add
    /// additional arguments.
    ///
    /// When invoked via `gimp.Procedure.run`, it unpacks these standard
    /// arguments and calls `run_func` which is a `gimp.RunThumbnailFunc`. The
    /// "args" `gimp.ValueArray` of `gimp.RunThumbnailFunc` only contains
    /// additionally added arguments.
    ///
    /// `gimp.RunThumbnailFunc` must `gimp.ValueArray.truncate` the returned
    /// `gimp.ValueArray` to the number of return values it actually uses.
    extern fn gimp_thumbnail_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_run_func: gimp.RunThumbnailFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.ThumbnailProcedure;
    pub const new = gimp_thumbnail_procedure_new;

    extern fn gimp_thumbnail_procedure_get_type() usize;
    pub const getGObjectType = gimp_thumbnail_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.ThumbnailProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ThumbnailProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ThumbnailProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Provides operations on units, a collection of predefined units and
/// functions to create new units.
pub const Unit = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimp.UnitClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const abbreviation = struct {
            pub const name = "abbreviation";

            pub const Type = ?[*:0]u8;
        };

        pub const digits = struct {
            pub const name = "digits";

            pub const Type = c_int;
        };

        pub const factor = struct {
            pub const name = "factor";

            pub const Type = f64;
        };

        pub const id = struct {
            pub const name = "id";

            pub const Type = c_int;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const symbol = struct {
            pub const name = "symbol";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// The `format` string supports the following percent expansions:
    ///
    /// * ``n``: Name (long label)
    /// * ``a``: Abbreviation (short label)
    /// * `%%`: Literal percent
    /// * ``f``: Factor (how many units make up an inch)
    /// * ``y``: Symbol (e.g. `''` for `GIMP_UNIT_INCH`)
    extern fn gimp_unit_format_string(p_format: [*:0]const u8, p_unit: *gimp.Unit) [*:0]u8;
    pub const formatString = gimp_unit_format_string;

    /// Returns the unique `Unit` object corresponding to `unit_id`,
    /// which is the integer identifier as returned by `Unit.getId`.
    extern fn gimp_unit_get_by_id(p_unit_id: c_int) *gimp.Unit;
    pub const getById = gimp_unit_get_by_id;

    /// Returns the unique object representing inch unit.
    ///
    /// This procedure returns the unit representing inch. The returned
    /// object is unique across the whole run.
    extern fn gimp_unit_inch() *gimp.Unit;
    pub const inch = gimp_unit_inch;

    /// Returns the unique object representing millimeter unit.
    ///
    /// This procedure returns the unit representing millimeter. The
    /// returned object is unique across the whole run.
    extern fn gimp_unit_mm() *gimp.Unit;
    pub const mm = gimp_unit_mm;

    /// Returns the unique object representing percent dimensions relatively
    /// to an image.
    ///
    /// This procedure returns the unit representing typographical points.
    /// The returned object is unique across the whole run.
    extern fn gimp_unit_percent() *gimp.Unit;
    pub const percent = gimp_unit_percent;

    /// Returns the unique object representing Pica unit.
    ///
    /// This procedure returns the unit representing Picas.
    /// The returned object is unique across the whole run.
    extern fn gimp_unit_pica() *gimp.Unit;
    pub const pica = gimp_unit_pica;

    /// Returns the unique object representing pixel unit.
    ///
    /// This procedure returns the unit representing pixel. The returned
    /// object is unique across the whole run.
    extern fn gimp_unit_pixel() *gimp.Unit;
    pub const pixel = gimp_unit_pixel;

    /// Returns the unique object representing typographical point unit.
    ///
    /// This procedure returns the unit representing typographical points.
    /// The returned object is unique across the whole run.
    extern fn gimp_unit_point() *gimp.Unit;
    pub const point = gimp_unit_point;

    /// Creates a new unit.
    ///
    /// This procedure creates a new unit and returns it. Note that the new
    /// unit will have it's deletion flag set to TRUE, so you will have to
    /// set it to FALSE with `gimp.Unit.setDeletionFlag` to make it
    /// persistent.
    extern fn gimp_unit_new(p_name: [*:0]const u8, p_factor: f64, p_digits: c_int, p_symbol: [*:0]const u8, p_abbreviation: [*:0]const u8) *gimp.Unit;
    pub const new = gimp_unit_new;

    /// This function returns the abbreviation of the unit (e.g. "in" for
    /// inches).
    /// It can be used as a short label for the unit in the interface.
    /// For long labels, use `Unit.getName`.
    ///
    /// NOTE: This string must not be changed or freed.
    extern fn gimp_unit_get_abbreviation(p_unit: *Unit) [*:0]const u8;
    pub const getAbbreviation = gimp_unit_get_abbreviation;

    extern fn gimp_unit_get_deletion_flag(p_unit: *Unit) c_int;
    pub const getDeletionFlag = gimp_unit_get_deletion_flag;

    /// Returns the number of digits set for `unit`.
    /// Built-in units' accuracy is approximately the same as an inch with
    /// two digits. User-defined units can suggest a different accuracy.
    ///
    /// Note: the value is as-set by defaults or by the user and does not
    /// necessary provide enough precision on high-resolution units.
    /// When the information is needed for a specific unit, the use of
    /// `gimp.Unit.getScaledDigits` may be more appropriate.
    ///
    /// Returns 0 for `unit` == GIMP_UNIT_PIXEL.
    extern fn gimp_unit_get_digits(p_unit: *Unit) c_int;
    pub const getDigits = gimp_unit_get_digits;

    /// A `gimp.Unit`'s `factor` is defined to be:
    ///
    /// distance_in_units == (`factor` * distance_in_inches)
    ///
    /// Returns 0 for `unit` == GIMP_UNIT_PIXEL.
    extern fn gimp_unit_get_factor(p_unit: *Unit) f64;
    pub const getFactor = gimp_unit_get_factor;

    /// The ID can be used to retrieve the unit with `Unit.getById`.
    ///
    /// Note that this ID will be stable within a single session of GIMP, but
    /// you should not expect this ID to stay the same across multiple runs.
    extern fn gimp_unit_get_id(p_unit: *Unit) i32;
    pub const getId = gimp_unit_get_id;

    /// This function returns the usual name of the unit (e.g. "inches").
    /// It can be used as the long label for the unit in the interface.
    /// For short labels, use `Unit.getAbbreviation`.
    ///
    /// NOTE: This string must not be changed or freed.
    extern fn gimp_unit_get_name(p_unit: *Unit) [*:0]const u8;
    pub const getName = gimp_unit_get_name;

    /// Returns the number of digits a `unit` field should provide to get
    /// enough accuracy so that every pixel position shows a different
    /// value from neighboring pixels.
    ///
    /// Note: when needing digit accuracy to display a diagonal distance,
    /// the `resolution` may not correspond to the unit's horizontal or
    /// vertical resolution, but instead to the result of:
    /// `distance_in_pixel / distance_in_inch`.
    extern fn gimp_unit_get_scaled_digits(p_unit: *Unit, p_resolution: f64) c_int;
    pub const getScaledDigits = gimp_unit_get_scaled_digits;

    /// This is e.g. "''" for UNIT_INCH.
    ///
    /// NOTE: This string must not be changed or freed.
    extern fn gimp_unit_get_symbol(p_unit: *Unit) [*:0]const u8;
    pub const getSymbol = gimp_unit_get_symbol;

    /// Returns whether the unit is built-in.
    ///
    /// This procedure returns `unit` is a built-in unit. In particular the
    /// deletion flag cannot be set on built-in units.
    extern fn gimp_unit_is_built_in(p_unit: *Unit) c_int;
    pub const isBuiltIn = gimp_unit_is_built_in;

    /// Checks if the given `unit` is metric. A simplistic test is used
    /// that looks at the unit's factor and checks if it is 2.54 multiplied
    /// by some common powers of 10. Currently it checks for mm, cm, dm, m.
    ///
    /// See also: `gimp.Unit.getFactor`
    extern fn gimp_unit_is_metric(p_unit: *Unit) c_int;
    pub const isMetric = gimp_unit_is_metric;

    /// Sets a `gimp.Unit`'s `deletion_flag`. If the `deletion_flag` of a unit is
    /// `TRUE` when GIMP exits, this unit will not be saved in the users's
    /// "unitrc" file.
    ///
    /// Trying to change the `deletion_flag` of a built-in unit will be silently
    /// ignored.
    extern fn gimp_unit_set_deletion_flag(p_unit: *Unit, p_deletion_flag: c_int) void;
    pub const setDeletionFlag = gimp_unit_set_deletion_flag;

    extern fn gimp_unit_get_type() usize;
    pub const getGObjectType = gimp_unit_get_type;

    extern fn g_object_ref(p_self: *gimp.Unit) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.Unit) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Unit, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `Procedure` subclass that makes it easier to write load procedures
/// for vector image formats.
///
/// It automatically adds the standard arguments:
/// (`RunMode`, `gio.File`, int width, int height)
///
/// and the standard return value: ( `Image` )
///
/// It is possible to add additional arguments.
///
/// When invoked via `Procedure.run`, it unpacks these standard
/// arguments and calls `run_func` which is a `RunImageFunc`. The
/// `ProcedureConfig` of `gimp.RunVectorLoadFunc` contains
/// additionally added arguments but also the arguments added by this class.
pub const VectorLoadProcedure = opaque {
    pub const Parent = gimp.LoadProcedure;
    pub const Implements = [_]type{};
    pub const Class = gimp.VectorLoadProcedureClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new load procedure named `name` which will call `run_func`
    /// when invoked.
    ///
    /// See `gimp.Procedure.new` for information about `proc_type`.
    extern fn gimp_vector_load_procedure_new(p_plug_in: *gimp.PlugIn, p_name: [*:0]const u8, p_proc_type: gimp.PDBProcType, p_extract_func: gimp.ExtractVectorFunc, p_extract_data: ?*anyopaque, p_extract_data_destroy: ?glib.DestroyNotify, p_run_func: gimp.RunVectorLoadFunc, p_run_data: ?*anyopaque, p_run_data_destroy: ?glib.DestroyNotify) *gimp.VectorLoadProcedure;
    pub const new = gimp_vector_load_procedure_new;

    /// Extracts native or suggested dimensions from `file`, which must be a vector
    /// file in the right format supported by `procedure`. It is considered a
    /// programming error to pass a file of invalid format.
    extern fn gimp_vector_load_procedure_extract_dimensions(p_procedure: *VectorLoadProcedure, p_file: *gio.File, p_data: *gimp.VectorLoadData, p_error: ?*?*glib.Error) c_int;
    pub const extractDimensions = gimp_vector_load_procedure_extract_dimensions;

    extern fn gimp_vector_load_procedure_get_type() usize;
    pub const getGObjectType = gimp_vector_load_procedure_get_type;

    extern fn g_object_ref(p_self: *gimp.VectorLoadProcedure) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.VectorLoadProcedure) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VectorLoadProcedure, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An interface dealing with color profiles.
pub const ColorManaged = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = gimp.ColorManagedInterface;
    pub const virtual_methods = struct {
        /// This function always returns a `gimp.ColorProfile` and falls back to
        /// `gimp.ColorProfile.newRgbSrgb` if the method is not implemented.
        pub const get_color_profile = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gimp.ColorProfile {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_get_color_profile.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gimp.ColorProfile) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_get_color_profile = @ptrCast(p_implementation);
            }
        };

        pub const get_icc_profile = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_len: *usize) [*]const u8 {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_get_icc_profile.?(gobject.ext.as(ColorManaged, p_managed), p_len);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_len: *usize) callconv(.c) [*]const u8) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_get_icc_profile = @ptrCast(p_implementation);
            }
        };

        /// This function always returns a gboolean representing whether
        /// Black Point Compensation is enabled
        pub const get_simulation_bpc = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_bpc.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_bpc = @ptrCast(p_implementation);
            }
        };

        /// This function always returns a `gimp.ColorRenderingIntent`
        pub const get_simulation_intent = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) gimp.ColorRenderingIntent {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_intent.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) gimp.ColorRenderingIntent) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_intent = @ptrCast(p_implementation);
            }
        };

        /// This function always returns a `gimp.ColorProfile`
        pub const get_simulation_profile = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gimp.ColorProfile {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_profile.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gimp.ColorProfile) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_get_simulation_profile = @ptrCast(p_implementation);
            }
        };

        /// Emits the "profile-changed" signal.
        pub const profile_changed = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_profile_changed.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_profile_changed = @ptrCast(p_implementation);
            }
        };

        /// Emits the "simulation-bpc-changed" signal.
        pub const simulation_bpc_changed = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_bpc_changed.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_bpc_changed = @ptrCast(p_implementation);
            }
        };

        /// Emits the "simulation-intent-changed" signal.
        pub const simulation_intent_changed = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_intent_changed.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_intent_changed = @ptrCast(p_implementation);
            }
        };

        /// Emits the "simulation-profile-changed" signal.
        pub const simulation_profile_changed = struct {
            pub fn call(p_class: anytype, p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_profile_changed.?(gobject.ext.as(ColorManaged, p_managed));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_managed: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorManaged.Iface, p_class).f_simulation_profile_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const profile_changed = struct {
            pub const name = "profile-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorManaged, p_instance))),
                    gobject.signalLookup("profile-changed", ColorManaged.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const simulation_bpc_changed = struct {
            pub const name = "simulation-bpc-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorManaged, p_instance))),
                    gobject.signalLookup("simulation-bpc-changed", ColorManaged.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const simulation_intent_changed = struct {
            pub const name = "simulation-intent-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorManaged, p_instance))),
                    gobject.signalLookup("simulation-intent-changed", ColorManaged.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const simulation_profile_changed = struct {
            pub const name = "simulation-profile-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorManaged, p_instance))),
                    gobject.signalLookup("simulation-profile-changed", ColorManaged.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This function always returns a `gimp.ColorProfile` and falls back to
    /// `gimp.ColorProfile.newRgbSrgb` if the method is not implemented.
    extern fn gimp_color_managed_get_color_profile(p_managed: *ColorManaged) *gimp.ColorProfile;
    pub const getColorProfile = gimp_color_managed_get_color_profile;

    extern fn gimp_color_managed_get_icc_profile(p_managed: *ColorManaged, p_len: *usize) [*]const u8;
    pub const getIccProfile = gimp_color_managed_get_icc_profile;

    /// This function always returns a gboolean representing whether
    /// Black Point Compensation is enabled
    extern fn gimp_color_managed_get_simulation_bpc(p_managed: *ColorManaged) c_int;
    pub const getSimulationBpc = gimp_color_managed_get_simulation_bpc;

    /// This function always returns a `gimp.ColorRenderingIntent`
    extern fn gimp_color_managed_get_simulation_intent(p_managed: *ColorManaged) gimp.ColorRenderingIntent;
    pub const getSimulationIntent = gimp_color_managed_get_simulation_intent;

    /// This function always returns a `gimp.ColorProfile`
    extern fn gimp_color_managed_get_simulation_profile(p_managed: *ColorManaged) *gimp.ColorProfile;
    pub const getSimulationProfile = gimp_color_managed_get_simulation_profile;

    /// Emits the "profile-changed" signal.
    extern fn gimp_color_managed_profile_changed(p_managed: *ColorManaged) void;
    pub const profileChanged = gimp_color_managed_profile_changed;

    /// Emits the "simulation-bpc-changed" signal.
    extern fn gimp_color_managed_simulation_bpc_changed(p_managed: *ColorManaged) void;
    pub const simulationBpcChanged = gimp_color_managed_simulation_bpc_changed;

    /// Emits the "simulation-intent-changed" signal.
    extern fn gimp_color_managed_simulation_intent_changed(p_managed: *ColorManaged) void;
    pub const simulationIntentChanged = gimp_color_managed_simulation_intent_changed;

    /// Emits the "simulation-profile-changed" signal.
    extern fn gimp_color_managed_simulation_profile_changed(p_managed: *ColorManaged) void;
    pub const simulationProfileChanged = gimp_color_managed_simulation_profile_changed;

    extern fn gimp_color_managed_get_type() usize;
    pub const getGObjectType = gimp_color_managed_get_type;

    extern fn g_object_ref(p_self: *gimp.ColorManaged) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ColorManaged) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorManaged, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ConfigInterface = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = ConfigInterface;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a search path as it is used in the gimprc file.  The path
    /// returned by `gimp.configBuildDataPath` includes a directory
    /// below the user's gimp directory and one in the system-wide data
    /// directory.
    ///
    /// Note that you cannot use this path directly with `gimp.Path.parse`.
    /// As it is in the gimprc notation, you first need to expand and
    /// recode it using `gimp.ConfigPath.expand`.
    extern fn gimp_config_build_data_path(p_name: [*:0]const u8) [*:0]u8;
    pub const buildDataPath = gimp_config_build_data_path;

    /// Creates a search path as it is used in the gimprc file.  The path
    /// returned by `gimp.configBuildPlugInPath` includes a directory
    /// below the user's gimp directory and one in the system-wide plug-in
    /// directory.
    ///
    /// Note that you cannot use this path directly with `gimp.Path.parse`.
    /// As it is in the gimprc notation, you first need to expand and
    /// recode it using `gimp.ConfigPath.expand`.
    extern fn gimp_config_build_plug_in_path(p_name: [*:0]const u8) [*:0]u8;
    pub const buildPlugInPath = gimp_config_build_plug_in_path;

    /// Creates a search path as it is used in the gimprc file.  The path
    /// returned by `gimp.configBuildSystemPath` is just the read-only
    /// parts of the search path constructed by `gimp.configBuildPlugInPath`.
    ///
    /// Note that you cannot use this path directly with `gimp.Path.parse`.
    /// As it is in the gimprc notation, you first need to expand and
    /// recode it using `gimp.ConfigPath.expand`.
    extern fn gimp_config_build_system_path(p_name: [*:0]const u8) [*:0]u8;
    pub const buildSystemPath = gimp_config_build_system_path;

    /// Creates a search path as it is used in the gimprc file.  The path
    /// returned by `gimp.configBuildWritablePath` is just the writable
    /// parts of the search path constructed by `gimp.configBuildDataPath`.
    ///
    /// Note that you cannot use this path directly with `gimp.Path.parse`.
    /// As it is in the gimprc notation, you first need to expand and
    /// recode it using `gimp.ConfigPath.expand`.
    extern fn gimp_config_build_writable_path(p_name: [*:0]const u8) [*:0]u8;
    pub const buildWritablePath = gimp_config_build_writable_path;

    extern fn gimp_config_deserialize_return(p_scanner: *glib.Scanner, p_expected_token: glib.TokenType, p_nest_level: c_int) c_int;
    pub const deserializeReturn = gimp_config_deserialize_return;

    /// Compares all properties of `a` and `b` that have all `flags` set. If
    /// `flags` is 0, all properties are compared.
    ///
    /// If the two objects are not of the same type, only properties that
    /// exist in both object classes and are of the same value_type are
    /// compared.
    extern fn gimp_config_diff(p_a: *gobject.Object, p_b: *gobject.Object, p_flags: gobject.ParamFlags) *glib.List;
    pub const diff = gimp_config_diff;

    /// This function is never called directly. Use `GIMP_CONFIG_ERROR` instead.
    extern fn gimp_config_error_quark() glib.Quark;
    pub const errorQuark = gimp_config_error_quark;

    /// Creates an exact copy of `pspec`, with all its properties, returns
    /// `NULL` if `pspec` is of an unknown type that can't be duplicated.
    extern fn gimp_config_param_spec_duplicate(p_pspec: *gobject.ParamSpec) *gobject.ParamSpec;
    pub const paramSpecDuplicate = gimp_config_param_spec_duplicate;

    /// Resets all writable properties of `object` to the default values as
    /// defined in their `gobject.ParamSpec`. Properties marked as "construct-only"
    /// are not touched.
    ///
    /// If you want to reset a `gimp.Config` object, please use `gimp.Config.reset`.
    extern fn gimp_config_reset_properties(p_object: *gobject.Object) void;
    pub const resetProperties = gimp_config_reset_properties;

    /// Resets the property named `property_name` to its default value.  The
    /// property must be writable and must not be marked as "construct-only".
    extern fn gimp_config_reset_property(p_object: *gobject.Object, p_property_name: [*:0]const u8) void;
    pub const resetProperty = gimp_config_reset_property;

    /// This utility function appends a string representation of `gobject.Value` to `str`.
    extern fn gimp_config_serialize_value(p_value: *const gobject.Value, p_str: *glib.String, p_escaped: c_int) c_int;
    pub const serializeValue = gimp_config_serialize_value;

    /// Escapes and quotes `val` and appends it to `string`. The escape
    /// algorithm is different from the one used by `glib.strescape` since it
    /// leaves non-ASCII characters intact and thus preserves UTF-8
    /// strings. Only control characters and quotes are being escaped.
    extern fn gimp_config_string_append_escaped(p_string: *glib.String, p_val: [*:0]const u8) void;
    pub const stringAppendEscaped = gimp_config_string_append_escaped;

    /// Compares all read- and write-able properties from `src` and `dest`
    /// that have all `flags` set. Differing values are then copied from
    /// `src` to `dest`. If `flags` is 0, all differing read/write properties.
    ///
    /// Properties marked as "construct-only" are not touched.
    ///
    /// If the two objects are not of the same type, only properties that
    /// exist in both object classes and are of the same value_type are
    /// synchronized
    extern fn gimp_config_sync(p_src: *gobject.Object, p_dest: *gobject.Object, p_flags: gobject.ParamFlags) c_int;
    pub const sync = gimp_config_sync;

    /// This function is a fancy wrapper around `gobject.typeRegisterStatic`.
    /// It creates a new object type as subclass of `parent_type`, installs
    /// `pspecs` on it and makes the new type implement the `gimp.Config`
    /// interface.
    extern fn gimp_config_type_register(p_parent_type: usize, p_type_name: [*:0]const u8, p_pspecs: [*]*gobject.ParamSpec, p_n_pspecs: c_int) usize;
    pub const typeRegister = gimp_config_type_register;

    extern fn gimp_config_get_type() usize;
    pub const getGObjectType = gimp_config_get_type;

    extern fn g_object_ref(p_self: *gimp.ConfigInterface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimp.ConfigInterface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ConfigInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Array = extern struct {
    /// pointer to the array's data.
    f_data: ?[*]u8,
    /// length of `data`, in bytes.
    f_length: usize,
    /// whether `data` points to statically allocated memory.
    f_static_data: c_int,

    extern fn gimp_array_new(p_data: [*]const u8, p_length: usize, p_static_data: c_int) *gimp.Array;
    pub const new = gimp_array_new;

    extern fn gimp_array_copy(p_array: *const Array) *gimp.Array;
    pub const copy = gimp_array_copy;

    extern fn gimp_array_free(p_array: *Array) void;
    pub const free = gimp_array_free;

    extern fn gimp_array_get_type() usize;
    pub const getGObjectType = gimp_array_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BatchProcedureClass = extern struct {
    pub const Instance = gimp.BatchProcedure;

    f_parent_class: gimp.ProcedureClass,

    pub fn as(p_instance: *BatchProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BrushClass = extern struct {
    pub const Instance = gimp.Brush;

    f_parent_class: gimp.ResourceClass,

    pub fn as(p_instance: *BrushClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChannelClass = extern struct {
    pub const Instance = gimp.Channel;

    f_parent_class: gimp.DrawableClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ChannelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChoiceClass = extern struct {
    pub const Instance = gimp.Choice;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ChoiceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorConfigClass = extern struct {
    pub const Instance = gimp.ColorConfig;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColorConfigClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorManagedInterface = extern struct {
    pub const Instance = gimp.ColorManaged;

    /// The parent interface
    f_base_iface: gobject.TypeInterface,
    /// Returns the ICC profile of the pixels managed by
    ///                   the object
    f_get_icc_profile: ?*const fn (p_managed: *gimp.ColorManaged, p_len: *usize) callconv(.c) [*]const u8,
    /// This signal is emitted when the object's color profile
    ///                   has changed
    f_profile_changed: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) void,
    f_simulation_profile_changed: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) void,
    f_simulation_intent_changed: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) void,
    f_simulation_bpc_changed: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) void,
    /// Returns the `gimp.ColorProfile` of the pixels managed
    ///                     by the object
    f_get_color_profile: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) *gimp.ColorProfile,
    /// Returns the simulation `gimp.ColorProfile` of the
    ///                          pixels managed by the object
    f_get_simulation_profile: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) *gimp.ColorProfile,
    f_get_simulation_intent: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) gimp.ColorRenderingIntent,
    /// Returns whether black point compensation is enabled for the
    ///                      simulation of the pixels managed by the object
    f_get_simulation_bpc: ?*const fn (p_managed: *gimp.ColorManaged) callconv(.c) c_int,

    pub fn as(p_instance: *ColorManagedInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorProfileClass = extern struct {
    pub const Instance = gimp.ColorProfile;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColorProfileClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorTransformClass = extern struct {
    pub const Instance = gimp.ColorTransform;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColorTransformClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Config = opaque {
    /// Compares all read- and write-able properties from `src` and `dest`
    /// that have all `flags` set. Differing values are then copied from
    /// `src` to `dest`. If `flags` is 0, all differing read/write properties.
    ///
    /// Properties marked as "construct-only" are not touched.
    extern fn gimp_config_copy(p_src: *Config, p_dest: *gimp.Config, p_flags: gobject.ParamFlags) c_int;
    pub const copy = gimp_config_copy;

    /// Deserialize the `gimp.Config` object.
    extern fn gimp_config_deserialize(p_config: *Config, p_scanner: *glib.Scanner, p_nest_level: c_int, p_data: ?*anyopaque) c_int;
    pub const deserialize = gimp_config_deserialize;

    /// Opens the file specified by `file`, reads configuration data from it
    /// and configures `config` accordingly. Basically this function creates
    /// a properly configured `glib.Scanner` for you and calls the deserialize
    /// function of the `config`'s `ConfigInterface`.
    extern fn gimp_config_deserialize_file(p_config: *Config, p_file: *gio.File, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const deserializeFile = gimp_config_deserialize_file;

    /// Configures `config` from `parasite`. Basically this function creates
    /// a properly configured `glib.Scanner` for you and calls the deserialize
    /// function of the `config`'s `gimp.ConfigInterface`.
    extern fn gimp_config_deserialize_parasite(p_config: *Config, p_parasite: *const gimp.Parasite, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const deserializeParasite = gimp_config_deserialize_parasite;

    /// This function uses the `scanner` to configure the properties of `config`.
    extern fn gimp_config_deserialize_properties(p_config: *Config, p_scanner: *glib.Scanner, p_nest_level: c_int) c_int;
    pub const deserializeProperties = gimp_config_deserialize_properties;

    /// This function deserializes a single property of `config`. You
    /// shouldn't need to call this function directly. If possible, use
    /// `gimp.Config.deserializeProperties` instead.
    extern fn gimp_config_deserialize_property(p_config: *Config, p_scanner: *glib.Scanner, p_nest_level: c_int) glib.TokenType;
    pub const deserializeProperty = gimp_config_deserialize_property;

    /// Reads configuration data from `input` and configures `config`
    /// accordingly. Basically this function creates a properly configured
    /// `glib.Scanner` for you and calls the deserialize function of the
    /// `config`'s `gimp.ConfigInterface`.
    extern fn gimp_config_deserialize_stream(p_config: *Config, p_input: *gio.InputStream, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const deserializeStream = gimp_config_deserialize_stream;

    /// Configures `config` from `text`. Basically this function creates a
    /// properly configured `glib.Scanner` for you and calls the deserialize
    /// function of the `config`'s `gimp.ConfigInterface`.
    extern fn gimp_config_deserialize_string(p_config: *Config, p_text: [*]const u8, p_text_len: c_int, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const deserializeString = gimp_config_deserialize_string;

    /// Creates a copy of the passed object by copying all object
    /// properties. The default implementation of the `gimp.ConfigInterface`
    /// only works for objects that are completely defined by their
    /// properties.
    extern fn gimp_config_duplicate(p_config: *Config) ?*anyopaque;
    pub const duplicate = gimp_config_duplicate;

    /// Compares the two objects. The default implementation of the
    /// `gimp.ConfigInterface` compares the object properties and thus only
    /// works for objects that are completely defined by their
    /// properties.
    extern fn gimp_config_is_equal_to(p_a: *Config, p_b: *gimp.Config) c_int;
    pub const isEqualTo = gimp_config_is_equal_to;

    /// Resets the object to its default state. The default implementation of the
    /// `gimp.ConfigInterface` only works for objects that are completely defined by
    /// their properties.
    extern fn gimp_config_reset(p_config: *Config) void;
    pub const reset = gimp_config_reset;

    /// Serialize the `gimp.Config` object.
    extern fn gimp_config_serialize(p_config: *Config, p_writer: *gimp.ConfigWriter, p_data: ?*anyopaque) c_int;
    pub const serialize = gimp_config_serialize;

    /// This function writes all object properties that have been changed from
    /// their default values to the `writer`.
    extern fn gimp_config_serialize_changed_properties(p_config: *Config, p_writer: *gimp.ConfigWriter) c_int;
    pub const serializeChangedProperties = gimp_config_serialize_changed_properties;

    /// This function writes all object properties to the `writer`.
    extern fn gimp_config_serialize_properties(p_config: *Config, p_writer: *gimp.ConfigWriter) c_int;
    pub const serializeProperties = gimp_config_serialize_properties;

    /// This function serializes a single object property to the `writer`.
    extern fn gimp_config_serialize_property(p_config: *Config, p_param_spec: *gobject.ParamSpec, p_writer: *gimp.ConfigWriter) c_int;
    pub const serializeProperty = gimp_config_serialize_property;

    /// This function serializes a single object property to the `writer`.
    extern fn gimp_config_serialize_property_by_name(p_config: *Config, p_prop_name: [*:0]const u8, p_writer: *gimp.ConfigWriter) c_int;
    pub const serializePropertyByName = gimp_config_serialize_property_by_name;

    /// Serializes the object properties of `config` to the given file
    /// descriptor.
    extern fn gimp_config_serialize_to_fd(p_config: *Config, p_fd: c_int, p_data: ?*anyopaque) c_int;
    pub const serializeToFd = gimp_config_serialize_to_fd;

    /// Serializes the object properties of `config` to the file specified
    /// by `file`. If a file with that name already exists, it is
    /// overwritten. Basically this function opens `file` for you and calls
    /// the serialize function of the `config`'s `ConfigInterface`.
    extern fn gimp_config_serialize_to_file(p_config: *Config, p_file: *gio.File, p_header: ?[*:0]const u8, p_footer: ?[*:0]const u8, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const serializeToFile = gimp_config_serialize_to_file;

    /// Serializes the object properties of `config` to a `Parasite`.
    extern fn gimp_config_serialize_to_parasite(p_config: *Config, p_parasite_name: [*:0]const u8, p_parasite_flags: c_uint, p_data: ?*anyopaque) *gimp.Parasite;
    pub const serializeToParasite = gimp_config_serialize_to_parasite;

    /// Serializes the object properties of `config` to the stream specified
    /// by `output`.
    extern fn gimp_config_serialize_to_stream(p_config: *Config, p_output: *gio.OutputStream, p_header: ?[*:0]const u8, p_footer: ?[*:0]const u8, p_data: ?*anyopaque, p_error: ?*?*glib.Error) c_int;
    pub const serializeToStream = gimp_config_serialize_to_stream;

    /// Serializes the object properties of `config` to a string.
    extern fn gimp_config_serialize_to_string(p_config: *Config, p_data: ?*anyopaque) [*:0]u8;
    pub const serializeToString = gimp_config_serialize_to_string;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions for writing config info to a file for libgimpconfig.
pub const ConfigWriter = opaque {
    extern fn gimp_config_writer_new_from_fd(p_fd: c_int) ?*gimp.ConfigWriter;
    pub const newFromFd = gimp_config_writer_new_from_fd;

    /// Creates a new `gimp.ConfigWriter` and sets it up to write to
    /// `file`. If `atomic` is `TRUE`, a temporary file is used to avoid
    /// possible race conditions. The temporary file is then moved to `file`
    /// when the writer is closed.
    extern fn gimp_config_writer_new_from_file(p_file: *gio.File, p_atomic: c_int, p_header: [*:0]const u8, p_error: ?*?*glib.Error) ?*gimp.ConfigWriter;
    pub const newFromFile = gimp_config_writer_new_from_file;

    /// Creates a new `gimp.ConfigWriter` and sets it up to write to
    /// `output`.
    extern fn gimp_config_writer_new_from_stream(p_output: *gio.OutputStream, p_header: [*:0]const u8, p_error: ?*?*glib.Error) ?*gimp.ConfigWriter;
    pub const newFromStream = gimp_config_writer_new_from_stream;

    extern fn gimp_config_writer_new_from_string(p_string: *glib.String) ?*gimp.ConfigWriter;
    pub const newFromString = gimp_config_writer_new_from_string;

    /// Closes an element opened with `gimp.ConfigWriter.open`.
    extern fn gimp_config_writer_close(p_writer: *ConfigWriter) void;
    pub const close = gimp_config_writer_close;

    /// Appends the `comment` to `str` and inserts linebreaks and hash-marks to
    /// format it as a comment. Note that this function does not handle non-ASCII
    /// characters.
    extern fn gimp_config_writer_comment(p_writer: *ConfigWriter, p_comment: [*:0]const u8) void;
    pub const comment = gimp_config_writer_comment;

    /// This function toggles whether the `writer` should create commented
    /// or uncommented output. This feature is used to generate the
    /// system-wide installed gimprc that documents the default settings.
    ///
    /// Since comments have to start at the beginning of a line, this
    /// function will insert a newline if necessary.
    extern fn gimp_config_writer_comment_mode(p_writer: *ConfigWriter, p_enable: c_int) void;
    pub const commentMode = gimp_config_writer_comment_mode;

    /// Writes data to `writer`.
    extern fn gimp_config_writer_data(p_writer: *ConfigWriter, p_length: c_int, p_data: [*]const u8) void;
    pub const data = gimp_config_writer_data;

    /// This function finishes the work of `writer` and unrefs it
    /// afterwards.  It closes all open elements, appends an optional
    /// comment and releases all resources allocated by `writer`.
    ///
    /// Using any function except `gimp.ConfigWriter.ref` or
    /// `gimp.ConfigWriter.unref` after this function is forbidden
    /// and will trigger warnings.
    extern fn gimp_config_writer_finish(p_writer: *ConfigWriter, p_footer: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const finish = gimp_config_writer_finish;

    /// Writes an identifier to `writer`. The `string` is *not* quoted and special
    /// characters are *not* escaped.
    extern fn gimp_config_writer_identifier(p_writer: *ConfigWriter, p_identifier: [*:0]const u8) void;
    pub const identifier = gimp_config_writer_identifier;

    extern fn gimp_config_writer_linefeed(p_writer: *ConfigWriter) void;
    pub const linefeed = gimp_config_writer_linefeed;

    /// This function writes the opening parenthesis followed by `name`.
    /// It also increases the indentation level and sets a mark that
    /// can be used by `gimp.ConfigWriter.revert`.
    extern fn gimp_config_writer_open(p_writer: *ConfigWriter, p_name: [*:0]const u8) void;
    pub const open = gimp_config_writer_open;

    /// Appends a space followed by `string` to the `writer`. Note that string
    /// must not contain any special characters that might need to be escaped.
    extern fn gimp_config_writer_print(p_writer: *ConfigWriter, p_string: [*:0]const u8, p_len: c_int) void;
    pub const print = gimp_config_writer_print;

    /// A printf-like function for `gimp.ConfigWriter`.
    extern fn gimp_config_writer_printf(p_writer: *ConfigWriter, p_format: [*:0]const u8, ...) void;
    pub const printf = gimp_config_writer_printf;

    /// Adds a reference to a `gimp.ConfigWriter`.
    extern fn gimp_config_writer_ref(p_writer: *ConfigWriter) *gimp.ConfigWriter;
    pub const ref = gimp_config_writer_ref;

    /// Reverts all changes to `writer` that were done since the last call
    /// to `gimp.ConfigWriter.open`. This can only work if you didn't call
    /// `gimp.ConfigWriter.close` yet.
    extern fn gimp_config_writer_revert(p_writer: *ConfigWriter) void;
    pub const revert = gimp_config_writer_revert;

    /// Writes a string value to `writer`. The `string` is quoted and special
    /// characters are escaped.
    extern fn gimp_config_writer_string(p_writer: *ConfigWriter, p_string: [*:0]const u8) void;
    pub const string = gimp_config_writer_string;

    /// Unref a `gimp.ConfigWriter`. If the reference count drops to zero, the
    /// writer is freed.
    ///
    /// Note that at least one of the references has to be dropped using
    /// `gimp.ConfigWriter.finish`.
    extern fn gimp_config_writer_unref(p_writer: *ConfigWriter) void;
    pub const unref = gimp_config_writer_unref;

    extern fn gimp_config_writer_get_type() usize;
    pub const getGObjectType = gimp_config_writer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DisplayClass = extern struct {
    pub const Instance = gimp.Display;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DisplayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawableClass = extern struct {
    pub const Instance = gimp.Drawable;

    f_parent_class: gimp.ItemClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *DrawableClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawableFilterClass = extern struct {
    pub const Instance = gimp.DrawableFilter;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *DrawableFilterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawableFilterConfigClass = extern struct {
    pub const Instance = gimp.DrawableFilterConfig;

    f_parent_class: gobject.ObjectClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *DrawableFilterConfigClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure is used to register translatable descriptions and
/// help texts for enum values. See `gimp.enumSetValueDescriptions`.
pub const EnumDesc = extern struct {
    /// An enum value.
    f_value: c_int,
    /// The value's description.
    f_value_desc: ?[*:0]const u8,
    /// The value's help text.
    f_value_help: ?[*:0]const u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExportOptionsClass = extern struct {
    pub const Instance = gimp.ExportOptions;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ExportOptionsClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExportProcedureClass = extern struct {
    pub const Instance = gimp.ExportProcedure;

    f_parent_class: gimp.FileProcedureClass,

    pub fn as(p_instance: *ExportProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileProcedureClass = extern struct {
    pub const Instance = gimp.FileProcedure;

    f_parent_class: gimp.ProcedureClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *FileProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure is used to register translatable descriptions and
/// help texts for flag values. See `gimp.flagsSetValueDescriptions`.
pub const FlagsDesc = extern struct {
    /// A flag value.
    f_value: c_uint,
    /// The value's description.
    f_value_desc: ?[*:0]const u8,
    /// The value's help text.
    f_value_help: ?[*:0]const u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontClass = extern struct {
    pub const Instance = gimp.Font;

    f_parent_class: gimp.ResourceClass,

    pub fn as(p_instance: *FontClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GradientClass = extern struct {
    pub const Instance = gimp.Gradient;

    f_parent_class: gimp.ResourceClass,

    pub fn as(p_instance: *GradientClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GroupLayerClass = extern struct {
    pub const Instance = gimp.GroupLayer;

    f_parent_class: gimp.LayerClass,

    pub fn as(p_instance: *GroupLayerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ImageClass = extern struct {
    pub const Instance = gimp.Image;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ImageClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ImageProcedureClass = extern struct {
    pub const Instance = gimp.ImageProcedure;

    f_parent_class: gimp.ProcedureClass,

    pub fn as(p_instance: *ImageProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ItemClass = extern struct {
    pub const Instance = gimp.Item;

    f_parent_class: gobject.ObjectClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ItemClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayerClass = extern struct {
    pub const Instance = gimp.Layer;

    f_parent_class: gimp.DrawableClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *LayerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayerMaskClass = extern struct {
    pub const Instance = gimp.LayerMask;

    f_parent_class: gimp.ChannelClass,

    pub fn as(p_instance: *LayerMaskClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LoadProcedureClass = extern struct {
    pub const Instance = gimp.LoadProcedure;

    f_parent_class: gimp.FileProcedureClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *LoadProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A two by two matrix.
pub const Matrix2 = extern struct {
    /// the coefficients
    f_coeff: [4]f64,

    /// Calculates the determinant of the given matrix.
    extern fn gimp_matrix2_determinant(p_matrix: *const Matrix2) f64;
    pub const determinant = gimp_matrix2_determinant;

    /// Sets the matrix to the identity matrix.
    extern fn gimp_matrix2_identity(p_matrix: *Matrix2) void;
    pub const identity = gimp_matrix2_identity;

    /// Inverts the given matrix.
    extern fn gimp_matrix2_invert(p_matrix: *Matrix2) void;
    pub const invert = gimp_matrix2_invert;

    /// Multiplies two matrices and puts the result into the second one.
    extern fn gimp_matrix2_mult(p_left: *const Matrix2, p_right: *gimp.Matrix2) void;
    pub const mult = gimp_matrix2_mult;

    /// Transforms a point in 2D as specified by the transformation matrix.
    extern fn gimp_matrix2_transform_point(p_matrix: *const Matrix2, p_x: f64, p_y: f64, p_newx: *f64, p_newy: *f64) void;
    pub const transformPoint = gimp_matrix2_transform_point;

    extern fn gimp_matrix2_get_type() usize;
    pub const getGObjectType = gimp_matrix2_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A three by three matrix.
pub const Matrix3 = extern struct {
    /// the coefficients
    f_coeff: [9]f64,

    /// Applies the affine transformation given by six values to `matrix`.
    /// The six values form define an affine transformation matrix as
    /// illustrated below:
    ///
    ///  ( a c e )
    ///  ( b d f )
    ///  ( 0 0 1 )
    extern fn gimp_matrix3_affine(p_matrix: *Matrix3, p_a: f64, p_b: f64, p_c: f64, p_d: f64, p_e: f64, p_f: f64) void;
    pub const affine = gimp_matrix3_affine;

    /// Calculates the determinant of the given matrix.
    extern fn gimp_matrix3_determinant(p_matrix: *const Matrix3) f64;
    pub const determinant = gimp_matrix3_determinant;

    /// Checks if two matrices are equal.
    extern fn gimp_matrix3_equal(p_matrix1: *const Matrix3, p_matrix2: *const gimp.Matrix3) c_int;
    pub const equal = gimp_matrix3_equal;

    /// Sets the matrix to the identity matrix.
    extern fn gimp_matrix3_identity(p_matrix: *Matrix3) void;
    pub const identity = gimp_matrix3_identity;

    /// Inverts the given matrix.
    extern fn gimp_matrix3_invert(p_matrix: *Matrix3) void;
    pub const invert = gimp_matrix3_invert;

    /// Checks if the given matrix defines an affine transformation.
    extern fn gimp_matrix3_is_affine(p_matrix: *const Matrix3) c_int;
    pub const isAffine = gimp_matrix3_is_affine;

    /// Checks if the given matrix is diagonal.
    extern fn gimp_matrix3_is_diagonal(p_matrix: *const Matrix3) c_int;
    pub const isDiagonal = gimp_matrix3_is_diagonal;

    /// Checks if the given matrix is the identity matrix.
    extern fn gimp_matrix3_is_identity(p_matrix: *const Matrix3) c_int;
    pub const isIdentity = gimp_matrix3_is_identity;

    /// Checks if we'll need to interpolate when applying this matrix as
    /// a transformation.
    extern fn gimp_matrix3_is_simple(p_matrix: *const Matrix3) c_int;
    pub const isSimple = gimp_matrix3_is_simple;

    /// Multiplies two matrices and puts the result into the second one.
    extern fn gimp_matrix3_mult(p_left: *const Matrix3, p_right: *gimp.Matrix3) void;
    pub const mult = gimp_matrix3_mult;

    /// Rotates the matrix by theta degrees.
    extern fn gimp_matrix3_rotate(p_matrix: *Matrix3, p_theta: f64) void;
    pub const rotate = gimp_matrix3_rotate;

    /// Scales the matrix by x and y
    extern fn gimp_matrix3_scale(p_matrix: *Matrix3, p_x: f64, p_y: f64) void;
    pub const scale = gimp_matrix3_scale;

    /// Transforms a point in 2D as specified by the transformation matrix.
    extern fn gimp_matrix3_transform_point(p_matrix: *const Matrix3, p_x: f64, p_y: f64, p_newx: *f64, p_newy: *f64) void;
    pub const transformPoint = gimp_matrix3_transform_point;

    /// Translates the matrix by x and y.
    extern fn gimp_matrix3_translate(p_matrix: *Matrix3, p_x: f64, p_y: f64) void;
    pub const translate = gimp_matrix3_translate;

    /// Shears the matrix in the X direction.
    extern fn gimp_matrix3_xshear(p_matrix: *Matrix3, p_amount: f64) void;
    pub const xshear = gimp_matrix3_xshear;

    /// Shears the matrix in the Y direction.
    extern fn gimp_matrix3_yshear(p_matrix: *Matrix3, p_amount: f64) void;
    pub const yshear = gimp_matrix3_yshear;

    extern fn gimp_matrix3_get_type() usize;
    pub const getGObjectType = gimp_matrix3_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A four by four matrix.
pub const Matrix4 = extern struct {
    /// the coefficients
    f_coeff: [16]f64,

    /// Sets the matrix to the identity matrix.
    extern fn gimp_matrix4_identity(p_matrix: *Matrix4) void;
    pub const identity = gimp_matrix4_identity;

    /// Multiplies two matrices and puts the result into the second one.
    extern fn gimp_matrix4_mult(p_left: *const Matrix4, p_right: *gimp.Matrix4) void;
    pub const mult = gimp_matrix4_mult;

    extern fn gimp_matrix4_to_deg(p_matrix: *const Matrix4, p_a: *f64, p_b: *f64, p_c: *f64) void;
    pub const toDeg = gimp_matrix4_to_deg;

    /// Transforms a point in 3D as specified by the transformation matrix.
    extern fn gimp_matrix4_transform_point(p_matrix: *const Matrix4, p_x: f64, p_y: f64, p_z: f64, p_newx: *f64, p_newy: *f64, p_newz: *f64) f64;
    pub const transformPoint = gimp_matrix4_transform_point;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataClass = extern struct {
    pub const Instance = gimp.Metadata;

    f_parent_class: @compileError("not enough type information available"),

    pub fn as(p_instance: *MetadataClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModuleClass = extern struct {
    pub const Instance = gimp.Module;

    f_parent_class: gobject.TypeModuleClass,
    f_modified: ?*const fn (p_module: *gimp.Module) callconv(.c) void,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ModuleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModuleDBClass = extern struct {
    pub const Instance = gimp.ModuleDB;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ModuleDBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure contains information about a loadable module.
pub const ModuleInfo = extern struct {
    /// The `GIMP_MODULE_ABI_VERSION` the module was compiled against.
    f_abi_version: u32,
    /// The module's general purpose.
    f_purpose: ?[*:0]u8,
    /// The module's author.
    f_author: ?[*:0]u8,
    /// The module's version.
    f_version: ?[*:0]u8,
    /// The module's copyright.
    f_copyright: ?[*:0]u8,
    /// The module's release date.
    f_date: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PDBClass = extern struct {
    pub const Instance = gimp.PDB;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PDBClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PaletteClass = extern struct {
    pub const Instance = gimp.Palette;

    f_parent_class: gimp.ResourceClass,

    pub fn as(p_instance: *PaletteClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecObject = extern struct {
    f_parent_instance: gobject.ParamSpecObject,
    f__default_value: ?*gobject.Object,
    f__has_default: c_int,

    /// This function duplicates `pspec` appropriately, depending on the
    /// accurate spec type.
    extern fn gimp_param_spec_object_duplicate(p_pspec: *gobject.ParamSpec) *gobject.ParamSpec;
    pub const duplicate = gimp_param_spec_object_duplicate;

    /// Get the default object value of the param spec.
    ///
    /// If the `pspec` has been registered with a specific default (which can
    /// be verified with `gimp.ParamSpecObject.hasDefault`), it will be
    /// returned, though some specific subtypes may support returning dynamic
    /// default (e.g. based on context).
    extern fn gimp_param_spec_object_get_default(p_pspec: *gobject.ParamSpec) *gobject.Object;
    pub const getDefault = gimp_param_spec_object_get_default;

    /// This function tells whether a default was set, typically with
    /// `gimp.ParamSpecObject.setDefault` or any other way. It
    /// does not guarantee that the default is an actual object (it may be
    /// `NULL` if valid as a default).
    extern fn gimp_param_spec_object_has_default(p_pspec: *gobject.ParamSpec) c_int;
    pub const hasDefault = gimp_param_spec_object_has_default;

    /// Set the default object value of the param spec. This will switch the
    /// `has_default` flag so that `gimp.ParamSpecObject.hasDefault`
    /// will now return `TRUE`.
    ///
    /// A `NULL` `default_value` still counts as a default (unless the specific
    /// `pspec` does not allow `NULL` as a default).
    extern fn gimp_param_spec_object_set_default(p_pspec: *gobject.ParamSpec, p_default_value: ?*gobject.Object) void;
    pub const setDefault = gimp_param_spec_object_set_default;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecObjectClass = extern struct {
    f_parent_class: gobject.ParamSpecClass,
    f_duplicate: ?*const fn (p_pspec: *gobject.ParamSpec) callconv(.c) *gobject.ParamSpec,
    f_get_default: ?*const fn (p_pspec: *gobject.ParamSpec) callconv(.c) *gobject.Object,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Arbitrary pieces of data which can be attached to various GIMP objects.
pub const Parasite = extern struct {
    /// the parasite name, USE A UNIQUE PREFIX
    f_name: ?[*:0]u8,
    /// the parasite flags, like save in XCF etc.
    f_flags: u32,
    /// the parasite size in bytes
    f_size: u32,
    /// the parasite data, the owner os the parasite is responsible
    ///   for tracking byte order and internal structure
    f_data: ?[*]*anyopaque,

    /// Creates a new parasite and save `data` which may be a proper text (in
    /// which case you may want to set `size` as strlen(`data`) + 1) or not.
    extern fn gimp_parasite_new(p_name: [*:0]const u8, p_flags: u32, p_size: u32, p_data: ?[*]const u8) *gimp.Parasite;
    pub const new = gimp_parasite_new;

    /// Compare parasite's contents.
    extern fn gimp_parasite_compare(p_a: *const Parasite, p_b: *const gimp.Parasite) c_int;
    pub const compare = gimp_parasite_compare;

    /// Create a new parasite with all the same values.
    extern fn gimp_parasite_copy(p_parasite: *const Parasite) *gimp.Parasite;
    pub const copy = gimp_parasite_copy;

    /// Free `parasite`'s dynamically allocated memory.
    extern fn gimp_parasite_free(p_parasite: *Parasite) void;
    pub const free = gimp_parasite_free;

    /// Gets the parasite's data. It may not necessarily be text, nor is it
    /// guaranteed to be `NULL`-terminated. It is your responsibility to know
    /// how to deal with this data.
    /// Even when you expect a nul-terminated string, it is advised not to
    /// assume the returned data to be, as parasites can be edited by third
    /// party scripts. You may end up reading out-of-bounds data. So you
    /// should only ignore `num_bytes` when you all you care about is checking
    /// if the parasite has contents.
    extern fn gimp_parasite_get_data(p_parasite: *const Parasite, p_num_bytes: ?*u32) [*]const u8;
    pub const getData = gimp_parasite_get_data;

    extern fn gimp_parasite_get_flags(p_parasite: *const Parasite) c_ulong;
    pub const getFlags = gimp_parasite_get_flags;

    extern fn gimp_parasite_get_name(p_parasite: *const Parasite) [*:0]const u8;
    pub const getName = gimp_parasite_get_name;

    extern fn gimp_parasite_has_flag(p_parasite: *const Parasite, p_flag: c_ulong) c_int;
    pub const hasFlag = gimp_parasite_has_flag;

    extern fn gimp_parasite_is_persistent(p_parasite: *const Parasite) c_int;
    pub const isPersistent = gimp_parasite_is_persistent;

    /// Compare parasite's names.
    extern fn gimp_parasite_is_type(p_parasite: *const Parasite, p_name: [*:0]const u8) c_int;
    pub const isType = gimp_parasite_is_type;

    extern fn gimp_parasite_is_undoable(p_parasite: *const Parasite) c_int;
    pub const isUndoable = gimp_parasite_is_undoable;

    extern fn gimp_parasite_get_type() usize;
    pub const getGObjectType = gimp_parasite_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathClass = extern struct {
    pub const Instance = gimp.Path;

    f_parent_class: gimp.ItemClass,

    pub fn as(p_instance: *PathClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PatternClass = extern struct {
    pub const Instance = gimp.Pattern;

    f_parent_class: gimp.ResourceClass,

    pub fn as(p_instance: *PatternClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// PLease somebody help documenting this.
pub const PixPipeParams = extern struct {
    /// Step
    f_step: c_int,
    /// Number of cells
    f_ncells: c_int,
    /// Dimension
    f_dim: c_int,
    /// Columns
    f_cols: c_int,
    /// Rows
    f_rows: c_int,
    /// Cell width
    f_cellwidth: c_int,
    /// Cell height
    f_cellheight: c_int,
    /// Placement
    f_placement: ?[*:0]u8,
    /// Rank
    f_rank: [4]c_int,
    /// Selection
    f_selection: [4][*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A class which every plug-in should subclass, while overriding
/// `PlugIn.virtual_methods.query_procedures` and/or `PlugIn.virtual_methods.init_procedures`, as
/// well as `PlugIn.virtual_methods.create_procedure`.
pub const PlugInClass = extern struct {
    pub const Instance = gimp.PlugIn;

    f_parent_class: gobject.ObjectClass,
    f_query_procedures: ?*const fn (p_plug_in: *gimp.PlugIn) callconv(.c) *glib.List,
    f_init_procedures: ?*const fn (p_plug_in: *gimp.PlugIn) callconv(.c) *glib.List,
    f_create_procedure: ?*const fn (p_plug_in: *gimp.PlugIn, p_procedure_name: [*:0]const u8) callconv(.c) *gimp.Procedure,
    f_quit: ?*const fn (p_plug_in: *gimp.PlugIn) callconv(.c) void,
    f_set_i18n: ?*const fn (p_plug_in: *gimp.PlugIn, p_procedure_name: [*:0]const u8, p_gettext_domain: ?*[*:0]u8, p_catalog_dir: ?*[*:0]u8) callconv(.c) c_int,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *PlugInClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcedureClass = extern struct {
    pub const Instance = gimp.Procedure;

    f_parent_class: gobject.ObjectClass,
    /// called to install the procedure with the main GIMP
    ///   application. This is an implementation detail and must never
    ///   be called by any plug-in code.
    f_install: ?*const fn (p_procedure: *gimp.Procedure) callconv(.c) void,
    /// called to uninstall the procedure from the main GIMP
    ///   application. This is an implementation detail and must never
    ///   be called by any plug-in code.
    f_uninstall: ?*const fn (p_procedure: *gimp.Procedure) callconv(.c) void,
    /// called when the procedure is executed via `gimp.Procedure.run`.
    ///   the default implementation simply calls the procedure's `gimp.RunFunc`,
    ///   `gimp.Procedure` subclasses are free to modify the passed `args` and
    ///   call their own, subclass-specific run functions.
    f_run: ?*const fn (p_procedure: *gimp.Procedure, p_args: *const gimp.ValueArray) callconv(.c) *gimp.ValueArray,
    /// called when a `gimp.Config` object is created using
    ///   `gimp.Procedure.createConfig`.
    f_create_config: ?*const fn (p_procedure: *gimp.Procedure, p_args: **gobject.ParamSpec, p_n_args: c_int) callconv(.c) *gimp.ProcedureConfig,
    f_set_sensitivity: ?*const fn (p_procedure: *gimp.Procedure, p_sensitivity_mask: c_int) callconv(.c) c_int,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcedureConfigClass = extern struct {
    pub const Instance = gimp.ProcedureConfig;

    f_parent_class: gobject.ObjectClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ProcedureConfigClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProgressVtable = extern struct {
    /// starts the progress.
    f_start: ?gimp.ProgressVtableStartFunc,
    /// ends the progress.
    f_end: ?gimp.ProgressVtableEndFunc,
    /// sets a new text on the progress.
    f_set_text: ?gimp.ProgressVtableSetTextFunc,
    /// sets a new percentage on the progress.
    f_set_value: ?gimp.ProgressVtableSetValueFunc,
    /// makes the progress pulse.
    f_pulse: ?gimp.ProgressVtablePulseFunc,
    /// returns the handle of the window where the progress is displayed.
    f_get_window_handle: ?gimp.ProgressVtableGetWindowFunc,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ResourceClass = extern struct {
    pub const Instance = gimp.Resource;

    f_parent_class: gobject.ObjectClass,
    f__gimp_reserved0: ?*const fn () callconv(.c) void,
    f__gimp_reserved1: ?*const fn () callconv(.c) void,
    f__gimp_reserved2: ?*const fn () callconv(.c) void,
    f__gimp_reserved3: ?*const fn () callconv(.c) void,
    f__gimp_reserved4: ?*const fn () callconv(.c) void,
    f__gimp_reserved5: ?*const fn () callconv(.c) void,
    f__gimp_reserved6: ?*const fn () callconv(.c) void,
    f__gimp_reserved7: ?*const fn () callconv(.c) void,
    f__gimp_reserved8: ?*const fn () callconv(.c) void,
    f__gimp_reserved9: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *ResourceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A wrapper around `glib.Scanner` with some convenience API.
pub const Scanner = opaque {
    extern fn gimp_scanner_new_file(p_file: *gio.File, p_error: ?*?*glib.Error) ?*gimp.Scanner;
    pub const newFile = gimp_scanner_new_file;

    extern fn gimp_scanner_new_stream(p_input: *gio.InputStream, p_error: ?*?*glib.Error) ?*gimp.Scanner;
    pub const newStream = gimp_scanner_new_stream;

    extern fn gimp_scanner_new_string(p_text: [*]const u8, p_text_len: c_int, p_error: ?*?*glib.Error) ?*gimp.Scanner;
    pub const newString = gimp_scanner_new_string;

    extern fn gimp_scanner_parse_boolean(p_scanner: *Scanner, p_dest: *c_int) c_int;
    pub const parseBoolean = gimp_scanner_parse_boolean;

    extern fn gimp_scanner_parse_color(p_scanner: *Scanner, p_color: **gegl.Color) c_int;
    pub const parseColor = gimp_scanner_parse_color;

    extern fn gimp_scanner_parse_data(p_scanner: *Scanner, p_length: c_int, p_dest: *[*]u8) c_int;
    pub const parseData = gimp_scanner_parse_data;

    extern fn gimp_scanner_parse_double(p_scanner: *Scanner, p_dest: *f64) c_int;
    pub const parseDouble = gimp_scanner_parse_double;

    extern fn gimp_scanner_parse_identifier(p_scanner: *Scanner, p_identifier: [*:0]const u8) c_int;
    pub const parseIdentifier = gimp_scanner_parse_identifier;

    extern fn gimp_scanner_parse_int(p_scanner: *Scanner, p_dest: *c_int) c_int;
    pub const parseInt = gimp_scanner_parse_int;

    extern fn gimp_scanner_parse_int64(p_scanner: *Scanner, p_dest: *i64) c_int;
    pub const parseInt64 = gimp_scanner_parse_int64;

    extern fn gimp_scanner_parse_matrix2(p_scanner: *Scanner, p_dest: *gimp.Matrix2) c_int;
    pub const parseMatrix2 = gimp_scanner_parse_matrix2;

    extern fn gimp_scanner_parse_string(p_scanner: *Scanner, p_dest: *[*:0]u8) c_int;
    pub const parseString = gimp_scanner_parse_string;

    extern fn gimp_scanner_parse_string_no_validate(p_scanner: *Scanner, p_dest: *[*:0]u8) c_int;
    pub const parseStringNoValidate = gimp_scanner_parse_string_no_validate;

    extern fn gimp_scanner_parse_token(p_scanner: *Scanner, p_token: glib.TokenType) c_int;
    pub const parseToken = gimp_scanner_parse_token;

    /// Adds a reference to a `gimp.Scanner`.
    extern fn gimp_scanner_ref(p_scanner: *Scanner) *gimp.Scanner;
    pub const ref = gimp_scanner_ref;

    /// Unref a `gimp.Scanner`. If the reference count drops to zero, the
    /// scanner is freed.
    extern fn gimp_scanner_unref(p_scanner: *Scanner) void;
    pub const unref = gimp_scanner_unref;

    extern fn gimp_scanner_get_type() usize;
    pub const getGObjectType = gimp_scanner_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SelectionClass = extern struct {
    pub const Instance = gimp.Selection;

    f_parent_class: gimp.ChannelClass,

    pub fn as(p_instance: *SelectionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextLayerClass = extern struct {
    pub const Instance = gimp.TextLayer;

    f_parent_class: gimp.LayerClass,

    pub fn as(p_instance: *TextLayerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ThumbnailProcedureClass = extern struct {
    pub const Instance = gimp.ThumbnailProcedure;

    f_parent_class: gimp.ProcedureClass,

    pub fn as(p_instance: *ThumbnailProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UnitClass = extern struct {
    pub const Instance = gimp.Unit;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *UnitClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The prime purpose of a `gimp.ValueArray` is for it to be used as an
/// object property that holds an array of values. A `gimp.ValueArray` wraps
/// an array of `gobject.Value` elements in order for it to be used as a boxed
/// type through `GIMP_TYPE_VALUE_ARRAY`.
pub const ValueArray = opaque {
    /// Allocate and initialize a new `gimp.ValueArray`, optionally preserve space
    /// for `n_prealloced` elements. New arrays always contain 0 elements,
    /// regardless of the value of `n_prealloced`.
    extern fn gimp_value_array_new(p_n_prealloced: c_int) *gimp.ValueArray;
    pub const new = gimp_value_array_new;

    /// Allocate and initialize a new `gimp.ValueArray`, and fill it with
    /// values that are given as a list of (`gobject.Type`, value) pairs,
    /// terminated by `G_TYPE_NONE`.
    extern fn gimp_value_array_new_from_types(p_error_msg: *[*:0]u8, p_first_type: usize, ...) ?*gimp.ValueArray;
    pub const newFromTypes = gimp_value_array_new_from_types;

    /// Allocate and initialize a new `gimp.ValueArray`, and fill it with
    /// `va_args` given in the order as passed to
    /// `gimp.ValueArray.newFromTypes`.
    extern fn gimp_value_array_new_from_types_valist(p_error_msg: *[*:0]u8, p_first_type: usize, p_va_args: std.builtin.VaList) ?*gimp.ValueArray;
    pub const newFromTypesValist = gimp_value_array_new_from_types_valist;

    /// Allocate and initialize a new `gimp.ValueArray`, and fill it with
    /// the given `GValues`.  When no `GValues` are given, returns empty `gimp.ValueArray`.
    extern fn gimp_value_array_new_from_values(p_values: [*]const gobject.Value, p_n_values: c_int) *gimp.ValueArray;
    pub const newFromValues = gimp_value_array_new_from_values;

    /// Insert a copy of `value` as last element of `value_array`. If `value` is
    /// `NULL`, an uninitialized value is appended.
    extern fn gimp_value_array_append(p_value_array: *ValueArray, p_value: ?*const gobject.Value) *gimp.ValueArray;
    pub const append = gimp_value_array_append;

    /// Return an exact copy of a `gimp.ValueArray` by duplicating all its values.
    extern fn gimp_value_array_copy(p_value_array: *const ValueArray) *gimp.ValueArray;
    pub const copy = gimp_value_array_copy;

    /// Return a pointer to the value at `index` contained in `value_array`. This value
    /// is supposed to be a `ColorArray`.
    ///
    /// *Note*: most of the time, you should use the generic `gimp.ValueArray.index`
    /// to retrieve a value, then the relevant `g_value_get_*()` function.
    /// This alternative function is mostly there for bindings because
    /// GObject-Introspection is [not able yet to process correctly known
    /// boxed array types](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492).
    ///
    /// There are no reasons to use this function in C code.
    extern fn gimp_value_array_get_color_array(p_value_array: *const ValueArray, p_index: c_int) [*]*gegl.Color;
    pub const getColorArray = gimp_value_array_get_color_array;

    /// Return a pointer to the value at `index` contained in `value_array`. This value
    /// is supposed to be a `CoreObjectArray`.
    ///
    /// *Note*: most of the time, you should use the generic `gimp.ValueArray.index`
    /// to retrieve a value, then the relevant `g_value_get_*()` function.
    /// This alternative function is mostly there for bindings because
    /// GObject-Introspection is [not able yet to process correctly known
    /// boxed array types](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/492).
    ///
    /// There are no reasons to use this function in C code.
    extern fn gimp_value_array_get_core_object_array(p_value_array: *const ValueArray, p_index: c_int) [*]*gobject.Object;
    pub const getCoreObjectArray = gimp_value_array_get_core_object_array;

    /// Return a pointer to the value at `index` contained in `value_array`.
    ///
    /// *Note*: in binding languages, some custom types fail to be correctly passed
    /// through. For these types, you should use specific functions.
    /// For instance, in the Python binding, a `ColorArray` `GValue`
    /// won't be usable with this function. You should use instead
    /// `ValueArray.getColorArray`.
    extern fn gimp_value_array_index(p_value_array: *const ValueArray, p_index: c_int) *gobject.Value;
    pub const index = gimp_value_array_index;

    /// Insert a copy of `value` at specified position into `value_array`. If `value`
    /// is `NULL`, an uninitialized value is inserted.
    extern fn gimp_value_array_insert(p_value_array: *ValueArray, p_index: c_int, p_value: ?*const gobject.Value) *gimp.ValueArray;
    pub const insert = gimp_value_array_insert;

    extern fn gimp_value_array_length(p_value_array: *const ValueArray) c_int;
    pub const length = gimp_value_array_length;

    /// Insert a copy of `value` as first element of `value_array`. If `value` is
    /// `NULL`, an uninitialized value is prepended.
    extern fn gimp_value_array_prepend(p_value_array: *ValueArray, p_value: ?*const gobject.Value) *gimp.ValueArray;
    pub const prepend = gimp_value_array_prepend;

    /// Adds a reference to a `gimp.ValueArray`.
    extern fn gimp_value_array_ref(p_value_array: *ValueArray) *gimp.ValueArray;
    pub const ref = gimp_value_array_ref;

    /// Remove the value at position `index` from `value_array`.
    extern fn gimp_value_array_remove(p_value_array: *ValueArray, p_index: c_int) *gimp.ValueArray;
    pub const remove = gimp_value_array_remove;

    extern fn gimp_value_array_truncate(p_value_array: *ValueArray, p_n_values: c_int) void;
    pub const truncate = gimp_value_array_truncate;

    /// Unref a `gimp.ValueArray`. If the reference count drops to zero, the
    /// array including its contents are freed.
    extern fn gimp_value_array_unref(p_value_array: *ValueArray) void;
    pub const unref = gimp_value_array_unref;

    extern fn gimp_value_array_get_type() usize;
    pub const getGObjectType = gimp_value_array_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A two dimensional vector.
pub const Vector2 = extern struct {
    /// the x axis
    f_x: f64,
    /// the y axis
    f_y: f64,

    /// Computes the sum of two 2D vectors. The resulting `gimp.Vector2` is
    /// stored in `result`.
    extern fn gimp_vector2_add(p_result: *gimp.Vector2, p_vector1: *const gimp.Vector2, p_vector2: *const gimp.Vector2) void;
    pub const add = gimp_vector2_add;

    /// Computes the difference of two 2D vectors (`vector1` minus `vector2`).
    /// The resulting `gimp.Vector2` is stored in `result`.
    extern fn gimp_vector2_sub(p_result: *gimp.Vector2, p_vector1: *const gimp.Vector2, p_vector2: *const gimp.Vector2) void;
    pub const sub = gimp_vector2_sub;

    /// Creates a `Vector2` of coordinates `x` and `y`.
    extern fn gimp_vector2_new(p_x: f64, p_y: f64) gimp.Vector2;
    pub const new = gimp_vector2_new;

    /// This function is identical to `gimp.vector2Add` but the vectors
    /// are passed by value rather than by reference.
    extern fn gimp_vector2_add_val(p_vector1: Vector2, p_vector2: gimp.Vector2) gimp.Vector2;
    pub const addVal = gimp_vector2_add_val;

    /// Compute the cross product of two vectors. The result is a
    /// `gimp.Vector2` which is orthogonal to both `vector1` and `vector2`. If
    /// `vector1` and `vector2` are parallel, the result will be the nul
    /// vector.
    ///
    /// Note that in 2D, this function is useful to test if two vectors are
    /// parallel or not, or to compute the area spawned by two vectors.
    extern fn gimp_vector2_cross_product(p_vector1: *const Vector2, p_vector2: *const gimp.Vector2) gimp.Vector2;
    pub const crossProduct = gimp_vector2_cross_product;

    /// Identical to `Vector2.crossProduct`, but the
    /// vectors are passed by value rather than by reference.
    extern fn gimp_vector2_cross_product_val(p_vector1: Vector2, p_vector2: gimp.Vector2) gimp.Vector2;
    pub const crossProductVal = gimp_vector2_cross_product_val;

    /// Computes the inner (dot) product of two 2D vectors.
    /// This product is zero if and only if the two vectors are orthogonal.
    extern fn gimp_vector2_inner_product(p_vector1: *const Vector2, p_vector2: *const gimp.Vector2) f64;
    pub const innerProduct = gimp_vector2_inner_product;

    /// Identical to `Vector2.innerProduct`, but the
    /// vectors are passed by value rather than by reference.
    extern fn gimp_vector2_inner_product_val(p_vector1: Vector2, p_vector2: gimp.Vector2) f64;
    pub const innerProductVal = gimp_vector2_inner_product_val;

    /// Computes the length of a 2D vector.
    extern fn gimp_vector2_length(p_vector: *const Vector2) f64;
    pub const length = gimp_vector2_length;

    /// Identical to `Vector2.length`, but the vector is passed by value
    /// rather than by reference.
    extern fn gimp_vector2_length_val(p_vector: Vector2) f64;
    pub const lengthVal = gimp_vector2_length_val;

    /// Multiplies each component of the `vector` by `factor`. Note that this
    /// is equivalent to multiplying the vectors length by `factor`.
    extern fn gimp_vector2_mul(p_vector: *Vector2, p_factor: f64) void;
    pub const mul = gimp_vector2_mul;

    /// Identical to `Vector2.mul`, but the vector is passed by value rather
    /// than by reference.
    extern fn gimp_vector2_mul_val(p_vector: Vector2, p_factor: f64) gimp.Vector2;
    pub const mulVal = gimp_vector2_mul_val;

    /// Negates the `vector` (i.e. negate all its coordinates).
    extern fn gimp_vector2_neg(p_vector: *Vector2) void;
    pub const neg = gimp_vector2_neg;

    /// Identical to `Vector2.neg`, but the vector
    /// is passed by value rather than by reference.
    extern fn gimp_vector2_neg_val(p_vector: Vector2) gimp.Vector2;
    pub const negVal = gimp_vector2_neg_val;

    /// Compute a normalized perpendicular vector to `vector`
    extern fn gimp_vector2_normal(p_vector: *Vector2) gimp.Vector2;
    pub const normal = gimp_vector2_normal;

    /// Identical to `Vector2.normal`, but the vector
    /// is passed by value rather than by reference.
    extern fn gimp_vector2_normal_val(p_vector: Vector2) gimp.Vector2;
    pub const normalVal = gimp_vector2_normal_val;

    /// Normalizes the `vector` so the length of the `vector` is 1.0. The nul
    /// vector will not be changed.
    extern fn gimp_vector2_normalize(p_vector: *Vector2) void;
    pub const normalize = gimp_vector2_normalize;

    /// Identical to `Vector2.normalize`, but the
    /// vector is passed by value rather than by reference.
    extern fn gimp_vector2_normalize_val(p_vector: Vector2) gimp.Vector2;
    pub const normalizeVal = gimp_vector2_normalize_val;

    /// Rotates the `vector` counterclockwise by `alpha` radians.
    extern fn gimp_vector2_rotate(p_vector: *Vector2, p_alpha: f64) void;
    pub const rotate = gimp_vector2_rotate;

    /// Identical to `Vector2.rotate`, but the vector
    /// is passed by value rather than by reference.
    extern fn gimp_vector2_rotate_val(p_vector: Vector2, p_alpha: f64) gimp.Vector2;
    pub const rotateVal = gimp_vector2_rotate_val;

    /// Sets the X and Y coordinates of `vector` to `x` and `y`.
    extern fn gimp_vector2_set(p_vector: *Vector2, p_x: f64, p_y: f64) void;
    pub const set = gimp_vector2_set;

    /// This function is identical to `gimp.vector2Sub` but the vectors
    /// are passed by value rather than by reference.
    extern fn gimp_vector2_sub_val(p_vector1: Vector2, p_vector2: gimp.Vector2) gimp.Vector2;
    pub const subVal = gimp_vector2_sub_val;

    extern fn gimp_vector2_get_type() usize;
    pub const getGObjectType = gimp_vector2_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A three dimensional vector.
pub const Vector3 = extern struct {
    /// the x axis
    f_x: f64,
    /// the y axis
    f_y: f64,
    /// the z axis
    f_z: f64,

    /// Computes the sum of two 3D vectors. The resulting `gimp.Vector3` is
    /// stored in `result`.
    extern fn gimp_vector3_add(p_result: *gimp.Vector3, p_vector1: *const gimp.Vector3, p_vector2: *const gimp.Vector3) void;
    pub const add = gimp_vector3_add;

    /// Computes the difference of two 3D vectors (`vector1` minus `vector2`).
    /// The resulting `gimp.Vector3` is stored in `result`.
    extern fn gimp_vector3_sub(p_result: *gimp.Vector3, p_vector1: *const gimp.Vector3, p_vector2: *const gimp.Vector3) void;
    pub const sub = gimp_vector3_sub;

    /// Creates a `gimp.Vector3` of coordinate `x`, `y` and `z`.
    extern fn gimp_vector3_new(p_x: f64, p_y: f64, p_z: f64) gimp.Vector3;
    pub const new = gimp_vector3_new;

    /// This function is identical to `gimp.vector3Add` but the vectors
    /// are passed by value rather than by reference.
    extern fn gimp_vector3_add_val(p_vector1: Vector3, p_vector2: gimp.Vector3) gimp.Vector3;
    pub const addVal = gimp_vector3_add_val;

    /// Compute the cross product of two vectors. The result is a
    /// `gimp.Vector3` which is orthogonal to both `vector1` and `vector2`. If
    /// `vector1` and `vector2` and parallel, the result will be the nul
    /// vector.
    ///
    /// This function can be used to compute the normal of the plane
    /// defined by `vector1` and `vector2`.
    extern fn gimp_vector3_cross_product(p_vector1: *const Vector3, p_vector2: *const gimp.Vector3) gimp.Vector3;
    pub const crossProduct = gimp_vector3_cross_product;

    /// Identical to `Vector3.crossProduct`, but the
    /// vectors are passed by value rather than by reference.
    extern fn gimp_vector3_cross_product_val(p_vector1: Vector3, p_vector2: gimp.Vector3) gimp.Vector3;
    pub const crossProductVal = gimp_vector3_cross_product_val;

    /// Computes the inner (dot) product of two 3D vectors. This product
    /// is zero if and only if the two vectors are orthogonal.
    extern fn gimp_vector3_inner_product(p_vector1: *const Vector3, p_vector2: *const gimp.Vector3) f64;
    pub const innerProduct = gimp_vector3_inner_product;

    /// Identical to `Vector3.innerProduct`, but the
    /// vectors are passed by value rather than by reference.
    extern fn gimp_vector3_inner_product_val(p_vector1: Vector3, p_vector2: gimp.Vector3) f64;
    pub const innerProductVal = gimp_vector3_inner_product_val;

    /// Computes the length of a 3D vector.
    extern fn gimp_vector3_length(p_vector: *const Vector3) f64;
    pub const length = gimp_vector3_length;

    /// Identical to `Vector3.length`, but the vector
    /// is passed by value rather than by reference.
    extern fn gimp_vector3_length_val(p_vector: Vector3) f64;
    pub const lengthVal = gimp_vector3_length_val;

    /// Multiplies each component of the `vector` by `factor`. Note that
    /// this is equivalent to multiplying the vectors length by `factor`.
    extern fn gimp_vector3_mul(p_vector: *Vector3, p_factor: f64) void;
    pub const mul = gimp_vector3_mul;

    /// Identical to `Vector3.mul`, but the vector is
    /// passed by value rather than by reference.
    extern fn gimp_vector3_mul_val(p_vector: Vector3, p_factor: f64) gimp.Vector3;
    pub const mulVal = gimp_vector3_mul_val;

    /// Negates the `vector` (i.e. negate all its coordinates).
    extern fn gimp_vector3_neg(p_vector: *Vector3) void;
    pub const neg = gimp_vector3_neg;

    /// Identical to `Vector3.neg`, but the vector
    /// is passed by value rather than by reference.
    extern fn gimp_vector3_neg_val(p_vector: Vector3) gimp.Vector3;
    pub const negVal = gimp_vector3_neg_val;

    /// Normalizes the `vector` so the length of the `vector` is 1.0. The nul
    /// vector will not be changed.
    extern fn gimp_vector3_normalize(p_vector: *Vector3) void;
    pub const normalize = gimp_vector3_normalize;

    /// Identical to `Vector3.normalize`, but the
    /// vector is passed by value rather than by reference.
    extern fn gimp_vector3_normalize_val(p_vector: Vector3) gimp.Vector3;
    pub const normalizeVal = gimp_vector3_normalize_val;

    /// Rotates the `vector` around the three axis (Z, Y, and X) by `alpha`,
    /// `beta` and `gamma`, respectively.
    ///
    /// Note that the order of the rotation is very important. If you
    /// expect a vector to be rotated around X, and then around Y, you will
    /// have to call this function twice. Also, it is often wise to call
    /// this function with only one of `alpha`, `beta` and `gamma` non-zero.
    extern fn gimp_vector3_rotate(p_vector: *Vector3, p_alpha: f64, p_beta: f64, p_gamma: f64) void;
    pub const rotate = gimp_vector3_rotate;

    /// Identical to `Vector3.rotate`, but the vectors
    /// are passed by value rather than by reference.
    extern fn gimp_vector3_rotate_val(p_vector: Vector3, p_alpha: f64, p_beta: f64, p_gamma: f64) gimp.Vector3;
    pub const rotateVal = gimp_vector3_rotate_val;

    /// Sets the X, Y and Z coordinates of `vector` to `x`, `y` and `z`.
    extern fn gimp_vector3_set(p_vector: *Vector3, p_x: f64, p_y: f64, p_z: f64) void;
    pub const set = gimp_vector3_set;

    /// This function is identical to `gimp.vector3Sub` but the vectors
    /// are passed by value rather than by reference.
    extern fn gimp_vector3_sub_val(p_vector1: Vector3, p_vector2: gimp.Vector3) gimp.Vector3;
    pub const subVal = gimp_vector3_sub_val;

    extern fn gimp_vector3_get_type() usize;
    pub const getGObjectType = gimp_vector3_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A four dimensional vector.
pub const Vector4 = extern struct {
    /// the x axis
    f_x: f64,
    /// the y axis
    f_y: f64,
    /// the z axis
    f_z: f64,
    /// the w axis
    f_w: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VectorLoadData = extern struct {
    f_width: f64,
    f_width_unit: ?*gimp.Unit,
    f_exact_width: c_int,
    f_height: f64,
    f_height_unit: ?*gimp.Unit,
    f_exact_height: c_int,
    f_correct_ratio: c_int,
    f_pixel_density: f64,
    f_density_unit: ?*gimp.Unit,
    f_exact_density: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VectorLoadProcedureClass = extern struct {
    pub const Instance = gimp.VectorLoadProcedure;

    f_parent_class: gimp.LoadProcedureClass,

    pub fn as(p_instance: *VectorLoadProcedureClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Modes of initialising a layer mask.
pub const AddMaskType = enum(c_int) {
    white = 0,
    black = 1,
    alpha = 2,
    alpha_transfer = 3,
    selection = 4,
    copy = 5,
    channel = 6,
    _,

    extern fn gimp_add_mask_type_get_type() usize;
    pub const getGObjectType = gimp_add_mask_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Methods of syncing procedure arguments.
pub const ArgumentSync = enum(c_int) {
    none = 0,
    parasite = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/paint/paint-enums.h
pub const BrushApplicationMode = enum(c_int) {
    hard = 0,
    soft = 1,
    _,

    extern fn gimp_brush_application_mode_get_type() usize;
    pub const getGObjectType = gimp_brush_application_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Shapes of generated brushes.
pub const BrushGeneratedShape = enum(c_int) {
    circle = 0,
    square = 1,
    diamond = 2,
    _,

    extern fn gimp_brush_generated_shape_get_type() usize;
    pub const getGObjectType = gimp_brush_generated_shape_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Style of line endings.
pub const CapStyle = enum(c_int) {
    butt = 0,
    round = 1,
    square = 2,
    _,

    extern fn gimp_cap_style_get_type() usize;
    pub const getGObjectType = gimp_cap_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Operations to combine channels and selections.
pub const ChannelOps = enum(c_int) {
    add = 0,
    subtract = 1,
    replace = 2,
    intersect = 3,
    _,

    extern fn gimp_channel_ops_get_type() usize;
    pub const getGObjectType = gimp_channel_ops_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Channels (as in color components).
pub const ChannelType = enum(c_int) {
    red = 0,
    green = 1,
    blue = 2,
    gray = 3,
    indexed = 4,
    alpha = 5,
    _,

    extern fn gimp_channel_type_get_type() usize;
    pub const getGObjectType = gimp_channel_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Size of the checkerboard indicating transparency.
pub const CheckSize = enum(c_int) {
    small_checks = 0,
    medium_checks = 1,
    large_checks = 2,
    _,

    extern fn gimp_check_size_get_type() usize;
    pub const getGObjectType = gimp_check_size_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Color/Brightness of the checkerboard indicating transparency.
pub const CheckType = enum(c_int) {
    light_checks = 0,
    gray_checks = 1,
    dark_checks = 2,
    white_only = 3,
    gray_only = 4,
    black_only = 5,
    custom_checks = 6,
    _,

    extern fn gimp_check_type_get_type() usize;
    pub const getGObjectType = gimp_check_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Clone sources.
pub const CloneType = enum(c_int) {
    image = 0,
    pattern = 1,
    _,

    extern fn gimp_clone_type_get_type() usize;
    pub const getGObjectType = gimp_clone_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Modes of color management.
pub const ColorManagementMode = enum(c_int) {
    off = 0,
    display = 1,
    softproof = 2,
    _,

    extern fn gimp_color_management_mode_get_type() usize;
    pub const getGObjectType = gimp_color_management_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Intents for color management.
pub const ColorRenderingIntent = enum(c_int) {
    perceptual = 0,
    relative_colorimetric = 1,
    saturation = 2,
    absolute_colorimetric = 3,
    _,

    extern fn gimp_color_rendering_intent_get_type() usize;
    pub const getGObjectType = gimp_color_rendering_intent_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible tag colors.
pub const ColorTag = enum(c_int) {
    none = 0,
    blue = 1,
    green = 2,
    yellow = 3,
    orange = 4,
    brown = 5,
    red = 6,
    violet = 7,
    gray = 8,
    _,

    extern fn gimp_color_tag_get_type() usize;
    pub const getGObjectType = gimp_color_tag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for modifying `gimp.ColorTransform`'s behavior.
pub const ColorTransformFlags = enum(c_int) {
    nooptimize = 256,
    gamut_check = 4096,
    black_point_compensation = 8192,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Encoding types of image components.
pub const ComponentType = enum(c_int) {
    u8 = 100,
    u16 = 200,
    u32 = 300,
    half = 500,
    float = 600,
    double = 700,
    _,

    extern fn gimp_component_type_get_type() usize;
    pub const getGObjectType = gimp_component_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The possible values of a `glib.Error` thrown by libgimpconfig.
pub const ConfigError = enum(c_int) {
    open = 0,
    open_enoent = 1,
    write = 2,
    parse = 3,
    version = 4,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of config paths.
pub const ConfigPathType = enum(c_int) {
    file = 0,
    file_list = 1,
    dir = 2,
    dir_list = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/core/core-enums.h
pub const ConvertDitherType = enum(c_int) {
    none = 0,
    fs = 1,
    fs_lowbleed = 2,
    fixed = 3,
    _,

    extern fn gimp_convert_dither_type_get_type() usize;
    pub const getGObjectType = gimp_convert_dither_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of palettes for indexed conversion.
pub const ConvertPaletteType = enum(c_int) {
    generate = 0,
    web = 1,
    mono = 2,
    custom = 3,
    _,

    extern fn gimp_convert_palette_type_get_type() usize;
    pub const getGObjectType = gimp_convert_palette_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of convolutions.
pub const ConvolveType = enum(c_int) {
    blur = 0,
    sharpen = 1,
    _,

    extern fn gimp_convolve_type_get_type() usize;
    pub const getGObjectType = gimp_convolve_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of detectable CPU accelerations
pub const CpuAccelFlags = enum(c_int) {
    none = 0,
    x86_mmx = 2147483648,
    x86_3dnow = 1073741824,
    x86_mmxext = 536870912,
    x86_sse = 268435456,
    x86_sse2 = 134217728,
    x86_sse3 = 33554432,
    x86_ssse3 = 16777216,
    x86_sse4_1 = 8388608,
    x86_sse4_2 = 4194304,
    x86_avx = 2097152,
    ppc_altivec = 67108864,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Grayscale conversion methods.
pub const DesaturateMode = enum(c_int) {
    lightness = 0,
    luma = 1,
    average = 2,
    luminance = 3,
    value = 4,
    _,

    extern fn gimp_desaturate_mode_get_type() usize;
    pub const getGObjectType = gimp_desaturate_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Methods for the dodge/burn operation.
pub const DodgeBurnType = enum(c_int) {
    dodge = 0,
    burn = 1,
    _,

    extern fn gimp_dodge_burn_type_get_type() usize;
    pub const getGObjectType = gimp_dodge_burn_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible return values of `ExportOptions.getImage`.
pub const ExportReturn = enum(c_int) {
    ignore = 0,
    @"export" = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A type of file to choose from when actions are expected to choose a
/// file. This is basically a mapping to `GtkFileChooserAction` except for
/// `gimp.@"FileChooserAction.ANY"` which should not be used for any
/// GUI functions since we can't know what you are looking for.
pub const FileChooserAction = enum(c_int) {
    any = -1,
    open = 0,
    save = 1,
    select_folder = 2,
    create_folder = 3,
    _,

    extern fn gimp_file_chooser_action_get_type() usize;
    pub const getGObjectType = gimp_file_chooser_action_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of filling.
pub const FillType = enum(c_int) {
    foreground = 0,
    background = 1,
    cielab_middle_gray = 2,
    white = 3,
    transparent = 4,
    pattern = 5,
    _,

    extern fn gimp_fill_type_get_type() usize;
    pub const getGObjectType = gimp_fill_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Foreground extract engines.
pub const ForegroundExtractMode = enum(c_int) {
    matting = 0,
    _,

    extern fn gimp_foreground_extract_mode_get_type() usize;
    pub const getGObjectType = gimp_foreground_extract_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Color space for blending gradients.
pub const GradientBlendColorSpace = enum(c_int) {
    rgb_perceptual = 0,
    rgb_linear = 1,
    cie_lab = 2,
    _,

    extern fn gimp_gradient_blend_color_space_get_type() usize;
    pub const getGObjectType = gimp_gradient_blend_color_space_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Coloring types for gradient segments.
pub const GradientSegmentColor = enum(c_int) {
    rgb = 0,
    hsv_ccw = 1,
    hsv_cw = 2,
    _,

    extern fn gimp_gradient_segment_color_get_type() usize;
    pub const getGObjectType = gimp_gradient_segment_color_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Transition functions for gradient segments.
pub const GradientSegmentType = enum(c_int) {
    linear = 0,
    curved = 1,
    sine = 2,
    sphere_increasing = 3,
    sphere_decreasing = 4,
    step = 5,
    _,

    extern fn gimp_gradient_segment_type_get_type() usize;
    pub const getGObjectType = gimp_gradient_segment_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Gradient shapes.
pub const GradientType = enum(c_int) {
    linear = 0,
    bilinear = 1,
    radial = 2,
    square = 3,
    conical_symmetric = 4,
    conical_asymmetric = 5,
    shapeburst_angular = 6,
    shapeburst_spherical = 7,
    shapeburst_dimpled = 8,
    spiral_clockwise = 9,
    spiral_anticlockwise = 10,
    _,

    extern fn gimp_gradient_type_get_type() usize;
    pub const getGObjectType = gimp_gradient_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Rendering types for the display grid.
pub const GridStyle = enum(c_int) {
    dots = 0,
    intersections = 1,
    on_off_dash = 2,
    double_dash = 3,
    solid = 4,
    _,

    extern fn gimp_grid_style_get_type() usize;
    pub const getGObjectType = gimp_grid_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/core/core-enums.h
pub const HistogramChannel = enum(c_int) {
    value = 0,
    red = 1,
    green = 2,
    blue = 3,
    alpha = 4,
    luminance = 5,
    _,

    extern fn gimp_histogram_channel_get_type() usize;
    pub const getGObjectType = gimp_histogram_channel_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Hue ranges.
pub const HueRange = enum(c_int) {
    all = 0,
    red = 1,
    yellow = 2,
    green = 3,
    cyan = 4,
    blue = 5,
    magenta = 6,
    _,

    extern fn gimp_hue_range_get_type() usize;
    pub const getGObjectType = gimp_hue_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Icon types for plug-ins to register.
pub const IconType = enum(c_int) {
    icon_name = 0,
    pixbuf = 1,
    image_file = 2,
    _,

    extern fn gimp_icon_type_get_type() usize;
    pub const getGObjectType = gimp_icon_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Image color models.
pub const ImageBaseType = enum(c_int) {
    rgb = 0,
    gray = 1,
    indexed = 2,
    _,

    extern fn gimp_image_base_type_get_type() usize;
    pub const getGObjectType = gimp_image_base_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible drawable types.
pub const ImageType = enum(c_int) {
    rgb_image = 0,
    rgba_image = 1,
    gray_image = 2,
    graya_image = 3,
    indexed_image = 4,
    indexeda_image = 5,
    _,

    extern fn gimp_image_type_get_type() usize;
    pub const getGObjectType = gimp_image_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Ink tool tips.
pub const InkBlobType = enum(c_int) {
    circle = 0,
    square = 1,
    diamond = 2,
    _,

    extern fn gimp_ink_blob_type_get_type() usize;
    pub const getGObjectType = gimp_ink_blob_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interpolation types.
pub const InterpolationType = enum(c_int) {
    none = 0,
    linear = 1,
    cubic = 2,
    nohalo = 3,
    lohalo = 4,
    _,

    extern fn gimp_interpolation_type_get_type() usize;
    pub const getGObjectType = gimp_interpolation_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Line join styles.
pub const JoinStyle = enum(c_int) {
    miter = 0,
    round = 1,
    bevel = 2,
    _,

    extern fn gimp_join_style_get_type() usize;
    pub const getGObjectType = gimp_join_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/operations/operations-enums.h
pub const LayerColorSpace = enum(c_int) {
    auto = 0,
    rgb_linear = 1,
    rgb_non_linear = 2,
    lab = 3,
    rgb_perceptual = 4,
    _,

    extern fn gimp_layer_color_space_get_type() usize;
    pub const getGObjectType = gimp_layer_color_space_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/operations/operations-enums.h
pub const LayerCompositeMode = enum(c_int) {
    auto = 0,
    @"union" = 1,
    clip_to_backdrop = 2,
    clip_to_layer = 3,
    intersection = 4,
    _,

    extern fn gimp_layer_composite_mode_get_type() usize;
    pub const getGObjectType = gimp_layer_composite_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Extracted from app/operations/operations-enums.h
pub const LayerMode = enum(c_int) {
    normal_legacy = 0,
    dissolve = 1,
    behind_legacy = 2,
    multiply_legacy = 3,
    screen_legacy = 4,
    overlay_legacy = 5,
    difference_legacy = 6,
    addition_legacy = 7,
    subtract_legacy = 8,
    darken_only_legacy = 9,
    lighten_only_legacy = 10,
    hsv_hue_legacy = 11,
    hsv_saturation_legacy = 12,
    hsl_color_legacy = 13,
    hsv_value_legacy = 14,
    divide_legacy = 15,
    dodge_legacy = 16,
    burn_legacy = 17,
    hardlight_legacy = 18,
    softlight_legacy = 19,
    grain_extract_legacy = 20,
    grain_merge_legacy = 21,
    color_erase_legacy = 22,
    overlay = 23,
    lch_hue = 24,
    lch_chroma = 25,
    lch_color = 26,
    lch_lightness = 27,
    normal = 28,
    behind = 29,
    multiply = 30,
    screen = 31,
    difference = 32,
    addition = 33,
    subtract = 34,
    darken_only = 35,
    lighten_only = 36,
    hsv_hue = 37,
    hsv_saturation = 38,
    hsl_color = 39,
    hsv_value = 40,
    divide = 41,
    dodge = 42,
    burn = 43,
    hardlight = 44,
    softlight = 45,
    grain_extract = 46,
    grain_merge = 47,
    vivid_light = 48,
    pin_light = 49,
    linear_light = 50,
    hard_mix = 51,
    exclusion = 52,
    linear_burn = 53,
    luma_darken_only = 54,
    luma_lighten_only = 55,
    luminance = 56,
    color_erase = 57,
    erase = 58,
    merge = 59,
    split = 60,
    pass_through = 61,
    replace = 62,
    _,

    extern fn gimp_layer_mode_get_type() usize;
    pub const getGObjectType = gimp_layer_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Layer mask apply modes.
pub const MaskApplyMode = enum(c_int) {
    apply = 0,
    discard = 1,
    _,

    extern fn gimp_mask_apply_mode_get_type() usize;
    pub const getGObjectType = gimp_mask_apply_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of merging layers.
pub const MergeType = enum(c_int) {
    expand_as_necessary = 0,
    clip_to_image = 1,
    clip_to_bottom_layer = 2,
    flatten_image = 3,
    _,

    extern fn gimp_merge_type_get_type() usize;
    pub const getGObjectType = gimp_merge_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// How to present messages.
pub const MessageHandlerType = enum(c_int) {
    message_box = 0,
    console = 1,
    error_console = 2,
    _,

    extern fn gimp_message_handler_type_get_type() usize;
    pub const getGObjectType = gimp_message_handler_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Well-defined colorspace information available from metadata
pub const MetadataColorspace = enum(c_int) {
    unspecified = 0,
    uncalibrated = 1,
    srgb = 2,
    adobergb = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of errors returned by modules
pub const ModuleError = enum(c_int) {
    module_failed = 0,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The possible states a `gimp.Module` can be in.
pub const ModuleState = enum(c_int) {
    @"error" = 0,
    loaded = 1,
    load_failed = 2,
    not_loaded = 3,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Background fill types for the offset operation.
pub const OffsetType = enum(c_int) {
    color = 0,
    transparent = 1,
    wrap_around = 2,
    _,

    extern fn gimp_offset_type_get_type() usize;
    pub const getGObjectType = gimp_offset_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Orientations for various purposes.
pub const OrientationType = enum(c_int) {
    horizontal = 0,
    vertical = 1,
    unknown = 2,
    _,

    extern fn gimp_orientation_type_get_type() usize;
    pub const getGObjectType = gimp_orientation_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// PDB error handlers.
pub const PDBErrorHandler = enum(c_int) {
    internal = 0,
    plugin = 1,
    _,

    extern fn gimp_pdb_error_handler_get_type() usize;
    pub const getGObjectType = gimp_pdb_error_handler_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of PDB procedures.
pub const PDBProcType = enum(c_int) {
    internal = 0,
    plugin = 1,
    persistent = 2,
    temporary = 3,
    _,

    extern fn gimp_pdb_proc_type_get_type() usize;
    pub const getGObjectType = gimp_pdb_proc_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Return status of PDB calls.
pub const PDBStatusType = enum(c_int) {
    execution_error = 0,
    calling_error = 1,
    pass_through = 2,
    success = 3,
    cancel = 4,
    _,

    extern fn gimp_pdb_status_type_get_type() usize;
    pub const getGObjectType = gimp_pdb_status_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Paint application modes.
pub const PaintApplicationMode = enum(c_int) {
    constant = 0,
    incremental = 1,
    _,

    extern fn gimp_paint_application_mode_get_type() usize;
    pub const getGObjectType = gimp_paint_application_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible type of strokes in path objects.
pub const PathStrokeType = enum(c_int) {
    bezier = 0,
    _,

    extern fn gimp_path_stroke_type_get_type() usize;
    pub const getGObjectType = gimp_path_stroke_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// How to deal with transparency when creating thubnail pixbufs from
/// images and drawables.
pub const PixbufTransparency = enum(c_int) {
    keep_alpha = 0,
    small_checks = 1,
    large_checks = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Precisions for pixel encoding.
pub const Precision = enum(c_int) {
    u8_linear = 100,
    u8_non_linear = 150,
    u8_perceptual = 175,
    u16_linear = 200,
    u16_non_linear = 250,
    u16_perceptual = 275,
    u32_linear = 300,
    u32_non_linear = 350,
    u32_perceptual = 375,
    half_linear = 500,
    half_non_linear = 550,
    half_perceptual = 575,
    float_linear = 600,
    float_non_linear = 650,
    float_perceptual = 675,
    double_linear = 700,
    double_non_linear = 750,
    double_perceptual = 775,
    _,

    extern fn gimp_precision_get_type() usize;
    pub const getGObjectType = gimp_precision_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Commands for the progress API.
pub const ProgressCommand = enum(c_int) {
    start = 0,
    end = 1,
    set_text = 2,
    set_value = 3,
    pulse = 4,
    get_window = 5,
    _,

    extern fn gimp_progress_command_get_type() usize;
    pub const getGObjectType = gimp_progress_command_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Repeat modes for example for gradients.
pub const RepeatMode = enum(c_int) {
    none = 0,
    truncate = 1,
    sawtooth = 2,
    triangular = 3,
    _,

    extern fn gimp_repeat_mode_get_type() usize;
    pub const getGObjectType = gimp_repeat_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of simple rotations.
pub const RotationType = enum(c_int) {
    degrees90 = 0,
    degrees180 = 1,
    degrees270 = 2,
    _,

    extern fn gimp_rotation_type_get_type() usize;
    pub const getGObjectType = gimp_rotation_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Run modes for plug-ins.
pub const RunMode = enum(c_int) {
    interactive = 0,
    noninteractive = 1,
    with_last_vals = 2,
    _,

    extern fn gimp_run_mode_get_type() usize;
    pub const getGObjectType = gimp_run_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Criterions for color similarity.
pub const SelectCriterion = enum(c_int) {
    composite = 0,
    rgb_red = 1,
    rgb_green = 2,
    rgb_blue = 3,
    hsv_hue = 4,
    hsv_saturation = 5,
    hsv_value = 6,
    lch_lightness = 7,
    lch_chroma = 8,
    lch_hue = 9,
    alpha = 10,
    _,

    extern fn gimp_select_criterion_get_type() usize;
    pub const getGObjectType = gimp_select_criterion_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Size types for the old-style text API.
pub const SizeType = enum(c_int) {
    pixels = 0,
    points = 1,
    _,

    extern fn gimp_size_type_get_type() usize;
    pub const getGObjectType = gimp_size_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// When to generate stack traces in case of an error.
pub const StackTraceMode = enum(c_int) {
    never = 0,
    query = 1,
    always = 2,
    _,

    extern fn gimp_stack_trace_mode_get_type() usize;
    pub const getGObjectType = gimp_stack_trace_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Methods of stroking selections and paths.
pub const StrokeMethod = enum(c_int) {
    line = 0,
    paint_method = 1,
    _,

    extern fn gimp_stroke_method_get_type() usize;
    pub const getGObjectType = gimp_stroke_method_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text directions.
pub const TextDirection = enum(c_int) {
    ltr = 0,
    rtl = 1,
    ttb_rtl = 2,
    ttb_rtl_upright = 3,
    ttb_ltr = 4,
    ttb_ltr_upright = 5,
    _,

    extern fn gimp_text_direction_get_type() usize;
    pub const getGObjectType = gimp_text_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text hint strengths.
pub const TextHintStyle = enum(c_int) {
    none = 0,
    slight = 1,
    medium = 2,
    full = 3,
    _,

    extern fn gimp_text_hint_style_get_type() usize;
    pub const getGObjectType = gimp_text_hint_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text justifications.
pub const TextJustification = enum(c_int) {
    left = 0,
    right = 1,
    center = 2,
    fill = 3,
    _,

    extern fn gimp_text_justification_get_type() usize;
    pub const getGObjectType = gimp_text_justification_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// For choosing which brightness ranges to transform.
pub const TransferMode = enum(c_int) {
    shadows = 0,
    midtones = 1,
    highlights = 2,
    _,

    extern fn gimp_transfer_mode_get_type() usize;
    pub const getGObjectType = gimp_transfer_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Transform directions.
pub const TransformDirection = enum(c_int) {
    forward = 0,
    backward = 1,
    _,

    extern fn gimp_transform_direction_get_type() usize;
    pub const getGObjectType = gimp_transform_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Ways of clipping the result when transforming drawables.
pub const TransformResize = enum(c_int) {
    adjust = 0,
    clip = 1,
    crop = 2,
    crop_with_aspect = 3,
    _,

    extern fn gimp_transform_resize_get_type() usize;
    pub const getGObjectType = gimp_transform_resize_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Integer IDs of built-in units used for dimensions in images. These
/// IDs are meant to stay stable but user-created units IDs may change
/// from one session to another.
pub const UnitID = enum(c_int) {
    pixel = 0,
    inch = 1,
    mm = 2,
    point = 3,
    pica = 4,
    end = 5,
    percent = 65536,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The types of images and layers an export procedure can handle
pub const ExportCapabilities = packed struct(c_uint) {
    can_handle_rgb: bool = false,
    can_handle_gray: bool = false,
    can_handle_indexed: bool = false,
    can_handle_bitmap: bool = false,
    can_handle_alpha: bool = false,
    can_handle_layers: bool = false,
    can_handle_layers_as_animation: bool = false,
    can_handle_layer_masks: bool = false,
    can_handle_layer_effects: bool = false,
    needs_alpha: bool = false,
    needs_crop: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_can_handle_rgb: ExportCapabilities = @bitCast(@as(c_uint, 1));
    pub const flags_can_handle_gray: ExportCapabilities = @bitCast(@as(c_uint, 2));
    pub const flags_can_handle_indexed: ExportCapabilities = @bitCast(@as(c_uint, 4));
    pub const flags_can_handle_bitmap: ExportCapabilities = @bitCast(@as(c_uint, 8));
    pub const flags_can_handle_alpha: ExportCapabilities = @bitCast(@as(c_uint, 16));
    pub const flags_can_handle_layers: ExportCapabilities = @bitCast(@as(c_uint, 32));
    pub const flags_can_handle_layers_as_animation: ExportCapabilities = @bitCast(@as(c_uint, 64));
    pub const flags_can_handle_layer_masks: ExportCapabilities = @bitCast(@as(c_uint, 128));
    pub const flags_can_handle_layer_effects: ExportCapabilities = @bitCast(@as(c_uint, 256));
    pub const flags_needs_alpha: ExportCapabilities = @bitCast(@as(c_uint, 512));
    pub const flags_needs_crop: ExportCapabilities = @bitCast(@as(c_uint, 1024));
    extern fn gimp_export_capabilities_get_type() usize;
    pub const getGObjectType = gimp_export_capabilities_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// What metadata to load when importing images.
pub const MetadataLoadFlags = packed struct(c_uint) {
    comment: bool = false,
    resolution: bool = false,
    orientation: bool = false,
    colorspace: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_none: MetadataLoadFlags = @bitCast(@as(c_uint, 0));
    pub const flags_comment: MetadataLoadFlags = @bitCast(@as(c_uint, 1));
    pub const flags_resolution: MetadataLoadFlags = @bitCast(@as(c_uint, 2));
    pub const flags_orientation: MetadataLoadFlags = @bitCast(@as(c_uint, 4));
    pub const flags_colorspace: MetadataLoadFlags = @bitCast(@as(c_uint, 8));
    pub const flags_all: MetadataLoadFlags = @bitCast(@as(c_uint, 4294967295));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// What kinds of metadata to save when exporting images.
pub const MetadataSaveFlags = packed struct(c_uint) {
    exif: bool = false,
    xmp: bool = false,
    iptc: bool = false,
    thumbnail: bool = false,
    color_profile: bool = false,
    comment: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_exif: MetadataSaveFlags = @bitCast(@as(c_uint, 1));
    pub const flags_xmp: MetadataSaveFlags = @bitCast(@as(c_uint, 2));
    pub const flags_iptc: MetadataSaveFlags = @bitCast(@as(c_uint, 4));
    pub const flags_thumbnail: MetadataSaveFlags = @bitCast(@as(c_uint, 8));
    pub const flags_color_profile: MetadataSaveFlags = @bitCast(@as(c_uint, 16));
    pub const flags_comment: MetadataSaveFlags = @bitCast(@as(c_uint, 32));
    pub const flags_all: MetadataSaveFlags = @bitCast(@as(c_uint, 4294967295));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The cases when a `gimp.Procedure` should be shown as sensitive.
pub const ProcedureSensitivityMask = packed struct(c_uint) {
    drawable: bool = false,
    _padding1: bool = false,
    drawables: bool = false,
    no_drawables: bool = false,
    no_image: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    _padding10: bool = false,
    _padding11: bool = false,
    _padding12: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    _padding20: bool = false,
    _padding21: bool = false,
    _padding22: bool = false,
    _padding23: bool = false,
    _padding24: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_drawable: ProcedureSensitivityMask = @bitCast(@as(c_uint, 1));
    pub const flags_drawables: ProcedureSensitivityMask = @bitCast(@as(c_uint, 4));
    pub const flags_no_drawables: ProcedureSensitivityMask = @bitCast(@as(c_uint, 8));
    pub const flags_no_image: ProcedureSensitivityMask = @bitCast(@as(c_uint, 16));
    pub const flags_always: ProcedureSensitivityMask = @bitCast(@as(c_uint, 2147483647));
    extern fn gimp_procedure_sensitivity_mask_get_type() usize;
    pub const getGObjectType = gimp_procedure_sensitivity_mask_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn gimp_adaptive_supersample_area(p_x1: c_int, p_y1: c_int, p_x2: c_int, p_y2: c_int, p_max_depth: c_int, p_threshold: f64, p_render_func: gimp.RenderFunc, p_render_data: ?*anyopaque, p_put_pixel_func: gimp.PutPixelFunc, p_put_pixel_data: ?*anyopaque, p_progress_func: gimp.ProgressFunc, p_progress_data: ?*anyopaque) c_ulong;
pub const adaptiveSupersampleArea = gimp_adaptive_supersample_area;

/// Paint in the current brush with varying pressure. Paint application
/// is time-dependent.
///
/// This tool simulates the use of an airbrush. Paint pressure
/// represents the relative intensity of the paint application. High
/// pressure results in a thicker layer of paint while low pressure
/// results in a thinner layer.
extern fn gimp_airbrush(p_drawable: *gimp.Drawable, p_pressure: f64, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const airbrush = gimp_airbrush;

/// Paint in the current brush with varying pressure. Paint application
/// is time-dependent.
///
/// This tool simulates the use of an airbrush. It is similar to
/// `gimp.airbrush` except that the pressure is derived from the
/// airbrush tools options box. It the option has not been set the
/// default for the option will be used.
extern fn gimp_airbrush_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const airbrushDefault = gimp_airbrush_default;

/// This function takes any string (UTF-8 or not) and always returns a valid
/// UTF-8 string.
///
/// If `str` is valid UTF-8, a copy of the string is returned.
///
/// If UTF-8 validation fails, `glib.localeToUtf8` is tried and if it
/// succeeds the resulting string is returned.
///
/// Otherwise, the portion of `str` that is UTF-8, concatenated
/// with "(invalid UTF-8 string)" is returned. If not even the start
/// of `str` is valid UTF-8, only "(invalid UTF-8 string)" is returned.
extern fn gimp_any_to_utf8(p_str: [*]const u8, p_len: isize, p_warning_format: [*:0]const u8, ...) [*:0]u8;
pub const anyToUtf8 = gimp_any_to_utf8;

/// Add a global parasite.
///
/// This procedure attaches a global parasite. It has no return values.
extern fn gimp_attach_parasite(p_parasite: *const gimp.Parasite) c_int;
pub const attachParasite = gimp_attach_parasite;

extern fn gimp_babl_format_get_type() usize;
pub const bablFormatGetType = gimp_babl_format_get_type;

extern fn gimp_bilinear(p_x: f64, p_y: f64, p_values: *[4]f64) f64;
pub const bilinear = gimp_bilinear;

extern fn gimp_bilinear_16(p_x: f64, p_y: f64, p_values: *[4]u16) u16;
pub const bilinear16 = gimp_bilinear_16;

extern fn gimp_bilinear_32(p_x: f64, p_y: f64, p_values: *[4]u32) u32;
pub const bilinear32 = gimp_bilinear_32;

extern fn gimp_bilinear_8(p_x: f64, p_y: f64, p_values: *[4]u8) u8;
pub const bilinear8 = gimp_bilinear_8;

extern fn gimp_bilinear_rgb(p_x: f64, p_y: f64, p_values: *[16]f64, p_has_alpha: c_int, p_retvalues: *[4]f64) void;
pub const bilinearRgb = gimp_bilinear_rgb;

/// This function wraps bindtextdomain on UNIX and wbintextdomain on Windows.
/// `dir_name` is expected to be in the encoding used by the C library on UNIX
/// and UTF-8 on Windows.
extern fn gimp_bind_text_domain(p_domain_name: [*:0]const u8, p_dir_name: [*:0]const u8) void;
pub const bindTextDomain = gimp_bind_text_domain;

/// Close the brush selection dialog.
///
/// Closes an open brush selection dialog.
extern fn gimp_brushes_close_popup(p_brush_callback: [*:0]const u8) c_int;
pub const brushesClosePopup = gimp_brushes_close_popup;

/// Retrieve a complete listing of the available brushes.
///
/// This procedure returns a complete listing of available GIMP brushes.
/// Each brush returned can be used as input to
/// `gimp.contextSetBrush`.
extern fn gimp_brushes_get_list(p_filter: [*:0]const u8) [*]*gimp.Brush;
pub const brushesGetList = gimp_brushes_get_list;

/// Invokes the GIMP brush selection dialog.
///
/// Opens a dialog letting a user choose a brush.
extern fn gimp_brushes_popup(p_brush_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_initial_brush: ?*gimp.Brush, p_parent_window: ?*glib.Bytes) c_int;
pub const brushesPopup = gimp_brushes_popup;

/// Refresh current brushes. This function always succeeds.
///
/// This procedure retrieves all brushes currently in the user's brush
/// path and updates the brush dialogs accordingly.
extern fn gimp_brushes_refresh() c_int;
pub const brushesRefresh = gimp_brushes_refresh;

/// Sets the selected brush in a brush selection dialog.
///
/// Sets the selected brush in a brush selection dialog.
extern fn gimp_brushes_set_popup(p_brush_callback: [*:0]const u8, p_brush: *gimp.Brush) c_int;
pub const brushesSetPopup = gimp_brushes_set_popup;

/// Deletes a named buffer.
///
/// This procedure deletes a named buffer.
extern fn gimp_buffer_delete(p_buffer_name: [*:0]const u8) c_int;
pub const bufferDelete = gimp_buffer_delete;

/// Retrieves the specified buffer's bytes.
///
/// This procedure retrieves the specified named buffer's bytes.
extern fn gimp_buffer_get_bytes(p_buffer_name: [*:0]const u8) c_int;
pub const bufferGetBytes = gimp_buffer_get_bytes;

/// Retrieves the specified buffer's height.
///
/// This procedure retrieves the specified named buffer's height.
extern fn gimp_buffer_get_height(p_buffer_name: [*:0]const u8) c_int;
pub const bufferGetHeight = gimp_buffer_get_height;

/// Retrieves the specified buffer's image type.
///
/// This procedure retrieves the specified named buffer's image type.
extern fn gimp_buffer_get_image_type(p_buffer_name: [*:0]const u8) gimp.ImageType;
pub const bufferGetImageType = gimp_buffer_get_image_type;

/// Retrieves the specified buffer's width.
///
/// This procedure retrieves the specified named buffer's width.
extern fn gimp_buffer_get_width(p_buffer_name: [*:0]const u8) c_int;
pub const bufferGetWidth = gimp_buffer_get_width;

/// Renames a named buffer.
///
/// This procedure renames a named buffer.
extern fn gimp_buffer_rename(p_buffer_name: [*:0]const u8, p_new_name: [*:0]const u8) [*:0]u8;
pub const bufferRename = gimp_buffer_rename;

/// Retrieve a complete listing of the available buffers.
///
/// This procedure returns a complete listing of available named
/// buffers.
extern fn gimp_buffers_get_name_list(p_filter: ?[*:0]const u8) [*][*:0]u8;
pub const buffersGetNameList = gimp_buffers_get_name_list;

/// Returns the default top directory for GIMP cached files. If the
/// environment variable GIMP3_CACHEDIR exists, that is used.  It
/// should be an absolute pathname.  Otherwise, a subdirectory of the
/// directory returned by `glib.getUserCacheDir` is used.
///
/// Note that the actual directories used for GIMP caches files can
/// be overridden by the user in the preferences dialog.
///
/// In config files such as gimprc, the string ${gimp_cache_dir}
/// expands to this directory.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8. (On Windows it always is
/// UTF-8.).
extern fn gimp_cache_directory() [*:0]const u8;
pub const cacheDirectory = gimp_cache_directory;

/// Create a repeating checkerboard pattern.
extern fn gimp_cairo_checkerboard_create(p_cr: *cairo.Context, p_size: c_int, p_light: *const gegl.Color, p_dark: *const gegl.Color) *cairo.Pattern;
pub const cairoCheckerboardCreate = gimp_cairo_checkerboard_create;

/// This function returns a `gegl.Buffer` which wraps `surface`'s pixels.
/// It must only be called on image surfaces, calling it on other surface
/// types is an error.
///
/// If `format` is set, the returned `gegl.Buffer` will use it. It has to
/// map with `surface` Cairo format. If unset, the buffer format will be
/// determined from `surface`. The main difference is that automatically
/// determined format has sRGB space and TRC by default.
extern fn gimp_cairo_surface_create_buffer(p_surface: *cairo.Surface, p_format: *const babl.Object) *gegl.Buffer;
pub const cairoSurfaceCreateBuffer = gimp_cairo_surface_create_buffer;

/// This function returns a `babl.Object` format that corresponds to `surface`'s
/// pixel format.
extern fn gimp_cairo_surface_get_format(p_surface: *cairo.Surface) *const babl.Object;
pub const cairoSurfaceGetFormat = gimp_cairo_surface_get_format;

/// Turns any input string into a canonicalized string.
///
/// Canonical identifiers are e.g. expected by the PDB for procedure
/// and parameter names. Every character of the input string that is
/// not either '-', 'a-z', 'A-Z' or '0-9' will be replaced by a '-'.
extern fn gimp_canonicalize_identifier(p_identifier: [*:0]const u8) [*:0]u8;
pub const canonicalizeIdentifier = gimp_canonicalize_identifier;

/// Returns the first checkerboard custom color that can
/// be used in previews.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_check_custom_color1() *const gegl.Color;
pub const checkCustomColor1 = gimp_check_custom_color1;

/// Returns the second checkerboard custom color that can
/// be used in previews.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_check_custom_color2() *const gegl.Color;
pub const checkCustomColor2 = gimp_check_custom_color2;

/// Returns the size of the checkerboard to be used in previews.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_check_size() gimp.CheckSize;
pub const checkSize = gimp_check_size;

/// Returns the type of the checkerboard to be used in previews.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_check_type() gimp.CheckType;
pub const checkType = gimp_check_type;

/// Retrieves the colors to use when drawing a checkerboard for a certain
/// `gimp.CheckType` and custom colors.
/// If `type` is `GIMP_CHECK_TYPE_CUSTOM_CHECKS`, then `color1` and `color2`
/// will remain untouched, which means you must initialize them to the
/// values expected for custom checks.
///
/// To obtain the user-set colors in Preferences, just call:
/// ```
/// GeglColor *color1 = gimp_check_custom_color1 ();
/// GeglColor *color2 = gimp_check_custom_color2 ();
/// gimp_checks_get_colors (gimp_check_type (), &color1, &color2);
/// ```
extern fn gimp_checks_get_colors(p_type: gimp.CheckType, p_color1: **gegl.Color, p_color2: **gegl.Color) void;
pub const checksGetColors = gimp_checks_get_colors;

/// Clone from the source to the dest drawable using the current brush
///
/// This tool clones (copies) from the source drawable starting at the
/// specified source coordinates to the dest drawable. If the
/// \"clone_type\" argument is set to PATTERN-CLONE, then the current
/// pattern is used as the source and the \"src_drawable\" argument is
/// ignored. Pattern cloning assumes a tileable pattern and mods the sum
/// of the src coordinates and subsequent stroke offsets with the width
/// and height of the pattern. For image cloning, if the sum of the src
/// coordinates and subsequent stroke offsets exceeds the extents of the
/// src drawable, then no paint is transferred. The clone tool is
/// capable of transforming between any image types including
/// RGB-&gt;Indexed--although converting from any type to indexed is
/// significantly slower.
extern fn gimp_clone(p_drawable: *gimp.Drawable, p_src_drawable: *gimp.Drawable, p_clone_type: gimp.CloneType, p_src_x: f64, p_src_y: f64, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const clone = gimp_clone;

/// Clone from the source to the dest drawable using the current brush
///
/// This tool clones (copies) from the source drawable starting at the
/// specified source coordinates to the dest drawable. This function
/// performs exactly the same as the `gimp.clone` function except that
/// the tools arguments are obtained from the clones option dialog. It
/// this dialog has not been activated then the dialogs default values
/// will be used.
extern fn gimp_clone_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const cloneDefault = gimp_clone_default;

/// Creates a new `gimp.ColorArray` containing a deep copy of a `NULL`-terminated
/// array of `gegl.Color`.
extern fn gimp_color_array_copy(p_array: gimp.ColorArray) gimp.ColorArray;
pub const colorArrayCopy = gimp_color_array_copy;

/// Frees a `NULL`-terminated array of `gegl.Color`.
extern fn gimp_color_array_free(p_array: gimp.ColorArray) void;
pub const colorArrayFree = gimp_color_array_free;

extern fn gimp_color_array_get_length(p_array: gimp.ColorArray) c_int;
pub const colorArrayGetLength = gimp_color_array_get_length;

extern fn gimp_color_array_get_type() usize;
pub const colorArrayGetType = gimp_color_array_get_type;

/// Determine whether `color` is out of its `space` gamut.
/// A small error of margin is accepted, so that for instance a component
/// at -0.0000001 is not making the whole color to be considered as
/// out-of-gamut while it may just be computation imprecision.
extern fn gimp_color_is_out_of_gamut(p_color: *gegl.Color, p_space: *const babl.Object) c_int;
pub const colorIsOutOfGamut = gimp_color_is_out_of_gamut;

/// Determine whether `color` is out of its own space gamut. This can only
/// happen if the color space is unbounded and any of the color component
/// is out of the `[0; 1]` range.
/// A small error of margin is accepted, so that for instance a component
/// at -0.0000001 is not making the whole color to be considered as
/// out-of-gamut while it may just be computation imprecision.
extern fn gimp_color_is_out_of_self_gamut(p_color: *gegl.Color) c_int;
pub const colorIsOutOfSelfGamut = gimp_color_is_out_of_self_gamut;

/// Determine whether `color1` and `color2` can be considered identical to the
/// human eyes, by computing the distance in a color space as perceptually
/// uniform as possible.
///
/// This function will also consider any transparency channel, so that if you
/// only want to compare the pure color, you could for instance set both color's
/// alpha channel to 1.0 first (possibly on duplicates of the colors if originals
/// should not be modified), such as:
///
/// ```C
/// gimp_color_set_alpha (color1, 1.0);
/// gimp_color_set_alpha (color2, 1.0);
/// if (gimp_color_is_perceptually_identical (color1, color2))
///   {
///     printf ("Both colors are identical, ignoring their alpha component");
///   }
/// ```
extern fn gimp_color_is_perceptually_identical(p_color1: *gegl.Color, p_color2: *gegl.Color) c_int;
pub const colorIsPerceptuallyIdentical = gimp_color_is_perceptually_identical;

/// Returns the list of [SVG 1.0 color
/// keywords](https://www.w3.org/TR/SVG/types.html) that is recognized by
/// `colorParseName`.
///
/// The returned strings are const and must not be freed. Only the array
/// must be freed with ``glib.free``.
///
/// The optional `colors` arrays must be freed with `colorArrayFree` when
/// they are no longer needed.
extern fn gimp_color_list_names(p_colors: ?*[*]gegl.Color) [*][*:0]const u8;
pub const colorListNames = gimp_color_list_names;

/// Attempts to parse a string describing an sRGB color in CSS notation. This can
/// be either a numerical representation (`rgb(255,0,0)` or `rgb(100%,0%,0%)`)
/// or a hexadecimal notation as parsed by `colorParseHex` (`#`ff0000``) or
/// a color name as parsed by `colorParseCss` (`red`).
///
/// Additionally the ``rgba``, ``hsl`` and ``hsla`` functions are supported too.
extern fn gimp_color_parse_css(p_css: [*:0]const u8) *gegl.Color;
pub const colorParseCss = gimp_color_parse_css;

/// Attempts to parse a string describing an sRGB color in CSS notation. This can
/// be either a numerical representation (`rgb(255,0,0)` or `rgb(100%,0%,0%)`) or
/// a hexadecimal notation as parsed by `colorParseHex` (`#`ff0000``) or a
/// color name as parsed by `colorParseName` (`red`).
///
/// Additionally the ``rgba``, ``hsl`` and ``hsla`` functions are supported too.
extern fn gimp_color_parse_css_substring(p_css: [*]const u8, p_len: c_int) *gegl.Color;
pub const colorParseCssSubstring = gimp_color_parse_css_substring;

/// Attempts to parse a string describing a sRGB color in hexadecimal
/// notation (optionally prefixed with a '#').
extern fn gimp_color_parse_hex(p_hex: [*:0]const u8) *gegl.Color;
pub const colorParseHex = gimp_color_parse_hex;

/// Attempts to parse a string describing an RGB color in hexadecimal
/// notation (optionally prefixed with a '#').
///
/// This function does not touch the alpha component of `rgb`.
extern fn gimp_color_parse_hex_substring(p_hex: [*]const u8, p_len: c_int) *gegl.Color;
pub const colorParseHexSubstring = gimp_color_parse_hex_substring;

/// Attempts to parse a color name. This function accepts [SVG 1.1 color
/// keywords](https://www.w3.org/TR/SVG11/types.html`ColorKeywords`).
extern fn gimp_color_parse_name(p_name: [*:0]const u8) *gegl.Color;
pub const colorParseName = gimp_color_parse_name;

/// Attempts to parse a color name. This function accepts [SVG 1.1 color
/// keywords](https://www.w3.org/TR/SVG11/types.html`ColorKeywords`).
extern fn gimp_color_parse_name_substring(p_name: [*]const u8, p_len: c_int) *gegl.Color;
pub const colorParseNameSubstring = gimp_color_parse_name_substring;

/// Update the `alpha` channel, and any other component if necessary (e.g. in case
/// of premultiplied channels), without changing the format of `color`.
///
/// If `color` has no alpha component, this function is a no-op.
extern fn gimp_color_set_alpha(p_color: *gegl.Color, p_alpha: f64) void;
pub const colorSetAlpha = gimp_color_set_alpha;

/// Whether the currently active paint dynamics will be applied to
/// painting.
///
/// Returns whether the currently active paint dynamics (as returned by
/// `gimp_context_get_dynamics`) is enabled.
extern fn gimp_context_are_dynamics_enabled() c_int;
pub const contextAreDynamicsEnabled = gimp_context_are_dynamics_enabled;

/// Enables paint dynamics using the active paint dynamics.
///
/// Enables the active paint dynamics to be used in all subsequent paint
/// operations.
extern fn gimp_context_enable_dynamics(p_enable: c_int) c_int;
pub const contextEnableDynamics = gimp_context_enable_dynamics;

/// Get the antialias setting.
///
/// Returns the antialias setting.
extern fn gimp_context_get_antialias() c_int;
pub const contextGetAntialias = gimp_context_get_antialias;

/// Get the current GIMP background color.
///
/// Returns the current GIMP background color. The background color is
/// used in a variety of tools such as blending, erasing (with non-alpha
/// images), and image filling.
extern fn gimp_context_get_background() *gegl.Color;
pub const contextGetBackground = gimp_context_get_background;

/// Get the currently active brush.
///
/// Returns the currently active brush. All paint and stroke operations
/// use this brush.
extern fn gimp_context_get_brush() *gimp.Brush;
pub const contextGetBrush = gimp_context_get_brush;

/// Get brush angle in degrees.
///
/// Set the angle in degrees for brush based paint tools.
extern fn gimp_context_get_brush_angle() f64;
pub const contextGetBrushAngle = gimp_context_get_brush_angle;

/// Get brush aspect ratio.
///
/// Set the aspect ratio for brush based paint tools.
extern fn gimp_context_get_brush_aspect_ratio() f64;
pub const contextGetBrushAspectRatio = gimp_context_get_brush_aspect_ratio;

/// Get brush force in paint options.
///
/// Get the brush application force for brush based paint tools.
extern fn gimp_context_get_brush_force() f64;
pub const contextGetBrushForce = gimp_context_get_brush_force;

/// Get brush hardness in paint options.
///
/// Get the brush hardness for brush based paint tools.
extern fn gimp_context_get_brush_hardness() f64;
pub const contextGetBrushHardness = gimp_context_get_brush_hardness;

/// Get brush size in pixels.
///
/// Get the brush size in pixels for brush based paint tools.
extern fn gimp_context_get_brush_size() f64;
pub const contextGetBrushSize = gimp_context_get_brush_size;

/// Get brush spacing as percent of size.
///
/// Get the brush spacing as percent of size for brush based paint
/// tools.
extern fn gimp_context_get_brush_spacing() f64;
pub const contextGetBrushSpacing = gimp_context_get_brush_spacing;

/// Get the diagonal neighbors setting.
///
/// Returns the diagonal neighbors setting.
extern fn gimp_context_get_diagonal_neighbors() c_int;
pub const contextGetDiagonalNeighbors = gimp_context_get_diagonal_neighbors;

/// Get the distance metric used in some computations.
///
/// Returns the distance metric in the current context. See
/// `gimp.contextSetDistanceMetric` to know more about its usage.
extern fn gimp_context_get_distance_metric() gegl.DistanceMetric;
pub const contextGetDistanceMetric = gimp_context_get_distance_metric;

/// Get the currently active paint dynamics.
///
/// Returns the name of the currently active paint dynamics. If enabled,
/// all paint operations and stroke operations use this paint dynamics
/// to control the application of paint to the image. If disabled, the
/// dynamics will be ignored during paint actions.
/// See `gimp.contextAreDynamicsEnabled` to enquire whether dynamics
/// are used or ignored.
extern fn gimp_context_get_dynamics_name() [*:0]u8;
pub const contextGetDynamicsName = gimp_context_get_dynamics_name;

/// Retrieve the currently active stroke option's emulate brush dynamics
/// setting.
///
/// This procedure returns the emulate brush dynamics property of the
/// currently active stroke options.
extern fn gimp_context_get_emulate_brush_dynamics() c_int;
pub const contextGetEmulateBrushDynamics = gimp_context_get_emulate_brush_dynamics;

/// Get the feather setting.
///
/// Returns the feather setting.
extern fn gimp_context_get_feather() c_int;
pub const contextGetFeather = gimp_context_get_feather;

/// Get the feather radius setting.
///
/// Returns the feather radius setting.
extern fn gimp_context_get_feather_radius(p_feather_radius_x: *f64, p_feather_radius_y: *f64) c_int;
pub const contextGetFeatherRadius = gimp_context_get_feather_radius;

/// Get the currently active font.
///
/// Returns the currently active font.
extern fn gimp_context_get_font() *gimp.Font;
pub const contextGetFont = gimp_context_get_font;

/// Get the current GIMP foreground color.
///
/// Returns the current GIMP foreground color. The foreground color is
/// used in a variety of tools such as paint tools, blending, and bucket
/// fill.
extern fn gimp_context_get_foreground() *gegl.Color;
pub const contextGetForeground = gimp_context_get_foreground;

/// Get the currently active gradient.
///
/// Returns the currently active gradient.
extern fn gimp_context_get_gradient() *gimp.Gradient;
pub const contextGetGradient = gimp_context_get_gradient;

/// Get the gradient blend color space.
///
/// Get the gradient blend color space for paint tools and the gradient
/// tool.
extern fn gimp_context_get_gradient_blend_color_space() gimp.GradientBlendColorSpace;
pub const contextGetGradientBlendColorSpace = gimp_context_get_gradient_blend_color_space;

/// Get the gradient repeat mode.
///
/// Get the gradient repeat mode for paint tools and the gradient tool.
extern fn gimp_context_get_gradient_repeat_mode() gimp.RepeatMode;
pub const contextGetGradientRepeatMode = gimp_context_get_gradient_repeat_mode;

/// Get the gradient reverse setting.
///
/// Get the gradient reverse setting for paint tools and the gradient
/// tool.
extern fn gimp_context_get_gradient_reverse() c_int;
pub const contextGetGradientReverse = gimp_context_get_gradient_reverse;

/// Get ink angle in degrees.
///
/// Get the ink angle in degrees for ink tool.
extern fn gimp_context_get_ink_angle() f64;
pub const contextGetInkAngle = gimp_context_get_ink_angle;

/// Get ink blob angle in degrees.
///
/// Get the ink blob angle in degrees for ink tool.
extern fn gimp_context_get_ink_blob_angle() f64;
pub const contextGetInkBlobAngle = gimp_context_get_ink_blob_angle;

/// Get ink blob aspect ratio.
///
/// Get the ink blob aspect ratio for ink tool.
extern fn gimp_context_get_ink_blob_aspect_ratio() f64;
pub const contextGetInkBlobAspectRatio = gimp_context_get_ink_blob_aspect_ratio;

/// Get ink blob type.
///
/// Get the ink blob type for ink tool.
extern fn gimp_context_get_ink_blob_type() gimp.InkBlobType;
pub const contextGetInkBlobType = gimp_context_get_ink_blob_type;

/// Get ink blob size in pixels.
///
/// Get the ink blob size in pixels for ink tool.
extern fn gimp_context_get_ink_size() f64;
pub const contextGetInkSize = gimp_context_get_ink_size;

/// Get ink size sensitivity.
///
/// Get the ink size sensitivity for ink tool.
extern fn gimp_context_get_ink_size_sensitivity() f64;
pub const contextGetInkSizeSensitivity = gimp_context_get_ink_size_sensitivity;

/// Get ink speed sensitivity.
///
/// Get the ink speed sensitivity for ink tool.
extern fn gimp_context_get_ink_speed_sensitivity() f64;
pub const contextGetInkSpeedSensitivity = gimp_context_get_ink_speed_sensitivity;

/// Get ink tilt sensitivity.
///
/// Get the ink tilt sensitivity for ink tool.
extern fn gimp_context_get_ink_tilt_sensitivity() f64;
pub const contextGetInkTiltSensitivity = gimp_context_get_ink_tilt_sensitivity;

/// Get the interpolation type.
///
/// Returns the interpolation setting. The return value is an integer
/// which corresponds to the values listed in the argument description.
/// If the interpolation has not been set explicitly by
/// `gimp.contextSetInterpolation`, the default interpolation set in
/// gimprc will be used.
extern fn gimp_context_get_interpolation() gimp.InterpolationType;
pub const contextGetInterpolation = gimp_context_get_interpolation;

/// Get the line cap style setting.
///
/// Returns the line cap style setting.
extern fn gimp_context_get_line_cap_style() gimp.CapStyle;
pub const contextGetLineCapStyle = gimp_context_get_line_cap_style;

/// Get the line dash offset setting.
///
/// Returns the line dash offset setting.
extern fn gimp_context_get_line_dash_offset() f64;
pub const contextGetLineDashOffset = gimp_context_get_line_dash_offset;

/// Get the line dash pattern setting.
///
/// Returns the line dash pattern setting.
extern fn gimp_context_get_line_dash_pattern(p_num_dashes: *usize, p_dashes: *[*]f64) c_int;
pub const contextGetLineDashPattern = gimp_context_get_line_dash_pattern;

/// Get the line join style setting.
///
/// Returns the line join style setting.
extern fn gimp_context_get_line_join_style() gimp.JoinStyle;
pub const contextGetLineJoinStyle = gimp_context_get_line_join_style;

/// Get the line miter limit setting.
///
/// Returns the line miter limit setting.
extern fn gimp_context_get_line_miter_limit() f64;
pub const contextGetLineMiterLimit = gimp_context_get_line_miter_limit;

/// Get the line width setting.
///
/// Returns the line width setting.
extern fn gimp_context_get_line_width() f64;
pub const contextGetLineWidth = gimp_context_get_line_width;

/// Get the line width unit setting.
///
/// Returns the line width unit setting.
extern fn gimp_context_get_line_width_unit() *gimp.Unit;
pub const contextGetLineWidthUnit = gimp_context_get_line_width_unit;

/// Get the currently active MyPaint brush.
///
/// Returns the name of the currently active MyPaint brush.
extern fn gimp_context_get_mypaint_brush() [*:0]u8;
pub const contextGetMypaintBrush = gimp_context_get_mypaint_brush;

/// Get the opacity.
///
/// Returns the opacity setting. The return value is a floating point
/// number between 0 and 100.
extern fn gimp_context_get_opacity() f64;
pub const contextGetOpacity = gimp_context_get_opacity;

/// Get the currently active paint method.
///
/// Returns the name of the currently active paint method.
extern fn gimp_context_get_paint_method() [*:0]u8;
pub const contextGetPaintMethod = gimp_context_get_paint_method;

/// Get the paint mode.
///
/// Returns the paint-mode setting. The return value is an integer which
/// corresponds to the values listed in the argument description.
extern fn gimp_context_get_paint_mode() gimp.LayerMode;
pub const contextGetPaintMode = gimp_context_get_paint_mode;

/// Get the currently active palette.
///
/// Returns the currently active palette.
extern fn gimp_context_get_palette() *gimp.Palette;
pub const contextGetPalette = gimp_context_get_palette;

/// Get the currently active pattern.
///
/// Returns the active pattern in the current context. All clone and
/// bucket-fill operations with patterns will use this pattern to
/// control the application of paint to the image.
extern fn gimp_context_get_pattern() *gimp.Pattern;
pub const contextGetPattern = gimp_context_get_pattern;

/// Get the sample criterion setting.
///
/// Returns the sample criterion setting.
extern fn gimp_context_get_sample_criterion() gimp.SelectCriterion;
pub const contextGetSampleCriterion = gimp_context_get_sample_criterion;

/// Get the sample merged setting.
///
/// Returns the sample merged setting.
extern fn gimp_context_get_sample_merged() c_int;
pub const contextGetSampleMerged = gimp_context_get_sample_merged;

/// Get the sample threshold setting.
///
/// Returns the sample threshold setting.
extern fn gimp_context_get_sample_threshold() f64;
pub const contextGetSampleThreshold = gimp_context_get_sample_threshold;

/// Get the sample threshold setting as an integer value.
///
/// Returns the sample threshold setting as an integer value. See
/// `gimp.contextGetSampleThreshold`.
extern fn gimp_context_get_sample_threshold_int() c_int;
pub const contextGetSampleThresholdInt = gimp_context_get_sample_threshold_int;

/// Get the sample transparent setting.
///
/// Returns the sample transparent setting.
extern fn gimp_context_get_sample_transparent() c_int;
pub const contextGetSampleTransparent = gimp_context_get_sample_transparent;

/// Get the currently active stroke method.
///
/// Returns the currently active stroke method.
extern fn gimp_context_get_stroke_method() gimp.StrokeMethod;
pub const contextGetStrokeMethod = gimp_context_get_stroke_method;

/// Get the transform direction.
///
/// Returns the transform direction. The return value is an integer
/// which corresponds to the values listed in the argument description.
extern fn gimp_context_get_transform_direction() gimp.TransformDirection;
pub const contextGetTransformDirection = gimp_context_get_transform_direction;

/// Get the transform resize type.
///
/// Returns the transform resize setting. The return value is an integer
/// which corresponds to the values listed in the argument description.
extern fn gimp_context_get_transform_resize() gimp.TransformResize;
pub const contextGetTransformResize = gimp_context_get_transform_resize;

/// Lists the available paint methods.
///
/// Lists the names of the available paint methods. Any of the names can
/// be used for `gimp.contextSetPaintMethod`.
extern fn gimp_context_list_paint_methods(p_paint_methods: *[*][*:0]u8) c_int;
pub const contextListPaintMethods = gimp_context_list_paint_methods;

/// Pops the topmost context from the plug-in's context stack.
///
/// Removes the topmost context from the plug-in's context stack. The
/// next context on the stack becomes the new current context of the
/// plug-in, that is, the context that was active before the
/// corresponding call to `gimp.contextPush`
extern fn gimp_context_pop() c_int;
pub const contextPop = gimp_context_pop;

/// Pushes a context onto the top of the plug-in's context stack.
///
/// Creates a new context by copying the current context. The copy
/// becomes the new current context for the calling plug-in until it is
/// popped again using `gimp.contextPop`.
extern fn gimp_context_push() c_int;
pub const contextPush = gimp_context_push;

/// Set the antialias setting.
///
/// Modifies the antialias setting. If antialiasing is turned on, the
/// edges of selected region will contain intermediate values which give
/// the appearance of a sharper, less pixelized edge. This should be set
/// as TRUE most of the time unless a binary-only selection is wanted.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Image.selectRoundRectangle`, `gimp.Image.selectEllipse`,
/// `gimp.Image.selectPolygon`, `gimp.Image.selectItem`,
/// `gimp.Drawable.editBucketFill`, `gimp.Drawable.editStrokeItem`,
/// `gimp.Drawable.editStrokeSelection`.
extern fn gimp_context_set_antialias(p_antialias: c_int) c_int;
pub const contextSetAntialias = gimp_context_set_antialias;

/// Set the current GIMP background color.
///
/// Sets the current GIMP background color. After this is set,
/// operations which use background such as blending, filling images,
/// clearing, and erasing (in non-alpha images) will use the new value.
extern fn gimp_context_set_background(p_background: *gegl.Color) c_int;
pub const contextSetBackground = gimp_context_set_background;

/// Set the active brush.
///
/// Sets the active brush in the current context. The brush will be used
/// in subsequent paint and stroke operations. Returns an error when the
/// brush data was uninstalled since the brush object was created.
extern fn gimp_context_set_brush(p_brush: *gimp.Brush) c_int;
pub const contextSetBrush = gimp_context_set_brush;

/// Set brush angle in degrees.
///
/// Set the angle in degrees for brush based paint tools.
extern fn gimp_context_set_brush_angle(p_angle: f64) c_int;
pub const contextSetBrushAngle = gimp_context_set_brush_angle;

/// Set brush aspect ratio.
///
/// Set the aspect ratio for brush based paint tools.
extern fn gimp_context_set_brush_aspect_ratio(p_aspect: f64) c_int;
pub const contextSetBrushAspectRatio = gimp_context_set_brush_aspect_ratio;

/// Set brush spacing to its default.
///
/// Set the brush spacing to the default for paintbrush, airbrush, or
/// pencil tools.
extern fn gimp_context_set_brush_default_hardness() c_int;
pub const contextSetBrushDefaultHardness = gimp_context_set_brush_default_hardness;

/// Set brush size to its default.
///
/// Set the brush size to the default (max of width and height) for
/// paintbrush, airbrush, or pencil tools.
extern fn gimp_context_set_brush_default_size() c_int;
pub const contextSetBrushDefaultSize = gimp_context_set_brush_default_size;

/// Set brush spacing to its default.
///
/// Set the brush spacing to the default for paintbrush, airbrush, or
/// pencil tools.
extern fn gimp_context_set_brush_default_spacing() c_int;
pub const contextSetBrushDefaultSpacing = gimp_context_set_brush_default_spacing;

/// Set brush application force.
///
/// Set the brush application force for brush based paint tools.
extern fn gimp_context_set_brush_force(p_force: f64) c_int;
pub const contextSetBrushForce = gimp_context_set_brush_force;

/// Set brush hardness.
///
/// Set the brush hardness for brush based paint tools.
extern fn gimp_context_set_brush_hardness(p_hardness: f64) c_int;
pub const contextSetBrushHardness = gimp_context_set_brush_hardness;

/// Set brush size in pixels.
///
/// Set the brush size in pixels for brush based paint tools.
extern fn gimp_context_set_brush_size(p_size: f64) c_int;
pub const contextSetBrushSize = gimp_context_set_brush_size;

/// Set brush spacing as percent of size.
///
/// Set the brush spacing as percent of size for brush based paint
/// tools.
extern fn gimp_context_set_brush_spacing(p_spacing: f64) c_int;
pub const contextSetBrushSpacing = gimp_context_set_brush_spacing;

/// Set the current GIMP foreground and background colors to black and
/// white.
///
/// Sets the current GIMP foreground and background colors to their
/// initial default values, black and white.
extern fn gimp_context_set_default_colors() c_int;
pub const contextSetDefaultColors = gimp_context_set_default_colors;

/// Reset context settings to their default values.
///
/// Resets context settings used by various procedures to their default
/// value. You should usually call this after a context push so that a
/// script which calls procedures affected by context settings will not
/// be affected by changes in the global context.
extern fn gimp_context_set_defaults() c_int;
pub const contextSetDefaults = gimp_context_set_defaults;

/// Set the diagonal neighbors setting.
///
/// Modifies the diagonal neighbors setting. If the affected region of
/// an operation is based on a seed point, like when doing a seed fill,
/// then, when this setting is TRUE, all eight neighbors of each pixel
/// are considered when calculating the affected region; in contrast,
/// when this setting is FALSE, only the four orthogonal neighbors of
/// each pixel are considered.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectContiguousColor`,
/// `gimp.Drawable.editBucketFill`.
extern fn gimp_context_set_diagonal_neighbors(p_diagonal_neighbors: c_int) c_int;
pub const contextSetDiagonalNeighbors = gimp_context_set_diagonal_neighbors;

/// Set the distance metric used in some computations.
///
/// Modifies the distance metric used in some computations, such as
/// `gimp.Drawable.editGradientFill`. In particular, it does not
/// change the metric used in generic distance computation on canvas, as
/// in the Measure tool.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editGradientFill`.
extern fn gimp_context_set_distance_metric(p_metric: gegl.DistanceMetric) c_int;
pub const contextSetDistanceMetric = gimp_context_set_distance_metric;

/// Set the active paint dynamics.
///
/// Sets the active paint dynamics. The paint dynamics will be used in
/// all subsequent paint operations when dynamics are enabled. The name
/// should be a name of an installed paint dynamics. Returns an error if
/// no matching paint dynamics is found.
extern fn gimp_context_set_dynamics_name(p_name: [*:0]const u8) c_int;
pub const contextSetDynamicsName = gimp_context_set_dynamics_name;

/// Set the stroke option's emulate brush dynamics setting.
///
/// This procedure sets the specified emulate brush dynamics setting.
/// The new method will be used in all subsequent stroke operations.
extern fn gimp_context_set_emulate_brush_dynamics(p_emulate_dynamics: c_int) c_int;
pub const contextSetEmulateBrushDynamics = gimp_context_set_emulate_brush_dynamics;

/// Set the feather setting.
///
/// Modifies the feather setting. If the feather option is enabled,
/// selections will be blurred before combining. The blur is a gaussian
/// blur; its radii can be controlled using
/// `gimp.contextSetFeatherRadius`.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Image.selectRectangle`, `gimp.Image.selectRoundRectangle`,
/// `gimp.Image.selectEllipse`, `gimp.Image.selectPolygon`,
/// `gimp.Image.selectItem`.
extern fn gimp_context_set_feather(p_feather: c_int) c_int;
pub const contextSetFeather = gimp_context_set_feather;

/// Set the feather radius setting.
///
/// Modifies the feather radius setting.
///
/// This setting affects all procedures that are affected by
/// `gimp.contextSetFeather`.
extern fn gimp_context_set_feather_radius(p_feather_radius_x: f64, p_feather_radius_y: f64) c_int;
pub const contextSetFeatherRadius = gimp_context_set_feather_radius;

/// Set the active font.
///
/// Sets the active font in the current context. The font will be used
/// in subsequent text operations. Returns an error when the font data
/// was uninstalled since the font object was created.
extern fn gimp_context_set_font(p_font: *gimp.Font) c_int;
pub const contextSetFont = gimp_context_set_font;

/// Set the current GIMP foreground color.
///
/// Sets the current GIMP foreground color. After this is set,
/// operations which use foreground such as paint tools, blending, and
/// bucket fill will use the new value.
extern fn gimp_context_set_foreground(p_foreground: *gegl.Color) c_int;
pub const contextSetForeground = gimp_context_set_foreground;

/// Sets the active gradient.
///
/// Sets the active gradient in the current context. The gradient will
/// be used in subsequent gradient operations. Returns an error when the
/// gradient data was uninstalled since the gradient object was created.
extern fn gimp_context_set_gradient(p_gradient: *gimp.Gradient) c_int;
pub const contextSetGradient = gimp_context_set_gradient;

/// Set the gradient blend color space.
///
/// Set the gradient blend color space for paint tools and the gradient
/// tool.
extern fn gimp_context_set_gradient_blend_color_space(p_blend_color_space: gimp.GradientBlendColorSpace) c_int;
pub const contextSetGradientBlendColorSpace = gimp_context_set_gradient_blend_color_space;

/// Sets the built-in FG-BG HSV (ccw) gradient as the active gradient.
///
/// Sets the built-in FG-BG HSV (ccw) gradient as the active gradient.
/// The gradient will be used for subsequent gradient operations.
extern fn gimp_context_set_gradient_fg_bg_hsv_ccw() c_int;
pub const contextSetGradientFgBgHsvCcw = gimp_context_set_gradient_fg_bg_hsv_ccw;

/// Sets the built-in FG-BG HSV (cw) gradient as the active gradient.
///
/// Sets the built-in FG-BG HSV (cw) gradient as the active gradient.
/// The gradient will be used for subsequent gradient operations.
extern fn gimp_context_set_gradient_fg_bg_hsv_cw() c_int;
pub const contextSetGradientFgBgHsvCw = gimp_context_set_gradient_fg_bg_hsv_cw;

/// Sets the built-in FG-BG RGB gradient as the active gradient.
///
/// Sets the built-in FG-BG RGB gradient as the active gradient. The
/// gradient will be used for subsequent gradient operations.
extern fn gimp_context_set_gradient_fg_bg_rgb() c_int;
pub const contextSetGradientFgBgRgb = gimp_context_set_gradient_fg_bg_rgb;

/// Sets the built-in FG-Transparent gradient as the active gradient.
///
/// Sets the built-in FG-Transparent gradient as the active gradient.
/// The gradient will be used for subsequent gradient operations.
extern fn gimp_context_set_gradient_fg_transparent() c_int;
pub const contextSetGradientFgTransparent = gimp_context_set_gradient_fg_transparent;

/// Set the gradient repeat mode.
///
/// Set the gradient repeat mode for paint tools and the gradient tool.
extern fn gimp_context_set_gradient_repeat_mode(p_repeat_mode: gimp.RepeatMode) c_int;
pub const contextSetGradientRepeatMode = gimp_context_set_gradient_repeat_mode;

/// Set the gradient reverse setting.
///
/// Set the gradient reverse setting for paint tools and the gradient
/// tool.
extern fn gimp_context_set_gradient_reverse(p_reverse: c_int) c_int;
pub const contextSetGradientReverse = gimp_context_set_gradient_reverse;

/// Set ink angle in degrees.
///
/// Set the ink angle in degrees for ink tool.
extern fn gimp_context_set_ink_angle(p_angle: f64) c_int;
pub const contextSetInkAngle = gimp_context_set_ink_angle;

/// Set ink blob angle in degrees.
///
/// Set the ink blob angle in degrees for ink tool.
extern fn gimp_context_set_ink_blob_angle(p_angle: f64) c_int;
pub const contextSetInkBlobAngle = gimp_context_set_ink_blob_angle;

/// Set ink blob aspect ratio.
///
/// Set the ink blob aspect ratio for ink tool.
extern fn gimp_context_set_ink_blob_aspect_ratio(p_aspect: f64) c_int;
pub const contextSetInkBlobAspectRatio = gimp_context_set_ink_blob_aspect_ratio;

/// Set ink blob type.
///
/// Set the ink blob type for ink tool.
extern fn gimp_context_set_ink_blob_type(p_type: gimp.InkBlobType) c_int;
pub const contextSetInkBlobType = gimp_context_set_ink_blob_type;

/// Set ink blob size in pixels.
///
/// Set the ink blob size in pixels for ink tool.
extern fn gimp_context_set_ink_size(p_size: f64) c_int;
pub const contextSetInkSize = gimp_context_set_ink_size;

/// Set ink size sensitivity.
///
/// Set the ink size sensitivity for ink tool.
extern fn gimp_context_set_ink_size_sensitivity(p_size: f64) c_int;
pub const contextSetInkSizeSensitivity = gimp_context_set_ink_size_sensitivity;

/// Set ink speed sensitivity.
///
/// Set the ink speed sensitivity for ink tool.
extern fn gimp_context_set_ink_speed_sensitivity(p_speed: f64) c_int;
pub const contextSetInkSpeedSensitivity = gimp_context_set_ink_speed_sensitivity;

/// Set ink tilt sensitivity.
///
/// Set the ink tilt sensitivity for ink tool.
extern fn gimp_context_set_ink_tilt_sensitivity(p_tilt: f64) c_int;
pub const contextSetInkTiltSensitivity = gimp_context_set_ink_tilt_sensitivity;

/// Set the interpolation type.
///
/// Modifies the interpolation setting.
///
/// This setting affects affects the following procedures:
/// `gimp.Item.transformFlip`, `gimp.Item.transformPerspective`,
/// `gimp.Item.transformRotate`, `gimp.Item.transformScale`,
/// `gimp.Item.transformShear`, `gimp.Item.transform2d`,
/// `gimp.Item.transformMatrix`, `gimp.Image.scale`,
/// `gimp.Layer.scale`.
extern fn gimp_context_set_interpolation(p_interpolation: gimp.InterpolationType) c_int;
pub const contextSetInterpolation = gimp_context_set_interpolation;

/// Set the line cap style setting.
///
/// Modifies the line cap style setting for stroking lines.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_cap_style(p_cap_style: gimp.CapStyle) c_int;
pub const contextSetLineCapStyle = gimp_context_set_line_cap_style;

/// Set the line dash offset setting.
///
/// Modifies the line dash offset setting for stroking lines.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_dash_offset(p_dash_offset: f64) c_int;
pub const contextSetLineDashOffset = gimp_context_set_line_dash_offset;

/// Set the line dash pattern setting.
///
/// Modifies the line dash pattern setting for stroking lines.
///
/// The unit of the dash pattern segments is the actual line width used
/// for the stroke operation, in other words a segment length of 1.0
/// results in a square segment shape (or gap shape).
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_dash_pattern(p_num_dashes: usize, p_dashes: [*]const f64) c_int;
pub const contextSetLineDashPattern = gimp_context_set_line_dash_pattern;

/// Set the line join style setting.
///
/// Modifies the line join style setting for stroking lines.
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_join_style(p_join_style: gimp.JoinStyle) c_int;
pub const contextSetLineJoinStyle = gimp_context_set_line_join_style;

/// Set the line miter limit setting.
///
/// Modifies the line miter limit setting for stroking lines.
/// A mitered join is converted to a bevelled join if the miter would
/// extend to a distance of more than (miter-limit * line-width) from
/// the actual join point.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_miter_limit(p_miter_limit: f64) c_int;
pub const contextSetLineMiterLimit = gimp_context_set_line_miter_limit;

/// Set the line width setting.
///
/// Modifies the line width setting for stroking lines.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_width(p_line_width: f64) c_int;
pub const contextSetLineWidth = gimp_context_set_line_width;

/// Set the line width unit setting.
///
/// Modifies the line width unit setting for stroking lines.
///
/// This setting affects the following procedures:
/// `gimp.Drawable.editStrokeSelection`,
/// `gimp.Drawable.editStrokeItem`.
extern fn gimp_context_set_line_width_unit(p_line_width_unit: *gimp.Unit) c_int;
pub const contextSetLineWidthUnit = gimp_context_set_line_width_unit;

/// Set a MyPaint brush as the active MyPaint brush.
///
/// Sets the active MyPaint brush to the named MyPaint brush. The brush
/// will be used in all subsequent MyPaint paint operations. The name
/// should be a name of an installed MyPaint brush. Returns an error if
/// no matching MyPaint brush is found.
extern fn gimp_context_set_mypaint_brush(p_name: [*:0]const u8) c_int;
pub const contextSetMypaintBrush = gimp_context_set_mypaint_brush;

/// Set the opacity.
///
/// Modifies the opacity setting. The value should be a floating point
/// number between 0 and 100.
extern fn gimp_context_set_opacity(p_opacity: f64) c_int;
pub const contextSetOpacity = gimp_context_set_opacity;

/// Set the active paint method.
///
/// Sets the active paint method to the named paint method. The paint
/// method will be used in all subsequent paint operations. The name
/// should be a name of an available paint method. Returns an error if
/// no matching paint method is found.
extern fn gimp_context_set_paint_method(p_name: [*:0]const u8) c_int;
pub const contextSetPaintMethod = gimp_context_set_paint_method;

/// Set the paint mode.
///
/// Modifies the paint_mode setting.
extern fn gimp_context_set_paint_mode(p_paint_mode: gimp.LayerMode) c_int;
pub const contextSetPaintMode = gimp_context_set_paint_mode;

/// Set the active palette.
///
/// Sets the active palette in the current context. The palette will be
/// used in subsequent paint operations. Returns an error when the
/// palette data was uninstalled since the palette object was created.
extern fn gimp_context_set_palette(p_palette: *gimp.Palette) c_int;
pub const contextSetPalette = gimp_context_set_palette;

/// Set the active pattern.
///
/// Sets the active pattern in the current context. The pattern will be
/// used in subsequent fill operations using a pattern. Returns an error
/// when the pattern data was uninstalled since the pattern object was
/// created.
extern fn gimp_context_set_pattern(p_pattern: *gimp.Pattern) c_int;
pub const contextSetPattern = gimp_context_set_pattern;

/// Set the sample criterion setting.
///
/// Modifies the sample criterion setting. If an operation depends on
/// the colors of the pixels present in a drawable, like when doing a
/// seed fill, this setting controls how color similarity is determined.
/// SELECT_CRITERION_COMPOSITE is the default value.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Drawable.editBucketFill`.
extern fn gimp_context_set_sample_criterion(p_sample_criterion: gimp.SelectCriterion) c_int;
pub const contextSetSampleCriterion = gimp_context_set_sample_criterion;

/// Set the sample merged setting.
///
/// Modifies the sample merged setting. If an operation depends on the
/// colors of the pixels present in a drawable, like when doing a seed
/// fill, this setting controls whether the pixel data from the given
/// drawable is used ('sample-merged' is FALSE), or the pixel data from
/// the composite image ('sample-merged' is TRUE. This is equivalent to
/// sampling for colors after merging all visible layers).
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Drawable.editBucketFill`.
extern fn gimp_context_set_sample_merged(p_sample_merged: c_int) c_int;
pub const contextSetSampleMerged = gimp_context_set_sample_merged;

/// Set the sample threshold setting.
///
/// Modifies the sample threshold setting. If an operation depends on
/// the colors of the pixels present in a drawable, like when doing a
/// seed fill, this setting controls what is \"sufficiently close\" to
/// be considered a similar color. If the sample threshold has not been
/// set explicitly, the default threshold set in gimprc will be used.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Drawable.editBucketFill`.
extern fn gimp_context_set_sample_threshold(p_sample_threshold: f64) c_int;
pub const contextSetSampleThreshold = gimp_context_set_sample_threshold;

/// Set the sample threshold setting as an integer value.
///
/// Modifies the sample threshold setting as an integer value. See
/// `gimp.contextSetSampleThreshold`.
extern fn gimp_context_set_sample_threshold_int(p_sample_threshold: c_int) c_int;
pub const contextSetSampleThresholdInt = gimp_context_set_sample_threshold_int;

/// Set the sample transparent setting.
///
/// Modifies the sample transparent setting. If an operation depends on
/// the colors of the pixels present in a drawable, like when doing a
/// seed fill, this setting controls whether transparency is considered
/// to be a unique selectable color. When this setting is TRUE,
/// transparent areas can be selected or filled.
///
/// This setting affects the following procedures:
/// `gimp.Image.selectColor`, `gimp.Image.selectContiguousColor`,
/// `gimp.Drawable.editBucketFill`.
extern fn gimp_context_set_sample_transparent(p_sample_transparent: c_int) c_int;
pub const contextSetSampleTransparent = gimp_context_set_sample_transparent;

/// Set the active stroke method.
///
/// Sets the active stroke method. The method will be used in all
/// subsequent stroke operations.
extern fn gimp_context_set_stroke_method(p_stroke_method: gimp.StrokeMethod) c_int;
pub const contextSetStrokeMethod = gimp_context_set_stroke_method;

/// Set the transform direction.
///
/// Modifies the transform direction setting.
///
/// This setting affects affects the following procedures:
/// `gimp.Item.transformFlip`, `gimp.Item.transformPerspective`,
/// `gimp.Item.transformRotate`, `gimp.Item.transformScale`,
/// `gimp.Item.transformShear`, `gimp.Item.transform2d`,
/// `gimp.Item.transformMatrix`.
extern fn gimp_context_set_transform_direction(p_transform_direction: gimp.TransformDirection) c_int;
pub const contextSetTransformDirection = gimp_context_set_transform_direction;

/// Set the transform resize type.
///
/// Modifies the transform resize setting. When transforming pixels, if
/// the result of a transform operation has a different size than the
/// original area, this setting determines how the resulting area is
/// sized.
///
/// This setting affects affects the following procedures:
/// `gimp.Item.transformFlip`, `gimp.Item.transformFlipSimple`,
/// `gimp.Item.transformPerspective`, `gimp.Item.transformRotate`,
/// `gimp.Item.transformRotateSimple`, `gimp.Item.transformScale`,
/// `gimp.Item.transformShear`, `gimp.Item.transform2d`,
/// `gimp.Item.transformMatrix`.
extern fn gimp_context_set_transform_resize(p_transform_resize: gimp.TransformResize) c_int;
pub const contextSetTransformResize = gimp_context_set_transform_resize;

/// Swap the current GIMP foreground and background colors.
///
/// Swaps the current GIMP foreground and background colors, so that the
/// new foreground color becomes the old background color and vice
/// versa.
extern fn gimp_context_swap_colors() c_int;
pub const contextSwapColors = gimp_context_swap_colors;

/// Convolve (Blur, Sharpen) using the current brush.
///
/// This tool convolves the specified drawable with either a sharpening
/// or blurring kernel. The pressure parameter controls the magnitude of
/// the operation. Like the paintbrush, this tool linearly interpolates
/// between the specified stroke coordinates.
extern fn gimp_convolve(p_drawable: *gimp.Drawable, p_pressure: f64, p_convolve_type: gimp.ConvolveType, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const convolve = gimp_convolve;

/// Convolve (Blur, Sharpen) using the current brush.
///
/// This tool convolves the specified drawable with either a sharpening
/// or blurring kernel. This function performs exactly the same as the
/// `gimp.convolve` function except that the tools arguments are
/// obtained from the convolve option dialog. It this dialog has not
/// been activated then the dialogs default values will be used.
extern fn gimp_convolve_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const convolveDefault = gimp_convolve_default;

extern fn gimp_core_object_array_get_length(p_array: **gobject.Object) usize;
pub const coreObjectArrayGetLength = gimp_core_object_array_get_length;

extern fn gimp_core_object_array_get_type() usize;
pub const coreObjectArrayGetType = gimp_core_object_array_get_type;

/// Query for CPU acceleration support.
extern fn gimp_cpu_accel_get_support() gimp.CpuAccelFlags;
pub const cpuAccelGetSupport = gimp_cpu_accel_get_support;

/// Returns the default top directory for GIMP data. If the environment
/// variable GIMP3_DATADIR exists, that is used.  It should be an
/// absolute pathname.  Otherwise, on Unix the compile-time defined
/// directory is used. On Windows, the installation directory as
/// deduced from the executable's full filename is used.
///
/// Note that the actual directories used for GIMP data files can be
/// overridden by the user in the preferences dialog.
///
/// In config files such as gimprc, the string ${gimp_data_dir} expands
/// to this directory.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8. (On Windows it always is
/// UTF-8.)
extern fn gimp_data_directory() [*:0]const u8;
pub const dataDirectory = gimp_data_directory;

/// Returns a `gio.File` in the data directory, or the data directory
/// itself if `first_element` is `NULL`.
///
/// See also: `gimp.dataDirectory`.
extern fn gimp_data_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
pub const dataDirectoryFile = gimp_data_directory_file;

/// Finishes measuring elapsed time.
///
/// This procedure stops the timer started by a previous
/// `gimp.debugTimerStart` call, and prints and returns the elapsed
/// time.
/// If there was already an active timer at the time of corresponding
/// call to `gimp.debugTimerStart`, a dummy value is returned.
///
/// This is a debug utility procedure. It is subject to change at any
/// point, and should not be used in production.
extern fn gimp_debug_timer_end() f64;
pub const debugTimerEnd = gimp_debug_timer_end;

/// Starts measuring elapsed time.
///
/// This procedure starts a timer, measuring the elapsed time since the
/// call. Each call to this procedure should be matched by a call to
/// `gimp.debugTimerEnd`, which returns the elapsed time.
/// If there is already an active timer, it is not affected by the call,
/// however, a matching `gimp.debugTimerEnd` call is still required.
///
/// This is a debug utility procedure. It is subject to change at any
/// point, and should not be used in production.
extern fn gimp_debug_timer_start() c_int;
pub const debugTimerStart = gimp_debug_timer_start;

/// Returns the default display ID. This corresponds to the display the
/// running procedure's menu entry was invoked from.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_default_display() *gimp.Display;
pub const defaultDisplay = gimp_default_display;

/// Removes a global parasite.
///
/// This procedure detaches a global parasite from. It has no return
/// values.
extern fn gimp_detach_parasite(p_name: [*:0]const u8) c_int;
pub const detachParasite = gimp_detach_parasite;

/// Returns the user-specific GIMP settings directory. If the
/// environment variable GIMP3_DIRECTORY exists, it is used. If it is
/// an absolute path, it is used as is.  If it is a relative path, it
/// is taken to be a subdirectory of the home directory. If it is a
/// relative path, and no home directory can be determined, it is taken
/// to be a subdirectory of `gimp.dataDirectory`.
///
/// The usual case is that no GIMP3_DIRECTORY environment variable
/// exists, and then we use the GIMPDIR subdirectory of the local
/// configuration directory:
///
/// - UNIX: $XDG_CONFIG_HOME (defaults to $HOME/.config/)
///
/// - Windows: CSIDL_APPDATA
///
/// - OSX (UNIX exception): the Application Support Directory.
///
/// If neither the configuration nor home directory exist,
/// `glib.getUserConfigDir` will return {tmp}/{user_name}/.config/ where
/// the temporary directory {tmp} and the {user_name} are determined
/// according to platform rules.
///
/// In any case, we always return some non-empty string, whether it
/// corresponds to an existing directory or not.
///
/// In config files such as gimprc, the string ${gimp_dir} expands to
/// this directory.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8 (on Windows it is always
/// UTF-8.)
extern fn gimp_directory() [*:0]const u8;
pub const directory = gimp_directory;

/// Returns a `gio.File` in the user's GIMP directory, or the GIMP
/// directory itself if `first_element` is `NULL`.
///
/// See also: `gimp.directory`.
extern fn gimp_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
pub const directoryFile = gimp_directory_file;

/// Flush all internal changes to the user interface
///
/// This procedure takes no arguments and returns nothing except a
/// success status. Its purpose is to flush all pending updates of image
/// manipulations to the user interface. It should be called whenever
/// appropriate.
extern fn gimp_displays_flush() c_int;
pub const displaysFlush = gimp_displays_flush;

/// Reconnect displays from one image to another image.
///
/// This procedure connects all displays of the old_image to the
/// new_image. If the old_image has no display or new_image already has
/// a display the reconnect is not performed and the procedure returns
/// without success. You should rarely need to use this function.
extern fn gimp_displays_reconnect(p_old_image: *gimp.Image, p_new_image: *gimp.Image) c_int;
pub const displaysReconnect = gimp_displays_reconnect;

/// Dodgeburn image with varying exposure.
///
/// Dodgeburn. More details here later.
extern fn gimp_dodgeburn(p_drawable: *gimp.Drawable, p_exposure: f64, p_dodgeburn_type: gimp.DodgeBurnType, p_dodgeburn_mode: gimp.TransferMode, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const dodgeburn = gimp_dodgeburn;

/// Dodgeburn image with varying exposure. This is the same as the
/// `gimp.dodgeburn` function except that the exposure, type and mode
/// are taken from the tools option dialog. If the dialog has not been
/// activated then the defaults as used by the dialog will be used.
///
/// Dodgeburn. More details here later.
extern fn gimp_dodgeburn_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const dodgeburnDefault = gimp_dodgeburn_default;

/// Close the drawable selection dialog.
///
/// Closes an open drawable selection dialog.
extern fn gimp_drawables_close_popup(p_callback: [*:0]const u8) c_int;
pub const drawablesClosePopup = gimp_drawables_close_popup;

/// Invokes the drawable selection dialog.
///
/// Opens a dialog letting a user choose an drawable.
extern fn gimp_drawables_popup(p_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_drawable_type: [*:0]const u8, p_initial_drawable: ?*gimp.Drawable, p_parent_window: ?*glib.Bytes) c_int;
pub const drawablesPopup = gimp_drawables_popup;

/// Sets the selected drawable in a drawable selection dialog.
///
/// Sets the selected drawable in a drawable selection dialog.
extern fn gimp_drawables_set_popup(p_callback: [*:0]const u8, p_drawable: *gimp.Drawable) c_int;
pub const drawablesSetPopup = gimp_drawables_set_popup;

/// Retrieve the list of loaded paint dynamics.
///
/// This procedure returns a list of the paint dynamics that are
/// currently available.
extern fn gimp_dynamics_get_name_list(p_filter: ?[*:0]const u8) [*][*:0]u8;
pub const dynamicsGetNameList = gimp_dynamics_get_name_list;

/// Refresh current paint dynamics. This function always succeeds.
///
/// This procedure retrieves all paint dynamics currently in the user's
/// paint dynamics path and updates the paint dynamics dialogs
/// accordingly.
extern fn gimp_dynamics_refresh() c_int;
pub const dynamicsRefresh = gimp_dynamics_refresh;

/// Copy from the specified drawables.
///
/// If there is a selection in the image, then the area specified by the
/// selection is copied from the specified drawables and placed in an
/// internal GIMP edit buffer. It can subsequently be retrieved using
/// the `gimp.editPaste` command. If there is no selection, then the
/// specified drawables' contents will be stored in the internal GIMP
/// edit buffer.
/// This procedure will return `FALSE` if the selected area lies
/// completely outside the bounds of the current drawables and there is
/// nothing to copy from.
/// All the drawables must belong to the same image.
extern fn gimp_edit_copy(p_drawables: [*]*const gimp.Drawable) c_int;
pub const editCopy = gimp_edit_copy;

/// Copy from the projection.
///
/// If there is a selection in the image, then the area specified by the
/// selection is copied from the projection and placed in an internal
/// GIMP edit buffer. It can subsequently be retrieved using the
/// `gimp.editPaste` command. If there is no selection, then the
/// projection's contents will be stored in the internal GIMP edit
/// buffer.
extern fn gimp_edit_copy_visible(p_image: *gimp.Image) c_int;
pub const editCopyVisible = gimp_edit_copy_visible;

/// Cut from the specified drawables.
///
/// If there is a selection in the image, then the area specified by the
/// selection is cut from the specified drawables and placed in an
/// internal GIMP edit buffer. It can subsequently be retrieved using
/// the `gimp.editPaste` command. If there is no selection and only one
/// specified drawable, then the specified drawable will be removed and
/// its contents stored in the internal GIMP edit buffer.
/// This procedure will return `FALSE` if the selected area lies
/// completely outside the bounds of the current drawables and there is
/// nothing to cut from.
extern fn gimp_edit_cut(p_drawables: [*]*const gimp.Drawable) c_int;
pub const editCut = gimp_edit_cut;

/// Copy into a named buffer.
///
/// This procedure works like `gimp.editCopy`, but additionally stores
/// the copied buffer into a named buffer that will stay available for
/// later pasting, regardless of any intermediate copy or cut
/// operations.
extern fn gimp_edit_named_copy(p_drawables: [*]*const gimp.Drawable, p_buffer_name: [*:0]const u8) [*:0]u8;
pub const editNamedCopy = gimp_edit_named_copy;

/// Copy from the projection into a named buffer.
///
/// This procedure works like `gimp.editCopyVisible`, but additionally
/// stores the copied buffer into a named buffer that will stay
/// available for later pasting, regardless of any intermediate copy or
/// cut operations.
extern fn gimp_edit_named_copy_visible(p_image: *gimp.Image, p_buffer_name: [*:0]const u8) [*:0]u8;
pub const editNamedCopyVisible = gimp_edit_named_copy_visible;

/// Cut into a named buffer.
///
/// This procedure works like `gimp.editCut`, but additionally stores
/// the cut buffer into a named buffer that will stay available for
/// later pasting, regardless of any intermediate copy or cut
/// operations.
extern fn gimp_edit_named_cut(p_drawables: [*]*const gimp.Drawable, p_buffer_name: [*:0]const u8) [*:0]u8;
pub const editNamedCut = gimp_edit_named_cut;

/// Paste named buffer to the specified drawable.
///
/// This procedure works like `gimp.editPaste` but pastes a named
/// buffer instead of the global buffer.
extern fn gimp_edit_named_paste(p_drawable: *gimp.Drawable, p_buffer_name: [*:0]const u8, p_paste_into: c_int) *gimp.Layer;
pub const editNamedPaste = gimp_edit_named_paste;

/// Paste named buffer to a new image.
///
/// This procedure works like `gimp.editPasteAsNewImage` but pastes
/// a named buffer instead of the global buffer.
extern fn gimp_edit_named_paste_as_new_image(p_buffer_name: [*:0]const u8) *gimp.Image;
pub const editNamedPasteAsNewImage = gimp_edit_named_paste_as_new_image;

/// Paste buffer to the specified drawable.
///
/// This procedure pastes a copy of the internal GIMP edit buffer to the
/// specified drawable. The GIMP edit buffer will be empty unless a call
/// was previously made to either `gimp.editCut` or
/// `gimp.editCopy`. The \"paste_into\" option specifies whether
/// to clear the current image selection, or to paste the buffer
/// \"behind\" the selection. This allows the selection to act as a mask
/// for the pasted buffer. Anywhere that the selection mask is non-zero,
/// the pasted buffer will show through. The pasted data may be a
/// floating selection when relevant, layers otherwise. If the image has
/// a floating selection at the time of pasting, the old floating
/// selection will be anchored to its drawable before the new floating
/// selection is added.
/// This procedure returns the new drawables (floating or not). If the
/// result is a floating selection, it will already be attached to the
/// specified drawable, and a subsequent call to
/// `gimp.floatingSelAttach` is not needed.
extern fn gimp_edit_paste(p_drawable: *gimp.Drawable, p_paste_into: c_int) [*]*gimp.Drawable;
pub const editPaste = gimp_edit_paste;

/// Paste buffer to a new image.
///
/// This procedure pastes a copy of the internal GIMP edit buffer to a
/// new image. The GIMP edit buffer will be empty unless a call was
/// previously made to either `gimp.editCut` or `gimp.editCopy`. This
/// procedure returns the new image or -1 if the edit buffer was empty.
extern fn gimp_edit_paste_as_new_image() *gimp.Image;
pub const editPasteAsNewImage = gimp_edit_paste_as_new_image;

/// Retrieves `gimp.EnumDesc` associated with the given value, or `NULL`.
extern fn gimp_enum_get_desc(p_enum_class: *gobject.EnumClass, p_value: c_int) ?*const gimp.EnumDesc;
pub const enumGetDesc = gimp_enum_get_desc;

/// Checks if `value` is valid for the enum registered as `enum_type`.
/// If the value exists in that enum, its name, nick and its translated
/// description and help are returned (if `value_name`, `value_nick`,
/// `value_desc` and `value_help` are not `NULL`).
extern fn gimp_enum_get_value(p_enum_type: usize, p_value: c_int, p_value_name: ?*[*:0]const u8, p_value_nick: ?*[*:0]const u8, p_value_desc: ?*[*:0]const u8, p_value_help: ?*[*:0]const u8) c_int;
pub const enumGetValue = gimp_enum_get_value;

/// Retrieves the array of human readable and translatable descriptions
/// and help texts for enum values.
extern fn gimp_enum_get_value_descriptions(p_enum_type: usize) *const gimp.EnumDesc;
pub const enumGetValueDescriptions = gimp_enum_get_value_descriptions;

/// Sets the array of human readable and translatable descriptions
/// and help texts for enum values.
extern fn gimp_enum_set_value_descriptions(p_enum_type: usize, p_descriptions: *const gimp.EnumDesc) void;
pub const enumSetValueDescriptions = gimp_enum_set_value_descriptions;

/// Retrieves the translated abbreviation for a given `enum_value`.
extern fn gimp_enum_value_get_abbrev(p_enum_class: *gobject.EnumClass, p_enum_value: *const gobject.EnumValue) [*:0]const u8;
pub const enumValueGetAbbrev = gimp_enum_value_get_abbrev;

/// Retrieves the translated description for a given `enum_value`.
extern fn gimp_enum_value_get_desc(p_enum_class: *gobject.EnumClass, p_enum_value: *const gobject.EnumValue) [*:0]const u8;
pub const enumValueGetDesc = gimp_enum_value_get_desc;

/// Retrieves the translated help for a given `enum_value`.
extern fn gimp_enum_value_get_help(p_enum_class: *gobject.EnumClass, p_enum_value: *const gobject.EnumValue) [*:0]const u8;
pub const enumValueGetHelp = gimp_enum_value_get_help;

/// This function gives access to the list of enums registered by libgimp.
/// The returned array is static and must not be modified.
extern fn gimp_enums_get_type_names(p_n_type_names: *c_int) [*][*:0]const u8;
pub const enumsGetTypeNames = gimp_enums_get_type_names;

/// This function makes sure all the enum types are registered
/// with the `gobject.Type` system. This is intended for use by language
/// bindings that need the symbols early, before gimp_main is run.
/// It's not necessary for plug-ins to call this directly, because
/// the normal plug-in initialization code will handle it implicitly.
extern fn gimp_enums_init() void;
pub const enumsInit = gimp_enums_init;

/// Erase using the current brush.
///
/// This tool erases using the current brush mask. If the specified
/// drawable contains an alpha channel, then the erased pixels will
/// become transparent. Otherwise, the eraser tool replaces the contents
/// of the drawable with the background color. Like paintbrush, this
/// tool linearly interpolates between the specified stroke coordinates.
extern fn gimp_eraser(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64, p_hardness: gimp.BrushApplicationMode, p_method: gimp.PaintApplicationMode) c_int;
pub const eraser = gimp_eraser;

/// Erase using the current brush.
///
/// This tool erases using the current brush mask. This function
/// performs exactly the same as the `gimp.eraser` function except that
/// the tools arguments are obtained from the eraser option dialog. It
/// this dialog has not been activated then the dialogs default values
/// will be used.
extern fn gimp_eraser_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const eraserDefault = gimp_eraser_default;

/// This function returns a copy of `str` with all underline converted
/// to two adjacent underlines. This comes in handy when needing to display
/// strings with underlines (like filenames) in a place that would convert
/// them to mnemonics.
extern fn gimp_escape_uline(p_str: ?[*:0]const u8) [*:0]u8;
pub const escapeUline = gimp_escape_uline;

/// Returns whether file plug-ins should default to exporting the
/// image's color profile.
extern fn gimp_export_color_profile() c_int;
pub const exportColorProfile = gimp_export_color_profile;

/// Returns whether file plug-ins should default to exporting the
/// image's comment.
extern fn gimp_export_comment() c_int;
pub const exportComment = gimp_export_comment;

/// Returns whether file plug-ins should default to exporting Exif
/// metadata, according preferences (original settings is `FALSE` since
/// metadata can contain sensitive information).
extern fn gimp_export_exif() c_int;
pub const exportExif = gimp_export_exif;

/// Returns whether file plug-ins should default to exporting IPTC
/// metadata, according preferences (original settings is `FALSE` since
/// metadata can contain sensitive information).
extern fn gimp_export_iptc() c_int;
pub const exportIptc = gimp_export_iptc;

/// Returns whether file plug-ins should default to exporting the
/// image's comment.
extern fn gimp_export_thumbnail() c_int;
pub const exportThumbnail = gimp_export_thumbnail;

/// Returns whether file plug-ins should default to exporting XMP
/// metadata, according preferences (original settings is `FALSE` since
/// metadata can contain sensitive information).
extern fn gimp_export_xmp() c_int;
pub const exportXmp = gimp_export_xmp;

/// Creates a thumbnail of `image` for the given `file`
///
/// This procedure creates a thumbnail for the given `file` and stores it
/// according to relevant standards.
/// In particular, it will follow the [Free Desktop Thumbnail Managing
/// Standard](https://specifications.freedesktop.org/thumbnail-spec/late
/// st/thumbsave.html) when relevant.
///
/// The thumbnail is stored so that it belongs to the given `file`. This
/// means you have to save `image` under this name first. As a fallback,
/// the call will work if `image` was exported or imported as `file`. In
/// any other case, this procedure will fail.
extern fn gimp_file_create_thumbnail(p_image: *gimp.Image, p_file: *gio.File) c_int;
pub const fileCreateThumbnail = gimp_file_create_thumbnail;

/// Unexpands `file`'s path using `gimp.ConfigPath.unexpand` and
/// returns the unexpanded path.
///
/// The inverse operation of `gimp.fileNewForConfigPath`.
extern fn gimp_file_get_config_path(p_file: *gio.File, p_error: ?*?*glib.Error) ?[*:0]u8;
pub const fileGetConfigPath = gimp_file_get_config_path;

/// This function works like `gimp.filenameToUtf8` and returns
/// a UTF-8 encoded string that does not need to be freed.
///
/// It converts a `gio.File`'s path or uri to UTF-8 temporarily.  The
/// return value is a pointer to a string that is guaranteed to be
/// valid only during the current iteration of the main loop or until
/// the next call to `gimp.fileGetUtf8Name`.
///
/// The only purpose of this function is to provide an easy way to pass
/// a `gio.File`'s name to a function that expects an UTF-8 encoded string.
///
/// See `gio.File.getParseName`.
extern fn gimp_file_get_utf8_name(p_file: *gio.File) [*:0]const u8;
pub const fileGetUtf8Name = gimp_file_get_utf8_name;

/// This function checks if `file`'s URI ends with `extension`. It behaves
/// like `glib.strHasSuffix` on `gio.File.getUri`, except that the string
/// comparison is done case-insensitively using `glib.asciiStrcasecmp`.
extern fn gimp_file_has_extension(p_file: *gio.File, p_extension: [*:0]const u8) c_int;
pub const fileHasExtension = gimp_file_has_extension;

/// Loads an image file by invoking the right load handler.
///
/// This procedure invokes the correct file load handler using magic if
/// possible, and falling back on the file's extension and/or prefix if
/// not.
extern fn gimp_file_load(p_run_mode: gimp.RunMode, p_file: *gio.File) *gimp.Image;
pub const fileLoad = gimp_file_load;

/// Loads an image file as a layer for an existing image.
///
/// This procedure behaves like the file-load procedure but opens the
/// specified image as a layer for an existing image. The returned layer
/// needs to be added to the existing image with
/// `gimp.Image.insertLayer`.
extern fn gimp_file_load_layer(p_run_mode: gimp.RunMode, p_image: *gimp.Image, p_file: *gio.File) *gimp.Layer;
pub const fileLoadLayer = gimp_file_load_layer;

/// Loads an image file as layers for an existing image.
///
/// This procedure behaves like the file-load procedure but opens the
/// specified image as layers for an existing image. The returned layers
/// needs to be added to the existing image with
/// `gimp.Image.insertLayer`.
extern fn gimp_file_load_layers(p_run_mode: gimp.RunMode, p_image: *gimp.Image, p_file: *gio.File) [*]*gimp.Layer;
pub const fileLoadLayers = gimp_file_load_layers;

/// Expands `path` using `gimp.ConfigPath.expand` and returns a `gio.File`
/// for the expanded path.
///
/// To reverse the expansion, use `gimp.fileGetConfigPath`.
extern fn gimp_file_new_for_config_path(p_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*gio.File;
pub const fileNewForConfigPath = gimp_file_new_for_config_path;

/// Saves to XCF or export `image` to any supported format by extension.
///
/// This procedure invokes the correct file save/export handler
/// according to `file`'s extension and/or prefix.
///
/// The `options` argument is currently unused and should be set to `NULL`
/// right now.
extern fn gimp_file_save(p_run_mode: gimp.RunMode, p_image: *gimp.Image, p_file: *gio.File, p_options: ?*gimp.ExportOptions) c_int;
pub const fileSave = gimp_file_save;

/// Shows `file` in the system file manager.
extern fn gimp_file_show_in_file_manager(p_file: *gio.File, p_error: ?*?*glib.Error) c_int;
pub const fileShowInFileManager = gimp_file_show_in_file_manager;

/// Convert a filename in the filesystem's encoding to UTF-8
/// temporarily.  The return value is a pointer to a string that is
/// guaranteed to be valid only during the current iteration of the
/// main loop or until the next call to `gimp.filenameToUtf8`.
///
/// The only purpose of this function is to provide an easy way to pass
/// a filename in the filesystem encoding to a function that expects an
/// UTF-8 encoded filename.
extern fn gimp_filename_to_utf8(p_filename: [*:0]const u8) [*:0]const u8;
pub const filenameToUtf8 = gimp_filename_to_utf8;

/// Retrieves the first `gimp.FlagsDesc` that matches the given value, or `NULL`.
extern fn gimp_flags_get_first_desc(p_flags_class: *gobject.FlagsClass, p_value: c_uint) ?*const gimp.FlagsDesc;
pub const flagsGetFirstDesc = gimp_flags_get_first_desc;

/// Checks if `value` is valid for the flags registered as `flags_type`.
/// If the value exists in that flags, its name, nick and its
/// translated description and help are returned (if `value_name`,
/// `value_nick`, `value_desc` and `value_help` are not `NULL`).
extern fn gimp_flags_get_first_value(p_flags_type: usize, p_value: c_uint, p_value_name: ?*[*:0]const u8, p_value_nick: ?*[*:0]const u8, p_value_desc: ?*[*:0]const u8, p_value_help: ?*[*:0]const u8) c_int;
pub const flagsGetFirstValue = gimp_flags_get_first_value;

/// Retrieves the array of human readable and translatable descriptions
/// and help texts for flags values.
extern fn gimp_flags_get_value_descriptions(p_flags_type: usize) *const gimp.FlagsDesc;
pub const flagsGetValueDescriptions = gimp_flags_get_value_descriptions;

/// Sets the array of human readable and translatable descriptions
/// and help texts for flags values.
extern fn gimp_flags_set_value_descriptions(p_flags_type: usize, p_descriptions: *const gimp.FlagsDesc) void;
pub const flagsSetValueDescriptions = gimp_flags_set_value_descriptions;

/// Retrieves the translated abbreviation for a given `flags_value`.
extern fn gimp_flags_value_get_abbrev(p_flags_class: *gobject.FlagsClass, p_flags_value: *const gobject.FlagsValue) [*:0]const u8;
pub const flagsValueGetAbbrev = gimp_flags_value_get_abbrev;

/// Retrieves the translated description for a given `flags_value`.
extern fn gimp_flags_value_get_desc(p_flags_class: *gobject.FlagsClass, p_flags_value: *const gobject.FlagsValue) [*:0]const u8;
pub const flagsValueGetDesc = gimp_flags_value_get_desc;

/// Retrieves the translated help for a given `flags_value`.
extern fn gimp_flags_value_get_help(p_flags_class: *gobject.FlagsClass, p_flags_value: *const gobject.FlagsValue) [*:0]const u8;
pub const flagsValueGetHelp = gimp_flags_value_get_help;

/// Anchor the specified floating selection to its associated drawable.
///
/// This procedure anchors the floating selection to its associated
/// drawable. This is similar to merging with a merge type of
/// ClipToBottomLayer. The floating selection layer is no longer valid
/// after this operation.
extern fn gimp_floating_sel_anchor(p_floating_sel: *gimp.Layer) c_int;
pub const floatingSelAnchor = gimp_floating_sel_anchor;

/// Attach the specified layer as floating to the specified drawable.
///
/// This procedure attaches the layer as floating selection to the
/// drawable.
extern fn gimp_floating_sel_attach(p_layer: *gimp.Layer, p_drawable: *gimp.Drawable) c_int;
pub const floatingSelAttach = gimp_floating_sel_attach;

/// Remove the specified floating selection from its associated
/// drawable.
///
/// This procedure removes the floating selection completely, without
/// any side effects. The associated drawable is then set to active.
extern fn gimp_floating_sel_remove(p_floating_sel: *gimp.Layer) c_int;
pub const floatingSelRemove = gimp_floating_sel_remove;

/// Transforms the specified floating selection into a layer.
///
/// This procedure transforms the specified floating selection into a
/// layer with the same offsets and extents. The composited image will
/// look precisely the same, but the floating selection layer will no
/// longer be clipped to the extents of the drawable it was attached to.
/// The floating selection will become the active layer. This procedure
/// will not work if the floating selection has a different base type
/// from the underlying image. This might be the case if the floating
/// selection is above an auxiliary channel or a layer mask.
extern fn gimp_floating_sel_to_layer(p_floating_sel: *gimp.Layer) c_int;
pub const floatingSelToLayer = gimp_floating_sel_to_layer;

/// Close the font selection dialog.
///
/// Closes an open font selection dialog.
extern fn gimp_fonts_close_popup(p_font_callback: [*:0]const u8) c_int;
pub const fontsClosePopup = gimp_fonts_close_popup;

/// Retrieve the list of loaded fonts.
///
/// This procedure returns a list of the fonts that are currently
/// available.
/// Each font returned can be used as input to
/// `gimp.contextSetFont`.
extern fn gimp_fonts_get_list(p_filter: ?[*:0]const u8) [*]*gimp.Font;
pub const fontsGetList = gimp_fonts_get_list;

/// Invokes the Gimp font selection dialog.
///
/// Opens a dialog letting a user choose a font.
extern fn gimp_fonts_popup(p_font_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_initial_font: ?*gimp.Font, p_parent_window: ?*glib.Bytes) c_int;
pub const fontsPopup = gimp_fonts_popup;

/// Refresh current fonts. This function always succeeds.
///
/// This procedure retrieves all fonts currently in the user's font path
/// and updates the font dialogs accordingly. Depending on the amount of
/// fonts on the system, this can take considerable time.
extern fn gimp_fonts_refresh() c_int;
pub const fontsRefresh = gimp_fonts_refresh;

/// Sets the current font in a font selection dialog.
///
/// Sets the current font in a font selection dialog.
extern fn gimp_fonts_set_popup(p_font_callback: [*:0]const u8, p_font: *gimp.Font) c_int;
pub const fontsSetPopup = gimp_fonts_set_popup;

/// Retrieve a copy of the current color management configuration.
extern fn gimp_get_color_configuration() *gimp.ColorConfig;
pub const getColorConfiguration = gimp_get_color_configuration;

/// Get the default image comment as specified in the Preferences.
///
/// Returns a copy of the default image comment.
extern fn gimp_get_default_comment() [*:0]u8;
pub const getDefaultComment = gimp_get_default_comment;

/// Get the default unit (taken from the user's locale).
///
/// Returns the default unit.
extern fn gimp_get_default_unit() *gimp.Unit;
pub const getDefaultUnit = gimp_get_default_unit;

/// Returns the list of images currently open.
///
/// This procedure returns the list of images currently open in GIMP.
extern fn gimp_get_images() [*]*gimp.Image;
pub const getImages = gimp_get_images;

/// Get the list of modules which should not be loaded.
///
/// Returns a copy of the list of modules which should not be loaded.
extern fn gimp_get_module_load_inhibit() [*:0]u8;
pub const getModuleLoadInhibit = gimp_get_module_load_inhibit;

/// Get the monitor resolution as specified in the Preferences.
///
/// Returns the resolution of the monitor in pixels/inch. This value is
/// taken from the Preferences (or the windowing system if this is set
/// in the Preferences) and there's no guarantee for the value to be
/// reasonable.
extern fn gimp_get_monitor_resolution(p_xres: *f64, p_yres: *f64) c_int;
pub const getMonitorResolution = gimp_get_monitor_resolution;

/// Returns the number of threads set explicitly by the user in the
/// preferences. This information can be used by plug-ins wishing to
/// follow user settings for multi-threaded implementations.
extern fn gimp_get_num_processors() c_int;
pub const getNumProcessors = gimp_get_num_processors;

/// Look up a global parasite.
///
/// Finds and returns the global parasite that was previously attached.
extern fn gimp_get_parasite(p_name: [*:0]const u8) *gimp.Parasite;
pub const getParasite = gimp_get_parasite;

/// List all parasites.
///
/// Returns a list of all currently attached global parasites.
extern fn gimp_get_parasite_list() [*][*:0]u8;
pub const getParasiteList = gimp_get_parasite_list;

/// This function returns the plug-in's `gimp.PDB` instance, which is a
/// singleton that can exist exactly once per running plug-in.
extern fn gimp_get_pdb() ?*gimp.PDB;
pub const getPdb = gimp_get_pdb;

/// This function returns the plug-in's `gimp.PlugIn` instance, which is
/// a a singleton that can exist exactly once per running plug-in.
extern fn gimp_get_plug_in() ?*gimp.PlugIn;
pub const getPlugIn = gimp_get_plug_in;

/// Returns the plug-in's executable name.
extern fn gimp_get_progname() [*:0]const u8;
pub const getProgname = gimp_get_progname;

/// Returns the PID of the host GIMP process.
///
/// This procedure returns the process ID of the currently running GIMP.
extern fn gimp_getpid() c_int;
pub const getpid = gimp_getpid;

/// Queries the gimprc file parser for information on a specified token.
///
/// This procedure is used to locate additional information contained in
/// the gimprc file considered extraneous to the operation of GIMP.
/// Plug-ins that need configuration information can expect it will be
/// stored in the user gimprc file and can use this procedure to
/// retrieve it. This query procedure will return the value associated
/// with the specified token. This corresponds _only_ to entries with
/// the format: (&lt;token&gt; &lt;value&gt;). The value must be a
/// string. Entries not corresponding to this format will cause warnings
/// to be issued on gimprc parsing and will not be queryable.
extern fn gimp_gimprc_query(p_token: [*:0]const u8) [*:0]u8;
pub const gimprcQuery = gimp_gimprc_query;

/// Sets a gimprc token to a value and saves it in the gimprc.
///
/// This procedure is used to add or change additional information in
/// the gimprc file that is considered extraneous to the operation of
/// GIMP. Plug-ins that need configuration information can use this
/// function to store it, and `gimp.gimprcQuery` to retrieve it. This
/// will accept _only_ string values in UTF-8 encoding.
extern fn gimp_gimprc_set(p_token: [*:0]const u8, p_value: [*:0]const u8) c_int;
pub const gimprcSet = gimp_gimprc_set;

/// Close the gradient selection dialog.
///
/// Closes an open gradient selection dialog.
extern fn gimp_gradients_close_popup(p_gradient_callback: [*:0]const u8) c_int;
pub const gradientsClosePopup = gimp_gradients_close_popup;

/// Retrieve the list of loaded gradients.
///
/// This procedure returns a list of the gradients that are currently
/// loaded.
/// Each gradient returned can be used as input to
/// `gimp.contextSetGradient`.
extern fn gimp_gradients_get_list(p_filter: ?[*:0]const u8) [*]*gimp.Gradient;
pub const gradientsGetList = gimp_gradients_get_list;

/// Invokes the Gimp gradients selection dialog.
///
/// Opens a dialog letting a user choose a gradient.
extern fn gimp_gradients_popup(p_gradient_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_initial_gradient: ?*gimp.Gradient, p_parent_window: ?*glib.Bytes) c_int;
pub const gradientsPopup = gimp_gradients_popup;

/// Refresh current gradients. This function always succeeds.
///
/// This procedure retrieves all gradients currently in the user's
/// gradient path and updates the gradient dialogs accordingly.
extern fn gimp_gradients_refresh() c_int;
pub const gradientsRefresh = gimp_gradients_refresh;

/// Sets the current gradient in a gradient selection dialog.
///
/// Sets the current gradient in a gradient selection dialog.
extern fn gimp_gradients_set_popup(p_gradient_callback: [*:0]const u8, p_gradient: *gimp.Gradient) c_int;
pub const gradientsSetPopup = gimp_gradients_set_popup;

/// Heal from the source to the dest drawable using the current brush
///
/// This tool heals the source drawable starting at the specified source
/// coordinates to the dest drawable. For image healing, if the sum of
/// the src coordinates and subsequent stroke offsets exceeds the
/// extents of the src drawable, then no paint is transferred. The
/// healing tool is capable of transforming between any image types
/// except RGB-&gt;Indexed.
extern fn gimp_heal(p_drawable: *gimp.Drawable, p_src_drawable: *gimp.Drawable, p_src_x: f64, p_src_y: f64, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const heal = gimp_heal;

/// Heal from the source to the dest drawable using the current brush
///
/// This tool heals from the source drawable starting at the specified
/// source coordinates to the dest drawable. This function performs
/// exactly the same as the `gimp.heal` function except that the tools
/// arguments are obtained from the healing option dialog. It this
/// dialog has not been activated then the dialogs default values will
/// be used.
extern fn gimp_heal_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const healDefault = gimp_heal_default;

/// Load a help page.
///
/// This procedure loads the specified help page into the helpbrowser or
/// what ever is configured as help viewer. The help page is identified
/// by its domain and ID: if help_domain is NULL, we use the help_domain
/// which was registered using the `gimp_plugin_help_register`
/// procedure. If help_domain is NULL and no help domain was registered,
/// the help domain of the main GIMP installation is used.
extern fn gimp_help(p_help_domain: ?[*:0]const u8, p_help_id: [*:0]const u8) c_int;
pub const help = gimp_help;

/// Returns the directory of the current icon theme.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_icon_theme_dir() [*:0]const u8;
pub const iconThemeDir = gimp_icon_theme_dir;

/// Returns the top installation directory of GIMP. On Unix the
/// compile-time defined installation prefix is used. On Windows, the
/// installation directory as deduced from the executable's full
/// filename is used. On OSX we ask [NSBundle mainBundle] for the
/// resource path to check if GIMP is part of a relocatable bundle.
///
/// In config files such as gimprc, the string ${gimp_installation_dir}
/// expands to this directory.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8. (On Windows it always is
/// UTF-8.)
extern fn gimp_installation_directory() [*:0]const u8;
pub const installationDirectory = gimp_installation_directory;

/// Returns a `gio.File` in the installation directory, or the installation
/// directory itself if `first_element` is `NULL`.
///
/// See also: `gimp.installationDirectory`.
extern fn gimp_installation_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
pub const installationDirectoryFile = gimp_installation_directory_file;

/// Checks if `identifier` is canonical and non-`NULL`.
///
/// Canonical identifiers are e.g. expected by the PDB for procedure
/// and parameter names. Every character of the input string must be
/// either '-', 'a-z', 'A-Z' or '0-9'.
extern fn gimp_is_canonical_identifier(p_identifier: [*:0]const u8) c_int;
pub const isCanonicalIdentifier = gimp_is_canonical_identifier;

/// Returns the list of images currently open.
///
/// This procedure returns the list of images currently open in GIMP.
extern fn gimp_list_images() *glib.List;
pub const listImages = gimp_list_images;

/// Returns the top directory for GIMP locale files. If the environment
/// variable GIMP3_LOCALEDIR exists, that is used.  It should be an
/// absolute pathname.  Otherwise, on Unix the compile-time defined
/// directory is used. On Windows, the installation directory as deduced
/// from the executable's full filename is used.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string encoding depends on the system where GIMP
/// is running: on UNIX it's in the encoding used for filenames by
/// the C library (which isn't necessarily UTF-8); on Windows it's UTF-8.
///
/// On UNIX the returned string can be passed directly to the `bindtextdomain`
/// function from libintl; on Windows the returned string can be converted to
/// UTF-16 and passed to the `wbindtextdomain` function from libintl.
extern fn gimp_locale_directory() [*:0]const u8;
pub const localeDirectory = gimp_locale_directory;

/// Returns a `gio.File` in the locale directory, or the locale directory
/// itself if `first_element` is `NULL`.
///
/// See also: `gimp.localeDirectory`.
extern fn gimp_locale_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
pub const localeDirectoryFile = gimp_locale_directory_file;

/// The main plug-in function that must be called with the plug-in's
/// `gimp.PlugIn` subclass `gobject.Type` and the 'argc' and 'argv' that are passed
/// to the platform's ``main``.
///
/// For instance, in Python, you will want to end your plug-in with this
/// call:
///
/// ```py
/// Gimp.main(MyPlugIn.__gtype__, sys.argv)
/// ```
///
/// For C plug-ins, use instead the `gimp.MAIN` macro
extern fn gimp_main(p_plug_in_type: usize, p_argc: c_int, p_argv: [*][*:0]u8) c_int;
pub const main = gimp_main;

/// Displays a dialog box with a message.
///
/// Displays a dialog box with a message. Useful for status or error
/// reporting. The message must be in UTF-8 encoding.
extern fn gimp_message(p_message: [*:0]const u8) c_int;
pub const message = gimp_message;

/// Returns the current state of where warning messages are displayed.
///
/// This procedure returns the way g_message warnings are displayed.
/// They can be shown in a dialog box or printed on the console where
/// gimp was started.
extern fn gimp_message_get_handler() gimp.MessageHandlerType;
pub const messageGetHandler = gimp_message_get_handler;

/// Controls where warning messages are displayed.
///
/// This procedure controls how g_message warnings are displayed. They
/// can be shown in a dialog box or printed on the console where gimp
/// was started.
extern fn gimp_message_set_handler(p_handler: gimp.MessageHandlerType) c_int;
pub const messageSetHandler = gimp_message_set_handler;

/// Returns the monitor number to be used for plug-in windows.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_monitor_number() c_int;
pub const monitorNumber = gimp_monitor_number;

/// Paint in the current brush with optional fade out parameter and pull
/// colors from a gradient.
///
/// This tool is the standard paintbrush. It draws linearly interpolated
/// lines through the specified stroke coordinates. It operates on the
/// specified drawable in the foreground color with the active brush.
/// The 'fade-out' parameter is measured in pixels and allows the brush
/// stroke to linearly fall off. The pressure is set to the maximum at
/// the beginning of the stroke. As the distance of the stroke nears the
/// fade-out value, the pressure will approach zero. The gradient-length
/// is the distance to spread the gradient over. It is measured in
/// pixels. If the gradient-length is 0, no gradient is used.
extern fn gimp_paintbrush(p_drawable: *gimp.Drawable, p_fade_out: f64, p_num_strokes: usize, p_strokes: [*]const f64, p_method: gimp.PaintApplicationMode, p_gradient_length: f64) c_int;
pub const paintbrush = gimp_paintbrush;

/// Paint in the current brush. The fade out parameter and pull colors
/// from a gradient parameter are set from the paintbrush options
/// dialog. If this dialog has not been activated then the dialog
/// defaults will be used.
///
/// This tool is similar to the standard paintbrush. It draws linearly
/// interpolated lines through the specified stroke coordinates. It
/// operates on the specified drawable in the foreground color with the
/// active brush. The 'fade-out' parameter is measured in pixels and
/// allows the brush stroke to linearly fall off (value obtained from
/// the option dialog). The pressure is set to the maximum at the
/// beginning of the stroke. As the distance of the stroke nears the
/// fade-out value, the pressure will approach zero. The gradient-length
/// (value obtained from the option dialog) is the distance to spread
/// the gradient over. It is measured in pixels. If the gradient-length
/// is 0, no gradient is used.
extern fn gimp_paintbrush_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const paintbrushDefault = gimp_paintbrush_default;

/// Close the palette selection dialog.
///
/// Closes an open palette selection dialog.
extern fn gimp_palettes_close_popup(p_palette_callback: [*:0]const u8) c_int;
pub const palettesClosePopup = gimp_palettes_close_popup;

/// Retrieves a list of all of the available palettes
///
/// This procedure returns a complete listing of available palettes.
/// Each palette returned can be used as input to
/// `gimp.contextSetPalette`.
extern fn gimp_palettes_get_list(p_filter: ?[*:0]const u8) [*]*gimp.Palette;
pub const palettesGetList = gimp_palettes_get_list;

/// Invokes the Gimp palette selection dialog.
///
/// Opens a dialog letting a user choose a palette.
extern fn gimp_palettes_popup(p_palette_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_initial_palette: ?*gimp.Palette, p_parent_window: ?*glib.Bytes) c_int;
pub const palettesPopup = gimp_palettes_popup;

/// Refreshes current palettes. This function always succeeds.
///
/// This procedure retrieves all palettes currently in the user's
/// palette path and updates the palette dialogs accordingly.
extern fn gimp_palettes_refresh() c_int;
pub const palettesRefresh = gimp_palettes_refresh;

/// Sets the current palette in a palette selection dialog.
///
/// Sets the current palette in a palette selection dialog.
extern fn gimp_palettes_set_popup(p_palette_callback: [*:0]const u8, p_palette: *gimp.Palette) c_int;
pub const palettesSetPopup = gimp_palettes_set_popup;

/// Creates a new `GimpParamSpecArray` specifying a
/// `Array` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_array(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecArray = gimp_param_spec_array;

/// Creates a new `GimpParamSpecBrush` specifying a
/// `Brush` property. See also `gimp.paramSpecResource`.
extern fn gimp_param_spec_brush(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Brush, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecBrush = gimp_param_spec_brush;

/// Creates a new `GimpParamSpecChannel` specifying a
/// `Channel` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_channel(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecChannel = gimp_param_spec_channel;

/// Creates a new `GimpParamSpecChoice` specifying a
/// `G_TYPE_STRING` property.
/// This `GimpParamSpecChoice` takes ownership of the reference on `choice`.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_choice(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_choice: *gimp.Choice, p_default_value: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecChoice = gimp_param_spec_choice;

extern fn gimp_param_spec_choice_get_choice(p_pspec: *gobject.ParamSpec) *gimp.Choice;
pub const paramSpecChoiceGetChoice = gimp_param_spec_choice_get_choice;

extern fn gimp_param_spec_choice_get_default(p_pspec: *gobject.ParamSpec) [*:0]const u8;
pub const paramSpecChoiceGetDefault = gimp_param_spec_choice_get_default;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Color` property.
/// Note that the `default_color` is duplicated, so reusing object will
/// not change the default color of the returned `GimpParamSpecColor`.
extern fn gimp_param_spec_color(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_has_alpha: c_int, p_default_color: *gegl.Color, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecColor = gimp_param_spec_color;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Color` property.
extern fn gimp_param_spec_color_from_string(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_has_alpha: c_int, p_default_color_string: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecColorFromString = gimp_param_spec_color_from_string;

extern fn gimp_param_spec_color_has_alpha(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecColorHasAlpha = gimp_param_spec_color_has_alpha;

/// Creates a param spec to hold a filename, dir name,
/// or list of file or dir names.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_config_path(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_type: gimp.ConfigPathType, p_default_value: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecConfigPath = gimp_param_spec_config_path;

/// Tells whether the path param encodes a filename,
/// dir name, or list of file or dir names.
extern fn gimp_param_spec_config_path_type(p_pspec: *gobject.ParamSpec) gimp.ConfigPathType;
pub const paramSpecConfigPathType = gimp_param_spec_config_path_type;

/// Creates a new `GimpParamSpecCoreObjectArray` specifying a
/// `CoreObjectArray` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_core_object_array(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_object_type: usize, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecCoreObjectArray = gimp_param_spec_core_object_array;

extern fn gimp_param_spec_core_object_array_get_object_type(p_pspec: *gobject.ParamSpec) usize;
pub const paramSpecCoreObjectArrayGetObjectType = gimp_param_spec_core_object_array_get_object_type;

/// Creates a new `GimpParamSpecDisplay` specifying a
/// `Display` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_display(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecDisplay = gimp_param_spec_display;

extern fn gimp_param_spec_display_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecDisplayNoneAllowed = gimp_param_spec_display_none_allowed;

/// Creates a new `GimpParamSpecDoubleArray` specifying a
/// `GIMP_TYPE_DOUBLE_ARRAY` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_double_array(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecDoubleArray = gimp_param_spec_double_array;

/// Creates a new `GimpParamSpecDrawable` specifying a
/// `Drawable` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_drawable(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecDrawable = gimp_param_spec_drawable;

/// Creates a new `GimpParamSpecDrawableFilter` specifying a
/// `DrawableFilter` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_drawable_filter(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecDrawableFilter = gimp_param_spec_drawable_filter;

extern fn gimp_param_spec_drawable_filter_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecDrawableFilterNoneAllowed = gimp_param_spec_drawable_filter_none_allowed;

/// Creates a new `GimpParamSpecExportOptions` specifying a
/// `G_TYPE_INT` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_export_options(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecExportOptions = gimp_param_spec_export_options;

/// Creates a param spec to hold a file param.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_file(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_action: gimp.FileChooserAction, p_none_ok: c_int, p_default_value: ?*gio.File, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecFile = gimp_param_spec_file;

extern fn gimp_param_spec_file_get_action(p_pspec: *gobject.ParamSpec) gimp.FileChooserAction;
pub const paramSpecFileGetAction = gimp_param_spec_file_get_action;

extern fn gimp_param_spec_file_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecFileNoneAllowed = gimp_param_spec_file_none_allowed;

/// Change the file action tied to `pspec`.
extern fn gimp_param_spec_file_set_action(p_pspec: *gobject.ParamSpec, p_action: gimp.FileChooserAction) void;
pub const paramSpecFileSetAction = gimp_param_spec_file_set_action;

/// Creates a new `GimpParamSpecFont` specifying a
/// `Font` property. See also `gimp.paramSpecResource`.
extern fn gimp_param_spec_font(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Font, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecFont = gimp_param_spec_font;

/// Creates a new `GimpParamSpecGradient` specifying a
/// `Gradient` property. See also `gimp.paramSpecResource`.
extern fn gimp_param_spec_gradient(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Gradient, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecGradient = gimp_param_spec_gradient;

/// Creates a new `GimpParamSpecGroupLayer` specifying a
/// `GroupLayer` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_group_layer(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecGroupLayer = gimp_param_spec_group_layer;

/// Creates a new `GimpParamSpecImage` specifying a
/// `Image` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_image(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecImage = gimp_param_spec_image;

extern fn gimp_param_spec_image_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecImageNoneAllowed = gimp_param_spec_image_none_allowed;

/// Creates a new `GimpParamSpecInt32Array` specifying a
/// `GIMP_TYPE_INT32_ARRAY` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_int32_array(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecInt32Array = gimp_param_spec_int32_array;

/// Creates a new `GimpParamSpecItem` specifying a
/// `Item` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_item(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecItem = gimp_param_spec_item;

extern fn gimp_param_spec_item_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecItemNoneAllowed = gimp_param_spec_item_none_allowed;

/// Creates a new `GimpParamSpecLayer` specifying a
/// `Layer` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_layer(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecLayer = gimp_param_spec_layer;

/// Creates a new `GimpParamSpecLayerMask` specifying a
/// `LayerMask` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_layer_mask(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecLayerMask = gimp_param_spec_layer_mask;

/// Creates a param spec to hold a `gimp.Matrix2` value.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_matrix2(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_value: *const gimp.Matrix2, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecMatrix2 = gimp_param_spec_matrix2;

/// Creates a param spec to hold a `gimp.Matrix3` value.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_matrix3(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_value: *const gimp.Matrix3, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecMatrix3 = gimp_param_spec_matrix3;

/// Creates a param spec to hold a memory size value.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_memsize(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_minimum: u64, p_maximum: u64, p_default_value: u64, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecMemsize = gimp_param_spec_memsize;

/// Creates a new `GimpParamSpecPalette` specifying a
/// `Palette` property. See also `gimp.paramSpecResource`.
extern fn gimp_param_spec_palette(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Palette, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecPalette = gimp_param_spec_palette;

/// Creates a new `GimpParamSpecParasite` specifying a
/// `Parasite` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_parasite(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecParasite = gimp_param_spec_parasite;

/// Creates a new `GimpParamSpecPath` specifying a
/// `Path` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_path(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecPath = gimp_param_spec_path;

/// Creates a new `GimpParamSpecPattern` specifying a
/// `Pattern` property. See also `gimp.paramSpecResource`.
extern fn gimp_param_spec_pattern(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_default_value: ?*gimp.Pattern, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecPattern = gimp_param_spec_pattern;

/// Creates a new `GimpParamSpecResource` specifying a `Resource` property.
/// See `gobject.ParamSpec.internal` for details on property names.
///
/// `default_to_context` cannot be `TRUE` for a `resource_type` of value
/// `gimp.Resource`, but only for specific subtypes. If it is
/// `TRUE`, `default_value` must be `NULL`. Instead of a fixed default,
/// whatever is the context's resource for the given type at run time
/// will be used as dynamic default.
extern fn gimp_param_spec_resource(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_resource_type: usize, p_none_ok: c_int, p_default_value: ?*gimp.Resource, p_default_to_context: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecResource = gimp_param_spec_resource;

extern fn gimp_param_spec_resource_defaults_to_context(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecResourceDefaultsToContext = gimp_param_spec_resource_defaults_to_context;

extern fn gimp_param_spec_resource_none_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecResourceNoneAllowed = gimp_param_spec_resource_none_allowed;

/// Creates a new `GimpParamSpecSelection` specifying a
/// `Selection` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_selection(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecSelection = gimp_param_spec_selection;

/// Creates a new `GimpParamSpecTextLayer` specifying a
/// `TextLayer` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_text_layer(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_none_ok: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecTextLayer = gimp_param_spec_text_layer;

/// Creates a param spec to hold a units param.
/// See `gobject.ParamSpec.internal` for more information.
extern fn gimp_param_spec_unit(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_allow_pixel: c_int, p_allow_percent: c_int, p_default_value: *gimp.Unit, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecUnit = gimp_param_spec_unit;

extern fn gimp_param_spec_unit_percent_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecUnitPercentAllowed = gimp_param_spec_unit_percent_allowed;

extern fn gimp_param_spec_unit_pixel_allowed(p_pspec: *gobject.ParamSpec) c_int;
pub const paramSpecUnitPixelAllowed = gimp_param_spec_unit_pixel_allowed;

/// Creates a new `GimpParamSpecValueArray` specifying a
/// `gobject.ValueArray` property.
///
/// See `gobject.ParamSpec.internal` for details on property names.
extern fn gimp_param_spec_value_array(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_element_spec: ?*gobject.ParamSpec, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecValueArray = gimp_param_spec_value_array;

extern fn gimp_param_spec_value_array_get_element_spec(p_pspec: *gobject.ParamSpec) *gobject.ParamSpec;
pub const paramSpecValueArrayGetElementSpec = gimp_param_spec_value_array_get_element_spec;

/// Close the pattern selection dialog.
///
/// Closes an open pattern selection dialog.
extern fn gimp_patterns_close_popup(p_pattern_callback: [*:0]const u8) c_int;
pub const patternsClosePopup = gimp_patterns_close_popup;

/// Retrieve a complete listing of the available patterns.
///
/// This procedure returns a complete listing of available GIMP
/// patterns.
/// Each pattern returned can be used as input to
/// `gimp.contextSetPattern`.
extern fn gimp_patterns_get_list(p_filter: ?[*:0]const u8) [*]*gimp.Pattern;
pub const patternsGetList = gimp_patterns_get_list;

/// Invokes the Gimp pattern selection.
///
/// Opens the pattern selection dialog.
extern fn gimp_patterns_popup(p_pattern_callback: [*:0]const u8, p_popup_title: [*:0]const u8, p_initial_pattern: ?*gimp.Pattern, p_parent_window: ?*glib.Bytes) c_int;
pub const patternsPopup = gimp_patterns_popup;

/// Refresh current patterns. This function always succeeds.
///
/// This procedure retrieves all patterns currently in the user's
/// pattern path and updates all pattern dialogs accordingly.
extern fn gimp_patterns_refresh() c_int;
pub const patternsRefresh = gimp_patterns_refresh;

/// Sets the current pattern in a pattern selection dialog.
///
/// Sets the current pattern in a pattern selection dialog.
extern fn gimp_patterns_set_popup(p_pattern_callback: [*:0]const u8, p_pattern: *gimp.Pattern) c_int;
pub const patternsSetPopup = gimp_patterns_set_popup;

/// Paint in the current brush without sub-pixel sampling.
///
/// This tool is the standard pencil. It draws linearly interpolated
/// lines through the specified stroke coordinates. It operates on the
/// specified drawable in the foreground color with the active brush.
/// The brush mask is treated as though it contains only black and white
/// values. Any value below half is treated as black; any above half, as
/// white.
extern fn gimp_pencil(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const pencil = gimp_pencil;

/// Returns a `gegl.Buffer` that's either backed by the `pixbuf`'s pixels,
/// or a copy of them. This function tries to not copy the `pixbuf`'s
/// pixels. If the pixbuf's rowstride is a multiple of its bpp, a
/// simple reference to the `pixbuf`'s pixels is made and `pixbuf` will
/// be kept around for as long as the buffer exists; otherwise the
/// pixels are copied.
extern fn gimp_pixbuf_create_buffer(p_pixbuf: *gdkpixbuf.Pixbuf) *gegl.Buffer;
pub const pixbufCreateBuffer = gimp_pixbuf_create_buffer;

/// Returns the Babl format that corresponds to the `pixbuf`'s pixel format.
extern fn gimp_pixbuf_get_format(p_pixbuf: *gdkpixbuf.Pixbuf) *const babl.Object;
pub const pixbufGetFormat = gimp_pixbuf_get_format;

/// Returns the ICC profile attached to the `pixbuf`, or `NULL` if there
/// is none.
extern fn gimp_pixbuf_get_icc_profile(p_pixbuf: *gdkpixbuf.Pixbuf, p_length: *usize) ?[*]u8;
pub const pixbufGetIccProfile = gimp_pixbuf_get_icc_profile;

/// Converts a `value` specified in pixels to `unit`.
extern fn gimp_pixels_to_units(p_pixels: f64, p_unit: *gimp.Unit, p_resolution: f64) f64;
pub const pixelsToUnits = gimp_pixels_to_units;

extern fn gimp_pixpipe_params_build(p_params: *gimp.PixPipeParams) [*:0]u8;
pub const pixpipeParamsBuild = gimp_pixpipe_params_build;

extern fn gimp_pixpipe_params_free(p_params: *gimp.PixPipeParams) void;
pub const pixpipeParamsFree = gimp_pixpipe_params_free;

extern fn gimp_pixpipe_params_init(p_params: *gimp.PixPipeParams) void;
pub const pixpipeParamsInit = gimp_pixpipe_params_init;

extern fn gimp_pixpipe_params_parse(p_parameters: [*:0]const u8, p_params: *gimp.PixPipeParams) void;
pub const pixpipeParamsParse = gimp_pixpipe_params_parse;

/// Cancels a running progress.
///
/// This function cancels the currently running progress.
extern fn gimp_progress_cancel(p_progress_callback: [*:0]const u8) c_int;
pub const progressCancel = gimp_progress_cancel;

/// Ends the progress bar for the current plug-in.
///
/// Ends the progress display for the current plug-in. Most plug-ins
/// don't need to call this, they just exit when the work is done. It is
/// only valid to call this procedure from a plug-in.
extern fn gimp_progress_end() c_int;
pub const progressEnd = gimp_progress_end;

/// Returns the native handle of the toplevel window this plug-in's
/// progress is or would be displayed in.
///
/// This function returns the native handle allowing to identify the
/// toplevel window this plug-in's progress is displayed in. It should
/// still work even if the progress bar has not been initialized yet,
/// unless the plug-in wasn't called from a GUI.
/// This handle can be of various types (integer, string, etc.)
/// depending on the platform you are running on which is why it returns
/// a GBytes. There are usually no reasons to call this directly.
extern fn gimp_progress_get_window_handle() *glib.Bytes;
pub const progressGetWindowHandle = gimp_progress_get_window_handle;

/// Initializes the progress bar for the current plug-in.
///
/// Initializes the progress bar for the current plug-in. It is only
/// valid to call this procedure from a plug-in.
extern fn gimp_progress_init(p_message: [*:0]const u8) c_int;
pub const progressInit = gimp_progress_init;

/// Initializes the progress bar for the current plug-in.
///
/// Initializes the progress bar for the current plug-in. It is only
/// valid to call this procedure from a plug-in.
extern fn gimp_progress_init_printf(p_format: [*:0]const u8, ...) c_int;
pub const progressInitPrintf = gimp_progress_init_printf;

extern fn gimp_progress_install_vtable(p_vtable: *const gimp.ProgressVtable, p_user_data: ?*anyopaque, p_user_data_destroy: ?glib.DestroyNotify) [*:0]const u8;
pub const progressInstallVtable = gimp_progress_install_vtable;

/// Pulses the progress bar for the current plug-in.
///
/// Updates the progress bar for the current plug-in. It is only valid
/// to call this procedure from a plug-in. Use this function instead of
/// `gimp.progressUpdate` if you cannot tell how much progress has been
/// made. This usually causes the the progress bar to enter \"activity
/// mode\", where a block bounces back and forth.
extern fn gimp_progress_pulse() c_int;
pub const progressPulse = gimp_progress_pulse;

/// Changes the text in the progress bar for the current plug-in.
///
/// This function changes the text in the progress bar for the current
/// plug-in. Unlike `gimp.progressInit` it does not change the
/// displayed value.
extern fn gimp_progress_set_text(p_message: ?[*:0]const u8) c_int;
pub const progressSetText = gimp_progress_set_text;

/// Changes the text in the progress bar for the current plug-in.
///
/// This function changes the text in the progress bar for the current
/// plug-in. Unlike `gimp.progressInit` it does not change the
/// displayed value.
extern fn gimp_progress_set_text_printf(p_format: [*:0]const u8, ...) c_int;
pub const progressSetTextPrintf = gimp_progress_set_text_printf;

/// Uninstalls a temporary progress procedure that was installed using
/// `gimp_progress_install`.
extern fn gimp_progress_uninstall(p_progress_callback: [*:0]const u8) void;
pub const progressUninstall = gimp_progress_uninstall;

/// Updates the progress bar for the current plug-in.
///
/// The library will handle over-updating by possibly dropping silently
/// some updates when they happen too close next to each other (either
/// time-wise or step-wise).
/// The caller does not have to take care of this aspect of progression
/// and can focus on computing relevant progression steps.
extern fn gimp_progress_update(p_percentage: f64) c_int;
pub const progressUpdate = gimp_progress_update;

/// Forcefully causes the GIMP library to exit and close down its
/// connection to main gimp application. This function never returns.
extern fn gimp_quit() void;
pub const quit = gimp_quit;

/// This function proposes reasonable settings for increments and display
/// digits. These can be used for instance on `GtkRange` or other widgets
/// using a `GtkAdjustment` typically.
/// Note that it will never return `digits` with value 0. If you know that
/// your input needs to display integer values, there is no need to set
/// `digits`.
///
/// There is no universal answer to the best increments and number of
/// decimal places. It often depends on context of what the value is
/// meant to represent. This function only tries to provide sensible
/// generic values which can be used when it doesn't matter too much or
/// for generated GUI for instance. If you know exactly how you want to
/// show and interact with a given range, you don't have to use this
/// function.
extern fn gimp_range_estimate_settings(p_lower: f64, p_upper: f64, p_step: ?*f64, p_page: ?*f64, p_digits: ?*c_int) void;
pub const rangeEstimateSettings = gimp_range_estimate_settings;

/// Calculates the intersection of two rectangles.
extern fn gimp_rectangle_intersect(p_x1: c_int, p_y1: c_int, p_width1: c_int, p_height1: c_int, p_x2: c_int, p_y2: c_int, p_width2: c_int, p_height2: c_int, p_dest_x: ?*c_int, p_dest_y: ?*c_int, p_dest_width: ?*c_int, p_dest_height: ?*c_int) c_int;
pub const rectangleIntersect = gimp_rectangle_intersect;

/// Calculates the union of two rectangles.
extern fn gimp_rectangle_union(p_x1: c_int, p_y1: c_int, p_width1: c_int, p_height1: c_int, p_x2: c_int, p_y2: c_int, p_width2: c_int, p_height2: c_int, p_dest_x: ?*c_int, p_dest_y: ?*c_int, p_dest_width: ?*c_int, p_dest_height: ?*c_int) void;
pub const rectangleUnion = gimp_rectangle_union;

/// Returns whether or not GimpDialog should automatically add a help
/// button if help_func and help_id are given.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_show_help_button() c_int;
pub const showHelpButton = gimp_show_help_button;

/// Smudge image with varying pressure.
///
/// This tool simulates a smudge using the current brush. High pressure
/// results in a greater smudge of paint while low pressure results in a
/// lesser smudge.
extern fn gimp_smudge(p_drawable: *gimp.Drawable, p_pressure: f64, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const smudge = gimp_smudge;

/// Smudge image with varying pressure.
///
/// This tool simulates a smudge using the current brush. It behaves
/// exactly the same as `gimp.smudge` except that the pressure value is
/// taken from the smudge tool options or the options default if the
/// tools option dialog has not been activated.
extern fn gimp_smudge_default(p_drawable: *gimp.Drawable, p_num_strokes: usize, p_strokes: [*]const f64) c_int;
pub const smudgeDefault = gimp_smudge_default;

/// Returns `TRUE` if we have dependencies to generate backtraces. If
/// `optimal` is `TRUE`, the function will return `TRUE` only when we
/// are able to generate optimal traces (i.e. with GDB or LLDB);
/// otherwise we return `TRUE` even if only `backtrace` API is available.
///
/// On Win32, we return TRUE if Dr. Mingw is built-in, FALSE otherwise.
///
/// Note: this function is not crash-safe, i.e. you should not try to use
/// it in a callback when the program is already crashing. In such a
/// case, call `gimp.stackTracePrint` or `gimp.stackTraceQuery`
/// directly.
extern fn gimp_stack_trace_available(p_optimal: c_int) c_int;
pub const stackTraceAvailable = gimp_stack_trace_available;

/// Attempts to generate a stack trace at current code position in
/// `prog_name`. `prog_name` is mostly a helper and can be set to NULL.
/// Nevertheless if set, it has to be the current program name (argv[0]).
/// This function is not meant to generate stack trace for third-party
/// programs, and will attach the current process id only.
/// Internally, this function uses `gdb` or `lldb` if they are available,
/// or the `stacktrace` API on platforms where it is available. It always
/// fails on Win32.
///
/// The stack trace, once generated, will either be printed to `stream` or
/// returned as a newly allocated string in `trace`, if not `NULL`.
///
/// In some error cases (e.g. segmentation fault), trying to allocate
/// more memory will trigger more segmentation faults and therefore loop
/// our error handling (which is just wrong). Therefore printing to a
/// file description is an implementation without any memory allocation.
extern fn gimp_stack_trace_print(p_prog_name: [*:0]const u8, p_stream: ?*anyopaque, p_trace: ?*[*:0]u8) c_int;
pub const stackTracePrint = gimp_stack_trace_print;

/// This is mostly the same as `glib.onErrorQuery` except that we use our
/// own backtrace function, much more complete.
/// `prog_name` must be the current program name (argv[0]).
/// It does nothing on Win32.
extern fn gimp_stack_trace_query(p_prog_name: [*:0]const u8) void;
pub const stackTraceQuery = gimp_stack_trace_query;

/// This function returns a copy of `str` stripped of underline
/// characters. This comes in handy when needing to strip mnemonics
/// from menu paths etc.
///
/// In some languages, mnemonics are handled by adding the mnemonic
/// character in brackets (like "File (_F)"). This function recognizes
/// this construct and removes the whole bracket construction to get
/// rid of the mnemonic (see bug 157561).
extern fn gimp_strip_uline(p_str: ?[*:0]const u8) [*:0]u8;
pub const stripUline = gimp_strip_uline;

/// Returns the top directory for GIMP config files. If the environment
/// variable GIMP3_SYSCONFDIR exists, that is used.  It should be an
/// absolute pathname.  Otherwise, on Unix the compile-time defined
/// directory is used. On Windows, the installation directory as deduced
/// from the executable's full filename is used.
///
/// In config files such as gimprc, the string ${gimp_sysconf_dir}
/// expands to this directory.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8. (On Windows it always is
/// UTF-8.).
extern fn gimp_sysconf_directory() [*:0]const u8;
pub const sysconfDirectory = gimp_sysconf_directory;

/// Returns a `gio.File` in the sysconf directory, or the sysconf directory
/// itself if `first_element` is `NULL`.
///
/// See also: `gimp.sysconfDirectory`.
extern fn gimp_sysconf_directory_file(p_first_element: [*:0]const u8, ...) *gio.File;
pub const sysconfDirectoryFile = gimp_sysconf_directory_file;

/// Returns the default top directory for GIMP temporary files. If the
/// environment variable GIMP3_TEMPDIR exists, that is used.  It
/// should be an absolute pathname.  Otherwise, a subdirectory of the
/// directory returned by `glib.getTmpDir` is used.
///
/// In config files such as gimprc, the string ${gimp_temp_dir} expands
/// to this directory.
///
/// Note that the actual directories used for GIMP temporary files can
/// be overridden by the user in the preferences dialog.
///
/// The returned string is owned by GIMP and must not be modified or
/// freed. The returned string is in the encoding used for filenames by
/// GLib, which isn't necessarily UTF-8. (On Windows it always is
/// UTF-8.).
extern fn gimp_temp_directory() [*:0]const u8;
pub const tempDirectory = gimp_temp_directory;

/// Generates a unique temporary file.
///
/// Generates a unique file using the temp path supplied in the user's
/// gimprc.
extern fn gimp_temp_file(p_extension: ?[*:0]const u8) *gio.File;
pub const tempFile = gimp_temp_file;

/// Add text at the specified location as a floating selection or a new
/// layer.
///
/// The x and y parameters together control the placement of the new
/// text by specifying the upper left corner of the text bounding box.
/// If the specified drawable parameter is valid, the text will be
/// created as a floating selection attached to the drawable. If the
/// drawable parameter is not valid (`NULL`), the text will appear as a
/// new layer. Finally, a border can be specified around the final
/// rendered text. The border is measured in pixels.
/// The size is always in pixels. If you need to display a font in
/// points, divide the size in points by 72.0 and multiply it by the
/// image's vertical resolution.
extern fn gimp_text_font(p_image: *gimp.Image, p_drawable: ?*gimp.Drawable, p_x: f64, p_y: f64, p_text: [*:0]const u8, p_border: c_int, p_antialias: c_int, p_size: f64, p_font: *gimp.Font) ?*gimp.Layer;
pub const textFont = gimp_text_font;

/// Get extents of the bounding box for the specified text.
///
/// This tool returns the width and height of a bounding box for the
/// specified text rendered with the specified font information. Ascent
/// and descent of the glyph extents are returned as well.
/// The ascent is the distance from the baseline to the highest point of
/// the character. This is positive if the glyph ascends above the
/// baseline. The descent is the distance from the baseline to the
/// lowest point of the character. This is positive if the glyph
/// descends below the baseline.
/// The size is always in pixels. If you need to set a font in points,
/// divide the size in points by 72.0 and multiply it by the vertical
/// resolution of the image you are taking into account.
extern fn gimp_text_get_extents_font(p_text: [*:0]const u8, p_size: f64, p_font: *gimp.Font, p_width: *c_int, p_height: *c_int, p_ascent: *c_int, p_descent: *c_int) c_int;
pub const textGetExtentsFont = gimp_text_get_extents_font;

/// Returns the tile height GIMP is using.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_tile_height() c_uint;
pub const tileHeight = gimp_tile_height;

/// Returns the tile width GIMP is using.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_tile_width() c_uint;
pub const tileWidth = gimp_tile_width;

/// Retrieves the translation context that has been previously set
/// using `gimp.typeSetTranslationContext`. You should not need to
/// use this function directly, use `gimp.enumGetValue` or
/// `gimp.enumValueGetDesc` instead.
extern fn gimp_type_get_translation_context(p_type: usize) [*:0]const u8;
pub const typeGetTranslationContext = gimp_type_get_translation_context;

/// Retrieves the gettext translation domain identifier that has been
/// previously set using `gimp.typeSetTranslationDomain`. You should
/// not need to use this function directly, use `gimp.enumGetValue`
/// or `gimp.enumValueGetDesc` instead.
extern fn gimp_type_get_translation_domain(p_type: usize) [*:0]const u8;
pub const typeGetTranslationDomain = gimp_type_get_translation_domain;

/// This function attaches a constant string as a translation context
/// to a `gobject.Type`. The only purpose of this function is to use it when
/// registering a `G_TYPE_ENUM` with translatable value names.
extern fn gimp_type_set_translation_context(p_type: usize, p_context: [*:0]const u8) void;
pub const typeSetTranslationContext = gimp_type_set_translation_context;

/// This function attaches a constant string as a gettext translation
/// domain identifier to a `gobject.Type`. The only purpose of this function is
/// to use it when registering a `G_TYPE_ENUM` with translatable value
/// names.
extern fn gimp_type_set_translation_domain(p_type: usize, p_domain: [*:0]const u8) void;
pub const typeSetTranslationDomain = gimp_type_set_translation_domain;

/// Converts a `value` specified in `unit` to pixels.
extern fn gimp_units_to_pixels(p_value: f64, p_unit: *gimp.Unit, p_resolution: f64) f64;
pub const unitsToPixels = gimp_units_to_pixels;

/// Converts a `value` specified in `unit` to points.
extern fn gimp_units_to_points(p_value: f64, p_unit: *gimp.Unit, p_resolution: f64) f64;
pub const unitsToPoints = gimp_units_to_points;

/// Returns the timestamp of the user interaction that should be set on
/// the plug-in window. This is handled transparently, plug-in authors
/// do not have to care about it.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_user_time() u32;
pub const userTime = gimp_user_time;

/// Creates a (possibly trimmed) copy of `str`. The string is cut if it
/// exceeds `max_chars` characters or on the first newline. The fact
/// that the string was trimmed is indicated by appending an ellipsis.
extern fn gimp_utf8_strtrim(p_str: ?[*:0]const u8, p_max_chars: c_int) [*:0]u8;
pub const utf8Strtrim = gimp_utf8_strtrim;

/// Gets the contents of a `GIMP_TYPE_DOUBLE_ARRAY` `gobject.Value`
extern fn gimp_value_dup_double_array(p_value: *const gobject.Value, p_length: *usize) [*]f64;
pub const valueDupDoubleArray = gimp_value_dup_double_array;

/// Gets the contents of a `GIMP_TYPE_INT32_ARRAY` `gobject.Value`
extern fn gimp_value_dup_int32_array(p_value: *const gobject.Value, p_length: *usize) [*]i32;
pub const valueDupInt32Array = gimp_value_dup_int32_array;

/// Gets the contents of a `GIMP_TYPE_DOUBLE_ARRAY` `gobject.Value`
extern fn gimp_value_get_double_array(p_value: *const gobject.Value, p_length: *usize) [*]const f64;
pub const valueGetDoubleArray = gimp_value_get_double_array;

/// Gets the contents of a `GIMP_TYPE_INT32_ARRAY` `gobject.Value`
extern fn gimp_value_get_int32_array(p_value: *const gobject.Value, p_length: *usize) [*]const i32;
pub const valueGetInt32Array = gimp_value_get_int32_array;

/// Sets the contents of `value` to `data`.
extern fn gimp_value_set_double_array(p_value: *gobject.Value, p_data: [*]const f64, p_length: usize) void;
pub const valueSetDoubleArray = gimp_value_set_double_array;

/// Sets the contents of `value` to `data`.
extern fn gimp_value_set_int32_array(p_value: *gobject.Value, p_data: [*]const i32, p_length: usize) void;
pub const valueSetInt32Array = gimp_value_set_int32_array;

/// Sets the contents of `value` to `data`, without copying the data.
extern fn gimp_value_set_static_double_array(p_value: *gobject.Value, p_data: [*]const f64, p_length: usize) void;
pub const valueSetStaticDoubleArray = gimp_value_set_static_double_array;

/// Sets the contents of `value` to `data`, without copying the data.
extern fn gimp_value_set_static_int32_array(p_value: *gobject.Value, p_data: [*]const i32, p_length: usize) void;
pub const valueSetStaticInt32Array = gimp_value_set_static_int32_array;

/// Sets the contents of `value` to `data`, and takes ownership of `data`.
extern fn gimp_value_take_double_array(p_value: *gobject.Value, p_data: [*]f64, p_length: usize) void;
pub const valueTakeDoubleArray = gimp_value_take_double_array;

/// Sets the contents of `value` to `data`, and takes ownership of `data`.
extern fn gimp_value_take_int32_array(p_value: *gobject.Value, p_data: [*]i32, p_length: usize) void;
pub const valueTakeInt32Array = gimp_value_take_int32_array;

/// \"Compute screen (sx, sy) - (sx + w, sy + h) to 3D unit square
/// mapping. The plane to map to is given in the z field of p. The
/// observer is located at position vp (vp->z != 0.0).\"
///
/// In other words, this computes the projection of the point (`x`, `y`)
/// to the plane z = `p`->z (parallel to XY), from the `vp` point of view
/// through the screen (`sx`, `sy`)->(`sx` + `w`, `sy` + `h`)
extern fn gimp_vector_2d_to_3d(p_sx: c_int, p_sy: c_int, p_w: c_int, p_h: c_int, p_x: c_int, p_y: c_int, p_vp: *const gimp.Vector3, p_p: *gimp.Vector3) void;
pub const vector2dTo3d = gimp_vector_2d_to_3d;

/// This function is identical to `gimp.vector2dTo3d` but the
/// position of the `observer` and the resulting point `p` are passed by
/// value rather than by reference.
extern fn gimp_vector_2d_to_3d_val(p_sx: c_int, p_sy: c_int, p_w: c_int, p_h: c_int, p_x: c_int, p_y: c_int, p_vp: gimp.Vector3, p_p: gimp.Vector3) gimp.Vector3;
pub const vector2dTo3dVal = gimp_vector_2d_to_3d_val;

/// Convert the given 3D point to 2D (project it onto the viewing
/// plane, (sx, sy, 0) - (sx + w, sy + h, 0). The input is assumed to
/// be in the unit square (0, 0, z) - (1, 1, z). The viewpoint of the
/// observer is passed in vp.
///
/// This is basically the opposite of `gimp.vector2dTo3d`.
extern fn gimp_vector_3d_to_2d(p_sx: c_int, p_sy: c_int, p_w: c_int, p_h: c_int, p_x: *f64, p_y: *f64, p_vp: *const gimp.Vector3, p_p: *const gimp.Vector3) void;
pub const vector3dTo2d = gimp_vector_3d_to_2d;

/// Returns the host GIMP version.
///
/// This procedure returns the version number of the currently running
/// GIMP.
extern fn gimp_version() [*:0]u8;
pub const version = gimp_version;

/// Returns the window manager class to be used for plug-in windows.
///
/// This is a constant value given at plug-in configuration time.
extern fn gimp_wm_class() [*:0]const u8;
pub const wmClass = gimp_wm_class;

/// The batch function is run during the lifetime of the GIMP session,
/// each time a plug-in batch procedure is called.
pub const BatchFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_command: [*:0]const u8, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// This function returns the capabilities requested by your export
/// procedure, depending on `config` or `options`.
pub const ExportGetCapabilitiesFunc = *const fn (p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_options: *gimp.ExportOptions, p_get_capabilities_data: ?*anyopaque) callconv(.c) gimp.ExportCapabilities;

/// Loading a vector image happens in 2 steps:
///
/// 1. this function is first run to determine which size should be actually requested.
/// 2. `RunVectorLoadFunc` is called with the suggested `width` and `height`.
///
/// This function is run during the lifetime of the GIMP session, as the first
/// step above. It should extract the maximum of information from the source
/// document to help GIMP take appropriate decisions for default values and also
/// for displaying relevant information in the load dialog (if necessary).
///
/// The best case scenario is to be able to extract proper dimensions (`width` and
/// `height`) with valid units supported by GIMP. If not possible, returning
/// already processed dimensions then setting `exact_width` and `exact_height` to
/// `FALSE` in `extracted_data` is also an option. If all you can get are no-unit
/// dimensions, set them with `GIMP_UNIT_PIXEL` and `correct_ratio` to `TRUE` to at
/// least give a valid ratio as a default.
///
/// If there is no way to extract any valid default dimensions, not even a ratio,
/// then return `FALSE` but leave `@"error"` as `NULL`. `RunVectorLoadFunc`
/// will still be called but default values might be bogus.
/// If the return value is `FALSE` and `@"error"` is set, it means that the file is
/// invalid and cannot even be loaded. Thus `RunVectorLoadFunc` won't be
/// run and `@"error"` is passed as the main run error.
///
/// Note: when `procedure` is run, the original arguments will be passed as
/// `config`. Nevertheless it may happen that this function is called with a `NULL`
/// `config`, in particular when `VectorLoadProcedure.extractDimensions` is
/// called. In such a case, the callback is expected to return whatever can be
/// considered "best judgement" defaults.
pub const ExtractVectorFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_file: *gio.File, p_metadata: *gimp.Metadata, p_config: ?*gimp.ProcedureConfig, p_extracted_data: *gimp.VectorLoadData, p_data_for_run: ?*anyopaque, p_data_for_run_destroy: ?*glib.DestroyNotify, p_extract_data: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// The signature of the query function a loadable GIMP module must
/// implement. In the module, the function must be called `Module.query`.
///
/// `Module` will copy the returned `ModuleInfo`, so the
/// module doesn't need to keep these values around (however in most
/// cases the module will just return a pointer to a constant
/// structure).
pub const ModuleQueryFunc = *const fn (p_module: *gobject.TypeModule) callconv(.c) *const gimp.ModuleInfo;

/// The signature of the register function a loadable GIMP module must
/// implement.  In the module, the function must be called
/// `Module.register`.
///
/// When this function is called, the module should register all the types
/// it implements with the passed `module`.
pub const ModuleRegisterFunc = *const fn (p_module: *gobject.TypeModule) callconv(.c) c_int;

pub const ProgressFunc = *const fn (p_min: c_int, p_max: c_int, p_current: c_int, p_data: ?*anyopaque) callconv(.c) void;

/// Ends the progress
pub const ProgressVtableEndFunc = *const fn (p_user_data: ?*anyopaque) callconv(.c) void;

pub const ProgressVtableGetWindowFunc = *const fn (p_user_data: ?*anyopaque) callconv(.c) *glib.Bytes;

/// Makes the progress pulse
pub const ProgressVtablePulseFunc = *const fn (p_user_data: ?*anyopaque) callconv(.c) void;

/// Sets a new text on the progress.
pub const ProgressVtableSetTextFunc = *const fn (p_message: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) void;

/// Sets a new percentage on the progress.
pub const ProgressVtableSetValueFunc = *const fn (p_percentage: f64, p_user_data: ?*anyopaque) callconv(.c) void;

/// Starts the progress
pub const ProgressVtableStartFunc = *const fn (p_message: [*:0]const u8, p_cancelable: c_int, p_user_data: ?*anyopaque) callconv(.c) void;

pub const PutPixelFunc = *const fn (p_x: c_int, p_y: c_int, p_color: *f64, p_data: ?*anyopaque) callconv(.c) void;

pub const RenderFunc = *const fn (p_x: f64, p_y: f64, p_color: *f64, p_data: ?*anyopaque) callconv(.c) void;

/// The export function is run during the lifetime of the GIMP session,
/// each time a plug-in export procedure is called.
///
/// If a MimeType was passed in `gimp.ExportProcedure.new`, then `metadata` will be
/// non-`NULL` and can be tweaked by the `run` function if needed. Otherwise you
/// can let it as-is and it will be stored back into the exported `file` according
/// to rules on metadata export shared across formats.
pub const RunExportFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_image: *gimp.Image, p_file: *gio.File, p_options: *gimp.ExportOptions, p_metadata: *gimp.Metadata, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// The run function is run during the lifetime of the GIMP session,
/// each time a plug-in procedure is called.
pub const RunFunc = *const fn (p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// The image function is run during the lifetime of the GIMP session,
/// each time a plug-in image procedure is called.
pub const RunImageFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_image: *gimp.Image, p_drawables: [*]*gimp.Drawable, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// The load function is run during the lifetime of the GIMP session, each time a
/// plug-in load procedure is called.
///
/// You are expected to read `file` and create a `gimp.Image` out of its
/// data. This image will be the first return value.
/// `metadata` will be filled from metadata from `file` if our infrastructure
/// supports this format. You may tweak this object, for instance adding metadata
/// specific to the format. You can also edit `flags` if you need to filter out
/// some specific common fields. For instance, it is customary to remove a
/// colorspace field with `MetadataLoadFlags` when a profile was added.
pub const RunLoadFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_file: *gio.File, p_metadata: *gimp.Metadata, p_flags: *gimp.MetadataLoadFlags, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// The thumbnail function is run during the lifetime of the GIMP session,
/// each time a plug-in thumbnail procedure is called.
///
/// `ThumbnailProcedure` are always run non-interactively.
///
/// On success, the returned array must contain:
/// 1. a `Image`: this is the only mandatory return value. It should
///    ideally be a simple image whose dimensions are closest to `size` and meant
///    to be displayed as a small static image.
/// 2. (optional) the full image's width (not the thumbnail's image's), or 0 if
///    unknown.
/// 3. (optional) the full image's height, or 0 if unknown.
/// 4. (optional) the `ImageType` of the full image.
/// 5. (optional) the number of layers in the full image.
pub const RunThumbnailFunc = *const fn (p_procedure: *gimp.Procedure, p_file: *gio.File, p_size: c_int, p_config: *gimp.ProcedureConfig, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

/// The load function is run during the lifetime of the GIMP session, each time a
/// plug-in load procedure is called.
///
/// You are expected to read `file` and create a `gimp.Image` out of its
/// data. This image will be the first return value.
/// `metadata` will be filled from metadata from `file` if our infrastructure
/// supports this format. You may tweak this object, for instance adding metadata
/// specific to the format. You can also edit `flags` if you need to filter out
/// some specific common fields. For instance, it is customary to remove a
/// colorspace field with `MetadataLoadFlags` when a profile was added.
///
/// Regarding returned image dimensions:
///
/// 1. If `width` or `height` is 0 or negative, the actual value will be computed
///    so that ratio is preserved. If `prefer_native_dimension` is `FALSE`, at
///    least one of the 2 dimensions should be strictly positive.
/// 2. If `preserve_ratio` is `TRUE`, then `width` and `height` are considered as a
///    max size in their respective dimension. I.e. that the resulting image will
///    be at most `widthx``height` while preserving original ratio. `preserve_ratio`
///    is implied when any of the dimension is 0 or negative.
/// 3. If `prefer_native_dimension` is `TRUE`, and if the image has some kind of
///    native size (if the format has such metadata or it can be computed), it
///    will be used rather than `widthx``height`. Note that if both dimensions are
///    0 or negative, even if `prefer_native_dimension` is TRUE yet the procedure
///    cannot determine native dimensions, then maybe a dialog could be popped
///    up (if implemented), unless the `run_mode` is
///    `gimp.@"RunMode.NONINTERACTIVE"`.
pub const RunVectorLoadFunc = *const fn (p_procedure: *gimp.Procedure, p_run_mode: gimp.RunMode, p_file: *gio.File, p_width: c_int, p_height: c_int, p_extracted_data: gimp.VectorLoadData, p_metadata: *gimp.Metadata, p_flags: *gimp.MetadataLoadFlags, p_config: *gimp.ProcedureConfig, p_data_from_extract: ?*anyopaque, p_run_data: ?*anyopaque) callconv(.c) *gimp.ValueArray;

pub const API_VERSION = "3.0";
/// The dark gray value for the default checkerboard pattern.
pub const CHECK_DARK = 0.400000;
/// The dark light value for the default checkerboard pattern.
pub const CHECK_LIGHT = 0.600000;
/// The default checkerboard size in pixels. This is configurable in
/// the core but GIMP plug-ins can't access the user preference and
/// should use this constant instead.
pub const CHECK_SIZE = 8;
/// The default small checkerboard size in pixels.
pub const CHECK_SIZE_SM = 4;
/// The object property is to be treated as part of the parent object.
pub const CONFIG_PARAM_AGGREGATE = 2;
/// Changes to this property should be confirmed by the user before
/// being applied.
pub const CONFIG_PARAM_CONFIRM = 8;
/// Don't serialize this property if it has the default value.
pub const CONFIG_PARAM_DEFAULTS = 16;
/// Ignore this property when comparing objects.
pub const CONFIG_PARAM_DONT_COMPARE = 64;
/// The default flags that should be used for serializable `gimp.Config`
/// properties.
pub const CONFIG_PARAM_FLAGS = 7;
/// Minimum shift count to be used for core application defined
/// `gobject.ParamFlags`.
pub const CONFIG_PARAM_FLAG_SHIFT = 7;
/// This property exists for obscure reasons or is needed for backward
/// compatibility. Ignore the value read and don't serialize it.
pub const CONFIG_PARAM_IGNORE = 32;
/// Changes to this property take effect only after a restart.
pub const CONFIG_PARAM_RESTART = 4;
/// A property that can and should be serialized and deserialized.
pub const CONFIG_PARAM_SERIALIZE = 1;
/// The major GIMP version number.
pub const MAJOR_VERSION = 3;
/// The maximum width and height of a GIMP image in pixels. This is a
/// somewhat arbitrary value that can be used when an upper value for
/// pixel sizes is needed; for example to give a spin button an upper
/// limit.
pub const MAX_IMAGE_SIZE = 524288;
/// A large but arbitrary value that can be used when an upper limit
/// for a memory size (in bytes) is needed. It is smaller than
/// `G_MAXDOUBLE` since the `GimpMemsizeEntry` doesn't handle larger
/// values.
pub const MAX_MEMSIZE = 4398046511104;
/// The maximum resolution of a GIMP image in pixels per inch. This is
/// a somewhat arbitrary value that can be used to when an upper value
/// for a resolution is needed. GIMP will not accept resolutions larger
/// than this value.
pub const MAX_RESOLUTION = 1048576.000000;
/// The micro GIMP version number.
pub const MICRO_VERSION = 2;
/// The minor GIMP version number.
pub const MINOR_VERSION = 0;
/// The minimum width and height of a GIMP image in pixels.
pub const MIN_IMAGE_SIZE = 1;
/// The minimum resolution of a GIMP image in pixels per inch. This is
/// a somewhat arbitrary value that can be used when a lower value for a
/// resolution is needed. GIMP will not accept resolutions smaller than
/// this value.
pub const MIN_RESOLUTION = 0.005000;
/// The version of the module system's ABI. Modules put this value into
/// `gimp.ModuleInfo`'s `abi_version` field so the code loading the modules
/// can check if it was compiled against the same module ABI the modules
/// are compiled against.
///
///  GIMP_MODULE_ABI_VERSION is incremented each time one of the
///  following changes:
///
///  - the libgimpmodule implementation (if the change affects modules).
///
///  - one of the classes implemented by modules (currently `GimpColorDisplay`,
///    `GimpColorSelector` and `GimpController`).
pub const MODULE_ABI_VERSION = 5;
/// This property will be ignored when serializing and deserializing.
/// This is useful for GimpProcedure arguments for which you never want
/// the last run values to be restored.
///
/// Since 3.0
pub const PARAM_DONT_SERIALIZE = 2;
/// Minimum shift count to be used for libgimpconfig defined
/// `gobject.ParamFlags` (see libgimpconfig/gimpconfig-params.h).
pub const PARAM_FLAG_SHIFT = 2;
/// Since 3.0
pub const PARAM_NO_VALIDATE = 1;
pub const PARAM_READABLE = 1;
pub const PARAM_READWRITE = 3;
pub const PARAM_STATIC_STRINGS = 224;
pub const PARAM_WRITABLE = 2;
pub const PARASITE_ATTACH_GRANDPARENT = 8388608;
pub const PARASITE_ATTACH_PARENT = 32768;
pub const PARASITE_GRANDPARENT_PERSISTENT = 0;
pub const PARASITE_GRANDPARENT_UNDOABLE = 0;
pub const PARASITE_PARENT_PERSISTENT = 0;
pub const PARASITE_PARENT_UNDOABLE = 0;
pub const PARASITE_PERSISTENT = 1;
pub const PARASITE_UNDOABLE = 2;
pub const PIXPIPE_MAXDIM = 4;
/// The GIMP version as a string.
pub const VERSION = "3.0.2";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
