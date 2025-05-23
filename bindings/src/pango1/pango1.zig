pub const ext = @import("ext.zig");
const pango = @This();

const std = @import("std");
const compat = @import("compat");
const cairo = @import("cairo1");
const gobject = @import("gobject2");
const glib = @import("glib2");
const harfbuzz = @import("harfbuzz0");
const freetype2 = @import("freetype22");
const gio = @import("gio2");
const gmodule = @import("gmodule2");
/// A `PangoGlyph` represents a single glyph in the output form of a string.
pub const Glyph = u32;

/// The `PangoGlyphUnit` type is used to store dimensions within
/// Pango.
///
/// Dimensions are stored in 1/PANGO_SCALE of a device unit.
/// (A device unit might be a pixel for screen display, or
/// a point on a printer.) PANGO_SCALE is currently 1024, and
/// may change in the future (unlikely though), but you should not
/// depend on its exact value.
///
/// The `PANGO_PIXELS` macro can be used to convert from glyph units
/// into device units with correct rounding.
pub const GlyphUnit = i32;

/// A `PangoLayoutRun` represents a single run within a `PangoLayoutLine`.
///
/// It is simply an alternate name for `pango.GlyphItem`.
/// See the `pango.GlyphItem` docs for details on the fields.
pub const LayoutRun = pango.GlyphItem;

/// A `PangoContext` stores global information used to control the
/// itemization process.
///
/// The information stored by `PangoContext` includes the fontmap used
/// to look up fonts, and default values such as the default language,
/// default gravity, or default font.
///
/// To obtain a `PangoContext`, use `pango.FontMap.createContext`.
pub const Context = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.ContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `PangoContext` initialized to default values.
    ///
    /// This function is not particularly useful as it should always
    /// be followed by a `pango.Context.setFontMap` call, and the
    /// function `pango.FontMap.createContext` does these two steps
    /// together and hence users are recommended to use that.
    ///
    /// If you are using Pango as part of a higher-level system,
    /// that system may have it's own way of create a `PangoContext`.
    /// For instance, the GTK toolkit has, among others,
    /// ``gtk_widget_get_pango_context``. Use those instead.
    extern fn pango_context_new() *pango.Context;
    pub const new = pango_context_new;

    /// Forces a change in the context, which will cause any `PangoLayout`
    /// using this context to re-layout.
    ///
    /// This function is only useful when implementing a new backend
    /// for Pango, something applications won't do. Backends should
    /// call this function if they have attached extra data to the context
    /// and such data is changed.
    extern fn pango_context_changed(p_context: *Context) void;
    pub const changed = pango_context_changed;

    /// Retrieves the base direction for the context.
    ///
    /// See `pango.Context.setBaseDir`.
    extern fn pango_context_get_base_dir(p_context: *Context) pango.Direction;
    pub const getBaseDir = pango_context_get_base_dir;

    /// Retrieves the base gravity for the context.
    ///
    /// See `pango.Context.setBaseGravity`.
    extern fn pango_context_get_base_gravity(p_context: *Context) pango.Gravity;
    pub const getBaseGravity = pango_context_get_base_gravity;

    /// Retrieve the default font description for the context.
    extern fn pango_context_get_font_description(p_context: *Context) ?*pango.FontDescription;
    pub const getFontDescription = pango_context_get_font_description;

    /// Gets the `PangoFontMap` used to look up fonts for this context.
    extern fn pango_context_get_font_map(p_context: *Context) ?*pango.FontMap;
    pub const getFontMap = pango_context_get_font_map;

    /// Retrieves the gravity for the context.
    ///
    /// This is similar to `pango.Context.getBaseGravity`,
    /// except for when the base gravity is `PANGO_GRAVITY_AUTO` for
    /// which `pango.Gravity.getForMatrix` is used to return the
    /// gravity from the current context matrix.
    extern fn pango_context_get_gravity(p_context: *Context) pango.Gravity;
    pub const getGravity = pango_context_get_gravity;

    /// Retrieves the gravity hint for the context.
    ///
    /// See `pango.Context.setGravityHint` for details.
    extern fn pango_context_get_gravity_hint(p_context: *Context) pango.GravityHint;
    pub const getGravityHint = pango_context_get_gravity_hint;

    /// Retrieves the global language tag for the context.
    extern fn pango_context_get_language(p_context: *Context) *pango.Language;
    pub const getLanguage = pango_context_get_language;

    /// Gets the transformation matrix that will be applied when
    /// rendering with this context.
    ///
    /// See `pango.Context.setMatrix`.
    extern fn pango_context_get_matrix(p_context: *Context) ?*const pango.Matrix;
    pub const getMatrix = pango_context_get_matrix;

    /// Get overall metric information for a particular font description.
    ///
    /// Since the metrics may be substantially different for different scripts,
    /// a language tag can be provided to indicate that the metrics should be
    /// retrieved that correspond to the script(s) used by that language.
    ///
    /// The `PangoFontDescription` is interpreted in the same way as by `itemize`,
    /// and the family name may be a comma separated list of names. If characters
    /// from multiple of these families would be used to render the string, then
    /// the returned fonts would be a composite of the metrics for the fonts loaded
    /// for the individual families.
    extern fn pango_context_get_metrics(p_context: *Context, p_desc: ?*const pango.FontDescription, p_language: ?*pango.Language) *pango.FontMetrics;
    pub const getMetrics = pango_context_get_metrics;

    /// Returns whether font rendering with this context should
    /// round glyph positions and widths.
    extern fn pango_context_get_round_glyph_positions(p_context: *Context) c_int;
    pub const getRoundGlyphPositions = pango_context_get_round_glyph_positions;

    /// Returns the current serial number of `context`.
    ///
    /// The serial number is initialized to an small number larger than zero
    /// when a new context is created and is increased whenever the context
    /// is changed using any of the setter functions, or the `PangoFontMap` it
    /// uses to find fonts has changed. The serial may wrap, but will never
    /// have the value 0. Since it can wrap, never compare it with "less than",
    /// always use "not equals".
    ///
    /// This can be used to automatically detect changes to a `PangoContext`,
    /// and is only useful when implementing objects that need update when their
    /// `PangoContext` changes, like `PangoLayout`.
    extern fn pango_context_get_serial(p_context: *Context) c_uint;
    pub const getSerial = pango_context_get_serial;

    /// List all families for a context.
    extern fn pango_context_list_families(p_context: *Context, p_families: *[*]*pango.FontFamily, p_n_families: *c_int) void;
    pub const listFamilies = pango_context_list_families;

    /// Loads the font in one of the fontmaps in the context
    /// that is the closest match for `desc`.
    extern fn pango_context_load_font(p_context: *Context, p_desc: *const pango.FontDescription) ?*pango.Font;
    pub const loadFont = pango_context_load_font;

    /// Load a set of fonts in the context that can be used to render
    /// a font matching `desc`.
    extern fn pango_context_load_fontset(p_context: *Context, p_desc: *const pango.FontDescription, p_language: *pango.Language) ?*pango.Fontset;
    pub const loadFontset = pango_context_load_fontset;

    /// Sets the base direction for the context.
    ///
    /// The base direction is used in applying the Unicode bidirectional
    /// algorithm; if the `direction` is `PANGO_DIRECTION_LTR` or
    /// `PANGO_DIRECTION_RTL`, then the value will be used as the paragraph
    /// direction in the Unicode bidirectional algorithm. A value of
    /// `PANGO_DIRECTION_WEAK_LTR` or `PANGO_DIRECTION_WEAK_RTL` is used only
    /// for paragraphs that do not contain any strong characters themselves.
    extern fn pango_context_set_base_dir(p_context: *Context, p_direction: pango.Direction) void;
    pub const setBaseDir = pango_context_set_base_dir;

    /// Sets the base gravity for the context.
    ///
    /// The base gravity is used in laying vertical text out.
    extern fn pango_context_set_base_gravity(p_context: *Context, p_gravity: pango.Gravity) void;
    pub const setBaseGravity = pango_context_set_base_gravity;

    /// Set the default font description for the context
    extern fn pango_context_set_font_description(p_context: *Context, p_desc: ?*const pango.FontDescription) void;
    pub const setFontDescription = pango_context_set_font_description;

    /// Sets the font map to be searched when fonts are looked-up
    /// in this context.
    ///
    /// This is only for internal use by Pango backends, a `PangoContext`
    /// obtained via one of the recommended methods should already have a
    /// suitable font map.
    extern fn pango_context_set_font_map(p_context: *Context, p_font_map: ?*pango.FontMap) void;
    pub const setFontMap = pango_context_set_font_map;

    /// Sets the gravity hint for the context.
    ///
    /// The gravity hint is used in laying vertical text out, and
    /// is only relevant if gravity of the context as returned by
    /// `pango.Context.getGravity` is set to `PANGO_GRAVITY_EAST`
    /// or `PANGO_GRAVITY_WEST`.
    extern fn pango_context_set_gravity_hint(p_context: *Context, p_hint: pango.GravityHint) void;
    pub const setGravityHint = pango_context_set_gravity_hint;

    /// Sets the global language tag for the context.
    ///
    /// The default language for the locale of the running process
    /// can be found using `pango.Language.getDefault`.
    extern fn pango_context_set_language(p_context: *Context, p_language: ?*pango.Language) void;
    pub const setLanguage = pango_context_set_language;

    /// Sets the transformation matrix that will be applied when rendering
    /// with this context.
    ///
    /// Note that reported metrics are in the user space coordinates before
    /// the application of the matrix, not device-space coordinates after the
    /// application of the matrix. So, they don't scale with the matrix, though
    /// they may change slightly for different matrices, depending on how the
    /// text is fit to the pixel grid.
    extern fn pango_context_set_matrix(p_context: *Context, p_matrix: ?*const pango.Matrix) void;
    pub const setMatrix = pango_context_set_matrix;

    /// Sets whether font rendering with this context should
    /// round glyph positions and widths to integral positions,
    /// in device units.
    ///
    /// This is useful when the renderer can't handle subpixel
    /// positioning of glyphs.
    ///
    /// The default value is to round glyph positions, to remain
    /// compatible with previous Pango behavior.
    extern fn pango_context_set_round_glyph_positions(p_context: *Context, p_round_positions: c_int) void;
    pub const setRoundGlyphPositions = pango_context_set_round_glyph_positions;

    extern fn pango_context_get_type() usize;
    pub const getGObjectType = pango_context_get_type;

    extern fn g_object_ref(p_self: *pango.Context) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.Context) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Context, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoCoverage` structure is a map from Unicode characters
/// to `pango.CoverageLevel` values.
///
/// It is often necessary in Pango to determine if a particular
/// font can represent a particular character, and also how well
/// it can represent that character. The `PangoCoverage` is a data
/// structure that is used to represent that information. It is an
/// opaque structure with no public fields.
pub const Coverage = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Coverage;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Convert data generated from `pango.Coverage.toBytes`
    /// back to a `PangoCoverage`.
    extern fn pango_coverage_from_bytes(p_bytes: [*]u8, p_n_bytes: c_int) ?*pango.Coverage;
    pub const fromBytes = pango_coverage_from_bytes;

    /// Create a new `PangoCoverage`
    extern fn pango_coverage_new() *pango.Coverage;
    pub const new = pango_coverage_new;

    /// Copy an existing `PangoCoverage`.
    extern fn pango_coverage_copy(p_coverage: *Coverage) *pango.Coverage;
    pub const copy = pango_coverage_copy;

    /// Determine whether a particular index is covered by `coverage`.
    extern fn pango_coverage_get(p_coverage: *Coverage, p_index_: c_int) pango.CoverageLevel;
    pub const get = pango_coverage_get;

    /// Set the coverage for each index in `coverage` to be the max (better)
    /// value of the current coverage for the index and the coverage for
    /// the corresponding index in `other`.
    extern fn pango_coverage_max(p_coverage: *Coverage, p_other: *pango.Coverage) void;
    pub const max = pango_coverage_max;

    /// Increase the reference count on the `PangoCoverage` by one.
    extern fn pango_coverage_ref(p_coverage: *Coverage) *pango.Coverage;
    pub const ref = pango_coverage_ref;

    /// Modify a particular index within `coverage`
    extern fn pango_coverage_set(p_coverage: *Coverage, p_index_: c_int, p_level: pango.CoverageLevel) void;
    pub const set = pango_coverage_set;

    /// Convert a `PangoCoverage` structure into a flat binary format.
    extern fn pango_coverage_to_bytes(p_coverage: *Coverage, p_bytes: *[*]u8, p_n_bytes: *c_int) void;
    pub const toBytes = pango_coverage_to_bytes;

    /// Decrease the reference count on the `PangoCoverage` by one.
    ///
    /// If the result is zero, free the coverage and all associated memory.
    extern fn pango_coverage_unref(p_coverage: *Coverage) void;
    pub const unref = pango_coverage_unref;

    extern fn pango_coverage_get_type() usize;
    pub const getGObjectType = pango_coverage_get_type;

    pub fn as(p_instance: *Coverage, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFont` is used to represent a font in a
