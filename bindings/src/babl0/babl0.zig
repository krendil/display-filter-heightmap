pub const ext = @import("ext.zig");
const babl = @This();

const std = @import("std");
const compat = @import("compat");
/// The babl API is based around polymorphism and almost everything is
/// a Babl object.
pub const Object = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IccIntent = enum(c_int) {
    perceptual = 0,
    relative_colorimetric = 1,
    saturation = 2,
    absolute_colorimetric = 3,
    performance = 32,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpaceFlags = enum(c_int) {
    none = 0,
    equalize = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ModelFlag = packed struct(c_uint) {
    _padding0: bool = false,
    alpha: bool = false,
    associated: bool = false,
    inverted: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    _padding8: bool = false,
    _padding9: bool = false,
    linear: bool = false,
    nonlinear: bool = false,
    perceptual: bool = false,
    _padding13: bool = false,
    _padding14: bool = false,
    _padding15: bool = false,
    _padding16: bool = false,
    _padding17: bool = false,
    _padding18: bool = false,
    _padding19: bool = false,
    gray: bool = false,
    rgb: bool = false,
    _padding22: bool = false,
    cie: bool = false,
    cmyk: bool = false,
    _padding25: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_alpha: ModelFlag = @bitCast(@as(c_uint, 2));
    pub const flags_associated: ModelFlag = @bitCast(@as(c_uint, 4));
    pub const flags_inverted: ModelFlag = @bitCast(@as(c_uint, 8));
    pub const flags_linear: ModelFlag = @bitCast(@as(c_uint, 1024));
    pub const flags_nonlinear: ModelFlag = @bitCast(@as(c_uint, 2048));
    pub const flags_perceptual: ModelFlag = @bitCast(@as(c_uint, 4096));
    pub const flags_gray: ModelFlag = @bitCast(@as(c_uint, 1048576));
    pub const flags_rgb: ModelFlag = @bitCast(@as(c_uint, 2097152));
    pub const flags_cie: ModelFlag = @bitCast(@as(c_uint, 8388608));
    pub const flags_cmyk: ModelFlag = @bitCast(@as(c_uint, 16777216));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Returns the babl object representing the color component given by
/// `name` such as for example "R", "cyan" or "CIE L".
extern fn babl_component(p_name: [*:0]const u8) *const babl.Object;
pub const component = babl_component;

/// Defines a new color component with babl.
///
///     babl_component_new  (const char *name,
///                          NULL);
extern fn babl_component_new(p_first_arg: ?*anyopaque, ...) *const babl.Object;
pub const componentNew = babl_component_new;

/// Returns the RGB space defined for the destination of conversion.
extern fn babl_conversion_get_destination_space(p_conversion: *const babl.Object) *const babl.Object;
pub const conversionGetDestinationSpace = babl_conversion_get_destination_space;

/// Returns the RGB space defined for the source of conversion.
extern fn babl_conversion_get_source_space(p_conversion: *const babl.Object) *const babl.Object;
pub const conversionGetSourceSpace = babl_conversion_get_source_space;

/// Defines a new conversion between either two formats, two models or
/// two types in babl.
///
///     babl_conversion_new (<BablFormat *source, BablFormat *destination|
///                          BablModel  *source, BablModel  *destination|
///                          BablType   *source, BablType   *destination>,
///                          <"linear"|"planar">, <BablFuncLinear | BablFuncPlanar> conv_func,
///                          NULL);
extern fn babl_conversion_new(p_first_arg: ?*anyopaque, ...) *const babl.Object;
pub const conversionNew = babl_conversion_new;

/// Deinitializes the babl library and frees any resources used when
/// matched with the number of calls to `babl.init`.
extern fn babl_exit() void;
pub const exit = babl_exit;

/// Create a faster than normal fish with specified performance (and thus
/// corresponding precision tradeoff), values tolerance can hold: NULL and
/// "default", means do same as `babl.fish`, other values understood in
/// increasing order of speed gain are:
///    "exact" "precise" "fast" "glitch"
///
/// Fast fishes should be cached, since they are not internally kept track
/// of/made into singletons by babl and many creations of fast fishes will
/// otherwise be a leak.
extern fn babl_fast_fish(p_source_format: ?*anyopaque, p_destination_format: ?*anyopaque, p_performance: [*:0]const u8) *const babl.Object;
pub const fastFish = babl_fast_fish;

/// Create a babl fish capable of converting from source_format to
///  destination_format, source and destination can be either strings
///  with the names of the formats or Babl-format objects.
extern fn babl_fish(p_source_format: ?*anyopaque, p_destination_format: ?*anyopaque) *const babl.Object;
pub const fish = babl_fish;

/// get the dispatch function of a fish, this allows faster use of a fish
/// in a loop than the more indirect method of babl_process, this also avoids
/// base-level instrumentation.
extern fn babl_fish_get_process(p_babl: *const babl.Object) babl.FishProcess;
pub const fishGetProcess = babl_fish_get_process;

/// Returns the babl object representing the color format given by
/// `name` such as for example "RGB u8", "CMYK float" or "CIE Lab u16",
/// creates a format using the sRGB space, to also specify the color space
/// and TRCs for a format, see babl_format_with_space.
extern fn babl_format(p_encoding: [*:0]const u8) *const babl.Object;
pub const format = babl_format;

/// Returns 1 if the provided format name is known by babl or 0 if it is
/// not. Can also be used to verify that specific extension formats are
/// available (though this can also be inferred from the version of babl).
extern fn babl_format_exists(p_name: [*:0]const u8) c_int;
pub const formatExists = babl_format_exists;

/// Returns the bytes per pixel for a babl color format.
extern fn babl_format_get_bytes_per_pixel(p_format: *const babl.Object) c_int;
pub const formatGetBytesPerPixel = babl_format_get_bytes_per_pixel;

/// Returns the components and data type, without space suffix.
extern fn babl_format_get_encoding(p_babl: *const babl.Object) [*:0]const u8;
pub const formatGetEncoding = babl_format_get_encoding;

/// Return the model used for constructing the format.
extern fn babl_format_get_model(p_format: *const babl.Object) *const babl.Object;
pub const formatGetModel = babl_format_get_model;

/// Returns the number of components for the given `format`.
extern fn babl_format_get_n_components(p_format: *const babl.Object) c_int;
pub const formatGetNComponents = babl_format_get_n_components;

extern fn babl_format_get_space(p_format: *const babl.Object) *const babl.Object;
pub const formatGetSpace = babl_format_get_space;

/// Returns the type in the given `format` for the given
/// `component_index`.
extern fn babl_format_get_type(p_format: *const babl.Object, p_component_index: c_int) *const babl.Object;
pub const formatGetType = babl_format_get_type;

/// Returns whether the `format` has an alpha channel.
extern fn babl_format_has_alpha(p_format: *const babl.Object) c_int;
pub const formatHasAlpha = babl_format_has_alpha;

/// Returns whether the `format` is a format_n type.
extern fn babl_format_is_format_n(p_format: *const babl.Object) c_int;
pub const formatIsFormatN = babl_format_is_format_n;

/// check whether a format is a palette backed format.
extern fn babl_format_is_palette(p_format: *const babl.Object) c_int;
pub const formatIsPalette = babl_format_is_palette;

extern fn babl_format_n(p_type: *const babl.Object, p_components: c_int) *const babl.Object;
pub const formatN = babl_format_n;

/// Defines a new pixel format in babl. Provided BablType and|or
/// BablSampling is valid for the following components as well. If no
/// name is provided a (long) descriptive name is used.
///
///     babl_format_new     (["name", const char *name,]
///                          BablModel          *model,
///                          [BablType           *type,]
///                          [BablSampling,      *sampling,]
///                          BablComponent      *component1,
///                          [[BablType           *type,]
///                           [BablSampling       *sampling,]
///                           BablComponent      *componentN,
///                           ...]
///                          ["planar",]
///                          NULL);
extern fn babl_format_new(p_first_arg: ?*anyopaque, ...) *const babl.Object;
pub const formatNew = babl_format_new;

/// Returns the babl object representing the color format given by
/// `name` such as for example "RGB u8", "R'G'B'A float", "Y float" with
/// a specific RGB working space used as the space, the resulting format
/// has -space suffixed to it, unless the space requested is sRGB then
/// the unsuffixed version is used. If a format is passed in as space
/// the space of the format is used.
extern fn babl_format_with_space(p_encoding: [*:0]const u8, p_space: *const babl.Object) *const babl.Object;
pub const formatWithSpace = babl_format_with_space;

/// Do a babl fish garbage collection cycle, should only be called
/// from the main thread with no concurrent babl processing in other
/// threads in paralell.
extern fn babl_gc() void;
pub const gc = babl_gc;

extern fn babl_get_model_flags(p_model: *const babl.Object) babl.ModelFlag;
pub const getModelFlags = babl_get_model_flags;

/// Returns a string describing a Babl object.
extern fn babl_get_name(p_babl: *const babl.Object) [*:0]const u8;
pub const getName = babl_get_name;

/// Get data set with babl_set_user_data
extern fn babl_get_user_data(p_babl: *const babl.Object) ?*anyopaque;
pub const getUserData = babl_get_user_data;

/// Get the version information on the babl library
extern fn babl_get_version(p_major: *c_int, p_minor: *c_int, p_micro: *c_int) void;
pub const getVersion = babl_get_version;

extern fn babl_icc_get_key(p_icc_data: [*:0]const u8, p_icc_length: c_int, p_key: [*:0]const u8, p_language: [*:0]const u8, p_country: [*:0]const u8) [*:0]u8;
pub const iccGetKey = babl_icc_get_key;

extern fn babl_icc_make_space(p_icc_data: [*:0]const u8, p_icc_length: c_int, p_intent: babl.IccIntent, p_error: *[*:0]const u8) *const babl.Object;
pub const iccMakeSpace = babl_icc_make_space;

/// Initializes the babl library.
extern fn babl_init() void;
pub const init = babl_init;

/// introspect a given BablObject
extern fn babl_introspect(p_babl: *babl.Object) void;
pub const introspect = babl_introspect;

/// Returns the babl object representing the color model given by `name`
/// such as for example "RGB", "CMYK" or "CIE Lab".
extern fn babl_model(p_name: [*:0]const u8) *const babl.Object;
pub const model = babl_model;

extern fn babl_model_is(p_babl: *const babl.Object, p_model_name: [*:0]const u8) c_int;
pub const modelIs = babl_model_is;

/// Defines a new color model in babl. If no name is provided a name is
/// generated by concatenating the name of all the involved components.
///
///     babl_model_new      (["name", const char *name,]
///                          BablComponent *component1,
///                          [BablComponent *componentN, ...]
///                          NULL);
extern fn babl_model_new(p_first_arg: ?*anyopaque, ...) *const babl.Object;
pub const modelNew = babl_model_new;

/// The models for formats also have a space in babl, try to avoid code
/// needing to use this.
extern fn babl_model_with_space(p_name: [*:0]const u8, p_space: *const babl.Object) *const babl.Object;
pub const modelWithSpace = babl_model_with_space;

/// create a new palette based format, name is optional pass in NULL to get
/// an anonymous format. If you pass in with_alpha the format also gets
/// an 8bit alpha channel. Returns the BablModel of the color model. If
/// you pass in the same name the previous formats will be provided
/// again.
extern fn babl_new_palette(p_name: [*:0]const u8, p_format_u8: **const babl.Object, p_format_u8_with_alpha: **const babl.Object) *const babl.Object;
pub const newPalette = babl_new_palette;

/// create a new palette based format, name is optional pass in NULL to get
/// an anonymous format. If you pass in with_alpha the format also gets
/// an 8bit alpha channel. Returns the BablModel of the color model. If
/// you pass in the same name the previous formats will be provided
/// again.
extern fn babl_new_palette_with_space(p_name: [*:0]const u8, p_space: *const babl.Object, p_format_u8: **const babl.Object, p_format_u8_with_alpha: **const babl.Object) *const babl.Object;
pub const newPaletteWithSpace = babl_new_palette_with_space;

/// reset a palette to initial state, frees up some caches that optimize
/// conversions.
extern fn babl_palette_reset(p_babl: *const babl.Object) void;
pub const paletteReset = babl_palette_reset;

/// Assign a palette to a palette format, the data is a single span of pixels
/// representing the colors of the palette.
extern fn babl_palette_set_palette(p_babl: *const babl.Object, p_format: *const babl.Object, p_data: [*]u8, p_count: c_int) void;
pub const paletteSetPalette = babl_palette_set_palette;

/// Process n pixels from source to destination using babl_fish,
///  returns number of pixels converted.
extern fn babl_process(p_babl_fish: *const babl.Object, p_source: ?*anyopaque, p_destination: ?*anyopaque, p_n: c_long) c_long;
pub const process = babl_process;

extern fn babl_process_rows(p_babl_fish: *const babl.Object, p_source: ?*anyopaque, p_source_stride: c_int, p_dest: ?*anyopaque, p_dest_stride: c_int, p_n: c_long, p_rows: c_int) c_long;
pub const processRows = babl_process_rows;

/// Returns the babl object representing the `horizontal` and `vertical`
/// sampling such as for example 2, 2 for the chroma components in
/// YCbCr.
extern fn babl_sampling(p_horizontal: c_int, p_vertical: c_int) *const babl.Object;
pub const sampling = babl_sampling;

/// associate a data pointer with a format/model, this data can be accessed and
/// used from the conversion functions, encoding color profiles, palettes or
/// similar with the data, perhaps this should be made internal API, not
/// accesible at all from
extern fn babl_set_user_data(p_babl: *const babl.Object, p_data: ?*anyopaque) void;
pub const setUserData = babl_set_user_data;

/// Returns the babl object representing the specific RGB matrix color
/// working space referred to by name. Babl knows of:
///    sRGB, Rec2020, Adobish, Apple and ProPhoto
extern fn babl_space(p_name: [*:0]const u8) *const babl.Object;
pub const space = babl_space;

/// Creates a new babl-space/ RGB matrix color space definition with the
/// specified CIE xy(Y) values for white point: wx, wy and primary
/// chromaticities: rx,ry,gx,gy,bx,by and TRCs to be used. After registering a
/// new babl-space it can be used with `babl.space` passing its name;
///
/// Internally this does the math to derive the RGBXYZ matrix as used in an ICC
/// profile.
extern fn babl_space_from_chromaticities(p_name: ?[*:0]const u8, p_wx: f64, p_wy: f64, p_rx: f64, p_ry: f64, p_gx: f64, p_gy: f64, p_bx: f64, p_by: f64, p_trc_red: *const babl.Object, p_trc_green: ?*const babl.Object, p_trc_blue: ?*const babl.Object, p_flags: babl.SpaceFlags) *const babl.Object;
pub const spaceFromChromaticities = babl_space_from_chromaticities;

/// Create a babl space from an in memory ICC profile, the profile does no
/// longer need to be loaded for the space to work, multiple calls with the same
/// icc profile and same intent will result in the same babl space.
///
/// On a profile that doesn't contain A2B0 and B2A0 CLUTs perceptual and
/// relative-colorimetric intents are treated the same.
///
/// If a BablSpace cannot be created from the profile NULL is returned and a
/// static string is set on the const char *value pointed at with &value
/// containing a message describing why the provided data does not yield a babl
/// space.
extern fn babl_space_from_icc(p_icc_data: [*:0]const u8, p_icc_length: c_int, p_intent: babl.IccIntent, p_error: *[*:0]const u8) *const babl.Object;
pub const spaceFromIcc = babl_space_from_icc;

/// Creates a new RGB matrix color space definition using a precomputed D50
/// adapted 3x3 matrix and associated CIE XYZ whitepoint, as possibly read from
/// an ICC profile.
extern fn babl_space_from_rgbxyz_matrix(p_name: ?[*:0]const u8, p_wx: f64, p_wy: f64, p_wz: f64, p_rx: f64, p_gx: f64, p_bx: f64, p_ry: f64, p_gy: f64, p_by: f64, p_rz: f64, p_gz: f64, p_bz: f64, p_trc_red: *const babl.Object, p_trc_green: ?*const babl.Object, p_trc_blue: ?*const babl.Object) *const babl.Object;
pub const spaceFromRgbxyzMatrix = babl_space_from_rgbxyz_matrix;

/// query the chromaticities of white point and primaries as well as trcs
/// used for r g a nd b, all arguments are optional (can be `NULL`).
extern fn babl_space_get(p_space: *const babl.Object, p_xw: ?*f64, p_yw: ?*f64, p_xr: ?*f64, p_yr: ?*f64, p_xg: ?*f64, p_yg: ?*f64, p_xb: ?*f64, p_yb: ?*f64, p_red_trc: ?**const babl.Object, p_green_trc: ?**const babl.Object, p_blue_trc: ?**const babl.Object) void;
pub const spaceGet = babl_space_get;

extern fn babl_space_get_gamma(p_space: *const babl.Object) f64;
pub const spaceGetGamma = babl_space_get_gamma;

/// Return pointer to ICC profile for space note that this is
/// the ICC profile for R'G'B', though in formats only supporting linear
/// like EXR GEGL chooses to load this lienar data as RGB and use the sRGB
/// TRC.
extern fn babl_space_get_icc(p_babl: *const babl.Object, p_length: ?*c_int) [*]const u8;
pub const spaceGetIcc = babl_space_get_icc;

/// Retrieve the relevant RGB luminance constants for a babl space.
///
/// Note: these luminance coefficients should only ever be used on linear data.
/// If your input `space` is non-linear, you should convert your pixel values to
/// the linearized variant of `space` before making any computation with these
/// coefficients. See `@"83"`.
extern fn babl_space_get_rgb_luminance(p_space: *const babl.Object, p_red_luminance: ?*f64, p_green_luminance: ?*f64, p_blue_luminance: ?*f64) void;
pub const spaceGetRgbLuminance = babl_space_get_rgb_luminance;

extern fn babl_space_is_cmyk(p_space: *const babl.Object) c_int;
pub const spaceIsCmyk = babl_space_is_cmyk;

extern fn babl_space_is_gray(p_space: *const babl.Object) c_int;
pub const spaceIsGray = babl_space_is_gray;

extern fn babl_space_is_rgb(p_space: *const babl.Object) c_int;
pub const spaceIsRgb = babl_space_is_rgb;

/// Creates a variant of an existing space with different trc.
extern fn babl_space_with_trc(p_space: *const babl.Object, p_trc: *const babl.Object) *const babl.Object;
pub const spaceWithTrc = babl_space_with_trc;

/// Look up a TRC by name, "sRGB" and "linear" are recognized
/// strings in a stock babl configuration.
extern fn babl_trc(p_name: [*:0]const u8) *const babl.Object;
pub const trc = babl_trc;

/// Creates a Babl TRC for a specific gamma value, it will be given
/// a name that is a short string representation of the value.
extern fn babl_trc_gamma(p_gamma: f64) *const babl.Object;
pub const trcGamma = babl_trc_gamma;

/// Returns the babl object representing the data type given by `name`
/// such as for example "u8", "u16" or "float".
extern fn babl_type(p_name: [*:0]const u8) *const babl.Object;
pub const @"type" = babl_type;

/// Defines a new data type in babl. A data type that babl can have in
/// its buffers requires conversions to and from "double" to be
/// registered before passing sanity.
///
///     babl_type_new       (const char *name,
///                          "bits",     int bits,
///                          ["min_val", double min_val,]
///                          ["max_val", double max_val,]
///                          NULL);
extern fn babl_type_new(p_first_arg: ?*anyopaque, ...) *const babl.Object;
pub const typeNew = babl_type_new;

pub const FishProcess = *const fn (p_babl: *const babl.Object, p_src: [*:0]const u8, p_dst: [*:0]u8, p_n: c_long, p_data: ?*anyopaque) callconv(.c) void;

pub const FuncLinear = *const fn (p_conversion: *const babl.Object, p_src: [*:0]const u8, p_dst: [*:0]u8, p_n: c_long, p_user_data: ?*anyopaque) callconv(.c) void;

pub const FuncPlanar = *const fn (p_conversion: *const babl.Object, p_src_bands: c_int, p_src: *[*:0]const u8, p_src_pitch: *c_int, p_dst_bands: c_int, p_dst: *[*:0]u8, p_dst_pitch: *c_int, p_n: c_long, p_user_data: ?*anyopaque) callconv(.c) void;

pub const ALPHA_FLOOR = 0;
pub const ALPHA_FLOOR_F = 0;
pub const MAJOR_VERSION = 0;
pub const MICRO_VERSION = 112;
pub const MINOR_VERSION = 1;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
