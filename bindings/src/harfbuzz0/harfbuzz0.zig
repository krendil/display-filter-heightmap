pub const ext = @import("ext.zig");
const harfbuzz = @This();

const std = @import("std");
const compat = @import("compat");
const freetype2 = @import("freetype22");
const gobject = @import("gobject2");
const glib = @import("glib2");
/// Data type for booleans.
pub const bool_t = c_int;

/// Data type for holding Unicode codepoints. Also
/// used to hold glyph IDs.
pub const codepoint_t = u32;

/// Data type for holding color values. Colors are eight bits per
/// channel RGB plus alpha transparency.
pub const color_t = u32;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the extents for a font, for horizontal-direction
/// text segments. Extents must be returned in an `hb_glyph_extents` output
/// parameter.
pub const font_get_font_h_extents_func_t = harfbuzz.font_get_font_extents_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the extents for a font, for vertical-direction
/// text segments. Extents must be returned in an `hb_glyph_extents` output
/// parameter.
pub const font_get_font_v_extents_func_t = harfbuzz.font_get_font_extents_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advance for a specified glyph, in
/// horizontal-direction text segments. Advances must be returned in
/// an `harfbuzz.position_t` output parameter.
pub const font_get_glyph_h_advance_func_t = harfbuzz.font_get_glyph_advance_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advances for a sequence of glyphs, in
/// horizontal-direction text segments.
pub const font_get_glyph_h_advances_func_t = harfbuzz.font_get_glyph_advances_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the kerning-adjustment value for a glyph-pair in
/// the specified font, for horizontal text segments.
pub const font_get_glyph_h_kerning_func_t = harfbuzz.font_get_glyph_kerning_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the (X,Y) coordinates (in font units) of the
/// origin for a glyph, for horizontal-direction text segments. Each
/// coordinate must be returned in an `harfbuzz.position_t` output parameter.
pub const font_get_glyph_h_origin_func_t = harfbuzz.font_get_glyph_origin_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advance for a specified glyph, in
/// vertical-direction text segments. Advances must be returned in
/// an `harfbuzz.position_t` output parameter.
pub const font_get_glyph_v_advance_func_t = harfbuzz.font_get_glyph_advance_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advances for a sequence of glyphs, in
/// vertical-direction text segments.
pub const font_get_glyph_v_advances_func_t = harfbuzz.font_get_glyph_advances_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the kerning-adjustment value for a glyph-pair in
/// the specified font, for vertical text segments.
pub const font_get_glyph_v_kerning_func_t = harfbuzz.font_get_glyph_kerning_func_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the (X,Y) coordinates (in font units) of the
/// origin for a glyph, for vertical-direction text segments. Each coordinate
/// must be returned in an `harfbuzz.position_t` output parameter.
pub const font_get_glyph_v_origin_func_t = harfbuzz.font_get_glyph_origin_func_t;

/// Data type for bitmasks.
pub const mask_t = u32;

/// An integral type representing an OpenType 'name' table name identifier.
/// There are predefined name IDs, as well as name IDs return from other
/// API.  These can be used to fetch name strings from a font face.
pub const ot_name_id_t = c_uint;

/// Data type for holding a single coordinate value.
/// Contour points and other multi-dimensional data are
/// stored as tuples of `harfbuzz.position_t`'s.
pub const position_t = i32;

/// Data type for tag identifiers. Tags are four
/// byte integers, each byte representing a character.
///
/// Tags are used to identify tables, design-variation axes,
/// scripts, languages, font features, and baselines with
/// human-readable names.
pub const tag_t = u32;