/// rendering-system-independent manner.
pub const Font = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.FontClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const create_hb_font = struct {
            pub fn call(p_class: anytype, p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *harfbuzz.font_t {
                return gobject.ext.as(Font.Class, p_class).f_create_hb_font.?(gobject.ext.as(Font, p_font));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *harfbuzz.font_t) void {
                gobject.ext.as(Font.Class, p_class).f_create_hb_font = @ptrCast(p_implementation);
            }
        };

        /// Returns a description of the font, with font size set in points.
        ///
        /// Use `pango.Font.describeWithAbsoluteSize` if you want
        /// the font size in device units.
        pub const describe = struct {
            pub fn call(p_class: anytype, p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.FontDescription {
                return gobject.ext.as(Font.Class, p_class).f_describe.?(gobject.ext.as(Font, p_font));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.FontDescription) void {
                gobject.ext.as(Font.Class, p_class).f_describe = @ptrCast(p_implementation);
            }
        };

        pub const describe_absolute = struct {
            pub fn call(p_class: anytype, p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.FontDescription {
                return gobject.ext.as(Font.Class, p_class).f_describe_absolute.?(gobject.ext.as(Font, p_font));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.FontDescription) void {
                gobject.ext.as(Font.Class, p_class).f_describe_absolute = @ptrCast(p_implementation);
            }
        };

        /// Computes the coverage map for a given font and language tag.
        pub const get_coverage = struct {
            pub fn call(p_class: anytype, p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_language: *pango.Language) *pango.Coverage {
                return gobject.ext.as(Font.Class, p_class).f_get_coverage.?(gobject.ext.as(Font, p_font), p_language);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_language: *pango.Language) callconv(.c) *pango.Coverage) void {
                gobject.ext.as(Font.Class, p_class).f_get_coverage = @ptrCast(p_implementation);
            }
        };

        /// Obtain the OpenType features that are provided by the font.
        ///
        /// These are passed to the rendering system, together with features
        /// that have been explicitly set via attributes.
        ///
        /// Note that this does not include OpenType features which the
        /// rendering system enables by default.
        pub const get_features = struct {
            pub fn call(p_class: anytype, p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_features: *[*]harfbuzz.feature_t, p_len: c_uint, p_num_features: *c_uint) void {
                return gobject.ext.as(Font.Class, p_class).f_get_features.?(gobject.ext.as(Font, p_font), p_features, p_len, p_num_features);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_features: *[*]harfbuzz.feature_t, p_len: c_uint, p_num_features: *c_uint) callconv(.c) void) void {
                gobject.ext.as(Font.Class, p_class).f_get_features = @ptrCast(p_implementation);
            }
        };

        /// Gets the font map for which the font was created.
        ///
        /// Note that the font maintains a *weak* reference to
        /// the font map, so if all references to font map are
        /// dropped, the font map will be finalized even if there
        /// are fonts created with the font map that are still alive.
        /// In that case this function will return `NULL`.
        ///
        /// It is the responsibility of the user to ensure that the
        /// font map is kept alive. In most uses this is not an issue
        /// as a `PangoContext` holds a reference to the font map.
        pub const get_font_map = struct {
            pub fn call(p_class: anytype, p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*pango.FontMap {
                return gobject.ext.as(Font.Class, p_class).f_get_font_map.?(gobject.ext.as(Font, p_font));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*pango.FontMap) void {
                gobject.ext.as(Font.Class, p_class).f_get_font_map = @ptrCast(p_implementation);
            }
        };

        /// Gets the logical and ink extents of a glyph within a font.
        ///
        /// The coordinate system for each rectangle has its origin at the
        /// base line and horizontal origin of the character with increasing
        /// coordinates extending to the right and down. The macros `PANGO_ASCENT`,
        /// `PANGO_DESCENT`, `PANGO_LBEARING`, and `PANGO_RBEARING` can be used to convert
        /// from the extents rectangle to more traditional font metrics. The units
        /// of the rectangles are in 1/PANGO_SCALE of a device unit.
        ///
        /// If `font` is `NULL`, this function gracefully sets some sane values in the
        /// output variables and returns.
        pub const get_glyph_extents = struct {
            pub fn call(p_class: anytype, p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_glyph: pango.Glyph, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void {
                return gobject.ext.as(Font.Class, p_class).f_get_glyph_extents.?(gobject.ext.as(Font, p_font), p_glyph, p_ink_rect, p_logical_rect);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_glyph: pango.Glyph, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) callconv(.c) void) void {
                gobject.ext.as(Font.Class, p_class).f_get_glyph_extents = @ptrCast(p_implementation);
            }
        };

        /// Gets overall metric information for a font.
        ///
        /// Since the metrics may be substantially different for different scripts,
        /// a language tag can be provided to indicate that the metrics should be
        /// retrieved that correspond to the script(s) used by that language.
        ///
        /// If `font` is `NULL`, this function gracefully sets some sane values in the
        /// output variables and returns.
        pub const get_metrics = struct {
            pub fn call(p_class: anytype, p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_language: ?*pango.Language) *pango.FontMetrics {
                return gobject.ext.as(Font.Class, p_class).f_get_metrics.?(gobject.ext.as(Font, p_font), p_language);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_font: ?*@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_language: ?*pango.Language) callconv(.c) *pango.FontMetrics) void {
                gobject.ext.as(Font.Class, p_class).f_get_metrics = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Frees an array of font descriptions.
    extern fn pango_font_descriptions_free(p_descs: ?[*]*pango.FontDescription, p_n_descs: c_int) void;
    pub const descriptionsFree = pango_font_descriptions_free;

    /// Loads data previously created via `pango.Font.serialize`.
    ///
    /// For a discussion of the supported format, see that function.
    ///
    /// Note: to verify that the returned font is identical to
    /// the one that was serialized, you can compare `bytes` to the
    /// result of serializing the font again.
    extern fn pango_font_deserialize(p_context: *pango.Context, p_bytes: *glib.Bytes, p_error: ?*?*glib.Error) ?*pango.Font;
    pub const deserialize = pango_font_deserialize;

    /// Returns a description of the font, with font size set in points.
    ///
    /// Use `pango.Font.describeWithAbsoluteSize` if you want
    /// the font size in device units.
    extern fn pango_font_describe(p_font: *Font) *pango.FontDescription;
    pub const describe = pango_font_describe;

    /// Returns a description of the font, with absolute font size set
    /// in device units.
    ///
    /// Use `pango.Font.describe` if you want the font size in points.
    extern fn pango_font_describe_with_absolute_size(p_font: *Font) *pango.FontDescription;
    pub const describeWithAbsoluteSize = pango_font_describe_with_absolute_size;

    /// Computes the coverage map for a given font and language tag.
    extern fn pango_font_get_coverage(p_font: *Font, p_language: *pango.Language) *pango.Coverage;
    pub const getCoverage = pango_font_get_coverage;

    /// Gets the `PangoFontFace` to which `font` belongs.
    extern fn pango_font_get_face(p_font: *Font) *pango.FontFace;
    pub const getFace = pango_font_get_face;

    /// Obtain the OpenType features that are provided by the font.
    ///
    /// These are passed to the rendering system, together with features
    /// that have been explicitly set via attributes.
    ///
    /// Note that this does not include OpenType features which the
    /// rendering system enables by default.
    extern fn pango_font_get_features(p_font: *Font, p_features: *[*]harfbuzz.feature_t, p_len: c_uint, p_num_features: *c_uint) void;
    pub const getFeatures = pango_font_get_features;

    /// Gets the font map for which the font was created.
    ///
    /// Note that the font maintains a *weak* reference to
    /// the font map, so if all references to font map are
    /// dropped, the font map will be finalized even if there
    /// are fonts created with the font map that are still alive.
    /// In that case this function will return `NULL`.
    ///
    /// It is the responsibility of the user to ensure that the
    /// font map is kept alive. In most uses this is not an issue
    /// as a `PangoContext` holds a reference to the font map.
    extern fn pango_font_get_font_map(p_font: ?*Font) ?*pango.FontMap;
    pub const getFontMap = pango_font_get_font_map;

    /// Gets the logical and ink extents of a glyph within a font.
    ///
    /// The coordinate system for each rectangle has its origin at the
    /// base line and horizontal origin of the character with increasing
    /// coordinates extending to the right and down. The macros `PANGO_ASCENT`,
    /// `PANGO_DESCENT`, `PANGO_LBEARING`, and `PANGO_RBEARING` can be used to convert
    /// from the extents rectangle to more traditional font metrics. The units
    /// of the rectangles are in 1/PANGO_SCALE of a device unit.
    ///
    /// If `font` is `NULL`, this function gracefully sets some sane values in the
    /// output variables and returns.
    extern fn pango_font_get_glyph_extents(p_font: ?*Font, p_glyph: pango.Glyph, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getGlyphExtents = pango_font_get_glyph_extents;

    /// Get a `hb_font_t` object backing this font.
    ///
    /// Note that the objects returned by this function are cached
    /// and immutable. If you need to make changes to the `hb_font_t`,
    /// use [`harfbuzz.fontCreateSubFont`](https://harfbuzz.github.io/harfbuzz-hb-font.html`hb`-font-create-sub-font).
    extern fn pango_font_get_hb_font(p_font: *Font) ?*harfbuzz.font_t;
    pub const getHbFont = pango_font_get_hb_font;

    /// Returns the languages that are supported by `font`.
    ///
    /// If the font backend does not provide this information,
    /// `NULL` is returned. For the fontconfig backend, this
    /// corresponds to the FC_LANG member of the FcPattern.
    ///
    /// The returned array is only valid as long as the font
    /// and its fontmap are valid.
    extern fn pango_font_get_languages(p_font: *Font) ?[*]*pango.Language;
    pub const getLanguages = pango_font_get_languages;

    /// Gets overall metric information for a font.
    ///
    /// Since the metrics may be substantially different for different scripts,
    /// a language tag can be provided to indicate that the metrics should be
    /// retrieved that correspond to the script(s) used by that language.
    ///
    /// If `font` is `NULL`, this function gracefully sets some sane values in the
    /// output variables and returns.
    extern fn pango_font_get_metrics(p_font: ?*Font, p_language: ?*pango.Language) *pango.FontMetrics;
    pub const getMetrics = pango_font_get_metrics;

    /// Returns whether the font provides a glyph for this character.
    extern fn pango_font_has_char(p_font: *Font, p_wc: u32) c_int;
    pub const hasChar = pango_font_has_char;

    /// Serializes the `font` in a way that can be uniquely identified.
    ///
    /// There are no guarantees about the format of the output across different
    /// versions of Pango.
    ///
    /// The intended use of this function is testing, benchmarking and debugging.
    /// The format is not meant as a permanent storage format.
    ///
    /// To recreate a font from its serialized form, use `pango.Font.deserialize`.
    extern fn pango_font_serialize(p_font: *Font) *glib.Bytes;
    pub const serialize = pango_font_serialize;

    extern fn pango_font_get_type() usize;
    pub const getGObjectType = pango_font_get_type;

    extern fn g_object_ref(p_self: *pango.Font) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.Font) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Font, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontFace` is used to represent a group of fonts with
/// the same family, slant, weight, and width, but varying sizes.
pub const FontFace = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.FontFaceClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Returns a font description that matches the face.
        ///
        /// The resulting font description will have the family, style,
        /// variant, weight and stretch of the face, but its size field
        /// will be unset.
        pub const describe = struct {
            pub fn call(p_class: anytype, p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.FontDescription {
                return gobject.ext.as(FontFace.Class, p_class).f_describe.?(gobject.ext.as(FontFace, p_face));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.FontDescription) void {
                gobject.ext.as(FontFace.Class, p_class).f_describe = @ptrCast(p_implementation);
            }
        };

        /// Gets a name representing the style of this face.
        ///
        /// Note that a font family may contain multiple faces
        /// with the same name (e.g. a variable and a non-variable
        /// face for the same style).
        pub const get_face_name = struct {
            pub fn call(p_class: anytype, p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(FontFace.Class, p_class).f_get_face_name.?(gobject.ext.as(FontFace, p_face));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(FontFace.Class, p_class).f_get_face_name = @ptrCast(p_implementation);
            }
        };

        /// Gets the `PangoFontFamily` that `face` belongs to.
        pub const get_family = struct {
            pub fn call(p_class: anytype, p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.FontFamily {
                return gobject.ext.as(FontFace.Class, p_class).f_get_family.?(gobject.ext.as(FontFace, p_face));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.FontFamily) void {
                gobject.ext.as(FontFace.Class, p_class).f_get_family = @ptrCast(p_implementation);
            }
        };

        /// Returns whether a `PangoFontFace` is synthesized.
        ///
        /// This will be the case if the underlying font rendering engine
        /// creates this face from another face, by shearing, emboldening,
        /// lightening or modifying it in some other way.
        pub const is_synthesized = struct {
            pub fn call(p_class: anytype, p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FontFace.Class, p_class).f_is_synthesized.?(gobject.ext.as(FontFace, p_face));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FontFace.Class, p_class).f_is_synthesized = @ptrCast(p_implementation);
            }
        };

        /// List the available sizes for a font.
        ///
        /// This is only applicable to bitmap fonts. For scalable fonts, stores
        /// `NULL` at the location pointed to by `sizes` and 0 at the location pointed
        /// to by `n_sizes`. The sizes returned are in Pango units and are sorted
        /// in ascending order.
        pub const list_sizes = struct {
            pub fn call(p_class: anytype, p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sizes: ?*[*]c_int, p_n_sizes: *c_int) void {
                return gobject.ext.as(FontFace.Class, p_class).f_list_sizes.?(gobject.ext.as(FontFace, p_face), p_sizes, p_n_sizes);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_face: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sizes: ?*[*]c_int, p_n_sizes: *c_int) callconv(.c) void) void {
                gobject.ext.as(FontFace.Class, p_class).f_list_sizes = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns a font description that matches the face.
    ///
    /// The resulting font description will have the family, style,
    /// variant, weight and stretch of the face, but its size field
    /// will be unset.
    extern fn pango_font_face_describe(p_face: *FontFace) *pango.FontDescription;
    pub const describe = pango_font_face_describe;

    /// Gets a name representing the style of this face.
    ///
    /// Note that a font family may contain multiple faces
    /// with the same name (e.g. a variable and a non-variable
    /// face for the same style).
    extern fn pango_font_face_get_face_name(p_face: *FontFace) [*:0]const u8;
    pub const getFaceName = pango_font_face_get_face_name;

    /// Gets the `PangoFontFamily` that `face` belongs to.
    extern fn pango_font_face_get_family(p_face: *FontFace) *pango.FontFamily;
    pub const getFamily = pango_font_face_get_family;

    /// Returns whether a `PangoFontFace` is synthesized.
    ///
    /// This will be the case if the underlying font rendering engine
    /// creates this face from another face, by shearing, emboldening,
    /// lightening or modifying it in some other way.
    extern fn pango_font_face_is_synthesized(p_face: *FontFace) c_int;
    pub const isSynthesized = pango_font_face_is_synthesized;

    /// List the available sizes for a font.
    ///
    /// This is only applicable to bitmap fonts. For scalable fonts, stores
    /// `NULL` at the location pointed to by `sizes` and 0 at the location pointed
    /// to by `n_sizes`. The sizes returned are in Pango units and are sorted
    /// in ascending order.
    extern fn pango_font_face_list_sizes(p_face: *FontFace, p_sizes: ?*[*]c_int, p_n_sizes: *c_int) void;
    pub const listSizes = pango_font_face_list_sizes;

    extern fn pango_font_face_get_type() usize;
    pub const getGObjectType = pango_font_face_get_type;

    extern fn g_object_ref(p_self: *pango.FontFace) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.FontFace) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontFace, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontFamily` is used to represent a family of related
/// font faces.
///
/// The font faces in a family share a common design, but differ in
/// slant, weight, width or other aspects.
pub const FontFamily = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = pango.FontFamilyClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Gets the `PangoFontFace` of `family` with the given name.
        pub const get_face = struct {
            pub fn call(p_class: anytype, p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: ?[*:0]const u8) ?*pango.FontFace {
                return gobject.ext.as(FontFamily.Class, p_class).f_get_face.?(gobject.ext.as(FontFamily, p_family), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: ?[*:0]const u8) callconv(.c) ?*pango.FontFace) void {
                gobject.ext.as(FontFamily.Class, p_class).f_get_face = @ptrCast(p_implementation);
            }
        };

        /// Gets the name of the family.
        ///
        /// The name is unique among all fonts for the font backend and can
        /// be used in a `PangoFontDescription` to specify that a face from
        /// this family is desired.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(FontFamily.Class, p_class).f_get_name.?(gobject.ext.as(FontFamily, p_family));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(FontFamily.Class, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// A monospace font is a font designed for text display where the the
        /// characters form a regular grid.
        ///
        /// For Western languages this would
        /// mean that the advance width of all characters are the same, but
        /// this categorization also includes Asian fonts which include
        /// double-width characters: characters that occupy two grid cells.
        /// `glib.unicharIswide` returns a result that indicates whether a
        /// character is typically double-width in a monospace font.
        ///
        /// The best way to find out the grid-cell size is to call
        /// `pango.FontMetrics.getApproximateDigitWidth`, since the
        /// results of `pango.FontMetrics.getApproximateCharWidth` may
        /// be affected by double-width characters.
        pub const is_monospace = struct {
            pub fn call(p_class: anytype, p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FontFamily.Class, p_class).f_is_monospace.?(gobject.ext.as(FontFamily, p_family));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FontFamily.Class, p_class).f_is_monospace = @ptrCast(p_implementation);
            }
        };

        /// A variable font is a font which has axes that can be modified to
        /// produce different faces.
        ///
        /// Such axes are also known as _variations_; see
        /// `pango.FontDescription.setVariations` for more information.
        pub const is_variable = struct {
            pub fn call(p_class: anytype, p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(FontFamily.Class, p_class).f_is_variable.?(gobject.ext.as(FontFamily, p_family));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(FontFamily.Class, p_class).f_is_variable = @ptrCast(p_implementation);
            }
        };

        /// Lists the different font faces that make up `family`.
        ///
        /// The faces in a family share a common design, but differ in slant, weight,
        /// width and other aspects.
        ///
        /// Note that the returned faces are not in any particular order, and
        /// multiple faces may have the same name or characteristics.
        ///
        /// `PangoFontFamily` also implemented the `gio.ListModel` interface
        /// for enumerating faces.
        pub const list_faces = struct {
            pub fn call(p_class: anytype, p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_faces: ?*[*]*pango.FontFace, p_n_faces: *c_int) void {
                return gobject.ext.as(FontFamily.Class, p_class).f_list_faces.?(gobject.ext.as(FontFamily, p_family), p_faces, p_n_faces);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_family: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_faces: ?*[*]*pango.FontFace, p_n_faces: *c_int) callconv(.c) void) void {
                gobject.ext.as(FontFamily.Class, p_class).f_list_faces = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Is this a monospace font
        pub const is_monospace = struct {
            pub const name = "is-monospace";

            pub const Type = c_int;
        };

        /// Is this a variable font
        pub const is_variable = struct {
            pub const name = "is-variable";

            pub const Type = c_int;
        };

        /// The type of items contained in this list.
        pub const item_type = struct {
            pub const name = "item-type";

            pub const Type = usize;
        };

        /// The number of items contained in this list.
        pub const n_items = struct {
            pub const name = "n-items";

            pub const Type = c_uint;
        };

        /// The name of the family
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Gets the `PangoFontFace` of `family` with the given name.
    extern fn pango_font_family_get_face(p_family: *FontFamily, p_name: ?[*:0]const u8) ?*pango.FontFace;
    pub const getFace = pango_font_family_get_face;

    /// Gets the name of the family.
    ///
    /// The name is unique among all fonts for the font backend and can
    /// be used in a `PangoFontDescription` to specify that a face from
    /// this family is desired.
    extern fn pango_font_family_get_name(p_family: *FontFamily) [*:0]const u8;
    pub const getName = pango_font_family_get_name;

    /// A monospace font is a font designed for text display where the the
    /// characters form a regular grid.
    ///
    /// For Western languages this would
    /// mean that the advance width of all characters are the same, but
    /// this categorization also includes Asian fonts which include
    /// double-width characters: characters that occupy two grid cells.
    /// `glib.unicharIswide` returns a result that indicates whether a
    /// character is typically double-width in a monospace font.
    ///
    /// The best way to find out the grid-cell size is to call
    /// `pango.FontMetrics.getApproximateDigitWidth`, since the
    /// results of `pango.FontMetrics.getApproximateCharWidth` may
    /// be affected by double-width characters.
    extern fn pango_font_family_is_monospace(p_family: *FontFamily) c_int;
    pub const isMonospace = pango_font_family_is_monospace;

    /// A variable font is a font which has axes that can be modified to
    /// produce different faces.
    ///
    /// Such axes are also known as _variations_; see
    /// `pango.FontDescription.setVariations` for more information.
    extern fn pango_font_family_is_variable(p_family: *FontFamily) c_int;
    pub const isVariable = pango_font_family_is_variable;

    /// Lists the different font faces that make up `family`.
    ///
    /// The faces in a family share a common design, but differ in slant, weight,
    /// width and other aspects.
    ///
    /// Note that the returned faces are not in any particular order, and
    /// multiple faces may have the same name or characteristics.
    ///
    /// `PangoFontFamily` also implemented the `gio.ListModel` interface
    /// for enumerating faces.
    extern fn pango_font_family_list_faces(p_family: *FontFamily, p_faces: ?*[*]*pango.FontFace, p_n_faces: *c_int) void;
    pub const listFaces = pango_font_family_list_faces;

    extern fn pango_font_family_get_type() usize;
    pub const getGObjectType = pango_font_family_get_type;

    extern fn g_object_ref(p_self: *pango.FontFamily) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.FontFamily) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontFamily, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontMap` represents the set of fonts available for a
/// particular rendering system.
///
/// This is a virtual object with implementations being specific to
/// particular rendering systems.
pub const FontMap = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = pango.FontMapClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Forces a change in the context, which will cause any `PangoContext`
        /// using this fontmap to change.
        ///
        /// This function is only useful when implementing a new backend
        /// for Pango, something applications won't do. Backends should
        /// call this function if they have attached extra data to the
        /// context and such data is changed.
        pub const changed = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(FontMap.Class, p_class).f_changed.?(gobject.ext.as(FontMap, p_fontmap));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(FontMap.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        pub const get_face = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font) *pango.FontFace {
                return gobject.ext.as(FontMap.Class, p_class).f_get_face.?(gobject.ext.as(FontMap, p_fontmap), p_font);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font) callconv(.c) *pango.FontFace) void {
                gobject.ext.as(FontMap.Class, p_class).f_get_face = @ptrCast(p_implementation);
            }
        };

        /// Gets a font family by name.
        pub const get_family = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) *pango.FontFamily {
                return gobject.ext.as(FontMap.Class, p_class).f_get_family.?(gobject.ext.as(FontMap, p_fontmap), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) *pango.FontFamily) void {
                gobject.ext.as(FontMap.Class, p_class).f_get_family = @ptrCast(p_implementation);
            }
        };

        /// Returns the current serial number of `fontmap`.
        ///
        /// The serial number is initialized to an small number larger than zero
        /// when a new fontmap is created and is increased whenever the fontmap
        /// is changed. It may wrap, but will never have the value 0. Since it can
        /// wrap, never compare it with "less than", always use "not equals".
        ///
        /// The fontmap can only be changed using backend-specific API, like changing
        /// fontmap resolution.
        ///
        /// This can be used to automatically detect changes to a `PangoFontMap`,
        /// like in `PangoContext`.
        pub const get_serial = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_uint {
                return gobject.ext.as(FontMap.Class, p_class).f_get_serial.?(gobject.ext.as(FontMap, p_fontmap));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_uint) void {
                gobject.ext.as(FontMap.Class, p_class).f_get_serial = @ptrCast(p_implementation);
            }
        };

        /// List all families for a fontmap.
        ///
        /// Note that the returned families are not in any particular order.
        ///
        /// `PangoFontMap` also implemented the `gio.ListModel` interface
        /// for enumerating families.
        pub const list_families = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_families: *[*]*pango.FontFamily, p_n_families: *c_int) void {
                return gobject.ext.as(FontMap.Class, p_class).f_list_families.?(gobject.ext.as(FontMap, p_fontmap), p_families, p_n_families);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_families: *[*]*pango.FontFamily, p_n_families: *c_int) callconv(.c) void) void {
                gobject.ext.as(FontMap.Class, p_class).f_list_families = @ptrCast(p_implementation);
            }
        };

        /// Load the font in the fontmap that is the closest match for `desc`.
        pub const load_font = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_context: *pango.Context, p_desc: *const pango.FontDescription) ?*pango.Font {
                return gobject.ext.as(FontMap.Class, p_class).f_load_font.?(gobject.ext.as(FontMap, p_fontmap), p_context, p_desc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_context: *pango.Context, p_desc: *const pango.FontDescription) callconv(.c) ?*pango.Font) void {
                gobject.ext.as(FontMap.Class, p_class).f_load_font = @ptrCast(p_implementation);
            }
        };

        /// Load a set of fonts in the fontmap that can be used to render
        /// a font matching `desc`.
        pub const load_fontset = struct {
            pub fn call(p_class: anytype, p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_context: *pango.Context, p_desc: *const pango.FontDescription, p_language: *pango.Language) ?*pango.Fontset {
                return gobject.ext.as(FontMap.Class, p_class).f_load_fontset.?(gobject.ext.as(FontMap, p_fontmap), p_context, p_desc, p_language);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontmap: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_context: *pango.Context, p_desc: *const pango.FontDescription, p_language: *pango.Language) callconv(.c) ?*pango.Fontset) void {
                gobject.ext.as(FontMap.Class, p_class).f_load_fontset = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The type of items contained in this list.
        pub const item_type = struct {
            pub const name = "item-type";

            pub const Type = usize;
        };

        /// The number of items contained in this list.
        pub const n_items = struct {
            pub const name = "n-items";

            pub const Type = c_uint;
        };
    };

    pub const signals = struct {};

    /// Loads a font file with one or more fonts into the `PangoFontMap`.
    ///
    /// The added fonts will take precedence over preexisting
    /// fonts with the same name.
    extern fn pango_font_map_add_font_file(p_fontmap: *FontMap, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const addFontFile = pango_font_map_add_font_file;

    /// Forces a change in the context, which will cause any `PangoContext`
    /// using this fontmap to change.
    ///
    /// This function is only useful when implementing a new backend
    /// for Pango, something applications won't do. Backends should
    /// call this function if they have attached extra data to the
    /// context and such data is changed.
    extern fn pango_font_map_changed(p_fontmap: *FontMap) void;
    pub const changed = pango_font_map_changed;

    /// Creates a `PangoContext` connected to `fontmap`.
    ///
    /// This is equivalent to `pango.Context.new` followed by
    /// `pango.Context.setFontMap`.
    ///
    /// If you are using Pango as part of a higher-level system,
    /// that system may have it's own way of create a `PangoContext`.
    /// For instance, the GTK toolkit has, among others,
    /// `gtk_widget_get_pango_context`. Use those instead.
    extern fn pango_font_map_create_context(p_fontmap: *FontMap) *pango.Context;
    pub const createContext = pango_font_map_create_context;

    /// Gets a font family by name.
    extern fn pango_font_map_get_family(p_fontmap: *FontMap, p_name: [*:0]const u8) *pango.FontFamily;
    pub const getFamily = pango_font_map_get_family;

    /// Returns the current serial number of `fontmap`.
    ///
    /// The serial number is initialized to an small number larger than zero
    /// when a new fontmap is created and is increased whenever the fontmap
    /// is changed. It may wrap, but will never have the value 0. Since it can
    /// wrap, never compare it with "less than", always use "not equals".
    ///
    /// The fontmap can only be changed using backend-specific API, like changing
    /// fontmap resolution.
    ///
    /// This can be used to automatically detect changes to a `PangoFontMap`,
    /// like in `PangoContext`.
    extern fn pango_font_map_get_serial(p_fontmap: *FontMap) c_uint;
    pub const getSerial = pango_font_map_get_serial;

    /// List all families for a fontmap.
    ///
    /// Note that the returned families are not in any particular order.
    ///
    /// `PangoFontMap` also implemented the `gio.ListModel` interface
    /// for enumerating families.
    extern fn pango_font_map_list_families(p_fontmap: *FontMap, p_families: *[*]*pango.FontFamily, p_n_families: *c_int) void;
    pub const listFamilies = pango_font_map_list_families;

    /// Load the font in the fontmap that is the closest match for `desc`.
    extern fn pango_font_map_load_font(p_fontmap: *FontMap, p_context: *pango.Context, p_desc: *const pango.FontDescription) ?*pango.Font;
    pub const loadFont = pango_font_map_load_font;

    /// Load a set of fonts in the fontmap that can be used to render
    /// a font matching `desc`.
    extern fn pango_font_map_load_fontset(p_fontmap: *FontMap, p_context: *pango.Context, p_desc: *const pango.FontDescription, p_language: *pango.Language) ?*pango.Fontset;
    pub const loadFontset = pango_font_map_load_fontset;

    /// Returns a new font that is like `font`, except that it is scaled
    /// by `scale`, its backend-dependent configuration (e.g. cairo font options)
    /// is replaced by the one in `context`, and its variations are replaced
    /// by `variations`.
    ///
    /// Note that the scaling here is meant to be linear, so this
    /// scaling can be used to render a font on a hi-dpi display
    /// without changing its optical size.
    extern fn pango_font_map_reload_font(p_fontmap: *FontMap, p_font: *pango.Font, p_scale: f64, p_context: ?*pango.Context, p_variations: ?[*:0]const u8) *pango.Font;
    pub const reloadFont = pango_font_map_reload_font;

    extern fn pango_font_map_get_type() usize;
    pub const getGObjectType = pango_font_map_get_type;

    extern fn g_object_ref(p_self: *pango.FontMap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.FontMap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontMap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontset` represents a set of `PangoFont` to use when rendering text.
///
/// A `PangoFontset` is the result of resolving a `PangoFontDescription`
/// against a particular `PangoContext`. It has operations for finding the
/// component font for a particular Unicode character, and for finding a
/// composite set of metrics for the entire fontset.
pub const Fontset = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.FontsetClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Iterates through all the fonts in a fontset, calling `func` for
        /// each one.
        ///
        /// If `func` returns `TRUE`, that stops the iteration.
        pub const foreach = struct {
            pub fn call(p_class: anytype, p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: pango.FontsetForeachFunc, p_data: ?*anyopaque) void {
                return gobject.ext.as(Fontset.Class, p_class).f_foreach.?(gobject.ext.as(Fontset, p_fontset), p_func, p_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_func: pango.FontsetForeachFunc, p_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Fontset.Class, p_class).f_foreach = @ptrCast(p_implementation);
            }
        };

        /// Returns the font in the fontset that contains the best
        /// glyph for a Unicode character.
        pub const get_font = struct {
            pub fn call(p_class: anytype, p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_wc: c_uint) *pango.Font {
                return gobject.ext.as(Fontset.Class, p_class).f_get_font.?(gobject.ext.as(Fontset, p_fontset), p_wc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_wc: c_uint) callconv(.c) *pango.Font) void {
                gobject.ext.as(Fontset.Class, p_class).f_get_font = @ptrCast(p_implementation);
            }
        };

        /// a function to get the language of the fontset.
        pub const get_language = struct {
            pub fn call(p_class: anytype, p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.Language {
                return gobject.ext.as(Fontset.Class, p_class).f_get_language.?(gobject.ext.as(Fontset, p_fontset));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.Language) void {
                gobject.ext.as(Fontset.Class, p_class).f_get_language = @ptrCast(p_implementation);
            }
        };

        /// Get overall metric information for the fonts in the fontset.
        pub const get_metrics = struct {
            pub fn call(p_class: anytype, p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *pango.FontMetrics {
                return gobject.ext.as(Fontset.Class, p_class).f_get_metrics.?(gobject.ext.as(Fontset, p_fontset));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_fontset: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *pango.FontMetrics) void {
                gobject.ext.as(Fontset.Class, p_class).f_get_metrics = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Iterates through all the fonts in a fontset, calling `func` for
    /// each one.
    ///
    /// If `func` returns `TRUE`, that stops the iteration.
    extern fn pango_fontset_foreach(p_fontset: *Fontset, p_func: pango.FontsetForeachFunc, p_data: ?*anyopaque) void;
    pub const foreach = pango_fontset_foreach;

    /// Returns the font in the fontset that contains the best
    /// glyph for a Unicode character.
    extern fn pango_fontset_get_font(p_fontset: *Fontset, p_wc: c_uint) *pango.Font;
    pub const getFont = pango_fontset_get_font;

    /// Get overall metric information for the fonts in the fontset.
    extern fn pango_fontset_get_metrics(p_fontset: *Fontset) *pango.FontMetrics;
    pub const getMetrics = pango_fontset_get_metrics;

    extern fn pango_fontset_get_type() usize;
    pub const getGObjectType = pango_fontset_get_type;

    extern fn g_object_ref(p_self: *pango.Fontset) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.Fontset) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Fontset, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoFontsetSimple` is a implementation of the abstract
/// `PangoFontset` base class as an array of fonts.
///
/// When creating a `PangoFontsetSimple`, you have to provide
/// the array of fonts that make up the fontset.
pub const FontsetSimple = opaque {
    pub const Parent = pango.Fontset;
    pub const Implements = [_]type{};
    pub const Class = pango.FontsetSimpleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `PangoFontsetSimple` for the given language.
    extern fn pango_fontset_simple_new(p_language: *pango.Language) *pango.FontsetSimple;
    pub const new = pango_fontset_simple_new;

    /// Adds a font to the fontset.
    ///
    /// The fontset takes ownership of `font`.
    extern fn pango_fontset_simple_append(p_fontset: *FontsetSimple, p_font: *pango.Font) void;
    pub const append = pango_fontset_simple_append;

    /// Returns the number of fonts in the fontset.
    extern fn pango_fontset_simple_size(p_fontset: *FontsetSimple) c_int;
    pub const size = pango_fontset_simple_size;

    extern fn pango_fontset_simple_get_type() usize;
    pub const getGObjectType = pango_fontset_simple_get_type;

    extern fn g_object_ref(p_self: *pango.FontsetSimple) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.FontsetSimple) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontsetSimple, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoLayout` structure represents an entire paragraph of text.
///
/// While complete access to the layout capabilities of Pango is provided
/// using the detailed interfaces for itemization and shaping, using
/// that functionality directly involves writing a fairly large amount
/// of code. `PangoLayout` provides a high-level driver for formatting
/// entire paragraphs of text at once. This includes paragraph-level
/// functionality such as line breaking, justification, alignment and
/// ellipsization.
///
/// A `PangoLayout` is initialized with a `PangoContext`, UTF-8 string
/// and set of attributes for that string. Once that is done, the set of
/// formatted lines can be extracted from the object, the layout can be
/// rendered, and conversion between logical character positions within
/// the layout's text, and the physical position of the resulting glyphs
/// can be made.
///
/// There are a number of parameters to adjust the formatting of a
/// `PangoLayout`. The following image shows adjustable parameters
/// (on the left) and font metrics (on the right):
///
/// <picture>
///   <source srcset="layout-dark.png" media="(prefers-color-scheme: dark)">
///   <img alt="Pango Layout Parameters" src="layout-light.png">
/// </picture>
///
/// The following images demonstrate the effect of alignment and
/// justification on the layout of text:
///
/// | | |
/// | --- | --- |
/// | ![align=left](align-left.png) | ![align=left, justify](align-left-justify.png) |
/// | ![align=center](align-center.png) | ![align=center, justify](align-center-justify.png) |
/// | ![align=right](align-right.png) | ![align=right, justify](align-right-justify.png) |
///
///
/// It is possible, as well, to ignore the 2-D setup,
/// and simply treat the results of a `PangoLayout` as a list of lines.
pub const Layout = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.LayoutClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Loads data previously created via `pango.Layout.serialize`.
    ///
    /// For a discussion of the supported format, see that function.
    ///
    /// Note: to verify that the returned layout is identical to
    /// the one that was serialized, you can compare `bytes` to the
    /// result of serializing the layout again.
    extern fn pango_layout_deserialize(p_context: *pango.Context, p_bytes: *glib.Bytes, p_flags: pango.LayoutDeserializeFlags, p_error: ?*?*glib.Error) ?*pango.Layout;
    pub const deserialize = pango_layout_deserialize;

    /// Create a new `PangoLayout` object with attributes initialized to
    /// default values for a particular `PangoContext`.
    extern fn pango_layout_new(p_context: *pango.Context) *pango.Layout;
    pub const new = pango_layout_new;

    /// Forces recomputation of any state in the `PangoLayout` that
    /// might depend on the layout's context.
    ///
    /// This function should be called if you make changes to the context
    /// subsequent to creating the layout.
    extern fn pango_layout_context_changed(p_layout: *Layout) void;
    pub const contextChanged = pango_layout_context_changed;

    /// Creates a deep copy-by-value of the layout.
    ///
    /// The attribute list, tab array, and text from the original layout
    /// are all copied by value.
    extern fn pango_layout_copy(p_src: *Layout) *pango.Layout;
    pub const copy = pango_layout_copy;

    /// Gets the alignment for the layout: how partial lines are
    /// positioned within the horizontal space available.
    extern fn pango_layout_get_alignment(p_layout: *Layout) pango.Alignment;
    pub const getAlignment = pango_layout_get_alignment;

    /// Gets the attribute list for the layout, if any.
    extern fn pango_layout_get_attributes(p_layout: *Layout) ?*pango.AttrList;
    pub const getAttributes = pango_layout_get_attributes;

    /// Gets whether to calculate the base direction for the layout
    /// according to its contents.
    ///
    /// See `pango.Layout.setAutoDir`.
    extern fn pango_layout_get_auto_dir(p_layout: *Layout) c_int;
    pub const getAutoDir = pango_layout_get_auto_dir;

    /// Gets the Y position of baseline of the first line in `layout`.
    extern fn pango_layout_get_baseline(p_layout: *Layout) c_int;
    pub const getBaseline = pango_layout_get_baseline;

    /// Given an index within a layout, determines the positions that of the
    /// strong and weak cursors if the insertion point is at that index.
    ///
    /// This is a variant of `pango.Layout.getCursorPos` that applies
    /// font metric information about caret slope and offset to the positions
    /// it returns.
    ///
    /// <picture>
    ///   <source srcset="caret-metrics-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Caret metrics" src="caret-metrics-light.png">
    /// </picture>
    extern fn pango_layout_get_caret_pos(p_layout: *Layout, p_index_: c_int, p_strong_pos: ?*pango.Rectangle, p_weak_pos: ?*pango.Rectangle) void;
    pub const getCaretPos = pango_layout_get_caret_pos;

    /// Returns the number of Unicode characters in the
    /// the text of `layout`.
    extern fn pango_layout_get_character_count(p_layout: *Layout) c_int;
    pub const getCharacterCount = pango_layout_get_character_count;

    /// Retrieves the `PangoContext` used for this layout.
    extern fn pango_layout_get_context(p_layout: *Layout) *pango.Context;
    pub const getContext = pango_layout_get_context;

    /// Given an index within a layout, determines the positions that of the
    /// strong and weak cursors if the insertion point is at that index.
    ///
    /// The position of each cursor is stored as a zero-width rectangle
    /// with the height of the run extents.
    ///
    /// <picture>
    ///   <source srcset="cursor-positions-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Cursor positions" src="cursor-positions-light.png">
    /// </picture>
    ///
    /// The strong cursor location is the location where characters of the
    /// directionality equal to the base direction of the layout are inserted.
    /// The weak cursor location is the location where characters of the
    /// directionality opposite to the base direction of the layout are inserted.
    ///
    /// The following example shows text with both a strong and a weak cursor.
    ///
    /// <picture>
    ///   <source srcset="split-cursor-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Strong and weak cursors" src="split-cursor-light.png">
    /// </picture>
    ///
    /// The strong cursor has a little arrow pointing to the right, the weak
    /// cursor to the left. Typing a 'c' in this situation will insert the
    /// character after the 'b', and typing another Hebrew character, like 'ג',
    /// will insert it at the end.
    extern fn pango_layout_get_cursor_pos(p_layout: *Layout, p_index_: c_int, p_strong_pos: ?*pango.Rectangle, p_weak_pos: ?*pango.Rectangle) void;
    pub const getCursorPos = pango_layout_get_cursor_pos;

    /// Gets the text direction at the given character position in `layout`.
    extern fn pango_layout_get_direction(p_layout: *Layout, p_index: c_int) pango.Direction;
    pub const getDirection = pango_layout_get_direction;

    /// Gets the type of ellipsization being performed for `layout`.
    ///
    /// See `pango.Layout.setEllipsize`.
    ///
    /// Use `pango.Layout.isEllipsized` to query whether any
    /// paragraphs were actually ellipsized.
    extern fn pango_layout_get_ellipsize(p_layout: *Layout) pango.EllipsizeMode;
    pub const getEllipsize = pango_layout_get_ellipsize;

    /// Computes the logical and ink extents of `layout`.
    ///
    /// Logical extents are usually what you want for positioning things. Note
    /// that both extents may have non-zero x and y. You may want to use those
    /// to offset where you render the layout. Not doing that is a very typical
    /// bug that shows up as right-to-left layouts not being correctly positioned
    /// in a layout with a set width.
    ///
    /// The extents are given in layout coordinates and in Pango units; layout
    /// coordinates begin at the top left corner of the layout.
    extern fn pango_layout_get_extents(p_layout: *Layout, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getExtents = pango_layout_get_extents;

    /// Gets the font description for the layout, if any.
    extern fn pango_layout_get_font_description(p_layout: *Layout) ?*const pango.FontDescription;
    pub const getFontDescription = pango_layout_get_font_description;

    /// Gets the height of layout used for ellipsization.
    ///
    /// See `pango.Layout.setHeight` for details.
    extern fn pango_layout_get_height(p_layout: *Layout) c_int;
    pub const getHeight = pango_layout_get_height;

    /// Gets the paragraph indent width in Pango units.
    ///
    /// A negative value indicates a hanging indentation.
    extern fn pango_layout_get_indent(p_layout: *Layout) c_int;
    pub const getIndent = pango_layout_get_indent;

    /// Returns an iterator to iterate over the visual extents of the layout.
    extern fn pango_layout_get_iter(p_layout: *Layout) *pango.LayoutIter;
    pub const getIter = pango_layout_get_iter;

    /// Gets whether each complete line should be stretched to fill the entire
    /// width of the layout.
    extern fn pango_layout_get_justify(p_layout: *Layout) c_int;
    pub const getJustify = pango_layout_get_justify;

    /// Gets whether the last line should be stretched
    /// to fill the entire width of the layout.
    extern fn pango_layout_get_justify_last_line(p_layout: *Layout) c_int;
    pub const getJustifyLastLine = pango_layout_get_justify_last_line;

    /// Retrieves a particular line from a `PangoLayout`.
    ///
    /// Use the faster `pango.Layout.getLineReadonly` if you do not
    /// plan to modify the contents of the line (glyphs, glyph widths, etc.).
    extern fn pango_layout_get_line(p_layout: *Layout, p_line: c_int) ?*pango.LayoutLine;
    pub const getLine = pango_layout_get_line;

    /// Retrieves the count of lines for the `layout`.
    extern fn pango_layout_get_line_count(p_layout: *Layout) c_int;
    pub const getLineCount = pango_layout_get_line_count;

    /// Retrieves a particular line from a `PangoLayout`.
    ///
    /// This is a faster alternative to `pango.Layout.getLine`,
    /// but the user is not expected to modify the contents of the line
    /// (glyphs, glyph widths, etc.).
    extern fn pango_layout_get_line_readonly(p_layout: *Layout, p_line: c_int) ?*pango.LayoutLine;
    pub const getLineReadonly = pango_layout_get_line_readonly;

    /// Gets the line spacing factor of `layout`.
    ///
    /// See `pango.Layout.setLineSpacing`.
    extern fn pango_layout_get_line_spacing(p_layout: *Layout) f32;
    pub const getLineSpacing = pango_layout_get_line_spacing;

    /// Returns the lines of the `layout` as a list.
    ///
    /// Use the faster `pango.Layout.getLinesReadonly` if you do not
    /// plan to modify the contents of the lines (glyphs, glyph widths, etc.).
    extern fn pango_layout_get_lines(p_layout: *Layout) *glib.SList;
    pub const getLines = pango_layout_get_lines;

    /// Returns the lines of the `layout` as a list.
    ///
    /// This is a faster alternative to `pango.Layout.getLines`,
    /// but the user is not expected to modify the contents of the lines
    /// (glyphs, glyph widths, etc.).
    extern fn pango_layout_get_lines_readonly(p_layout: *Layout) *glib.SList;
    pub const getLinesReadonly = pango_layout_get_lines_readonly;

    /// Retrieves an array of logical attributes for each character in
    /// the `layout`.
    extern fn pango_layout_get_log_attrs(p_layout: *Layout, p_attrs: *[*]pango.LogAttr, p_n_attrs: *c_int) void;
    pub const getLogAttrs = pango_layout_get_log_attrs;

    /// Retrieves an array of logical attributes for each character in
    /// the `layout`.
    ///
    /// This is a faster alternative to `pango.Layout.getLogAttrs`.
    /// The returned array is part of `layout` and must not be modified.
    /// Modifying the layout will invalidate the returned array.
    ///
    /// The number of attributes returned in `n_attrs` will be one more
    /// than the total number of characters in the layout, since there
    /// need to be attributes corresponding to both the position before
    /// the first character and the position after the last character.
    extern fn pango_layout_get_log_attrs_readonly(p_layout: *Layout, p_n_attrs: *c_int) [*]const pango.LogAttr;
    pub const getLogAttrsReadonly = pango_layout_get_log_attrs_readonly;

    /// Computes the logical and ink extents of `layout` in device units.
    ///
    /// This function just calls `pango.Layout.getExtents` followed by
    /// two `extentsToPixels` calls, rounding `ink_rect` and `logical_rect`
    /// such that the rounded rectangles fully contain the unrounded one (that is,
    /// passes them as first argument to `pango.extentsToPixels`).
    extern fn pango_layout_get_pixel_extents(p_layout: *Layout, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getPixelExtents = pango_layout_get_pixel_extents;

    /// Determines the logical width and height of a `PangoLayout` in device
    /// units.
    ///
    /// `pango.Layout.getSize` returns the width and height
    /// scaled by `PANGO_SCALE`. This is simply a convenience function
    /// around `pango.Layout.getPixelExtents`.
    extern fn pango_layout_get_pixel_size(p_layout: *Layout, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getPixelSize = pango_layout_get_pixel_size;

    /// Returns the current serial number of `layout`.
    ///
    /// The serial number is initialized to an small number larger than zero
    /// when a new layout is created and is increased whenever the layout is
    /// changed using any of the setter functions, or the `PangoContext` it
    /// uses has changed. The serial may wrap, but will never have the value 0.
    /// Since it can wrap, never compare it with "less than", always use "not equals".
    ///
    /// This can be used to automatically detect changes to a `PangoLayout`,
    /// and is useful for example to decide whether a layout needs redrawing.
    /// To force the serial to be increased, use
    /// `pango.Layout.contextChanged`.
    extern fn pango_layout_get_serial(p_layout: *Layout) c_uint;
    pub const getSerial = pango_layout_get_serial;

    /// Obtains whether `layout` is in single paragraph mode.
    ///
    /// See `pango.Layout.setSingleParagraphMode`.
    extern fn pango_layout_get_single_paragraph_mode(p_layout: *Layout) c_int;
    pub const getSingleParagraphMode = pango_layout_get_single_paragraph_mode;

    /// Determines the logical width and height of a `PangoLayout` in Pango
    /// units.
    ///
    /// This is simply a convenience function around `pango.Layout.getExtents`.
    extern fn pango_layout_get_size(p_layout: *Layout, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getSize = pango_layout_get_size;

    /// Gets the amount of spacing between the lines of the layout.
    extern fn pango_layout_get_spacing(p_layout: *Layout) c_int;
    pub const getSpacing = pango_layout_get_spacing;

    /// Gets the current `PangoTabArray` used by this layout.
    ///
    /// If no `PangoTabArray` has been set, then the default tabs are
    /// in use and `NULL` is returned. Default tabs are every 8 spaces.
    ///
    /// The return value should be freed with `pango.TabArray.free`.
    extern fn pango_layout_get_tabs(p_layout: *Layout) ?*pango.TabArray;
    pub const getTabs = pango_layout_get_tabs;

    /// Gets the text in the layout.
    ///
    /// The returned text should not be freed or modified.
    extern fn pango_layout_get_text(p_layout: *Layout) [*:0]const u8;
    pub const getText = pango_layout_get_text;

    /// Counts the number of unknown glyphs in `layout`.
    ///
    /// This function can be used to determine if there are any fonts
    /// available to render all characters in a certain string, or when
    /// used in combination with `PANGO_ATTR_FALLBACK`, to check if a
    /// certain font supports all the characters in the string.
    extern fn pango_layout_get_unknown_glyphs_count(p_layout: *Layout) c_int;
    pub const getUnknownGlyphsCount = pango_layout_get_unknown_glyphs_count;

    /// Gets the width to which the lines of the `PangoLayout` should wrap.
    extern fn pango_layout_get_width(p_layout: *Layout) c_int;
    pub const getWidth = pango_layout_get_width;

    /// Gets the wrap mode for the layout.
    ///
    /// Use `pango.Layout.isWrapped` to query whether
    /// any paragraphs were actually wrapped.
    extern fn pango_layout_get_wrap(p_layout: *Layout) pango.WrapMode;
    pub const getWrap = pango_layout_get_wrap;

    /// Converts from byte `index_` within the `layout` to line and X position.
    ///
    /// The X position is measured from the left edge of the line.
    extern fn pango_layout_index_to_line_x(p_layout: *Layout, p_index_: c_int, p_trailing: c_int, p_line: ?*c_int, p_x_pos: ?*c_int) void;
    pub const indexToLineX = pango_layout_index_to_line_x;

    /// Converts from an index within a `PangoLayout` to the onscreen position
    /// corresponding to the grapheme at that index.
    ///
    /// The returns is represented as rectangle. Note that `pos->x` is
    /// always the leading edge of the grapheme and `pos->x + pos->width` the
    /// trailing edge of the grapheme. If the directionality of the grapheme
    /// is right-to-left, then `pos->width` will be negative.
    extern fn pango_layout_index_to_pos(p_layout: *Layout, p_index_: c_int, p_pos: *pango.Rectangle) void;
    pub const indexToPos = pango_layout_index_to_pos;

    /// Queries whether the layout had to ellipsize any paragraphs.
    ///
    /// This returns `TRUE` if the ellipsization mode for `layout`
    /// is not `PANGO_ELLIPSIZE_NONE`, a positive width is set on `layout`,
    /// and there are paragraphs exceeding that width that have to be
    /// ellipsized.
    extern fn pango_layout_is_ellipsized(p_layout: *Layout) c_int;
    pub const isEllipsized = pango_layout_is_ellipsized;

    /// Queries whether the layout had to wrap any paragraphs.
    ///
    /// This returns `TRUE` if a positive width is set on `layout`,
    /// and there are paragraphs exceeding the layout width that have
    /// to be wrapped.
    extern fn pango_layout_is_wrapped(p_layout: *Layout) c_int;
    pub const isWrapped = pango_layout_is_wrapped;

    /// Computes a new cursor position from an old position and a direction.
    ///
    /// If `direction` is positive, then the new position will cause the strong
    /// or weak cursor to be displayed one position to right of where it was
    /// with the old cursor position. If `direction` is negative, it will be
    /// moved to the left.
    ///
    /// In the presence of bidirectional text, the correspondence between
    /// logical and visual order will depend on the direction of the current
    /// run, and there may be jumps when the cursor is moved off of the end
    /// of a run.
    ///
    /// Motion here is in cursor positions, not in characters, so a single
    /// call to this function may move the cursor over multiple characters
    /// when multiple characters combine to form a single grapheme.
    extern fn pango_layout_move_cursor_visually(p_layout: *Layout, p_strong: c_int, p_old_index: c_int, p_old_trailing: c_int, p_direction: c_int, p_new_index: *c_int, p_new_trailing: *c_int) void;
    pub const moveCursorVisually = pango_layout_move_cursor_visually;

    /// Serializes the `layout` for later deserialization via `pango.Layout.deserialize`.
    ///
    /// There are no guarantees about the format of the output across different
    /// versions of Pango and `pango.Layout.deserialize` will reject data
    /// that it cannot parse.
    ///
    /// The intended use of this function is testing, benchmarking and debugging.
    /// The format is not meant as a permanent storage format.
    extern fn pango_layout_serialize(p_layout: *Layout, p_flags: pango.LayoutSerializeFlags) *glib.Bytes;
    pub const serialize = pango_layout_serialize;

    /// Sets the alignment for the layout: how partial lines are
    /// positioned within the horizontal space available.
    ///
    /// The default alignment is `PANGO_ALIGN_LEFT`.
    extern fn pango_layout_set_alignment(p_layout: *Layout, p_alignment: pango.Alignment) void;
    pub const setAlignment = pango_layout_set_alignment;

    /// Sets the text attributes for a layout object.
    ///
    /// References `attrs`, so the caller can unref its reference.
    extern fn pango_layout_set_attributes(p_layout: *Layout, p_attrs: ?*pango.AttrList) void;
    pub const setAttributes = pango_layout_set_attributes;

    /// Sets whether to calculate the base direction
    /// for the layout according to its contents.
    ///
    /// When this flag is on (the default), then paragraphs in `layout` that
    /// begin with strong right-to-left characters (Arabic and Hebrew principally),
    /// will have right-to-left layout, paragraphs with letters from other scripts
    /// will have left-to-right layout. Paragraphs with only neutral characters
    /// get their direction from the surrounding paragraphs.
    ///
    /// When `FALSE`, the choice between left-to-right and right-to-left
    /// layout is done according to the base direction of the layout's
    /// `PangoContext`. (See `pango.Context.setBaseDir`).
    ///
    /// When the auto-computed direction of a paragraph differs from the
    /// base direction of the context, the interpretation of
    /// `PANGO_ALIGN_LEFT` and `PANGO_ALIGN_RIGHT` are swapped.
    extern fn pango_layout_set_auto_dir(p_layout: *Layout, p_auto_dir: c_int) void;
    pub const setAutoDir = pango_layout_set_auto_dir;

    /// Sets the type of ellipsization being performed for `layout`.
    ///
    /// Depending on the ellipsization mode `ellipsize` text is
    /// removed from the start, middle, or end of text so they
    /// fit within the width and height of layout set with
    /// `pango.Layout.setWidth` and `pango.Layout.setHeight`.
    ///
    /// If the layout contains characters such as newlines that
    /// force it to be layed out in multiple paragraphs, then whether
    /// each paragraph is ellipsized separately or the entire layout
    /// is ellipsized as a whole depends on the set height of the layout.
    ///
    /// The default value is `PANGO_ELLIPSIZE_NONE`.
    ///
    /// See `pango.Layout.setHeight` for details.
    extern fn pango_layout_set_ellipsize(p_layout: *Layout, p_ellipsize: pango.EllipsizeMode) void;
    pub const setEllipsize = pango_layout_set_ellipsize;

    /// Sets the default font description for the layout.
    ///
    /// If no font description is set on the layout, the
    /// font description from the layout's context is used.
    extern fn pango_layout_set_font_description(p_layout: *Layout, p_desc: ?*const pango.FontDescription) void;
    pub const setFontDescription = pango_layout_set_font_description;

    /// Sets the height to which the `PangoLayout` should be ellipsized at.
    ///
    /// There are two different behaviors, based on whether `height` is positive
    /// or negative.
    ///
    /// If `height` is positive, it will be the maximum height of the layout. Only
    /// lines would be shown that would fit, and if there is any text omitted,
    /// an ellipsis added. At least one line is included in each paragraph regardless
    /// of how small the height value is. A value of zero will render exactly one
    /// line for the entire layout.
    ///
    /// If `height` is negative, it will be the (negative of) maximum number of lines
    /// per paragraph. That is, the total number of lines shown may well be more than
    /// this value if the layout contains multiple paragraphs of text.
    /// The default value of -1 means that the first line of each paragraph is ellipsized.
    /// This behavior may be changed in the future to act per layout instead of per
    /// paragraph. File a bug against pango at
    /// [https://gitlab.gnome.org/gnome/pango](https://gitlab.gnome.org/gnome/pango)
    /// if your code relies on this behavior.
    ///
    /// Height setting only has effect if a positive width is set on
    /// `layout` and ellipsization mode of `layout` is not `PANGO_ELLIPSIZE_NONE`.
    /// The behavior is undefined if a height other than -1 is set and
    /// ellipsization mode is set to `PANGO_ELLIPSIZE_NONE`, and may change in the
    /// future.
    extern fn pango_layout_set_height(p_layout: *Layout, p_height: c_int) void;
    pub const setHeight = pango_layout_set_height;

    /// Sets the width in Pango units to indent each paragraph.
    ///
    /// A negative value of `indent` will produce a hanging indentation.
    /// That is, the first line will have the full width, and subsequent
    /// lines will be indented by the absolute value of `indent`.
    ///
    /// The indent setting is ignored if layout alignment is set to
    /// `PANGO_ALIGN_CENTER`.
    ///
    /// The default value is 0.
    extern fn pango_layout_set_indent(p_layout: *Layout, p_indent: c_int) void;
    pub const setIndent = pango_layout_set_indent;

    /// Sets whether each complete line should be stretched to fill the
    /// entire width of the layout.
    ///
    /// Stretching is typically done by adding whitespace, but for some scripts
    /// (such as Arabic), the justification may be done in more complex ways,
    /// like extending the characters.
    ///
    /// Note that this setting is not implemented and so is ignored in
    /// Pango older than 1.18.
    ///
    /// Note that tabs and justification conflict with each other:
    /// Justification will move content away from its tab-aligned
    /// positions.
    ///
    /// The default value is `FALSE`.
    ///
    /// Also see `pango.Layout.setJustifyLastLine`.
    extern fn pango_layout_set_justify(p_layout: *Layout, p_justify: c_int) void;
    pub const setJustify = pango_layout_set_justify;

    /// Sets whether the last line should be stretched to fill the
    /// entire width of the layout.
    ///
    /// This only has an effect if `pango.Layout.setJustify` has
    /// been called as well.
    ///
    /// The default value is `FALSE`.
    extern fn pango_layout_set_justify_last_line(p_layout: *Layout, p_justify: c_int) void;
    pub const setJustifyLastLine = pango_layout_set_justify_last_line;

    /// Sets a factor for line spacing.
    ///
    /// Typical values are: 0, 1, 1.5, 2. The default values is 0.
    ///
    /// If `factor` is non-zero, lines are placed so that
    ///
    ///     baseline2 = baseline1 + factor * height2
    ///
    /// where height2 is the line height of the second line
    /// (as determined by the font(s)). In this case, the spacing
    /// set with `pango.Layout.setSpacing` is ignored.
    ///
    /// If `factor` is zero (the default), spacing is applied as before.
    ///
    /// Note: for semantics that are closer to the CSS line-height
    /// property, see `pango.attrLineHeightNew`.
    extern fn pango_layout_set_line_spacing(p_layout: *Layout, p_factor: f32) void;
    pub const setLineSpacing = pango_layout_set_line_spacing;

    /// Sets the layout text and attribute list from marked-up text.
    ///
    /// See [Pango Markup](pango_markup.html)).
    ///
    /// Replaces the current text and attribute list.
    ///
    /// This is the same as `pango.Layout.setMarkupWithAccel`,
    /// but the markup text isn't scanned for accelerators.
    extern fn pango_layout_set_markup(p_layout: *Layout, p_markup: [*:0]const u8, p_length: c_int) void;
    pub const setMarkup = pango_layout_set_markup;

    /// Sets the layout text and attribute list from marked-up text.
    ///
    /// See [Pango Markup](pango_markup.html)).
    ///
    /// Replaces the current text and attribute list.
    ///
    /// If `accel_marker` is nonzero, the given character will mark the
    /// character following it as an accelerator. For example, `accel_marker`
    /// might be an ampersand or underscore. All characters marked
    /// as an accelerator will receive a `PANGO_UNDERLINE_LOW` attribute,
    /// and the first character so marked will be returned in `accel_char`.
    /// Two `accel_marker` characters following each other produce a single
    /// literal `accel_marker` character.
    extern fn pango_layout_set_markup_with_accel(p_layout: *Layout, p_markup: [*:0]const u8, p_length: c_int, p_accel_marker: u32, p_accel_char: ?*u32) void;
    pub const setMarkupWithAccel = pango_layout_set_markup_with_accel;

    /// Sets the single paragraph mode of `layout`.
    ///
    /// If `setting` is `TRUE`, do not treat newlines and similar characters
    /// as paragraph separators; instead, keep all text in a single paragraph,
    /// and display a glyph for paragraph separator characters. Used when
    /// you want to allow editing of newlines on a single text line.
    ///
    /// The default value is `FALSE`.
    extern fn pango_layout_set_single_paragraph_mode(p_layout: *Layout, p_setting: c_int) void;
    pub const setSingleParagraphMode = pango_layout_set_single_paragraph_mode;

    /// Sets the amount of spacing in Pango units between
    /// the lines of the layout.
    ///
    /// When placing lines with spacing, Pango arranges things so that
    ///
    ///     line2.top = line1.bottom + spacing
    ///
    /// The default value is 0.
    ///
    /// Note: Since 1.44, Pango is using the line height (as determined
    /// by the font) for placing lines when the line spacing factor is set
    /// to a non-zero value with `pango.Layout.setLineSpacing`.
    /// In that case, the `spacing` set with this function is ignored.
    ///
    /// Note: for semantics that are closer to the CSS line-height
    /// property, see `pango.attrLineHeightNew`.
    extern fn pango_layout_set_spacing(p_layout: *Layout, p_spacing: c_int) void;
    pub const setSpacing = pango_layout_set_spacing;

    /// Sets the tabs to use for `layout`, overriding the default tabs.
    ///
    /// `PangoLayout` will place content at the next tab position
    /// whenever it meets a Tab character (U+0009).
    ///
    /// By default, tabs are every 8 spaces. If `tabs` is `NULL`, the
    /// default tabs are reinstated. `tabs` is copied into the layout;
    /// you must free your copy of `tabs` yourself.
    ///
    /// Note that tabs and justification conflict with each other:
    /// Justification will move content away from its tab-aligned
    /// positions. The same is true for alignments other than
    /// `PANGO_ALIGN_LEFT`.
    extern fn pango_layout_set_tabs(p_layout: *Layout, p_tabs: ?*pango.TabArray) void;
    pub const setTabs = pango_layout_set_tabs;

    /// Sets the text of the layout.
    ///
    /// This function validates `text` and renders invalid UTF-8
    /// with a placeholder glyph.
    ///
    /// Note that if you have used `pango.Layout.setMarkup` or
    /// `pango.Layout.setMarkupWithAccel` on `layout` before, you
    /// may want to call `pango.Layout.setAttributes` to clear the
    /// attributes set on the layout from the markup as this function does
    /// not clear attributes.
    extern fn pango_layout_set_text(p_layout: *Layout, p_text: [*:0]const u8, p_length: c_int) void;
    pub const setText = pango_layout_set_text;

    /// Sets the width to which the lines of the `PangoLayout` should wrap or
    /// get ellipsized.
    ///
    /// The default value is -1: no width set.
    extern fn pango_layout_set_width(p_layout: *Layout, p_width: c_int) void;
    pub const setWidth = pango_layout_set_width;

    /// Sets the wrap mode.
    ///
    /// The wrap mode only has effect if a width is set on the layout
    /// with `pango.Layout.setWidth`. To turn off wrapping,
    /// set the width to -1.
    ///
    /// The default value is `PANGO_WRAP_WORD`.
    extern fn pango_layout_set_wrap(p_layout: *Layout, p_wrap: pango.WrapMode) void;
    pub const setWrap = pango_layout_set_wrap;

    /// A convenience method to serialize a layout to a file.
    ///
    /// It is equivalent to calling `pango.Layout.serialize`
    /// followed by `glib.fileSetContents`.
    ///
    /// See those two functions for details on the arguments.
    ///
    /// It is mostly intended for use inside a debugger to quickly dump
    /// a layout to a file for later inspection.
    extern fn pango_layout_write_to_file(p_layout: *Layout, p_flags: pango.LayoutSerializeFlags, p_filename: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const writeToFile = pango_layout_write_to_file;

    /// Converts from X and Y position within a layout to the byte index to the
    /// character at that logical position.
    ///
    /// If the Y position is not inside the layout, the closest position is
    /// chosen (the position will be clamped inside the layout). If the X position
    /// is not within the layout, then the start or the end of the line is
    /// chosen as described for `pango.LayoutLine.xToIndex`. If either
    /// the X or Y positions were not inside the layout, then the function returns
    /// `FALSE`; on an exact hit, it returns `TRUE`.
    extern fn pango_layout_xy_to_index(p_layout: *Layout, p_x: c_int, p_y: c_int, p_index_: *c_int, p_trailing: *c_int) c_int;
    pub const xyToIndex = pango_layout_xy_to_index;

    extern fn pango_layout_get_type() usize;
    pub const getGObjectType = pango_layout_get_type;

    extern fn g_object_ref(p_self: *pango.Layout) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.Layout) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Layout, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoRenderer` is a base class for objects that can render text
/// provided as `PangoGlyphString` or `PangoLayout`.
///
/// By subclassing `PangoRenderer` and overriding operations such as
/// `draw_glyphs` and `draw_rectangle`, renderers for particular font
/// backends and destinations can be created.
pub const Renderer = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = pango.RendererClass;
    f_parent_instance: gobject.Object,
    f_underline: pango.Underline,
    f_strikethrough: c_int,
    f_active_count: c_int,
    /// the current transformation matrix for
    ///   the Renderer; may be `NULL`, which should be treated the
    ///   same as the identity matrix.
    f_matrix: ?*pango.Matrix,
    f_priv: ?*pango.RendererPrivate,

    pub const virtual_methods = struct {
        /// Do renderer-specific initialization before drawing
        pub const begin = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Renderer.Class, p_class).f_begin.?(gobject.ext.as(Renderer, p_renderer));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_begin = @ptrCast(p_implementation);
            }
        };

        /// Draw a squiggly line that approximately covers the given rectangle
        /// in the style of an underline used to indicate a spelling error.
        ///
        /// The width of the underline is rounded to an integer number
        /// of up/down segments and the resulting rectangle is centered
        /// in the original rectangle.
        ///
        /// This should be called while `renderer` is already active.
        /// Use `pango.Renderer.activate` to activate a renderer.
        pub const draw_error_underline = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_error_underline.?(gobject.ext.as(Renderer, p_renderer), p_x, p_y, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_error_underline = @ptrCast(p_implementation);
            }
        };

        /// Draws a single glyph with coordinates in device space.
        pub const draw_glyph = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font, p_glyph: pango.Glyph, p_x: f64, p_y: f64) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_glyph.?(gobject.ext.as(Renderer, p_renderer), p_font, p_glyph, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font, p_glyph: pango.Glyph, p_x: f64, p_y: f64) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_glyph = @ptrCast(p_implementation);
            }
        };

        /// Draws the glyphs in `glyph_item` with the specified `PangoRenderer`,
        /// embedding the text associated with the glyphs in the output if the
        /// output format supports it.
        ///
        /// This is useful for rendering text in PDF.
        ///
        /// Note that this method does not handle attributes in `glyph_item`.
        /// If you want colors, shapes and lines handled automatically according
        /// to those attributes, you need to use `pango.Renderer.drawLayoutLine`
        /// or `pango.Renderer.drawLayout`.
        ///
        /// Note that `text` is the start of the text for layout, which is then
        /// indexed by `glyph_item->item->offset`.
        ///
        /// If `text` is `NULL`, this simply calls `pango.Renderer.drawGlyphs`.
        ///
        /// The default implementation of this method simply falls back to
        /// `pango.Renderer.drawGlyphs`.
        pub const draw_glyph_item = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_text: ?[*:0]const u8, p_glyph_item: *pango.GlyphItem, p_x: c_int, p_y: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_glyph_item.?(gobject.ext.as(Renderer, p_renderer), p_text, p_glyph_item, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_text: ?[*:0]const u8, p_glyph_item: *pango.GlyphItem, p_x: c_int, p_y: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_glyph_item = @ptrCast(p_implementation);
            }
        };

        /// Draws the glyphs in `glyphs` with the specified `PangoRenderer`.
        pub const draw_glyphs = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_glyphs.?(gobject.ext.as(Renderer, p_renderer), p_font, p_glyphs, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_glyphs = @ptrCast(p_implementation);
            }
        };

        /// Draws an axis-aligned rectangle in user space coordinates with the
        /// specified `PangoRenderer`.
        ///
        /// This should be called while `renderer` is already active.
        /// Use `pango.Renderer.activate` to activate a renderer.
        pub const draw_rectangle = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_rectangle.?(gobject.ext.as(Renderer, p_renderer), p_part, p_x, p_y, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_rectangle = @ptrCast(p_implementation);
            }
        };

        /// draw content for a glyph shaped with `PangoAttrShape`
        ///   `x`, `y` are the coordinates of the left edge of the baseline,
        ///   in user coordinates.
        pub const draw_shape = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attr: *pango.AttrShape, p_x: c_int, p_y: c_int) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_shape.?(gobject.ext.as(Renderer, p_renderer), p_attr, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attr: *pango.AttrShape, p_x: c_int, p_y: c_int) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_shape = @ptrCast(p_implementation);
            }
        };

        /// Draws a trapezoid with the parallel sides aligned with the X axis
        /// using the given `PangoRenderer`; coordinates are in device space.
        pub const draw_trapezoid = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_y1_: f64, p_x11: f64, p_x21: f64, p_y2: f64, p_x12: f64, p_x22: f64) void {
                return gobject.ext.as(Renderer.Class, p_class).f_draw_trapezoid.?(gobject.ext.as(Renderer, p_renderer), p_part, p_y1_, p_x11, p_x21, p_y2, p_x12, p_x22);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart, p_y1_: f64, p_x11: f64, p_x21: f64, p_y2: f64, p_x12: f64, p_x22: f64) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_draw_trapezoid = @ptrCast(p_implementation);
            }
        };

        /// Do renderer-specific cleanup after drawing
        pub const end = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Renderer.Class, p_class).f_end.?(gobject.ext.as(Renderer, p_renderer));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_end = @ptrCast(p_implementation);
            }
        };

        /// Informs Pango that the way that the rendering is done
        /// for `part` has changed.
        ///
        /// This should be called if the rendering changes in a way that would
        /// prevent multiple pieces being joined together into one drawing call.
        /// For instance, if a subclass of `PangoRenderer` was to add a stipple
        /// option for drawing underlines, it needs to call
        ///
        /// ```
        /// pango_renderer_part_changed (render, PANGO_RENDER_PART_UNDERLINE);
        /// ```
        ///
        /// When the stipple changes or underlines with different stipples
        /// might be joined together. Pango automatically calls this for
        /// changes to colors. (See `pango.Renderer.setColor`)
        pub const part_changed = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart) void {
                return gobject.ext.as(Renderer.Class, p_class).f_part_changed.?(gobject.ext.as(Renderer, p_renderer), p_part);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_part: pango.RenderPart) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_part_changed = @ptrCast(p_implementation);
            }
        };

        /// updates the renderer for a new run
        pub const prepare_run = struct {
            pub fn call(p_class: anytype, p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_run: *pango.LayoutRun) void {
                return gobject.ext.as(Renderer.Class, p_class).f_prepare_run.?(gobject.ext.as(Renderer, p_renderer), p_run);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_renderer: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_run: *pango.LayoutRun) callconv(.c) void) void {
                gobject.ext.as(Renderer.Class, p_class).f_prepare_run = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Does initial setup before rendering operations on `renderer`.
    ///
    /// `pango.Renderer.deactivate` should be called when done drawing.
    /// Calls such as `pango.Renderer.drawLayout` automatically
    /// activate the layout before drawing on it.
    ///
    /// Calls to `pango.Renderer.activate` and
    /// `pango.Renderer.deactivate` can be nested and the
    /// renderer will only be initialized and deinitialized once.
    extern fn pango_renderer_activate(p_renderer: *Renderer) void;
    pub const activate = pango_renderer_activate;

    /// Cleans up after rendering operations on `renderer`.
    ///
    /// See docs for `pango.Renderer.activate`.
    extern fn pango_renderer_deactivate(p_renderer: *Renderer) void;
    pub const deactivate = pango_renderer_deactivate;

    /// Draw a squiggly line that approximately covers the given rectangle
    /// in the style of an underline used to indicate a spelling error.
    ///
    /// The width of the underline is rounded to an integer number
    /// of up/down segments and the resulting rectangle is centered
    /// in the original rectangle.
    ///
    /// This should be called while `renderer` is already active.
    /// Use `pango.Renderer.activate` to activate a renderer.
    extern fn pango_renderer_draw_error_underline(p_renderer: *Renderer, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void;
    pub const drawErrorUnderline = pango_renderer_draw_error_underline;

    /// Draws a single glyph with coordinates in device space.
    extern fn pango_renderer_draw_glyph(p_renderer: *Renderer, p_font: *pango.Font, p_glyph: pango.Glyph, p_x: f64, p_y: f64) void;
    pub const drawGlyph = pango_renderer_draw_glyph;

    /// Draws the glyphs in `glyph_item` with the specified `PangoRenderer`,
    /// embedding the text associated with the glyphs in the output if the
    /// output format supports it.
    ///
    /// This is useful for rendering text in PDF.
    ///
    /// Note that this method does not handle attributes in `glyph_item`.
    /// If you want colors, shapes and lines handled automatically according
    /// to those attributes, you need to use `pango.Renderer.drawLayoutLine`
    /// or `pango.Renderer.drawLayout`.
    ///
    /// Note that `text` is the start of the text for layout, which is then
    /// indexed by `glyph_item->item->offset`.
    ///
    /// If `text` is `NULL`, this simply calls `pango.Renderer.drawGlyphs`.
    ///
    /// The default implementation of this method simply falls back to
    /// `pango.Renderer.drawGlyphs`.
    extern fn pango_renderer_draw_glyph_item(p_renderer: *Renderer, p_text: ?[*:0]const u8, p_glyph_item: *pango.GlyphItem, p_x: c_int, p_y: c_int) void;
    pub const drawGlyphItem = pango_renderer_draw_glyph_item;

    /// Draws the glyphs in `glyphs` with the specified `PangoRenderer`.
    extern fn pango_renderer_draw_glyphs(p_renderer: *Renderer, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) void;
    pub const drawGlyphs = pango_renderer_draw_glyphs;

    /// Draws `layout` with the specified `PangoRenderer`.
    ///
    /// This is equivalent to drawing the lines of the layout, at their
    /// respective positions relative to `x`, `y`.
    extern fn pango_renderer_draw_layout(p_renderer: *Renderer, p_layout: *pango.Layout, p_x: c_int, p_y: c_int) void;
    pub const drawLayout = pango_renderer_draw_layout;

    /// Draws `line` with the specified `PangoRenderer`.
    ///
    /// This draws the glyph items that make up the line, as well as
    /// shapes, backgrounds and lines that are specified by the attributes
    /// of those items.
    extern fn pango_renderer_draw_layout_line(p_renderer: *Renderer, p_line: *pango.LayoutLine, p_x: c_int, p_y: c_int) void;
    pub const drawLayoutLine = pango_renderer_draw_layout_line;

    /// Draws an axis-aligned rectangle in user space coordinates with the
    /// specified `PangoRenderer`.
    ///
    /// This should be called while `renderer` is already active.
    /// Use `pango.Renderer.activate` to activate a renderer.
    extern fn pango_renderer_draw_rectangle(p_renderer: *Renderer, p_part: pango.RenderPart, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void;
    pub const drawRectangle = pango_renderer_draw_rectangle;

    /// Draws a trapezoid with the parallel sides aligned with the X axis
    /// using the given `PangoRenderer`; coordinates are in device space.
    extern fn pango_renderer_draw_trapezoid(p_renderer: *Renderer, p_part: pango.RenderPart, p_y1_: f64, p_x11: f64, p_x21: f64, p_y2: f64, p_x12: f64, p_x22: f64) void;
    pub const drawTrapezoid = pango_renderer_draw_trapezoid;

    /// Gets the current alpha for the specified part.
    extern fn pango_renderer_get_alpha(p_renderer: *Renderer, p_part: pango.RenderPart) u16;
    pub const getAlpha = pango_renderer_get_alpha;

    /// Gets the current rendering color for the specified part.
    extern fn pango_renderer_get_color(p_renderer: *Renderer, p_part: pango.RenderPart) ?*pango.Color;
    pub const getColor = pango_renderer_get_color;

    /// Gets the layout currently being rendered using `renderer`.
    ///
    /// Calling this function only makes sense from inside a subclass's
    /// methods, like in its draw_shape vfunc, for example.
    ///
    /// The returned layout should not be modified while still being
    /// rendered.
    extern fn pango_renderer_get_layout(p_renderer: *Renderer) ?*pango.Layout;
    pub const getLayout = pango_renderer_get_layout;

    /// Gets the layout line currently being rendered using `renderer`.
    ///
    /// Calling this function only makes sense from inside a subclass's
    /// methods, like in its draw_shape vfunc, for example.
    ///
    /// The returned layout line should not be modified while still being
    /// rendered.
    extern fn pango_renderer_get_layout_line(p_renderer: *Renderer) ?*pango.LayoutLine;
    pub const getLayoutLine = pango_renderer_get_layout_line;

    /// Gets the transformation matrix that will be applied when
    /// rendering.
    ///
    /// See `pango.Renderer.setMatrix`.
    extern fn pango_renderer_get_matrix(p_renderer: *Renderer) ?*const pango.Matrix;
    pub const getMatrix = pango_renderer_get_matrix;

    /// Informs Pango that the way that the rendering is done
    /// for `part` has changed.
    ///
    /// This should be called if the rendering changes in a way that would
    /// prevent multiple pieces being joined together into one drawing call.
    /// For instance, if a subclass of `PangoRenderer` was to add a stipple
    /// option for drawing underlines, it needs to call
    ///
    /// ```
    /// pango_renderer_part_changed (render, PANGO_RENDER_PART_UNDERLINE);
    /// ```
    ///
    /// When the stipple changes or underlines with different stipples
    /// might be joined together. Pango automatically calls this for
    /// changes to colors. (See `pango.Renderer.setColor`)
    extern fn pango_renderer_part_changed(p_renderer: *Renderer, p_part: pango.RenderPart) void;
    pub const partChanged = pango_renderer_part_changed;

    /// Sets the alpha for part of the rendering.
    ///
    /// Note that the alpha may only be used if a color is
    /// specified for `part` as well.
    extern fn pango_renderer_set_alpha(p_renderer: *Renderer, p_part: pango.RenderPart, p_alpha: u16) void;
    pub const setAlpha = pango_renderer_set_alpha;

    /// Sets the color for part of the rendering.
    ///
    /// Also see `pango.Renderer.setAlpha`.
    extern fn pango_renderer_set_color(p_renderer: *Renderer, p_part: pango.RenderPart, p_color: ?*const pango.Color) void;
    pub const setColor = pango_renderer_set_color;

    /// Sets the transformation matrix that will be applied when rendering.
    extern fn pango_renderer_set_matrix(p_renderer: *Renderer, p_matrix: ?*const pango.Matrix) void;
    pub const setMatrix = pango_renderer_set_matrix;

    extern fn pango_renderer_get_type() usize;
    pub const getGObjectType = pango_renderer_get_type;

    extern fn g_object_ref(p_self: *pango.Renderer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *pango.Renderer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Renderer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAnalysis` structure stores information about
/// the properties of a segment of text.
pub const Analysis = extern struct {
    /// unused, reserved
    f_shape_engine: ?*anyopaque,
    /// unused, reserved
    f_lang_engine: ?*anyopaque,
    /// the font for this segment.
    f_font: ?*pango.Font,
    /// the bidirectional level for this segment.
    f_level: u8,
    /// the glyph orientation for this segment (A `PangoGravity`).
    f_gravity: u8,
    /// boolean flags for this segment (Since: 1.16).
    f_flags: u8,
    /// the detected script for this segment (A `PangoScript`) (Since: 1.18).
    f_script: u8,
    /// the detected language for this segment.
    f_language: ?*pango.Language,
    /// extra attributes for this segment.
    f_extra_attrs: ?*glib.SList,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrClass` structure stores the type and operations for
/// a particular type of attribute.
///
/// The functions in this structure should not be called directly. Instead,
/// one should use the wrapper functions provided for `PangoAttribute`.
pub const AttrClass = extern struct {
    /// the type ID for this attribute
    f_type: pango.AttrType,
    /// function to duplicate an attribute of this type
    ///   (see `pango.Attribute.copy`)
    f_copy: ?*const fn (p_attr: *const pango.Attribute) callconv(.c) *pango.Attribute,
    /// function to free an attribute of this type
    ///   (see `pango.Attribute.destroy`)
    f_destroy: ?*const fn (p_attr: *pango.Attribute) callconv(.c) void,
    /// function to check two attributes of this type for equality
    ///   (see `pango.Attribute.equal`)
    f_equal: ?*const fn (p_attr1: *const pango.Attribute, p_attr2: *const pango.Attribute) callconv(.c) c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrColor` structure is used to represent attributes that
/// are colors.
pub const AttrColor = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the `PangoColor` which is the value of the attribute
    f_color: pango.Color,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrFloat` structure is used to represent attributes with
/// a float or double value.
pub const AttrFloat = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the value of the attribute
    f_value: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrFontDesc` structure is used to store an attribute that
/// sets all aspects of the font description at once.
pub const AttrFontDesc = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the font description which is the value of this attribute
    f_desc: ?*pango.FontDescription,

    /// Create a new font description attribute.
    ///
    /// This attribute allows setting family, style, weight, variant,
    /// stretch, and size simultaneously.
    extern fn pango_attr_font_desc_new(p_desc: *const pango.FontDescription) *pango.Attribute;
    pub const new = pango_attr_font_desc_new;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrFontFeatures` structure is used to represent OpenType
/// font features as an attribute.
pub const AttrFontFeatures = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the features, as a string in CSS syntax
    f_features: ?[*:0]u8,

    /// Create a new font features tag attribute.
    ///
    /// You can use this attribute to select OpenType font features like small-caps,
    /// alternative glyphs, ligatures, etc. for fonts that support them.
    extern fn pango_attr_font_features_new(p_features: [*:0]const u8) *pango.Attribute;
    pub const new = pango_attr_font_features_new;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrInt` structure is used to represent attributes with
/// an integer or enumeration value.
pub const AttrInt = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the value of the attribute
    f_value: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoAttrIterator` is used to iterate through a `PangoAttrList`.
///
/// A new iterator is created with `pango.AttrList.getIterator`.
/// Once the iterator is created, it can be advanced through the style
/// changes in the text using `pango.AttrIterator.next`. At each
/// style change, the range of the current style segment and the attributes
/// currently in effect can be queried.
pub const AttrIterator = opaque {
    /// Copy a `PangoAttrIterator`.
    extern fn pango_attr_iterator_copy(p_iterator: *AttrIterator) *pango.AttrIterator;
    pub const copy = pango_attr_iterator_copy;

    /// Destroy a `PangoAttrIterator` and free all associated memory.
    extern fn pango_attr_iterator_destroy(p_iterator: *AttrIterator) void;
    pub const destroy = pango_attr_iterator_destroy;

    /// Find the current attribute of a particular type
    /// at the iterator location.
    ///
    /// When multiple attributes of the same type overlap,
    /// the attribute whose range starts closest to the
    /// current location is used.
    extern fn pango_attr_iterator_get(p_iterator: *AttrIterator, p_type: pango.AttrType) ?*pango.Attribute;
    pub const get = pango_attr_iterator_get;

    /// Gets a list of all attributes at the current position of the
    /// iterator.
    extern fn pango_attr_iterator_get_attrs(p_iterator: *AttrIterator) *glib.SList;
    pub const getAttrs = pango_attr_iterator_get_attrs;

    /// Get the font and other attributes at the current
    /// iterator position.
    extern fn pango_attr_iterator_get_font(p_iterator: *AttrIterator, p_desc: *pango.FontDescription, p_language: ?**pango.Language, p_extra_attrs: ?**glib.SList) void;
    pub const getFont = pango_attr_iterator_get_font;

    /// Advance the iterator until the next change of style.
    extern fn pango_attr_iterator_next(p_iterator: *AttrIterator) c_int;
    pub const next = pango_attr_iterator_next;

    /// Get the range of the current segment.
    ///
    /// Note that the stored return values are signed, not unsigned
    /// like the values in `PangoAttribute`. To deal with this API
    /// oversight, stored return values that wouldn't fit into
    /// a signed integer are clamped to `G_MAXINT`.
    extern fn pango_attr_iterator_range(p_iterator: *AttrIterator, p_start: *c_int, p_end: *c_int) void;
    pub const range = pango_attr_iterator_range;

    extern fn pango_attr_iterator_get_type() usize;
    pub const getGObjectType = pango_attr_iterator_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrLanguage` structure is used to represent attributes that
/// are languages.
pub const AttrLanguage = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the `PangoLanguage` which is the value of the attribute
    f_value: ?*pango.Language,

    /// Create a new language tag attribute.
    extern fn pango_attr_language_new(p_language: *pango.Language) *pango.Attribute;
    pub const new = pango_attr_language_new;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoAttrList` represents a list of attributes that apply to a section
/// of text.
///
/// The attributes in a `PangoAttrList` are, in general, allowed to overlap in
/// an arbitrary fashion. However, if the attributes are manipulated only through
/// `pango.AttrList.change`, the overlap between properties will meet
/// stricter criteria.
///
/// Since the `PangoAttrList` structure is stored as a linear list, it is not
/// suitable for storing attributes for large amounts of text. In general, you
/// should not use a single `PangoAttrList` for more than one paragraph of text.
pub const AttrList = opaque {
    /// Deserializes a `PangoAttrList` from a string.
    ///
    /// This is the counterpart to `pango.AttrList.toString`.
    /// See that functions for details about the format.
    extern fn pango_attr_list_from_string(p_text: [*:0]const u8) ?*pango.AttrList;
    pub const fromString = pango_attr_list_from_string;

    /// Create a new empty attribute list with a reference
    /// count of one.
    extern fn pango_attr_list_new() *pango.AttrList;
    pub const new = pango_attr_list_new;

    /// Insert the given attribute into the `PangoAttrList`.
    ///
    /// It will replace any attributes of the same type
    /// on that segment and be merged with any adjoining
    /// attributes that are identical.
    ///
    /// This function is slower than `pango.AttrList.insert`
    /// for creating an attribute list in order (potentially
    /// much slower for large lists). However,
    /// `pango.AttrList.insert` is not suitable for
    /// continually changing a set of attributes since it
    /// never removes or combines existing attributes.
    extern fn pango_attr_list_change(p_list: *AttrList, p_attr: *pango.Attribute) void;
    pub const change = pango_attr_list_change;

    /// Copy `list` and return an identical new list.
    extern fn pango_attr_list_copy(p_list: ?*AttrList) ?*pango.AttrList;
    pub const copy = pango_attr_list_copy;

    /// Checks whether `list` and `other_list` contain the same
    /// attributes and whether those attributes apply to the
    /// same ranges.
    ///
    /// Beware that this will return wrong values if any list
    /// contains duplicates.
    extern fn pango_attr_list_equal(p_list: *AttrList, p_other_list: *pango.AttrList) c_int;
    pub const equal = pango_attr_list_equal;

    /// Given a `PangoAttrList` and callback function, removes
    /// any elements of `list` for which `func` returns `TRUE` and
    /// inserts them into a new list.
    extern fn pango_attr_list_filter(p_list: *AttrList, p_func: pango.AttrFilterFunc, p_data: ?*anyopaque) ?*pango.AttrList;
    pub const filter = pango_attr_list_filter;

    /// Gets a list of all attributes in `list`.
    extern fn pango_attr_list_get_attributes(p_list: *AttrList) *glib.SList;
    pub const getAttributes = pango_attr_list_get_attributes;

    /// Create a iterator initialized to the beginning of the list.
    ///
    /// `list` must not be modified until this iterator is freed.
    extern fn pango_attr_list_get_iterator(p_list: *AttrList) *pango.AttrIterator;
    pub const getIterator = pango_attr_list_get_iterator;

    /// Insert the given attribute into the `PangoAttrList`.
    ///
    /// It will be inserted after all other attributes with a
    /// matching `start_index`.
    extern fn pango_attr_list_insert(p_list: *AttrList, p_attr: *pango.Attribute) void;
    pub const insert = pango_attr_list_insert;

    /// Insert the given attribute into the `PangoAttrList`.
    ///
    /// It will be inserted before all other attributes with a
    /// matching `start_index`.
    extern fn pango_attr_list_insert_before(p_list: *AttrList, p_attr: *pango.Attribute) void;
    pub const insertBefore = pango_attr_list_insert_before;

    /// Increase the reference count of the given attribute
    /// list by one.
    extern fn pango_attr_list_ref(p_list: ?*AttrList) *pango.AttrList;
    pub const ref = pango_attr_list_ref;

    /// This function opens up a hole in `list`, fills it
    /// in with attributes from the left, and then merges
    /// `other` on top of the hole.
    ///
    /// This operation is equivalent to stretching every attribute
    /// that applies at position `pos` in `list` by an amount `len`,
    /// and then calling `pango.AttrList.change` with a copy
    /// of each attribute in `other` in sequence (offset in position
    /// by `pos`, and limited in length to `len`).
    ///
    /// This operation proves useful for, for instance, inserting
    /// a pre-edit string in the middle of an edit buffer.
    ///
    /// For backwards compatibility, the function behaves differently
    /// when `len` is 0. In this case, the attributes from `other` are
    /// not imited to `len`, and are just overlayed on top of `list`.
    ///
    /// This mode is useful for merging two lists of attributes together.
    extern fn pango_attr_list_splice(p_list: *AttrList, p_other: *pango.AttrList, p_pos: c_int, p_len: c_int) void;
    pub const splice = pango_attr_list_splice;

    /// Serializes a `PangoAttrList` to a string.
    ///
    /// In the resulting string, serialized attributes are separated by newlines or commas.
    /// Individual attributes are serialized to a string of the form
    ///
    ///     [START END] TYPE VALUE
    ///
    /// Where START and END are the indices (with -1 being accepted in place
    /// of MAXUINT), TYPE is the nickname of the attribute value type, e.g.
    /// _weight_ or _stretch_, and the value is serialized according to its type:
    ///
    /// Optionally, START and END can be omitted to indicate unlimited extent.
    ///
    /// - enum values as nick or numeric value
    /// - boolean values as _true_ or _false_
    /// - integers and floats as numbers
    /// - strings as string, optionally quoted
    /// - font features as quoted string
    /// - PangoLanguage as string
    /// - PangoFontDescription as serialized by `pango.FontDescription.toString`, quoted
    /// - PangoColor as serialized by `pango.Color.toString`
    ///
    /// Examples:
    ///
    ///     0 10 foreground red, 5 15 weight bold, 0 200 font-desc "Sans 10"
    ///
    ///     0 -1 weight 700
    ///     0 100 family Times
    ///
    ///     weight bold
    ///
    /// To parse the returned value, use `pango.AttrList.fromString`.
    ///
    /// Note that shape attributes can not be serialized.
    extern fn pango_attr_list_to_string(p_list: *AttrList) [*:0]u8;
    pub const toString = pango_attr_list_to_string;

    /// Decrease the reference count of the given attribute
    /// list by one.
    ///
    /// If the result is zero, free the attribute list
    /// and the attributes it contains.
    extern fn pango_attr_list_unref(p_list: ?*AttrList) void;
    pub const unref = pango_attr_list_unref;

    /// Update indices of attributes in `list` for a change in the
    /// text they refer to.
    ///
    /// The change that this function applies is removing `remove`
    /// bytes at position `pos` and inserting `add` bytes instead.
    ///
    /// Attributes that fall entirely in the (`pos`, `pos` + `remove`)
    /// range are removed.
    ///
    /// Attributes that start or end inside the (`pos`, `pos` + `remove`)
    /// range are shortened to reflect the removal.
    ///
    /// Attributes start and end positions are updated if they are
    /// behind `pos` + `remove`.
    extern fn pango_attr_list_update(p_list: *AttrList, p_pos: c_int, p_remove: c_int, p_add: c_int) void;
    pub const update = pango_attr_list_update;

    extern fn pango_attr_list_get_type() usize;
    pub const getGObjectType = pango_attr_list_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrShape` structure is used to represent attributes which
/// impose shape restrictions.
pub const AttrShape = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the ink rectangle to restrict to
    f_ink_rect: pango.Rectangle,
    /// the logical rectangle to restrict to
    f_logical_rect: pango.Rectangle,
    /// user data set (see `pango.AttrShape.newWithData`)
    f_data: ?*anyopaque,
    /// copy function for the user data
    f_copy_func: ?pango.AttrDataCopyFunc,
    /// destroy function for the user data
    f_destroy_func: ?glib.DestroyNotify,

    /// Create a new shape attribute.
    ///
    /// A shape is used to impose a particular ink and logical
    /// rectangle on the result of shaping a particular glyph.
    /// This might be used, for instance, for embedding a picture
    /// or a widget inside a `PangoLayout`.
    extern fn pango_attr_shape_new(p_ink_rect: *const pango.Rectangle, p_logical_rect: *const pango.Rectangle) *pango.Attribute;
    pub const new = pango_attr_shape_new;

    /// Creates a new shape attribute.
    ///
    /// Like `pango.AttrShape.new`, but a user data pointer
    /// is also provided; this pointer can be accessed when later
    /// rendering the glyph.
    extern fn pango_attr_shape_new_with_data(p_ink_rect: *const pango.Rectangle, p_logical_rect: *const pango.Rectangle, p_data: ?*anyopaque, p_copy_func: ?pango.AttrDataCopyFunc, p_destroy_func: ?glib.DestroyNotify) *pango.Attribute;
    pub const newWithData = pango_attr_shape_new_with_data;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrSize` structure is used to represent attributes which
/// set font size.
pub const AttrSize = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// size of font, in units of 1/`PANGO_SCALE` of a point (for
    ///   `PANGO_ATTR_SIZE`) or of a device unit (for `PANGO_ATTR_ABSOLUTE_SIZE`)
    f_size: c_int,
    bitfields0: packed struct(c_uint) {
        /// whether the font size is in device units or points.
        ///   This field is only present for compatibility with Pango-1.8.0
        ///   (`PANGO_ATTR_ABSOLUTE_SIZE` was added in 1.8.1); and always will
        ///   be `FALSE` for `PANGO_ATTR_SIZE` and `TRUE` for `PANGO_ATTR_ABSOLUTE_SIZE`.
        f_absolute: u1,
        _: u31,
    },

    /// Create a new font-size attribute in fractional points.
    extern fn pango_attr_size_new(p_size: c_int) *pango.Attribute;
    pub const new = pango_attr_size_new;

    /// Create a new font-size attribute in device units.
    extern fn pango_attr_size_new_absolute(p_size: c_int) *pango.Attribute;
    pub const newAbsolute = pango_attr_size_new_absolute;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrString` structure is used to represent attributes with
/// a string value.
pub const AttrString = extern struct {
    /// the common portion of the attribute
    f_attr: pango.Attribute,
    /// the string which is the value of the attribute
    f_value: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttribute` structure represents the common portions of all
/// attributes.
///
/// Particular types of attributes include this structure as their initial
/// portion. The common portion of the attribute holds the range to which
/// the value in the type-specific part of the attribute applies and should
/// be initialized using `pango.Attribute.init`. By default, an attribute
/// will have an all-inclusive range of [0,`G_MAXUINT`].
pub const Attribute = extern struct {
    /// the class structure holding information about the type of the attribute
    f_klass: ?*const pango.AttrClass,
    /// the start index of the range (in bytes).
    f_start_index: c_uint,
    /// end index of the range (in bytes). The character at this index
    ///   is not included in the range.
    f_end_index: c_uint,

    /// Returns the attribute cast to `PangoAttrColor`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_color(p_attr: *Attribute) ?*pango.AttrColor;
    pub const asColor = pango_attribute_as_color;

    /// Returns the attribute cast to `PangoAttrFloat`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_float(p_attr: *Attribute) ?*pango.AttrFloat;
    pub const asFloat = pango_attribute_as_float;

    /// Returns the attribute cast to `PangoAttrFontDesc`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_font_desc(p_attr: *Attribute) ?*pango.AttrFontDesc;
    pub const asFontDesc = pango_attribute_as_font_desc;

    /// Returns the attribute cast to `PangoAttrFontFeatures`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_font_features(p_attr: *Attribute) ?*pango.AttrFontFeatures;
    pub const asFontFeatures = pango_attribute_as_font_features;

    /// Returns the attribute cast to `PangoAttrInt`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_int(p_attr: *Attribute) ?*pango.AttrInt;
    pub const asInt = pango_attribute_as_int;

    /// Returns the attribute cast to `PangoAttrLanguage`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_language(p_attr: *Attribute) ?*pango.AttrLanguage;
    pub const asLanguage = pango_attribute_as_language;

    /// Returns the attribute cast to `PangoAttrShape`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_shape(p_attr: *Attribute) ?*pango.AttrShape;
    pub const asShape = pango_attribute_as_shape;

    /// Returns the attribute cast to `PangoAttrSize`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_size(p_attr: *Attribute) ?*pango.AttrSize;
    pub const asSize = pango_attribute_as_size;

    /// Returns the attribute cast to `PangoAttrString`.
    ///
    /// This is mainly useful for language bindings.
    extern fn pango_attribute_as_string(p_attr: *Attribute) ?*pango.AttrString;
    pub const asString = pango_attribute_as_string;

    /// Make a copy of an attribute.
    extern fn pango_attribute_copy(p_attr: *const Attribute) *pango.Attribute;
    pub const copy = pango_attribute_copy;

    /// Destroy a `PangoAttribute` and free all associated memory.
    extern fn pango_attribute_destroy(p_attr: *Attribute) void;
    pub const destroy = pango_attribute_destroy;

    /// Compare two attributes for equality.
    ///
    /// This compares only the actual value of the two
    /// attributes and not the ranges that the attributes
    /// apply to.
    extern fn pango_attribute_equal(p_attr1: *const Attribute, p_attr2: *const pango.Attribute) c_int;
    pub const equal = pango_attribute_equal;

    /// Initializes `attr`'s klass to `klass`, it's start_index to
    /// `PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING` and end_index to
    /// `PANGO_ATTR_INDEX_TO_TEXT_END` such that the attribute applies
    /// to the entire text by default.
    extern fn pango_attribute_init(p_attr: *Attribute, p_klass: *const pango.AttrClass) void;
    pub const init = pango_attribute_init;

    extern fn pango_attribute_get_type() usize;
    pub const getGObjectType = pango_attribute_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoColor` structure is used to
/// represent a color in an uncalibrated RGB color-space.
pub const Color = extern struct {
    /// value of red component
    f_red: u16,
    /// value of green component
    f_green: u16,
    /// value of blue component
    f_blue: u16,

    /// Creates a copy of `src`.
    ///
    /// The copy should be freed with `pango.Color.free`.
    /// Primarily used by language bindings, not that useful
    /// otherwise (since colors can just be copied by assignment
    /// in C).
    extern fn pango_color_copy(p_src: ?*const Color) ?*pango.Color;
    pub const copy = pango_color_copy;

    /// Frees a color allocated by `pango.Color.copy`.
    extern fn pango_color_free(p_color: ?*Color) void;
    pub const free = pango_color_free;

    /// Fill in the fields of a color from a string specification.
    ///
    /// The string can either one of a large set of standard names.
    /// (Taken from the CSS Color [specification](https://www.w3.org/TR/css-color-4/`named`-colors),
    /// or it can be a value in the form ``rgb``, ``rrggbb``,
    /// ``rrrgggbbb`` or ``rrrrggggbbbb``, where `r`, `g` and `b`
    /// are hex digits of the red, green, and blue components
    /// of the color, respectively. (White in the four forms is
    /// ``fff``, ``ffffff``, ``fffffffff`` and ``ffffffffffff``.)
    extern fn pango_color_parse(p_color: ?*Color, p_spec: [*:0]const u8) c_int;
    pub const parse = pango_color_parse;

    /// Fill in the fields of a color from a string specification.
    ///
    /// The string can either one of a large set of standard names.
    /// (Taken from the CSS Color [specification](https://www.w3.org/TR/css-color-4/`named`-colors),
    /// or it can be a hexadecimal value in the form ``rgb``,
    /// ``rrggbb``, ``rrrgggbbb`` or ``rrrrggggbbbb`` where `r`, `g`
    /// and `b` are hex digits of the red, green, and blue components
    /// of the color, respectively. (White in the four forms is
    /// ``fff``, ``ffffff``, ``fffffffff`` and ``ffffffffffff``.)
    ///
    /// Additionally, parse strings of the form ``rgba``, ``rrggbbaa``,
    /// ``rrrrggggbbbbaaaa``, if `alpha` is not `NULL`, and set `alpha`
    /// to the value specified by the hex digits for `a`. If no alpha
    /// component is found in `spec`, `alpha` is set to 0xffff (for a
    /// solid color).
    extern fn pango_color_parse_with_alpha(p_color: ?*Color, p_alpha: ?*u16, p_spec: [*:0]const u8) c_int;
    pub const parseWithAlpha = pango_color_parse_with_alpha;

    /// Returns a textual specification of `color`.
    ///
    /// The string is in the hexadecimal form ``rrrrggggbbbb``,
    /// where `r`, `g` and `b` are hex digits representing the
    /// red, green, and blue components respectively.
    extern fn pango_color_to_string(p_color: *const Color) [*:0]u8;
    pub const toString = pango_color_to_string;

    extern fn pango_color_get_type() usize;
    pub const getGObjectType = pango_color_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ContextClass = opaque {
    pub const Instance = pango.Context;

    pub fn as(p_instance: *ContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontClass = extern struct {
    pub const Instance = pango.Font;

    f_parent_class: gobject.ObjectClass,
    f_describe: ?*const fn (p_font: *pango.Font) callconv(.c) *pango.FontDescription,
    f_get_coverage: ?*const fn (p_font: *pango.Font, p_language: *pango.Language) callconv(.c) *pango.Coverage,
    f_get_glyph_extents: ?*const fn (p_font: ?*pango.Font, p_glyph: pango.Glyph, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) callconv(.c) void,
    f_get_metrics: ?*const fn (p_font: ?*pango.Font, p_language: ?*pango.Language) callconv(.c) *pango.FontMetrics,
    f_get_font_map: ?*const fn (p_font: ?*pango.Font) callconv(.c) ?*pango.FontMap,
    f_describe_absolute: ?*const fn (p_font: *pango.Font) callconv(.c) *pango.FontDescription,
    f_get_features: ?*const fn (p_font: *pango.Font, p_features: *[*]harfbuzz.feature_t, p_len: c_uint, p_num_features: *c_uint) callconv(.c) void,
    f_create_hb_font: ?*const fn (p_font: *pango.Font) callconv(.c) *harfbuzz.font_t,

    pub fn as(p_instance: *FontClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontDescription` describes a font in an implementation-independent
/// manner.
///
/// `PangoFontDescription` structures are used both to list what fonts are
/// available on the system and also for specifying the characteristics of
/// a font to load.
pub const FontDescription = opaque {
    /// Creates a new font description from a string representation.
    ///
    /// The string must have the form
    ///
    ///     [FAMILY-LIST] [STYLE-OPTIONS] [SIZE] [VARIATIONS] [FEATURES]
    ///
    /// where FAMILY-LIST is a comma-separated list of families optionally
    /// terminated by a comma, STYLE_OPTIONS is a whitespace-separated list
    /// of words where each word describes one of style, variant, weight,
    /// stretch, or gravity, and SIZE is a decimal number (size in points)
    /// or optionally followed by the unit modifier "px" for absolute size.
    ///
    /// The following words are understood as styles:
    /// "Normal", "Roman", "Oblique", "Italic".
    ///
    /// The following words are understood as variants:
    /// "Small-Caps", "All-Small-Caps", "Petite-Caps", "All-Petite-Caps",
    /// "Unicase", "Title-Caps".
    ///
    /// The following words are understood as weights:
    /// "Thin", "Ultra-Light", "Extra-Light", "Light", "Semi-Light",
    /// "Demi-Light", "Book", "Regular", "Medium", "Semi-Bold", "Demi-Bold",
    /// "Bold", "Ultra-Bold", "Extra-Bold", "Heavy", "Black", "Ultra-Black",
    /// "Extra-Black".
    ///
    /// The following words are understood as stretch values:
    /// "Ultra-Condensed", "Extra-Condensed", "Condensed", "Semi-Condensed",
    /// "Semi-Expanded", "Expanded", "Extra-Expanded", "Ultra-Expanded".
    ///
    /// The following words are understood as gravity values:
    /// "Not-Rotated", "South", "Upside-Down", "North", "Rotated-Left",
    /// "East", "Rotated-Right", "West".
    ///
    /// VARIATIONS is a comma-separated list of font variations
    /// of the form @‍axis1=value,axis2=value,...
    ///
    /// FEATURES is a comma-separated list of font features of the form
    /// \#‍feature1=value,feature2=value,...
    /// The =value part can be ommitted if the value is 1.
    ///
    /// Any one of the options may be absent. If FAMILY-LIST is absent, then
    /// the family_name field of the resulting font description will be
    /// initialized to `NULL`. If STYLE-OPTIONS is missing, then all style
    /// options will be set to the default values. If SIZE is missing, the
    /// size in the resulting font description will be set to 0.
    ///
    /// A typical example:
    ///
    ///     Cantarell Italic Light 15 @‍wght=200 #‍tnum=1
    extern fn pango_font_description_from_string(p_str: [*:0]const u8) *pango.FontDescription;
    pub const fromString = pango_font_description_from_string;

    /// Creates a new font description structure with all fields unset.
    extern fn pango_font_description_new() *pango.FontDescription;
    pub const new = pango_font_description_new;

    /// Determines if the style attributes of `new_match` are a closer match
    /// for `desc` than those of `old_match` are, or if `old_match` is `NULL`,
    /// determines if `new_match` is a match at all.
    ///
    /// Approximate matching is done for weight and style; other style attributes
    /// must match exactly. Style attributes are all attributes other than family
    /// and size-related attributes. Approximate matching for style considers
    /// `PANGO_STYLE_OBLIQUE` and `PANGO_STYLE_ITALIC` as matches, but not as good
    /// a match as when the styles are equal.
    ///
    /// Note that `old_match` must match `desc`.
    extern fn pango_font_description_better_match(p_desc: *const FontDescription, p_old_match: ?*const pango.FontDescription, p_new_match: *const pango.FontDescription) c_int;
    pub const betterMatch = pango_font_description_better_match;

    /// Make a copy of a `PangoFontDescription`.
    extern fn pango_font_description_copy(p_desc: ?*const FontDescription) ?*pango.FontDescription;
    pub const copy = pango_font_description_copy;

    /// Make a copy of a `PangoFontDescription`, but don't duplicate
    /// allocated fields.
    ///
    /// This is like `pango.FontDescription.copy`, but only a shallow
    /// copy is made of the family name and other allocated fields. The result
    /// can only be used until `desc` is modified or freed. This is meant
    /// to be used when the copy is only needed temporarily.
    extern fn pango_font_description_copy_static(p_desc: ?*const FontDescription) ?*pango.FontDescription;
    pub const copyStatic = pango_font_description_copy_static;

    /// Compares two font descriptions for equality.
    ///
    /// Two font descriptions are considered equal if the fonts they describe
    /// are provably identical. This means that their masks do not have to match,
    /// as long as other fields are all the same. (Two font descriptions may
    /// result in identical fonts being loaded, but still compare `FALSE`.)
    extern fn pango_font_description_equal(p_desc1: *const FontDescription, p_desc2: *const pango.FontDescription) c_int;
    pub const equal = pango_font_description_equal;

    /// Frees a font description.
    extern fn pango_font_description_free(p_desc: ?*FontDescription) void;
    pub const free = pango_font_description_free;

    /// Gets the family name field of a font description.
    ///
    /// See `pango.FontDescription.setFamily`.
    extern fn pango_font_description_get_family(p_desc: *const FontDescription) ?[*:0]const u8;
    pub const getFamily = pango_font_description_get_family;

    /// Gets the features field of a font description.
    ///
    /// See `pango.FontDescription.setFeatures`.
    extern fn pango_font_description_get_features(p_desc: *const FontDescription) ?[*:0]const u8;
    pub const getFeatures = pango_font_description_get_features;

    /// Gets the gravity field of a font description.
    ///
    /// See `pango.FontDescription.setGravity`.
    extern fn pango_font_description_get_gravity(p_desc: *const FontDescription) pango.Gravity;
    pub const getGravity = pango_font_description_get_gravity;

    /// Determines which fields in a font description have been set.
    extern fn pango_font_description_get_set_fields(p_desc: *const FontDescription) pango.FontMask;
    pub const getSetFields = pango_font_description_get_set_fields;

    /// Gets the size field of a font description.
    ///
    /// See `pango.FontDescription.setSize`.
    extern fn pango_font_description_get_size(p_desc: *const FontDescription) c_int;
    pub const getSize = pango_font_description_get_size;

    /// Determines whether the size of the font is in points (not absolute)
    /// or device units (absolute).
    ///
    /// See `pango.FontDescription.setSize`
    /// and `pango.FontDescription.setAbsoluteSize`.
    extern fn pango_font_description_get_size_is_absolute(p_desc: *const FontDescription) c_int;
    pub const getSizeIsAbsolute = pango_font_description_get_size_is_absolute;

    /// Gets the stretch field of a font description.
    ///
    /// See `pango.FontDescription.setStretch`.
    extern fn pango_font_description_get_stretch(p_desc: *const FontDescription) pango.Stretch;
    pub const getStretch = pango_font_description_get_stretch;

    /// Gets the style field of a `PangoFontDescription`.
    ///
    /// See `pango.FontDescription.setStyle`.
    extern fn pango_font_description_get_style(p_desc: *const FontDescription) pango.Style;
    pub const getStyle = pango_font_description_get_style;

    /// Gets the variant field of a `PangoFontDescription`.
    ///
    /// See `pango.FontDescription.setVariant`.
    extern fn pango_font_description_get_variant(p_desc: *const FontDescription) pango.Variant;
    pub const getVariant = pango_font_description_get_variant;

    /// Gets the variations field of a font description.
    ///
    /// See `pango.FontDescription.setVariations`.
    extern fn pango_font_description_get_variations(p_desc: *const FontDescription) ?[*:0]const u8;
    pub const getVariations = pango_font_description_get_variations;

    /// Gets the weight field of a font description.
    ///
    /// See `pango.FontDescription.setWeight`.
    extern fn pango_font_description_get_weight(p_desc: *const FontDescription) pango.Weight;
    pub const getWeight = pango_font_description_get_weight;

    /// Computes a hash of a `PangoFontDescription` structure.
    ///
    /// This is suitable to be used, for example, as an argument
    /// to `glib.HashTable.new`. The hash value is independent of `desc`->mask.
    extern fn pango_font_description_hash(p_desc: *const FontDescription) c_uint;
    pub const hash = pango_font_description_hash;

    /// Merges the fields that are set in `desc_to_merge` into the fields in
    /// `desc`.
    ///
    /// If `replace_existing` is `FALSE`, only fields in `desc` that
    /// are not already set are affected. If `TRUE`, then fields that are
    /// already set will be replaced as well.
    ///
    /// If `desc_to_merge` is `NULL`, this function performs nothing.
    extern fn pango_font_description_merge(p_desc: *FontDescription, p_desc_to_merge: ?*const pango.FontDescription, p_replace_existing: c_int) void;
    pub const merge = pango_font_description_merge;

    /// Merges the fields that are set in `desc_to_merge` into the fields in
    /// `desc`, without copying allocated fields.
    ///
    /// This is like `pango.FontDescription.merge`, but only a shallow copy
    /// is made of the family name and other allocated fields. `desc` can only
    /// be used until `desc_to_merge` is modified or freed. This is meant to
    /// be used when the merged font description is only needed temporarily.
    extern fn pango_font_description_merge_static(p_desc: *FontDescription, p_desc_to_merge: *const pango.FontDescription, p_replace_existing: c_int) void;
    pub const mergeStatic = pango_font_description_merge_static;

    /// Sets the size field of a font description, in device units.
    ///
    /// This is mutually exclusive with `pango.FontDescription.setSize`
    /// which sets the font size in points.
    extern fn pango_font_description_set_absolute_size(p_desc: *FontDescription, p_size: f64) void;
    pub const setAbsoluteSize = pango_font_description_set_absolute_size;

    /// Sets the family name field of a font description.
    ///
    /// The family
    /// name represents a family of related font styles, and will
    /// resolve to a particular `PangoFontFamily`. In some uses of
    /// `PangoFontDescription`, it is also possible to use a comma
    /// separated list of family names for this field.
    extern fn pango_font_description_set_family(p_desc: *FontDescription, p_family: [*:0]const u8) void;
    pub const setFamily = pango_font_description_set_family;

    /// Sets the family name field of a font description, without copying the string.
    ///
    /// This is like `pango.FontDescription.setFamily`, except that no
    /// copy of `family` is made. The caller must make sure that the
    /// string passed in stays around until `desc` has been freed or the
    /// name is set again. This function can be used if `family` is a static
    /// string such as a C string literal, or if `desc` is only needed temporarily.
    extern fn pango_font_description_set_family_static(p_desc: *FontDescription, p_family: [*:0]const u8) void;
    pub const setFamilyStatic = pango_font_description_set_family_static;

    /// Sets the features field of a font description.
    ///
    /// OpenType font features allow to enable or disable certain optional
    /// features of a font, such as tabular numbers.
    ///
    /// The format of the features string is comma-separated list of
    /// feature assignments, with each assignment being one of these forms:
    ///
    ///     FEATURE=n
    ///
    /// where FEATURE must be a 4 character tag that identifies and OpenType
    /// feature, and n an integer (depending on the feature, the allowed
    /// values may be 0, 1 or bigger numbers). Unknown features are ignored.
    ///
    /// Note that font features set in this way are enabled for the entire text
    /// that is using the font, which is not appropriate for all OpenType features.
    /// The intended use case is to select character variations (features cv01 - c99),
    /// style sets (ss01 - ss20) and the like.
    ///
    /// Pango does not currently have a way to find supported OpenType features
    /// of a font. Both harfbuzz and freetype have API for this. See for example
    /// [hb_ot_layout_table_get_feature_tags](https://harfbuzz.github.io/harfbuzz-hb-ot-layout.html`hb`-ot-layout-table-get-feature-tags).
    ///
    /// Features that are not supported by the font are silently ignored.
    extern fn pango_font_description_set_features(p_desc: *FontDescription, p_features: ?[*:0]const u8) void;
    pub const setFeatures = pango_font_description_set_features;

    /// Sets the features field of a font description.
    ///
    /// This is like `pango.FontDescription.setFeatures`, except
    /// that no copy of `featuresis` made. The caller must make sure that
    /// the string passed in stays around until `desc` has been freed
    /// or the name is set again. This function can be used if
    /// `features` is a static string such as a C string literal,
    /// or if `desc` is only needed temporarily.
    extern fn pango_font_description_set_features_static(p_desc: *FontDescription, p_features: [*:0]const u8) void;
    pub const setFeaturesStatic = pango_font_description_set_features_static;

    /// Sets the gravity field of a font description.
    ///
    /// The gravity field
    /// specifies how the glyphs should be rotated. If `gravity` is
    /// `PANGO_GRAVITY_AUTO`, this actually unsets the gravity mask on
    /// the font description.
    ///
    /// This function is seldom useful to the user. Gravity should normally
    /// be set on a `PangoContext`.
    extern fn pango_font_description_set_gravity(p_desc: *FontDescription, p_gravity: pango.Gravity) void;
    pub const setGravity = pango_font_description_set_gravity;

    /// Sets the size field of a font description in fractional points.
    ///
    /// This is mutually exclusive with
    /// `pango.FontDescription.setAbsoluteSize`.
    extern fn pango_font_description_set_size(p_desc: *FontDescription, p_size: c_int) void;
    pub const setSize = pango_font_description_set_size;

    /// Sets the stretch field of a font description.
    ///
    /// The `pango.Stretch` field specifies how narrow or
    /// wide the font should be.
    extern fn pango_font_description_set_stretch(p_desc: *FontDescription, p_stretch: pango.Stretch) void;
    pub const setStretch = pango_font_description_set_stretch;

    /// Sets the style field of a `PangoFontDescription`.
    ///
    /// The `pango.Style` enumeration describes whether the font is
    /// slanted and the manner in which it is slanted; it can be either
    /// `PANGO_STYLE_NORMAL`, `PANGO_STYLE_ITALIC`, or `PANGO_STYLE_OBLIQUE`.
    ///
    /// Most fonts will either have a italic style or an oblique style,
    /// but not both, and font matching in Pango will match italic
    /// specifications with oblique fonts and vice-versa if an exact
    /// match is not found.
    extern fn pango_font_description_set_style(p_desc: *FontDescription, p_style: pango.Style) void;
    pub const setStyle = pango_font_description_set_style;

    /// Sets the variant field of a font description.
    ///
    /// The `pango.Variant` can either be `PANGO_VARIANT_NORMAL`
    /// or `PANGO_VARIANT_SMALL_CAPS`.
    extern fn pango_font_description_set_variant(p_desc: *FontDescription, p_variant: pango.Variant) void;
    pub const setVariant = pango_font_description_set_variant;

    /// Sets the variations field of a font description.
    ///
    /// OpenType font variations allow to select a font instance by
    /// specifying values for a number of axes, such as width or weight.
    ///
    /// The format of the variations string is
    ///
    ///     AXIS1=VALUE,AXIS2=VALUE...
    ///
    /// with each AXIS a 4 character tag that identifies a font axis,
    /// and each VALUE a floating point number. Unknown axes are ignored,
    /// and values are clamped to their allowed range.
    ///
    /// Pango does not currently have a way to find supported axes of
    /// a font. Both harfbuzz and freetype have API for this. See
    /// for example [hb_ot_var_get_axis_infos](https://harfbuzz.github.io/harfbuzz-hb-ot-var.html`hb`-ot-var-get-axis-infos).
    extern fn pango_font_description_set_variations(p_desc: *FontDescription, p_variations: ?[*:0]const u8) void;
    pub const setVariations = pango_font_description_set_variations;

    /// Sets the variations field of a font description.
    ///
    /// This is like `pango.FontDescription.setVariations`, except
    /// that no copy of `variations` is made. The caller must make sure that
    /// the string passed in stays around until `desc` has been freed
    /// or the name is set again. This function can be used if
    /// `variations` is a static string such as a C string literal,
    /// or if `desc` is only needed temporarily.
    extern fn pango_font_description_set_variations_static(p_desc: *FontDescription, p_variations: [*:0]const u8) void;
    pub const setVariationsStatic = pango_font_description_set_variations_static;

    /// Sets the weight field of a font description.
    ///
    /// The weight field
    /// specifies how bold or light the font should be. In addition
    /// to the values of the `pango.Weight` enumeration, other
    /// intermediate numeric values are possible.
    extern fn pango_font_description_set_weight(p_desc: *FontDescription, p_weight: pango.Weight) void;
    pub const setWeight = pango_font_description_set_weight;

    /// Creates a filename representation of a font description.
    ///
    /// The filename is identical to the result from calling
    /// `pango.FontDescription.toString`, but with underscores
    /// instead of characters that are untypical in filenames, and in
    /// lower case only.
    extern fn pango_font_description_to_filename(p_desc: *const FontDescription) ?[*:0]u8;
    pub const toFilename = pango_font_description_to_filename;

    /// Creates a string representation of a font description.
    ///
    /// See `pango.FontDescription.fromString` for a description
    /// of the format of the string representation. The family list in
    /// the string description will only have a terminating comma if
    /// the last word of the list is a valid style option.
    extern fn pango_font_description_to_string(p_desc: *const FontDescription) [*:0]u8;
    pub const toString = pango_font_description_to_string;

    /// Unsets some of the fields in a `PangoFontDescription`.
    ///
    /// The unset fields will get back to their default values.
    extern fn pango_font_description_unset_fields(p_desc: *FontDescription, p_to_unset: pango.FontMask) void;
    pub const unsetFields = pango_font_description_unset_fields;

    extern fn pango_font_description_get_type() usize;
    pub const getGObjectType = pango_font_description_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontFaceClass = extern struct {
    pub const Instance = pango.FontFace;

    f_parent_class: gobject.ObjectClass,
    f_get_face_name: ?*const fn (p_face: *pango.FontFace) callconv(.c) [*:0]const u8,
    f_describe: ?*const fn (p_face: *pango.FontFace) callconv(.c) *pango.FontDescription,
    f_list_sizes: ?*const fn (p_face: *pango.FontFace, p_sizes: ?*[*]c_int, p_n_sizes: *c_int) callconv(.c) void,
    f_is_synthesized: ?*const fn (p_face: *pango.FontFace) callconv(.c) c_int,
    f_get_family: ?*const fn (p_face: *pango.FontFace) callconv(.c) *pango.FontFamily,
    f__pango_reserved3: ?*const fn () callconv(.c) void,
    f__pango_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *FontFaceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontFamilyClass = extern struct {
    pub const Instance = pango.FontFamily;

    f_parent_class: gobject.ObjectClass,
    f_list_faces: ?*const fn (p_family: *pango.FontFamily, p_faces: ?*[*]*pango.FontFace, p_n_faces: *c_int) callconv(.c) void,
    f_get_name: ?*const fn (p_family: *pango.FontFamily) callconv(.c) [*:0]const u8,
    f_is_monospace: ?*const fn (p_family: *pango.FontFamily) callconv(.c) c_int,
    f_is_variable: ?*const fn (p_family: *pango.FontFamily) callconv(.c) c_int,
    f_get_face: ?*const fn (p_family: *pango.FontFamily, p_name: ?[*:0]const u8) callconv(.c) ?*pango.FontFace,
    f__pango_reserved2: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *FontFamilyClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoFontMapClass` structure holds the virtual functions for
/// a particular `PangoFontMap` implementation.
pub const FontMapClass = extern struct {
    pub const Instance = pango.FontMap;

    /// parent `GObjectClass`
    f_parent_class: gobject.ObjectClass,
    /// a function to load a font with a given description. See
    /// `pango.FontMap.loadFont`.
    f_load_font: ?*const fn (p_fontmap: *pango.FontMap, p_context: *pango.Context, p_desc: *const pango.FontDescription) callconv(.c) ?*pango.Font,
    /// A function to list available font families. See
    /// `pango.FontMap.listFamilies`.
    f_list_families: ?*const fn (p_fontmap: *pango.FontMap, p_families: *[*]*pango.FontFamily, p_n_families: *c_int) callconv(.c) void,
    /// a function to load a fontset with a given given description
    /// suitable for a particular language. See `pango.FontMap.loadFontset`.
    f_load_fontset: ?*const fn (p_fontmap: *pango.FontMap, p_context: *pango.Context, p_desc: *const pango.FontDescription, p_language: *pango.Language) callconv(.c) ?*pango.Fontset,
    /// the type of rendering-system-dependent engines that
    /// can handle fonts of this fonts loaded with this fontmap.
    f_shape_engine_type: ?[*:0]const u8,
    /// a function to get the serial number of the fontmap.
    /// See `pango.FontMap.getSerial`.
    f_get_serial: ?*const fn (p_fontmap: *pango.FontMap) callconv(.c) c_uint,
    /// See `pango.FontMap.changed`
    f_changed: ?*const fn (p_fontmap: *pango.FontMap) callconv(.c) void,
    f_get_family: ?*const fn (p_fontmap: *pango.FontMap, p_name: [*:0]const u8) callconv(.c) *pango.FontFamily,
    f_get_face: ?*const fn (p_fontmap: *pango.FontMap, p_font: *pango.Font) callconv(.c) *pango.FontFace,

    pub fn as(p_instance: *FontMapClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoFontMetrics` structure holds the overall metric information
/// for a font.
///
/// The information in a `PangoFontMetrics` structure may be restricted
/// to a script. The fields of this structure are private to implementations
/// of a font backend. See the documentation of the corresponding getters
/// for documentation of their meaning.
///
/// For an overview of the most important metrics, see:
///
/// <picture>
///   <source srcset="fontmetrics-dark.png" media="(prefers-color-scheme: dark)">
///   <img alt="Font metrics" src="fontmetrics-light.png">
/// </picture>
pub const FontMetrics = extern struct {
    f_ref_count: c_uint,
    f_ascent: c_int,
    f_descent: c_int,
    f_height: c_int,
    f_approximate_char_width: c_int,
    f_approximate_digit_width: c_int,
    f_underline_position: c_int,
    f_underline_thickness: c_int,
    f_strikethrough_position: c_int,
    f_strikethrough_thickness: c_int,

    /// Gets the approximate character width for a font metrics structure.
    ///
    /// This is merely a representative value useful, for example, for
    /// determining the initial size for a window. Actual characters in
    /// text will be wider and narrower than this.
    extern fn pango_font_metrics_get_approximate_char_width(p_metrics: *FontMetrics) c_int;
    pub const getApproximateCharWidth = pango_font_metrics_get_approximate_char_width;

    /// Gets the approximate digit width for a font metrics structure.
    ///
    /// This is merely a representative value useful, for example, for
    /// determining the initial size for a window. Actual digits in
    /// text can be wider or narrower than this, though this value
    /// is generally somewhat more accurate than the result of
    /// `pango.FontMetrics.getApproximateCharWidth` for digits.
    extern fn pango_font_metrics_get_approximate_digit_width(p_metrics: *FontMetrics) c_int;
    pub const getApproximateDigitWidth = pango_font_metrics_get_approximate_digit_width;

    /// Gets the ascent from a font metrics structure.
    ///
    /// The ascent is the distance from the baseline to the logical top
    /// of a line of text. (The logical top may be above or below the top
    /// of the actual drawn ink. It is necessary to lay out the text to
    /// figure where the ink will be.)
    extern fn pango_font_metrics_get_ascent(p_metrics: *FontMetrics) c_int;
    pub const getAscent = pango_font_metrics_get_ascent;

    /// Gets the descent from a font metrics structure.
    ///
    /// The descent is the distance from the baseline to the logical bottom
    /// of a line of text. (The logical bottom may be above or below the
    /// bottom of the actual drawn ink. It is necessary to lay out the text
    /// to figure where the ink will be.)
    extern fn pango_font_metrics_get_descent(p_metrics: *FontMetrics) c_int;
    pub const getDescent = pango_font_metrics_get_descent;

    /// Gets the line height from a font metrics structure.
    ///
    /// The line height is the recommended distance between successive
    /// baselines in wrapped text using this font.
    ///
    /// If the line height is not available, 0 is returned.
    extern fn pango_font_metrics_get_height(p_metrics: *FontMetrics) c_int;
    pub const getHeight = pango_font_metrics_get_height;

    /// Gets the suggested position to draw the strikethrough.
    ///
    /// The value returned is the distance *above* the
    /// baseline of the top of the strikethrough.
    extern fn pango_font_metrics_get_strikethrough_position(p_metrics: *FontMetrics) c_int;
    pub const getStrikethroughPosition = pango_font_metrics_get_strikethrough_position;

    /// Gets the suggested thickness to draw for the strikethrough.
    extern fn pango_font_metrics_get_strikethrough_thickness(p_metrics: *FontMetrics) c_int;
    pub const getStrikethroughThickness = pango_font_metrics_get_strikethrough_thickness;

    /// Gets the suggested position to draw the underline.
    ///
    /// The value returned is the distance *above* the baseline of the top
    /// of the underline. Since most fonts have underline positions beneath
    /// the baseline, this value is typically negative.
    extern fn pango_font_metrics_get_underline_position(p_metrics: *FontMetrics) c_int;
    pub const getUnderlinePosition = pango_font_metrics_get_underline_position;

    /// Gets the suggested thickness to draw for the underline.
    extern fn pango_font_metrics_get_underline_thickness(p_metrics: *FontMetrics) c_int;
    pub const getUnderlineThickness = pango_font_metrics_get_underline_thickness;

    /// Increase the reference count of a font metrics structure by one.
    extern fn pango_font_metrics_ref(p_metrics: ?*FontMetrics) ?*pango.FontMetrics;
    pub const ref = pango_font_metrics_ref;

    /// Decrease the reference count of a font metrics structure by one.
    ///
    /// If the result is zero, frees the structure and any associated memory.
    extern fn pango_font_metrics_unref(p_metrics: ?*FontMetrics) void;
    pub const unref = pango_font_metrics_unref;

    extern fn pango_font_metrics_get_type() usize;
    pub const getGObjectType = pango_font_metrics_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoFontsetClass` structure holds the virtual functions for
/// a particular `PangoFontset` implementation.
pub const FontsetClass = extern struct {
    pub const Instance = pango.Fontset;

    /// parent `GObjectClass`
    f_parent_class: gobject.ObjectClass,
    /// a function to get the font in the fontset that contains the
    ///   best glyph for the given Unicode character; see `pango.Fontset.getFont`
    f_get_font: ?*const fn (p_fontset: *pango.Fontset, p_wc: c_uint) callconv(.c) *pango.Font,
    /// a function to get overall metric information for the fonts
    ///   in the fontset; see `pango.Fontset.getMetrics`
    f_get_metrics: ?*const fn (p_fontset: *pango.Fontset) callconv(.c) *pango.FontMetrics,
    /// a function to get the language of the fontset.
    f_get_language: ?*const fn (p_fontset: *pango.Fontset) callconv(.c) *pango.Language,
    /// a function to loop over the fonts in the fontset. See
    ///   `pango.Fontset.foreach`
    f_foreach: ?*const fn (p_fontset: *pango.Fontset, p_func: pango.FontsetForeachFunc, p_data: ?*anyopaque) callconv(.c) void,
    f__pango_reserved1: ?*const fn () callconv(.c) void,
    f__pango_reserved2: ?*const fn () callconv(.c) void,
    f__pango_reserved3: ?*const fn () callconv(.c) void,
    f__pango_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *FontsetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontsetSimpleClass = opaque {
    pub const Instance = pango.FontsetSimple;

    pub fn as(p_instance: *FontsetSimpleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoGlyphGeometry` structure contains width and positioning
/// information for a single glyph.
///
/// Note that `width` is not guaranteed to be the same as the glyph
/// extents. Kerning and other positioning applied during shaping will
/// affect both the `width` and the `x_offset` for the glyphs in the
/// glyph string that results from shaping.
///
/// The information in this struct is intended for rendering the glyphs,
/// as follows:
///
/// 1. Assume the current point is (x, y)
/// 2. Render the current glyph at (x + x_offset, y + y_offset),
/// 3. Advance the current point to (x + width, y)
/// 4. Render the next glyph
pub const GlyphGeometry = extern struct {
    /// the logical width to use for the the character.
    f_width: pango.GlyphUnit,
    /// horizontal offset from nominal character position.
    f_x_offset: pango.GlyphUnit,
    /// vertical offset from nominal character position.
    f_y_offset: pango.GlyphUnit,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoGlyphInfo` structure represents a single glyph with
/// positioning information and visual attributes.
pub const GlyphInfo = extern struct {
    /// the glyph itself.
    f_glyph: pango.Glyph,
    /// the positional information about the glyph.
    f_geometry: pango.GlyphGeometry,
    /// the visual attributes of the glyph.
    f_attr: pango.GlyphVisAttr,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoGlyphItem` is a pair of a `PangoItem` and the glyphs
/// resulting from shaping the items text.
///
/// As an example of the usage of `PangoGlyphItem`, the results
/// of shaping text with `PangoLayout` is a list of `PangoLayoutLine`,
/// each of which contains a list of `PangoGlyphItem`.
pub const GlyphItem = extern struct {
    /// corresponding `PangoItem`
    f_item: ?*pango.Item,
    /// corresponding `PangoGlyphString`
    f_glyphs: ?*pango.GlyphString,
    /// shift of the baseline, relative to the baseline
    ///   of the containing line. Positive values shift upwards
    f_y_offset: c_int,
    /// horizontal displacement to apply before the
    ///   glyph item. Positive values shift right
    f_start_x_offset: c_int,
    /// horizontal displacement to apply after th
    ///   glyph item. Positive values shift right
    f_end_x_offset: c_int,

    /// Splits a shaped item (`PangoGlyphItem`) into multiple items based
    /// on an attribute list.
    ///
    /// The idea is that if you have attributes that don't affect shaping,
    /// such as color or underline, to avoid affecting shaping, you filter
    /// them out (`pango.AttrList.filter`), apply the shaping process
    /// and then reapply them to the result using this function.
    ///
    /// All attributes that start or end inside a cluster are applied
    /// to that cluster; for instance, if half of a cluster is underlined
    /// and the other-half strikethrough, then the cluster will end
    /// up with both underline and strikethrough attributes. In these
    /// cases, it may happen that `item`->extra_attrs for some of the
    /// result items can have multiple attributes of the same type.
    ///
    /// This function takes ownership of `glyph_item`; it will be reused
    /// as one of the elements in the list.
    extern fn pango_glyph_item_apply_attrs(p_glyph_item: *GlyphItem, p_text: [*:0]const u8, p_list: *pango.AttrList) *glib.SList;
    pub const applyAttrs = pango_glyph_item_apply_attrs;

    /// Make a deep copy of an existing `PangoGlyphItem` structure.
    extern fn pango_glyph_item_copy(p_orig: ?*GlyphItem) ?*pango.GlyphItem;
    pub const copy = pango_glyph_item_copy;

    /// Frees a `PangoGlyphItem` and resources to which it points.
    extern fn pango_glyph_item_free(p_glyph_item: ?*GlyphItem) void;
    pub const free = pango_glyph_item_free;

    /// Given a `PangoGlyphItem` and the corresponding text, determine the
    /// width corresponding to each character.
    ///
    /// When multiple characters compose a single cluster, the width of the
    /// entire cluster is divided equally among the characters.
    ///
    /// See also `pango.GlyphString.getLogicalWidths`.
    extern fn pango_glyph_item_get_logical_widths(p_glyph_item: *GlyphItem, p_text: [*:0]const u8, p_logical_widths: *[*]c_int) void;
    pub const getLogicalWidths = pango_glyph_item_get_logical_widths;

    /// Adds spacing between the graphemes of `glyph_item` to
    /// give the effect of typographic letter spacing.
    extern fn pango_glyph_item_letter_space(p_glyph_item: *GlyphItem, p_text: [*:0]const u8, p_log_attrs: [*]pango.LogAttr, p_letter_spacing: c_int) void;
    pub const letterSpace = pango_glyph_item_letter_space;

    /// Modifies `orig` to cover only the text after `split_index`, and
    /// returns a new item that covers the text before `split_index` that
    /// used to be in `orig`.
    ///
    /// You can think of `split_index` as the length of the returned item.
    /// `split_index` may not be 0, and it may not be greater than or equal
    /// to the length of `orig` (that is, there must be at least one byte
    /// assigned to each item, you can't create a zero-length item).
    ///
    /// This function is similar in function to `pango.Item.split` (and uses
    /// it internally.)
    extern fn pango_glyph_item_split(p_orig: *GlyphItem, p_text: [*:0]const u8, p_split_index: c_int) ?*pango.GlyphItem;
    pub const split = pango_glyph_item_split;

    extern fn pango_glyph_item_get_type() usize;
    pub const getGObjectType = pango_glyph_item_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoGlyphItemIter` is an iterator over the clusters in a
/// `PangoGlyphItem`.
///
/// The *forward direction* of the iterator is the logical direction of text.
/// That is, with increasing `start_index` and `start_char` values. If `glyph_item`
/// is right-to-left (that is, if `glyph_item->item->analysis.level` is odd),
/// then `start_glyph` decreases as the iterator moves forward.  Moreover,
/// in right-to-left cases, `start_glyph` is greater than `end_glyph`.
///
/// An iterator should be initialized using either
/// `pango.GlyphItemIter.initStart` or
/// `pango.GlyphItemIter.initEnd`, for forward and backward iteration
/// respectively, and walked over using any desired mixture of
/// `pango.GlyphItemIter.nextCluster` and
/// `pango.GlyphItemIter.prevCluster`.
///
/// A common idiom for doing a forward iteration over the clusters is:
///
/// ```
/// PangoGlyphItemIter cluster_iter;
/// gboolean have_cluster;
///
/// for (have_cluster = pango_glyph_item_iter_init_start (&cluster_iter,
///                                                       glyph_item, text);
///      have_cluster;
///      have_cluster = pango_glyph_item_iter_next_cluster (&cluster_iter))
/// {
///   ...
/// }
/// ```
///
/// Note that `text` is the start of the text for layout, which is then
/// indexed by `glyph_item->item->offset` to get to the text of `glyph_item`.
/// The `start_index` and `end_index` values can directly index into `text`. The
/// `start_glyph`, `end_glyph`, `start_char`, and `end_char` values however are
/// zero-based for the `glyph_item`.  For each cluster, the item pointed at by
/// the start variables is included in the cluster while the one pointed at by
/// end variables is not.
///
/// None of the members of a `PangoGlyphItemIter` should be modified manually.
pub const GlyphItemIter = extern struct {
    f_glyph_item: ?*pango.GlyphItem,
    f_text: ?[*:0]const u8,
    f_start_glyph: c_int,
    f_start_index: c_int,
    f_start_char: c_int,
    f_end_glyph: c_int,
    f_end_index: c_int,
    f_end_char: c_int,

    /// Make a shallow copy of an existing `PangoGlyphItemIter` structure.
    extern fn pango_glyph_item_iter_copy(p_orig: ?*GlyphItemIter) ?*pango.GlyphItemIter;
    pub const copy = pango_glyph_item_iter_copy;

    /// Frees a `PangoGlyphItem`Iter.
    extern fn pango_glyph_item_iter_free(p_iter: ?*GlyphItemIter) void;
    pub const free = pango_glyph_item_iter_free;

    /// Initializes a `PangoGlyphItemIter` structure to point to the
    /// last cluster in a glyph item.
    ///
    /// See `PangoGlyphItemIter` for details of cluster orders.
    extern fn pango_glyph_item_iter_init_end(p_iter: *GlyphItemIter, p_glyph_item: *pango.GlyphItem, p_text: [*:0]const u8) c_int;
    pub const initEnd = pango_glyph_item_iter_init_end;

    /// Initializes a `PangoGlyphItemIter` structure to point to the
    /// first cluster in a glyph item.
    ///
    /// See `PangoGlyphItemIter` for details of cluster orders.
    extern fn pango_glyph_item_iter_init_start(p_iter: *GlyphItemIter, p_glyph_item: *pango.GlyphItem, p_text: [*:0]const u8) c_int;
    pub const initStart = pango_glyph_item_iter_init_start;

    /// Advances the iterator to the next cluster in the glyph item.
    ///
    /// See `PangoGlyphItemIter` for details of cluster orders.
    extern fn pango_glyph_item_iter_next_cluster(p_iter: *GlyphItemIter) c_int;
    pub const nextCluster = pango_glyph_item_iter_next_cluster;

    /// Moves the iterator to the preceding cluster in the glyph item.
    /// See `PangoGlyphItemIter` for details of cluster orders.
    extern fn pango_glyph_item_iter_prev_cluster(p_iter: *GlyphItemIter) c_int;
    pub const prevCluster = pango_glyph_item_iter_prev_cluster;

    extern fn pango_glyph_item_iter_get_type() usize;
    pub const getGObjectType = pango_glyph_item_iter_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoGlyphString` is used to store strings of glyphs with geometry
/// and visual attribute information.
///
/// The storage for the glyph information is owned by the structure
/// which simplifies memory management.
pub const GlyphString = extern struct {
    /// number of glyphs in this glyph string
    f_num_glyphs: c_int,
    /// array of glyph information
    f_glyphs: ?[*]pango.GlyphInfo,
    /// logical cluster info, indexed by the byte index
    ///   within the text corresponding to the glyph string
    f_log_clusters: ?*c_int,
    f_space: c_int,

    /// Create a new `PangoGlyphString`.
    extern fn pango_glyph_string_new() *pango.GlyphString;
    pub const new = pango_glyph_string_new;

    /// Copy a glyph string and associated storage.
    extern fn pango_glyph_string_copy(p_string: ?*GlyphString) ?*pango.GlyphString;
    pub const copy = pango_glyph_string_copy;

    /// Compute the logical and ink extents of a glyph string.
    ///
    /// See the documentation for `pango.Font.getGlyphExtents` for details
    /// about the interpretation of the rectangles.
    ///
    /// Examples of logical (red) and ink (green) rects:
    ///
    /// ![](rects1.png) ![](rects2.png)
    extern fn pango_glyph_string_extents(p_glyphs: *GlyphString, p_font: *pango.Font, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const extents = pango_glyph_string_extents;

    /// Computes the extents of a sub-portion of a glyph string.
    ///
    /// The extents are relative to the start of the glyph string range
    /// (the origin of their coordinate system is at the start of the range,
    /// not at the start of the entire glyph string).
    extern fn pango_glyph_string_extents_range(p_glyphs: *GlyphString, p_start: c_int, p_end: c_int, p_font: *pango.Font, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const extentsRange = pango_glyph_string_extents_range;

    /// Free a glyph string and associated storage.
    extern fn pango_glyph_string_free(p_string: ?*GlyphString) void;
    pub const free = pango_glyph_string_free;

    /// Given a `PangoGlyphString` and corresponding text, determine the width
    /// corresponding to each character.
    ///
    /// When multiple characters compose a single cluster, the width of the
    /// entire cluster is divided equally among the characters.
    ///
    /// See also `pango.GlyphItem.getLogicalWidths`.
    extern fn pango_glyph_string_get_logical_widths(p_glyphs: *GlyphString, p_text: [*:0]const u8, p_length: c_int, p_embedding_level: c_int, p_logical_widths: *[*]c_int) void;
    pub const getLogicalWidths = pango_glyph_string_get_logical_widths;

    /// Computes the logical width of the glyph string.
    ///
    /// This can also be computed using `pango.GlyphString.extents`.
    /// However, since this only computes the width, it's much faster. This
    /// is in fact only a convenience function that computes the sum of
    /// `geometry`.width for each glyph in the `glyphs`.
    extern fn pango_glyph_string_get_width(p_glyphs: *GlyphString) c_int;
    pub const getWidth = pango_glyph_string_get_width;

    /// Converts from character position to x position.
    ///
    /// The X position is measured from the left edge of the run.
    /// Character positions are obtained using font metrics for ligatures
    /// where available, and computed by dividing up each cluster
    /// into equal portions, otherwise.
    ///
    /// <picture>
    ///   <source srcset="glyphstring-positions-dark.png" media="(prefers-color-scheme: dark)">
    ///   <img alt="Glyph positions" src="glyphstring-positions-light.png">
    /// </picture>
    extern fn pango_glyph_string_index_to_x(p_glyphs: *GlyphString, p_text: [*:0]const u8, p_length: c_int, p_analysis: *pango.Analysis, p_index_: c_int, p_trailing: c_int, p_x_pos: ?*c_int) void;
    pub const indexToX = pango_glyph_string_index_to_x;

    /// Converts from character position to x position.
    ///
    /// This variant of `pango.GlyphString.indexToX` additionally
    /// accepts a `PangoLogAttr` array. The grapheme boundary information
    /// in it can be used to disambiguate positioning inside some complex
    /// clusters.
    extern fn pango_glyph_string_index_to_x_full(p_glyphs: *GlyphString, p_text: [*:0]const u8, p_length: c_int, p_analysis: *pango.Analysis, p_attrs: ?*pango.LogAttr, p_index_: c_int, p_trailing: c_int, p_x_pos: ?*c_int) void;
    pub const indexToXFull = pango_glyph_string_index_to_x_full;

    /// Resize a glyph string to the given length.
    extern fn pango_glyph_string_set_size(p_string: *GlyphString, p_new_len: c_int) void;
    pub const setSize = pango_glyph_string_set_size;

    /// Convert from x offset to character position.
    ///
    /// Character positions are computed by dividing up each cluster into
    /// equal portions. In scripts where positioning within a cluster is
    /// not allowed (such as Thai), the returned value may not be a valid
    /// cursor position; the caller must combine the result with the logical
    /// attributes for the text to compute the valid cursor position.
    extern fn pango_glyph_string_x_to_index(p_glyphs: *GlyphString, p_text: [*:0]const u8, p_length: c_int, p_analysis: *pango.Analysis, p_x_pos: c_int, p_index_: ?*c_int, p_trailing: ?*c_int) void;
    pub const xToIndex = pango_glyph_string_x_to_index;

    extern fn pango_glyph_string_get_type() usize;
    pub const getGObjectType = pango_glyph_string_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoGlyphVisAttr` structure communicates information between
/// the shaping and rendering phases.
///
/// Currently, it contains cluster start and color information.
/// More attributes may be added in the future.
///
/// Clusters are stored in visual order, within the cluster, glyphs
/// are always ordered in logical order, since visual order is meaningless;
/// that is, in Arabic text, accent glyphs follow the glyphs for the
/// base character.
pub const GlyphVisAttr = extern struct {
    bitfields0: packed struct(c_uint) {
        /// set for the first logical glyph in each cluster.
        f_is_cluster_start: u1,
        /// set if the the font will render this glyph with color. Since 1.50
        f_is_color: u1,
        _: u30,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoItem` structure stores information about a segment of text.
///
/// You typically obtain `PangoItems` by itemizing a piece of text
/// with `itemize`.
pub const Item = extern struct {
    /// byte offset of the start of this item in text.
    f_offset: c_int,
    /// length of this item in bytes.
    f_length: c_int,
    /// number of Unicode characters in the item.
    f_num_chars: c_int,
    /// analysis results for the item.
    f_analysis: pango.Analysis,

    /// Creates a new `PangoItem` structure initialized to default values.
    extern fn pango_item_new() *pango.Item;
    pub const new = pango_item_new;

    /// Add attributes to a `PangoItem`.
    ///
    /// The idea is that you have attributes that don't affect itemization,
    /// such as font features, so you filter them out using
    /// `pango.AttrList.filter`, itemize your text, then reapply the
    /// attributes to the resulting items using this function.
    ///
    /// The `iter` should be positioned before the range of the item,
    /// and will be advanced past it. This function is meant to be called
    /// in a loop over the items resulting from itemization, while passing
    /// the iter to each call.
    extern fn pango_item_apply_attrs(p_item: *Item, p_iter: *pango.AttrIterator) void;
    pub const applyAttrs = pango_item_apply_attrs;

    /// Copy an existing `PangoItem` structure.
    extern fn pango_item_copy(p_item: ?*Item) ?*pango.Item;
    pub const copy = pango_item_copy;

    /// Free a `PangoItem` and all associated memory.
    extern fn pango_item_free(p_item: ?*Item) void;
    pub const free = pango_item_free;

    /// Returns the character offset of the item from the beginning
    /// of the itemized text.
    ///
    /// If the item has not been obtained from Pango's itemization
    /// machinery, then the character offset is not available. In
    /// that case, this function returns -1.
    extern fn pango_item_get_char_offset(p_item: *Item) c_int;
    pub const getCharOffset = pango_item_get_char_offset;

    /// Modifies `orig` to cover only the text after `split_index`, and
    /// returns a new item that covers the text before `split_index` that
    /// used to be in `orig`.
    ///
    /// You can think of `split_index` as the length of the returned item.
    /// `split_index` may not be 0, and it may not be greater than or equal
    /// to the length of `orig` (that is, there must be at least one byte
    /// assigned to each item, you can't create a zero-length item).
    /// `split_offset` is the length of the first item in chars, and must be
    /// provided because the text used to generate the item isn't available,
    /// so ``pango.Item.split`` can't count the char length of the split items
    /// itself.
    extern fn pango_item_split(p_orig: *Item, p_split_index: c_int, p_split_offset: c_int) *pango.Item;
    pub const split = pango_item_split;

    extern fn pango_item_get_type() usize;
    pub const getGObjectType = pango_item_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoLanguage` structure is used to
/// represent a language.
///
/// `PangoLanguage` pointers can be efficiently
/// copied and compared with each other.
pub const Language = opaque {
    /// Convert a language tag to a `PangoLanguage`.
    ///
    /// The language tag must be in a RFC-3066 format. `PangoLanguage` pointers
    /// can be efficiently copied (copy the pointer) and compared with other
    /// language tags (compare the pointer.)
    ///
    /// This function first canonicalizes the string by converting it to
    /// lowercase, mapping '_' to '-', and stripping all characters other
    /// than letters and '-'.
    ///
    /// Use `pango.Language.getDefault` if you want to get the
    /// `PangoLanguage` for the current locale of the process.
    extern fn pango_language_from_string(p_language: ?[*:0]const u8) ?*pango.Language;
    pub const fromString = pango_language_from_string;

    /// Returns the `PangoLanguage` for the current locale of the process.
    ///
    /// On Unix systems, this is the return value is derived from
    /// `setlocale (LC_CTYPE, NULL)`, and the user can
    /// affect this through the environment variables LC_ALL, LC_CTYPE or
    /// LANG (checked in that order). The locale string typically is in
    /// the form lang_COUNTRY, where lang is an ISO-639 language code, and
    /// COUNTRY is an ISO-3166 country code. For instance, sv_FI for
    /// Swedish as written in Finland or pt_BR for Portuguese as written in
    /// Brazil.
    ///
    /// On Windows, the C library does not use any such environment
    /// variables, and setting them won't affect the behavior of functions
    /// like `ctime`. The user sets the locale through the Regional Options
    /// in the Control Panel. The C library (in the `setlocale` function)
    /// does not use country and language codes, but country and language
    /// names spelled out in English.
    /// However, this function does check the above environment
    /// variables, and does return a Unix-style locale string based on
    /// either said environment variables or the thread's current locale.
    ///
    /// Your application should call `setlocale(LC_ALL, "")` for the user
    /// settings to take effect. GTK does this in its initialization
    /// functions automatically (by calling `gtk_set_locale`).
    /// See the `setlocale` manpage for more details.
    ///
    /// Note that the default language can change over the life of an application.
    ///
    /// Also note that this function will not do the right thing if you
    /// use per-thread locales with `uselocale`. In that case, you should
    /// just call `pango.languageFromString` yourself.
    extern fn pango_language_get_default() *pango.Language;
    pub const getDefault = pango_language_get_default;

    /// Returns the list of languages that the user prefers.
    ///
    /// The list is specified by the `PANGO_LANGUAGE` or `LANGUAGE`
    /// environment variables, in order of preference. Note that this
    /// list does not necessarily include the language returned by
    /// `pango.Language.getDefault`.
    ///
    /// When choosing language-specific resources, such as the sample
    /// text returned by `pango.Language.getSampleString`,
    /// you should first try the default language, followed by the
    /// languages returned by this function.
    extern fn pango_language_get_preferred() ?[*]*pango.Language;
    pub const getPreferred = pango_language_get_preferred;

    /// Get a string that is representative of the characters needed to
    /// render a particular language.
    ///
    /// The sample text may be a pangram, but is not necessarily. It is chosen
    /// to be demonstrative of normal text in the language, as well as exposing
    /// font feature requirements unique to the language. It is suitable for use
    /// as sample text in a font selection dialog.
    ///
    /// If `language` is `NULL`, the default language as found by
    /// `pango.Language.getDefault` is used.
    ///
    /// If Pango does not have a sample string for `language`, the classic
    /// "The quick brown fox..." is returned.  This can be detected by
    /// comparing the returned pointer value to that returned for (non-existent)
    /// language code "xx".  That is, compare to:
    ///
    /// ```
    /// pango_language_get_sample_string (pango_language_from_string ("xx"))
    /// ```
    extern fn pango_language_get_sample_string(p_language: ?*Language) [*:0]const u8;
    pub const getSampleString = pango_language_get_sample_string;

    /// Determines the scripts used to to write `language`.
    ///
    /// If nothing is known about the language tag `language`,
    /// or if `language` is `NULL`, then `NULL` is returned.
    /// The list of scripts returned starts with the script that the
    /// language uses most and continues to the one it uses least.
    ///
    /// The value `num_script` points at will be set to the number
    /// of scripts in the returned array (or zero if `NULL` is returned).
    ///
    /// Most languages use only one script for writing, but there are
    /// some that use two (Latin and Cyrillic for example), and a few
    /// use three (Japanese for example). Applications should not make
    /// any assumptions on the maximum number of scripts returned
    /// though, except that it is positive if the return value is not
    /// `NULL`, and it is a small number.
    ///
    /// The `pango.Language.includesScript` function uses this
    /// function internally.
    ///
    /// Note: while the return value is declared as `PangoScript`, the
    /// returned values are from the `GUnicodeScript` enumeration, which
    /// may have more values. Callers need to handle unknown values.
    extern fn pango_language_get_scripts(p_language: ?*Language, p_num_scripts: ?*c_int) ?[*]const pango.Script;
    pub const getScripts = pango_language_get_scripts;

    /// Determines if `script` is one of the scripts used to
    /// write `language`.
    ///
    /// The returned value is conservative; if nothing is known about
    /// the language tag `language`, `TRUE` will be returned, since, as
    /// far as Pango knows, `script` might be used to write `language`.
    ///
    /// This routine is used in Pango's itemization process when
    /// determining if a supplied language tag is relevant to
    /// a particular section of text. It probably is not useful
    /// for applications in most circumstances.
    ///
    /// This function uses `pango.Language.getScripts` internally.
    extern fn pango_language_includes_script(p_language: ?*Language, p_script: pango.Script) c_int;
    pub const includesScript = pango_language_includes_script;

    /// Checks if a language tag matches one of the elements in a list of
    /// language ranges.
    ///
    /// A language tag is considered to match a range in the list if the
    /// range is '*', the range is exactly the tag, or the range is a prefix
    /// of the tag, and the character after it in the tag is '-'.
    extern fn pango_language_matches(p_language: ?*Language, p_range_list: [*:0]const u8) c_int;
    pub const matches = pango_language_matches;

    /// Gets the RFC-3066 format string representing the given language tag.
    ///
    /// Returns (transfer none): a string representing the language tag
    extern fn pango_language_to_string(p_language: *Language) [*:0]const u8;
    pub const toString = pango_language_to_string;

    extern fn pango_language_get_type() usize;
    pub const getGObjectType = pango_language_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayoutClass = opaque {
    pub const Instance = pango.Layout;

    pub fn as(p_instance: *LayoutClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoLayoutIter` can be used to iterate over the visual
/// extents of a `PangoLayout`.
///
/// To obtain a `PangoLayoutIter`, use `pango.Layout.getIter`.
///
/// The `PangoLayoutIter` structure is opaque, and has no user-visible fields.
pub const LayoutIter = opaque {
    /// Determines whether `iter` is on the last line of the layout.
    extern fn pango_layout_iter_at_last_line(p_iter: *LayoutIter) c_int;
    pub const atLastLine = pango_layout_iter_at_last_line;

    /// Copies a `PangoLayoutIter`.
    extern fn pango_layout_iter_copy(p_iter: ?*LayoutIter) ?*pango.LayoutIter;
    pub const copy = pango_layout_iter_copy;

    /// Frees an iterator that's no longer in use.
    extern fn pango_layout_iter_free(p_iter: ?*LayoutIter) void;
    pub const free = pango_layout_iter_free;

    /// Gets the Y position of the current line's baseline, in layout
    /// coordinates.
    ///
    /// Layout coordinates have the origin at the top left of the entire layout.
    extern fn pango_layout_iter_get_baseline(p_iter: *LayoutIter) c_int;
    pub const getBaseline = pango_layout_iter_get_baseline;

    /// Gets the extents of the current character, in layout coordinates.
    ///
    /// Layout coordinates have the origin at the top left of the entire layout.
    ///
    /// Only logical extents can sensibly be obtained for characters;
    /// ink extents make sense only down to the level of clusters.
    extern fn pango_layout_iter_get_char_extents(p_iter: *LayoutIter, p_logical_rect: *pango.Rectangle) void;
    pub const getCharExtents = pango_layout_iter_get_char_extents;

    /// Gets the extents of the current cluster, in layout coordinates.
    ///
    /// Layout coordinates have the origin at the top left of the entire layout.
    extern fn pango_layout_iter_get_cluster_extents(p_iter: *LayoutIter, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getClusterExtents = pango_layout_iter_get_cluster_extents;

    /// Gets the current byte index.
    ///
    /// Note that iterating forward by char moves in visual order,
    /// not logical order, so indexes may not be sequential. Also,
    /// the index may be equal to the length of the text in the
    /// layout, if on the `NULL` run (see `pango.LayoutIter.getRun`).
    extern fn pango_layout_iter_get_index(p_iter: *LayoutIter) c_int;
    pub const getIndex = pango_layout_iter_get_index;

    /// Gets the layout associated with a `PangoLayoutIter`.
    extern fn pango_layout_iter_get_layout(p_iter: *LayoutIter) ?*pango.Layout;
    pub const getLayout = pango_layout_iter_get_layout;

    /// Obtains the extents of the `PangoLayout` being iterated over.
    extern fn pango_layout_iter_get_layout_extents(p_iter: *LayoutIter, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getLayoutExtents = pango_layout_iter_get_layout_extents;

    /// Gets the current line.
    ///
    /// Use the faster `pango.LayoutIter.getLineReadonly` if
    /// you do not plan to modify the contents of the line (glyphs,
    /// glyph widths, etc.).
    extern fn pango_layout_iter_get_line(p_iter: *LayoutIter) ?*pango.LayoutLine;
    pub const getLine = pango_layout_iter_get_line;

    /// Obtains the extents of the current line.
    ///
    /// Extents are in layout coordinates (origin is the top-left corner
    /// of the entire `PangoLayout`). Thus the extents returned by this
    /// function will be the same width/height but not at the same x/y
    /// as the extents returned from `pango.LayoutLine.getExtents`.
    extern fn pango_layout_iter_get_line_extents(p_iter: *LayoutIter, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getLineExtents = pango_layout_iter_get_line_extents;

    /// Gets the current line for read-only access.
    ///
    /// This is a faster alternative to `pango.LayoutIter.getLine`,
    /// but the user is not expected to modify the contents of the line
    /// (glyphs, glyph widths, etc.).
    extern fn pango_layout_iter_get_line_readonly(p_iter: *LayoutIter) ?*pango.LayoutLine;
    pub const getLineReadonly = pango_layout_iter_get_line_readonly;

    /// Divides the vertical space in the `PangoLayout` being iterated over
    /// between the lines in the layout, and returns the space belonging to
    /// the current line.
    ///
    /// A line's range includes the line's logical extents. plus half of the
    /// spacing above and below the line, if `pango.Layout.setSpacing`
    /// has been called to set layout spacing. The Y positions are in layout
    /// coordinates (origin at top left of the entire layout).
    ///
    /// Note: Since 1.44, Pango uses line heights for placing lines, and there
    /// may be gaps between the ranges returned by this function.
    extern fn pango_layout_iter_get_line_yrange(p_iter: *LayoutIter, p_y0_: ?*c_int, p_y1_: ?*c_int) void;
    pub const getLineYrange = pango_layout_iter_get_line_yrange;

    /// Gets the current run.
    ///
    /// When iterating by run, at the end of each line, there's a position
    /// with a `NULL` run, so this function can return `NULL`. The `NULL` run
    /// at the end of each line ensures that all lines have at least one run,
    /// even lines consisting of only a newline.
    ///
    /// Use the faster `pango.LayoutIter.getRunReadonly` if you do not
    /// plan to modify the contents of the run (glyphs, glyph widths, etc.).
    extern fn pango_layout_iter_get_run(p_iter: *LayoutIter) ?*pango.LayoutRun;
    pub const getRun = pango_layout_iter_get_run;

    /// Gets the Y position of the current run's baseline, in layout
    /// coordinates.
    ///
    /// Layout coordinates have the origin at the top left of the entire layout.
    ///
    /// The run baseline can be different from the line baseline, for
    /// example due to superscript or subscript positioning.
    extern fn pango_layout_iter_get_run_baseline(p_iter: *LayoutIter) c_int;
    pub const getRunBaseline = pango_layout_iter_get_run_baseline;

    /// Gets the extents of the current run in layout coordinates.
    ///
    /// Layout coordinates have the origin at the top left of the entire layout.
    extern fn pango_layout_iter_get_run_extents(p_iter: *LayoutIter, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getRunExtents = pango_layout_iter_get_run_extents;

    /// Gets the current run for read-only access.
    ///
    /// When iterating by run, at the end of each line, there's a position
    /// with a `NULL` run, so this function can return `NULL`. The `NULL` run
    /// at the end of each line ensures that all lines have at least one run,
    /// even lines consisting of only a newline.
    ///
    /// This is a faster alternative to `pango.LayoutIter.getRun`,
    /// but the user is not expected to modify the contents of the run (glyphs,
    /// glyph widths, etc.).
    extern fn pango_layout_iter_get_run_readonly(p_iter: *LayoutIter) ?*pango.LayoutRun;
    pub const getRunReadonly = pango_layout_iter_get_run_readonly;

    /// Moves `iter` forward to the next character in visual order.
    ///
    /// If `iter` was already at the end of the layout, returns `FALSE`.
    extern fn pango_layout_iter_next_char(p_iter: *LayoutIter) c_int;
    pub const nextChar = pango_layout_iter_next_char;

    /// Moves `iter` forward to the next cluster in visual order.
    ///
    /// If `iter` was already at the end of the layout, returns `FALSE`.
    extern fn pango_layout_iter_next_cluster(p_iter: *LayoutIter) c_int;
    pub const nextCluster = pango_layout_iter_next_cluster;

    /// Moves `iter` forward to the start of the next line.
    ///
    /// If `iter` is already on the last line, returns `FALSE`.
    extern fn pango_layout_iter_next_line(p_iter: *LayoutIter) c_int;
    pub const nextLine = pango_layout_iter_next_line;

    /// Moves `iter` forward to the next run in visual order.
    ///
    /// If `iter` was already at the end of the layout, returns `FALSE`.
    extern fn pango_layout_iter_next_run(p_iter: *LayoutIter) c_int;
    pub const nextRun = pango_layout_iter_next_run;

    extern fn pango_layout_iter_get_type() usize;
    pub const getGObjectType = pango_layout_iter_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoLayoutLine` represents one of the lines resulting from laying
/// out a paragraph via `PangoLayout`.
///
/// `PangoLayoutLine` structures are obtained by calling
/// `pango.Layout.getLine` and are only valid until the text,
/// attributes, or settings of the parent `PangoLayout` are modified.
pub const LayoutLine = extern struct {
    /// the layout this line belongs to, might be `NULL`
    f_layout: ?*pango.Layout,
    /// start of line as byte index into layout->text
    f_start_index: c_int,
    /// length of line in bytes
    f_length: c_int,
    /// list of runs in the
    ///   line, from left to right
    f_runs: ?*glib.SList,
    bitfields0: packed struct(c_uint) {
        /// `TRUE` if this is the first line of the paragraph
        f_is_paragraph_start: u1,
        /// `Resolved` PangoDirection of line
        f_resolved_dir: u3,
        _: u28,
    },

    /// Computes the logical and ink extents of a layout line.
    ///
    /// See `pango.Font.getGlyphExtents` for details
    /// about the interpretation of the rectangles.
    extern fn pango_layout_line_get_extents(p_line: *LayoutLine, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getExtents = pango_layout_line_get_extents;

    /// Computes the height of the line, as the maximum of the heights
    /// of fonts used in this line.
    ///
    /// Note that the actual baseline-to-baseline distance between lines
    /// of text is influenced by other factors, such as
    /// `pango.Layout.setSpacing` and
    /// `pango.Layout.setLineSpacing`.
    extern fn pango_layout_line_get_height(p_line: *LayoutLine, p_height: ?*c_int) void;
    pub const getHeight = pango_layout_line_get_height;

    /// Returns the length of the line, in bytes.
    extern fn pango_layout_line_get_length(p_line: *LayoutLine) c_int;
    pub const getLength = pango_layout_line_get_length;

    /// Computes the logical and ink extents of `layout_line` in device units.
    ///
    /// This function just calls `pango.LayoutLine.getExtents` followed by
    /// two `extentsToPixels` calls, rounding `ink_rect` and `logical_rect`
    /// such that the rounded rectangles fully contain the unrounded one (that is,
    /// passes them as first argument to `extentsToPixels`).
    extern fn pango_layout_line_get_pixel_extents(p_layout_line: *LayoutLine, p_ink_rect: ?*pango.Rectangle, p_logical_rect: ?*pango.Rectangle) void;
    pub const getPixelExtents = pango_layout_line_get_pixel_extents;

    /// Returns the resolved direction of the line.
    extern fn pango_layout_line_get_resolved_direction(p_line: *LayoutLine) pango.Direction;
    pub const getResolvedDirection = pango_layout_line_get_resolved_direction;

    /// Returns the start index of the line, as byte index
    /// into the text of the layout.
    extern fn pango_layout_line_get_start_index(p_line: *LayoutLine) c_int;
    pub const getStartIndex = pango_layout_line_get_start_index;

    /// Gets a list of visual ranges corresponding to a given logical range.
    ///
    /// This list is not necessarily minimal - there may be consecutive
    /// ranges which are adjacent. The ranges will be sorted from left to
    /// right. The ranges are with respect to the left edge of the entire
    /// layout, not with respect to the line.
    extern fn pango_layout_line_get_x_ranges(p_line: *LayoutLine, p_start_index: c_int, p_end_index: c_int, p_ranges: *[*]c_int, p_n_ranges: *c_int) void;
    pub const getXRanges = pango_layout_line_get_x_ranges;

    /// Converts an index within a line to a X position.
    extern fn pango_layout_line_index_to_x(p_line: *LayoutLine, p_index_: c_int, p_trailing: c_int, p_x_pos: *c_int) void;
    pub const indexToX = pango_layout_line_index_to_x;

    /// Returns whether this is the first line of the paragraph.
    extern fn pango_layout_line_is_paragraph_start(p_line: *LayoutLine) c_int;
    pub const isParagraphStart = pango_layout_line_is_paragraph_start;

    /// Increase the reference count of a `PangoLayoutLine` by one.
    extern fn pango_layout_line_ref(p_line: ?*LayoutLine) ?*pango.LayoutLine;
    pub const ref = pango_layout_line_ref;

    /// Decrease the reference count of a `PangoLayoutLine` by one.
    ///
    /// If the result is zero, the line and all associated memory
    /// will be freed.
    extern fn pango_layout_line_unref(p_line: *LayoutLine) void;
    pub const unref = pango_layout_line_unref;

    /// Converts from x offset to the byte index of the corresponding character
    /// within the text of the layout.
    ///
    /// If `x_pos` is outside the line, `index_` and `trailing` will point to the very
    /// first or very last position in the line. This determination is based on the
    /// resolved direction of the paragraph; for example, if the resolved direction
    /// is right-to-left, then an X position to the right of the line (after it)
    /// results in 0 being stored in `index_` and `trailing`. An X position to the
    /// left of the line results in `index_` pointing to the (logical) last grapheme
    /// in the line and `trailing` being set to the number of characters in that
    /// grapheme. The reverse is true for a left-to-right line.
    extern fn pango_layout_line_x_to_index(p_line: *LayoutLine, p_x_pos: c_int, p_index_: *c_int, p_trailing: *c_int) c_int;
    pub const xToIndex = pango_layout_line_x_to_index;

    extern fn pango_layout_line_get_type() usize;
    pub const getGObjectType = pango_layout_line_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoLogAttr` structure stores information about the attributes of a
/// single character.
pub const LogAttr = extern struct {
    bitfields0: packed struct(c_uint) {
        /// if set, can break line in front of character
        f_is_line_break: u1,
        /// if set, must break line in front of character
        f_is_mandatory_break: u1,
        /// if set, can break here when doing character wrapping
        f_is_char_break: u1,
        /// is whitespace character
        f_is_white: u1,
        /// if set, cursor can appear in front of character.
        ///   i.e. this is a grapheme boundary, or the first character in the text.
        ///   This flag implements Unicode's
        ///   [Grapheme Cluster Boundaries](http://www.unicode.org/reports/tr29/)
        ///   semantics.
        f_is_cursor_position: u1,
        /// is first character in a word
        f_is_word_start: u1,
        /// is first non-word char after a word
        ///   Note that in degenerate cases, you could have both `is_word_start`
        ///   and `is_word_end` set for some character.
        f_is_word_end: u1,
        /// is a sentence boundary.
        ///   There are two ways to divide sentences. The first assigns all
        ///   inter-sentence whitespace/control/format chars to some sentence,
        ///   so all chars are in some sentence; `is_sentence_boundary` denotes
        ///   the boundaries there. The second way doesn't assign
        ///   between-sentence spaces, etc. to any sentence, so
        ///   `is_sentence_start`/`is_sentence_end` mark the boundaries of those sentences.
        f_is_sentence_boundary: u1,
        /// is first character in a sentence
        f_is_sentence_start: u1,
        /// is first char after a sentence.
        ///   Note that in degenerate cases, you could have both `is_sentence_start`
        ///   and `is_sentence_end` set for some character. (e.g. no space after a
        ///   period, so the next sentence starts right away)
        f_is_sentence_end: u1,
        /// if set, backspace deletes one character
        ///   rather than the entire grapheme cluster. This field is only meaningful
        ///   on grapheme boundaries (where `is_cursor_position` is set). In some languages,
        ///   the full grapheme (e.g. letter + diacritics) is considered a unit, while in
        ///   others, each decomposed character in the grapheme is a unit. In the default
        ///   implementation of `@"break"`, this bit is set on all grapheme boundaries
        ///   except those following Latin, Cyrillic or Greek base characters.
        f_backspace_deletes_character: u1,
        /// is a whitespace character that can possibly be
        ///   expanded for justification purposes. (Since: 1.18)
        f_is_expandable_space: u1,
        /// is a word boundary, as defined by UAX`@"29"`.
        ///   More specifically, means that this is not a position in the middle of a word.
        ///   For example, both sides of a punctuation mark are considered word boundaries.
        ///   This flag is particularly useful when selecting text word-by-word. This flag
        ///   implements Unicode's [Word Boundaries](http://www.unicode.org/reports/tr29/)
        ///   semantics. (Since: 1.22)
        f_is_word_boundary: u1,
        /// when breaking lines before this char, insert a hyphen.
        ///   Since: 1.50
        f_break_inserts_hyphen: u1,
        /// when breaking lines before this char, remove the
        ///   preceding char. Since 1.50
        f_break_removes_preceding: u1,
        f_reserved: u17,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoMatrix` specifies a transformation between user-space
/// and device coordinates.
///
/// The transformation is given by
///
/// ```
/// x_device = x_user * matrix->xx + y_user * matrix->xy + matrix->x0;
/// y_device = x_user * matrix->yx + y_user * matrix->yy + matrix->y0;
/// ```
pub const Matrix = extern struct {
    /// 1st component of the transformation matrix
    f_xx: f64,
    /// 2nd component of the transformation matrix
    f_xy: f64,
    /// 3rd component of the transformation matrix
    f_yx: f64,
    /// 4th component of the transformation matrix
    f_yy: f64,
    /// x translation
    f_x0: f64,
    /// y translation
    f_y0: f64,

    /// Changes the transformation represented by `matrix` to be the
    /// transformation given by first applying transformation
    /// given by `new_matrix` then applying the original transformation.
    extern fn pango_matrix_concat(p_matrix: *Matrix, p_new_matrix: *const pango.Matrix) void;
    pub const concat = pango_matrix_concat;

    /// Copies a `PangoMatrix`.
    extern fn pango_matrix_copy(p_matrix: ?*const Matrix) ?*pango.Matrix;
    pub const copy = pango_matrix_copy;

    /// Free a `PangoMatrix`.
    extern fn pango_matrix_free(p_matrix: ?*Matrix) void;
    pub const free = pango_matrix_free;

    /// Returns the scale factor of a matrix on the height of the font.
    ///
    /// That is, the scale factor in the direction perpendicular to the
    /// vector that the X coordinate is mapped to.  If the scale in the X
    /// coordinate is needed as well, use `pango.Matrix.getFontScaleFactors`.
    extern fn pango_matrix_get_font_scale_factor(p_matrix: ?*const Matrix) f64;
    pub const getFontScaleFactor = pango_matrix_get_font_scale_factor;

    /// Calculates the scale factor of a matrix on the width and height of the font.
    ///
    /// That is, `xscale` is the scale factor in the direction of the X coordinate,
    /// and `yscale` is the scale factor in the direction perpendicular to the
    /// vector that the X coordinate is mapped to.
    ///
    /// Note that output numbers will always be non-negative.
    extern fn pango_matrix_get_font_scale_factors(p_matrix: ?*const Matrix, p_xscale: ?*f64, p_yscale: ?*f64) void;
    pub const getFontScaleFactors = pango_matrix_get_font_scale_factors;

    /// Gets the slant ratio of a matrix.
    ///
    /// For a simple shear matrix in the form:
    ///
    ///     1 λ
    ///     0 1
    ///
    /// this is simply λ.
    extern fn pango_matrix_get_slant_ratio(p_matrix: *const Matrix) f64;
    pub const getSlantRatio = pango_matrix_get_slant_ratio;

    /// Changes the transformation represented by `matrix` to be the
    /// transformation given by first rotating by `degrees` degrees
    /// counter-clockwise then applying the original transformation.
    extern fn pango_matrix_rotate(p_matrix: *Matrix, p_degrees: f64) void;
    pub const rotate = pango_matrix_rotate;

    /// Changes the transformation represented by `matrix` to be the
    /// transformation given by first scaling by `sx` in the X direction
    /// and `sy` in the Y direction then applying the original
    /// transformation.
    extern fn pango_matrix_scale(p_matrix: *Matrix, p_scale_x: f64, p_scale_y: f64) void;
    pub const scale = pango_matrix_scale;

    /// Transforms the distance vector (`dx`,`dy`) by `matrix`.
    ///
    /// This is similar to `pango.Matrix.transformPoint`,
    /// except that the translation components of the transformation
    /// are ignored. The calculation of the returned vector is as follows:
    ///
    /// ```
    /// dx2 = dx1 * xx + dy1 * xy;
    /// dy2 = dx1 * yx + dy1 * yy;
    /// ```
    ///
    /// Affine transformations are position invariant, so the same vector
    /// always transforms to the same vector. If (`x1`,`y1`) transforms
    /// to (`x2`,`y2`) then (`x1`+`dx1`,`y1`+`dy1`) will transform to
    /// (`x1`+`dx2`,`y1`+`dy2`) for all values of `x1` and `x2`.
    extern fn pango_matrix_transform_distance(p_matrix: ?*const Matrix, p_dx: *f64, p_dy: *f64) void;
    pub const transformDistance = pango_matrix_transform_distance;

    /// First transforms the `rect` using `matrix`, then calculates the bounding box
    /// of the transformed rectangle.
    ///
    /// This function is useful for example when you want to draw a rotated
    /// `PangoLayout` to an image buffer, and want to know how large the image
    /// should be and how much you should shift the layout when rendering.
    ///
    /// For better accuracy, you should use `pango.Matrix.transformRectangle`
    /// on original rectangle in Pango units and convert to pixels afterward
    /// using `extentsToPixels`'s first argument.
    extern fn pango_matrix_transform_pixel_rectangle(p_matrix: ?*const Matrix, p_rect: ?*pango.Rectangle) void;
    pub const transformPixelRectangle = pango_matrix_transform_pixel_rectangle;

    /// Transforms the point (`x`, `y`) by `matrix`.
    extern fn pango_matrix_transform_point(p_matrix: ?*const Matrix, p_x: *f64, p_y: *f64) void;
    pub const transformPoint = pango_matrix_transform_point;

    /// First transforms `rect` using `matrix`, then calculates the bounding box
    /// of the transformed rectangle.
    ///
    /// This function is useful for example when you want to draw a rotated
    /// `PangoLayout` to an image buffer, and want to know how large the image
    /// should be and how much you should shift the layout when rendering.
    ///
    /// If you have a rectangle in device units (pixels), use
    /// `pango.Matrix.transformPixelRectangle`.
    ///
    /// If you have the rectangle in Pango units and want to convert to
    /// transformed pixel bounding box, it is more accurate to transform it first
    /// (using this function) and pass the result to `pango.extentsToPixels`,
    /// first argument, for an inclusive rounded rectangle.
    /// However, there are valid reasons that you may want to convert
    /// to pixels first and then transform, for example when the transformed
    /// coordinates may overflow in Pango units (large matrix translation for
    /// example).
    extern fn pango_matrix_transform_rectangle(p_matrix: ?*const Matrix, p_rect: ?*pango.Rectangle) void;
    pub const transformRectangle = pango_matrix_transform_rectangle;

    /// Changes the transformation represented by `matrix` to be the
    /// transformation given by first translating by (`tx`, `ty`)
    /// then applying the original transformation.
    extern fn pango_matrix_translate(p_matrix: *Matrix, p_tx: f64, p_ty: f64) void;
    pub const translate = pango_matrix_translate;

    extern fn pango_matrix_get_type() usize;
    pub const getGObjectType = pango_matrix_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoRectangle` structure represents a rectangle.
///
/// `PangoRectangle` is frequently used to represent the logical or ink
/// extents of a single glyph or section of text. (See, for instance,
/// `pango.Font.getGlyphExtents`.)
pub const Rectangle = extern struct {
    /// X coordinate of the left side of the rectangle.
    f_x: c_int,
    /// Y coordinate of the the top side of the rectangle.
    f_y: c_int,
    /// width of the rectangle.
    f_width: c_int,
    /// height of the rectangle.
    f_height: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Class structure for `PangoRenderer`.
///
/// The following vfuncs take user space coordinates in Pango units
/// and have default implementations:
/// - draw_glyphs
/// - draw_rectangle
/// - draw_error_underline
/// - draw_shape
/// - draw_glyph_item
///
/// The default draw_shape implementation draws nothing.
///
/// The following vfuncs take device space coordinates as doubles
/// and must be implemented:
/// - draw_trapezoid
/// - draw_glyph
pub const RendererClass = extern struct {
    pub const Instance = pango.Renderer;

    f_parent_class: gobject.ObjectClass,
    /// draws a `PangoGlyphString`
    f_draw_glyphs: ?*const fn (p_renderer: *pango.Renderer, p_font: *pango.Font, p_glyphs: *pango.GlyphString, p_x: c_int, p_y: c_int) callconv(.c) void,
    /// draws a rectangle
    f_draw_rectangle: ?*const fn (p_renderer: *pango.Renderer, p_part: pango.RenderPart, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void,
    /// draws a squiggly line that approximately
    /// covers the given rectangle in the style of an underline used to
    /// indicate a spelling error.
    f_draw_error_underline: ?*const fn (p_renderer: *pango.Renderer, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void,
    /// draw content for a glyph shaped with `PangoAttrShape`
    ///   `x`, `y` are the coordinates of the left edge of the baseline,
    ///   in user coordinates.
    f_draw_shape: ?*const fn (p_renderer: *pango.Renderer, p_attr: *pango.AttrShape, p_x: c_int, p_y: c_int) callconv(.c) void,
    /// draws a trapezoidal filled area
    f_draw_trapezoid: ?*const fn (p_renderer: *pango.Renderer, p_part: pango.RenderPart, p_y1_: f64, p_x11: f64, p_x21: f64, p_y2: f64, p_x12: f64, p_x22: f64) callconv(.c) void,
    /// draws a single glyph
    f_draw_glyph: ?*const fn (p_renderer: *pango.Renderer, p_font: *pango.Font, p_glyph: pango.Glyph, p_x: f64, p_y: f64) callconv(.c) void,
    /// do renderer specific processing when rendering
    ///  attributes change
    f_part_changed: ?*const fn (p_renderer: *pango.Renderer, p_part: pango.RenderPart) callconv(.c) void,
    /// Do renderer-specific initialization before drawing
    f_begin: ?*const fn (p_renderer: *pango.Renderer) callconv(.c) void,
    /// Do renderer-specific cleanup after drawing
    f_end: ?*const fn (p_renderer: *pango.Renderer) callconv(.c) void,
    /// updates the renderer for a new run
    f_prepare_run: ?*const fn (p_renderer: *pango.Renderer, p_run: *pango.LayoutRun) callconv(.c) void,
    /// draws a `PangoGlyphItem`
    f_draw_glyph_item: ?*const fn (p_renderer: *pango.Renderer, p_text: ?[*:0]const u8, p_glyph_item: *pango.GlyphItem, p_x: c_int, p_y: c_int) callconv(.c) void,
    f__pango_reserved2: ?*const fn () callconv(.c) void,
    f__pango_reserved3: ?*const fn () callconv(.c) void,
    f__pango_reserved4: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *RendererClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RendererPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoScriptIter` is used to iterate through a string
/// and identify ranges in different scripts.
pub const ScriptIter = opaque {
    /// Create a new `PangoScriptIter`, used to break a string of
    /// Unicode text into runs by Unicode script.
    ///
    /// No copy is made of `text`, so the caller needs to make
    /// sure it remains valid until the iterator is freed with
    /// `pango.ScriptIter.free`.
    extern fn pango_script_iter_new(p_text: [*:0]const u8, p_length: c_int) *pango.ScriptIter;
    pub const new = pango_script_iter_new;

    /// Frees a `PangoScriptIter`.
    extern fn pango_script_iter_free(p_iter: *ScriptIter) void;
    pub const free = pango_script_iter_free;

    /// Gets information about the range to which `iter` currently points.
    ///
    /// The range is the set of locations p where *start <= p < *end.
    /// (That is, it doesn't include the character stored at *end)
    ///
    /// Note that while the type of the `script` argument is declared
    /// as `PangoScript`, as of Pango 1.18, this function simply returns
    /// `GUnicodeScript` values. Callers must be prepared to handle unknown
    /// values.
    extern fn pango_script_iter_get_range(p_iter: *ScriptIter, p_start: ?*[*:0]const u8, p_end: ?*[*:0]const u8, p_script: ?*pango.Script) void;
    pub const getRange = pango_script_iter_get_range;

    /// Advances a `PangoScriptIter` to the next range.
    ///
    /// If `iter` is already at the end, it is left unchanged
    /// and `FALSE` is returned.
    extern fn pango_script_iter_next(p_iter: *ScriptIter) c_int;
    pub const next = pango_script_iter_next;

    extern fn pango_script_iter_get_type() usize;
    pub const getGObjectType = pango_script_iter_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `PangoTabArray` contains an array of tab stops.
///
/// `PangoTabArray` can be used to set tab stops in a `PangoLayout`.
/// Each tab stop has an alignment, a position, and optionally
/// a character to use as decimal point.
pub const TabArray = opaque {
    /// Deserializes a `PangoTabArray` from a string.
    ///
    /// This is the counterpart to `pango.TabArray.toString`.
    /// See that functions for details about the format.
    extern fn pango_tab_array_from_string(p_text: [*:0]const u8) ?*pango.TabArray;
    pub const fromString = pango_tab_array_from_string;

    /// Creates an array of `initial_size` tab stops.
    ///
    /// Tab stops are specified in pixel units if `positions_in_pixels` is `TRUE`,
    /// otherwise in Pango units. All stops are initially at position 0.
    extern fn pango_tab_array_new(p_initial_size: c_int, p_positions_in_pixels: c_int) *pango.TabArray;
    pub const new = pango_tab_array_new;

    /// Creates a `PangoTabArray` and allows you to specify the alignment
    /// and position of each tab stop.
    ///
    /// You **must** provide an alignment and position for `size` tab stops.
    extern fn pango_tab_array_new_with_positions(p_size: c_int, p_positions_in_pixels: c_int, p_first_alignment: pango.TabAlign, p_first_position: c_int, ...) *pango.TabArray;
    pub const newWithPositions = pango_tab_array_new_with_positions;

    /// Copies a `PangoTabArray`.
    extern fn pango_tab_array_copy(p_src: *TabArray) *pango.TabArray;
    pub const copy = pango_tab_array_copy;

    /// Frees a tab array and associated resources.
    extern fn pango_tab_array_free(p_tab_array: *TabArray) void;
    pub const free = pango_tab_array_free;

    /// Gets the Unicode character to use as decimal point.
    ///
    /// This is only relevant for tabs with `PANGO_TAB_DECIMAL` alignment,
    /// which align content at the first occurrence of the decimal point
    /// character.
    ///
    /// The default value of 0 means that Pango will use the
    /// decimal point according to the current locale.
    extern fn pango_tab_array_get_decimal_point(p_tab_array: *TabArray, p_tab_index: c_int) u32;
    pub const getDecimalPoint = pango_tab_array_get_decimal_point;

    /// Returns `TRUE` if the tab positions are in pixels,
    /// `FALSE` if they are in Pango units.
    extern fn pango_tab_array_get_positions_in_pixels(p_tab_array: *TabArray) c_int;
    pub const getPositionsInPixels = pango_tab_array_get_positions_in_pixels;

    /// Gets the number of tab stops in `tab_array`.
    extern fn pango_tab_array_get_size(p_tab_array: *TabArray) c_int;
    pub const getSize = pango_tab_array_get_size;

    /// Gets the alignment and position of a tab stop.
    extern fn pango_tab_array_get_tab(p_tab_array: *TabArray, p_tab_index: c_int, p_alignment: ?*pango.TabAlign, p_location: ?*c_int) void;
    pub const getTab = pango_tab_array_get_tab;

    /// If non-`NULL`, `alignments` and `locations` are filled with allocated
    /// arrays.
    ///
    /// The arrays are of length `pango.TabArray.getSize`.
    /// You must free the returned array.
    extern fn pango_tab_array_get_tabs(p_tab_array: *TabArray, p_alignments: ?**pango.TabAlign, p_locations: ?*[*]c_int) void;
    pub const getTabs = pango_tab_array_get_tabs;

    /// Resizes a tab array.
    ///
    /// You must subsequently initialize any tabs
    /// that were added as a result of growing the array.
    extern fn pango_tab_array_resize(p_tab_array: *TabArray, p_new_size: c_int) void;
    pub const resize = pango_tab_array_resize;

    /// Sets the Unicode character to use as decimal point.
    ///
    /// This is only relevant for tabs with `PANGO_TAB_DECIMAL` alignment,
    /// which align content at the first occurrence of the decimal point
    /// character.
    ///
    /// By default, Pango uses the decimal point according
    /// to the current locale.
    extern fn pango_tab_array_set_decimal_point(p_tab_array: *TabArray, p_tab_index: c_int, p_decimal_point: u32) void;
    pub const setDecimalPoint = pango_tab_array_set_decimal_point;

    /// Sets whether positions in this array are specified in
    /// pixels.
    extern fn pango_tab_array_set_positions_in_pixels(p_tab_array: *TabArray, p_positions_in_pixels: c_int) void;
    pub const setPositionsInPixels = pango_tab_array_set_positions_in_pixels;

    /// Sets the alignment and location of a tab stop.
    extern fn pango_tab_array_set_tab(p_tab_array: *TabArray, p_tab_index: c_int, p_alignment: pango.TabAlign, p_location: c_int) void;
    pub const setTab = pango_tab_array_set_tab;

    /// Utility function to ensure that the tab stops are in increasing order.
    extern fn pango_tab_array_sort(p_tab_array: *TabArray) void;
    pub const sort = pango_tab_array_sort;

    /// Serializes a `PangoTabArray` to a string.
    ///
    /// In the resulting string, serialized tabs are separated by newlines or commas.
    ///
    /// Individual tabs are serialized to a string of the form
    ///
    ///     [ALIGNMENT:]POSITION[:DECIMAL_POINT]
    ///
    /// Where ALIGNMENT is one of _left_, _right_, _center_ or _decimal_, and
    /// POSITION is the position of the tab, optionally followed by the unit _px_.
    /// If ALIGNMENT is omitted, it defaults to _left_. If ALIGNMENT is _decimal_,
    /// the DECIMAL_POINT character may be specified as a Unicode codepoint.
    ///
    /// Note that all tabs in the array must use the same unit.
    ///
    /// A typical example:
    ///
    ///     100px 200px center:300px right:400px
    extern fn pango_tab_array_to_string(p_tab_array: *TabArray) [*:0]u8;
    pub const toString = pango_tab_array_to_string;

    extern fn pango_tab_array_get_type() usize;
    pub const getGObjectType = pango_tab_array_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoAlignment` describes how to align the lines of a `PangoLayout`
/// within the available space.
///
/// If the `PangoLayout` is set to justify using `pango.Layout.setJustify`,
/// this only affects partial lines.
///
/// See `pango.Layout.setAutoDir` for how text direction affects
/// the interpretation of `PangoAlignment` values.
pub const Alignment = enum(c_int) {
    left = 0,
    center = 1,
    right = 2,
    _,

    extern fn pango_alignment_get_type() usize;
    pub const getGObjectType = pango_alignment_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoAttrType` distinguishes between different types of attributes.
///
/// Along with the predefined values, it is possible to allocate additional
/// values for custom attributes using `AttrType.register`. The predefined
/// values are given below. The type of structure used to store the attribute is
/// listed in parentheses after the description.
pub const AttrType = enum(c_int) {
    invalid = 0,
    language = 1,
    family = 2,
    style = 3,
    weight = 4,
    variant = 5,
    stretch = 6,
    size = 7,
    font_desc = 8,
    foreground = 9,
    background = 10,
    underline = 11,
    strikethrough = 12,
    rise = 13,
    shape = 14,
    scale = 15,
    fallback = 16,
    letter_spacing = 17,
    underline_color = 18,
    strikethrough_color = 19,
    absolute_size = 20,
    gravity = 21,
    gravity_hint = 22,
    font_features = 23,
    foreground_alpha = 24,
    background_alpha = 25,
    allow_breaks = 26,
    show = 27,
    insert_hyphens = 28,
    overline = 29,
    overline_color = 30,
    line_height = 31,
    absolute_line_height = 32,
    text_transform = 33,
    word = 34,
    sentence = 35,
    baseline_shift = 36,
    font_scale = 37,
    _,

    /// Fetches the attribute type name.
    ///
    /// The attribute type name is the string passed in
    /// when registering the type using
    /// `pango.AttrType.register`.
    ///
    /// The returned value is an interned string (see
    /// `glib.internString` for what that means) that should
    /// not be modified or freed.
    extern fn pango_attr_type_get_name(p_type: pango.AttrType) ?[*:0]const u8;
    pub const getName = pango_attr_type_get_name;

    /// Allocate a new attribute type ID.
    ///
    /// The attribute type name can be accessed later
    /// by using `pango.AttrType.getName`.
    extern fn pango_attr_type_register(p_name: [*:0]const u8) pango.AttrType;
    pub const register = pango_attr_type_register;

    extern fn pango_attr_type_get_type() usize;
    pub const getGObjectType = pango_attr_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration that affects baseline shifts between runs.
pub const BaselineShift = enum(c_int) {
    none = 0,
    superscript = 1,
    subscript = 2,
    _,

    extern fn pango_baseline_shift_get_type() usize;
    pub const getGObjectType = pango_baseline_shift_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoBidiType` represents the bidirectional character
/// type of a Unicode character.
///
/// The values in this enumeration are specified by the
/// [Unicode bidirectional algorithm](http://www.unicode.org/reports/tr9/).
pub const BidiType = enum(c_int) {
    l = 0,
    lre = 1,
    lro = 2,
    r = 3,
    al = 4,
    rle = 5,
    rlo = 6,
    pdf = 7,
    en = 8,
    es = 9,
    et = 10,
    an = 11,
    cs = 12,
    nsm = 13,
    bn = 14,
    b = 15,
    s = 16,
    ws = 17,
    on = 18,
    lri = 19,
    rli = 20,
    fsi = 21,
    pdi = 22,
    _,

    /// Determines the bidirectional type of a character.
    ///
    /// The bidirectional type is specified in the Unicode Character Database.
    ///
    /// A simplified version of this function is available as `unicharDirection`.
    extern fn pango_bidi_type_for_unichar(p_ch: u32) pango.BidiType;
    pub const forUnichar = pango_bidi_type_for_unichar;

    extern fn pango_bidi_type_get_type() usize;
    pub const getGObjectType = pango_bidi_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoCoverageLevel` is used to indicate how well a font can
/// represent a particular Unicode character for a particular script.
///
/// Since 1.44, only `PANGO_COVERAGE_NONE` and `PANGO_COVERAGE_EXACT`
/// will be returned.
pub const CoverageLevel = enum(c_int) {
    none = 0,
    fallback = 1,
    approximate = 2,
    exact = 3,
    _,

    extern fn pango_coverage_level_get_type() usize;
    pub const getGObjectType = pango_coverage_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoDirection` represents a direction in the Unicode bidirectional
/// algorithm.
///
/// Not every value in this enumeration makes sense for every usage of
/// `PangoDirection`; for example, the return value of `unicharDirection`
/// and `findBaseDir` cannot be `PANGO_DIRECTION_WEAK_LTR` or
/// `PANGO_DIRECTION_WEAK_RTL`, since every character is either neutral
/// or has a strong direction; on the other hand `PANGO_DIRECTION_NEUTRAL`
/// doesn't make sense to pass to `itemizeWithBaseDir`.
///
/// The `PANGO_DIRECTION_TTB_LTR`, `PANGO_DIRECTION_TTB_RTL` values come from
/// an earlier interpretation of this enumeration as the writing direction
/// of a block of text and are no longer used. See `PangoGravity` for how
/// vertical text is handled in Pango.
///
/// If you are interested in text direction, you should really use fribidi
/// directly. `PangoDirection` is only retained because it is used in some
/// public apis.
pub const Direction = enum(c_int) {
    ltr = 0,
    rtl = 1,
    ttb_ltr = 2,
    ttb_rtl = 3,
    weak_ltr = 4,
    weak_rtl = 5,
    neutral = 6,
    _,

    extern fn pango_direction_get_type() usize;
    pub const getGObjectType = pango_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoEllipsizeMode` describes what sort of ellipsization
/// should be applied to text.
///
/// In the ellipsization process characters are removed from the
/// text in order to make it fit to a given width and replaced
/// with an ellipsis.
pub const EllipsizeMode = enum(c_int) {
    none = 0,
    start = 1,
    middle = 2,
    end = 3,
    _,

    extern fn pango_ellipsize_mode_get_type() usize;
    pub const getGObjectType = pango_ellipsize_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration that affects font sizes for superscript
/// and subscript positioning and for (emulated) Small Caps.
pub const FontScale = enum(c_int) {
    none = 0,
    superscript = 1,
    subscript = 2,
    small_caps = 3,
    _,

    extern fn pango_font_scale_get_type() usize;
    pub const getGObjectType = pango_font_scale_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoGravity` represents the orientation of glyphs in a segment
/// of text.
///
/// This is useful when rendering vertical text layouts. In those situations,
/// the layout is rotated using a non-identity `pango.Matrix`, and then
/// glyph orientation is controlled using `PangoGravity`.
///
/// Not every value in this enumeration makes sense for every usage of
/// `PangoGravity`; for example, `PANGO_GRAVITY_AUTO` only can be passed to
/// `pango.Context.setBaseGravity` and can only be returned by
/// `pango.Context.getBaseGravity`.
///
/// See also: `pango.GravityHint`
pub const Gravity = enum(c_int) {
    south = 0,
    east = 1,
    north = 2,
    west = 3,
    auto = 4,
    _,

    /// Finds the gravity that best matches the rotation component
    /// in a `PangoMatrix`.
    extern fn pango_gravity_get_for_matrix(p_matrix: ?*const pango.Matrix) pango.Gravity;
    pub const getForMatrix = pango_gravity_get_for_matrix;

    /// Returns the gravity to use in laying out a `PangoItem`.
    ///
    /// The gravity is determined based on the script, base gravity, and hint.
    ///
    /// If `base_gravity` is `PANGO_GRAVITY_AUTO`, it is first replaced with the
    /// preferred gravity of `script`.  To get the preferred gravity of a script,
    /// pass `PANGO_GRAVITY_AUTO` and `PANGO_GRAVITY_HINT_STRONG` in.
    extern fn pango_gravity_get_for_script(p_script: pango.Script, p_base_gravity: pango.Gravity, p_hint: pango.GravityHint) pango.Gravity;
    pub const getForScript = pango_gravity_get_for_script;

    /// Returns the gravity to use in laying out a single character
    /// or `PangoItem`.
    ///
    /// The gravity is determined based on the script, East Asian width,
    /// base gravity, and hint,
    ///
    /// This function is similar to `pango.Gravity.getForScript` except
    /// that this function makes a distinction between narrow/half-width and
    /// wide/full-width characters also. Wide/full-width characters always
    /// stand *upright*, that is, they always take the base gravity,
    /// whereas narrow/full-width characters are always rotated in vertical
    /// context.
    ///
    /// If `base_gravity` is `PANGO_GRAVITY_AUTO`, it is first replaced with the
    /// preferred gravity of `script`.
    extern fn pango_gravity_get_for_script_and_width(p_script: pango.Script, p_wide: c_int, p_base_gravity: pango.Gravity, p_hint: pango.GravityHint) pango.Gravity;
    pub const getForScriptAndWidth = pango_gravity_get_for_script_and_width;

    /// Converts a `PangoGravity` value to its natural rotation in radians.
    ///
    /// Note that `pango.Matrix.rotate` takes angle in degrees, not radians.
    /// So, to call `pango.@"Matrix,rotate"` with the output of this function
    /// you should multiply it by (180. / G_PI).
    extern fn pango_gravity_to_rotation(p_gravity: pango.Gravity) f64;
    pub const toRotation = pango_gravity_to_rotation;

    extern fn pango_gravity_get_type() usize;
    pub const getGObjectType = pango_gravity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoGravityHint` defines how horizontal scripts should behave in a
/// vertical context.
///
/// That is, English excerpts in a vertical paragraph for example.
///
/// See also `pango.Gravity`
pub const GravityHint = enum(c_int) {
    natural = 0,
    strong = 1,
    line = 2,
    _,

    extern fn pango_gravity_hint_get_type() usize;
    pub const getGObjectType = pango_gravity_hint_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Errors that can be returned by `pango.Layout.deserialize`.
pub const LayoutDeserializeError = enum(c_int) {
    invalid = 0,
    invalid_value = 1,
    missing_value = 2,
    _,

    extern fn pango_layout_deserialize_error_quark() glib.Quark;
    pub const quark = pango_layout_deserialize_error_quark;

    extern fn pango_layout_deserialize_error_get_type() usize;
    pub const getGObjectType = pango_layout_deserialize_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoOverline` enumeration is used to specify whether text
/// should be overlined, and if so, the type of line.
pub const Overline = enum(c_int) {
    none = 0,
    single = 1,
    _,

    extern fn pango_overline_get_type() usize;
    pub const getGObjectType = pango_overline_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoRenderPart` defines different items to render for such
/// purposes as setting colors.
pub const RenderPart = enum(c_int) {
    foreground = 0,
    background = 1,
    underline = 2,
    strikethrough = 3,
    overline = 4,
    _,

    extern fn pango_render_part_get_type() usize;
    pub const getGObjectType = pango_render_part_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoScript` enumeration identifies different writing
/// systems.
///
/// The values correspond to the names as defined in the Unicode standard. See
/// [Unicode Standard Annex 24: Script names](http://www.unicode.org/reports/tr24/)
///
/// Note that this enumeration is deprecated and will not be updated to include values
/// in newer versions of the Unicode standard. Applications should use the
/// `glib.UnicodeScript` enumeration instead,
/// whose values are interchangeable with `PangoScript`.
pub const Script = enum(c_int) {
    invalid_code = -1,
    common = 0,
    inherited = 1,
    arabic = 2,
    armenian = 3,
    bengali = 4,
    bopomofo = 5,
    cherokee = 6,
    coptic = 7,
    cyrillic = 8,
    deseret = 9,
    devanagari = 10,
    ethiopic = 11,
    georgian = 12,
    gothic = 13,
    greek = 14,
    gujarati = 15,
    gurmukhi = 16,
    han = 17,
    hangul = 18,
    hebrew = 19,
    hiragana = 20,
    kannada = 21,
    katakana = 22,
    khmer = 23,
    lao = 24,
    latin = 25,
    malayalam = 26,
    mongolian = 27,
    myanmar = 28,
    ogham = 29,
    old_italic = 30,
    oriya = 31,
    runic = 32,
    sinhala = 33,
    syriac = 34,
    tamil = 35,
    telugu = 36,
    thaana = 37,
    thai = 38,
    tibetan = 39,
    canadian_aboriginal = 40,
    yi = 41,
    tagalog = 42,
    hanunoo = 43,
    buhid = 44,
    tagbanwa = 45,
    braille = 46,
    cypriot = 47,
    limbu = 48,
    osmanya = 49,
    shavian = 50,
    linear_b = 51,
    tai_le = 52,
    ugaritic = 53,
    new_tai_lue = 54,
    buginese = 55,
    glagolitic = 56,
    tifinagh = 57,
    syloti_nagri = 58,
    old_persian = 59,
    kharoshthi = 60,
    unknown = 61,
    balinese = 62,
    cuneiform = 63,
    phoenician = 64,
    phags_pa = 65,
    nko = 66,
    kayah_li = 67,
    lepcha = 68,
    rejang = 69,
    sundanese = 70,
    saurashtra = 71,
    cham = 72,
    ol_chiki = 73,
    vai = 74,
    carian = 75,
    lycian = 76,
    lydian = 77,
    batak = 78,
    brahmi = 79,
    mandaic = 80,
    chakma = 81,
    meroitic_cursive = 82,
    meroitic_hieroglyphs = 83,
    miao = 84,
    sharada = 85,
    sora_sompeng = 86,
    takri = 87,
    bassa_vah = 88,
    caucasian_albanian = 89,
    duployan = 90,
    elbasan = 91,
    grantha = 92,
    khojki = 93,
    khudawadi = 94,
    linear_a = 95,
    mahajani = 96,
    manichaean = 97,
    mende_kikakui = 98,
    modi = 99,
    mro = 100,
    nabataean = 101,
    old_north_arabian = 102,
    old_permic = 103,
    pahawh_hmong = 104,
    palmyrene = 105,
    pau_cin_hau = 106,
    psalter_pahlavi = 107,
    siddham = 108,
    tirhuta = 109,
    warang_citi = 110,
    ahom = 111,
    anatolian_hieroglyphs = 112,
    hatran = 113,
    multani = 114,
    old_hungarian = 115,
    signwriting = 116,
    _,

    /// Looks up the script for a particular character.
    ///
    /// The script of a character is defined by
    /// [Unicode Standard Annex 24: Script names](http://www.unicode.org/reports/tr24/).
    ///
    /// No check is made for `ch` being a valid Unicode character; if you pass
    /// in invalid character, the result is undefined.
    ///
    /// Note that while the return type of this function is declared
    /// as `PangoScript`, as of Pango 1.18, this function simply returns
    /// the return value of `glib.unicharGetScript`. Callers must be
    /// prepared to handle unknown values.
    extern fn pango_script_for_unichar(p_ch: u32) pango.Script;
    pub const forUnichar = pango_script_for_unichar;

    /// Finds a language tag that is reasonably representative of `script`.
    ///
    /// The language will usually be the most widely spoken or used language
    /// written in that script: for instance, the sample language for
    /// `PANGO_SCRIPT_CYRILLIC` is ru (Russian), the sample language for
    /// `PANGO_SCRIPT_ARABIC` is ar.
    ///
    /// For some scripts, no sample language will be returned because
    /// there is no language that is sufficiently representative. The
    /// best example of this is `PANGO_SCRIPT_HAN`, where various different
    /// variants of written Chinese, Japanese, and Korean all use
    /// significantly different sets of Han characters and forms
    /// of shared characters. No sample language can be provided
    /// for many historical scripts as well.
    ///
    /// As of 1.18, this function checks the environment variables
    /// `PANGO_LANGUAGE` and `LANGUAGE` (checked in that order) first.
    /// If one of them is set, it is parsed as a list of language tags
    /// separated by colons or other separators. This function
    /// will return the first language in the parsed list that Pango
    /// believes may use `script` for writing. This last predicate
    /// is tested using `pango.Language.includesScript`. This can
    /// be used to control Pango's font selection for non-primary
    /// languages. For example, a `PANGO_LANGUAGE` enviroment variable
    /// set to "en:fa" makes Pango choose fonts suitable for Persian (fa)
    /// instead of Arabic (ar) when a segment of Arabic text is found
    /// in an otherwise non-Arabic text. The same trick can be used to
    /// choose a default language for `PANGO_SCRIPT_HAN` when setting
    /// context language is not feasible.
    extern fn pango_script_get_sample_language(p_script: pango.Script) ?*pango.Language;
    pub const getSampleLanguage = pango_script_get_sample_language;

    extern fn pango_script_get_type() usize;
    pub const getGObjectType = pango_script_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration specifying the width of the font relative to other designs
/// within a family.
pub const Stretch = enum(c_int) {
    ultra_condensed = 0,
    extra_condensed = 1,
    condensed = 2,
    semi_condensed = 3,
    normal = 4,
    semi_expanded = 5,
    expanded = 6,
    extra_expanded = 7,
    ultra_expanded = 8,
    _,

    extern fn pango_stretch_get_type() usize;
    pub const getGObjectType = pango_stretch_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration specifying the various slant styles possible for a font.
pub const Style = enum(c_int) {
    normal = 0,
    oblique = 1,
    italic = 2,
    _,

    extern fn pango_style_get_type() usize;
    pub const getGObjectType = pango_style_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoTabAlign` specifies where the text appears relative to the tab stop
/// position.
pub const TabAlign = enum(c_int) {
    left = 0,
    right = 1,
    center = 2,
    decimal = 3,
    _,

    extern fn pango_tab_align_get_type() usize;
    pub const getGObjectType = pango_tab_align_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration that affects how Pango treats characters during shaping.
pub const TextTransform = enum(c_int) {
    none = 0,
    lowercase = 1,
    uppercase = 2,
    capitalize = 3,
    _,

    extern fn pango_text_transform_get_type() usize;
    pub const getGObjectType = pango_text_transform_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `PangoUnderline` enumeration is used to specify whether text
/// should be underlined, and if so, the type of underlining.
pub const Underline = enum(c_int) {
    none = 0,
    single = 1,
    double = 2,
    low = 3,
    @"error" = 4,
    single_line = 5,
    double_line = 6,
    error_line = 7,
    _,

    extern fn pango_underline_get_type() usize;
    pub const getGObjectType = pango_underline_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration specifying capitalization variant of the font.
pub const Variant = enum(c_int) {
    normal = 0,
    small_caps = 1,
    all_small_caps = 2,
    petite_caps = 3,
    all_petite_caps = 4,
    unicase = 5,
    title_caps = 6,
    _,

    extern fn pango_variant_get_type() usize;
    pub const getGObjectType = pango_variant_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration specifying the weight (boldness) of a font.
///
/// Weight is specified as a numeric value ranging from 100 to 1000.
/// This enumeration simply provides some common, predefined values.
pub const Weight = enum(c_int) {
    thin = 100,
    ultralight = 200,
    light = 300,
    semilight = 350,
    book = 380,
    normal = 400,
    medium = 500,
    semibold = 600,
    bold = 700,
    ultrabold = 800,
    heavy = 900,
    ultraheavy = 1000,
    _,

    extern fn pango_weight_get_type() usize;
    pub const getGObjectType = pango_weight_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `PangoWrapMode` describes how to wrap the lines of a `PangoLayout`
/// to the desired width.
///
/// For `PANGO_WRAP_WORD`, Pango uses break opportunities that are determined
/// by the Unicode line breaking algorithm. For `PANGO_WRAP_CHAR`, Pango allows
/// breaking at grapheme boundaries that are determined by the Unicode text
/// segmentation algorithm.
pub const WrapMode = enum(c_int) {
    word = 0,
    char = 1,
    word_char = 2,
    none = 3,
    _,

    extern fn pango_wrap_mode_get_type() usize;
    pub const getGObjectType = pango_wrap_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The bits in a `PangoFontMask` correspond to the set fields in a
/// `PangoFontDescription`.
pub const FontMask = packed struct(c_uint) {
    family: bool = false,
    style: bool = false,
    variant: bool = false,
    weight: bool = false,
    stretch: bool = false,
    size: bool = false,
    gravity: bool = false,
    variations: bool = false,
    features: bool = false,
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

    pub const flags_family: FontMask = @bitCast(@as(c_uint, 1));
    pub const flags_style: FontMask = @bitCast(@as(c_uint, 2));
    pub const flags_variant: FontMask = @bitCast(@as(c_uint, 4));
    pub const flags_weight: FontMask = @bitCast(@as(c_uint, 8));
    pub const flags_stretch: FontMask = @bitCast(@as(c_uint, 16));
    pub const flags_size: FontMask = @bitCast(@as(c_uint, 32));
    pub const flags_gravity: FontMask = @bitCast(@as(c_uint, 64));
    pub const flags_variations: FontMask = @bitCast(@as(c_uint, 128));
    pub const flags_features: FontMask = @bitCast(@as(c_uint, 256));
    extern fn pango_font_mask_get_type() usize;
    pub const getGObjectType = pango_font_mask_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that influence the behavior of `pango.Layout.deserialize`.
///
/// New members may be added to this enumeration over time.
pub const LayoutDeserializeFlags = packed struct(c_uint) {
    context: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
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

    pub const flags_default: LayoutDeserializeFlags = @bitCast(@as(c_uint, 0));
    pub const flags_context: LayoutDeserializeFlags = @bitCast(@as(c_uint, 1));
    extern fn pango_layout_deserialize_flags_get_type() usize;
    pub const getGObjectType = pango_layout_deserialize_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that influence the behavior of `pango.Layout.serialize`.
///
/// New members may be added to this enumeration over time.
pub const LayoutSerializeFlags = packed struct(c_uint) {
    context: bool = false,
    output: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
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

    pub const flags_default: LayoutSerializeFlags = @bitCast(@as(c_uint, 0));
    pub const flags_context: LayoutSerializeFlags = @bitCast(@as(c_uint, 1));
    pub const flags_output: LayoutSerializeFlags = @bitCast(@as(c_uint, 2));
    extern fn pango_layout_serialize_flags_get_type() usize;
    pub const getGObjectType = pango_layout_serialize_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags influencing the shaping process.
///
/// `PangoShapeFlags` can be passed to `pango.shapeWithFlags`.
pub const ShapeFlags = packed struct(c_uint) {
    round_positions: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
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

    pub const flags_none: ShapeFlags = @bitCast(@as(c_uint, 0));
    pub const flags_round_positions: ShapeFlags = @bitCast(@as(c_uint, 1));
    extern fn pango_shape_flags_get_type() usize;
    pub const getGObjectType = pango_shape_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These flags affect how Pango treats characters that are normally
/// not visible in the output.
pub const ShowFlags = packed struct(c_uint) {
    spaces: bool = false,
    line_breaks: bool = false,
    ignorables: bool = false,
    _padding3: bool = false,
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

    pub const flags_none: ShowFlags = @bitCast(@as(c_uint, 0));
    pub const flags_spaces: ShowFlags = @bitCast(@as(c_uint, 1));
    pub const flags_line_breaks: ShowFlags = @bitCast(@as(c_uint, 2));
    pub const flags_ignorables: ShowFlags = @bitCast(@as(c_uint, 4));
    extern fn pango_show_flags_get_type() usize;
    pub const getGObjectType = pango_show_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Create a new allow-breaks attribute.
///
/// If breaks are disabled, the range will be kept in a
/// single run, as far as possible.
extern fn pango_attr_allow_breaks_new(p_allow_breaks: c_int) *pango.Attribute;
pub const attrAllowBreaksNew = pango_attr_allow_breaks_new;

/// Create a new background alpha attribute.
extern fn pango_attr_background_alpha_new(p_alpha: u16) *pango.Attribute;
pub const attrBackgroundAlphaNew = pango_attr_background_alpha_new;

/// Create a new background color attribute.
extern fn pango_attr_background_new(p_red: u16, p_green: u16, p_blue: u16) *pango.Attribute;
pub const attrBackgroundNew = pango_attr_background_new;

/// Create a new baseline displacement attribute.
///
/// The effect of this attribute is to shift the baseline of a run,
/// relative to the run of preceding run.
///
/// <picture>
///   <source srcset="baseline-shift-dark.png" media="(prefers-color-scheme: dark)">
///   <img alt="Baseline Shift" src="baseline-shift-light.png">
/// </picture>
extern fn pango_attr_baseline_shift_new(p_shift: c_int) *pango.Attribute;
pub const attrBaselineShiftNew = pango_attr_baseline_shift_new;

/// Apply customization from attributes to the breaks in `attrs`.
///
/// The line breaks are assumed to have been produced
/// by `pango.defaultBreak` and `pango.tailorBreak`.
extern fn pango_attr_break(p_text: [*:0]const u8, p_length: c_int, p_attr_list: *pango.AttrList, p_offset: c_int, p_attrs: *[*]pango.LogAttr, p_attrs_len: c_int) void;
pub const attrBreak = pango_attr_break;

/// Create a new font fallback attribute.
///
/// If fallback is disabled, characters will only be
/// used from the closest matching font on the system.
/// No fallback will be done to other fonts on the system
/// that might contain the characters in the text.
extern fn pango_attr_fallback_new(p_enable_fallback: c_int) *pango.Attribute;
pub const attrFallbackNew = pango_attr_fallback_new;

/// Create a new font family attribute.
extern fn pango_attr_family_new(p_family: [*:0]const u8) *pango.Attribute;
pub const attrFamilyNew = pango_attr_family_new;

/// Create a new font scale attribute.
///
/// The effect of this attribute is to change the font size of a run,
/// relative to the size of preceding run.
extern fn pango_attr_font_scale_new(p_scale: pango.FontScale) *pango.Attribute;
pub const attrFontScaleNew = pango_attr_font_scale_new;

/// Create a new foreground alpha attribute.
extern fn pango_attr_foreground_alpha_new(p_alpha: u16) *pango.Attribute;
pub const attrForegroundAlphaNew = pango_attr_foreground_alpha_new;

/// Create a new foreground color attribute.
extern fn pango_attr_foreground_new(p_red: u16, p_green: u16, p_blue: u16) *pango.Attribute;
pub const attrForegroundNew = pango_attr_foreground_new;

/// Create a new gravity hint attribute.
extern fn pango_attr_gravity_hint_new(p_hint: pango.GravityHint) *pango.Attribute;
pub const attrGravityHintNew = pango_attr_gravity_hint_new;

/// Create a new gravity attribute.
extern fn pango_attr_gravity_new(p_gravity: pango.Gravity) *pango.Attribute;
pub const attrGravityNew = pango_attr_gravity_new;

/// Create a new insert-hyphens attribute.
///
/// Pango will insert hyphens when breaking lines in
/// the middle of a word. This attribute can be used
/// to suppress the hyphen.
extern fn pango_attr_insert_hyphens_new(p_insert_hyphens: c_int) *pango.Attribute;
pub const attrInsertHyphensNew = pango_attr_insert_hyphens_new;

/// Create a new letter-spacing attribute.
extern fn pango_attr_letter_spacing_new(p_letter_spacing: c_int) *pango.Attribute;
pub const attrLetterSpacingNew = pango_attr_letter_spacing_new;

/// Modify the height of logical line extents by a factor.
///
/// This affects the values returned by
/// `pango.LayoutLine.getExtents`,
/// `pango.LayoutLine.getPixelExtents` and
/// `pango.LayoutIter.getLineExtents`.
extern fn pango_attr_line_height_new(p_factor: f64) *pango.Attribute;
pub const attrLineHeightNew = pango_attr_line_height_new;

/// Override the height of logical line extents to be `height`.
///
/// This affects the values returned by
/// `pango.LayoutLine.getExtents`,
/// `pango.LayoutLine.getPixelExtents` and
/// `pango.LayoutIter.getLineExtents`.
extern fn pango_attr_line_height_new_absolute(p_height: c_int) *pango.Attribute;
pub const attrLineHeightNewAbsolute = pango_attr_line_height_new_absolute;

/// Create a new overline color attribute.
///
/// This attribute modifies the color of overlines.
/// If not set, overlines will use the foreground color.
extern fn pango_attr_overline_color_new(p_red: u16, p_green: u16, p_blue: u16) *pango.Attribute;
pub const attrOverlineColorNew = pango_attr_overline_color_new;

/// Create a new overline-style attribute.
extern fn pango_attr_overline_new(p_overline: pango.Overline) *pango.Attribute;
pub const attrOverlineNew = pango_attr_overline_new;

/// Create a new baseline displacement attribute.
extern fn pango_attr_rise_new(p_rise: c_int) *pango.Attribute;
pub const attrRiseNew = pango_attr_rise_new;

/// Create a new font size scale attribute.
///
/// The base font for the affected text will have
/// its size multiplied by `scale_factor`.
extern fn pango_attr_scale_new(p_scale_factor: f64) *pango.Attribute;
pub const attrScaleNew = pango_attr_scale_new;

/// Marks the range of the attribute as a single sentence.
///
/// Note that this may require adjustments to word and
/// sentence classification around the range.
extern fn pango_attr_sentence_new() *pango.Attribute;
pub const attrSentenceNew = pango_attr_sentence_new;

/// Create a new attribute that influences how invisible
/// characters are rendered.
extern fn pango_attr_show_new(p_flags: pango.ShowFlags) *pango.Attribute;
pub const attrShowNew = pango_attr_show_new;

/// Create a new font stretch attribute.
extern fn pango_attr_stretch_new(p_stretch: pango.Stretch) *pango.Attribute;
pub const attrStretchNew = pango_attr_stretch_new;

/// Create a new strikethrough color attribute.
///
/// This attribute modifies the color of strikethrough lines.
/// If not set, strikethrough lines will use the foreground color.
extern fn pango_attr_strikethrough_color_new(p_red: u16, p_green: u16, p_blue: u16) *pango.Attribute;
pub const attrStrikethroughColorNew = pango_attr_strikethrough_color_new;

/// Create a new strike-through attribute.
extern fn pango_attr_strikethrough_new(p_strikethrough: c_int) *pango.Attribute;
pub const attrStrikethroughNew = pango_attr_strikethrough_new;

/// Create a new font slant style attribute.
extern fn pango_attr_style_new(p_style: pango.Style) *pango.Attribute;
pub const attrStyleNew = pango_attr_style_new;

/// Create a new attribute that influences how characters
/// are transformed during shaping.
extern fn pango_attr_text_transform_new(p_transform: pango.TextTransform) *pango.Attribute;
pub const attrTextTransformNew = pango_attr_text_transform_new;

/// Create a new underline color attribute.
///
/// This attribute modifies the color of underlines.
/// If not set, underlines will use the foreground color.
extern fn pango_attr_underline_color_new(p_red: u16, p_green: u16, p_blue: u16) *pango.Attribute;
pub const attrUnderlineColorNew = pango_attr_underline_color_new;

/// Create a new underline-style attribute.
extern fn pango_attr_underline_new(p_underline: pango.Underline) *pango.Attribute;
pub const attrUnderlineNew = pango_attr_underline_new;

/// Create a new font variant attribute (normal or small caps).
extern fn pango_attr_variant_new(p_variant: pango.Variant) *pango.Attribute;
pub const attrVariantNew = pango_attr_variant_new;

/// Create a new font weight attribute.
extern fn pango_attr_weight_new(p_weight: pango.Weight) *pango.Attribute;
pub const attrWeightNew = pango_attr_weight_new;

/// Marks the range of the attribute as a single word.
///
/// Note that this may require adjustments to word and
/// sentence classification around the range.
extern fn pango_attr_word_new() *pango.Attribute;
pub const attrWordNew = pango_attr_word_new;

/// Determines possible line, word, and character breaks
/// for a string of Unicode text with a single analysis.
///
/// For most purposes you may want to use `pango.getLogAttrs`.
extern fn pango_break(p_text: [*:0]const u8, p_length: c_int, p_analysis: *pango.Analysis, p_attrs: *[*]pango.LogAttr, p_attrs_len: c_int) void;
pub const @"break" = pango_break;

/// This is the default break algorithm.
///
/// It applies rules from the [Unicode Line Breaking Algorithm](http://www.unicode.org/unicode/reports/tr14/)
/// without language-specific tailoring, therefore the `analyis` argument is unused
/// and can be `NULL`.
///
/// See `pango.tailorBreak` for language-specific breaks.
///
/// See `pango.attrBreak` for attribute-based customization.
extern fn pango_default_break(p_text: [*:0]const u8, p_length: c_int, p_analysis: ?*pango.Analysis, p_attrs: *[*]pango.LogAttr, p_attrs_len: c_int) void;
pub const defaultBreak = pango_default_break;

/// Converts extents from Pango units to device units.
///
/// The conversion is done by dividing by the `PANGO_SCALE` factor and
/// performing rounding.
///
/// The `inclusive` rectangle is converted by flooring the x/y coordinates
/// and extending width/height, such that the final rectangle completely
/// includes the original rectangle.
///
/// The `nearest` rectangle is converted by rounding the coordinates
/// of the rectangle to the nearest device unit (pixel).
///
/// The rule to which argument to use is: if you want the resulting device-space
/// rectangle to completely contain the original rectangle, pass it in as
/// `inclusive`. If you want two touching-but-not-overlapping rectangles stay
/// touching-but-not-overlapping after rounding to device units, pass them in
/// as `nearest`.
extern fn pango_extents_to_pixels(p_inclusive: ?*pango.Rectangle, p_nearest: ?*pango.Rectangle) void;
pub const extentsToPixels = pango_extents_to_pixels;

/// Searches a string the first character that has a strong
/// direction, according to the Unicode bidirectional algorithm.
extern fn pango_find_base_dir(p_text: [*:0]const u8, p_length: c_int) pango.Direction;
pub const findBaseDir = pango_find_base_dir;

/// Locates a paragraph boundary in `text`.
///
/// A boundary is caused by delimiter characters, such as
/// a newline, carriage return, carriage return-newline pair,
/// or Unicode paragraph separator character.
///
/// The index of the run of delimiters is returned in
/// `paragraph_delimiter_index`. The index of the start of the
/// next paragraph (index after all delimiters) is stored n
/// `next_paragraph_start`.
///
/// If no delimiters are found, both `paragraph_delimiter_index`
/// and `next_paragraph_start` are filled with the length of `text`
/// (an index one off the end).
extern fn pango_find_paragraph_boundary(p_text: [*:0]const u8, p_length: c_int, p_paragraph_delimiter_index: *c_int, p_next_paragraph_start: *c_int) void;
pub const findParagraphBoundary = pango_find_paragraph_boundary;

/// Computes a `PangoLogAttr` for each character in `text`.
///
/// The `attrs` array must have one `PangoLogAttr` for
/// each position in `text`; if `text` contains N characters,
/// it has N+1 positions, including the last position at the
/// end of the text. `text` should be an entire paragraph;
/// logical attributes can't be computed without context
/// (for example you need to see spaces on either side of
/// a word to know the word is a word).
extern fn pango_get_log_attrs(p_text: [*:0]const u8, p_length: c_int, p_level: c_int, p_language: *pango.Language, p_attrs: *[*]pango.LogAttr, p_attrs_len: c_int) void;
pub const getLogAttrs = pango_get_log_attrs;

/// Returns the mirrored character of a Unicode character.
///
/// Mirror characters are determined by the Unicode mirrored property.
extern fn pango_get_mirror_char(p_ch: u32, p_mirrored_ch: ?*u32) c_int;
pub const getMirrorChar = pango_get_mirror_char;

/// Checks if a character that should not be normally rendered.
///
/// This includes all Unicode characters with "ZERO WIDTH" in their name,
/// as well as *bidi* formatting characters, and a few other ones.
///
/// This is totally different from `glib.unicharIszerowidth` and is at best misnamed.
extern fn pango_is_zero_width(p_ch: u32) c_int;
pub const isZeroWidth = pango_is_zero_width;

/// Breaks a piece of text into segments with consistent directional
/// level and font.
///
/// Each byte of `text` will be contained in exactly one of the items in the
/// returned list; the generated list of items will be in logical order (the
/// start offsets of the items are ascending).
///
/// `cached_iter` should be an iterator over `attrs` currently positioned
/// at a range before or containing `start_index`; `cached_iter` will be
/// advanced to the range covering the position just after
/// `start_index` + `length`. (i.e. if itemizing in a loop, just keep passing
/// in the same `cached_iter`).
extern fn pango_itemize(p_context: *pango.Context, p_text: [*:0]const u8, p_start_index: c_int, p_length: c_int, p_attrs: *pango.AttrList, p_cached_iter: ?*pango.AttrIterator) *glib.List;
pub const itemize = pango_itemize;

/// Like ``pango.itemize``, but with an explicitly specified base direction.
///
/// The base direction is used when computing bidirectional levels.
/// `itemize` gets the base direction from the `PangoContext`
/// (see `pango.Context.setBaseDir`).
extern fn pango_itemize_with_base_dir(p_context: *pango.Context, p_base_dir: pango.Direction, p_text: [*:0]const u8, p_start_index: c_int, p_length: c_int, p_attrs: *pango.AttrList, p_cached_iter: ?*pango.AttrIterator) *glib.List;
pub const itemizeWithBaseDir = pango_itemize_with_base_dir;

/// Return the bidirectional embedding levels of the input paragraph.
///
/// The bidirectional embedding levels are defined by the [Unicode Bidirectional
/// Algorithm](http://www.unicode.org/reports/tr9/).
///
/// If the input base direction is a weak direction, the direction of the
/// characters in the text will determine the final resolved direction.
extern fn pango_log2vis_get_embedding_levels(p_text: [*:0]const u8, p_length: c_int, p_pbase_dir: *pango.Direction) [*]u8;
pub const log2visGetEmbeddingLevels = pango_log2vis_get_embedding_levels;

/// Finishes parsing markup.
///
/// After feeding a Pango markup parser some data with `glib.MarkupParseContext.parse`,
/// use this function to get the list of attributes and text out of the
/// markup. This function will not free `context`, use `glib.MarkupParseContext.free`
/// to do so.
extern fn pango_markup_parser_finish(p_context: *glib.MarkupParseContext, p_attr_list: ?**pango.AttrList, p_text: ?*[*:0]u8, p_accel_char: ?*u32, p_error: ?*?*glib.Error) c_int;
pub const markupParserFinish = pango_markup_parser_finish;

/// Incrementally parses marked-up text to create a plain-text string
/// and an attribute list.
///
/// See the [Pango Markup](pango_markup.html) docs for details about the
/// supported markup.
///
/// If `accel_marker` is nonzero, the given character will mark the
/// character following it as an accelerator. For example, `accel_marker`
/// might be an ampersand or underscore. All characters marked
/// as an accelerator will receive a `PANGO_UNDERLINE_LOW` attribute,
/// and the first character so marked will be returned in `accel_char`,
/// when calling `markupParserFinish`. Two `accel_marker` characters
/// following each other produce a single literal `accel_marker` character.
///
/// To feed markup to the parser, use `glib.MarkupParseContext.parse`
/// on the returned `glib.MarkupParseContext`. When done with feeding markup
/// to the parser, use `markupParserFinish` to get the data out
/// of it, and then use `glib.MarkupParseContext.free` to free it.
///
/// This function is designed for applications that read Pango markup
/// from streams. To simply parse a string containing Pango markup,
/// the `pango.parseMarkup` API is recommended instead.
extern fn pango_markup_parser_new(p_accel_marker: u32) *glib.MarkupParseContext;
pub const markupParserNew = pango_markup_parser_new;

/// Parses an enum type and stores the result in `value`.
///
/// If `str` does not match the nick name of any of the possible values
/// for the enum and is not an integer, `FALSE` is returned, a warning
/// is issued if `warn` is `TRUE`, and a string representing the list of
/// possible values is stored in `possible_values`. The list is
/// slash-separated, eg. "none/start/middle/end".
///
/// If failed and `possible_values` is not `NULL`, returned string should
/// be freed using `glib.free`.
extern fn pango_parse_enum(p_type: usize, p_str: ?[*:0]const u8, p_value: ?*c_int, p_warn: c_int, p_possible_values: ?*[*:0]u8) c_int;
pub const parseEnum = pango_parse_enum;

/// Parses marked-up text to create a plain-text string and an attribute list.
///
/// See the [Pango Markup](pango_markup.html) docs for details about the
/// supported markup.
///
/// If `accel_marker` is nonzero, the given character will mark the
/// character following it as an accelerator. For example, `accel_marker`
/// might be an ampersand or underscore. All characters marked
/// as an accelerator will receive a `PANGO_UNDERLINE_LOW` attribute,
/// and the first character so marked will be returned in `accel_char`.
/// Two `accel_marker` characters following each other produce a single
/// literal `accel_marker` character.
///
/// To parse a stream of pango markup incrementally, use `markupParserNew`.
///
/// If any error happens, none of the output arguments are touched except
/// for `error`.
extern fn pango_parse_markup(p_markup_text: [*:0]const u8, p_length: c_int, p_accel_marker: u32, p_attr_list: ?**pango.AttrList, p_text: ?*[*:0]u8, p_accel_char: ?*u32, p_error: ?*?*glib.Error) c_int;
pub const parseMarkup = pango_parse_markup;

/// Parses a font stretch.
///
/// The allowed values are
/// "ultra_condensed", "extra_condensed", "condensed",
/// "semi_condensed", "normal", "semi_expanded", "expanded",
/// "extra_expanded" and "ultra_expanded". Case variations are
/// ignored and the '_' characters may be omitted.
extern fn pango_parse_stretch(p_str: [*:0]const u8, p_stretch: *pango.Stretch, p_warn: c_int) c_int;
pub const parseStretch = pango_parse_stretch;

/// Parses a font style.
///
/// The allowed values are "normal", "italic" and "oblique", case
/// variations being
/// ignored.
extern fn pango_parse_style(p_str: [*:0]const u8, p_style: *pango.Style, p_warn: c_int) c_int;
pub const parseStyle = pango_parse_style;

/// Parses a font variant.
///
/// The allowed values are "normal", "small-caps", "all-small-caps",
/// "petite-caps", "all-petite-caps", "unicase" and "title-caps",
/// case variations being ignored.
extern fn pango_parse_variant(p_str: [*:0]const u8, p_variant: *pango.Variant, p_warn: c_int) c_int;
pub const parseVariant = pango_parse_variant;

/// Parses a font weight.
///
/// The allowed values are "heavy",
/// "ultrabold", "bold", "normal", "light", "ultraleight"
/// and integers. Case variations are ignored.
extern fn pango_parse_weight(p_str: [*:0]const u8, p_weight: *pango.Weight, p_warn: c_int) c_int;
pub const parseWeight = pango_parse_weight;

/// Quantizes the thickness and position of a line to whole device pixels.
///
/// This is typically used for underline or strikethrough. The purpose of
/// this function is to avoid such lines looking blurry.
///
/// Care is taken to make sure `thickness` is at least one pixel when this
/// function returns, but returned `position` may become zero as a result
/// of rounding.
extern fn pango_quantize_line_geometry(p_thickness: *c_int, p_position: *c_int) void;
pub const quantizeLineGeometry = pango_quantize_line_geometry;

/// Reads an entire line from a file into a buffer.
///
/// Lines may be delimited with '\n', '\r', '\n\r', or '\r\n'. The delimiter
/// is not written into the buffer. Text after a '#' character is treated as
/// a comment and skipped. '\' can be used to escape a # character.
/// '\' proceeding a line delimiter combines adjacent lines. A '\' proceeding
/// any other character is ignored and written into the output buffer
/// unmodified.
extern fn pango_read_line(p_stream: ?*anyopaque, p_str: *glib.String) c_int;
pub const readLine = pango_read_line;

/// Reorder items from logical order to visual order.
///
/// The visual order is determined from the associated directional
/// levels of the items. The original list is unmodified.
///
/// (Please open a bug if you use this function.
///  It is not a particularly convenient interface, and the code
///  is duplicated elsewhere in Pango for that reason.)
extern fn pango_reorder_items(p_items: *glib.List) *glib.List;
pub const reorderItems = pango_reorder_items;

/// Scans an integer.
///
/// Leading white space is skipped.
extern fn pango_scan_int(p_pos: *[*:0]const u8, p_out: *c_int) c_int;
pub const scanInt = pango_scan_int;

/// Scans a string into a `GString` buffer.
///
/// The string may either be a sequence of non-white-space characters,
/// or a quoted string with '"'. Instead a quoted string, '\"' represents
/// a literal quote. Leading white space outside of quotes is skipped.
extern fn pango_scan_string(p_pos: *[*:0]const u8, p_out: *glib.String) c_int;
pub const scanString = pango_scan_string;

/// Scans a word into a `GString` buffer.
///
/// A word consists of [A-Za-z_] followed by zero or more
/// [A-Za-z_0-9]. Leading white space is skipped.
extern fn pango_scan_word(p_pos: *[*:0]const u8, p_out: *glib.String) c_int;
pub const scanWord = pango_scan_word;

/// Convert the characters in `text` into glyphs.
///
/// Given a segment of text and the corresponding `PangoAnalysis` structure
/// returned from `pango.itemize`, convert the characters into glyphs. You
/// may also pass in only a substring of the item from `pango.itemize`.
///
/// It is recommended that you use `pango.shapeFull` instead, since
/// that API allows for shaping interaction happening across text item
/// boundaries.
///
/// Some aspects of hyphen insertion and text transformation (in particular,
/// capitalization) require log attrs, and thus can only be handled by
/// `pango.shapeItem`.
///
/// Note that the extra attributes in the `analyis` that is returned from
/// `pango.itemize` have indices that are relative to the entire paragraph,
/// so you need to subtract the item offset from their indices before
/// calling `pango.shape`.
extern fn pango_shape(p_text: [*:0]const u8, p_length: c_int, p_analysis: *const pango.Analysis, p_glyphs: *pango.GlyphString) void;
pub const shape = pango_shape;

/// Convert the characters in `text` into glyphs.
///
/// Given a segment of text and the corresponding `PangoAnalysis` structure
/// returned from `pango.itemize`, convert the characters into glyphs.
/// You may also pass in only a substring of the item from `pango.itemize`.
///
/// This is similar to `pango.shape`, except it also can optionally take
/// the full paragraph text as input, which will then be used to perform
/// certain cross-item shaping interactions. If you have access to the broader
/// text of which `item_text` is part of, provide the broader text as
/// `paragraph_text`. If `paragraph_text` is `NULL`, item text is used instead.
///
/// Some aspects of hyphen insertion and text transformation (in particular,
/// capitalization) require log attrs, and thus can only be handled by
/// `pango.shapeItem`.
///
/// Note that the extra attributes in the `analyis` that is returned from
/// `pango.itemize` have indices that are relative to the entire paragraph,
/// so you do not pass the full paragraph text as `paragraph_text`, you need
/// to subtract the item offset from their indices before calling
/// `pango.shapeFull`.
extern fn pango_shape_full(p_item_text: [*:0]const u8, p_item_length: c_int, p_paragraph_text: ?[*:0]const u8, p_paragraph_length: c_int, p_analysis: *const pango.Analysis, p_glyphs: *pango.GlyphString) void;
pub const shapeFull = pango_shape_full;

/// Convert the characters in `item` into glyphs.
///
/// This is similar to `pango.shapeWithFlags`, except it takes a
/// `PangoItem` instead of separate `item_text` and `analysis` arguments.
///
/// It also takes `log_attrs`, which are needed for implementing some aspects
/// of hyphen insertion and text transforms (in particular, capitalization).
///
/// Note that the extra attributes in the `analyis` that is returned from
/// `pango.itemize` have indices that are relative to the entire paragraph,
/// so you do not pass the full paragraph text as `paragraph_text`, you need
/// to subtract the item offset from their indices before calling
/// `pango.shapeWithFlags`.
extern fn pango_shape_item(p_item: *pango.Item, p_paragraph_text: ?[*:0]const u8, p_paragraph_length: c_int, p_log_attrs: ?*pango.LogAttr, p_glyphs: *pango.GlyphString, p_flags: pango.ShapeFlags) void;
pub const shapeItem = pango_shape_item;

/// Convert the characters in `text` into glyphs.
///
/// Given a segment of text and the corresponding `PangoAnalysis` structure
/// returned from `pango.itemize`, convert the characters into glyphs.
/// You may also pass in only a substring of the item from `pango.itemize`.
///
/// This is similar to `pango.shapeFull`, except it also takes flags
/// that can influence the shaping process.
///
/// Some aspects of hyphen insertion and text transformation (in particular,
/// capitalization) require log attrs, and thus can only be handled by
/// `pango.shapeItem`.
///
/// Note that the extra attributes in the `analyis` that is returned from
/// `pango.itemize` have indices that are relative to the entire paragraph,
/// so you do not pass the full paragraph text as `paragraph_text`, you need
/// to subtract the item offset from their indices before calling
/// `pango.shapeWithFlags`.
extern fn pango_shape_with_flags(p_item_text: [*:0]const u8, p_item_length: c_int, p_paragraph_text: ?[*:0]const u8, p_paragraph_length: c_int, p_analysis: *const pango.Analysis, p_glyphs: *pango.GlyphString, p_flags: pango.ShapeFlags) void;
pub const shapeWithFlags = pango_shape_with_flags;

/// Skips 0 or more characters of white space.
extern fn pango_skip_space(p_pos: *[*:0]const u8) c_int;
pub const skipSpace = pango_skip_space;

/// Splits a `G_SEARCHPATH_SEPARATOR`-separated list of files, stripping
/// white space and substituting ~/ with $HOME/.
extern fn pango_split_file_list(p_str: [*:0]const u8) [*][*:0]u8;
pub const splitFileList = pango_split_file_list;

/// Apply language-specific tailoring to the breaks in `attrs`.
///
/// The line breaks are assumed to have been produced by `pango.defaultBreak`.
///
/// If `offset` is not -1, it is used to apply attributes from `analysis` that are
/// relevant to line breaking.
///
/// Note that it is better to pass -1 for `offset` and use `pango.attrBreak`
/// to apply attributes to the whole paragraph.
extern fn pango_tailor_break(p_text: [*:0]const u8, p_length: c_int, p_analysis: *pango.Analysis, p_offset: c_int, p_attrs: *[*]pango.LogAttr, p_attrs_len: c_int) void;
pub const tailorBreak = pango_tailor_break;

/// Trims leading and trailing whitespace from a string.
extern fn pango_trim_string(p_str: [*:0]const u8) [*:0]u8;
pub const trimString = pango_trim_string;

/// Determines the inherent direction of a character.
///
/// The inherent direction is either `PANGO_DIRECTION_LTR`, `PANGO_DIRECTION_RTL`,
/// or `PANGO_DIRECTION_NEUTRAL`.
///
/// This function is useful to categorize characters into left-to-right
/// letters, right-to-left letters, and everything else. If full Unicode
/// bidirectional type of a character is needed, `pango.BidiType.forUnichar`
/// can be used instead.
extern fn pango_unichar_direction(p_ch: u32) pango.Direction;
pub const unicharDirection = pango_unichar_direction;

/// Converts a floating-point number to Pango units.
///
/// The conversion is done by multiplying `d` by `PANGO_SCALE` and
/// rounding the result to nearest integer.
extern fn pango_units_from_double(p_d: f64) c_int;
pub const unitsFromDouble = pango_units_from_double;

/// Converts a number in Pango units to floating-point.
///
/// The conversion is done by dividing `i` by `PANGO_SCALE`.
extern fn pango_units_to_double(p_i: c_int) f64;
pub const unitsToDouble = pango_units_to_double;

/// Returns the encoded version of Pango available at run-time.
///
/// This is similar to the macro `PANGO_VERSION` except that the macro
/// returns the encoded version available at compile-time. A version
/// number can be encoded into an integer using `PANGO_VERSION_ENCODE`.
extern fn pango_version() c_int;
pub const version = pango_version;

/// Checks that the Pango library in use is compatible with the
/// given version.
///
/// Generally you would pass in the constants `PANGO_VERSION_MAJOR`,
/// `PANGO_VERSION_MINOR`, `PANGO_VERSION_MICRO` as the three arguments
/// to this function; that produces a check that the library in use at
/// run-time is compatible with the version of Pango the application or
/// module was compiled against.
///
/// Compatibility is defined by two things: first the version
/// of the running library is newer than the version
/// `required_major`.required_minor.`required_micro`. Second
/// the running library must be binary compatible with the
/// version `required_major`.required_minor.`required_micro`
/// (same major version.)
///
/// For compile-time version checking use `PANGO_VERSION_CHECK`.
extern fn pango_version_check(p_required_major: c_int, p_required_minor: c_int, p_required_micro: c_int) ?[*:0]const u8;
pub const versionCheck = pango_version_check;

/// Returns the version of Pango available at run-time.
///
/// This is similar to the macro `PANGO_VERSION_STRING` except that the
/// macro returns the version available at compile-time.
extern fn pango_version_string() [*:0]const u8;
pub const versionString = pango_version_string;

/// Type of a function that can duplicate user data for an attribute.
pub const AttrDataCopyFunc = *const fn (p_user_data: ?*const anyopaque) callconv(.c) ?*anyopaque;

/// Type of a function filtering a list of attributes.
pub const AttrFilterFunc = *const fn (p_attribute: *pango.Attribute, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Callback used when enumerating fonts in a fontset.
///
/// See `pango.Fontset.foreach`.
pub const FontsetForeachFunc = *const fn (p_fontset: *pango.Fontset, p_font: *pango.Font, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Whether the segment should be shifted to center around the baseline.
///
/// This is mainly used in vertical writing directions.
pub const ANALYSIS_FLAG_CENTERED_BASELINE = 1;
/// Whether this run holds ellipsized text.
pub const ANALYSIS_FLAG_IS_ELLIPSIS = 2;
/// Whether to add a hyphen at the end of the run during shaping.
pub const ANALYSIS_FLAG_NEED_HYPHEN = 4;
/// Value for `start_index` in `PangoAttribute` that indicates
/// the beginning of the text.
pub const ATTR_INDEX_FROM_TEXT_BEGINNING = 0;
/// Value for `end_index` in `PangoAttribute` that indicates
/// the end of the text.
pub const ATTR_INDEX_TO_TEXT_END = 4294967295;
/// A `PangoGlyph` value that indicates a zero-width empty glpyh.
///
/// This is useful for example in shaper modules, to use as the glyph for
/// various zero-width Unicode characters (those passing `isZeroWidth`).
pub const GLYPH_EMPTY = 268435455;
/// A `PangoGlyph` value for invalid input.
///
/// `PangoLayout` produces one such glyph per invalid input UTF-8 byte and such
/// a glyph is rendered as a crossed box.
///
/// Note that this value is defined such that it has the `PANGO_GLYPH_UNKNOWN_FLAG`
/// set.
pub const GLYPH_INVALID_INPUT = 4294967295;
/// Flag used in `PangoGlyph` to turn a `gunichar` value of a valid Unicode
/// character into an unknown-character glyph for that `gunichar`.
///
/// Such unknown-character glyphs may be rendered as a 'hex box'.
pub const GLYPH_UNKNOWN_FLAG = 268435456;
/// The scale between dimensions used for Pango distances and device units.
///
/// The definition of device units is dependent on the output device; it will
/// typically be pixels for a screen, and points for a printer. `PANGO_SCALE` is
/// currently 1024, but this may be changed in the future.
///
/// When setting font sizes, device units are always considered to be
/// points (as in "12 point font"), rather than pixels.
pub const SCALE = 1024;
/// The major component of the version of Pango available at compile-time.
pub const VERSION_MAJOR = 1;
/// The micro component of the version of Pango available at compile-time.
pub const VERSION_MICRO = 3;
/// The minor component of the version of Pango available at compile-time.
pub const VERSION_MINOR = 56;
/// A string literal containing the version of Pango available at compile-time.
pub const VERSION_STRING = "1.56.3";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