/// Structure representing a setting for an `harfbuzz.aat_layout_feature_type_t`.
pub const aat_layout_feature_selector_info_t = extern struct {
    /// The selector's name identifier
    f_name_id: harfbuzz.ot_name_id_t,
    /// The value to turn the selector on
    f_enable: harfbuzz.aat_layout_feature_selector_t,
    /// The value to turn the selector off
    f_disable: harfbuzz.aat_layout_feature_selector_t,
    f_reserved: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for blobs. A blob wraps a chunk of binary
/// data and facilitates its lifecycle management between
/// a client program and HarfBuzz.
pub const blob_t = opaque {
    extern fn hb_gobject_blob_get_type() usize;
    pub const getGObjectType = hb_gobject_blob_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The main structure holding the input text and its properties before shaping,
/// and output glyphs and their information after shaping.
pub const buffer_t = opaque {
    extern fn hb_gobject_buffer_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A struct containing color information for a gradient.
pub const color_line_t = extern struct {
    f_data: ?*anyopaque,
    f_get_color_stops: ?harfbuzz.color_line_get_color_stops_func_t,
    f_get_color_stops_user_data: ?*anyopaque,
    f_get_extend: ?harfbuzz.color_line_get_extend_func_t,
    f_get_extend_user_data: ?*anyopaque,
    f_reserved0: ?*anyopaque,
    f_reserved1: ?*anyopaque,
    f_reserved2: ?*anyopaque,
    f_reserved3: ?*anyopaque,
    f_reserved5: ?*anyopaque,
    f_reserved6: ?*anyopaque,
    f_reserved7: ?*anyopaque,
    f_reserved8: ?*anyopaque,

    extern fn hb_gobject_color_line_get_type() usize;
    pub const getGObjectType = hb_gobject_color_line_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Information about a color stop on a color line.
///
/// Color lines typically have offsets ranging between 0 and 1,
/// but that is not required.
///
/// Note: despite `color` being unpremultiplied here, interpolation in
/// gradients shall happen in premultiplied space. See the OpenType spec
/// [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details.
pub const color_stop_t = extern struct {
    /// the offset of the color stop
    f_offset: f32,
    /// whether the color is the foreground
    f_is_foreground: harfbuzz.bool_t,
    /// the color, unpremultiplied
    f_color: harfbuzz.color_t,

    extern fn hb_gobject_color_stop_get_type() usize;
    pub const getGObjectType = hb_gobject_color_stop_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Glyph draw callbacks.
///
/// `harfbuzz.draw_move_to_func_t`, `harfbuzz.draw_line_to_func_t` and
/// `harfbuzz.draw_cubic_to_func_t` calls are necessary to be defined but we translate
/// `harfbuzz.draw_quadratic_to_func_t` calls to `harfbuzz.draw_cubic_to_func_t` if the
/// callback isn't defined.
pub const draw_funcs_t = opaque {
    extern fn hb_gobject_draw_funcs_get_type() usize;
    pub const getGObjectType = hb_gobject_draw_funcs_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Current drawing state.
pub const draw_state_t = extern struct {
    /// Whether there is an open path
    f_path_open: harfbuzz.bool_t,
    /// X component of the start of current path
    f_path_start_x: f32,
    /// Y component of the start of current path
    f_path_start_y: f32,
    /// X component of current point
    f_current_x: f32,
    /// Y component of current point
    f_current_y: f32,
    f_reserved1: harfbuzz.var_num_t,
    f_reserved2: harfbuzz.var_num_t,
    f_reserved3: harfbuzz.var_num_t,
    f_reserved4: harfbuzz.var_num_t,
    f_reserved5: harfbuzz.var_num_t,
    f_reserved6: harfbuzz.var_num_t,
    f_reserved7: harfbuzz.var_num_t,

    extern fn hb_gobject_draw_state_get_type() usize;
    pub const getGObjectType = hb_gobject_draw_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding font faces.
pub const face_t = opaque {
    extern fn hb_gobject_face_get_type() usize;
    pub const getGObjectType = hb_gobject_face_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `harfbuzz.feature_t` is the structure that holds information about requested
/// feature application. The feature will be applied with the given value to all
/// glyphs which are in clusters between `start` (inclusive) and `end` (exclusive).
/// Setting start to `HB_FEATURE_GLOBAL_START` and end to `HB_FEATURE_GLOBAL_END`
/// specifies that the feature always applies to the entire buffer.
pub const feature_t = extern struct {
    /// The `harfbuzz.tag_t` tag of the feature
    f_tag: harfbuzz.tag_t,
    /// The value of the feature. 0 disables the feature, non-zero (usually
    /// 1) enables the feature.  For features implemented as lookup type 3 (like
    /// 'salt') the `value` is a one based index into the alternates.
    f_value: u32,
    /// the cluster to start applying this feature setting (inclusive).
    f_start: c_uint,
    /// the cluster to end applying this feature setting (exclusive).
    f_end: c_uint,

    extern fn hb_gobject_feature_get_type() usize;
    pub const getGObjectType = hb_gobject_feature_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Font-wide extent values, measured in font units.
///
/// Note that typically `ascender` is positive and `descender`
/// negative, in coordinate systems that grow up.
pub const font_extents_t = extern struct {
    /// The height of typographic ascenders.
    f_ascender: harfbuzz.position_t,
    /// The depth of typographic descenders.
    f_descender: harfbuzz.position_t,
    /// The suggested line-spacing gap.
    f_line_gap: harfbuzz.position_t,
    f_reserved9: harfbuzz.position_t,
    f_reserved8: harfbuzz.position_t,
    f_reserved7: harfbuzz.position_t,
    f_reserved6: harfbuzz.position_t,
    f_reserved5: harfbuzz.position_t,
    f_reserved4: harfbuzz.position_t,
    f_reserved3: harfbuzz.position_t,
    f_reserved2: harfbuzz.position_t,
    f_reserved1: harfbuzz.position_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type containing a set of virtual methods used for
/// working on `harfbuzz.font_t` font objects.
///
/// HarfBuzz provides a lightweight default function for each of
/// the methods in `harfbuzz.font_funcs_t`. Client programs can implement
/// their own replacements for the individual font functions, as
/// needed, and replace the default by calling the setter for a
/// method.
pub const font_funcs_t = opaque {
    extern fn hb_gobject_font_funcs_get_type() usize;
    pub const getGObjectType = hb_gobject_font_funcs_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding fonts.
pub const font_t = opaque {
    extern fn hb_gobject_font_get_type() usize;
    pub const getGObjectType = hb_gobject_font_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Glyph extent values, measured in font units.
///
/// Note that `height` is negative, in coordinate systems that grow up.
pub const glyph_extents_t = extern struct {
    /// Distance from the x-origin to the left extremum of the glyph.
    f_x_bearing: harfbuzz.position_t,
    /// Distance from the top extremum of the glyph to the y-origin.
    f_y_bearing: harfbuzz.position_t,
    /// Distance from the left extremum of the glyph to the right extremum.
    f_width: harfbuzz.position_t,
    /// Distance from the top extremum of the glyph to the bottom extremum.
    f_height: harfbuzz.position_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `harfbuzz.glyph_info_t` is the structure that holds information about the
/// glyphs and their relation to input text.
pub const glyph_info_t = extern struct {
    /// either a Unicode code point (before shaping) or a glyph index
    ///             (after shaping).
    f_codepoint: harfbuzz.codepoint_t,
    f_mask: harfbuzz.mask_t,
    /// the index of the character in the original text that corresponds
    ///           to this `harfbuzz.glyph_info_t`, or whatever the client passes to
    ///           `harfbuzz.bufferAdd`. More than one `harfbuzz.glyph_info_t` can have the same
    ///           `cluster` value, if they resulted from the same character (e.g. one
    ///           to many glyph substitution), and when more than one character gets
    ///           merged in the same glyph (e.g. many to one glyph substitution) the
    ///           `harfbuzz.glyph_info_t` will have the smallest cluster value of them.
    ///           By default some characters are merged into the same cluster
    ///           (e.g. combining marks have the same cluster as their bases)
    ///           even if they are separate glyphs, `harfbuzz.bufferSetClusterLevel`
    ///           allow selecting more fine-grained cluster handling.
    f_cluster: u32,
    f_var1: harfbuzz.var_int_t,
    f_var2: harfbuzz.var_int_t,

    extern fn hb_gobject_glyph_info_get_type() usize;
    pub const getGObjectType = hb_gobject_glyph_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `harfbuzz.glyph_position_t` is the structure that holds the positions of the
/// glyph in both horizontal and vertical directions. All positions in
/// `harfbuzz.glyph_position_t` are relative to the current point.
pub const glyph_position_t = extern struct {
    /// how much the line advances after drawing this glyph when setting
    ///             text in horizontal direction.
    f_x_advance: harfbuzz.position_t,
    /// how much the line advances after drawing this glyph when setting
    ///             text in vertical direction.
    f_y_advance: harfbuzz.position_t,
    /// how much the glyph moves on the X-axis before drawing it, this
    ///            should not affect how much the line advances.
    f_x_offset: harfbuzz.position_t,
    /// how much the glyph moves on the Y-axis before drawing it, this
    ///            should not affect how much the line advances.
    f_y_offset: harfbuzz.position_t,
    f_var: harfbuzz.var_int_t,

    extern fn hb_gobject_glyph_position_get_type() usize;
    pub const getGObjectType = hb_gobject_glyph_position_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for languages. Each `harfbuzz.language_t` corresponds to a BCP 47
/// language tag.
pub const language_t = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding integer-to-integer hash maps.
pub const map_t = opaque {
    extern fn hb_gobject_map_get_type() usize;
    pub const getGObjectType = hb_gobject_map_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Pairs of glyph and color index.
///
/// A color index of 0xFFFF does not refer to a palette
/// color, but indicates that the foreground color should
/// be used.
pub const ot_color_layer_t = extern struct {
    /// the glyph ID of the layer
    f_glyph: harfbuzz.codepoint_t,
    /// the palette color index of the layer
    f_color_index: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type to hold information for a "part" component of a math-variant glyph.
/// Large variants for stretchable math glyphs (such as parentheses) can be constructed
/// on the fly from parts.
pub const ot_math_glyph_part_t = extern struct {
    /// The glyph index of the variant part
    f_glyph: harfbuzz.codepoint_t,
    /// The length of the connector on the starting side of the variant part
    f_start_connector_length: harfbuzz.position_t,
    /// The length of the connector on the ending side of the variant part
    f_end_connector_length: harfbuzz.position_t,
    /// The total advance of the part
    f_full_advance: harfbuzz.position_t,
    /// `harfbuzz.ot_math_glyph_part_flags_t` flags for the part
    f_flags: harfbuzz.ot_math_glyph_part_flags_t,

    extern fn hb_gobject_ot_math_glyph_part_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_math_glyph_part_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type to hold math-variant information for a glyph.
pub const ot_math_glyph_variant_t = extern struct {
    /// The glyph index of the variant
    f_glyph: harfbuzz.codepoint_t,
    /// The advance width of the variant
    f_advance: harfbuzz.position_t,

    extern fn hb_gobject_ot_math_glyph_variant_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_math_glyph_variant_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type to hold math kerning (cut-in) information for a glyph.
pub const ot_math_kern_entry_t = extern struct {
    /// The maximum height at which this entry should be used
    f_max_correction_height: harfbuzz.position_t,
    /// The kern value of the entry
    f_kern_value: harfbuzz.position_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Structure representing a name ID in a particular language.
pub const ot_name_entry_t = extern struct {
    /// name ID
    f_name_id: harfbuzz.ot_name_id_t,
    f_var: harfbuzz.var_int_t,
    /// language
    f_language: ?harfbuzz.language_t,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding variation-axis values.
///
/// The minimum, default, and maximum values are in un-normalized, user scales.
///
/// <note>Note: at present, the only flag defined for `flags` is
/// `HB_OT_VAR_AXIS_FLAG_HIDDEN`.</note>
pub const ot_var_axis_info_t = extern struct {
    /// Index of the axis in the variation-axis array
    f_axis_index: c_uint,
    /// The `harfbuzz.tag_t` tag identifying the design variation of the axis
    f_tag: harfbuzz.tag_t,
    /// The `name` table Name ID that provides display names for the axis
    f_name_id: harfbuzz.ot_name_id_t,
    /// The `harfbuzz.ot_var_axis_flags_t` flags for the axis
    f_flags: harfbuzz.ot_var_axis_flags_t,
    /// The minimum value on the variation axis that the font covers
    f_min_value: f32,
    /// The position on the variation axis corresponding to the font's defaults
    f_default_value: f32,
    /// The maximum value on the variation axis that the font covers
    f_max_value: f32,
    f_reserved: c_uint,

    extern fn hb_gobject_ot_var_axis_info_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_var_axis_info_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Use `harfbuzz.ot_var_axis_info_t` instead.
pub const ot_var_axis_t = extern struct {
    /// axis tag
    f_tag: harfbuzz.tag_t,
    /// axis name identifier
    f_name_id: harfbuzz.ot_name_id_t,
    /// minimum value of the axis
    f_min_value: f32,
    /// default value of the axis
    f_default_value: f32,
    /// maximum value of the axis
    f_max_value: f32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Glyph paint callbacks.
///
/// The callbacks assume that the caller maintains a stack
/// of current transforms, clips and intermediate surfaces,
/// as evidenced by the pairs of push/pop callbacks. The
/// push/pop calls will be properly nested, so it is fine
/// to store the different kinds of object on a single stack.
///
/// Not all callbacks are required for all kinds of glyphs.
/// For rendering COLRv0 or non-color outline glyphs, the
/// gradient callbacks are not needed, and the composite
/// callback only needs to handle simple alpha compositing
/// (`HB_PAINT_COMPOSITE_MODE_SRC_OVER`).
///
/// The paint-image callback is only needed for glyphs
/// with image blobs in the CBDT, sbix or SVG tables.
///
/// The custom-palette-color callback is only necessary if
/// you want to override colors from the font palette with
/// custom colors.
pub const paint_funcs_t = opaque {
    extern fn hb_gobject_paint_funcs_get_type() usize;
    pub const getGObjectType = hb_gobject_paint_funcs_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The structure that holds various text properties of an `harfbuzz.buffer_t`. Can be
/// set and retrieved using `harfbuzz.bufferSetSegmentProperties` and
/// `harfbuzz.bufferGetSegmentProperties`, respectively.
pub const segment_properties_t = extern struct {
    /// the `harfbuzz.direction_t` of the buffer, see `harfbuzz.bufferSetDirection`.
    f_direction: harfbuzz.direction_t,
    /// the `harfbuzz.script_t` of the buffer, see `harfbuzz.bufferSetScript`.
    f_script: harfbuzz.script_t,
    /// the `harfbuzz.language_t` of the buffer, see `harfbuzz.bufferSetLanguage`.
    f_language: ?harfbuzz.language_t,
    f_reserved1: ?*anyopaque,
    f_reserved2: ?*anyopaque,

    extern fn hb_gobject_segment_properties_get_type() usize;
    pub const getGObjectType = hb_gobject_segment_properties_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding a set of integers. `harfbuzz.set_t`'s are
/// used to gather and contain glyph IDs, Unicode code
/// points, and various other collections of discrete
/// values.
pub const set_t = opaque {
    extern fn hb_gobject_set_get_type() usize;
    pub const getGObjectType = hb_gobject_set_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding a shaping plan.
///
/// Shape plans contain information about how HarfBuzz will shape a
/// particular text segment, based on the segment's properties and the
/// capabilities in the font face in use.
///
/// Shape plans can be queried about how shaping will perform, given a set
/// of specific input parameters (script, language, direction, features,
/// etc.).
pub const shape_plan_t = opaque {
    extern fn hb_gobject_shape_plan_get_type() usize;
    pub const getGObjectType = hb_gobject_shape_plan_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type containing a set of virtual methods used for
/// accessing various Unicode character properties.
///
/// HarfBuzz provides a default function for each of the
/// methods in `harfbuzz.unicode_funcs_t`. Client programs can implement
/// their own replacements for the individual Unicode functions, as
/// needed, and replace the default by calling the setter for a
/// method.
pub const unicode_funcs_t = opaque {
    extern fn hb_gobject_unicode_funcs_get_type() usize;
    pub const getGObjectType = hb_gobject_unicode_funcs_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data structure for holding user-data keys.
pub const user_data_key_t = extern struct {
    f_unused: u8,

    extern fn hb_gobject_user_data_key_get_type() usize;
    pub const getGObjectType = hb_gobject_user_data_key_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding variation data. Registered OpenType
/// variation-axis tags are listed in
/// [OpenType Axis Tag Registry](https://docs.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg).
pub const variation_t = extern struct {
    /// The `harfbuzz.tag_t` tag of the variation-axis name
    f_tag: harfbuzz.tag_t,
    /// The value of the variation axis
    f_value: f32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const var_int_t = extern union {
    f_u32: u32,
    f_i32: i32,
    f_u16: [2]u16,
    f_i16: [2]i16,
    f_u8: [4]u8,
    f_i8: [4]i8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const var_num_t = extern union {
    f_f: f32,
    f_u32: u32,
    f_i32: i32,
    f_u16: [2]u16,
    f_i16: [2]i16,
    f_u8: [4]u8,
    f_i8: [4]i8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The selectors defined for specifying AAT feature settings.
pub const aat_layout_feature_selector_t = enum(c_int) {
    invalid = 65535,
    all_type_features_on = 0,
    all_type_features_off = 1,
    common_ligatures_on = 2,
    common_ligatures_off = 3,
    rare_ligatures_on = 4,
    rare_ligatures_off = 5,
    logos_on = 6,
    logos_off = 7,
    rebus_pictures_on = 8,
    rebus_pictures_off = 9,
    diphthong_ligatures_on = 10,
    diphthong_ligatures_off = 11,
    squared_ligatures_on = 12,
    squared_ligatures_off = 13,
    abbrev_squared_ligatures_on = 14,
    abbrev_squared_ligatures_off = 15,
    symbol_ligatures_on = 16,
    symbol_ligatures_off = 17,
    contextual_ligatures_on = 18,
    contextual_ligatures_off = 19,
    historical_ligatures_on = 20,
    historical_ligatures_off = 21,
    stylistic_alt_eleven_on = 22,
    stylistic_alt_eleven_off = 23,
    stylistic_alt_twelve_on = 24,
    stylistic_alt_twelve_off = 25,
    stylistic_alt_thirteen_on = 26,
    stylistic_alt_thirteen_off = 27,
    stylistic_alt_fourteen_on = 28,
    stylistic_alt_fourteen_off = 29,
    stylistic_alt_fifteen_on = 30,
    stylistic_alt_fifteen_off = 31,
    stylistic_alt_sixteen_on = 32,
    stylistic_alt_sixteen_off = 33,
    stylistic_alt_seventeen_on = 34,
    stylistic_alt_seventeen_off = 35,
    stylistic_alt_eighteen_on = 36,
    stylistic_alt_eighteen_off = 37,
    stylistic_alt_nineteen_on = 38,
    stylistic_alt_nineteen_off = 39,
    stylistic_alt_twenty_on = 40,
    stylistic_alt_twenty_off = 41,
    _,

    pub const required_ligatures_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const required_ligatures_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const unconnected = aat_layout_feature_selector_t.all_type_features_on;
    pub const partially_connected = aat_layout_feature_selector_t.all_type_features_off;
    pub const cursive = aat_layout_feature_selector_t.common_ligatures_on;
    pub const upper_and_lower_case = aat_layout_feature_selector_t.all_type_features_on;
    pub const all_caps = aat_layout_feature_selector_t.all_type_features_off;
    pub const all_lower_case = aat_layout_feature_selector_t.common_ligatures_on;
    pub const small_caps = aat_layout_feature_selector_t.common_ligatures_off;
    pub const initial_caps = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const initial_caps_and_small_caps = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const substitute_vertical_forms_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const substitute_vertical_forms_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const linguistic_rearrangement_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const linguistic_rearrangement_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const monospaced_numbers = aat_layout_feature_selector_t.all_type_features_on;
    pub const proportional_numbers = aat_layout_feature_selector_t.all_type_features_off;
    pub const third_width_numbers = aat_layout_feature_selector_t.common_ligatures_on;
    pub const quarter_width_numbers = aat_layout_feature_selector_t.common_ligatures_off;
    pub const word_initial_swashes_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const word_initial_swashes_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const word_final_swashes_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const word_final_swashes_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const line_initial_swashes_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const line_initial_swashes_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const line_final_swashes_on = aat_layout_feature_selector_t.logos_on;
    pub const line_final_swashes_off = aat_layout_feature_selector_t.logos_off;
    pub const non_final_swashes_on = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const non_final_swashes_off = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const show_diacritics = aat_layout_feature_selector_t.all_type_features_on;
    pub const hide_diacritics = aat_layout_feature_selector_t.all_type_features_off;
    pub const decompose_diacritics = aat_layout_feature_selector_t.common_ligatures_on;
    pub const normal_position = aat_layout_feature_selector_t.all_type_features_on;
    pub const superiors = aat_layout_feature_selector_t.all_type_features_off;
    pub const inferiors = aat_layout_feature_selector_t.common_ligatures_on;
    pub const ordinals = aat_layout_feature_selector_t.common_ligatures_off;
    pub const scientific_inferiors = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const no_fractions = aat_layout_feature_selector_t.all_type_features_on;
    pub const vertical_fractions = aat_layout_feature_selector_t.all_type_features_off;
    pub const diagonal_fractions = aat_layout_feature_selector_t.common_ligatures_on;
    pub const prevent_overlap_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const prevent_overlap_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const hyphens_to_em_dash_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const hyphens_to_em_dash_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const hyphen_to_en_dash_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const hyphen_to_en_dash_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const slashed_zero_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const slashed_zero_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const form_interrobang_on = aat_layout_feature_selector_t.logos_on;
    pub const form_interrobang_off = aat_layout_feature_selector_t.logos_off;
    pub const smart_quotes_on = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const smart_quotes_off = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const periods_to_ellipsis_on = aat_layout_feature_selector_t.diphthong_ligatures_on;
    pub const periods_to_ellipsis_off = aat_layout_feature_selector_t.diphthong_ligatures_off;
    pub const hyphen_to_minus_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const hyphen_to_minus_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const asterisk_to_multiply_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const asterisk_to_multiply_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const slash_to_divide_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const slash_to_divide_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const inequality_ligatures_on = aat_layout_feature_selector_t.logos_on;
    pub const inequality_ligatures_off = aat_layout_feature_selector_t.logos_off;
    pub const exponents_on = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const exponents_off = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const mathematical_greek_on = aat_layout_feature_selector_t.diphthong_ligatures_on;
    pub const mathematical_greek_off = aat_layout_feature_selector_t.diphthong_ligatures_off;
    pub const no_ornaments = aat_layout_feature_selector_t.all_type_features_on;
    pub const dingbats = aat_layout_feature_selector_t.all_type_features_off;
    pub const pi_characters = aat_layout_feature_selector_t.common_ligatures_on;
    pub const fleurons = aat_layout_feature_selector_t.common_ligatures_off;
    pub const decorative_borders = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const international_symbols = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const math_symbols = aat_layout_feature_selector_t.logos_on;
    pub const no_alternates = aat_layout_feature_selector_t.all_type_features_on;
    pub const design_level1 = aat_layout_feature_selector_t.all_type_features_on;
    pub const design_level2 = aat_layout_feature_selector_t.all_type_features_off;
    pub const design_level3 = aat_layout_feature_selector_t.common_ligatures_on;
    pub const design_level4 = aat_layout_feature_selector_t.common_ligatures_off;
    pub const design_level5 = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const no_style_options = aat_layout_feature_selector_t.all_type_features_on;
    pub const display_text = aat_layout_feature_selector_t.all_type_features_off;
    pub const engraved_text = aat_layout_feature_selector_t.common_ligatures_on;
    pub const illuminated_caps = aat_layout_feature_selector_t.common_ligatures_off;
    pub const titling_caps = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const tall_caps = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const traditional_characters = aat_layout_feature_selector_t.all_type_features_on;
    pub const simplified_characters = aat_layout_feature_selector_t.all_type_features_off;
    pub const jis1978_characters = aat_layout_feature_selector_t.common_ligatures_on;
    pub const jis1983_characters = aat_layout_feature_selector_t.common_ligatures_off;
    pub const jis1990_characters = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const traditional_alt_one = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const traditional_alt_two = aat_layout_feature_selector_t.logos_on;
    pub const traditional_alt_three = aat_layout_feature_selector_t.logos_off;
    pub const traditional_alt_four = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const traditional_alt_five = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const expert_characters = aat_layout_feature_selector_t.diphthong_ligatures_on;
    pub const jis2004_characters = aat_layout_feature_selector_t.diphthong_ligatures_off;
    pub const hojo_characters = aat_layout_feature_selector_t.squared_ligatures_on;
    pub const nlccharacters = aat_layout_feature_selector_t.squared_ligatures_off;
    pub const traditional_names_characters = aat_layout_feature_selector_t.abbrev_squared_ligatures_on;
    pub const lower_case_numbers = aat_layout_feature_selector_t.all_type_features_on;
    pub const upper_case_numbers = aat_layout_feature_selector_t.all_type_features_off;
    pub const proportional_text = aat_layout_feature_selector_t.all_type_features_on;
    pub const monospaced_text = aat_layout_feature_selector_t.all_type_features_off;
    pub const half_width_text = aat_layout_feature_selector_t.common_ligatures_on;
    pub const third_width_text = aat_layout_feature_selector_t.common_ligatures_off;
    pub const quarter_width_text = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const alt_proportional_text = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const alt_half_width_text = aat_layout_feature_selector_t.logos_on;
    pub const no_transliteration = aat_layout_feature_selector_t.all_type_features_on;
    pub const hanja_to_hangul = aat_layout_feature_selector_t.all_type_features_off;
    pub const hiragana_to_katakana = aat_layout_feature_selector_t.common_ligatures_on;
    pub const katakana_to_hiragana = aat_layout_feature_selector_t.common_ligatures_off;
    pub const kana_to_romanization = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const romanization_to_hiragana = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const romanization_to_katakana = aat_layout_feature_selector_t.logos_on;
    pub const hanja_to_hangul_alt_one = aat_layout_feature_selector_t.logos_off;
    pub const hanja_to_hangul_alt_two = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const hanja_to_hangul_alt_three = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const no_annotation = aat_layout_feature_selector_t.all_type_features_on;
    pub const box_annotation = aat_layout_feature_selector_t.all_type_features_off;
    pub const rounded_box_annotation = aat_layout_feature_selector_t.common_ligatures_on;
    pub const circle_annotation = aat_layout_feature_selector_t.common_ligatures_off;
    pub const inverted_circle_annotation = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const parenthesis_annotation = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const period_annotation = aat_layout_feature_selector_t.logos_on;
    pub const roman_numeral_annotation = aat_layout_feature_selector_t.logos_off;
    pub const diamond_annotation = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const inverted_box_annotation = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const inverted_rounded_box_annotation = aat_layout_feature_selector_t.diphthong_ligatures_on;
    pub const full_width_kana = aat_layout_feature_selector_t.all_type_features_on;
    pub const proportional_kana = aat_layout_feature_selector_t.all_type_features_off;
    pub const full_width_ideographs = aat_layout_feature_selector_t.all_type_features_on;
    pub const proportional_ideographs = aat_layout_feature_selector_t.all_type_features_off;
    pub const half_width_ideographs = aat_layout_feature_selector_t.common_ligatures_on;
    pub const canonical_composition_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const canonical_composition_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const compatibility_composition_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const compatibility_composition_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const transcoding_composition_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const transcoding_composition_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const no_ruby_kana = aat_layout_feature_selector_t.all_type_features_on;
    pub const ruby_kana = aat_layout_feature_selector_t.all_type_features_off;
    pub const ruby_kana_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const ruby_kana_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const no_cjk_symbol_alternatives = aat_layout_feature_selector_t.all_type_features_on;
    pub const cjk_symbol_alt_one = aat_layout_feature_selector_t.all_type_features_off;
    pub const cjk_symbol_alt_two = aat_layout_feature_selector_t.common_ligatures_on;
    pub const cjk_symbol_alt_three = aat_layout_feature_selector_t.common_ligatures_off;
    pub const cjk_symbol_alt_four = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const cjk_symbol_alt_five = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const no_ideographic_alternatives = aat_layout_feature_selector_t.all_type_features_on;
    pub const ideographic_alt_one = aat_layout_feature_selector_t.all_type_features_off;
    pub const ideographic_alt_two = aat_layout_feature_selector_t.common_ligatures_on;
    pub const ideographic_alt_three = aat_layout_feature_selector_t.common_ligatures_off;
    pub const ideographic_alt_four = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const ideographic_alt_five = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const cjk_vertical_roman_centered = aat_layout_feature_selector_t.all_type_features_on;
    pub const cjk_vertical_roman_hbaseline = aat_layout_feature_selector_t.all_type_features_off;
    pub const no_cjk_italic_roman = aat_layout_feature_selector_t.all_type_features_on;
    pub const cjk_italic_roman = aat_layout_feature_selector_t.all_type_features_off;
    pub const cjk_italic_roman_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const cjk_italic_roman_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const case_sensitive_layout_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const case_sensitive_layout_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const case_sensitive_spacing_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const case_sensitive_spacing_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const alternate_horiz_kana_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const alternate_horiz_kana_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const alternate_vert_kana_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const alternate_vert_kana_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const no_stylistic_alternates = aat_layout_feature_selector_t.all_type_features_on;
    pub const stylistic_alt_one_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const stylistic_alt_one_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const stylistic_alt_two_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const stylistic_alt_two_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const stylistic_alt_three_on = aat_layout_feature_selector_t.logos_on;
    pub const stylistic_alt_three_off = aat_layout_feature_selector_t.logos_off;
    pub const stylistic_alt_four_on = aat_layout_feature_selector_t.rebus_pictures_on;
    pub const stylistic_alt_four_off = aat_layout_feature_selector_t.rebus_pictures_off;
    pub const stylistic_alt_five_on = aat_layout_feature_selector_t.diphthong_ligatures_on;
    pub const stylistic_alt_five_off = aat_layout_feature_selector_t.diphthong_ligatures_off;
    pub const stylistic_alt_six_on = aat_layout_feature_selector_t.squared_ligatures_on;
    pub const stylistic_alt_six_off = aat_layout_feature_selector_t.squared_ligatures_off;
    pub const stylistic_alt_seven_on = aat_layout_feature_selector_t.abbrev_squared_ligatures_on;
    pub const stylistic_alt_seven_off = aat_layout_feature_selector_t.abbrev_squared_ligatures_off;
    pub const stylistic_alt_eight_on = aat_layout_feature_selector_t.symbol_ligatures_on;
    pub const stylistic_alt_eight_off = aat_layout_feature_selector_t.symbol_ligatures_off;
    pub const stylistic_alt_nine_on = aat_layout_feature_selector_t.contextual_ligatures_on;
    pub const stylistic_alt_nine_off = aat_layout_feature_selector_t.contextual_ligatures_off;
    pub const stylistic_alt_ten_on = aat_layout_feature_selector_t.historical_ligatures_on;
    pub const stylistic_alt_ten_off = aat_layout_feature_selector_t.historical_ligatures_off;
    pub const contextual_alternates_on = aat_layout_feature_selector_t.all_type_features_on;
    pub const contextual_alternates_off = aat_layout_feature_selector_t.all_type_features_off;
    pub const swash_alternates_on = aat_layout_feature_selector_t.common_ligatures_on;
    pub const swash_alternates_off = aat_layout_feature_selector_t.common_ligatures_off;
    pub const contextual_swash_alternates_on = aat_layout_feature_selector_t.rare_ligatures_on;
    pub const contextual_swash_alternates_off = aat_layout_feature_selector_t.rare_ligatures_off;
    pub const default_lower_case = aat_layout_feature_selector_t.all_type_features_on;
    pub const lower_case_small_caps = aat_layout_feature_selector_t.all_type_features_off;
    pub const lower_case_petite_caps = aat_layout_feature_selector_t.common_ligatures_on;
    pub const default_upper_case = aat_layout_feature_selector_t.all_type_features_on;
    pub const upper_case_small_caps = aat_layout_feature_selector_t.all_type_features_off;
    pub const upper_case_petite_caps = aat_layout_feature_selector_t.common_ligatures_on;
    pub const half_width_cjk_roman = aat_layout_feature_selector_t.all_type_features_on;
    pub const proportional_cjk_roman = aat_layout_feature_selector_t.all_type_features_off;
    pub const default_cjk_roman = aat_layout_feature_selector_t.common_ligatures_on;
    pub const full_width_cjk_roman = aat_layout_feature_selector_t.common_ligatures_off;
    extern fn hb_gobject_aat_layout_feature_selector_get_type() usize;
    pub const getGObjectType = hb_gobject_aat_layout_feature_selector_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The possible feature types defined for AAT shaping, from Apple [Font Feature Registry](https://developer.apple.com/fonts/TrueType-Reference-Manual/RM09/AppendixF.html).
pub const aat_layout_feature_type_t = enum(c_int) {
    invalid = 65535,
    all_typographic = 0,
    ligatures = 1,
    cursive_connection = 2,
    letter_case = 3,
    vertical_substitution = 4,
    linguistic_rearrangement = 5,
    number_spacing = 6,
    smart_swash_type = 8,
    diacritics_type = 9,
    vertical_position = 10,
    fractions = 11,
    overlapping_characters_type = 13,
    typographic_extras = 14,
    mathematical_extras = 15,
    ornament_sets_type = 16,
    character_alternatives = 17,
    design_complexity_type = 18,
    style_options = 19,
    character_shape = 20,
    number_case = 21,
    text_spacing = 22,
    transliteration = 23,
    annotation_type = 24,
    kana_spacing_type = 25,
    ideographic_spacing_type = 26,
    unicode_decomposition_type = 27,
    ruby_kana = 28,
    cjk_symbol_alternatives_type = 29,
    ideographic_alternatives_type = 30,
    cjk_vertical_roman_placement_type = 31,
    italic_cjk_roman = 32,
    case_sensitive_layout = 33,
    alternate_kana = 34,
    stylistic_alternatives = 35,
    contextual_alternatives = 36,
    lower_case = 37,
    upper_case = 38,
    language_tag_type = 39,
    cjk_roman_spacing_type = 103,
    _,

    extern fn hb_gobject_aat_layout_feature_type_get_type() usize;
    pub const getGObjectType = hb_gobject_aat_layout_feature_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for holding HarfBuzz's clustering behavior options. The cluster level
/// dictates one aspect of how HarfBuzz will treat non-base characters
/// during shaping.
///
/// In `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES`, non-base
/// characters are merged into the cluster of the base character that precedes them.
/// There is also cluster merging every time the clusters will otherwise become non-monotone.
///
/// In `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS`, non-base characters are initially
/// assigned their own cluster values, which are not merged into preceding base
/// clusters. This allows HarfBuzz to perform additional operations like reorder
/// sequences of adjacent marks. The output is still monotone, but the cluster
/// values are more granular.
///
/// In `HB_BUFFER_CLUSTER_LEVEL_CHARACTERS`, non-base characters are assigned their
/// own cluster values, which are not merged into preceding base clusters. Moreover,
/// the cluster values are not merged into monotone order. This is the most granular
/// cluster level, and it is useful for clients that need to know the exact cluster
/// values of each character, but is harder to use for clients, since clusters
/// might appear in any order.
///
/// In `HB_BUFFER_CLUSTER_LEVEL_GRAPHEMES`, non-base characters are merged into the
/// cluster of the base character that precedes them. This is similar to the Unicode
/// Grapheme Cluster algorithm, but it is not exactly the same. The output is
/// not forced to be monotone. This is useful for clients that want to use HarfBuzz
/// as a cheap implementation of the Unicode Grapheme Cluster algorithm.
///
/// `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES` is the default, because it maintains
/// backward compatibility with older versions of HarfBuzz. New client programs that
/// do not need to maintain such backward compatibility are recommended to use
/// `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS` instead of the default.
pub const buffer_cluster_level_t = enum(c_int) {
    monotone_graphemes = 0,
    monotone_characters = 1,
    characters = 2,
    graphemes = 3,
    _,

    pub const default = buffer_cluster_level_t.monotone_graphemes;
    extern fn hb_gobject_buffer_cluster_level_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_cluster_level_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The type of `harfbuzz.buffer_t` contents.
pub const buffer_content_type_t = enum(c_int) {
    invalid = 0,
    unicode = 1,
    glyphs = 2,
    _,

    extern fn hb_gobject_buffer_content_type_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_content_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The buffer serialization and de-serialization format used in
/// `harfbuzz.bufferSerializeGlyphs` and `harfbuzz.bufferDeserializeGlyphs`.
pub const buffer_serialize_format_t = enum(c_int) {
    text = 1413830740,
    json = 1246973774,
    invalid = 0,
    _,

    extern fn hb_gobject_buffer_serialize_format_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_serialize_format_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The direction of a text segment or buffer.
///
/// A segment can also be tested for horizontal or vertical
/// orientation (irrespective of specific direction) with
/// `HB_DIRECTION_IS_HORIZONTAL` or `HB_DIRECTION_IS_VERTICAL`.
pub const direction_t = enum(c_int) {
    invalid = 0,
    ltr = 4,
    rtl = 5,
    ttb = 6,
    btt = 7,
    _,

    extern fn hb_gobject_direction_get_type() usize;
    pub const getGObjectType = hb_gobject_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type holding the memory modes available to
/// client programs.
///
/// Regarding these various memory-modes:
///
/// - In no case shall the HarfBuzz client modify memory
///   that is passed to HarfBuzz in a blob.  If there is
///   any such possibility, `HB_MEMORY_MODE_DUPLICATE` should be used
///   such that HarfBuzz makes a copy immediately,
///
/// - Use `HB_MEMORY_MODE_READONLY` otherwise, unless you really really
///   really know what you are doing,
///
/// - `HB_MEMORY_MODE_WRITABLE` is appropriate if you really made a
///   copy of data solely for the purpose of passing to
///   HarfBuzz and doing that just once (no reuse!),
///
/// - If the font is `mmap`ed, it's okay to use
///   `HB_MEMORY_MODE_READONLY_MAY_MAKE_WRITABLE`, however, using that mode
///   correctly is very tricky.  Use `HB_MEMORY_MODE_READONLY` instead.
pub const memory_mode_t = enum(c_int) {
    duplicate = 0,
    readonly = 1,
    writable = 2,
    readonly_may_make_writable = 3,
    _,

    extern fn hb_gobject_memory_mode_get_type() usize;
    pub const getGObjectType = hb_gobject_memory_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Baseline tags from [Baseline Tags](https://docs.microsoft.com/en-us/typography/opentype/spec/baselinetags) registry.
pub const ot_layout_baseline_tag_t = enum(c_int) {
    roman = 1919905134,
    hanging = 1751215719,
    ideo_face_bottom_or_left = 1768121954,
    ideo_face_top_or_right = 1768121972,
    ideo_face_central = 1231251043,
    ideo_embox_bottom_or_left = 1768187247,
    ideo_embox_top_or_right = 1768191088,
    ideo_embox_central = 1231315813,
    math = 1835103336,
    _,

    extern fn hb_gobject_ot_layout_baseline_tag_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_layout_baseline_tag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The GDEF classes defined for glyphs.
pub const ot_layout_glyph_class_t = enum(c_int) {
    unclassified = 0,
    base_glyph = 1,
    ligature = 2,
    mark = 3,
    component = 4,
    _,

    extern fn hb_gobject_ot_layout_glyph_class_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_layout_glyph_class_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The 'MATH' table constants, refer to
/// [OpenType documentation](https://docs.microsoft.com/en-us/typography/opentype/spec/math`mathconstants`-table)
/// For more explanations.
pub const ot_math_constant_t = enum(c_int) {
    script_percent_scale_down = 0,
    script_script_percent_scale_down = 1,
    delimited_sub_formula_min_height = 2,
    display_operator_min_height = 3,
    math_leading = 4,
    axis_height = 5,
    accent_base_height = 6,
    flattened_accent_base_height = 7,
    subscript_shift_down = 8,
    subscript_top_max = 9,
    subscript_baseline_drop_min = 10,
    superscript_shift_up = 11,
    superscript_shift_up_cramped = 12,
    superscript_bottom_min = 13,
    superscript_baseline_drop_max = 14,
    sub_superscript_gap_min = 15,
    superscript_bottom_max_with_subscript = 16,
    space_after_script = 17,
    upper_limit_gap_min = 18,
    upper_limit_baseline_rise_min = 19,
    lower_limit_gap_min = 20,
    lower_limit_baseline_drop_min = 21,
    stack_top_shift_up = 22,
    stack_top_display_style_shift_up = 23,
    stack_bottom_shift_down = 24,
    stack_bottom_display_style_shift_down = 25,
    stack_gap_min = 26,
    stack_display_style_gap_min = 27,
    stretch_stack_top_shift_up = 28,
    stretch_stack_bottom_shift_down = 29,
    stretch_stack_gap_above_min = 30,
    stretch_stack_gap_below_min = 31,
    fraction_numerator_shift_up = 32,
    fraction_numerator_display_style_shift_up = 33,
    fraction_denominator_shift_down = 34,
    fraction_denominator_display_style_shift_down = 35,
    fraction_numerator_gap_min = 36,
    fraction_num_display_style_gap_min = 37,
    fraction_rule_thickness = 38,
    fraction_denominator_gap_min = 39,
    fraction_denom_display_style_gap_min = 40,
    skewed_fraction_horizontal_gap = 41,
    skewed_fraction_vertical_gap = 42,
    overbar_vertical_gap = 43,
    overbar_rule_thickness = 44,
    overbar_extra_ascender = 45,
    underbar_vertical_gap = 46,
    underbar_rule_thickness = 47,
    underbar_extra_descender = 48,
    radical_vertical_gap = 49,
    radical_display_style_vertical_gap = 50,
    radical_rule_thickness = 51,
    radical_extra_ascender = 52,
    radical_kern_before_degree = 53,
    radical_kern_after_degree = 54,
    radical_degree_bottom_raise_percent = 55,
    _,

    extern fn hb_gobject_ot_math_constant_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_math_constant_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The math kerning-table types defined for the four corners
/// of a glyph.
pub const ot_math_kern_t = enum(c_int) {
    top_right = 0,
    top_left = 1,
    bottom_right = 2,
    bottom_left = 3,
    _,

    extern fn hb_gobject_ot_math_kern_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_math_kern_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Known metadata tags from https://docs.microsoft.com/en-us/typography/opentype/spec/meta
pub const ot_meta_tag_t = enum(c_int) {
    design_languages = 1684827751,
    supported_languages = 1936485991,
    _,

    extern fn hb_gobject_ot_meta_tag_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_meta_tag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Metric tags corresponding to [MVAR Value
/// Tags](https://docs.microsoft.com/en-us/typography/opentype/spec/mvar`value`-tags)
pub const ot_metrics_tag_t = enum(c_int) {
    horizontal_ascender = 1751216995,
    horizontal_descender = 1751413603,
    horizontal_line_gap = 1751934832,
    horizontal_clipping_ascent = 1751346273,
    horizontal_clipping_descent = 1751346276,
    vertical_ascender = 1986098019,
    vertical_descender = 1986294627,
    vertical_line_gap = 1986815856,
    horizontal_caret_rise = 1751347827,
    horizontal_caret_run = 1751347822,
    horizontal_caret_offset = 1751347046,
    vertical_caret_rise = 1986228851,
    vertical_caret_run = 1986228846,
    vertical_caret_offset = 1986228070,
    x_height = 2020108148,
    cap_height = 1668311156,
    subscript_em_x_size = 1935833203,
    subscript_em_y_size = 1935833459,
    subscript_em_x_offset = 1935833199,
    subscript_em_y_offset = 1935833455,
    superscript_em_x_size = 1936750707,
    superscript_em_y_size = 1936750963,
    superscript_em_x_offset = 1936750703,
    superscript_em_y_offset = 1936750959,
    strikeout_size = 1937011315,
    strikeout_offset = 1937011311,
    underline_size = 1970168947,
    underline_offset = 1970168943,
    _,

    extern fn hb_gobject_ot_metrics_tag_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_metrics_tag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enum type representing the pre-defined name IDs.
///
/// For more information on these fields, see the
/// [OpenType spec](https://docs.microsoft.com/en-us/typography/opentype/spec/name`name`-ids).
pub const ot_name_id_predefined_t = enum(c_int) {
    copyright = 0,
    font_family = 1,
    font_subfamily = 2,
    unique_id = 3,
    full_name = 4,
    version_string = 5,
    postscript_name = 6,
    trademark = 7,
    manufacturer = 8,
    designer = 9,
    description = 10,
    vendor_url = 11,
    designer_url = 12,
    license = 13,
    license_url = 14,
    typographic_family = 16,
    typographic_subfamily = 17,
    mac_full_name = 18,
    sample_text = 19,
    cid_findfont_name = 20,
    wws_family = 21,
    wws_subfamily = 22,
    light_background = 23,
    dark_background = 24,
    variations_ps_prefix = 25,
    invalid = 65535,
    _,

    extern fn hb_gobject_ot_name_id_predefined_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_name_id_predefined_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enumeration describe the compositing modes
/// that can be used when combining temporary redirected drawing
/// with the backdrop.
///
/// See the OpenType spec [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details.
pub const paint_composite_mode_t = enum(c_int) {
    clear = 0,
    src = 1,
    dest = 2,
    src_over = 3,
    dest_over = 4,
    src_in = 5,
    dest_in = 6,
    src_out = 7,
    dest_out = 8,
    src_atop = 9,
    dest_atop = 10,
    xor = 11,
    plus = 12,
    screen = 13,
    overlay = 14,
    darken = 15,
    lighten = 16,
    color_dodge = 17,
    color_burn = 18,
    hard_light = 19,
    soft_light = 20,
    difference = 21,
    exclusion = 22,
    multiply = 23,
    hsl_hue = 24,
    hsl_saturation = 25,
    hsl_color = 26,
    hsl_luminosity = 27,
    _,

    extern fn hb_gobject_paint_composite_mode_get_type() usize;
    pub const getGObjectType = hb_gobject_paint_composite_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The values of this enumeration determine how color values
/// outside the minimum and maximum defined offset on a `harfbuzz.color_line_t`
/// are determined.
///
/// See the OpenType spec [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details.
pub const paint_extend_t = enum(c_int) {
    pad = 0,
    repeat = 1,
    reflect = 2,
    _,

    extern fn hb_gobject_paint_extend_get_type() usize;
    pub const getGObjectType = hb_gobject_paint_extend_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for scripts. Each `harfbuzz.script_t`'s value is an `harfbuzz.tag_t` corresponding
/// to the four-letter values defined by [ISO 15924](https://unicode.org/iso15924/).
///
/// See also the Script (sc) property of the Unicode Character Database.
pub const script_t = enum(c_int) {
    common = 1517910393,
    inherited = 1516858984,
    unknown = 1517976186,
    arabic = 1098015074,
    armenian = 1098018158,
    bengali = 1113943655,
    cyrillic = 1132032620,
    devanagari = 1147500129,
    georgian = 1197830002,
    greek = 1198679403,
    gujarati = 1198877298,
    gurmukhi = 1198879349,
    hangul = 1214344807,
    han = 1214344809,
    hebrew = 1214603890,
    hiragana = 1214870113,
    kannada = 1265525857,
    katakana = 1264676449,
    lao = 1281453935,
    latin = 1281455214,
    malayalam = 1298954605,
    oriya = 1332902241,
    tamil = 1415671148,
    telugu = 1415933045,
    thai = 1416126825,
    tibetan = 1416192628,
    bopomofo = 1114599535,
    braille = 1114792297,
    canadian_syllabics = 1130458739,
    cherokee = 1130915186,
    ethiopic = 1165256809,
    khmer = 1265134962,
    mongolian = 1299148391,
    myanmar = 1299803506,
    ogham = 1332175213,
    runic = 1383427698,
    sinhala = 1399418472,
    syriac = 1400468067,
    thaana = 1416126817,
    yi = 1500080489,
    deseret = 1148416628,
    gothic = 1198486632,
    old_italic = 1232363884,
    buhid = 1114990692,
    hanunoo = 1214344815,
    tagalog = 1416064103,
    tagbanwa = 1415669602,
    cypriot = 1131442804,
    limbu = 1281977698,
    linear_b = 1281977954,
    osmanya = 1332964705,
    shavian = 1399349623,
    tai_le = 1415670885,
    ugaritic = 1432838514,
    buginese = 1114990441,
    coptic = 1131376756,
    glagolitic = 1198285159,
    kharoshthi = 1265131890,
    new_tai_lue = 1415670901,
    old_persian = 1483761007,
    syloti_nagri = 1400466543,
    tifinagh = 1415999079,
    balinese = 1113681001,
    cuneiform = 1483961720,
    nko = 1315663727,
    phags_pa = 1349017959,
    phoenician = 1349021304,
    carian = 1130459753,
    cham = 1130914157,
    kayah_li = 1264675945,
    lepcha = 1281716323,
    lycian = 1283023721,
    lydian = 1283023977,
    ol_chiki = 1332503403,
    rejang = 1382706791,
    saurashtra = 1398895986,
    sundanese = 1400204900,
    vai = 1449224553,
    avestan = 1098281844,
    bamum = 1113681269,
    egyptian_hieroglyphs = 1164409200,
    imperial_aramaic = 1098018153,
    inscriptional_pahlavi = 1349020777,
    inscriptional_parthian = 1349678185,
    javanese = 1247901281,
    kaithi = 1265920105,
    lisu = 1281979253,
    meetei_mayek = 1299473769,
    old_south_arabian = 1398895202,
    old_turkic = 1332898664,
    samaritan = 1398893938,
    tai_tham = 1281453665,
    tai_viet = 1415673460,
    batak = 1113683051,
    brahmi = 1114792296,
    mandaic = 1298230884,
    chakma = 1130457965,
    meroitic_cursive = 1298494051,
    meroitic_hieroglyphs = 1298494063,
    miao = 1349284452,
    sharada = 1399353956,
    sora_sompeng = 1399812705,
    takri = 1415670642,
    bassa_vah = 1113682803,
    caucasian_albanian = 1097295970,
    duployan = 1148547180,
    elbasan = 1164730977,
    grantha = 1198678382,
    khojki = 1265135466,
    khudawadi = 1399418468,
    linear_a = 1281977953,
    mahajani = 1298229354,
    manichaean = 1298230889,
    mende_kikakui = 1298493028,
    modi = 1299145833,
    mro = 1299345263,
    nabataean = 1315070324,
    old_north_arabian = 1315009122,
    old_permic = 1348825709,
    pahawh_hmong = 1215131239,
    palmyrene = 1348562029,
    pau_cin_hau = 1348564323,
    psalter_pahlavi = 1349020784,
    siddham = 1399415908,
    tirhuta = 1416196712,
    warang_citi = 1466004065,
    ahom = 1097363309,
    anatolian_hieroglyphs = 1215067511,
    hatran = 1214346354,
    multani = 1299541108,
    old_hungarian = 1215655527,
    signwriting = 1399287415,
    adlam = 1097100397,
    bhaiksuki = 1114139507,
    marchen = 1298231907,
    osage = 1332963173,
    tangut = 1415671399,
    newa = 1315272545,
    masaram_gondi = 1198485101,
    nushu = 1316186229,
    soyombo = 1399814511,
    zanabazar_square = 1516334690,
    dogra = 1148151666,
    gunjala_gondi = 1198485095,
    hanifi_rohingya = 1383032935,
    makasar = 1298230113,
    medefaidrin = 1298490470,
    old_sogdian = 1399809903,
    sogdian = 1399809892,
    elymaic = 1164736877,
    nandinagari = 1315008100,
    nyiakeng_puachue_hmong = 1215131248,
    wancho = 1466132591,
    chorasmian = 1130918515,
    dives_akuru = 1147756907,
    khitan_small_script = 1265202291,
    yezidi = 1499822697,
    cypro_minoan = 1131441518,
    old_uyghur = 1333094258,
    tangsa = 1416524641,
    toto = 1416590447,
    vithkuqi = 1449751656,
    math = 1517122664,
    kawi = 1264678761,
    nag_mundari = 1315006317,
    garay = 1197568609,
    gurung_khema = 1198877544,
    kirat_rai = 1265787241,
    ol_onal = 1332633967,
    sunuwar = 1400204917,
    todhri = 1416586354,
    tulu_tigalari = 1416983655,
    invalid = 0,
    _,

    extern fn hb_gobject_script_get_type() usize;
    pub const getGObjectType = hb_gobject_script_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defined by [OpenType Design-Variation Axis Tag Registry](https://docs.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg).
pub const style_tag_t = enum(c_int) {
    italic = 1769234796,
    optical_size = 1869640570,
    slant_angle = 1936486004,
    slant_ratio = 1399615092,
    width = 2003072104,
    weight = 2003265652,
    _,

    extern fn hb_gobject_style_tag_get_type() usize;
    pub const getGObjectType = hb_gobject_style_tag_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for the Canonical_Combining_Class (ccc) property
/// from the Unicode Character Database.
///
/// <note>Note: newer versions of Unicode may add new values.
/// Client programs should be ready to handle any value in the 0..254 range
/// being returned from `harfbuzz.unicodeCombiningClass`.</note>
pub const unicode_combining_class_t = enum(c_int) {
    not_reordered = 0,
    overlay = 1,
    nukta = 7,
    kana_voicing = 8,
    virama = 9,
    ccc10 = 10,
    ccc11 = 11,
    ccc12 = 12,
    ccc13 = 13,
    ccc14 = 14,
    ccc15 = 15,
    ccc16 = 16,
    ccc17 = 17,
    ccc18 = 18,
    ccc19 = 19,
    ccc20 = 20,
    ccc21 = 21,
    ccc22 = 22,
    ccc23 = 23,
    ccc24 = 24,
    ccc25 = 25,
    ccc26 = 26,
    ccc27 = 27,
    ccc28 = 28,
    ccc29 = 29,
    ccc30 = 30,
    ccc31 = 31,
    ccc32 = 32,
    ccc33 = 33,
    ccc34 = 34,
    ccc35 = 35,
    ccc36 = 36,
    ccc84 = 84,
    ccc91 = 91,
    ccc103 = 103,
    ccc107 = 107,
    ccc118 = 118,
    ccc122 = 122,
    ccc129 = 129,
    ccc130 = 130,
    ccc132 = 132,
    attached_below_left = 200,
    attached_below = 202,
    attached_above = 214,
    attached_above_right = 216,
    below_left = 218,
    below = 220,
    below_right = 222,
    left = 224,
    right = 226,
    above_left = 228,
    above = 230,
    above_right = 232,
    double_below = 233,
    double_above = 234,
    iota_subscript = 240,
    invalid = 255,
    _,

    extern fn hb_gobject_unicode_combining_class_get_type() usize;
    pub const getGObjectType = hb_gobject_unicode_combining_class_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Data type for the "General_Category" (gc) property from
/// the Unicode Character Database.
pub const unicode_general_category_t = enum(c_int) {
    control = 0,
    format = 1,
    unassigned = 2,
    private_use = 3,
    surrogate = 4,
    lowercase_letter = 5,
    modifier_letter = 6,
    other_letter = 7,
    titlecase_letter = 8,
    uppercase_letter = 9,
    spacing_mark = 10,
    enclosing_mark = 11,
    non_spacing_mark = 12,
    decimal_number = 13,
    letter_number = 14,
    other_number = 15,
    connect_punctuation = 16,
    dash_punctuation = 17,
    close_punctuation = 18,
    final_punctuation = 19,
    initial_punctuation = 20,
    other_punctuation = 21,
    open_punctuation = 22,
    currency_symbol = 23,
    modifier_symbol = 24,
    math_symbol = 25,
    other_symbol = 26,
    line_separator = 27,
    paragraph_separator = 28,
    space_separator = 29,
    _,

    extern fn hb_gobject_unicode_general_category_get_type() usize;
    pub const getGObjectType = hb_gobject_unicode_general_category_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags from comparing two `harfbuzz.buffer_t`'s.
///
/// Buffer with different `harfbuzz.buffer_content_type_t` cannot be meaningfully
/// compared in any further detail.
///
/// For buffers with differing length, the per-glyph comparison is not
/// attempted, though we do still scan reference buffer for dotted circle and
/// `.notdef` glyphs.
///
/// If the buffers have the same length, we compare them glyph-by-glyph and
/// report which aspect(s) of the glyph info/position are different.
pub const buffer_diff_flags_t = packed struct(c_uint) {
    content_type_mismatch: bool = false,
    length_mismatch: bool = false,
    notdef_present: bool = false,
    dotted_circle_present: bool = false,
    codepoint_mismatch: bool = false,
    cluster_mismatch: bool = false,
    glyph_flags_mismatch: bool = false,
    position_mismatch: bool = false,
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

    pub const flags_equal: buffer_diff_flags_t = @bitCast(@as(c_uint, 0));
    pub const flags_content_type_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_length_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 2));
    pub const flags_notdef_present: buffer_diff_flags_t = @bitCast(@as(c_uint, 4));
    pub const flags_dotted_circle_present: buffer_diff_flags_t = @bitCast(@as(c_uint, 8));
    pub const flags_codepoint_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 16));
    pub const flags_cluster_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 32));
    pub const flags_glyph_flags_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 64));
    pub const flags_position_mismatch: buffer_diff_flags_t = @bitCast(@as(c_uint, 128));
    extern fn hb_gobject_buffer_diff_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_diff_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for `harfbuzz.buffer_t`.
pub const buffer_flags_t = packed struct(c_uint) {
    bot: bool = false,
    eot: bool = false,
    preserve_default_ignorables: bool = false,
    remove_default_ignorables: bool = false,
    do_not_insert_dotted_circle: bool = false,
    verify: bool = false,
    produce_unsafe_to_concat: bool = false,
    produce_safe_to_insert_tatweel: bool = false,
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

    pub const flags_default: buffer_flags_t = @bitCast(@as(c_uint, 0));
    pub const flags_bot: buffer_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_eot: buffer_flags_t = @bitCast(@as(c_uint, 2));
    pub const flags_preserve_default_ignorables: buffer_flags_t = @bitCast(@as(c_uint, 4));
    pub const flags_remove_default_ignorables: buffer_flags_t = @bitCast(@as(c_uint, 8));
    pub const flags_do_not_insert_dotted_circle: buffer_flags_t = @bitCast(@as(c_uint, 16));
    pub const flags_verify: buffer_flags_t = @bitCast(@as(c_uint, 32));
    pub const flags_produce_unsafe_to_concat: buffer_flags_t = @bitCast(@as(c_uint, 64));
    pub const flags_produce_safe_to_insert_tatweel: buffer_flags_t = @bitCast(@as(c_uint, 128));
    pub const flags_defined: buffer_flags_t = @bitCast(@as(c_uint, 255));
    extern fn hb_gobject_buffer_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that control what glyph information are serialized in `harfbuzz.bufferSerializeGlyphs`.
pub const buffer_serialize_flags_t = packed struct(c_uint) {
    no_clusters: bool = false,
    no_positions: bool = false,
    no_glyph_names: bool = false,
    glyph_extents: bool = false,
    glyph_flags: bool = false,
    no_advances: bool = false,
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

    pub const flags_default: buffer_serialize_flags_t = @bitCast(@as(c_uint, 0));
    pub const flags_no_clusters: buffer_serialize_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_no_positions: buffer_serialize_flags_t = @bitCast(@as(c_uint, 2));
    pub const flags_no_glyph_names: buffer_serialize_flags_t = @bitCast(@as(c_uint, 4));
    pub const flags_glyph_extents: buffer_serialize_flags_t = @bitCast(@as(c_uint, 8));
    pub const flags_glyph_flags: buffer_serialize_flags_t = @bitCast(@as(c_uint, 16));
    pub const flags_no_advances: buffer_serialize_flags_t = @bitCast(@as(c_uint, 32));
    pub const flags_defined: buffer_serialize_flags_t = @bitCast(@as(c_uint, 63));
    extern fn hb_gobject_buffer_serialize_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_buffer_serialize_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for `harfbuzz.glyph_info_t`.
pub const glyph_flags_t = packed struct(c_uint) {
    unsafe_to_break: bool = false,
    unsafe_to_concat: bool = false,
    safe_to_insert_tatweel: bool = false,
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

    pub const flags_unsafe_to_break: glyph_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_unsafe_to_concat: glyph_flags_t = @bitCast(@as(c_uint, 2));
    pub const flags_safe_to_insert_tatweel: glyph_flags_t = @bitCast(@as(c_uint, 4));
    pub const flags_defined: glyph_flags_t = @bitCast(@as(c_uint, 7));
    extern fn hb_gobject_glyph_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_glyph_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags that describe the properties of color palette.
pub const ot_color_palette_flags_t = packed struct(c_uint) {
    usable_with_light_background: bool = false,
    usable_with_dark_background: bool = false,
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

    pub const flags_default: ot_color_palette_flags_t = @bitCast(@as(c_uint, 0));
    pub const flags_usable_with_light_background: ot_color_palette_flags_t = @bitCast(@as(c_uint, 1));
    pub const flags_usable_with_dark_background: ot_color_palette_flags_t = @bitCast(@as(c_uint, 2));
    extern fn hb_gobject_ot_color_palette_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_color_palette_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for math glyph parts.
pub const ot_math_glyph_part_flags_t = packed struct(c_uint) {
    extender: bool = false,
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

    pub const flags_extender: ot_math_glyph_part_flags_t = @bitCast(@as(c_uint, 1));
    extern fn hb_gobject_ot_math_glyph_part_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_math_glyph_part_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags for `harfbuzz.ot_var_axis_info_t`.
pub const ot_var_axis_flags_t = packed struct(c_uint) {
    hidden: bool = false,
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

    pub const flags_hidden: ot_var_axis_flags_t = @bitCast(@as(c_uint, 1));
    extern fn hb_gobject_ot_var_axis_flags_get_type() usize;
    pub const getGObjectType = hb_gobject_ot_var_axis_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Fetches the name identifier of the specified feature type in the face's `name` table.
extern fn hb_aat_layout_feature_type_get_name_id(p_face: *harfbuzz.face_t, p_feature_type: harfbuzz.aat_layout_feature_type_t) harfbuzz.ot_name_id_t;
pub const aatLayoutFeatureTypeGetNameId = hb_aat_layout_feature_type_get_name_id;

/// Fetches a list of the selectors available for the specified feature in the given face.
///
/// If upon return, `default_index` is set to `HB_AAT_LAYOUT_NO_SELECTOR_INDEX`, then
/// the feature type is non-exclusive.  Otherwise, `default_index` is the index of
/// the selector that is selected by default.
extern fn hb_aat_layout_feature_type_get_selector_infos(p_face: *harfbuzz.face_t, p_feature_type: harfbuzz.aat_layout_feature_type_t, p_start_offset: c_uint, p_selector_count: ?*c_uint, p_selectors: ?*[*]harfbuzz.aat_layout_feature_selector_info_t, p_default_index: ?*c_uint) c_uint;
pub const aatLayoutFeatureTypeGetSelectorInfos = hb_aat_layout_feature_type_get_selector_infos;

/// Fetches a list of the AAT feature types included in the specified face.
extern fn hb_aat_layout_get_feature_types(p_face: *harfbuzz.face_t, p_start_offset: c_uint, p_feature_count: ?*c_uint, p_features: *[*]harfbuzz.aat_layout_feature_type_t) c_uint;
pub const aatLayoutGetFeatureTypes = hb_aat_layout_get_feature_types;

/// Tests whether the specified face includes any positioning information
/// in the `kerx` table.
///
/// <note>Note: does not examine the `GPOS` table.</note>
extern fn hb_aat_layout_has_positioning(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const aatLayoutHasPositioning = hb_aat_layout_has_positioning;

/// Tests whether the specified face includes any substitutions in the
/// `morx` or `mort` tables.
///
/// <note>Note: does not examine the `GSUB` table.</note>
extern fn hb_aat_layout_has_substitution(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const aatLayoutHasSubstitution = hb_aat_layout_has_substitution;

/// Tests whether the specified face includes any tracking information
/// in the `trak` table.
extern fn hb_aat_layout_has_tracking(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const aatLayoutHasTracking = hb_aat_layout_has_tracking;

/// Makes a writable copy of `blob`.
extern fn hb_blob_copy_writable_or_fail(p_blob: *harfbuzz.blob_t) *harfbuzz.blob_t;
pub const blobCopyWritableOrFail = hb_blob_copy_writable_or_fail;

/// Creates a new "blob" object wrapping `data`.  The `mode` parameter is used
/// to negotiate ownership and lifecycle of `data`.
extern fn hb_blob_create(p_data: [*:0]const u8, p_length: c_uint, p_mode: harfbuzz.memory_mode_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) *harfbuzz.blob_t;
pub const blobCreate = hb_blob_create;

/// Creates a new blob containing the data from the
/// specified binary font file.
///
/// The filename is passed directly to the system on all platforms,
/// except on Windows, where the filename is interpreted as UTF-8.
/// Only if the filename is not valid UTF-8, it will be interpreted
/// according to the system codepage.
extern fn hb_blob_create_from_file(p_file_name: [*:0]const u8) *harfbuzz.blob_t;
pub const blobCreateFromFile = hb_blob_create_from_file;

/// Creates a new blob containing the data from the specified file.
///
/// The filename is passed directly to the system on all platforms,
/// except on Windows, where the filename is interpreted as UTF-8.
/// Only if the filename is not valid UTF-8, it will be interpreted
/// according to the system codepage.
extern fn hb_blob_create_from_file_or_fail(p_file_name: [*:0]const u8) *harfbuzz.blob_t;
pub const blobCreateFromFileOrFail = hb_blob_create_from_file_or_fail;

/// Creates a new "blob" object wrapping `data`.  The `mode` parameter is used
/// to negotiate ownership and lifecycle of `data`.
///
/// Note that this function returns a freshly-allocated empty blob even if `length`
/// is zero. This is in contrast to `harfbuzz.blobCreate`, which returns the singleton
/// empty blob (as returned by `harfbuzz.blobGetEmpty`) if `length` is zero.
extern fn hb_blob_create_or_fail(p_data: [*:0]const u8, p_length: c_uint, p_mode: harfbuzz.memory_mode_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) *harfbuzz.blob_t;
pub const blobCreateOrFail = hb_blob_create_or_fail;

/// Returns a blob that represents a range of bytes in `parent`.  The new
/// blob is always created with `HB_MEMORY_MODE_READONLY`, meaning that it
/// will never modify data in the parent blob.  The parent data is not
/// expected to be modified, and will result in undefined behavior if it
/// is.
///
/// Makes `parent` immutable.
extern fn hb_blob_create_sub_blob(p_parent: *harfbuzz.blob_t, p_offset: c_uint, p_length: c_uint) *harfbuzz.blob_t;
pub const blobCreateSubBlob = hb_blob_create_sub_blob;

/// Decreases the reference count on `blob`, and if it reaches zero, destroys
/// `blob`, freeing all memory, possibly calling the destroy-callback the blob
/// was created for if it has not been called already.
///
/// See TODO:link object types for more information.
extern fn hb_blob_destroy(p_blob: *harfbuzz.blob_t) void;
pub const blobDestroy = hb_blob_destroy;

/// Fetches the data from a blob.
extern fn hb_blob_get_data(p_blob: *harfbuzz.blob_t, p_length: *c_uint) ?[*]const u8;
pub const blobGetData = hb_blob_get_data;

/// Tries to make blob data writable (possibly copying it) and
/// return pointer to data.
///
/// Fails if blob has been made immutable, or if memory allocation
/// fails.
extern fn hb_blob_get_data_writable(p_blob: *harfbuzz.blob_t, p_length: *c_uint) [*]u8;
pub const blobGetDataWritable = hb_blob_get_data_writable;

/// Returns the singleton empty blob.
///
/// See TODO:link object types for more information.
extern fn hb_blob_get_empty() *harfbuzz.blob_t;
pub const blobGetEmpty = hb_blob_get_empty;

/// Fetches the length of a blob's data.
extern fn hb_blob_get_length(p_blob: *harfbuzz.blob_t) c_uint;
pub const blobGetLength = hb_blob_get_length;

/// Fetches the user data associated with the specified key,
/// attached to the specified font-functions structure.
extern fn hb_blob_get_user_data(p_blob: *const harfbuzz.blob_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const blobGetUserData = hb_blob_get_user_data;

/// Tests whether a blob is immutable.
extern fn hb_blob_is_immutable(p_blob: *harfbuzz.blob_t) harfbuzz.bool_t;
pub const blobIsImmutable = hb_blob_is_immutable;

/// Makes a blob immutable.
extern fn hb_blob_make_immutable(p_blob: *harfbuzz.blob_t) void;
pub const blobMakeImmutable = hb_blob_make_immutable;

/// Increases the reference count on `blob`.
///
/// See TODO:link object types for more information.
extern fn hb_blob_reference(p_blob: *harfbuzz.blob_t) *harfbuzz.blob_t;
pub const blobReference = hb_blob_reference;

/// Attaches a user-data key/data pair to the specified blob.
extern fn hb_blob_set_user_data(p_blob: *harfbuzz.blob_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const blobSetUserData = hb_blob_set_user_data;

/// Appends a character with the Unicode value of `codepoint` to `buffer`, and
/// gives it the initial cluster value of `cluster`. Clusters can be any thing
/// the client wants, they are usually used to refer to the index of the
/// character in the input text stream and are output in
/// `harfbuzz.glyph_info_t.cluster` field.
///
/// This function does not check the validity of `codepoint`, it is up to the
/// caller to ensure it is a valid Unicode code point.
extern fn hb_buffer_add(p_buffer: *harfbuzz.buffer_t, p_codepoint: harfbuzz.codepoint_t, p_cluster: c_uint) void;
pub const bufferAdd = hb_buffer_add;

/// Appends characters from `text` array to `buffer`. The `item_offset` is the
/// position of the first character from `text` that will be appended, and
/// `item_length` is the number of character. When shaping part of a larger text
/// (e.g. a run of text from a paragraph), instead of passing just the substring
/// corresponding to the run, it is preferable to pass the whole
/// paragraph and specify the run start and length as `item_offset` and
/// `item_length`, respectively, to give HarfBuzz the full context to be able,
/// for example, to do cross-run Arabic shaping or properly handle combining
/// marks at stat of run.
///
/// This function does not check the validity of `text`, it is up to the caller
/// to ensure it contains a valid Unicode scalar values.  In contrast,
/// `harfbuzz.bufferAddUtf32` can be used that takes similar input but performs
/// sanity-check on the input.
extern fn hb_buffer_add_codepoints(p_buffer: *harfbuzz.buffer_t, p_text: [*]const harfbuzz.codepoint_t, p_text_length: c_int, p_item_offset: c_uint, p_item_length: c_int) void;
pub const bufferAddCodepoints = hb_buffer_add_codepoints;

/// Similar to `harfbuzz.bufferAddCodepoints`, but allows only access to first 256
/// Unicode code points that can fit in 8-bit strings.
///
/// <note>Has nothing to do with non-Unicode Latin-1 encoding.</note>
extern fn hb_buffer_add_latin1(p_buffer: *harfbuzz.buffer_t, p_text: [*]const u8, p_text_length: c_int, p_item_offset: c_uint, p_item_length: c_int) void;
pub const bufferAddLatin1 = hb_buffer_add_latin1;

/// See `harfbuzz.bufferAddCodepoints`.
///
/// Replaces invalid UTF-16 characters with the `buffer` replacement code point,
/// see `harfbuzz.bufferSetReplacementCodepoint`.
extern fn hb_buffer_add_utf16(p_buffer: *harfbuzz.buffer_t, p_text: [*]const u16, p_text_length: c_int, p_item_offset: c_uint, p_item_length: c_int) void;
pub const bufferAddUtf16 = hb_buffer_add_utf16;

/// See `harfbuzz.bufferAddCodepoints`.
///
/// Replaces invalid UTF-32 characters with the `buffer` replacement code point,
/// see `harfbuzz.bufferSetReplacementCodepoint`.
extern fn hb_buffer_add_utf32(p_buffer: *harfbuzz.buffer_t, p_text: [*]const u32, p_text_length: c_int, p_item_offset: c_uint, p_item_length: c_int) void;
pub const bufferAddUtf32 = hb_buffer_add_utf32;

/// See `harfbuzz.bufferAddCodepoints`.
///
/// Replaces invalid UTF-8 characters with the `buffer` replacement code point,
/// see `harfbuzz.bufferSetReplacementCodepoint`.
extern fn hb_buffer_add_utf8(p_buffer: *harfbuzz.buffer_t, p_text: [*]const u8, p_text_length: c_int, p_item_offset: c_uint, p_item_length: c_int) void;
pub const bufferAddUtf8 = hb_buffer_add_utf8;

/// Check if allocating memory for the buffer succeeded.
extern fn hb_buffer_allocation_successful(p_buffer: *harfbuzz.buffer_t) harfbuzz.bool_t;
pub const bufferAllocationSuccessful = hb_buffer_allocation_successful;

/// Append (part of) contents of another buffer to this buffer.
extern fn hb_buffer_append(p_buffer: *harfbuzz.buffer_t, p_source: *const harfbuzz.buffer_t, p_start: c_uint, p_end: c_uint) void;
pub const bufferAppend = hb_buffer_append;

/// Similar to `harfbuzz.bufferReset`, but does not clear the Unicode functions and
/// the replacement code point.
extern fn hb_buffer_clear_contents(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferClearContents = hb_buffer_clear_contents;

/// Creates a new `harfbuzz.buffer_t` with all properties to defaults.
extern fn hb_buffer_create() *harfbuzz.buffer_t;
pub const bufferCreate = hb_buffer_create;

/// Creates a new `harfbuzz.buffer_t`, similar to `harfbuzz.bufferCreate`. The only
/// difference is that the buffer is configured similarly to `src`.
extern fn hb_buffer_create_similar(p_src: *const harfbuzz.buffer_t) *harfbuzz.buffer_t;
pub const bufferCreateSimilar = hb_buffer_create_similar;

/// Deserializes glyphs `buffer` from textual representation in the format
/// produced by `harfbuzz.bufferSerializeGlyphs`.
extern fn hb_buffer_deserialize_glyphs(p_buffer: *harfbuzz.buffer_t, p_buf: [*]const u8, p_buf_len: c_int, p_end_ptr: ?*[*:0]const u8, p_font: ?*harfbuzz.font_t, p_format: harfbuzz.buffer_serialize_format_t) harfbuzz.bool_t;
pub const bufferDeserializeGlyphs = hb_buffer_deserialize_glyphs;

/// Deserializes Unicode `buffer` from textual representation in the format
/// produced by `harfbuzz.bufferSerializeUnicode`.
extern fn hb_buffer_deserialize_unicode(p_buffer: *harfbuzz.buffer_t, p_buf: [*]const u8, p_buf_len: c_int, p_end_ptr: ?*[*:0]const u8, p_format: harfbuzz.buffer_serialize_format_t) harfbuzz.bool_t;
pub const bufferDeserializeUnicode = hb_buffer_deserialize_unicode;

/// Deallocate the `buffer`.
/// Decreases the reference count on `buffer` by one. If the result is zero, then
/// `buffer` and all associated resources are freed. See `harfbuzz.bufferReference`.
extern fn hb_buffer_destroy(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferDestroy = hb_buffer_destroy;

/// If dottedcircle_glyph is (hb_codepoint_t) -1 then `HB_BUFFER_DIFF_FLAG_DOTTED_CIRCLE_PRESENT`
/// and `HB_BUFFER_DIFF_FLAG_NOTDEF_PRESENT` are never returned.  This should be used by most
/// callers if just comparing two buffers is needed.
extern fn hb_buffer_diff(p_buffer: *harfbuzz.buffer_t, p_reference: *harfbuzz.buffer_t, p_dottedcircle_glyph: harfbuzz.codepoint_t, p_position_fuzz: c_uint) harfbuzz.buffer_diff_flags_t;
pub const bufferDiff = hb_buffer_diff;

/// Fetches the cluster level of a buffer. The `harfbuzz.buffer_cluster_level_t`
/// dictates one aspect of how HarfBuzz will treat non-base characters
/// during shaping.
extern fn hb_buffer_get_cluster_level(p_buffer: *const harfbuzz.buffer_t) harfbuzz.buffer_cluster_level_t;
pub const bufferGetClusterLevel = hb_buffer_get_cluster_level;

/// Fetches the type of `buffer` contents. Buffers are either empty, contain
/// characters (before shaping), or contain glyphs (the result of shaping).
extern fn hb_buffer_get_content_type(p_buffer: *const harfbuzz.buffer_t) harfbuzz.buffer_content_type_t;
pub const bufferGetContentType = hb_buffer_get_content_type;

/// See `harfbuzz.bufferSetDirection`
extern fn hb_buffer_get_direction(p_buffer: *const harfbuzz.buffer_t) harfbuzz.direction_t;
pub const bufferGetDirection = hb_buffer_get_direction;

/// Fetches an empty `harfbuzz.buffer_t`.
extern fn hb_buffer_get_empty() *harfbuzz.buffer_t;
pub const bufferGetEmpty = hb_buffer_get_empty;

/// Fetches the `harfbuzz.buffer_flags_t` of `buffer`.
extern fn hb_buffer_get_flags(p_buffer: *const harfbuzz.buffer_t) harfbuzz.buffer_flags_t;
pub const bufferGetFlags = hb_buffer_get_flags;

/// Returns `buffer` glyph information array.  Returned pointer
/// is valid as long as `buffer` contents are not modified.
extern fn hb_buffer_get_glyph_infos(p_buffer: *harfbuzz.buffer_t, p_length: *c_uint) [*]harfbuzz.glyph_info_t;
pub const bufferGetGlyphInfos = hb_buffer_get_glyph_infos;

/// Returns `buffer` glyph position array.  Returned pointer
/// is valid as long as `buffer` contents are not modified.
///
/// If buffer did not have positions before, the positions will be
/// initialized to zeros, unless this function is called from
/// within a buffer message callback (see `harfbuzz.bufferSetMessageFunc`),
/// in which case `NULL` is returned.
extern fn hb_buffer_get_glyph_positions(p_buffer: *harfbuzz.buffer_t, p_length: *c_uint) [*]harfbuzz.glyph_position_t;
pub const bufferGetGlyphPositions = hb_buffer_get_glyph_positions;

/// See `harfbuzz.bufferSetInvisibleGlyph`.
extern fn hb_buffer_get_invisible_glyph(p_buffer: *const harfbuzz.buffer_t) harfbuzz.codepoint_t;
pub const bufferGetInvisibleGlyph = hb_buffer_get_invisible_glyph;

/// See `harfbuzz.bufferSetLanguage`.
extern fn hb_buffer_get_language(p_buffer: *const harfbuzz.buffer_t) harfbuzz.language_t;
pub const bufferGetLanguage = hb_buffer_get_language;

/// Returns the number of items in the buffer.
extern fn hb_buffer_get_length(p_buffer: *const harfbuzz.buffer_t) c_uint;
pub const bufferGetLength = hb_buffer_get_length;

/// See `harfbuzz.bufferSetNotFoundGlyph`.
extern fn hb_buffer_get_not_found_glyph(p_buffer: *const harfbuzz.buffer_t) harfbuzz.codepoint_t;
pub const bufferGetNotFoundGlyph = hb_buffer_get_not_found_glyph;

/// See `harfbuzz.bufferSetNotFoundVariationSelectorGlyph`.
extern fn hb_buffer_get_not_found_variation_selector_glyph(p_buffer: *const harfbuzz.buffer_t) harfbuzz.codepoint_t;
pub const bufferGetNotFoundVariationSelectorGlyph = hb_buffer_get_not_found_variation_selector_glyph;

/// See `harfbuzz.bufferSetRandomState`.
extern fn hb_buffer_get_random_state(p_buffer: *const harfbuzz.buffer_t) c_uint;
pub const bufferGetRandomState = hb_buffer_get_random_state;

/// Fetches the `harfbuzz.codepoint_t` that replaces invalid entries for a given encoding
/// when adding text to `buffer`.
extern fn hb_buffer_get_replacement_codepoint(p_buffer: *const harfbuzz.buffer_t) harfbuzz.codepoint_t;
pub const bufferGetReplacementCodepoint = hb_buffer_get_replacement_codepoint;

/// Fetches the script of `buffer`.
extern fn hb_buffer_get_script(p_buffer: *const harfbuzz.buffer_t) harfbuzz.script_t;
pub const bufferGetScript = hb_buffer_get_script;

/// Sets `props` to the `harfbuzz.segment_properties_t` of `buffer`.
extern fn hb_buffer_get_segment_properties(p_buffer: *const harfbuzz.buffer_t, p_props: *harfbuzz.segment_properties_t) void;
pub const bufferGetSegmentProperties = hb_buffer_get_segment_properties;

/// Fetches the Unicode-functions structure of a buffer.
extern fn hb_buffer_get_unicode_funcs(p_buffer: *const harfbuzz.buffer_t) *harfbuzz.unicode_funcs_t;
pub const bufferGetUnicodeFuncs = hb_buffer_get_unicode_funcs;

/// Fetches the user data associated with the specified key,
/// attached to the specified buffer.
extern fn hb_buffer_get_user_data(p_buffer: *const harfbuzz.buffer_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const bufferGetUserData = hb_buffer_get_user_data;

/// Sets unset buffer segment properties based on buffer Unicode
/// contents.  If buffer is not empty, it must have content type
/// `HB_BUFFER_CONTENT_TYPE_UNICODE`.
///
/// If buffer script is not set (ie. is `HB_SCRIPT_INVALID`), it
/// will be set to the Unicode script of the first character in
/// the buffer that has a script other than `HB_SCRIPT_COMMON`,
/// `HB_SCRIPT_INHERITED`, and `HB_SCRIPT_UNKNOWN`.
///
/// Next, if buffer direction is not set (ie. is `HB_DIRECTION_INVALID`),
/// it will be set to the natural horizontal direction of the
/// buffer script as returned by `harfbuzz.scriptGetHorizontalDirection`.
/// If `harfbuzz.scriptGetHorizontalDirection` returns `HB_DIRECTION_INVALID`,
/// then `HB_DIRECTION_LTR` is used.
///
/// Finally, if buffer language is not set (ie. is `HB_LANGUAGE_INVALID`),
/// it will be set to the process's default language as returned by
/// `harfbuzz.languageGetDefault`.  This may change in the future by
/// taking buffer script into consideration when choosing a language.
/// Note that `harfbuzz.languageGetDefault` is NOT threadsafe the first time
/// it is called.  See documentation for that function for details.
extern fn hb_buffer_guess_segment_properties(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferGuessSegmentProperties = hb_buffer_guess_segment_properties;

/// Returns whether `buffer` has glyph position data.
/// A buffer gains position data when `harfbuzz.bufferGetGlyphPositions` is called on it,
/// and cleared of position data when `harfbuzz.bufferClearContents` is called.
extern fn hb_buffer_has_positions(p_buffer: *harfbuzz.buffer_t) harfbuzz.bool_t;
pub const bufferHasPositions = hb_buffer_has_positions;

/// Reorders a glyph buffer to have canonical in-cluster glyph order / position.
/// The resulting clusters should behave identical to pre-reordering clusters.
///
/// <note>This has nothing to do with Unicode normalization.</note>
extern fn hb_buffer_normalize_glyphs(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferNormalizeGlyphs = hb_buffer_normalize_glyphs;

/// Pre allocates memory for `buffer` to fit at least `size` number of items.
extern fn hb_buffer_pre_allocate(p_buffer: *harfbuzz.buffer_t, p_size: c_uint) harfbuzz.bool_t;
pub const bufferPreAllocate = hb_buffer_pre_allocate;

/// Increases the reference count on `buffer` by one. This prevents `buffer` from
/// being destroyed until a matching call to `harfbuzz.bufferDestroy` is made.
extern fn hb_buffer_reference(p_buffer: *harfbuzz.buffer_t) *harfbuzz.buffer_t;
pub const bufferReference = hb_buffer_reference;

/// Resets the buffer to its initial status, as if it was just newly created
/// with `harfbuzz.bufferCreate`.
extern fn hb_buffer_reset(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferReset = hb_buffer_reset;

/// Reverses buffer contents.
extern fn hb_buffer_reverse(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferReverse = hb_buffer_reverse;

/// Reverses buffer clusters.  That is, the buffer contents are
/// reversed, then each cluster (consecutive items having the
/// same cluster number) are reversed again.
extern fn hb_buffer_reverse_clusters(p_buffer: *harfbuzz.buffer_t) void;
pub const bufferReverseClusters = hb_buffer_reverse_clusters;

/// Reverses buffer contents between `start` and `end`.
extern fn hb_buffer_reverse_range(p_buffer: *harfbuzz.buffer_t, p_start: c_uint, p_end: c_uint) void;
pub const bufferReverseRange = hb_buffer_reverse_range;

/// Serializes `buffer` into a textual representation of its content, whether
/// Unicode codepoints or glyph identifiers and positioning information. This is
/// useful for showing the contents of the buffer, for example during debugging.
/// See the documentation of `harfbuzz.bufferSerializeUnicode` and
/// `harfbuzz.bufferSerializeGlyphs` for a description of the output format.
extern fn hb_buffer_serialize(p_buffer: *harfbuzz.buffer_t, p_start: c_uint, p_end: c_uint, p_buf: *[*]u8, p_buf_size: c_uint, p_buf_consumed: ?*c_uint, p_font: ?*harfbuzz.font_t, p_format: harfbuzz.buffer_serialize_format_t, p_flags: harfbuzz.buffer_serialize_flags_t) c_uint;
pub const bufferSerialize = hb_buffer_serialize;

/// Parses a string into an `harfbuzz.buffer_serialize_format_t`. Does not check if
/// `str` is a valid buffer serialization format, use
/// `harfbuzz.bufferSerializeListFormats` to get the list of supported formats.
extern fn hb_buffer_serialize_format_from_string(p_str: [*]const u8, p_len: c_int) harfbuzz.buffer_serialize_format_t;
pub const bufferSerializeFormatFromString = hb_buffer_serialize_format_from_string;

/// Converts `format` to the string corresponding it, or `NULL` if it is not a valid
/// `harfbuzz.buffer_serialize_format_t`.
extern fn hb_buffer_serialize_format_to_string(p_format: harfbuzz.buffer_serialize_format_t) [*:0]const u8;
pub const bufferSerializeFormatToString = hb_buffer_serialize_format_to_string;

/// Serializes `buffer` into a textual representation of its glyph content,
/// useful for showing the contents of the buffer, for example during debugging.
/// There are currently two supported serialization formats:
///
/// ## text
/// A human-readable, plain text format.
/// The serialized glyphs will look something like:
///
/// ```
/// [uni0651=0`518`,0+0|uni0628=0+1897]
/// ```
///
/// - The serialized glyphs are delimited with `[` and `]`.
/// - Glyphs are separated with `|`
/// - Each glyph starts with glyph name, or glyph index if
///   `HB_BUFFER_SERIALIZE_FLAG_NO_GLYPH_NAMES` flag is set. Then,
///   - If `HB_BUFFER_SERIALIZE_FLAG_NO_CLUSTERS` is not set, `=` then `harfbuzz.glyph_info_t.cluster`.
///   - If `HB_BUFFER_SERIALIZE_FLAG_NO_POSITIONS` is not set, the `harfbuzz.glyph_position_t` in the format:
///     - If both `harfbuzz.glyph_position_t.x_offset` and `harfbuzz.glyph_position_t.y_offset` are not 0, ``x_offset`,y_offset`. Then,
///     - `+x_advance`, then `,y_advance` if `harfbuzz.glyph_position_t.y_advance` is not 0. Then,
///   - If `HB_BUFFER_SERIALIZE_FLAG_GLYPH_EXTENTS` is set, the `harfbuzz.glyph_extents_t` in the format `<x_bearing,y_bearing,width,height>`
///
/// ## json
/// A machine-readable, structured format.
/// The serialized glyphs will look something like:
///
/// ```
/// [{"g":"uni0651","cl":0,"dx":518,"dy":0,"ax":0,"ay":0},
/// {"g":"uni0628","cl":0,"dx":0,"dy":0,"ax":1897,"ay":0}]
/// ```
///
/// Each glyph is a JSON object, with the following properties:
/// - `g`: the glyph name or glyph index if
///   `HB_BUFFER_SERIALIZE_FLAG_NO_GLYPH_NAMES` flag is set.
/// - `cl`: `harfbuzz.glyph_info_t.cluster` if
///   `HB_BUFFER_SERIALIZE_FLAG_NO_CLUSTERS` is not set.
/// - `dx`,`dy`,`ax`,`ay`: `harfbuzz.glyph_position_t.x_offset`, `harfbuzz.glyph_position_t.y_offset`,
///    `harfbuzz.glyph_position_t.x_advance` and `harfbuzz.glyph_position_t.y_advance`
///    respectively, if `HB_BUFFER_SERIALIZE_FLAG_NO_POSITIONS` is not set.
/// - `xb`,`yb`,`w`,`h`: `harfbuzz.glyph_extents_t.x_bearing`, `harfbuzz.glyph_extents_t.y_bearing`,
///    `harfbuzz.glyph_extents_t.width` and `harfbuzz.glyph_extents_t.height` respectively if
///    `HB_BUFFER_SERIALIZE_FLAG_GLYPH_EXTENTS` is set.
extern fn hb_buffer_serialize_glyphs(p_buffer: *harfbuzz.buffer_t, p_start: c_uint, p_end: c_uint, p_buf: *[*]u8, p_buf_size: c_uint, p_buf_consumed: ?*c_uint, p_font: ?*harfbuzz.font_t, p_format: harfbuzz.buffer_serialize_format_t, p_flags: harfbuzz.buffer_serialize_flags_t) c_uint;
pub const bufferSerializeGlyphs = hb_buffer_serialize_glyphs;

/// Returns a list of supported buffer serialization formats.
extern fn hb_buffer_serialize_list_formats() [*][*:0]const u8;
pub const bufferSerializeListFormats = hb_buffer_serialize_list_formats;

/// Serializes `buffer` into a textual representation of its content,
/// when the buffer contains Unicode codepoints (i.e., before shaping). This is
/// useful for showing the contents of the buffer, for example during debugging.
/// There are currently two supported serialization formats:
///
/// ## text
/// A human-readable, plain text format.
/// The serialized codepoints will look something like:
///
/// ```
///  <U+0651=0|U+0628=1>
/// ```
///
/// - Glyphs are separated with `|`
/// - Unicode codepoints are expressed as zero-padded four (or more)
///   digit hexadecimal numbers preceded by `U+`
/// - If `HB_BUFFER_SERIALIZE_FLAG_NO_CLUSTERS` is not set, the cluster
///   will be indicated with a `=` then `harfbuzz.glyph_info_t.cluster`.
///
/// ## json
/// A machine-readable, structured format.
/// The serialized codepoints will be a list of objects with the following
/// properties:
/// - `u`: the Unicode codepoint as a decimal integer
/// - `cl`: `harfbuzz.glyph_info_t.cluster` if
///   `HB_BUFFER_SERIALIZE_FLAG_NO_CLUSTERS` is not set.
///
/// For example:
///
/// ```
/// [{u:1617,cl:0},{u:1576,cl:1}]
/// ```
extern fn hb_buffer_serialize_unicode(p_buffer: *harfbuzz.buffer_t, p_start: c_uint, p_end: c_uint, p_buf: *[*]u8, p_buf_size: c_uint, p_buf_consumed: ?*c_uint, p_format: harfbuzz.buffer_serialize_format_t, p_flags: harfbuzz.buffer_serialize_flags_t) c_uint;
pub const bufferSerializeUnicode = hb_buffer_serialize_unicode;

/// Sets the cluster level of a buffer. The `harfbuzz.buffer_cluster_level_t`
/// dictates one aspect of how HarfBuzz will treat non-base characters
/// during shaping.
extern fn hb_buffer_set_cluster_level(p_buffer: *harfbuzz.buffer_t, p_cluster_level: harfbuzz.buffer_cluster_level_t) void;
pub const bufferSetClusterLevel = hb_buffer_set_cluster_level;

/// Sets the type of `buffer` contents. Buffers are either empty, contain
/// characters (before shaping), or contain glyphs (the result of shaping).
///
/// You rarely need to call this function, since a number of other
/// functions transition the content type for you. Namely:
///
/// - A newly created buffer starts with content type
///   `HB_BUFFER_CONTENT_TYPE_INVALID`. Calling `harfbuzz.bufferReset`,
///   `harfbuzz.bufferClearContents`, as well as calling `harfbuzz.bufferSetLength`
///   with an argument of zero all set the buffer content type to invalid
///   as well.
///
/// - Calling `harfbuzz.bufferAddUtf8`, `harfbuzz.bufferAddUtf16`,
///   `harfbuzz.bufferAddUtf32`, `harfbuzz.bufferAddCodepoints` and
///   `harfbuzz.bufferAddLatin1` expect that buffer is either empty and
///   have a content type of invalid, or that buffer content type is
///   `HB_BUFFER_CONTENT_TYPE_UNICODE`, and they also set the content
///   type to Unicode if they added anything to an empty buffer.
///
/// - Finally `harfbuzz.shape` and `harfbuzz.shapeFull` expect that the buffer
///   is either empty and have content type of invalid, or that buffer
///   content type is `HB_BUFFER_CONTENT_TYPE_UNICODE`, and upon
///   success they set the buffer content type to
///   `HB_BUFFER_CONTENT_TYPE_GLYPHS`.
///
/// The above transitions are designed such that one can use a buffer
/// in a loop of "reset : add-text : shape" without needing to ever
/// modify the content type manually.
extern fn hb_buffer_set_content_type(p_buffer: *harfbuzz.buffer_t, p_content_type: harfbuzz.buffer_content_type_t) void;
pub const bufferSetContentType = hb_buffer_set_content_type;

/// Set the text flow direction of the buffer. No shaping can happen without
/// setting `buffer` direction, and it controls the visual direction for the
/// output glyphs; for RTL direction the glyphs will be reversed. Many layout
/// features depend on the proper setting of the direction, for example,
/// reversing RTL text before shaping, then shaping with LTR direction is not
/// the same as keeping the text in logical order and shaping with RTL
/// direction.
extern fn hb_buffer_set_direction(p_buffer: *harfbuzz.buffer_t, p_direction: harfbuzz.direction_t) void;
pub const bufferSetDirection = hb_buffer_set_direction;

/// Sets `buffer` flags to `flags`. See `harfbuzz.buffer_flags_t`.
extern fn hb_buffer_set_flags(p_buffer: *harfbuzz.buffer_t, p_flags: harfbuzz.buffer_flags_t) void;
pub const bufferSetFlags = hb_buffer_set_flags;

/// Sets the `harfbuzz.codepoint_t` that replaces invisible characters in
/// the shaping result.  If set to zero (default), the glyph for the
/// U+0020 SPACE character is used.  Otherwise, this value is used
/// verbatim.
extern fn hb_buffer_set_invisible_glyph(p_buffer: *harfbuzz.buffer_t, p_invisible: harfbuzz.codepoint_t) void;
pub const bufferSetInvisibleGlyph = hb_buffer_set_invisible_glyph;

/// Sets the language of `buffer` to `language`.
///
/// Languages are crucial for selecting which OpenType feature to apply to the
/// buffer which can result in applying language-specific behaviour. Languages
/// are orthogonal to the scripts, and though they are related, they are
/// different concepts and should not be confused with each other.
///
/// Use `harfbuzz.languageFromString` to convert from BCP 47 language tags to
/// `harfbuzz.language_t`.
extern fn hb_buffer_set_language(p_buffer: *harfbuzz.buffer_t, p_language: harfbuzz.language_t) void;
pub const bufferSetLanguage = hb_buffer_set_language;

/// Similar to `harfbuzz.bufferPreAllocate`, but clears any new items added at the
/// end.
extern fn hb_buffer_set_length(p_buffer: *harfbuzz.buffer_t, p_length: c_uint) harfbuzz.bool_t;
pub const bufferSetLength = hb_buffer_set_length;

/// Sets the implementation function for `harfbuzz.buffer_message_func_t`.
extern fn hb_buffer_set_message_func(p_buffer: *harfbuzz.buffer_t, p_func: harfbuzz.buffer_message_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const bufferSetMessageFunc = hb_buffer_set_message_func;

/// Sets the `harfbuzz.codepoint_t` that replaces characters not found in
/// the font during shaping.
///
/// The not-found glyph defaults to zero, sometimes known as the
/// ".notdef" glyph.  This API allows for differentiating the two.
extern fn hb_buffer_set_not_found_glyph(p_buffer: *harfbuzz.buffer_t, p_not_found: harfbuzz.codepoint_t) void;
pub const bufferSetNotFoundGlyph = hb_buffer_set_not_found_glyph;

/// Sets the `harfbuzz.codepoint_t` that replaces variation-selector characters not resolved
/// in the font during shaping.
///
/// The not-found-variation-selector glyph defaults to `HB_CODEPOINT_INVALID`,
/// in which case an unresolved variation-selector will be removed from the glyph
/// string during shaping. This API allows for changing that and retaining a glyph,
/// such that the situation can be detected by the client and handled accordingly
/// (e.g. by using a different font).
extern fn hb_buffer_set_not_found_variation_selector_glyph(p_buffer: *harfbuzz.buffer_t, p_not_found_variation_selector: harfbuzz.codepoint_t) void;
pub const bufferSetNotFoundVariationSelectorGlyph = hb_buffer_set_not_found_variation_selector_glyph;

/// Sets the random state of the buffer. The state changes
/// every time a glyph uses randomness (eg. the `rand`
/// OpenType feature). This function together with
/// `harfbuzz.bufferGetRandomState` allow for transferring
/// the current random state to a subsequent buffer, to
/// get better randomness distribution.
///
/// Defaults to 1 and when buffer contents are cleared.
/// A value of 0 disables randomness during shaping.
extern fn hb_buffer_set_random_state(p_buffer: *harfbuzz.buffer_t, p_state: c_uint) void;
pub const bufferSetRandomState = hb_buffer_set_random_state;

/// Sets the `harfbuzz.codepoint_t` that replaces invalid entries for a given encoding
/// when adding text to `buffer`.
///
/// Default is `HB_BUFFER_REPLACEMENT_CODEPOINT_DEFAULT`.
extern fn hb_buffer_set_replacement_codepoint(p_buffer: *harfbuzz.buffer_t, p_replacement: harfbuzz.codepoint_t) void;
pub const bufferSetReplacementCodepoint = hb_buffer_set_replacement_codepoint;

/// Sets the script of `buffer` to `script`.
///
/// Script is crucial for choosing the proper shaping behaviour for scripts that
/// require it (e.g. Arabic) and the which OpenType features defined in the font
/// to be applied.
///
/// You can pass one of the predefined `harfbuzz.script_t` values, or use
/// `harfbuzz.scriptFromString` or `harfbuzz.scriptFromIso15924Tag` to get the
/// corresponding script from an ISO 15924 script tag.
extern fn hb_buffer_set_script(p_buffer: *harfbuzz.buffer_t, p_script: harfbuzz.script_t) void;
pub const bufferSetScript = hb_buffer_set_script;

/// Sets the segment properties of the buffer, a shortcut for calling
/// `harfbuzz.bufferSetDirection`, `harfbuzz.bufferSetScript` and
/// `harfbuzz.bufferSetLanguage` individually.
extern fn hb_buffer_set_segment_properties(p_buffer: *harfbuzz.buffer_t, p_props: *const harfbuzz.segment_properties_t) void;
pub const bufferSetSegmentProperties = hb_buffer_set_segment_properties;

/// Sets the Unicode-functions structure of a buffer to
/// `unicode_funcs`.
extern fn hb_buffer_set_unicode_funcs(p_buffer: *harfbuzz.buffer_t, p_unicode_funcs: *harfbuzz.unicode_funcs_t) void;
pub const bufferSetUnicodeFuncs = hb_buffer_set_unicode_funcs;

/// Attaches a user-data key/data pair to the specified buffer.
extern fn hb_buffer_set_user_data(p_buffer: *harfbuzz.buffer_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const bufferSetUserData = hb_buffer_set_user_data;

/// Allocates `nmemb` elements of `size` bytes each, initialized to zero,
/// using the allocator set at compile-time. Typically just `calloc`.
extern fn hb_calloc(p_nmemb: usize, p_size: usize) ?*anyopaque;
pub const calloc = hb_calloc;

/// Fetches the alpha channel of the given `color`.
extern fn hb_color_get_alpha(p_color: harfbuzz.color_t) u8;
pub const colorGetAlpha = hb_color_get_alpha;

/// Fetches the blue channel of the given `color`.
extern fn hb_color_get_blue(p_color: harfbuzz.color_t) u8;
pub const colorGetBlue = hb_color_get_blue;

/// Fetches the green channel of the given `color`.
extern fn hb_color_get_green(p_color: harfbuzz.color_t) u8;
pub const colorGetGreen = hb_color_get_green;

/// Fetches the red channel of the given `color`.
extern fn hb_color_get_red(p_color: harfbuzz.color_t) u8;
pub const colorGetRed = hb_color_get_red;

/// Fetches a list of color stops from the given color line object.
///
/// Note that due to variations being applied, the returned color stops
/// may be out of order. It is the callers responsibility to ensure that
/// color stops are sorted by their offset before they are used.
extern fn hb_color_line_get_color_stops(p_color_line: *harfbuzz.color_line_t, p_start: c_uint, p_count: ?*c_uint, p_color_stops: ?*[*]harfbuzz.color_stop_t) c_uint;
pub const colorLineGetColorStops = hb_color_line_get_color_stops;

/// Fetches the extend mode of the color line object.
extern fn hb_color_line_get_extend(p_color_line: *harfbuzz.color_line_t) harfbuzz.paint_extend_t;
pub const colorLineGetExtend = hb_color_line_get_extend;

/// Converts a string to an `harfbuzz.direction_t`.
///
/// Matching is loose and applies only to the first letter. For
/// examples, "LTR" and "left-to-right" will both return `HB_DIRECTION_LTR`.
///
/// Unmatched strings will return `HB_DIRECTION_INVALID`.
extern fn hb_direction_from_string(p_str: [*]const u8, p_len: c_int) harfbuzz.direction_t;
pub const directionFromString = hb_direction_from_string;

/// Converts an `harfbuzz.direction_t` to a string.
extern fn hb_direction_to_string(p_direction: harfbuzz.direction_t) [*:0]const u8;
pub const directionToString = hb_direction_to_string;

/// Perform a "close-path" draw operation.
extern fn hb_draw_close_path(p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t) void;
pub const drawClosePath = hb_draw_close_path;

/// Perform a "cubic-to" draw operation.
extern fn hb_draw_cubic_to(p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_control1_x: f32, p_control1_y: f32, p_control2_x: f32, p_control2_y: f32, p_to_x: f32, p_to_y: f32) void;
pub const drawCubicTo = hb_draw_cubic_to;

/// Creates a new draw callbacks object.
extern fn hb_draw_funcs_create() *harfbuzz.draw_funcs_t;
pub const drawFuncsCreate = hb_draw_funcs_create;

/// Deallocate the `dfuncs`.
/// Decreases the reference count on `dfuncs` by one. If the result is zero, then
/// `dfuncs` and all associated resources are freed. See `harfbuzz.drawFuncsReference`.
extern fn hb_draw_funcs_destroy(p_dfuncs: *harfbuzz.draw_funcs_t) void;
pub const drawFuncsDestroy = hb_draw_funcs_destroy;

/// Fetches the singleton empty draw-functions structure.
extern fn hb_draw_funcs_get_empty() *harfbuzz.draw_funcs_t;
pub const drawFuncsGetEmpty = hb_draw_funcs_get_empty;

/// Fetches the user-data associated with the specified key,
/// attached to the specified draw-functions structure.
extern fn hb_draw_funcs_get_user_data(p_dfuncs: *const harfbuzz.draw_funcs_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const drawFuncsGetUserData = hb_draw_funcs_get_user_data;

/// Checks whether `dfuncs` is immutable.
extern fn hb_draw_funcs_is_immutable(p_dfuncs: *harfbuzz.draw_funcs_t) harfbuzz.bool_t;
pub const drawFuncsIsImmutable = hb_draw_funcs_is_immutable;

/// Makes `dfuncs` object immutable.
extern fn hb_draw_funcs_make_immutable(p_dfuncs: *harfbuzz.draw_funcs_t) void;
pub const drawFuncsMakeImmutable = hb_draw_funcs_make_immutable;

/// Increases the reference count on `dfuncs` by one.
///
/// This prevents `dfuncs` from being destroyed until a matching
/// call to `harfbuzz.drawFuncsDestroy` is made.
extern fn hb_draw_funcs_reference(p_dfuncs: *harfbuzz.draw_funcs_t) *harfbuzz.draw_funcs_t;
pub const drawFuncsReference = hb_draw_funcs_reference;

/// Sets close-path callback to the draw functions object.
extern fn hb_draw_funcs_set_close_path_func(p_dfuncs: *harfbuzz.draw_funcs_t, p_func: harfbuzz.draw_close_path_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const drawFuncsSetClosePathFunc = hb_draw_funcs_set_close_path_func;

/// Sets cubic-to callback to the draw functions object.
extern fn hb_draw_funcs_set_cubic_to_func(p_dfuncs: *harfbuzz.draw_funcs_t, p_func: harfbuzz.draw_cubic_to_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const drawFuncsSetCubicToFunc = hb_draw_funcs_set_cubic_to_func;

/// Sets line-to callback to the draw functions object.
extern fn hb_draw_funcs_set_line_to_func(p_dfuncs: *harfbuzz.draw_funcs_t, p_func: harfbuzz.draw_line_to_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const drawFuncsSetLineToFunc = hb_draw_funcs_set_line_to_func;

/// Sets move-to callback to the draw functions object.
extern fn hb_draw_funcs_set_move_to_func(p_dfuncs: *harfbuzz.draw_funcs_t, p_func: harfbuzz.draw_move_to_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const drawFuncsSetMoveToFunc = hb_draw_funcs_set_move_to_func;

/// Sets quadratic-to callback to the draw functions object.
extern fn hb_draw_funcs_set_quadratic_to_func(p_dfuncs: *harfbuzz.draw_funcs_t, p_func: harfbuzz.draw_quadratic_to_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const drawFuncsSetQuadraticToFunc = hb_draw_funcs_set_quadratic_to_func;

/// Attaches a user-data key/data pair to the specified draw-functions structure.
extern fn hb_draw_funcs_set_user_data(p_dfuncs: *harfbuzz.draw_funcs_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const drawFuncsSetUserData = hb_draw_funcs_set_user_data;

/// Perform a "line-to" draw operation.
extern fn hb_draw_line_to(p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_to_x: f32, p_to_y: f32) void;
pub const drawLineTo = hb_draw_line_to;

/// Perform a "move-to" draw operation.
extern fn hb_draw_move_to(p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_to_x: f32, p_to_y: f32) void;
pub const drawMoveTo = hb_draw_move_to;

/// Perform a "quadratic-to" draw operation.
extern fn hb_draw_quadratic_to(p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_control_x: f32, p_control_y: f32, p_to_x: f32, p_to_y: f32) void;
pub const drawQuadraticTo = hb_draw_quadratic_to;

/// Add table for `tag` with data provided by `blob` to the face.  `face` must
/// be created using `harfbuzz.faceBuilderCreate`.
extern fn hb_face_builder_add_table(p_face: *harfbuzz.face_t, p_tag: harfbuzz.tag_t, p_blob: *harfbuzz.blob_t) harfbuzz.bool_t;
pub const faceBuilderAddTable = hb_face_builder_add_table;

/// Creates a `harfbuzz.face_t` that can be used with `harfbuzz.faceBuilderAddTable`.
/// After tables are added to the face, it can be compiled to a binary
/// font file by calling `harfbuzz.faceReferenceBlob`.
extern fn hb_face_builder_create() *harfbuzz.face_t;
pub const faceBuilderCreate = hb_face_builder_create;

/// Set the ordering of tables for serialization. Any tables not
/// specified in the tags list will be ordered after the tables in
/// tags, ordered by the default sort ordering.
extern fn hb_face_builder_sort_tables(p_face: *harfbuzz.face_t, p_tags: [*]const harfbuzz.tag_t) void;
pub const faceBuilderSortTables = hb_face_builder_sort_tables;

/// Collects the mapping from Unicode characters to nominal glyphs of the `face`,
/// and optionally all of the Unicode characters covered by `face`.
extern fn hb_face_collect_nominal_glyph_mapping(p_face: *harfbuzz.face_t, p_mapping: *harfbuzz.map_t, p_unicodes: ?*harfbuzz.set_t) void;
pub const faceCollectNominalGlyphMapping = hb_face_collect_nominal_glyph_mapping;

/// Collects all of the Unicode characters covered by `face` and adds
/// them to the `harfbuzz.set_t` set `out`.
extern fn hb_face_collect_unicodes(p_face: *harfbuzz.face_t, p_out: *harfbuzz.set_t) void;
pub const faceCollectUnicodes = hb_face_collect_unicodes;

/// Collects all Unicode "Variation Selector" characters covered by `face` and adds
/// them to the `harfbuzz.set_t` set `out`.
extern fn hb_face_collect_variation_selectors(p_face: *harfbuzz.face_t, p_out: *harfbuzz.set_t) void;
pub const faceCollectVariationSelectors = hb_face_collect_variation_selectors;

/// Collects all Unicode characters for `variation_selector` covered by `face` and adds
/// them to the `harfbuzz.set_t` set `out`.
extern fn hb_face_collect_variation_unicodes(p_face: *harfbuzz.face_t, p_variation_selector: harfbuzz.codepoint_t, p_out: *harfbuzz.set_t) void;
pub const faceCollectVariationUnicodes = hb_face_collect_variation_unicodes;

/// Fetches the number of faces in a blob.
extern fn hb_face_count(p_blob: *harfbuzz.blob_t) c_uint;
pub const faceCount = hb_face_count;

/// Constructs a new face object from the specified blob and
/// a face index into that blob.
///
/// The face index is used for blobs of file formats such as TTC and
/// DFont that can contain more than one face.  Face indices within
/// such collections are zero-based.
///
/// <note>Note: If the blob font format is not a collection, `index`
/// is ignored.  Otherwise, only the lower 16-bits of `index` are used.
/// The unmodified `index` can be accessed via `harfbuzz.faceGetIndex`.</note>
///
/// <note>Note: The high 16-bits of `index`, if non-zero, are used by
/// `harfbuzz.fontCreate` to load named-instances in variable fonts.  See
/// `harfbuzz.fontCreate` for details.</note>
extern fn hb_face_create(p_blob: *harfbuzz.blob_t, p_index: c_uint) *harfbuzz.face_t;
pub const faceCreate = hb_face_create;

/// Variant of `harfbuzz.faceCreate`, built for those cases where it is more
/// convenient to provide data for individual tables instead of the whole font
/// data. With the caveat that `harfbuzz.faceGetTableTags` would not work
/// with faces created this way. You can address that by calling the
/// `harfbuzz.faceSetGetTableTagsFunc` function and setting the appropriate callback.
///
/// Creates a new face object from the specified `user_data` and `reference_table_func`,
/// with the `destroy` callback.
extern fn hb_face_create_for_tables(p_reference_table_func: harfbuzz.reference_table_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) *harfbuzz.face_t;
pub const faceCreateForTables = hb_face_create_for_tables;

/// A thin wrapper around `harfbuzz.blobCreateFromFileOrFail`
/// followed by `harfbuzz.faceCreateOrFail`.
extern fn hb_face_create_from_file_or_fail(p_file_name: [*:0]const u8, p_index: c_uint) *harfbuzz.face_t;
pub const faceCreateFromFileOrFail = hb_face_create_from_file_or_fail;

/// A thin wrapper around the face loader functions registered with HarfBuzz.
/// If `loader_name` is `NULL` or the empty string, the first available loader
/// is used.
///
/// For example, the FreeType ("ft") loader might be able to load
/// WOFF and WOFF2 files if FreeType is built with those features,
/// whereas the OpenType ("ot") loader will not.
extern fn hb_face_create_from_file_or_fail_using(p_file_name: [*:0]const u8, p_index: c_uint, p_loader_name: ?[*:0]const u8) *harfbuzz.face_t;
pub const faceCreateFromFileOrFailUsing = hb_face_create_from_file_or_fail_using;

/// Like `harfbuzz.faceCreate`, but returns `NULL` if the blob data
/// contains no usable font face at the specified index.
extern fn hb_face_create_or_fail(p_blob: *harfbuzz.blob_t, p_index: c_uint) *harfbuzz.face_t;
pub const faceCreateOrFail = hb_face_create_or_fail;

/// A thin wrapper around the face loader functions registered with HarfBuzz.
/// If `loader_name` is `NULL` or the empty string, the first available loader
/// is used.
///
/// For example, the FreeType ("ft") loader might be able to load
/// WOFF and WOFF2 files if FreeType is built with those features,
/// whereas the OpenType ("ot") loader will not.
extern fn hb_face_create_or_fail_using(p_blob: *harfbuzz.blob_t, p_index: c_uint, p_loader_name: ?[*:0]const u8) *harfbuzz.face_t;
pub const faceCreateOrFailUsing = hb_face_create_or_fail_using;

/// Decreases the reference count on a face object. When the
/// reference count reaches zero, the face is destroyed,
/// freeing all memory.
extern fn hb_face_destroy(p_face: *harfbuzz.face_t) void;
pub const faceDestroy = hb_face_destroy;

/// Fetches the singleton empty face object.
extern fn hb_face_get_empty() *harfbuzz.face_t;
pub const faceGetEmpty = hb_face_get_empty;

/// Fetches the glyph-count value of the specified face object.
extern fn hb_face_get_glyph_count(p_face: *const harfbuzz.face_t) c_uint;
pub const faceGetGlyphCount = hb_face_get_glyph_count;

/// Fetches the face-index corresponding to the given face.
///
/// <note>Note: face indices within a collection are zero-based.</note>
extern fn hb_face_get_index(p_face: *const harfbuzz.face_t) c_uint;
pub const faceGetIndex = hb_face_get_index;

/// Fetches a list of all table tags for a face, if possible. The list returned will
/// begin at the offset provided
extern fn hb_face_get_table_tags(p_face: *const harfbuzz.face_t, p_start_offset: c_uint, p_table_count: *c_uint, p_table_tags: *[*]harfbuzz.tag_t) c_uint;
pub const faceGetTableTags = hb_face_get_table_tags;

/// Fetches the units-per-em (UPEM) value of the specified face object.
///
/// Typical UPEM values for fonts are 1000, or 2048, but any value
/// in between 16 and 16,384 is allowed for OpenType fonts.
extern fn hb_face_get_upem(p_face: *const harfbuzz.face_t) c_uint;
pub const faceGetUpem = hb_face_get_upem;

/// Fetches the user data associated with the specified key,
/// attached to the specified face object.
extern fn hb_face_get_user_data(p_face: *const harfbuzz.face_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const faceGetUserData = hb_face_get_user_data;

/// Tests whether the given face object is immutable.
extern fn hb_face_is_immutable(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const faceIsImmutable = hb_face_is_immutable;

/// Retrieves the list of face loaders supported by HarfBuzz.
extern fn hb_face_list_loaders() [*][*:0]const u8;
pub const faceListLoaders = hb_face_list_loaders;

/// Makes the given face object immutable.
extern fn hb_face_make_immutable(p_face: *harfbuzz.face_t) void;
pub const faceMakeImmutable = hb_face_make_immutable;

/// Increases the reference count on a face object.
extern fn hb_face_reference(p_face: *harfbuzz.face_t) *harfbuzz.face_t;
pub const faceReference = hb_face_reference;

/// Fetches a pointer to the binary blob that contains the specified face.
/// If referencing the face data is not possible, this function creates a blob
/// out of individual table blobs if `harfbuzz.faceGetTableTags` works with this
/// face, otherwise it returns an empty blob.
extern fn hb_face_reference_blob(p_face: *harfbuzz.face_t) *harfbuzz.blob_t;
pub const faceReferenceBlob = hb_face_reference_blob;

/// Fetches a reference to the specified table within
/// the specified face. Returns an empty blob if referencing table data is not
/// possible.
extern fn hb_face_reference_table(p_face: *const harfbuzz.face_t, p_tag: harfbuzz.tag_t) *harfbuzz.blob_t;
pub const faceReferenceTable = hb_face_reference_table;

/// Sets the table-tag-fetching function for the specified face object.
extern fn hb_face_set_get_table_tags_func(p_face: *harfbuzz.face_t, p_func: harfbuzz.get_table_tags_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const faceSetGetTableTagsFunc = hb_face_set_get_table_tags_func;

/// Sets the glyph count for a face object to the specified value.
///
/// This API is used in rare circumstances.
extern fn hb_face_set_glyph_count(p_face: *harfbuzz.face_t, p_glyph_count: c_uint) void;
pub const faceSetGlyphCount = hb_face_set_glyph_count;

/// Assigns the specified face-index to `face`. Fails if the
/// face is immutable.
///
/// <note>Note: changing the index has no effect on the face itself
/// This only changes the value returned by `harfbuzz.faceGetIndex`.</note>
extern fn hb_face_set_index(p_face: *harfbuzz.face_t, p_index: c_uint) void;
pub const faceSetIndex = hb_face_set_index;

/// Sets the units-per-em (upem) for a face object to the specified value.
///
/// This API is used in rare circumstances.
extern fn hb_face_set_upem(p_face: *harfbuzz.face_t, p_upem: c_uint) void;
pub const faceSetUpem = hb_face_set_upem;

/// Attaches a user-data key/data pair to the given face object.
extern fn hb_face_set_user_data(p_face: *harfbuzz.face_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const faceSetUserData = hb_face_set_user_data;

/// Parses a string into a `harfbuzz.feature_t`.
///
/// The format for specifying feature strings follows. All valid CSS
/// font-feature-settings values other than 'normal' and the global values are
/// also accepted, though not documented below. CSS string escapes are not
/// supported.
///
/// The range indices refer to the positions between Unicode characters. The
/// position before the first character is always 0.
///
/// The format is Python-esque.  Here is how it all works:
///
/// <informaltable pgwide='1' align='left' frame='none'>
/// <tgroup cols='5'>
/// <thead>
/// <row><entry>Syntax</entry>    <entry>Value</entry> <entry>Start</entry> <entry>End</entry></row>
/// </thead>
/// <tbody>
/// <row><entry>Setting value:</entry></row>
/// <row><entry>kern</entry>      <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
/// <row><entry>+kern</entry>     <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
/// <row><entry>-kern</entry>     <entry>0</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature off</entry></row>
/// <row><entry>kern=0</entry>    <entry>0</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature off</entry></row>
/// <row><entry>kern=1</entry>    <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
/// <row><entry>aalt=2</entry>    <entry>2</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Choose 2nd alternate</entry></row>
/// <row><entry>Setting index:</entry></row>
/// <row><entry>kern[]</entry>    <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
/// <row><entry>kern[:]</entry>   <entry>1</entry>     <entry>0</entry>      <entry>∞</entry>   <entry>Turn feature on</entry></row>
/// <row><entry>kern[5:]</entry>  <entry>1</entry>     <entry>5</entry>      <entry>∞</entry>   <entry>Turn feature on, partial</entry></row>
/// <row><entry>kern[:5]</entry>  <entry>1</entry>     <entry>0</entry>      <entry>5</entry>   <entry>Turn feature on, partial</entry></row>
/// <row><entry>kern[3:5]</entry> <entry>1</entry>     <entry>3</entry>      <entry>5</entry>   <entry>Turn feature on, range</entry></row>
/// <row><entry>kern[3]</entry>   <entry>1</entry>     <entry>3</entry>      <entry>3+1</entry> <entry>Turn feature on, single char</entry></row>
/// <row><entry>Mixing it all:</entry></row>
/// <row><entry>aalt[3:5]=2</entry> <entry>2</entry>   <entry>3</entry>      <entry>5</entry>   <entry>Turn 2nd alternate on for range</entry></row>
/// </tbody>
/// </tgroup>
/// </informaltable>
extern fn hb_feature_from_string(p_str: [*]const u8, p_len: c_int, p_feature: *harfbuzz.feature_t) harfbuzz.bool_t;
pub const featureFromString = hb_feature_from_string;

/// Converts a `harfbuzz.feature_t` into a `NULL`-terminated string in the format
/// understood by `harfbuzz.featureFromString`. The client in responsible for
/// allocating big enough size for `buf`, 128 bytes is more than enough.
///
/// Note that the feature value will be omitted if it is '1', but the
/// string won't include any whitespace.
extern fn hb_feature_to_string(p_feature: *harfbuzz.feature_t, p_buf: *[*]u8, p_size: c_uint) void;
pub const featureToString = hb_feature_to_string;

/// Adds the origin coordinates to an (X,Y) point coordinate, in
/// the specified glyph ID in the specified font.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_add_glyph_origin_for_direction(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) void;
pub const fontAddGlyphOriginForDirection = hb_font_add_glyph_origin_for_direction;

/// Notifies the `font` that underlying font data has changed.
/// This has the effect of increasing the serial as returned
/// by `harfbuzz.fontGetSerial`, which invalidates internal caches.
extern fn hb_font_changed(p_font: *harfbuzz.font_t) void;
pub const fontChanged = hb_font_changed;

/// Constructs a new font object from the specified face.
///
/// <note>Note: If `face`'s index value (as passed to `harfbuzz.faceCreate`
/// has non-zero top 16-bits, those bits minus one are passed to
/// `harfbuzz.fontSetVarNamedInstance`, effectively loading a named-instance
/// of a variable font, instead of the default-instance.  This allows
/// specifying which named-instance to load by default when creating the
/// face.</note>
extern fn hb_font_create(p_face: *harfbuzz.face_t) *harfbuzz.font_t;
pub const fontCreate = hb_font_create;

/// Constructs a sub-font font object from the specified `parent` font,
/// replicating the parent's properties.
extern fn hb_font_create_sub_font(p_parent: *harfbuzz.font_t) *harfbuzz.font_t;
pub const fontCreateSubFont = hb_font_create_sub_font;

/// Decreases the reference count on the given font object. When the
/// reference count reaches zero, the font is destroyed,
/// freeing all memory.
extern fn hb_font_destroy(p_font: *harfbuzz.font_t) void;
pub const fontDestroy = hb_font_destroy;

/// Draws the outline that corresponds to a glyph in the specified `font`.
///
/// This is an older name for `harfbuzz.fontDrawGlyphOrFail`, with no
/// return value.
///
/// The outline is returned by way of calls to the callbacks of the `dfuncs`
/// objects, with `draw_data` passed to them.
extern fn hb_font_draw_glyph(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque) void;
pub const fontDrawGlyph = hb_font_draw_glyph;

/// Draws the outline that corresponds to a glyph in the specified `font`.
///
/// This is a newer name for `harfbuzz.fontDrawGlyph`, that returns `false`
/// if the font has no outlines for the glyph.
///
/// The outline is returned by way of calls to the callbacks of the `dfuncs`
/// objects, with `draw_data` passed to them.
extern fn hb_font_draw_glyph_or_fail(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque) harfbuzz.bool_t;
pub const fontDrawGlyphOrFail = hb_font_draw_glyph_or_fail;

/// Creates a new `harfbuzz.font_funcs_t` structure of font functions.
extern fn hb_font_funcs_create() *harfbuzz.font_funcs_t;
pub const fontFuncsCreate = hb_font_funcs_create;

/// Decreases the reference count on a font-functions structure. When
/// the reference count reaches zero, the font-functions structure is
/// destroyed, freeing all memory.
extern fn hb_font_funcs_destroy(p_ffuncs: *harfbuzz.font_funcs_t) void;
pub const fontFuncsDestroy = hb_font_funcs_destroy;

/// Fetches an empty font-functions structure.
extern fn hb_font_funcs_get_empty() *harfbuzz.font_funcs_t;
pub const fontFuncsGetEmpty = hb_font_funcs_get_empty;

/// Fetches the user data associated with the specified key,
/// attached to the specified font-functions structure.
extern fn hb_font_funcs_get_user_data(p_ffuncs: *const harfbuzz.font_funcs_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const fontFuncsGetUserData = hb_font_funcs_get_user_data;

/// Tests whether a font-functions structure is immutable.
extern fn hb_font_funcs_is_immutable(p_ffuncs: *harfbuzz.font_funcs_t) harfbuzz.bool_t;
pub const fontFuncsIsImmutable = hb_font_funcs_is_immutable;

/// Makes a font-functions structure immutable.
extern fn hb_font_funcs_make_immutable(p_ffuncs: *harfbuzz.font_funcs_t) void;
pub const fontFuncsMakeImmutable = hb_font_funcs_make_immutable;

/// Increases the reference count on a font-functions structure.
extern fn hb_font_funcs_reference(p_ffuncs: *harfbuzz.font_funcs_t) *harfbuzz.font_funcs_t;
pub const fontFuncsReference = hb_font_funcs_reference;

/// Sets the implementation function for `harfbuzz.font_draw_glyph_func_t`.
extern fn hb_font_funcs_set_draw_glyph_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_draw_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetDrawGlyphFunc = hb_font_funcs_set_draw_glyph_func;

/// Sets the implementation function for `harfbuzz.font_draw_glyph_or_fail_func_t`.
///
/// XSince: REPLACEME
extern fn hb_font_funcs_set_draw_glyph_or_fail_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_draw_glyph_or_fail_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetDrawGlyphOrFailFunc = hb_font_funcs_set_draw_glyph_or_fail_func;

/// Sets the implementation function for `harfbuzz.font_get_font_h_extents_func_t`.
extern fn hb_font_funcs_set_font_h_extents_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_font_h_extents_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetFontHExtentsFunc = hb_font_funcs_set_font_h_extents_func;

/// Sets the implementation function for `harfbuzz.font_get_font_v_extents_func_t`.
extern fn hb_font_funcs_set_font_v_extents_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_font_v_extents_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetFontVExtentsFunc = hb_font_funcs_set_font_v_extents_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_contour_point_func_t`.
extern fn hb_font_funcs_set_glyph_contour_point_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_contour_point_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphContourPointFunc = hb_font_funcs_set_glyph_contour_point_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_extents_func_t`.
extern fn hb_font_funcs_set_glyph_extents_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_extents_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphExtentsFunc = hb_font_funcs_set_glyph_extents_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_from_name_func_t`.
extern fn hb_font_funcs_set_glyph_from_name_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_from_name_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphFromNameFunc = hb_font_funcs_set_glyph_from_name_func;

/// Deprecated.  Use `harfbuzz.fontFuncsSetNominalGlyphFunc` and
/// `harfbuzz.fontFuncsSetVariationGlyphFunc` instead.
extern fn hb_font_funcs_set_glyph_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphFunc = hb_font_funcs_set_glyph_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_h_advance_func_t`.
extern fn hb_font_funcs_set_glyph_h_advance_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_h_advance_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphHAdvanceFunc = hb_font_funcs_set_glyph_h_advance_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_h_advances_func_t`.
extern fn hb_font_funcs_set_glyph_h_advances_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_h_advances_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphHAdvancesFunc = hb_font_funcs_set_glyph_h_advances_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_h_kerning_func_t`.
extern fn hb_font_funcs_set_glyph_h_kerning_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_h_kerning_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphHKerningFunc = hb_font_funcs_set_glyph_h_kerning_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_h_origin_func_t`.
extern fn hb_font_funcs_set_glyph_h_origin_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_h_origin_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphHOriginFunc = hb_font_funcs_set_glyph_h_origin_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_name_func_t`.
extern fn hb_font_funcs_set_glyph_name_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_name_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphNameFunc = hb_font_funcs_set_glyph_name_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_shape_func_t`,
/// which is the same as `harfbuzz.font_draw_glyph_func_t`.
extern fn hb_font_funcs_set_glyph_shape_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_shape_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphShapeFunc = hb_font_funcs_set_glyph_shape_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_v_advance_func_t`.
extern fn hb_font_funcs_set_glyph_v_advance_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_v_advance_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphVAdvanceFunc = hb_font_funcs_set_glyph_v_advance_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_v_advances_func_t`.
extern fn hb_font_funcs_set_glyph_v_advances_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_v_advances_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphVAdvancesFunc = hb_font_funcs_set_glyph_v_advances_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_v_kerning_func_t`.
extern fn hb_font_funcs_set_glyph_v_kerning_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_v_kerning_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphVKerningFunc = hb_font_funcs_set_glyph_v_kerning_func;

/// Sets the implementation function for `harfbuzz.font_get_glyph_v_origin_func_t`.
extern fn hb_font_funcs_set_glyph_v_origin_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_glyph_v_origin_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetGlyphVOriginFunc = hb_font_funcs_set_glyph_v_origin_func;

/// Sets the implementation function for `harfbuzz.font_get_nominal_glyph_func_t`.
extern fn hb_font_funcs_set_nominal_glyph_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_nominal_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetNominalGlyphFunc = hb_font_funcs_set_nominal_glyph_func;

/// Sets the implementation function for `harfbuzz.font_get_nominal_glyphs_func_t`.
extern fn hb_font_funcs_set_nominal_glyphs_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_nominal_glyphs_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetNominalGlyphsFunc = hb_font_funcs_set_nominal_glyphs_func;

/// Sets the implementation function for `harfbuzz.font_paint_glyph_func_t`.
extern fn hb_font_funcs_set_paint_glyph_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_paint_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetPaintGlyphFunc = hb_font_funcs_set_paint_glyph_func;

/// Sets the implementation function for `harfbuzz.font_paint_glyph_or_fail_func_t`.
///
/// XSince: REPLACEME
extern fn hb_font_funcs_set_paint_glyph_or_fail_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_paint_glyph_or_fail_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetPaintGlyphOrFailFunc = hb_font_funcs_set_paint_glyph_or_fail_func;

/// Attaches a user-data key/data pair to the specified font-functions structure.
extern fn hb_font_funcs_set_user_data(p_ffuncs: *harfbuzz.font_funcs_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const fontFuncsSetUserData = hb_font_funcs_set_user_data;

/// Sets the implementation function for `harfbuzz.font_get_variation_glyph_func_t`.
extern fn hb_font_funcs_set_variation_glyph_func(p_ffuncs: *harfbuzz.font_funcs_t, p_func: harfbuzz.font_get_variation_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontFuncsSetVariationGlyphFunc = hb_font_funcs_set_variation_glyph_func;

/// Fetches the empty font object.
extern fn hb_font_get_empty() *harfbuzz.font_t;
pub const fontGetEmpty = hb_font_get_empty;

/// Fetches the extents for a font in a text segment of the
/// specified direction.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_extents_for_direction(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t, p_extents: *harfbuzz.font_extents_t) void;
pub const fontGetExtentsForDirection = hb_font_get_extents_for_direction;

/// Fetches the face associated with the specified font object.
extern fn hb_font_get_face(p_font: *harfbuzz.font_t) *harfbuzz.face_t;
pub const fontGetFace = hb_font_get_face;

/// Fetches the glyph ID for a Unicode code point in the specified
/// font, with an optional variation selector.
///
/// If `variation_selector` is 0, calls `harfbuzz.fontGetNominalGlyph`;
/// otherwise calls `harfbuzz.fontGetVariationGlyph`.
extern fn hb_font_get_glyph(p_font: *harfbuzz.font_t, p_unicode: harfbuzz.codepoint_t, p_variation_selector: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const fontGetGlyph = hb_font_get_glyph;

/// Fetches the advance for a glyph ID from the specified font,
/// in a text segment of the specified direction.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_advance_for_direction(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) void;
pub const fontGetGlyphAdvanceForDirection = hb_font_get_glyph_advance_for_direction;

/// Fetches the advances for a sequence of glyph IDs in the specified
/// font, in a text segment of the specified direction.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_advances_for_direction(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t, p_count: c_uint, p_first_glyph: *const harfbuzz.codepoint_t, p_glyph_stride: c_uint, p_first_advance: *harfbuzz.position_t, p_advance_stride: c_uint) void;
pub const fontGetGlyphAdvancesForDirection = hb_font_get_glyph_advances_for_direction;

/// Fetches the (x,y) coordinates of a specified contour-point index
/// in the specified glyph, within the specified font.
extern fn hb_font_get_glyph_contour_point(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_point_index: c_uint, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) harfbuzz.bool_t;
pub const fontGetGlyphContourPoint = hb_font_get_glyph_contour_point;

/// Fetches the (X,Y) coordinates of a specified contour-point index
/// in the specified glyph ID in the specified font, with respect
/// to the origin in a text segment in the specified direction.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_contour_point_for_origin(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_point_index: c_uint, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) harfbuzz.bool_t;
pub const fontGetGlyphContourPointForOrigin = hb_font_get_glyph_contour_point_for_origin;

/// Fetches the `harfbuzz.glyph_extents_t` data for a glyph ID
/// in the specified font.
extern fn hb_font_get_glyph_extents(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_extents: *harfbuzz.glyph_extents_t) harfbuzz.bool_t;
pub const fontGetGlyphExtents = hb_font_get_glyph_extents;

/// Fetches the `harfbuzz.glyph_extents_t` data for a glyph ID
/// in the specified font, with respect to the origin in
/// a text segment in the specified direction.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_extents_for_origin(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_extents: *harfbuzz.glyph_extents_t) harfbuzz.bool_t;
pub const fontGetGlyphExtentsForOrigin = hb_font_get_glyph_extents_for_origin;

/// Fetches the glyph ID that corresponds to a name string in the specified `font`.
///
/// <note>Note: `len` == -1 means the name string is null-terminated.</note>
extern fn hb_font_get_glyph_from_name(p_font: *harfbuzz.font_t, p_name: [*]const u8, p_len: c_int, p_glyph: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const fontGetGlyphFromName = hb_font_get_glyph_from_name;

/// Fetches the advance for a glyph ID in the specified font,
/// for horizontal text segments.
extern fn hb_font_get_glyph_h_advance(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const fontGetGlyphHAdvance = hb_font_get_glyph_h_advance;

/// Fetches the advances for a sequence of glyph IDs in the specified
/// font, for horizontal text segments.
extern fn hb_font_get_glyph_h_advances(p_font: *harfbuzz.font_t, p_count: c_uint, p_first_glyph: *const harfbuzz.codepoint_t, p_glyph_stride: c_uint, p_first_advance: *harfbuzz.position_t, p_advance_stride: c_uint) void;
pub const fontGetGlyphHAdvances = hb_font_get_glyph_h_advances;

/// Fetches the kerning-adjustment value for a glyph-pair in
/// the specified font, for horizontal text segments.
///
/// <note>It handles legacy kerning only (as returned by the corresponding
/// `harfbuzz.font_funcs_t` function).</note>
extern fn hb_font_get_glyph_h_kerning(p_font: *harfbuzz.font_t, p_left_glyph: harfbuzz.codepoint_t, p_right_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const fontGetGlyphHKerning = hb_font_get_glyph_h_kerning;

/// Fetches the (X,Y) coordinates of the origin for a glyph ID
/// in the specified font, for horizontal text segments.
extern fn hb_font_get_glyph_h_origin(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) harfbuzz.bool_t;
pub const fontGetGlyphHOrigin = hb_font_get_glyph_h_origin;

/// Fetches the kerning-adjustment value for a glyph-pair in the specified font.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_kerning_for_direction(p_font: *harfbuzz.font_t, p_first_glyph: harfbuzz.codepoint_t, p_second_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) void;
pub const fontGetGlyphKerningForDirection = hb_font_get_glyph_kerning_for_direction;

/// Fetches the glyph-name string for a glyph ID in the specified `font`.
///
/// According to the OpenType specification, glyph names are limited to 63
/// characters and can only contain (a subset of) ASCII.
extern fn hb_font_get_glyph_name(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_name: *[*]u8, p_size: c_uint) harfbuzz.bool_t;
pub const fontGetGlyphName = hb_font_get_glyph_name;

/// Fetches the (X,Y) coordinates of the origin for a glyph in
/// the specified font.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_get_glyph_origin_for_direction(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) void;
pub const fontGetGlyphOriginForDirection = hb_font_get_glyph_origin_for_direction;

/// Fetches the glyph shape that corresponds to a glyph in the specified `font`.
/// The shape is returned by way of calls to the callbacks of the `dfuncs`
/// objects, with `draw_data` passed to them.
extern fn hb_font_get_glyph_shape(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque) void;
pub const fontGetGlyphShape = hb_font_get_glyph_shape;

/// Fetches the advance for a glyph ID in the specified font,
/// for vertical text segments.
extern fn hb_font_get_glyph_v_advance(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const fontGetGlyphVAdvance = hb_font_get_glyph_v_advance;

/// Fetches the advances for a sequence of glyph IDs in the specified
/// font, for vertical text segments.
extern fn hb_font_get_glyph_v_advances(p_font: *harfbuzz.font_t, p_count: c_uint, p_first_glyph: *const harfbuzz.codepoint_t, p_glyph_stride: c_uint, p_first_advance: *harfbuzz.position_t, p_advance_stride: c_uint) void;
pub const fontGetGlyphVAdvances = hb_font_get_glyph_v_advances;

/// Fetches the kerning-adjustment value for a glyph-pair in
/// the specified font, for vertical text segments.
///
/// <note>It handles legacy kerning only (as returned by the corresponding
/// `harfbuzz.font_funcs_t` function).</note>
extern fn hb_font_get_glyph_v_kerning(p_font: *harfbuzz.font_t, p_top_glyph: harfbuzz.codepoint_t, p_bottom_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const fontGetGlyphVKerning = hb_font_get_glyph_v_kerning;

/// Fetches the (X,Y) coordinates of the origin for a glyph ID
/// in the specified font, for vertical text segments.
extern fn hb_font_get_glyph_v_origin(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) harfbuzz.bool_t;
pub const fontGetGlyphVOrigin = hb_font_get_glyph_v_origin;

/// Fetches the extents for a specified font, for horizontal
/// text segments.
extern fn hb_font_get_h_extents(p_font: *harfbuzz.font_t, p_extents: *harfbuzz.font_extents_t) harfbuzz.bool_t;
pub const fontGetHExtents = hb_font_get_h_extents;

/// Fetches the nominal glyph ID for a Unicode code point in the
/// specified font.
///
/// This version of the function should not be used to fetch glyph IDs
/// for code points modified by variation selectors. For variation-selector
/// support, user `harfbuzz.fontGetVariationGlyph` or use `harfbuzz.fontGetGlyph`.
extern fn hb_font_get_nominal_glyph(p_font: *harfbuzz.font_t, p_unicode: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const fontGetNominalGlyph = hb_font_get_nominal_glyph;

/// Fetches the nominal glyph IDs for a sequence of Unicode code points. Glyph
/// IDs must be returned in a `harfbuzz.codepoint_t` output parameter. Stops at the
/// first unsupported glyph ID.
extern fn hb_font_get_nominal_glyphs(p_font: *harfbuzz.font_t, p_count: c_uint, p_first_unicode: *const harfbuzz.codepoint_t, p_unicode_stride: c_uint, p_first_glyph: *harfbuzz.codepoint_t, p_glyph_stride: c_uint) c_uint;
pub const fontGetNominalGlyphs = hb_font_get_nominal_glyphs;

/// Fetches the parent font of `font`.
extern fn hb_font_get_parent(p_font: *harfbuzz.font_t) *harfbuzz.font_t;
pub const fontGetParent = hb_font_get_parent;

/// Fetches the horizontal and vertical points-per-em (ppem) of a font.
extern fn hb_font_get_ppem(p_font: *harfbuzz.font_t, p_x_ppem: *c_uint, p_y_ppem: *c_uint) void;
pub const fontGetPpem = hb_font_get_ppem;

/// Fetches the "point size" of a font. Used in CoreText to
/// implement optical sizing.
extern fn hb_font_get_ptem(p_font: *harfbuzz.font_t) f32;
pub const fontGetPtem = hb_font_get_ptem;

/// Fetches the horizontal and vertical scale of a font.
extern fn hb_font_get_scale(p_font: *harfbuzz.font_t, p_x_scale: *c_int, p_y_scale: *c_int) void;
pub const fontGetScale = hb_font_get_scale;

/// Returns the internal serial number of the font. The serial
/// number is increased every time a setting on the font is
/// changed, using a setter function.
extern fn hb_font_get_serial(p_font: *harfbuzz.font_t) c_uint;
pub const fontGetSerial = hb_font_get_serial;

/// Fetches the "synthetic boldness" parameters of a font.
extern fn hb_font_get_synthetic_bold(p_font: *harfbuzz.font_t, p_x_embolden: *f32, p_y_embolden: *f32, p_in_place: *harfbuzz.bool_t) void;
pub const fontGetSyntheticBold = hb_font_get_synthetic_bold;

/// Fetches the "synthetic slant" of a font.
extern fn hb_font_get_synthetic_slant(p_font: *harfbuzz.font_t) f32;
pub const fontGetSyntheticSlant = hb_font_get_synthetic_slant;

/// Fetches the user-data object associated with the specified key,
/// attached to the specified font object.
extern fn hb_font_get_user_data(p_font: *const harfbuzz.font_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const fontGetUserData = hb_font_get_user_data;

/// Fetches the extents for a specified font, for vertical
/// text segments.
extern fn hb_font_get_v_extents(p_font: *harfbuzz.font_t, p_extents: *harfbuzz.font_extents_t) harfbuzz.bool_t;
pub const fontGetVExtents = hb_font_get_v_extents;

/// Fetches the list of variation coordinates (in design-space units) currently
/// set on a font.
///
/// Note that this returned array may only contain values for some
/// (or none) of the axes; omitted axes effectively have their default
/// values.
///
/// Return value is valid as long as variation coordinates of the font
/// are not modified.
extern fn hb_font_get_var_coords_design(p_font: *harfbuzz.font_t, p_length: *c_uint) *const f32;
pub const fontGetVarCoordsDesign = hb_font_get_var_coords_design;

/// Fetches the list of normalized variation coordinates currently
/// set on a font.
///
/// Note that this returned array may only contain values for some
/// (or none) of the axes; omitted axes effectively have zero values.
///
/// Return value is valid as long as variation coordinates of the font
/// are not modified.
extern fn hb_font_get_var_coords_normalized(p_font: *harfbuzz.font_t, p_length: *c_uint) *const c_int;
pub const fontGetVarCoordsNormalized = hb_font_get_var_coords_normalized;

/// Returns the currently-set named-instance index of the font.
extern fn hb_font_get_var_named_instance(p_font: *harfbuzz.font_t) c_uint;
pub const fontGetVarNamedInstance = hb_font_get_var_named_instance;

/// Fetches the glyph ID for a Unicode code point when followed by
/// by the specified variation-selector code point, in the specified
/// font.
extern fn hb_font_get_variation_glyph(p_font: *harfbuzz.font_t, p_unicode: harfbuzz.codepoint_t, p_variation_selector: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const fontGetVariationGlyph = hb_font_get_variation_glyph;

/// Fetches the glyph ID from `font` that matches the specified string.
/// Strings of the format `gidDDD` or `uniUUUU` are parsed automatically.
///
/// <note>Note: `len` == -1 means the string is null-terminated.</note>
extern fn hb_font_glyph_from_string(p_font: *harfbuzz.font_t, p_s: [*]const u8, p_len: c_int, p_glyph: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const fontGlyphFromString = hb_font_glyph_from_string;

/// Fetches the name of the specified glyph ID in `font` and returns
/// it in string `s`.
///
/// If the glyph ID has no name in `font`, a string of the form `gidDDD` is
/// generated, with `DDD` being the glyph ID.
///
/// According to the OpenType specification, glyph names are limited to 63
/// characters and can only contain (a subset of) ASCII.
extern fn hb_font_glyph_to_string(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_s: *[*]u8, p_size: c_uint) void;
pub const fontGlyphToString = hb_font_glyph_to_string;

/// Tests whether a font object is immutable.
extern fn hb_font_is_immutable(p_font: *harfbuzz.font_t) harfbuzz.bool_t;
pub const fontIsImmutable = hb_font_is_immutable;

/// Tests whether a font is synthetic. A synthetic font is one
/// that has either synthetic slant or synthetic bold set on it.
extern fn hb_font_is_synthetic(p_font: *harfbuzz.font_t) harfbuzz.bool_t;
pub const fontIsSynthetic = hb_font_is_synthetic;

/// Retrieves the list of font functions supported by HarfBuzz.
extern fn hb_font_list_funcs() [*][*:0]const u8;
pub const fontListFuncs = hb_font_list_funcs;

/// Makes `font` immutable.
extern fn hb_font_make_immutable(p_font: *harfbuzz.font_t) void;
pub const fontMakeImmutable = hb_font_make_immutable;

/// Paints the glyph. This function is similar to
/// `harfbuzz.fontPaintGlyphOrFail`, but if painting a color glyph
/// failed, it will fall back to painting an outline monochrome
/// glyph.
///
/// The painting instructions are returned by way of calls to
/// the callbacks of the `funcs` object, with `paint_data` passed
/// to them.
///
/// If the font has color palettes (see `harfbuzz.otColorHasPalettes`),
/// then `palette_index` selects the palette to use. If the font only
/// has one palette, this will be 0.
extern fn hb_font_paint_glyph(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_pfuncs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_palette_index: c_uint, p_foreground: harfbuzz.color_t) void;
pub const fontPaintGlyph = hb_font_paint_glyph;

/// Paints a color glyph.
///
/// This function is similar to, but lower-level than,
/// `harfbuzz.fontPaintGlyph`. It is suitable for clients that
/// need more control.  If there are no color glyphs available,
/// it will return `false`. The client can then fall back to
/// `harfbuzz.fontDrawGlyphOrFail` for the monochrome outline glyph.
///
/// The painting instructions are returned by way of calls to
/// the callbacks of the `funcs` object, with `paint_data` passed
/// to them.
///
/// If the font has color palettes (see `harfbuzz.otColorHasPalettes`),
/// then `palette_index` selects the palette to use. If the font only
/// has one palette, this will be 0.
extern fn hb_font_paint_glyph_or_fail(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_pfuncs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_palette_index: c_uint, p_foreground: harfbuzz.color_t) harfbuzz.bool_t;
pub const fontPaintGlyphOrFail = hb_font_paint_glyph_or_fail;

/// Increases the reference count on the given font object.
extern fn hb_font_reference(p_font: *harfbuzz.font_t) *harfbuzz.font_t;
pub const fontReference = hb_font_reference;

/// Sets `face` as the font-face value of `font`.
extern fn hb_font_set_face(p_font: *harfbuzz.font_t, p_face: *harfbuzz.face_t) void;
pub const fontSetFace = hb_font_set_face;

/// Replaces the font-functions structure attached to a font, updating
/// the font's user-data with `font`-data and the `destroy` callback.
extern fn hb_font_set_funcs(p_font: *harfbuzz.font_t, p_klass: *harfbuzz.font_funcs_t, p_font_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontSetFuncs = hb_font_set_funcs;

/// Replaces the user data attached to a font, updating the font's
/// `destroy` callback.
extern fn hb_font_set_funcs_data(p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const fontSetFuncsData = hb_font_set_funcs_data;

/// Sets the font-functions structure to use for a font, based on the
/// specified name.
///
/// If `name` is `NULL` or the empty string, the default (first) functioning font-functions
/// are used.  This default can be changed by setting the `HB_FONT_FUNCS` environment
/// variable to the name of the desired font-functions.
extern fn hb_font_set_funcs_using(p_font: *harfbuzz.font_t, p_name: [*:0]const u8) harfbuzz.bool_t;
pub const fontSetFuncsUsing = hb_font_set_funcs_using;

/// Sets the parent font of `font`.
extern fn hb_font_set_parent(p_font: *harfbuzz.font_t, p_parent: *harfbuzz.font_t) void;
pub const fontSetParent = hb_font_set_parent;

/// Sets the horizontal and vertical pixels-per-em (PPEM) of a font.
///
/// These values are used for pixel-size-specific adjustment to
/// shaping and draw results, though for the most part they are
/// unused and can be left unset.
extern fn hb_font_set_ppem(p_font: *harfbuzz.font_t, p_x_ppem: c_uint, p_y_ppem: c_uint) void;
pub const fontSetPpem = hb_font_set_ppem;

/// Sets the "point size" of a font. Set to zero to unset.
/// Used in CoreText to implement optical sizing.
///
/// <note>Note: There are 72 points in an inch.</note>
extern fn hb_font_set_ptem(p_font: *harfbuzz.font_t, p_ptem: f32) void;
pub const fontSetPtem = hb_font_set_ptem;

/// Sets the horizontal and vertical scale of a font.
///
/// The font scale is a number related to, but not the same as,
/// font size. Typically the client establishes a scale factor
/// to be used between the two. For example, 64, or 256, which
/// would be the fractional-precision part of the font scale.
/// This is necessary because `harfbuzz.position_t` values are integer
/// types and you need to leave room for fractional values
/// in there.
///
/// For example, to set the font size to 20, with 64
/// levels of fractional precision you would call
/// `hb_font_set_scale(font, 20 * 64, 20 * 64)`.
///
/// In the example above, even what font size 20 means is up to
/// you. It might be 20 pixels, or 20 points, or 20 millimeters.
/// HarfBuzz does not care about that.  You can set the point
/// size of the font using `harfbuzz.fontSetPtem`, and the pixel
/// size using `harfbuzz.fontSetPpem`.
///
/// The choice of scale is yours but needs to be consistent between
/// what you set here, and what you expect out of `harfbuzz.position_t`
/// as well has draw / paint API output values.
///
/// Fonts default to a scale equal to the UPEM value of their face.
/// A font with this setting is sometimes called an "unscaled" font.
extern fn hb_font_set_scale(p_font: *harfbuzz.font_t, p_x_scale: c_int, p_y_scale: c_int) void;
pub const fontSetScale = hb_font_set_scale;

/// Sets the "synthetic boldness" of a font.
///
/// Positive values for `x_embolden` / `y_embolden` make a font
/// bolder, negative values thinner. Typical values are in the
/// 0.01 to 0.05 range. The default value is zero.
///
/// Synthetic boldness is applied by offsetting the contour
/// points of the glyph shape.
///
/// Synthetic boldness is applied when rendering a glyph via
/// `harfbuzz.fontDrawGlyphOrFail`.
///
/// If `in_place` is `false`, then glyph advance-widths are also
/// adjusted, otherwise they are not.  The in-place mode is
/// useful for simulating [font grading](https://fonts.google.com/knowledge/glossary/grade).
extern fn hb_font_set_synthetic_bold(p_font: *harfbuzz.font_t, p_x_embolden: f32, p_y_embolden: f32, p_in_place: harfbuzz.bool_t) void;
pub const fontSetSyntheticBold = hb_font_set_synthetic_bold;

/// Sets the "synthetic slant" of a font.  By default is zero.
/// Synthetic slant is the graphical skew applied to the font
/// at rendering time.
///
/// HarfBuzz needs to know this value to adjust shaping results,
/// metrics, and style values to match the slanted rendering.
///
/// <note>Note: The glyph shape fetched via the `harfbuzz.fontDrawGlyphOrFail`
/// function is slanted to reflect this value as well.</note>
///
/// <note>Note: The slant value is a ratio.  For example, a
/// 20% slant would be represented as a 0.2 value.</note>
extern fn hb_font_set_synthetic_slant(p_font: *harfbuzz.font_t, p_slant: f32) void;
pub const fontSetSyntheticSlant = hb_font_set_synthetic_slant;

/// Attaches a user-data key/data pair to the specified font object.
extern fn hb_font_set_user_data(p_font: *harfbuzz.font_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const fontSetUserData = hb_font_set_user_data;

/// Applies a list of variation coordinates (in design-space units)
/// to a font.
///
/// Note that this overrides all existing variations set on `font`.
/// Axes not included in `coords` will be effectively set to their
/// default values.
extern fn hb_font_set_var_coords_design(p_font: *harfbuzz.font_t, p_coords: [*]const f32, p_coords_length: c_uint) void;
pub const fontSetVarCoordsDesign = hb_font_set_var_coords_design;

/// Applies a list of variation coordinates (in normalized units)
/// to a font.
///
/// Note that this overrides all existing variations set on `font`.
/// Axes not included in `coords` will be effectively set to their
/// default values.
///
/// <note>Note: Coordinates should be normalized to 2.14.</note>
extern fn hb_font_set_var_coords_normalized(p_font: *harfbuzz.font_t, p_coords: [*]const c_int, p_coords_length: c_uint) void;
pub const fontSetVarCoordsNormalized = hb_font_set_var_coords_normalized;

/// Sets design coords of a font from a named-instance index.
extern fn hb_font_set_var_named_instance(p_font: *harfbuzz.font_t, p_instance_index: c_uint) void;
pub const fontSetVarNamedInstance = hb_font_set_var_named_instance;

/// Change the value of one variation axis on the font.
///
/// Note: This function is expensive to be called repeatedly.
///   If you want to set multiple variation axes at the same time,
///   use `harfbuzz.fontSetVariations` instead.
extern fn hb_font_set_variation(p_font: *harfbuzz.font_t, p_tag: harfbuzz.tag_t, p_value: f32) void;
pub const fontSetVariation = hb_font_set_variation;

/// Applies a list of font-variation settings to a font.
///
/// Note that this overrides all existing variations set on `font`.
/// Axes not included in `variations` will be effectively set to their
/// default values.
extern fn hb_font_set_variations(p_font: *harfbuzz.font_t, p_variations: [*]const harfbuzz.variation_t, p_variations_length: c_uint) void;
pub const fontSetVariations = hb_font_set_variations;

/// Subtracts the origin coordinates from an (X,Y) point coordinate,
/// in the specified glyph ID in the specified font.
///
/// Calls the appropriate direction-specific variant (horizontal
/// or vertical) depending on the value of `direction`.
extern fn hb_font_subtract_glyph_origin_for_direction(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t) void;
pub const fontSubtractGlyphOriginForDirection = hb_font_subtract_glyph_origin_for_direction;

/// Frees the memory pointed to by `ptr`, using the allocator set at
/// compile-time. Typically just `free`.
extern fn hb_free(p_ptr: ?*anyopaque) void;
pub const free = hb_free;

/// Creates an `harfbuzz.face_t` face object from the specified FT_Face.
///
/// Note that this is using the FT_Face object just to get at the underlying
/// font data, and fonts created from the returned `harfbuzz.face_t` will use the native
/// HarfBuzz font implementation, unless you call `harfbuzz.ftFontSetFuncs` on them.
///
/// This variant of the function does not provide any life-cycle management.
///
/// Most client programs should use `harfbuzz.ftFaceCreateReferenced`
/// (or, perhaps, `harfbuzz.ftFaceCreateCached`) instead.
///
/// If you know you have valid reasons not to use `harfbuzz.ftFaceCreateReferenced`,
/// then it is the client program's responsibility to destroy `ft_face`
/// after the `harfbuzz.face_t` face object has been destroyed.
extern fn hb_ft_face_create(p_ft_face: freetype2.Face, p_destroy: ?harfbuzz.destroy_func_t) *harfbuzz.face_t;
pub const ftFaceCreate = hb_ft_face_create;

/// Creates an `harfbuzz.face_t` face object from the specified FT_Face.
///
/// Note that this is using the FT_Face object just to get at the underlying
/// font data, and fonts created from the returned `harfbuzz.face_t` will use the native
/// HarfBuzz font implementation, unless you call `harfbuzz.ftFontSetFuncs` on them.
///
/// This variant of the function caches the newly created `harfbuzz.face_t`
/// face object, using the `generic` pointer of `ft_face`. Subsequent function
/// calls that are passed the same `ft_face` parameter will have the same
/// `harfbuzz.face_t` returned to them, and that `harfbuzz.face_t` will be correctly
/// reference counted.
///
/// However, client programs are still responsible for destroying
/// `ft_face` after the last `harfbuzz.face_t` face object has been destroyed.
extern fn hb_ft_face_create_cached(p_ft_face: freetype2.Face) *harfbuzz.face_t;
pub const ftFaceCreateCached = hb_ft_face_create_cached;

/// Creates an `harfbuzz.face_t` face object from the specified
/// font blob and face index.
///
/// This is similar in functionality to `hb_face_create_from_blob_or_fail`,
/// but uses the FreeType library for loading the font blob. This can
/// be useful, for example, to load WOFF and WOFF2 font data.
extern fn hb_ft_face_create_from_blob_or_fail(p_blob: *harfbuzz.blob_t, p_index: c_uint) *harfbuzz.face_t;
pub const ftFaceCreateFromBlobOrFail = hb_ft_face_create_from_blob_or_fail;

/// Creates an `harfbuzz.face_t` face object from the specified
/// font file and face index.
///
/// This is similar in functionality to `harfbuzz.faceCreateFromFileOrFail`,
/// but uses the FreeType library for loading the font file. This can
/// be useful, for example, to load WOFF and WOFF2 font data.
extern fn hb_ft_face_create_from_file_or_fail(p_file_name: [*:0]const u8, p_index: c_uint) *harfbuzz.face_t;
pub const ftFaceCreateFromFileOrFail = hb_ft_face_create_from_file_or_fail;

/// Creates an `harfbuzz.face_t` face object from the specified FT_Face.
///
/// Note that this is using the FT_Face object just to get at the underlying
/// font data, and fonts created from the returned `harfbuzz.face_t` will use the native
/// HarfBuzz font implementation, unless you call `harfbuzz.ftFontSetFuncs` on them.
///
/// This is the preferred variant of the hb_ft_face_create*
/// function family, because it calls `FT_Reference_Face` on `ft_face`,
/// ensuring that `ft_face` remains alive as long as the resulting
/// `harfbuzz.face_t` face object remains alive. Also calls `FT_Done_Face`
/// when the `harfbuzz.face_t` face object is destroyed.
///
/// Use this version unless you know you have good reasons not to.
extern fn hb_ft_face_create_referenced(p_ft_face: freetype2.Face) *harfbuzz.face_t;
pub const ftFaceCreateReferenced = hb_ft_face_create_referenced;

/// Refreshes the state of `font` when the underlying FT_Face has changed.
/// This function should be called after changing the size or
/// variation-axis settings on the FT_Face.
extern fn hb_ft_font_changed(p_font: *harfbuzz.font_t) void;
pub const ftFontChanged = hb_ft_font_changed;

/// Creates an `harfbuzz.font_t` font object from the specified FT_Face.
///
/// <note>Note: You must set the face size on `ft_face` before calling
/// `harfbuzz.ftFontCreate` on it. HarfBuzz assumes size is always set and will
/// access `size` member of FT_Face unconditionally.</note>
///
/// This variant of the function does not provide any life-cycle management.
///
/// Most client programs should use `harfbuzz.ftFontCreateReferenced`
/// instead.
///
/// If you know you have valid reasons not to use `harfbuzz.ftFontCreateReferenced`,
/// then it is the client program's responsibility to destroy `ft_face`
/// only after the `harfbuzz.font_t` font object has been destroyed.
///
/// HarfBuzz will use the `destroy` callback on the `harfbuzz.font_t` font object
/// if it is supplied when you use this function. However, even if `destroy`
/// is provided, it is the client program's responsibility to destroy `ft_face`,
/// and it is the client program's responsibility to ensure that `ft_face` is
/// destroyed only after the `harfbuzz.font_t` font object has been destroyed.
extern fn hb_ft_font_create(p_ft_face: freetype2.Face, p_destroy: ?harfbuzz.destroy_func_t) *harfbuzz.font_t;
pub const ftFontCreate = hb_ft_font_create;

/// Creates an `harfbuzz.font_t` font object from the specified FT_Face.
///
/// <note>Note: You must set the face size on `ft_face` before calling
/// `harfbuzz.ftFontCreateReferenced` on it. HarfBuzz assumes size is always set
/// and will access `size` member of FT_Face unconditionally.</note>
///
/// This is the preferred variant of the hb_ft_font_create*
/// function family, because it calls `FT_Reference_Face` on `ft_face`,
/// ensuring that `ft_face` remains alive as long as the resulting
/// `harfbuzz.font_t` font object remains alive.
///
/// Use this version unless you know you have good reasons not to.
extern fn hb_ft_font_create_referenced(p_ft_face: freetype2.Face) *harfbuzz.font_t;
pub const ftFontCreateReferenced = hb_ft_font_create_referenced;

/// Fetches the FT_Face associated with the specified `harfbuzz.font_t`
/// font object.
///
/// This function works with `harfbuzz.font_t` objects created by
/// `harfbuzz.ftFontCreate` or `harfbuzz.ftFontCreateReferenced`.
extern fn hb_ft_font_get_face(p_font: *harfbuzz.font_t) ?freetype2.Face;
pub const ftFontGetFace = hb_ft_font_get_face;

/// Fetches the FT_Face associated with the specified `harfbuzz.font_t`
/// font object.
///
/// This function works with `harfbuzz.font_t` objects created by
/// `harfbuzz.ftFontCreate` or `harfbuzz.ftFontCreateReferenced`.
extern fn hb_ft_font_get_ft_face(p_font: *harfbuzz.font_t) ?freetype2.Face;
pub const ftFontGetFtFace = hb_ft_font_get_ft_face;

/// Fetches the FT_Load_Glyph load flags of the specified `harfbuzz.font_t`.
///
/// For more information, see
/// <https://freetype.org/freetype2/docs/reference/ft2-glyph_retrieval.html`ft_load_xxx`>
///
/// This function works with `harfbuzz.font_t` objects created by
/// `harfbuzz.ftFontCreate` or `harfbuzz.ftFontCreateReferenced`.
extern fn hb_ft_font_get_load_flags(p_font: *harfbuzz.font_t) c_int;
pub const ftFontGetLoadFlags = hb_ft_font_get_load_flags;

/// Gets the FT_Face associated with `font`.
///
/// This face will be kept around and access to the FT_Face object
/// from other HarfBuzz API wil be blocked until you call `harfbuzz.ftFontUnlockFace`.
///
/// This function works with `harfbuzz.font_t` objects created by
/// `harfbuzz.ftFontCreate` or `harfbuzz.ftFontCreateReferenced`.
extern fn hb_ft_font_lock_face(p_font: *harfbuzz.font_t) ?freetype2.Face;
pub const ftFontLockFace = hb_ft_font_lock_face;

/// Configures the font-functions structure of the specified
/// `harfbuzz.font_t` font object to use FreeType font functions.
///
/// In particular, you can use this function to configure an
/// existing `harfbuzz.face_t` face object for use with FreeType font
/// functions even if that `harfbuzz.face_t` face object was initially
/// created with `harfbuzz.faceCreate`, and therefore was not
/// initially configured to use FreeType font functions.
///
/// An `harfbuzz.font_t` object created with `harfbuzz.ftFontCreate`
/// is preconfigured for FreeType font functions and does not
/// require this function to be used.
///
/// Note that if you modify the underlying `harfbuzz.font_t` after
/// calling this function, you need to call `harfbuzz.ftHbFontChanged`
/// to update the underlying FT_Face.
///
/// <note>Note: Internally, this function creates an FT_Face.
/// </note>
extern fn hb_ft_font_set_funcs(p_font: *harfbuzz.font_t) void;
pub const ftFontSetFuncs = hb_ft_font_set_funcs;

/// Sets the FT_Load_Glyph load flags for the specified `harfbuzz.font_t`.
///
/// For more information, see
/// <https://freetype.org/freetype2/docs/reference/ft2-glyph_retrieval.html`ft_load_xxx`>
///
/// This function works with `harfbuzz.font_t` objects created by
/// `harfbuzz.ftFontCreate` or `harfbuzz.ftFontCreateReferenced`.
extern fn hb_ft_font_set_load_flags(p_font: *harfbuzz.font_t, p_load_flags: c_int) void;
pub const ftFontSetLoadFlags = hb_ft_font_set_load_flags;

/// Releases an FT_Face previously obtained with `harfbuzz.ftFontLockFace`.
extern fn hb_ft_font_unlock_face(p_font: *harfbuzz.font_t) void;
pub const ftFontUnlockFace = hb_ft_font_unlock_face;

/// Refreshes the state of the underlying FT_Face of `font` when the hb_font_t
/// `font` has changed.
/// This function should be called after changing the size or
/// variation-axis settings on the `font`.
/// This call is fast if nothing has changed on `font`.
///
/// Note that as of version 11.0.0, calling this function is not necessary,
/// as HarfBuzz will automatically detect changes to the font and update
/// the underlying FT_Face as needed.
extern fn hb_ft_hb_font_changed(p_font: *harfbuzz.font_t) harfbuzz.bool_t;
pub const ftHbFontChanged = hb_ft_hb_font_changed;

/// Creates an `harfbuzz.blob_t` blob from the specified
/// GBytes data structure.
extern fn hb_glib_blob_create(p_gbytes: *glib.Bytes) *harfbuzz.blob_t;
pub const glibBlobCreate = hb_glib_blob_create;

/// Fetches a Unicode-functions structure that is populated
/// with the appropriate GLib function for each method.
extern fn hb_glib_get_unicode_funcs() *harfbuzz.unicode_funcs_t;
pub const glibGetUnicodeFuncs = hb_glib_get_unicode_funcs;

/// Fetches the GUnicodeScript identifier that corresponds to the
/// specified `harfbuzz.script_t` script.
extern fn hb_glib_script_from_script(p_script: harfbuzz.script_t) glib.UnicodeScript;
pub const glibScriptFromScript = hb_glib_script_from_script;

/// Fetches the `harfbuzz.script_t` script that corresponds to the
/// specified GUnicodeScript identifier.
extern fn hb_glib_script_to_script(p_script: glib.UnicodeScript) harfbuzz.script_t;
pub const glibScriptToScript = hb_glib_script_to_script;

/// Returns glyph flags encoded within a `harfbuzz.glyph_info_t`.
extern fn hb_glyph_info_get_glyph_flags(p_info: *const harfbuzz.glyph_info_t) harfbuzz.glyph_flags_t;
pub const glyphInfoGetGlyphFlags = hb_glyph_info_get_glyph_flags;

/// Converts `str` representing a BCP 47 language tag to the corresponding
/// `harfbuzz.language_t`.
extern fn hb_language_from_string(p_str: [*]const u8, p_len: c_int) harfbuzz.language_t;
pub const languageFromString = hb_language_from_string;

/// Fetch the default language from current locale.
///
/// <note>Note that the first time this function is called, it calls
/// "setlocale (LC_CTYPE, nullptr)" to fetch current locale.  The underlying
/// setlocale function is, in many implementations, NOT threadsafe.  To avoid
/// problems, call this function once before multiple threads can call it.
/// This function is only used from `harfbuzz.bufferGuessSegmentProperties` by
/// HarfBuzz itself.</note>
extern fn hb_language_get_default() harfbuzz.language_t;
pub const languageGetDefault = hb_language_get_default;

/// Check whether a second language tag is the same or a more
/// specific version of the provided language tag.  For example,
/// "fa_IR.utf8" is a more specific tag for "fa" or for "fa_IR".
extern fn hb_language_matches(p_language: harfbuzz.language_t, p_specific: harfbuzz.language_t) harfbuzz.bool_t;
pub const languageMatches = hb_language_matches;

/// Converts an `harfbuzz.language_t` to a string.
extern fn hb_language_to_string(p_language: harfbuzz.language_t) [*:0]const u8;
pub const languageToString = hb_language_to_string;

/// Allocates `size` bytes of memory, using the allocator set at
/// compile-time. Typically just `malloc`.
extern fn hb_malloc(p_size: usize) ?*anyopaque;
pub const malloc = hb_malloc;

/// Tests whether memory allocation for a set was successful.
extern fn hb_map_allocation_successful(p_map: *const harfbuzz.map_t) harfbuzz.bool_t;
pub const mapAllocationSuccessful = hb_map_allocation_successful;

/// Clears out the contents of `map`.
extern fn hb_map_clear(p_map: *harfbuzz.map_t) void;
pub const mapClear = hb_map_clear;

/// Allocate a copy of `map`.
extern fn hb_map_copy(p_map: *const harfbuzz.map_t) *harfbuzz.map_t;
pub const mapCopy = hb_map_copy;

/// Creates a new, initially empty map.
extern fn hb_map_create() *harfbuzz.map_t;
pub const mapCreate = hb_map_create;

/// Removes `key` and its stored value from `map`.
extern fn hb_map_del(p_map: *harfbuzz.map_t, p_key: harfbuzz.codepoint_t) void;
pub const mapDel = hb_map_del;

/// Decreases the reference count on a map. When
/// the reference count reaches zero, the map is
/// destroyed, freeing all memory.
extern fn hb_map_destroy(p_map: *harfbuzz.map_t) void;
pub const mapDestroy = hb_map_destroy;

/// Fetches the value stored for `key` in `map`.
extern fn hb_map_get(p_map: *const harfbuzz.map_t, p_key: harfbuzz.codepoint_t) harfbuzz.codepoint_t;
pub const mapGet = hb_map_get;

/// Fetches the singleton empty `harfbuzz.map_t`.
extern fn hb_map_get_empty() *harfbuzz.map_t;
pub const mapGetEmpty = hb_map_get_empty;

/// Returns the number of key-value pairs in the map.
extern fn hb_map_get_population(p_map: *const harfbuzz.map_t) c_uint;
pub const mapGetPopulation = hb_map_get_population;

/// Fetches the user data associated with the specified key,
/// attached to the specified map.
extern fn hb_map_get_user_data(p_map: *const harfbuzz.map_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const mapGetUserData = hb_map_get_user_data;

/// Tests whether `key` is an element of `map`.
extern fn hb_map_has(p_map: *const harfbuzz.map_t, p_key: harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const mapHas = hb_map_has;

/// Creates a hash representing `map`.
extern fn hb_map_hash(p_map: *const harfbuzz.map_t) c_uint;
pub const mapHash = hb_map_hash;

/// Tests whether `map` is empty (contains no elements).
extern fn hb_map_is_empty(p_map: *const harfbuzz.map_t) harfbuzz.bool_t;
pub const mapIsEmpty = hb_map_is_empty;

/// Tests whether `map` and `other` are equal (contain the same
/// elements).
extern fn hb_map_is_equal(p_map: *const harfbuzz.map_t, p_other: *const harfbuzz.map_t) harfbuzz.bool_t;
pub const mapIsEqual = hb_map_is_equal;

/// Add the keys of `map` to `keys`.
extern fn hb_map_keys(p_map: *const harfbuzz.map_t, p_keys: *harfbuzz.set_t) void;
pub const mapKeys = hb_map_keys;

/// Fetches the next key/value pair in `map`.
///
/// Set `idx` to -1 to get started.
///
/// If the map is modified during iteration, the behavior is undefined.
///
/// The order in which the key/values are returned is undefined.
extern fn hb_map_next(p_map: *const harfbuzz.map_t, p_idx: *c_int, p_key: *harfbuzz.codepoint_t, p_value: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const mapNext = hb_map_next;

/// Increases the reference count on a map.
extern fn hb_map_reference(p_map: *harfbuzz.map_t) *harfbuzz.map_t;
pub const mapReference = hb_map_reference;

/// Stores `key`:`value` in the map.
extern fn hb_map_set(p_map: *harfbuzz.map_t, p_key: harfbuzz.codepoint_t, p_value: harfbuzz.codepoint_t) void;
pub const mapSet = hb_map_set;

/// Attaches a user-data key/data pair to the specified map.
extern fn hb_map_set_user_data(p_map: *harfbuzz.map_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const mapSetUserData = hb_map_set_user_data;

/// Add the contents of `other` to `map`.
extern fn hb_map_update(p_map: *harfbuzz.map_t, p_other: *const harfbuzz.map_t) void;
pub const mapUpdate = hb_map_update;

/// Add the values of `map` to `values`.
extern fn hb_map_values(p_map: *const harfbuzz.map_t, p_values: *harfbuzz.set_t) void;
pub const mapValues = hb_map_values;

/// Fetches a list of all color layers for the specified glyph index in the specified
/// face. The list returned will begin at the offset provided.
extern fn hb_ot_color_glyph_get_layers(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t, p_start_offset: c_uint, p_layer_count: ?*c_uint, p_layers: ?*[*]harfbuzz.ot_color_layer_t) c_uint;
pub const otColorGlyphGetLayers = hb_ot_color_glyph_get_layers;

/// Tests where a face includes COLRv1 paint
/// data for `glyph`.
extern fn hb_ot_color_glyph_has_paint(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const otColorGlyphHasPaint = hb_ot_color_glyph_has_paint;

/// Fetches the PNG image for a glyph. This function takes a font object, not a face object,
/// as input. To get an optimally sized PNG blob, the PPEM values must be set on the `font`
/// object. If PPEM is unset, the blob returned will be the largest PNG available.
///
/// If the glyph has no PNG image, the singleton empty blob is returned.
extern fn hb_ot_color_glyph_reference_png(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t) *harfbuzz.blob_t;
pub const otColorGlyphReferencePng = hb_ot_color_glyph_reference_png;

/// Fetches the SVG document for a glyph. The blob may be either plain text or gzip-encoded.
///
/// If the glyph has no SVG document, the singleton empty blob is returned.
extern fn hb_ot_color_glyph_reference_svg(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t) *harfbuzz.blob_t;
pub const otColorGlyphReferenceSvg = hb_ot_color_glyph_reference_svg;

/// Tests whether a face includes a `COLR` table
/// with data according to COLRv0.
extern fn hb_ot_color_has_layers(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otColorHasLayers = hb_ot_color_has_layers;

/// Tests where a face includes a `COLR` table
/// with data according to COLRv1.
extern fn hb_ot_color_has_paint(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otColorHasPaint = hb_ot_color_has_paint;

/// Tests whether a face includes a `CPAL` color-palette table.
extern fn hb_ot_color_has_palettes(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otColorHasPalettes = hb_ot_color_has_palettes;

/// Tests whether a face has PNG glyph images (either in `CBDT` or `sbix` tables).
extern fn hb_ot_color_has_png(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otColorHasPng = hb_ot_color_has_png;

/// Tests whether a face includes any `SVG` glyph images.
extern fn hb_ot_color_has_svg(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otColorHasSvg = hb_ot_color_has_svg;

/// Fetches the `name` table Name ID that provides display names for
/// the specified color in a face's `CPAL` color palette.
///
/// Display names can be generic (e.g., "Background") or specific
/// (e.g., "Eye color").
extern fn hb_ot_color_palette_color_get_name_id(p_face: *harfbuzz.face_t, p_color_index: c_uint) harfbuzz.ot_name_id_t;
pub const otColorPaletteColorGetNameId = hb_ot_color_palette_color_get_name_id;

/// Fetches a list of the colors in a color palette.
///
/// After calling this function, `colors` will be filled with the palette
/// colors. If `colors` is NULL, the function will just return the number
/// of total colors without storing any actual colors; this can be used
/// for allocating a buffer of suitable size before calling
/// `harfbuzz.otColorPaletteGetColors` a second time.
///
/// The RGBA values in the palette are unpremultiplied. See the
/// OpenType spec [CPAL](https://learn.microsoft.com/en-us/typography/opentype/spec/cpal)
/// section for details.
extern fn hb_ot_color_palette_get_colors(p_face: *harfbuzz.face_t, p_palette_index: c_uint, p_start_offset: c_uint, p_color_count: ?*c_uint, p_colors: ?*[*]harfbuzz.color_t) c_uint;
pub const otColorPaletteGetColors = hb_ot_color_palette_get_colors;

/// Fetches the number of color palettes in a face.
extern fn hb_ot_color_palette_get_count(p_face: *harfbuzz.face_t) c_uint;
pub const otColorPaletteGetCount = hb_ot_color_palette_get_count;

/// Fetches the flags defined for a color palette.
extern fn hb_ot_color_palette_get_flags(p_face: *harfbuzz.face_t, p_palette_index: c_uint) harfbuzz.ot_color_palette_flags_t;
pub const otColorPaletteGetFlags = hb_ot_color_palette_get_flags;

/// Fetches the `name` table Name ID that provides display names for
/// a `CPAL` color palette.
///
/// Palette display names can be generic (e.g., "Default") or provide
/// specific, themed names (e.g., "Spring", "Summer", "Fall", and "Winter").
extern fn hb_ot_color_palette_get_name_id(p_face: *harfbuzz.face_t, p_palette_index: c_uint) harfbuzz.ot_name_id_t;
pub const otColorPaletteGetNameId = hb_ot_color_palette_get_name_id;

/// Sets the font functions to use when working with `font` to
/// the HarfBuzz's native implementation. This is the default
/// for fonts newly created.
extern fn hb_ot_font_set_funcs(p_font: *harfbuzz.font_t) void;
pub const otFontSetFuncs = hb_ot_font_set_funcs;

/// Fetches a list of all feature indexes in the specified face's GSUB table
/// or GPOS table, underneath the specified scripts, languages, and features.
/// If no list of scripts is provided, all scripts will be queried. If no list
/// of languages is provided, all languages will be queried. If no list of
/// features is provided, all features will be queried.
extern fn hb_ot_layout_collect_features(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_scripts: ?[*]const harfbuzz.tag_t, p_languages: ?[*]const harfbuzz.tag_t, p_features: ?[*]const harfbuzz.tag_t, p_feature_indexes: *harfbuzz.set_t) void;
pub const otLayoutCollectFeatures = hb_ot_layout_collect_features;

/// Fetches the mapping from feature tags to feature indexes for
/// the specified script and language.
extern fn hb_ot_layout_collect_features_map(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_feature_map: *harfbuzz.map_t) void;
pub const otLayoutCollectFeaturesMap = hb_ot_layout_collect_features_map;

/// Fetches a list of all feature-lookup indexes in the specified face's GSUB
/// table or GPOS table, underneath the specified scripts, languages, and
/// features. If no list of scripts is provided, all scripts will be queried.
/// If no list of languages is provided, all languages will be queried. If no
/// list of features is provided, all features will be queried.
extern fn hb_ot_layout_collect_lookups(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_scripts: ?[*]const harfbuzz.tag_t, p_languages: ?[*]const harfbuzz.tag_t, p_features: ?[*]const harfbuzz.tag_t, p_lookup_indexes: *harfbuzz.set_t) void;
pub const otLayoutCollectLookups = hb_ot_layout_collect_lookups;

/// Fetches a list of the characters defined as having a variant under the specified
/// "Character Variant" ("cvXX") feature tag.
extern fn hb_ot_layout_feature_get_characters(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_feature_index: c_uint, p_start_offset: c_uint, p_char_count: ?*c_uint, p_characters: *[*]harfbuzz.codepoint_t) c_uint;
pub const otLayoutFeatureGetCharacters = hb_ot_layout_feature_get_characters;

/// Fetches a list of all lookups enumerated for the specified feature, in
/// the specified face's GSUB table or GPOS table. The list returned will
/// begin at the offset provided.
extern fn hb_ot_layout_feature_get_lookups(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_feature_index: c_uint, p_start_offset: c_uint, p_lookup_count: ?*c_uint, p_lookup_indexes: *[*]c_uint) c_uint;
pub const otLayoutFeatureGetLookups = hb_ot_layout_feature_get_lookups;

/// Fetches name indices from feature parameters for "Stylistic Set" ('ssXX') or
/// "Character Variant" ('cvXX') features.
extern fn hb_ot_layout_feature_get_name_ids(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_feature_index: c_uint, p_label_id: ?*harfbuzz.ot_name_id_t, p_tooltip_id: ?*harfbuzz.ot_name_id_t, p_sample_id: ?*harfbuzz.ot_name_id_t, p_num_named_parameters: ?*c_uint, p_first_param_id: ?*harfbuzz.ot_name_id_t) harfbuzz.bool_t;
pub const otLayoutFeatureGetNameIds = hb_ot_layout_feature_get_name_ids;

/// Fetches a list of all lookups enumerated for the specified feature, in
/// the specified face's GSUB table or GPOS table, enabled at the specified
/// variations index. The list returned will begin at the offset provided.
extern fn hb_ot_layout_feature_with_variations_get_lookups(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_feature_index: c_uint, p_variations_index: c_uint, p_start_offset: c_uint, p_lookup_count: ?*c_uint, p_lookup_indexes: *[*]c_uint) c_uint;
pub const otLayoutFeatureWithVariationsGetLookups = hb_ot_layout_feature_with_variations_get_lookups;

/// Fetches a list of all attachment points for the specified glyph in the GDEF
/// table of the face. The list returned will begin at the offset provided.
///
/// Useful if the client program wishes to cache the list.
extern fn hb_ot_layout_get_attach_points(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t, p_start_offset: c_uint, p_point_count: ?*c_uint, p_point_array: *[*]c_uint) c_uint;
pub const otLayoutGetAttachPoints = hb_ot_layout_get_attach_points;

/// Fetches a baseline value from the face.
extern fn hb_ot_layout_get_baseline(p_font: *harfbuzz.font_t, p_baseline_tag: harfbuzz.ot_layout_baseline_tag_t, p_direction: harfbuzz.direction_t, p_script_tag: harfbuzz.tag_t, p_language_tag: harfbuzz.tag_t, p_coord: ?*harfbuzz.position_t) harfbuzz.bool_t;
pub const otLayoutGetBaseline = hb_ot_layout_get_baseline;

/// Fetches a baseline value from the face.
///
/// This function is like `harfbuzz.otLayoutGetBaseline` but takes
/// `harfbuzz.script_t` and `harfbuzz.language_t` instead of OpenType `harfbuzz.tag_t`.
extern fn hb_ot_layout_get_baseline2(p_font: *harfbuzz.font_t, p_baseline_tag: harfbuzz.ot_layout_baseline_tag_t, p_direction: harfbuzz.direction_t, p_script: harfbuzz.script_t, p_language: ?harfbuzz.language_t, p_coord: ?*harfbuzz.position_t) harfbuzz.bool_t;
pub const otLayoutGetBaseline2 = hb_ot_layout_get_baseline2;

/// Fetches a baseline value from the face, and synthesizes
/// it if the font does not have it.
extern fn hb_ot_layout_get_baseline_with_fallback(p_font: *harfbuzz.font_t, p_baseline_tag: harfbuzz.ot_layout_baseline_tag_t, p_direction: harfbuzz.direction_t, p_script_tag: harfbuzz.tag_t, p_language_tag: harfbuzz.tag_t, p_coord: *harfbuzz.position_t) void;
pub const otLayoutGetBaselineWithFallback = hb_ot_layout_get_baseline_with_fallback;

/// Fetches a baseline value from the face, and synthesizes
/// it if the font does not have it.
///
/// This function is like `harfbuzz.otLayoutGetBaselineWithFallback` but takes
/// `harfbuzz.script_t` and `harfbuzz.language_t` instead of OpenType `harfbuzz.tag_t`.
extern fn hb_ot_layout_get_baseline_with_fallback2(p_font: *harfbuzz.font_t, p_baseline_tag: harfbuzz.ot_layout_baseline_tag_t, p_direction: harfbuzz.direction_t, p_script: harfbuzz.script_t, p_language: ?harfbuzz.language_t, p_coord: *harfbuzz.position_t) void;
pub const otLayoutGetBaselineWithFallback2 = hb_ot_layout_get_baseline_with_fallback2;

/// Fetches script/language-specific font extents.  These values are
/// looked up in the `BASE` table's `MinMax` records.
///
/// If no such extents are found, the default extents for the font are
/// fetched. As such, the return value of this function can for the
/// most part be ignored.  Note that the per-script/language extents
/// do not have a line-gap value, and the line-gap is set to zero in
/// that case.
extern fn hb_ot_layout_get_font_extents(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t, p_script_tag: harfbuzz.tag_t, p_language_tag: harfbuzz.tag_t, p_extents: ?*harfbuzz.font_extents_t) harfbuzz.bool_t;
pub const otLayoutGetFontExtents = hb_ot_layout_get_font_extents;

/// Fetches script/language-specific font extents.  These values are
/// looked up in the `BASE` table's `MinMax` records.
///
/// If no such extents are found, the default extents for the font are
/// fetched. As such, the return value of this function can for the
/// most part be ignored.  Note that the per-script/language extents
/// do not have a line-gap value, and the line-gap is set to zero in
/// that case.
///
/// This function is like `harfbuzz.otLayoutGetFontExtents` but takes
/// `harfbuzz.script_t` and `harfbuzz.language_t` instead of OpenType `harfbuzz.tag_t`.
extern fn hb_ot_layout_get_font_extents2(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t, p_script: harfbuzz.script_t, p_language: ?harfbuzz.language_t, p_extents: ?*harfbuzz.font_extents_t) harfbuzz.bool_t;
pub const otLayoutGetFontExtents2 = hb_ot_layout_get_font_extents2;

/// Fetches the GDEF class of the requested glyph in the specified face.
extern fn hb_ot_layout_get_glyph_class(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.ot_layout_glyph_class_t;
pub const otLayoutGetGlyphClass = hb_ot_layout_get_glyph_class;

/// Retrieves the set of all glyphs from the face that belong to the requested
/// glyph class in the face's GDEF table.
extern fn hb_ot_layout_get_glyphs_in_class(p_face: *harfbuzz.face_t, p_klass: harfbuzz.ot_layout_glyph_class_t, p_glyphs: *harfbuzz.set_t) void;
pub const otLayoutGetGlyphsInClass = hb_ot_layout_get_glyphs_in_class;

/// Fetches the dominant horizontal baseline tag used by `script`.
extern fn hb_ot_layout_get_horizontal_baseline_tag_for_script(p_script: harfbuzz.script_t) harfbuzz.ot_layout_baseline_tag_t;
pub const otLayoutGetHorizontalBaselineTagForScript = hb_ot_layout_get_horizontal_baseline_tag_for_script;

/// Fetches a list of the caret positions defined for a ligature glyph in the GDEF
/// table of the font. The list returned will begin at the offset provided.
///
/// Note that a ligature that is formed from n characters will have n-1
/// caret positions. The first character is not represented in the array,
/// since its caret position is the glyph position.
///
/// The positions returned by this function are 'unshaped', and will have to
/// be fixed up for kerning that may be applied to the ligature glyph.
extern fn hb_ot_layout_get_ligature_carets(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t, p_glyph: harfbuzz.codepoint_t, p_start_offset: c_uint, p_caret_count: ?*c_uint, p_caret_array: *[*]harfbuzz.position_t) c_uint;
pub const otLayoutGetLigatureCarets = hb_ot_layout_get_ligature_carets;

/// Fetches optical-size feature data (i.e., the `size` feature from GPOS). Note that
/// the subfamily_id and the subfamily name string (accessible via the subfamily_name_id)
/// as used here are defined as pertaining only to fonts within a font family that differ
/// specifically in their respective size ranges; other ways to differentiate fonts within
/// a subfamily are not covered by the `size` feature.
///
/// For more information on this distinction, see the [`size` feature documentation](
/// https://docs.microsoft.com/en-us/typography/opentype/spec/features_pt`tag`-size).
extern fn hb_ot_layout_get_size_params(p_face: *harfbuzz.face_t, p_design_size: *c_uint, p_subfamily_id: *c_uint, p_subfamily_name_id: *harfbuzz.ot_name_id_t, p_range_start: *c_uint, p_range_end: *c_uint) harfbuzz.bool_t;
pub const otLayoutGetSizeParams = hb_ot_layout_get_size_params;

/// Tests whether a face has any glyph classes defined in its GDEF table.
extern fn hb_ot_layout_has_glyph_classes(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otLayoutHasGlyphClasses = hb_ot_layout_has_glyph_classes;

/// Tests whether the specified face includes any GPOS positioning.
extern fn hb_ot_layout_has_positioning(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otLayoutHasPositioning = hb_ot_layout_has_positioning;

/// Tests whether the specified face includes any GSUB substitutions.
extern fn hb_ot_layout_has_substitution(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otLayoutHasSubstitution = hb_ot_layout_has_substitution;

/// Fetches the index of a given feature tag in the specified face's GSUB table
/// or GPOS table, underneath the specified script and language.
extern fn hb_ot_layout_language_find_feature(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_feature_tag: harfbuzz.tag_t, p_feature_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutLanguageFindFeature = hb_ot_layout_language_find_feature;

/// Fetches a list of all features in the specified face's GSUB table
/// or GPOS table, underneath the specified script and language. The list
/// returned will begin at the offset provided.
extern fn hb_ot_layout_language_get_feature_indexes(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_start_offset: c_uint, p_feature_count: ?*c_uint, p_feature_indexes: *[*]c_uint) c_uint;
pub const otLayoutLanguageGetFeatureIndexes = hb_ot_layout_language_get_feature_indexes;

/// Fetches a list of all features in the specified face's GSUB table
/// or GPOS table, underneath the specified script and language. The list
/// returned will begin at the offset provided.
extern fn hb_ot_layout_language_get_feature_tags(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_start_offset: c_uint, p_feature_count: ?*c_uint, p_feature_tags: *[*]harfbuzz.tag_t) c_uint;
pub const otLayoutLanguageGetFeatureTags = hb_ot_layout_language_get_feature_tags;

/// Fetches the tag of a requested feature index in the given face's GSUB or GPOS table,
/// underneath the specified script and language.
extern fn hb_ot_layout_language_get_required_feature(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_feature_index: *c_uint, p_feature_tag: *harfbuzz.tag_t) harfbuzz.bool_t;
pub const otLayoutLanguageGetRequiredFeature = hb_ot_layout_language_get_required_feature;

/// Fetches the index of a requested feature in the given face's GSUB or GPOS table,
/// underneath the specified script and language.
extern fn hb_ot_layout_language_get_required_feature_index(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_index: c_uint, p_feature_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutLanguageGetRequiredFeatureIndex = hb_ot_layout_language_get_required_feature_index;

/// Fetches a list of all glyphs affected by the specified lookup in the
/// specified face's GSUB table or GPOS table.
extern fn hb_ot_layout_lookup_collect_glyphs(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_lookup_index: c_uint, p_glyphs_before: *harfbuzz.set_t, p_glyphs_input: *harfbuzz.set_t, p_glyphs_after: *harfbuzz.set_t, p_glyphs_output: *harfbuzz.set_t) void;
pub const otLayoutLookupCollectGlyphs = hb_ot_layout_lookup_collect_glyphs;

/// Fetches alternates of a glyph from a given GSUB lookup index. Note that for one-to-one GSUB
/// glyph substitutions, this function fetches the substituted glyph.
extern fn hb_ot_layout_lookup_get_glyph_alternates(p_face: *harfbuzz.face_t, p_lookup_index: c_uint, p_glyph: harfbuzz.codepoint_t, p_start_offset: c_uint, p_alternate_count: ?*c_uint, p_alternate_glyphs: *[*]harfbuzz.codepoint_t) c_uint;
pub const otLayoutLookupGetGlyphAlternates = hb_ot_layout_lookup_get_glyph_alternates;

/// Fetches the optical bound of a glyph positioned at the margin of text.
/// The direction identifies which edge of the glyph to query.
extern fn hb_ot_layout_lookup_get_optical_bound(p_font: *harfbuzz.font_t, p_lookup_index: c_uint, p_direction: harfbuzz.direction_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const otLayoutLookupGetOpticalBound = hb_ot_layout_lookup_get_optical_bound;

/// Compute the transitive closure of glyphs needed for a
/// specified lookup.
extern fn hb_ot_layout_lookup_substitute_closure(p_face: *harfbuzz.face_t, p_lookup_index: c_uint, p_glyphs: *harfbuzz.set_t) void;
pub const otLayoutLookupSubstituteClosure = hb_ot_layout_lookup_substitute_closure;

/// Tests whether a specified lookup in the specified face would
/// trigger a substitution on the given glyph sequence.
extern fn hb_ot_layout_lookup_would_substitute(p_face: *harfbuzz.face_t, p_lookup_index: c_uint, p_glyphs: *const harfbuzz.codepoint_t, p_glyphs_length: c_uint, p_zero_context: harfbuzz.bool_t) harfbuzz.bool_t;
pub const otLayoutLookupWouldSubstitute = hb_ot_layout_lookup_would_substitute;

/// Compute the transitive closure of glyphs needed for all of the
/// provided lookups.
extern fn hb_ot_layout_lookups_substitute_closure(p_face: *harfbuzz.face_t, p_lookups: *const harfbuzz.set_t, p_glyphs: *harfbuzz.set_t) void;
pub const otLayoutLookupsSubstituteClosure = hb_ot_layout_lookups_substitute_closure;

/// Fetches the index of a given language tag in the specified face's GSUB table
/// or GPOS table, underneath the specified script tag.
extern fn hb_ot_layout_script_find_language(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_tag: harfbuzz.tag_t, p_language_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutScriptFindLanguage = hb_ot_layout_script_find_language;

/// Fetches a list of language tags in the given face's GSUB or GPOS table, underneath
/// the specified script index. The list returned will begin at the offset provided.
extern fn hb_ot_layout_script_get_language_tags(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_start_offset: c_uint, p_language_count: ?*c_uint, p_language_tags: *[*]harfbuzz.tag_t) c_uint;
pub const otLayoutScriptGetLanguageTags = hb_ot_layout_script_get_language_tags;

/// Fetches the index of the first language tag fom `language_tags` that is present
/// in the specified face's GSUB or GPOS table, underneath the specified script
/// index.
///
/// If none of the given language tags is found, `false` is returned and
/// `language_index` is set to the default language index.
extern fn hb_ot_layout_script_select_language(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_count: c_uint, p_language_tags: *const harfbuzz.tag_t, p_language_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutScriptSelectLanguage = hb_ot_layout_script_select_language;

/// Fetches the index of the first language tag fom `language_tags` that is present
/// in the specified face's GSUB or GPOS table, underneath the specified script
/// index.
///
/// If none of the given language tags is found, `false` is returned and
/// `language_index` is set to `HB_OT_LAYOUT_DEFAULT_LANGUAGE_INDEX` and
/// `chosen_language` is set to `HB_TAG_NONE`.
extern fn hb_ot_layout_script_select_language2(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_index: c_uint, p_language_count: c_uint, p_language_tags: *const harfbuzz.tag_t, p_language_index: *c_uint, p_chosen_language: *harfbuzz.tag_t) harfbuzz.bool_t;
pub const otLayoutScriptSelectLanguage2 = hb_ot_layout_script_select_language2;

/// Deprecated since 2.0.0
extern fn hb_ot_layout_table_choose_script(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_tags: *const harfbuzz.tag_t, p_script_index: *c_uint, p_chosen_script: *harfbuzz.tag_t) harfbuzz.bool_t;
pub const otLayoutTableChooseScript = hb_ot_layout_table_choose_script;

/// Fetches a list of feature variations in the specified face's GSUB table
/// or GPOS table, at the specified variation coordinates.
extern fn hb_ot_layout_table_find_feature_variations(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_coords: *const c_int, p_num_coords: c_uint, p_variations_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutTableFindFeatureVariations = hb_ot_layout_table_find_feature_variations;

/// Fetches the index if a given script tag in the specified face's GSUB table
/// or GPOS table.
extern fn hb_ot_layout_table_find_script(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_tag: harfbuzz.tag_t, p_script_index: *c_uint) harfbuzz.bool_t;
pub const otLayoutTableFindScript = hb_ot_layout_table_find_script;

/// Fetches a list of all feature tags in the given face's GSUB or GPOS table.
/// Note that there might be duplicate feature tags, belonging to different
/// script/language-system pairs of the table.
extern fn hb_ot_layout_table_get_feature_tags(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_start_offset: c_uint, p_feature_count: ?*c_uint, p_feature_tags: *[*]harfbuzz.tag_t) c_uint;
pub const otLayoutTableGetFeatureTags = hb_ot_layout_table_get_feature_tags;

/// Fetches the total number of lookups enumerated in the specified
/// face's GSUB table or GPOS table.
extern fn hb_ot_layout_table_get_lookup_count(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t) c_uint;
pub const otLayoutTableGetLookupCount = hb_ot_layout_table_get_lookup_count;

/// Fetches a list of all scripts enumerated in the specified face's GSUB table
/// or GPOS table. The list returned will begin at the offset provided.
extern fn hb_ot_layout_table_get_script_tags(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_start_offset: c_uint, p_script_count: ?*c_uint, p_script_tags: *[*]harfbuzz.tag_t) c_uint;
pub const otLayoutTableGetScriptTags = hb_ot_layout_table_get_script_tags;

/// Selects an OpenType script for `table_tag` from the `script_tags` array.
///
/// If the table does not have any of the requested scripts, then `DFLT`,
/// `dflt`, and `latn` tags are tried in that order. If the table still does not
/// have any of these scripts, `script_index` is set to
/// `HB_OT_LAYOUT_NO_SCRIPT_INDEX` and `chosen_script` is set to `HB_TAG_NONE`.
extern fn hb_ot_layout_table_select_script(p_face: *harfbuzz.face_t, p_table_tag: harfbuzz.tag_t, p_script_count: c_uint, p_script_tags: *const harfbuzz.tag_t, p_script_index: ?*c_uint, p_chosen_script: ?*harfbuzz.tag_t) harfbuzz.bool_t;
pub const otLayoutTableSelectScript = hb_ot_layout_table_select_script;

/// Fetches the specified math constant. For most constants, the value returned
/// is an `harfbuzz.position_t`.
///
/// However, if the requested constant is `HB_OT_MATH_CONSTANT_SCRIPT_PERCENT_SCALE_DOWN`,
/// `HB_OT_MATH_CONSTANT_SCRIPT_SCRIPT_PERCENT_SCALE_DOWN` or
/// `HB_OT_MATH_CONSTANT_RADICAL_DEGREE_BOTTOM_RAISE_PERCENT`, then the return value is
/// an integer between 0 and 100 representing that percentage.
extern fn hb_ot_math_get_constant(p_font: *harfbuzz.font_t, p_constant: harfbuzz.ot_math_constant_t) harfbuzz.position_t;
pub const otMathGetConstant = hb_ot_math_get_constant;

/// Fetches the GlyphAssembly for the specified font, glyph index, and direction.
/// Returned are a list of `harfbuzz.ot_math_glyph_part_t` glyph parts that can be
/// used to draw the glyph and an italics-correction value (if one is defined
/// in the font).
///
/// <note>The `direction` parameter is only used to select between horizontal
/// or vertical directions for the construction. Even though all `harfbuzz.direction_t`
/// values are accepted, only the result of `HB_DIRECTION_IS_HORIZONTAL` is
/// considered.</note>
extern fn hb_ot_math_get_glyph_assembly(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_start_offset: c_uint, p_parts_count: *c_uint, p_parts: *[*]harfbuzz.ot_math_glyph_part_t, p_italics_correction: *harfbuzz.position_t) c_uint;
pub const otMathGetGlyphAssembly = hb_ot_math_get_glyph_assembly;

/// Fetches an italics-correction value (if one exists) for the specified
/// glyph index.
extern fn hb_ot_math_get_glyph_italics_correction(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const otMathGetGlyphItalicsCorrection = hb_ot_math_get_glyph_italics_correction;

/// Fetches the math kerning (cut-ins) value for the specified font, glyph index, and
/// `kern`.
///
/// If the MathKern table is found, the function examines it to find a height
/// value that is greater or equal to `correction_height`. If such a height
/// value is found, corresponding kerning value from the table is returned. If
/// no such height value is found, the last kerning value is returned.
extern fn hb_ot_math_get_glyph_kerning(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_kern: harfbuzz.ot_math_kern_t, p_correction_height: harfbuzz.position_t) harfbuzz.position_t;
pub const otMathGetGlyphKerning = hb_ot_math_get_glyph_kerning;

/// Fetches the raw MathKern (cut-in) data for the specified font, glyph index,
/// and `kern`. The corresponding list of kern values and correction heights is
/// returned as a list of `harfbuzz.ot_math_kern_entry_t` structs.
///
/// See also `harfbuzz.otMathGetGlyphKerning`, which handles selecting the
/// appropriate kern value for a given correction height.
///
/// <note>For a glyph with `n` defined kern values (where `n` > 0), there are only
/// `n`−1 defined correction heights, as each correction height defines a boundary
/// past which the next kern value should be selected. Therefore, only the
/// `harfbuzz.ot_math_kern_entry_t.kern_value` of the uppermost `harfbuzz.ot_math_kern_entry_t`
/// actually comes from the font; its corresponding
/// `harfbuzz.ot_math_kern_entry_t.max_correction_height` is always set to
/// <code>INT32_MAX</code>.</note>
extern fn hb_ot_math_get_glyph_kernings(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_kern: harfbuzz.ot_math_kern_t, p_start_offset: c_uint, p_entries_count: ?*c_uint, p_kern_entries: *[*]harfbuzz.ot_math_kern_entry_t) c_uint;
pub const otMathGetGlyphKernings = hb_ot_math_get_glyph_kernings;

/// Fetches a top-accent-attachment value (if one exists) for the specified
/// glyph index.
///
/// For any glyph that does not have a top-accent-attachment value - that is,
/// a glyph not covered by the `MathTopAccentAttachment` table (or, when
/// `font` has no `MathTopAccentAttachment` table or no `MATH` table, any
/// glyph) - the function synthesizes a value, returning the position at
/// one-half the glyph's advance width.
extern fn hb_ot_math_get_glyph_top_accent_attachment(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.position_t;
pub const otMathGetGlyphTopAccentAttachment = hb_ot_math_get_glyph_top_accent_attachment;

/// Fetches the MathGlyphConstruction for the specified font, glyph index, and
/// direction. The corresponding list of size variants is returned as a list of
/// `harfbuzz.ot_math_glyph_variant_t` structs.
///
/// <note>The `direction` parameter is only used to select between horizontal
/// or vertical directions for the construction. Even though all `harfbuzz.direction_t`
/// values are accepted, only the result of `HB_DIRECTION_IS_HORIZONTAL` is
/// considered.</note>
extern fn hb_ot_math_get_glyph_variants(p_font: *harfbuzz.font_t, p_glyph: harfbuzz.codepoint_t, p_direction: harfbuzz.direction_t, p_start_offset: c_uint, p_variants_count: *c_uint, p_variants: *[*]harfbuzz.ot_math_glyph_variant_t) c_uint;
pub const otMathGetGlyphVariants = hb_ot_math_get_glyph_variants;

/// Fetches the MathVariants table for the specified font and returns the
/// minimum overlap of connecting glyphs that are required to draw a glyph
/// assembly in the specified direction.
///
/// <note>The `direction` parameter is only used to select between horizontal
/// or vertical directions for the construction. Even though all `harfbuzz.direction_t`
/// values are accepted, only the result of `HB_DIRECTION_IS_HORIZONTAL` is
/// considered.</note>
extern fn hb_ot_math_get_min_connector_overlap(p_font: *harfbuzz.font_t, p_direction: harfbuzz.direction_t) harfbuzz.position_t;
pub const otMathGetMinConnectorOverlap = hb_ot_math_get_min_connector_overlap;

/// Tests whether a face has a `MATH` table.
extern fn hb_ot_math_has_data(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otMathHasData = hb_ot_math_has_data;

/// Tests whether the given glyph index is an extended shape in the face.
extern fn hb_ot_math_is_glyph_extended_shape(p_face: *harfbuzz.face_t, p_glyph: harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const otMathIsGlyphExtendedShape = hb_ot_math_is_glyph_extended_shape;

/// Fetches all available feature types.
extern fn hb_ot_meta_get_entry_tags(p_face: *harfbuzz.face_t, p_start_offset: c_uint, p_entries_count: ?*c_uint, p_entries: *[*]harfbuzz.ot_meta_tag_t) c_uint;
pub const otMetaGetEntryTags = hb_ot_meta_get_entry_tags;

/// It fetches metadata entry of a given tag from a font.
extern fn hb_ot_meta_reference_entry(p_face: *harfbuzz.face_t, p_meta_tag: harfbuzz.ot_meta_tag_t) *harfbuzz.blob_t;
pub const otMetaReferenceEntry = hb_ot_meta_reference_entry;

/// Fetches metrics value corresponding to `metrics_tag` from `font`.
extern fn hb_ot_metrics_get_position(p_font: *harfbuzz.font_t, p_metrics_tag: harfbuzz.ot_metrics_tag_t, p_position: ?*harfbuzz.position_t) harfbuzz.bool_t;
pub const otMetricsGetPosition = hb_ot_metrics_get_position;

/// Fetches metrics value corresponding to `metrics_tag` from `font`,
/// and synthesizes a value if it the value is missing in the font.
extern fn hb_ot_metrics_get_position_with_fallback(p_font: *harfbuzz.font_t, p_metrics_tag: harfbuzz.ot_metrics_tag_t, p_position: ?*harfbuzz.position_t) void;
pub const otMetricsGetPositionWithFallback = hb_ot_metrics_get_position_with_fallback;

/// Fetches metrics value corresponding to `metrics_tag` from `font` with the
/// current font variation settings applied.
extern fn hb_ot_metrics_get_variation(p_font: *harfbuzz.font_t, p_metrics_tag: harfbuzz.ot_metrics_tag_t) f32;
pub const otMetricsGetVariation = hb_ot_metrics_get_variation;

/// Fetches horizontal metrics value corresponding to `metrics_tag` from `font`
/// with the current font variation settings applied.
extern fn hb_ot_metrics_get_x_variation(p_font: *harfbuzz.font_t, p_metrics_tag: harfbuzz.ot_metrics_tag_t) harfbuzz.position_t;
pub const otMetricsGetXVariation = hb_ot_metrics_get_x_variation;

/// Fetches vertical metrics value corresponding to `metrics_tag` from `font` with
/// the current font variation settings applied.
extern fn hb_ot_metrics_get_y_variation(p_font: *harfbuzz.font_t, p_metrics_tag: harfbuzz.ot_metrics_tag_t) harfbuzz.position_t;
pub const otMetricsGetYVariation = hb_ot_metrics_get_y_variation;

/// Fetches a font name from the OpenType 'name' table.
/// If `language` is `HB_LANGUAGE_INVALID`, English ("en") is assumed.
/// Returns string in UTF-16 encoding. A NUL terminator is always written
/// for convenience, and isn't included in the output `text_size`.
extern fn hb_ot_name_get_utf16(p_face: *harfbuzz.face_t, p_name_id: harfbuzz.ot_name_id_t, p_language: harfbuzz.language_t, p_text_size: ?*c_uint, p_text: *[*]u16) c_uint;
pub const otNameGetUtf16 = hb_ot_name_get_utf16;

/// Fetches a font name from the OpenType 'name' table.
/// If `language` is `HB_LANGUAGE_INVALID`, English ("en") is assumed.
/// Returns string in UTF-32 encoding. A NUL terminator is always written
/// for convenience, and isn't included in the output `text_size`.
extern fn hb_ot_name_get_utf32(p_face: *harfbuzz.face_t, p_name_id: harfbuzz.ot_name_id_t, p_language: harfbuzz.language_t, p_text_size: ?*c_uint, p_text: *[*]u32) c_uint;
pub const otNameGetUtf32 = hb_ot_name_get_utf32;

/// Fetches a font name from the OpenType 'name' table.
/// If `language` is `HB_LANGUAGE_INVALID`, English ("en") is assumed.
/// Returns string in UTF-8 encoding. A NUL terminator is always written
/// for convenience, and isn't included in the output `text_size`.
extern fn hb_ot_name_get_utf8(p_face: *harfbuzz.face_t, p_name_id: harfbuzz.ot_name_id_t, p_language: harfbuzz.language_t, p_text_size: ?*c_uint, p_text: *[*]u8) c_uint;
pub const otNameGetUtf8 = hb_ot_name_get_utf8;

/// Enumerates all available name IDs and language combinations. Returned
/// array is owned by the `face` and should not be modified.  It can be
/// used as long as `face` is alive.
extern fn hb_ot_name_list_names(p_face: *harfbuzz.face_t, p_num_entries: ?*c_uint) [*]const harfbuzz.ot_name_entry_t;
pub const otNameListNames = hb_ot_name_list_names;

/// Computes the transitive closure of glyphs needed for a specified
/// input buffer under the given font and feature list. The closure is
/// computed as a set, not as a list.
extern fn hb_ot_shape_glyphs_closure(p_font: *harfbuzz.font_t, p_buffer: *harfbuzz.buffer_t, p_features: [*]const harfbuzz.feature_t, p_num_features: c_uint, p_glyphs: *harfbuzz.set_t) void;
pub const otShapeGlyphsClosure = hb_ot_shape_glyphs_closure;

/// Computes the complete set of GSUB or GPOS lookups that are applicable
/// under a given `shape_plan`.
extern fn hb_ot_shape_plan_collect_lookups(p_shape_plan: *harfbuzz.shape_plan_t, p_table_tag: harfbuzz.tag_t, p_lookup_indexes: *harfbuzz.set_t) void;
pub const otShapePlanCollectLookups = hb_ot_shape_plan_collect_lookups;

/// Fetches the list of OpenType feature tags enabled for a shaping plan, if possible.
extern fn hb_ot_shape_plan_get_feature_tags(p_shape_plan: *harfbuzz.shape_plan_t, p_start_offset: c_uint, p_tag_count: *c_uint, p_tags: *[*]harfbuzz.tag_t) c_uint;
pub const otShapePlanGetFeatureTags = hb_ot_shape_plan_get_feature_tags;

/// Converts an `harfbuzz.language_t` to an `harfbuzz.tag_t`.
extern fn hb_ot_tag_from_language(p_language: harfbuzz.language_t) harfbuzz.tag_t;
pub const otTagFromLanguage = hb_ot_tag_from_language;

/// Converts a language tag to an `harfbuzz.language_t`.
extern fn hb_ot_tag_to_language(p_tag: harfbuzz.tag_t) ?harfbuzz.language_t;
pub const otTagToLanguage = hb_ot_tag_to_language;

/// Converts a script tag to an `harfbuzz.script_t`.
extern fn hb_ot_tag_to_script(p_tag: harfbuzz.tag_t) harfbuzz.script_t;
pub const otTagToScript = hb_ot_tag_to_script;

/// Converts an `harfbuzz.script_t` to script tags.
extern fn hb_ot_tags_from_script(p_script: harfbuzz.script_t, p_script_tag_1: *harfbuzz.tag_t, p_script_tag_2: *harfbuzz.tag_t) void;
pub const otTagsFromScript = hb_ot_tags_from_script;

/// Converts an `harfbuzz.script_t` and an `harfbuzz.language_t` to script and language tags.
extern fn hb_ot_tags_from_script_and_language(p_script: harfbuzz.script_t, p_language: ?harfbuzz.language_t, p_script_count: ?*c_uint, p_script_tags: ?*harfbuzz.tag_t, p_language_count: ?*c_uint, p_language_tags: ?*harfbuzz.tag_t) void;
pub const otTagsFromScriptAndLanguage = hb_ot_tags_from_script_and_language;

/// Converts a script tag and a language tag to an `harfbuzz.script_t` and an
/// `harfbuzz.language_t`.
extern fn hb_ot_tags_to_script_and_language(p_script_tag: harfbuzz.tag_t, p_language_tag: harfbuzz.tag_t, p_script: ?*harfbuzz.script_t, p_language: ?*harfbuzz.language_t) void;
pub const otTagsToScriptAndLanguage = hb_ot_tags_to_script_and_language;

/// Fetches the variation-axis information corresponding to the specified axis tag
/// in the specified face.
extern fn hb_ot_var_find_axis(p_face: *harfbuzz.face_t, p_axis_tag: harfbuzz.tag_t, p_axis_index: *c_uint, p_axis_info: *harfbuzz.ot_var_axis_t) harfbuzz.bool_t;
pub const otVarFindAxis = hb_ot_var_find_axis;

/// Fetches the variation-axis information corresponding to the specified axis tag
/// in the specified face.
extern fn hb_ot_var_find_axis_info(p_face: *harfbuzz.face_t, p_axis_tag: harfbuzz.tag_t, p_axis_info: *harfbuzz.ot_var_axis_info_t) harfbuzz.bool_t;
pub const otVarFindAxisInfo = hb_ot_var_find_axis_info;

/// Fetches a list of all variation axes in the specified face. The list returned will begin
/// at the offset provided.
extern fn hb_ot_var_get_axes(p_face: *harfbuzz.face_t, p_start_offset: c_uint, p_axes_count: ?*c_uint, p_axes_array: *[*]harfbuzz.ot_var_axis_t) c_uint;
pub const otVarGetAxes = hb_ot_var_get_axes;

/// Fetches the number of OpenType variation axes included in the face.
extern fn hb_ot_var_get_axis_count(p_face: *harfbuzz.face_t) c_uint;
pub const otVarGetAxisCount = hb_ot_var_get_axis_count;

/// Fetches a list of all variation axes in the specified face. The list returned will begin
/// at the offset provided.
extern fn hb_ot_var_get_axis_infos(p_face: *harfbuzz.face_t, p_start_offset: c_uint, p_axes_count: ?*c_uint, p_axes_array: *[*]harfbuzz.ot_var_axis_info_t) c_uint;
pub const otVarGetAxisInfos = hb_ot_var_get_axis_infos;

/// Fetches the number of named instances included in the face.
extern fn hb_ot_var_get_named_instance_count(p_face: *harfbuzz.face_t) c_uint;
pub const otVarGetNamedInstanceCount = hb_ot_var_get_named_instance_count;

/// Tests whether a face includes any OpenType variation data in the `fvar` table.
extern fn hb_ot_var_has_data(p_face: *harfbuzz.face_t) harfbuzz.bool_t;
pub const otVarHasData = hb_ot_var_has_data;

/// Fetches the design-space coordinates corresponding to the given
/// named instance in the face.
extern fn hb_ot_var_named_instance_get_design_coords(p_face: *harfbuzz.face_t, p_instance_index: c_uint, p_coords_length: ?*c_uint, p_coords: *[*]f32) c_uint;
pub const otVarNamedInstanceGetDesignCoords = hb_ot_var_named_instance_get_design_coords;

/// Fetches the `name` table Name ID that provides display names for
/// the "PostScript name" defined for the given named instance in the face.
extern fn hb_ot_var_named_instance_get_postscript_name_id(p_face: *harfbuzz.face_t, p_instance_index: c_uint) harfbuzz.ot_name_id_t;
pub const otVarNamedInstanceGetPostscriptNameId = hb_ot_var_named_instance_get_postscript_name_id;

/// Fetches the `name` table Name ID that provides display names for
/// the "Subfamily name" defined for the given named instance in the face.
extern fn hb_ot_var_named_instance_get_subfamily_name_id(p_face: *harfbuzz.face_t, p_instance_index: c_uint) harfbuzz.ot_name_id_t;
pub const otVarNamedInstanceGetSubfamilyNameId = hb_ot_var_named_instance_get_subfamily_name_id;

/// Normalizes the given design-space coordinates. The minimum and maximum
/// values for the axis are mapped to the interval [-1,1], with the default
/// axis value mapped to 0.
///
/// The normalized values have 14 bits of fixed-point sub-integer precision as per
/// OpenType specification.
///
/// Any additional scaling defined in the face's `avar` table is also
/// applied, as described at https://docs.microsoft.com/en-us/typography/opentype/spec/avar
extern fn hb_ot_var_normalize_coords(p_face: *harfbuzz.face_t, p_coords_length: c_uint, p_design_coords: *const f32, p_normalized_coords: *c_int) void;
pub const otVarNormalizeCoords = hb_ot_var_normalize_coords;

/// Normalizes all of the coordinates in the given list of variation axes.
extern fn hb_ot_var_normalize_variations(p_face: *harfbuzz.face_t, p_variations: *const harfbuzz.variation_t, p_variations_length: c_uint, p_coords: *[*]c_int, p_coords_length: c_uint) void;
pub const otVarNormalizeVariations = hb_ot_var_normalize_variations;

/// Perform a "color" paint operation.
extern fn hb_paint_color(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_is_foreground: harfbuzz.bool_t, p_color: harfbuzz.color_t) void;
pub const paintColor = hb_paint_color;

/// Perform a "color-glyph" paint operation.
extern fn hb_paint_color_glyph(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_font: *harfbuzz.font_t) harfbuzz.bool_t;
pub const paintColorGlyph = hb_paint_color_glyph;

/// Gets the custom palette color for `color_index`.
extern fn hb_paint_custom_palette_color(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_index: c_uint, p_color: *harfbuzz.color_t) harfbuzz.bool_t;
pub const paintCustomPaletteColor = hb_paint_custom_palette_color;

/// Creates a new `harfbuzz.paint_funcs_t` structure of paint functions.
///
/// The initial reference count of 1 should be released with `harfbuzz.paintFuncsDestroy`
/// when you are done using the `harfbuzz.paint_funcs_t`. This function never returns
/// `NULL`. If memory cannot be allocated, a special singleton `harfbuzz.paint_funcs_t`
/// object will be returned.
extern fn hb_paint_funcs_create() *harfbuzz.paint_funcs_t;
pub const paintFuncsCreate = hb_paint_funcs_create;

/// Decreases the reference count on a paint-functions structure.
///
/// When the reference count reaches zero, the structure
/// is destroyed, freeing all memory.
extern fn hb_paint_funcs_destroy(p_funcs: *harfbuzz.paint_funcs_t) void;
pub const paintFuncsDestroy = hb_paint_funcs_destroy;

/// Fetches the singleton empty paint-functions structure.
extern fn hb_paint_funcs_get_empty() *harfbuzz.paint_funcs_t;
pub const paintFuncsGetEmpty = hb_paint_funcs_get_empty;

/// Fetches the user-data associated with the specified key,
/// attached to the specified paint-functions structure.
extern fn hb_paint_funcs_get_user_data(p_funcs: *const harfbuzz.paint_funcs_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const paintFuncsGetUserData = hb_paint_funcs_get_user_data;

/// Tests whether a paint-functions structure is immutable.
extern fn hb_paint_funcs_is_immutable(p_funcs: *harfbuzz.paint_funcs_t) harfbuzz.bool_t;
pub const paintFuncsIsImmutable = hb_paint_funcs_is_immutable;

/// Makes a paint-functions structure immutable.
///
/// After this call, all attempts to set one of the callbacks
/// on `funcs` will fail.
extern fn hb_paint_funcs_make_immutable(p_funcs: *harfbuzz.paint_funcs_t) void;
pub const paintFuncsMakeImmutable = hb_paint_funcs_make_immutable;

/// Increases the reference count on a paint-functions structure.
///
/// This prevents `funcs` from being destroyed until a matching
/// call to `harfbuzz.paintFuncsDestroy` is made.
extern fn hb_paint_funcs_reference(p_funcs: *harfbuzz.paint_funcs_t) *harfbuzz.paint_funcs_t;
pub const paintFuncsReference = hb_paint_funcs_reference;

/// Sets the paint-color callback on the paint functions struct.
extern fn hb_paint_funcs_set_color_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_color_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetColorFunc = hb_paint_funcs_set_color_func;

/// Sets the color-glyph callback on the paint functions struct.
extern fn hb_paint_funcs_set_color_glyph_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_color_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetColorGlyphFunc = hb_paint_funcs_set_color_glyph_func;

/// Sets the custom-palette-color callback on the paint functions struct.
extern fn hb_paint_funcs_set_custom_palette_color_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_custom_palette_color_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetCustomPaletteColorFunc = hb_paint_funcs_set_custom_palette_color_func;

/// Sets the paint-image callback on the paint functions struct.
extern fn hb_paint_funcs_set_image_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_image_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetImageFunc = hb_paint_funcs_set_image_func;

/// Sets the linear-gradient callback on the paint functions struct.
extern fn hb_paint_funcs_set_linear_gradient_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_linear_gradient_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetLinearGradientFunc = hb_paint_funcs_set_linear_gradient_func;

/// Sets the pop-clip callback on the paint functions struct.
extern fn hb_paint_funcs_set_pop_clip_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_pop_clip_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPopClipFunc = hb_paint_funcs_set_pop_clip_func;

/// Sets the pop-group callback on the paint functions struct.
extern fn hb_paint_funcs_set_pop_group_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_pop_group_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPopGroupFunc = hb_paint_funcs_set_pop_group_func;

/// Sets the pop-transform callback on the paint functions struct.
extern fn hb_paint_funcs_set_pop_transform_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_pop_transform_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPopTransformFunc = hb_paint_funcs_set_pop_transform_func;

/// Sets the push-clip-glyph callback on the paint functions struct.
extern fn hb_paint_funcs_set_push_clip_glyph_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_push_clip_glyph_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPushClipGlyphFunc = hb_paint_funcs_set_push_clip_glyph_func;

/// Sets the push-clip-rect callback on the paint functions struct.
extern fn hb_paint_funcs_set_push_clip_rectangle_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_push_clip_rectangle_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPushClipRectangleFunc = hb_paint_funcs_set_push_clip_rectangle_func;

/// Sets the push-group callback on the paint functions struct.
extern fn hb_paint_funcs_set_push_group_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_push_group_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPushGroupFunc = hb_paint_funcs_set_push_group_func;

/// Sets the push-transform callback on the paint functions struct.
extern fn hb_paint_funcs_set_push_transform_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_push_transform_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetPushTransformFunc = hb_paint_funcs_set_push_transform_func;

/// Sets the radial-gradient callback on the paint functions struct.
extern fn hb_paint_funcs_set_radial_gradient_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_radial_gradient_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetRadialGradientFunc = hb_paint_funcs_set_radial_gradient_func;

/// Sets the sweep-gradient callback on the paint functions struct.
extern fn hb_paint_funcs_set_sweep_gradient_func(p_funcs: *harfbuzz.paint_funcs_t, p_func: harfbuzz.paint_sweep_gradient_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const paintFuncsSetSweepGradientFunc = hb_paint_funcs_set_sweep_gradient_func;

/// Attaches a user-data key/data pair to the specified paint-functions structure.
extern fn hb_paint_funcs_set_user_data(p_funcs: *harfbuzz.paint_funcs_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const paintFuncsSetUserData = hb_paint_funcs_set_user_data;

/// Perform a "image" paint operation.
extern fn hb_paint_image(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_image: *harfbuzz.blob_t, p_width: c_uint, p_height: c_uint, p_format: harfbuzz.tag_t, p_slant: f32, p_extents: ?*harfbuzz.glyph_extents_t) void;
pub const paintImage = hb_paint_image;

/// Perform a "linear-gradient" paint operation.
extern fn hb_paint_linear_gradient(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32) void;
pub const paintLinearGradient = hb_paint_linear_gradient;

/// Perform a "pop-clip" paint operation.
extern fn hb_paint_pop_clip(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque) void;
pub const paintPopClip = hb_paint_pop_clip;

/// Perform a "pop-group" paint operation.
extern fn hb_paint_pop_group(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_mode: harfbuzz.paint_composite_mode_t) void;
pub const paintPopGroup = hb_paint_pop_group;

/// Perform a "pop-transform" paint operation.
extern fn hb_paint_pop_transform(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque) void;
pub const paintPopTransform = hb_paint_pop_transform;

/// Perform a "push-clip-glyph" paint operation.
extern fn hb_paint_push_clip_glyph(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_font: *harfbuzz.font_t) void;
pub const paintPushClipGlyph = hb_paint_push_clip_glyph;

/// Perform a "push-clip-rect" paint operation.
extern fn hb_paint_push_clip_rectangle(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_xmin: f32, p_ymin: f32, p_xmax: f32, p_ymax: f32) void;
pub const paintPushClipRectangle = hb_paint_push_clip_rectangle;

/// Push the transform reflecting the font's scale and slant
/// settings onto the paint functions.
extern fn hb_paint_push_font_transform(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_font: *const harfbuzz.font_t) void;
pub const paintPushFontTransform = hb_paint_push_font_transform;

/// Perform a "push-group" paint operation.
extern fn hb_paint_push_group(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque) void;
pub const paintPushGroup = hb_paint_push_group;

/// Push the inverse of the transform reflecting the font's
/// scale and slant settings onto the paint functions.
extern fn hb_paint_push_inverse_font_transform(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_font: *const harfbuzz.font_t) void;
pub const paintPushInverseFontTransform = hb_paint_push_inverse_font_transform;

/// Perform a "push-transform" paint operation.
extern fn hb_paint_push_transform(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_xx: f32, p_yx: f32, p_xy: f32, p_yy: f32, p_dx: f32, p_dy: f32) void;
pub const paintPushTransform = hb_paint_push_transform;

/// Perform a "radial-gradient" paint operation.
extern fn hb_paint_radial_gradient(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_r0: f32, p_x1: f32, p_y1: f32, p_r1: f32) void;
pub const paintRadialGradient = hb_paint_radial_gradient;

/// Perform a "sweep-gradient" paint operation.
extern fn hb_paint_sweep_gradient(p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_start_angle: f32, p_end_angle: f32) void;
pub const paintSweepGradient = hb_paint_sweep_gradient;

/// Reallocates the memory pointed to by `ptr` to `size` bytes, using the
/// allocator set at compile-time. Typically just `realloc`.
extern fn hb_realloc(p_ptr: ?*anyopaque, p_size: usize) ?*anyopaque;
pub const realloc = hb_realloc;

/// Converts an ISO 15924 script tag to a corresponding `harfbuzz.script_t`.
extern fn hb_script_from_iso15924_tag(p_tag: harfbuzz.tag_t) harfbuzz.script_t;
pub const scriptFromIso15924Tag = hb_script_from_iso15924_tag;

/// Converts a string `str` representing an ISO 15924 script tag to a
/// corresponding `harfbuzz.script_t`. Shorthand for `harfbuzz.tagFromString` then
/// `harfbuzz.scriptFromIso15924Tag`.
extern fn hb_script_from_string(p_str: [*]const u8, p_len: c_int) harfbuzz.script_t;
pub const scriptFromString = hb_script_from_string;

/// Fetches the `harfbuzz.direction_t` of a script when it is
/// set horizontally. All right-to-left scripts will return
/// `HB_DIRECTION_RTL`. All left-to-right scripts will return
/// `HB_DIRECTION_LTR`.  Scripts that can be written either
/// horizontally or vertically will return `HB_DIRECTION_INVALID`.
/// Unknown scripts will return `HB_DIRECTION_LTR`.
extern fn hb_script_get_horizontal_direction(p_script: harfbuzz.script_t) harfbuzz.direction_t;
pub const scriptGetHorizontalDirection = hb_script_get_horizontal_direction;

/// Converts an `harfbuzz.script_t` to a corresponding ISO 15924 script tag.
extern fn hb_script_to_iso15924_tag(p_script: harfbuzz.script_t) harfbuzz.tag_t;
pub const scriptToIso15924Tag = hb_script_to_iso15924_tag;

/// Checks the equality of two `harfbuzz.segment_properties_t`'s.
extern fn hb_segment_properties_equal(p_a: *const harfbuzz.segment_properties_t, p_b: *const harfbuzz.segment_properties_t) harfbuzz.bool_t;
pub const segmentPropertiesEqual = hb_segment_properties_equal;

/// Creates a hash representing `p`.
extern fn hb_segment_properties_hash(p_p: *const harfbuzz.segment_properties_t) c_uint;
pub const segmentPropertiesHash = hb_segment_properties_hash;

/// Fills in missing fields of `p` from `src` in a considered manner.
///
/// First, if `p` does not have direction set, direction is copied from `src`.
///
/// Next, if `p` and `src` have the same direction (which can be unset), if `p`
/// does not have script set, script is copied from `src`.
///
/// Finally, if `p` and `src` have the same direction and script (which either
/// can be unset), if `p` does not have language set, language is copied from
/// `src`.
extern fn hb_segment_properties_overlay(p_p: *harfbuzz.segment_properties_t, p_src: *const harfbuzz.segment_properties_t) void;
pub const segmentPropertiesOverlay = hb_segment_properties_overlay;

/// Adds `codepoint` to `set`.
extern fn hb_set_add(p_set: *harfbuzz.set_t, p_codepoint: harfbuzz.codepoint_t) void;
pub const setAdd = hb_set_add;

/// Adds all of the elements from `first` to `last`
/// (inclusive) to `set`.
extern fn hb_set_add_range(p_set: *harfbuzz.set_t, p_first: harfbuzz.codepoint_t, p_last: harfbuzz.codepoint_t) void;
pub const setAddRange = hb_set_add_range;

/// Adds `num_codepoints` codepoints to a set at once.
/// The codepoints array must be in increasing order,
/// with size at least `num_codepoints`.
extern fn hb_set_add_sorted_array(p_set: *harfbuzz.set_t, p_sorted_codepoints: [*]const harfbuzz.codepoint_t, p_num_codepoints: c_uint) void;
pub const setAddSortedArray = hb_set_add_sorted_array;

/// Tests whether memory allocation for a set was successful.
extern fn hb_set_allocation_successful(p_set: *const harfbuzz.set_t) harfbuzz.bool_t;
pub const setAllocationSuccessful = hb_set_allocation_successful;

/// Clears out the contents of a set.
extern fn hb_set_clear(p_set: *harfbuzz.set_t) void;
pub const setClear = hb_set_clear;

/// Allocate a copy of `set`.
extern fn hb_set_copy(p_set: *const harfbuzz.set_t) *harfbuzz.set_t;
pub const setCopy = hb_set_copy;

/// Creates a new, initially empty set.
extern fn hb_set_create() *harfbuzz.set_t;
pub const setCreate = hb_set_create;

/// Removes `codepoint` from `set`.
extern fn hb_set_del(p_set: *harfbuzz.set_t, p_codepoint: harfbuzz.codepoint_t) void;
pub const setDel = hb_set_del;

/// Removes all of the elements from `first` to `last`
/// (inclusive) from `set`.
///
/// If `last` is `HB_SET_VALUE_INVALID`, then all values
/// greater than or equal to `first` are removed.
extern fn hb_set_del_range(p_set: *harfbuzz.set_t, p_first: harfbuzz.codepoint_t, p_last: harfbuzz.codepoint_t) void;
pub const setDelRange = hb_set_del_range;

/// Decreases the reference count on a set. When
/// the reference count reaches zero, the set is
/// destroyed, freeing all memory.
extern fn hb_set_destroy(p_set: *harfbuzz.set_t) void;
pub const setDestroy = hb_set_destroy;

/// Fetches the singleton empty `harfbuzz.set_t`.
extern fn hb_set_get_empty() *harfbuzz.set_t;
pub const setGetEmpty = hb_set_get_empty;

/// Finds the largest element in the set.
extern fn hb_set_get_max(p_set: *const harfbuzz.set_t) harfbuzz.codepoint_t;
pub const setGetMax = hb_set_get_max;

/// Finds the smallest element in the set.
extern fn hb_set_get_min(p_set: *const harfbuzz.set_t) harfbuzz.codepoint_t;
pub const setGetMin = hb_set_get_min;

/// Returns the number of elements in the set.
extern fn hb_set_get_population(p_set: *const harfbuzz.set_t) c_uint;
pub const setGetPopulation = hb_set_get_population;

/// Fetches the user data associated with the specified key,
/// attached to the specified set.
extern fn hb_set_get_user_data(p_set: *const harfbuzz.set_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const setGetUserData = hb_set_get_user_data;

/// Tests whether `codepoint` belongs to `set`.
extern fn hb_set_has(p_set: *const harfbuzz.set_t, p_codepoint: harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const setHas = hb_set_has;

/// Creates a hash representing `set`.
extern fn hb_set_hash(p_set: *const harfbuzz.set_t) c_uint;
pub const setHash = hb_set_hash;

/// Makes `set` the intersection of `set` and `other`.
extern fn hb_set_intersect(p_set: *harfbuzz.set_t, p_other: *const harfbuzz.set_t) void;
pub const setIntersect = hb_set_intersect;

/// Inverts the contents of `set`.
extern fn hb_set_invert(p_set: *harfbuzz.set_t) void;
pub const setInvert = hb_set_invert;

/// Tests whether a set is empty (contains no elements).
extern fn hb_set_is_empty(p_set: *const harfbuzz.set_t) harfbuzz.bool_t;
pub const setIsEmpty = hb_set_is_empty;

/// Tests whether `set` and `other` are equal (contain the same
/// elements).
extern fn hb_set_is_equal(p_set: *const harfbuzz.set_t, p_other: *const harfbuzz.set_t) harfbuzz.bool_t;
pub const setIsEqual = hb_set_is_equal;

/// Returns whether the set is inverted.
extern fn hb_set_is_inverted(p_set: *const harfbuzz.set_t) harfbuzz.bool_t;
pub const setIsInverted = hb_set_is_inverted;

/// Tests whether `set` is a subset of `larger_set`.
extern fn hb_set_is_subset(p_set: *const harfbuzz.set_t, p_larger_set: *const harfbuzz.set_t) harfbuzz.bool_t;
pub const setIsSubset = hb_set_is_subset;

/// Fetches the next element in `set` that is greater than current value of `codepoint`.
///
/// Set `codepoint` to `HB_SET_VALUE_INVALID` to get started.
extern fn hb_set_next(p_set: *const harfbuzz.set_t, p_codepoint: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const setNext = hb_set_next;

/// Finds the next element in `set` that is greater than `codepoint`. Writes out
/// codepoints to `out`, until either the set runs out of elements, or `size`
/// codepoints are written, whichever comes first.
extern fn hb_set_next_many(p_set: *const harfbuzz.set_t, p_codepoint: harfbuzz.codepoint_t, p_out: [*]harfbuzz.codepoint_t, p_size: c_uint) c_uint;
pub const setNextMany = hb_set_next_many;

/// Fetches the next consecutive range of elements in `set` that
/// are greater than current value of `last`.
///
/// Set `last` to `HB_SET_VALUE_INVALID` to get started.
extern fn hb_set_next_range(p_set: *const harfbuzz.set_t, p_first: *harfbuzz.codepoint_t, p_last: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const setNextRange = hb_set_next_range;

/// Fetches the previous element in `set` that is lower than current value of `codepoint`.
///
/// Set `codepoint` to `HB_SET_VALUE_INVALID` to get started.
extern fn hb_set_previous(p_set: *const harfbuzz.set_t, p_codepoint: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const setPrevious = hb_set_previous;

/// Fetches the previous consecutive range of elements in `set` that
/// are greater than current value of `last`.
///
/// Set `first` to `HB_SET_VALUE_INVALID` to get started.
extern fn hb_set_previous_range(p_set: *const harfbuzz.set_t, p_first: *harfbuzz.codepoint_t, p_last: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const setPreviousRange = hb_set_previous_range;

/// Increases the reference count on a set.
extern fn hb_set_reference(p_set: *harfbuzz.set_t) *harfbuzz.set_t;
pub const setReference = hb_set_reference;

/// Makes the contents of `set` equal to the contents of `other`.
extern fn hb_set_set(p_set: *harfbuzz.set_t, p_other: *const harfbuzz.set_t) void;
pub const setSet = hb_set_set;

/// Attaches a user-data key/data pair to the specified set.
extern fn hb_set_set_user_data(p_set: *harfbuzz.set_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const setSetUserData = hb_set_set_user_data;

/// Subtracts the contents of `other` from `set`.
extern fn hb_set_subtract(p_set: *harfbuzz.set_t, p_other: *const harfbuzz.set_t) void;
pub const setSubtract = hb_set_subtract;

/// Makes `set` the symmetric difference of `set`
/// and `other`.
extern fn hb_set_symmetric_difference(p_set: *harfbuzz.set_t, p_other: *const harfbuzz.set_t) void;
pub const setSymmetricDifference = hb_set_symmetric_difference;

/// Makes `set` the union of `set` and `other`.
extern fn hb_set_union(p_set: *harfbuzz.set_t, p_other: *const harfbuzz.set_t) void;
pub const setUnion = hb_set_union;

/// Shapes `buffer` using `font` turning its Unicode characters content to
/// positioned glyphs. If `features` is not `NULL`, it will be used to control the
/// features applied during shaping. If two `features` have the same tag but
/// overlapping ranges the value of the feature with the higher index takes
/// precedence.
extern fn hb_shape(p_font: *harfbuzz.font_t, p_buffer: *harfbuzz.buffer_t, p_features: ?[*]const harfbuzz.feature_t, p_num_features: c_uint) void;
pub const shape = hb_shape;

/// See `harfbuzz.shape` for details. If `shaper_list` is not `NULL`, the specified
/// shapers will be used in the given order, otherwise the default shapers list
/// will be used.
extern fn hb_shape_full(p_font: *harfbuzz.font_t, p_buffer: *harfbuzz.buffer_t, p_features: ?[*]const harfbuzz.feature_t, p_num_features: c_uint, p_shaper_list: ?[*]const [*:0]const u8) harfbuzz.bool_t;
pub const shapeFull = hb_shape_full;

/// Retrieves the list of shapers supported by HarfBuzz.
extern fn hb_shape_list_shapers() [*][*:0]const u8;
pub const shapeListShapers = hb_shape_list_shapers;

/// Constructs a shaping plan for a combination of `face`, `user_features`, `props`,
/// and `shaper_list`.
extern fn hb_shape_plan_create(p_face: *harfbuzz.face_t, p_props: *const harfbuzz.segment_properties_t, p_user_features: [*]const harfbuzz.feature_t, p_num_user_features: c_uint, p_shaper_list: [*]const [*:0]const u8) *harfbuzz.shape_plan_t;
pub const shapePlanCreate = hb_shape_plan_create;

/// The variable-font version of `harfbuzz.shapePlanCreate`.
/// Constructs a shaping plan for a combination of `face`, `user_features`, `props`,
/// and `shaper_list`, plus the variation-space coordinates `coords`.
extern fn hb_shape_plan_create2(p_face: *harfbuzz.face_t, p_props: *const harfbuzz.segment_properties_t, p_user_features: [*]const harfbuzz.feature_t, p_num_user_features: c_uint, p_coords: [*]const c_int, p_num_coords: c_uint, p_shaper_list: [*]const [*:0]const u8) *harfbuzz.shape_plan_t;
pub const shapePlanCreate2 = hb_shape_plan_create2;

/// Creates a cached shaping plan suitable for reuse, for a combination
/// of `face`, `user_features`, `props`, and `shaper_list`.
extern fn hb_shape_plan_create_cached(p_face: *harfbuzz.face_t, p_props: *const harfbuzz.segment_properties_t, p_user_features: [*]const harfbuzz.feature_t, p_num_user_features: c_uint, p_shaper_list: [*]const [*:0]const u8) *harfbuzz.shape_plan_t;
pub const shapePlanCreateCached = hb_shape_plan_create_cached;

/// The variable-font version of `harfbuzz.shapePlanCreateCached`.
/// Creates a cached shaping plan suitable for reuse, for a combination
/// of `face`, `user_features`, `props`, and `shaper_list`, plus the
/// variation-space coordinates `coords`.
extern fn hb_shape_plan_create_cached2(p_face: *harfbuzz.face_t, p_props: *const harfbuzz.segment_properties_t, p_user_features: [*]const harfbuzz.feature_t, p_num_user_features: c_uint, p_coords: [*]const c_int, p_num_coords: c_uint, p_shaper_list: [*]const [*:0]const u8) *harfbuzz.shape_plan_t;
pub const shapePlanCreateCached2 = hb_shape_plan_create_cached2;

/// Decreases the reference count on the given shaping plan. When the
/// reference count reaches zero, the shaping plan is destroyed,
/// freeing all memory.
extern fn hb_shape_plan_destroy(p_shape_plan: *harfbuzz.shape_plan_t) void;
pub const shapePlanDestroy = hb_shape_plan_destroy;

/// Executes the given shaping plan on the specified buffer, using
/// the given `font` and `features`.
extern fn hb_shape_plan_execute(p_shape_plan: *harfbuzz.shape_plan_t, p_font: *harfbuzz.font_t, p_buffer: *harfbuzz.buffer_t, p_features: [*]const harfbuzz.feature_t, p_num_features: c_uint) harfbuzz.bool_t;
pub const shapePlanExecute = hb_shape_plan_execute;

/// Fetches the singleton empty shaping plan.
extern fn hb_shape_plan_get_empty() *harfbuzz.shape_plan_t;
pub const shapePlanGetEmpty = hb_shape_plan_get_empty;

/// Fetches the shaper from a given shaping plan.
extern fn hb_shape_plan_get_shaper(p_shape_plan: *harfbuzz.shape_plan_t) [*:0]const u8;
pub const shapePlanGetShaper = hb_shape_plan_get_shaper;

/// Fetches the user data associated with the specified key,
/// attached to the specified shaping plan.
extern fn hb_shape_plan_get_user_data(p_shape_plan: *const harfbuzz.shape_plan_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const shapePlanGetUserData = hb_shape_plan_get_user_data;

/// Increases the reference count on the given shaping plan.
extern fn hb_shape_plan_reference(p_shape_plan: *harfbuzz.shape_plan_t) *harfbuzz.shape_plan_t;
pub const shapePlanReference = hb_shape_plan_reference;

/// Attaches a user-data key/data pair to the given shaping plan.
extern fn hb_shape_plan_set_user_data(p_shape_plan: *harfbuzz.shape_plan_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const shapePlanSetUserData = hb_shape_plan_set_user_data;

/// Searches variation axes of a `harfbuzz.font_t` object for a specific axis first,
/// if not set, first tries to get default style values in `STAT` table
/// then tries to polyfill from different tables of the font.
extern fn hb_style_get_value(p_font: *harfbuzz.font_t, p_style_tag: harfbuzz.style_tag_t) f32;
pub const styleGetValue = hb_style_get_value;

/// Converts a string into an `harfbuzz.tag_t`. Valid tags
/// are four characters. Shorter input strings will be
/// padded with spaces. Longer input strings will be
/// truncated.
extern fn hb_tag_from_string(p_str: [*]const u8, p_len: c_int) harfbuzz.tag_t;
pub const tagFromString = hb_tag_from_string;

/// Converts an `harfbuzz.tag_t` to a string and returns it in `buf`.
/// Strings will be four characters long.
extern fn hb_tag_to_string(p_tag: harfbuzz.tag_t, p_buf: *[4]u8) void;
pub const tagToString = hb_tag_to_string;

/// Retrieves the Canonical Combining Class (ccc) property
/// of code point `unicode`.
extern fn hb_unicode_combining_class(p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t) harfbuzz.unicode_combining_class_t;
pub const unicodeCombiningClass = hb_unicode_combining_class;

/// Fetches the composition of a sequence of two Unicode
/// code points.
///
/// Calls the composition function of the specified
/// Unicode-functions structure `ufuncs`.
extern fn hb_unicode_compose(p_ufuncs: *harfbuzz.unicode_funcs_t, p_a: harfbuzz.codepoint_t, p_b: harfbuzz.codepoint_t, p_ab: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const unicodeCompose = hb_unicode_compose;

/// Fetches the decomposition of a Unicode code point.
///
/// Calls the decomposition function of the specified
/// Unicode-functions structure `ufuncs`.
extern fn hb_unicode_decompose(p_ufuncs: *harfbuzz.unicode_funcs_t, p_ab: harfbuzz.codepoint_t, p_a: *harfbuzz.codepoint_t, p_b: *harfbuzz.codepoint_t) harfbuzz.bool_t;
pub const unicodeDecompose = hb_unicode_decompose;

/// Fetches the compatibility decomposition of a Unicode
/// code point. Deprecated.
extern fn hb_unicode_decompose_compatibility(p_ufuncs: *harfbuzz.unicode_funcs_t, p_u: harfbuzz.codepoint_t, p_decomposed: *harfbuzz.codepoint_t) c_uint;
pub const unicodeDecomposeCompatibility = hb_unicode_decompose_compatibility;

/// Don't use. Not used by HarfBuzz.
extern fn hb_unicode_eastasian_width(p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t) c_uint;
pub const unicodeEastasianWidth = hb_unicode_eastasian_width;

/// Creates a new `harfbuzz.unicode_funcs_t` structure of Unicode functions.
extern fn hb_unicode_funcs_create(p_parent: ?*harfbuzz.unicode_funcs_t) *harfbuzz.unicode_funcs_t;
pub const unicodeFuncsCreate = hb_unicode_funcs_create;

/// Decreases the reference count on a Unicode-functions structure. When
/// the reference count reaches zero, the Unicode-functions structure is
/// destroyed, freeing all memory.
extern fn hb_unicode_funcs_destroy(p_ufuncs: *harfbuzz.unicode_funcs_t) void;
pub const unicodeFuncsDestroy = hb_unicode_funcs_destroy;

/// Fetches a pointer to the default Unicode-functions structure that is used
/// when no functions are explicitly set on `harfbuzz.buffer_t`.
extern fn hb_unicode_funcs_get_default() *harfbuzz.unicode_funcs_t;
pub const unicodeFuncsGetDefault = hb_unicode_funcs_get_default;

/// Fetches the singleton empty Unicode-functions structure.
extern fn hb_unicode_funcs_get_empty() *harfbuzz.unicode_funcs_t;
pub const unicodeFuncsGetEmpty = hb_unicode_funcs_get_empty;

/// Fetches the parent of the Unicode-functions structure
/// `ufuncs`.
extern fn hb_unicode_funcs_get_parent(p_ufuncs: *harfbuzz.unicode_funcs_t) *harfbuzz.unicode_funcs_t;
pub const unicodeFuncsGetParent = hb_unicode_funcs_get_parent;

/// Fetches the user-data associated with the specified key,
/// attached to the specified Unicode-functions structure.
extern fn hb_unicode_funcs_get_user_data(p_ufuncs: *const harfbuzz.unicode_funcs_t, p_key: *harfbuzz.user_data_key_t) ?*anyopaque;
pub const unicodeFuncsGetUserData = hb_unicode_funcs_get_user_data;

/// Tests whether the specified Unicode-functions structure
/// is immutable.
extern fn hb_unicode_funcs_is_immutable(p_ufuncs: *harfbuzz.unicode_funcs_t) harfbuzz.bool_t;
pub const unicodeFuncsIsImmutable = hb_unicode_funcs_is_immutable;

/// Makes the specified Unicode-functions structure
/// immutable.
extern fn hb_unicode_funcs_make_immutable(p_ufuncs: *harfbuzz.unicode_funcs_t) void;
pub const unicodeFuncsMakeImmutable = hb_unicode_funcs_make_immutable;

/// Increases the reference count on a Unicode-functions structure.
extern fn hb_unicode_funcs_reference(p_ufuncs: *harfbuzz.unicode_funcs_t) *harfbuzz.unicode_funcs_t;
pub const unicodeFuncsReference = hb_unicode_funcs_reference;

/// Sets the implementation function for `harfbuzz.unicode_combining_class_func_t`.
extern fn hb_unicode_funcs_set_combining_class_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_combining_class_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetCombiningClassFunc = hb_unicode_funcs_set_combining_class_func;

/// Sets the implementation function for `harfbuzz.unicode_compose_func_t`.
extern fn hb_unicode_funcs_set_compose_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_compose_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetComposeFunc = hb_unicode_funcs_set_compose_func;

/// Sets the implementation function for `harfbuzz.unicode_decompose_compatibility_func_t`.
extern fn hb_unicode_funcs_set_decompose_compatibility_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_decompose_compatibility_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetDecomposeCompatibilityFunc = hb_unicode_funcs_set_decompose_compatibility_func;

/// Sets the implementation function for `harfbuzz.unicode_decompose_func_t`.
extern fn hb_unicode_funcs_set_decompose_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_decompose_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetDecomposeFunc = hb_unicode_funcs_set_decompose_func;

/// Sets the implementation function for `harfbuzz.unicode_eastasian_width_func_t`.
extern fn hb_unicode_funcs_set_eastasian_width_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_eastasian_width_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetEastasianWidthFunc = hb_unicode_funcs_set_eastasian_width_func;

/// Sets the implementation function for `harfbuzz.unicode_general_category_func_t`.
extern fn hb_unicode_funcs_set_general_category_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_general_category_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetGeneralCategoryFunc = hb_unicode_funcs_set_general_category_func;

/// Sets the implementation function for `harfbuzz.unicode_mirroring_func_t`.
extern fn hb_unicode_funcs_set_mirroring_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_mirroring_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetMirroringFunc = hb_unicode_funcs_set_mirroring_func;

/// Sets the implementation function for `harfbuzz.unicode_script_func_t`.
extern fn hb_unicode_funcs_set_script_func(p_ufuncs: *harfbuzz.unicode_funcs_t, p_func: harfbuzz.unicode_script_func_t, p_user_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t) void;
pub const unicodeFuncsSetScriptFunc = hb_unicode_funcs_set_script_func;

/// Attaches a user-data key/data pair to the specified Unicode-functions structure.
extern fn hb_unicode_funcs_set_user_data(p_ufuncs: *harfbuzz.unicode_funcs_t, p_key: *harfbuzz.user_data_key_t, p_data: ?*anyopaque, p_destroy: ?harfbuzz.destroy_func_t, p_replace: harfbuzz.bool_t) harfbuzz.bool_t;
pub const unicodeFuncsSetUserData = hb_unicode_funcs_set_user_data;

/// Retrieves the General Category (gc) property
/// of code point `unicode`.
extern fn hb_unicode_general_category(p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t) harfbuzz.unicode_general_category_t;
pub const unicodeGeneralCategory = hb_unicode_general_category;

/// Retrieves the Bi-directional Mirroring Glyph code
/// point defined for code point `unicode`.
extern fn hb_unicode_mirroring(p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t) harfbuzz.codepoint_t;
pub const unicodeMirroring = hb_unicode_mirroring;

/// Retrieves the `harfbuzz.script_t` script to which code
/// point `unicode` belongs.
extern fn hb_unicode_script(p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t) harfbuzz.script_t;
pub const unicodeScript = hb_unicode_script;

/// Parses a string into a `harfbuzz.variation_t`.
///
/// The format for specifying variation settings follows. All valid CSS
/// font-variation-settings values other than 'normal' and 'inherited' are also
/// accepted, though, not documented below.
///
/// The format is a tag, optionally followed by an equals sign, followed by a
/// number. For example `wght=500`, or `slnt=-7.5`.
extern fn hb_variation_from_string(p_str: [*]const u8, p_len: c_int, p_variation: *harfbuzz.variation_t) harfbuzz.bool_t;
pub const variationFromString = hb_variation_from_string;

/// Converts an `harfbuzz.variation_t` into a `NULL`-terminated string in the format
/// understood by `harfbuzz.variationFromString`. The client in responsible for
/// allocating big enough size for `buf`, 128 bytes is more than enough.
///
/// Note that the string won't include any whitespace.
extern fn hb_variation_to_string(p_variation: *harfbuzz.variation_t, p_buf: *[*]u8, p_size: c_uint) void;
pub const variationToString = hb_variation_to_string;

/// A callback method for `harfbuzz.buffer_t`. The method gets called with the
/// `harfbuzz.buffer_t` it was set on, the `harfbuzz.font_t` the buffer is shaped with and a
/// message describing what step of the shaping process will be performed.
/// Returning `false` from this method will skip this shaping step and move to
/// the next one.
pub const buffer_message_func_t = *const fn (p_buffer: *harfbuzz.buffer_t, p_font: *harfbuzz.font_t, p_message: [*:0]const u8, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.color_line_t` to fetch color stops.
pub const color_line_get_color_stops_func_t = *const fn (p_color_line: *harfbuzz.color_line_t, p_color_line_data: ?*anyopaque, p_start: c_uint, p_count: ?*c_uint, p_color_stops: ?*[*]harfbuzz.color_stop_t, p_user_data: ?*anyopaque) callconv(.c) c_uint;

/// A virtual method for the `hb_color_line_t` to fetches the extend mode.
pub const color_line_get_extend_func_t = *const fn (p_color_line: *harfbuzz.color_line_t, p_color_line_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.paint_extend_t;

/// A virtual method for destroy user-data callbacks.
pub const destroy_func_t = *const fn (p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.draw_funcs_t` to perform a "close-path" draw
/// operation.
pub const draw_close_path_func_t = *const fn (p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.draw_funcs_t` to perform a "cubic-to" draw
/// operation.
pub const draw_cubic_to_func_t = *const fn (p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_control1_x: f32, p_control1_y: f32, p_control2_x: f32, p_control2_y: f32, p_to_x: f32, p_to_y: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.draw_funcs_t` to perform a "line-to" draw
/// operation.
pub const draw_line_to_func_t = *const fn (p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_to_x: f32, p_to_y: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.draw_funcs_t` to perform a "move-to" draw
/// operation.
pub const draw_move_to_func_t = *const fn (p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_to_x: f32, p_to_y: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.draw_funcs_t` to perform a "quadratic-to" draw
/// operation.
pub const draw_quadratic_to_func_t = *const fn (p_dfuncs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_st: *harfbuzz.draw_state_t, p_control_x: f32, p_control_y: f32, p_to_x: f32, p_to_y: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
pub const font_draw_glyph_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_draw_funcs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
pub const font_draw_glyph_or_fail_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_draw_funcs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// This method should retrieve the extents for a font.
pub const font_get_font_extents_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_extents: *harfbuzz.font_extents_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advance for a specified glyph. The
/// method must return an `harfbuzz.position_t`.
pub const font_get_glyph_advance_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.position_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the advances for a sequence of glyphs.
pub const font_get_glyph_advances_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_count: c_uint, p_first_glyph: *const harfbuzz.codepoint_t, p_glyph_stride: c_uint, p_first_advance: *harfbuzz.position_t, p_advance_stride: c_uint, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the (X,Y) coordinates (in font units) for a
/// specified contour point in a glyph. Each coordinate must be returned as
/// an `harfbuzz.position_t` output parameter.
pub const font_get_glyph_contour_point_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_point_index: c_uint, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the extents for a specified glyph. Extents must be
/// returned in an `hb_glyph_extents` output parameter.
pub const font_get_glyph_extents_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_extents: *harfbuzz.glyph_extents_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the glyph ID that corresponds to a glyph-name
/// string.
pub const font_get_glyph_from_name_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_name: [*]const u8, p_len: c_int, p_glyph: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the glyph ID for a specified Unicode code point
/// font, with an optional variation selector.
pub const font_get_glyph_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_unicode: harfbuzz.codepoint_t, p_variation_selector: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// This method should retrieve the kerning-adjustment value for a glyph-pair in
/// the specified font, for horizontal text segments.
pub const font_get_glyph_kerning_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_first_glyph: harfbuzz.codepoint_t, p_second_glyph: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.position_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the glyph name that corresponds to a
/// glyph ID. The name should be returned in a string output parameter.
pub const font_get_glyph_name_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_name: *[*]u8, p_size: c_uint, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the (X,Y) coordinates (in font units) of the
/// origin for a glyph. Each coordinate must be returned in an `harfbuzz.position_t`
/// output parameter.
pub const font_get_glyph_origin_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_x: *harfbuzz.position_t, p_y: *harfbuzz.position_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
pub const font_get_glyph_shape_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_draw_funcs: *harfbuzz.draw_funcs_t, p_draw_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the nominal glyph ID for a specified Unicode code
/// point. Glyph IDs must be returned in a `harfbuzz.codepoint_t` output parameter.
pub const font_get_nominal_glyph_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_unicode: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the nominal glyph IDs for a sequence of
/// Unicode code points. Glyph IDs must be returned in a `harfbuzz.codepoint_t`
/// output parameter.
pub const font_get_nominal_glyphs_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_count: c_uint, p_first_unicode: *const harfbuzz.codepoint_t, p_unicode_stride: c_uint, p_first_glyph: *harfbuzz.codepoint_t, p_glyph_stride: c_uint, p_user_data: ?*anyopaque) callconv(.c) c_uint;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
///
/// This method should retrieve the glyph ID for a specified Unicode code point
/// followed by a specified Variation Selector code point. Glyph IDs must be
/// returned in a `harfbuzz.codepoint_t` output parameter.
pub const font_get_variation_glyph_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_unicode: harfbuzz.codepoint_t, p_variation_selector: harfbuzz.codepoint_t, p_glyph: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
pub const font_paint_glyph_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_paint_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_palette_index: c_uint, p_foreground: harfbuzz.color_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.font_funcs_t` of an `harfbuzz.font_t` object.
pub const font_paint_glyph_or_fail_func_t = *const fn (p_font: *harfbuzz.font_t, p_font_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_paint_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_palette_index: c_uint, p_foreground: harfbuzz.color_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// Callback function for `harfbuzz.faceGetTableTags`.
pub const get_table_tags_func_t = *const fn (p_face: *const harfbuzz.face_t, p_start_offset: c_uint, p_table_count: *c_uint, p_table_tags: *[*]harfbuzz.tag_t, p_user_data: ?*anyopaque) callconv(.c) c_uint;

/// A virtual method for the `harfbuzz.paint_funcs_t` to paint a
/// color everywhere within the current clip.
pub const paint_color_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_is_foreground: harfbuzz.bool_t, p_color: harfbuzz.color_t, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to render a color glyph by glyph index.
pub const paint_color_glyph_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_font: *harfbuzz.font_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.paint_funcs_t` to fetch a color from the custom
/// color palette.
///
/// Custom palette colors override the colors from the fonts selected color
/// palette. It is not necessary to override all palette entries; for entries
/// that should be taken from the font palette, return `false`.
///
/// This function might get called multiple times, but the custom palette is
/// expected to remain unchanged for duration of a `harfbuzz.fontPaintGlyph` call.
pub const paint_custom_palette_color_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_index: c_uint, p_color: *harfbuzz.color_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.paint_funcs_t` to paint a glyph image.
///
/// This method is called for glyphs with image blobs in the CBDT,
/// sbix or SVG tables. The `format` identifies the kind of data that
/// is contained in `image`. Possible values include `HB_PAINT_IMAGE_FORMAT_PNG`,
/// `HB_PAINT_IMAGE_FORMAT_SVG` and `HB_PAINT_IMAGE_FORMAT_BGRA`.
///
/// The image dimensions and glyph extents are provided if available,
/// and should be used to size and position the image.
pub const paint_image_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_image: *harfbuzz.blob_t, p_width: c_uint, p_height: c_uint, p_format: harfbuzz.tag_t, p_slant: f32, p_extents: ?*harfbuzz.glyph_extents_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.paint_funcs_t` to paint a linear
/// gradient everywhere within the current clip.
///
/// The `color_line` object contains information about the colors of the gradients.
/// It is only valid for the duration of the callback, you cannot keep it around.
///
/// The coordinates of the points are interpreted according
/// to the current transform.
///
/// See the OpenType spec [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details on how the points define the direction
/// of the gradient, and how to interpret the `color_line`.
pub const paint_linear_gradient_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_x1: f32, p_y1: f32, p_x2: f32, p_y2: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to undo
/// the effect of a prior call to the `hb_paint_funcs_push_clip_glyph_func_t`
/// or `hb_paint_funcs_push_clip_rectangle_func_t` vfuncs.
pub const paint_pop_clip_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to undo
/// the effect of a prior call to the `hb_paint_funcs_push_group_func_t`
/// vfunc.
///
/// This call stops the redirection to the intermediate surface,
/// and then composites it on the previous surface, using the
/// compositing mode passed to this call.
pub const paint_pop_group_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_mode: harfbuzz.paint_composite_mode_t, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to undo
/// the effect of a prior call to the `hb_paint_funcs_push_transform_func_t`
/// vfunc.
pub const paint_pop_transform_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to clip
/// subsequent paint calls to the outline of a glyph.
///
/// The coordinates of the glyph outline are expected in the
/// current `font` scale (ie. the results of calling
/// `harfbuzz.fontDrawGlyph` with `font`). The outline is
/// transformed by the current transform.
///
/// This clip is applied in addition to the current clip,
/// and remains in effect until a matching call to
/// the `hb_paint_funcs_pop_clip_func_t` vfunc.
pub const paint_push_clip_glyph_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_glyph: harfbuzz.codepoint_t, p_font: *harfbuzz.font_t, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to clip
/// subsequent paint calls to a rectangle.
///
/// The coordinates of the rectangle are interpreted according
/// to the current transform.
///
/// This clip is applied in addition to the current clip,
/// and remains in effect until a matching call to
/// the `hb_paint_funcs_pop_clip_func_t` vfunc.
pub const paint_push_clip_rectangle_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_xmin: f32, p_ymin: f32, p_xmax: f32, p_ymax: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to use
/// an intermediate surface for subsequent paint calls.
///
/// The drawing will be redirected to an intermediate surface
/// until a matching call to the `hb_paint_funcs_pop_group_func_t`
/// vfunc.
pub const paint_push_group_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to apply
/// a transform to subsequent paint calls.
///
/// This transform is applied after the current transform,
/// and remains in effect until a matching call to
/// the `hb_paint_funcs_pop_transform_func_t` vfunc.
pub const paint_push_transform_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_xx: f32, p_yx: f32, p_xy: f32, p_yy: f32, p_dx: f32, p_dy: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to paint a radial
/// gradient everywhere within the current clip.
///
/// The `color_line` object contains information about the colors of the gradients.
/// It is only valid for the duration of the callback, you cannot keep it around.
///
/// The coordinates of the points are interpreted according
/// to the current transform.
///
/// See the OpenType spec [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details on how the points define the direction
/// of the gradient, and how to interpret the `color_line`.
pub const paint_radial_gradient_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_r0: f32, p_x1: f32, p_y1: f32, p_r1: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// A virtual method for the `harfbuzz.paint_funcs_t` to paint a sweep
/// gradient everywhere within the current clip.
///
/// The `color_line` object contains information about the colors of the gradients.
/// It is only valid for the duration of the callback, you cannot keep it around.
///
/// The coordinates of the points are interpreted according
/// to the current transform.
///
/// See the OpenType spec [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
/// section for details on how the points define the direction
/// of the gradient, and how to interpret the `color_line`.
pub const paint_sweep_gradient_func_t = *const fn (p_funcs: *harfbuzz.paint_funcs_t, p_paint_data: ?*anyopaque, p_color_line: *harfbuzz.color_line_t, p_x0: f32, p_y0: f32, p_start_angle: f32, p_end_angle: f32, p_user_data: ?*anyopaque) callconv(.c) void;

/// Callback function for `harfbuzz.faceCreateForTables`. The `tag` is the tag of the
/// table to reference, and the special tag `HB_TAG_NONE` is used to reference the
/// blob of the face itself. If referencing the face blob is not possible, it is
/// recommended to set hb_get_table_tags_func_t on the `face` to allow
/// `harfbuzz.faceReferenceBlob` to create a face blob out of individual table blobs.
pub const reference_table_func_t = *const fn (p_face: *harfbuzz.face_t, p_tag: harfbuzz.tag_t, p_user_data: ?*anyopaque) callconv(.c) *harfbuzz.blob_t;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should retrieve the Canonical Combining Class (ccc)
/// property for a specified Unicode code point.
pub const unicode_combining_class_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.unicode_combining_class_t;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should compose a sequence of two input Unicode code
/// points by canonical equivalence, returning the composed code
/// point in a `harfbuzz.codepoint_t` output parameter (if successful).
/// The method must return an `harfbuzz.bool_t` indicating the success
/// of the composition.
pub const unicode_compose_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_a: harfbuzz.codepoint_t, p_b: harfbuzz.codepoint_t, p_ab: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// Fully decompose `u` to its Unicode compatibility decomposition. The codepoints of the decomposition will be written to `decomposed`.
/// The complete length of the decomposition will be returned.
///
/// If `u` has no compatibility decomposition, zero should be returned.
///
/// The Unicode standard guarantees that a buffer of length `HB_UNICODE_MAX_DECOMPOSITION_LEN` codepoints will always be sufficient for any
/// compatibility decomposition plus an terminating value of 0.  Consequently, `decompose` must be allocated by the caller to be at least this length.  Implementations
/// of this function type must ensure that they do not write past the provided array.
pub const unicode_decompose_compatibility_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_u: harfbuzz.codepoint_t, p_decomposed: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) c_uint;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should decompose an input Unicode code point,
/// returning the two decomposed code points in `harfbuzz.codepoint_t`
/// output parameters (if successful). The method must return an
/// `harfbuzz.bool_t` indicating the success of the composition.
pub const unicode_decompose_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_ab: harfbuzz.codepoint_t, p_a: *harfbuzz.codepoint_t, p_b: *harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.bool_t;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
pub const unicode_eastasian_width_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) c_uint;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should retrieve the General Category property for
/// a specified Unicode code point.
pub const unicode_general_category_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.unicode_general_category_t;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should retrieve the Bi-Directional Mirroring Glyph
/// code point for a specified Unicode code point.
///
/// <note>Note: If a code point does not have a specified
/// Bi-Directional Mirroring Glyph defined, the method should
/// return the original code point.</note>
pub const unicode_mirroring_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.codepoint_t;

/// A virtual method for the `harfbuzz.unicode_funcs_t` structure.
///
/// This method should retrieve the Script property for a
/// specified Unicode code point.
pub const unicode_script_func_t = *const fn (p_ufuncs: *harfbuzz.unicode_funcs_t, p_unicode: harfbuzz.codepoint_t, p_user_data: ?*anyopaque) callconv(.c) harfbuzz.script_t;

/// Used when getting or setting AAT feature selectors. Indicates that
/// there is no selector index corresponding to the selector of interest.
pub const AAT_LAYOUT_NO_SELECTOR_INDEX = 65535;
/// The default code point for replacing invalid characters in a given encoding.
/// Set to U+FFFD REPLACEMENT CHARACTER.
pub const BUFFER_REPLACEMENT_CODEPOINT_DEFAULT = 65533;
/// Unused `harfbuzz.codepoint_t` value.
pub const CODEPOINT_INVALID = 4294967295;
/// Special setting for `harfbuzz.feature_t.start` to apply the feature from the start
/// of the buffer.
pub const FEATURE_GLOBAL_START = 0;
/// Constant signifying that a font does not have any
/// named-instance index set.  This is the default of
/// a font.
pub const FONT_NO_VAR_NAMED_INSTANCE = 4294967295;
/// An unset `harfbuzz.language_t`.
pub const LANGUAGE_INVALID = 0;
/// Special value for language index indicating default or unsupported language.
pub const OT_LAYOUT_DEFAULT_LANGUAGE_INDEX = 65535;
/// Special value for feature index indicating unsupported feature.
pub const OT_LAYOUT_NO_FEATURE_INDEX = 65535;
/// Special value for script index indicating unsupported script.
pub const OT_LAYOUT_NO_SCRIPT_INDEX = 65535;
/// Special value for variations index indicating unsupported variation.
pub const OT_LAYOUT_NO_VARIATIONS_INDEX = 4294967295;
/// Maximum number of OpenType tags that can correspond to a give `harfbuzz.language_t`.
pub const OT_MAX_TAGS_PER_LANGUAGE = 3;
/// Maximum number of OpenType tags that can correspond to a give `harfbuzz.script_t`.
pub const OT_MAX_TAGS_PER_SCRIPT = 3;
/// Do not use.
pub const OT_VAR_NO_AXIS_INDEX = 4294967295;
/// [Tibetan]
pub const UNICODE_COMBINING_CLASS_CCC133 = 133;
/// Maximum valid Unicode code point.
pub const UNICODE_MAX = 1114111;
/// See Unicode 6.1 for details on the maximum decomposition length.
pub const UNICODE_MAX_DECOMPOSITION_LEN = 19;
pub const VERSION_MAJOR = 11;
pub const VERSION_MICRO = 1;
pub const VERSION_MINOR = 2;
pub const VERSION_STRING = "11.2.1";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
