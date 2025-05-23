pub const ext = @import("ext.zig");
const gegl = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
const babl = @import("babl0");
pub const AudioFragment = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gegl.AudioFragmentClass;
    f_parent_instance: gobject.Object,
    f_data: [8]*f32,
    f_priv: ?*gegl.AudioFragmentPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const string = struct {
            pub const name = "string";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn gegl_audio_fragment_new(p_sample_rate: c_int, p_channels: c_int, p_channel_layout: c_int, p_max_samples: c_int) *gegl.AudioFragment;
    pub const new = gegl_audio_fragment_new;

    extern fn gegl_audio_fragment_get_channel_layout(p_audio: *AudioFragment) c_int;
    pub const getChannelLayout = gegl_audio_fragment_get_channel_layout;

    extern fn gegl_audio_fragment_get_channels(p_audio: *AudioFragment) c_int;
    pub const getChannels = gegl_audio_fragment_get_channels;

    extern fn gegl_audio_fragment_get_max_samples(p_audio: *AudioFragment) c_int;
    pub const getMaxSamples = gegl_audio_fragment_get_max_samples;

    extern fn gegl_audio_fragment_get_pos(p_audio: *AudioFragment) c_int;
    pub const getPos = gegl_audio_fragment_get_pos;

    extern fn gegl_audio_fragment_get_sample_count(p_audio: *AudioFragment) c_int;
    pub const getSampleCount = gegl_audio_fragment_get_sample_count;

    extern fn gegl_audio_fragment_get_sample_rate(p_audio: *AudioFragment) c_int;
    pub const getSampleRate = gegl_audio_fragment_get_sample_rate;

    extern fn gegl_audio_fragment_set_channel_layout(p_audio: *AudioFragment, p_channel_layout: c_int) void;
    pub const setChannelLayout = gegl_audio_fragment_set_channel_layout;

    extern fn gegl_audio_fragment_set_channels(p_audio: *AudioFragment, p_channels: c_int) void;
    pub const setChannels = gegl_audio_fragment_set_channels;

    extern fn gegl_audio_fragment_set_max_samples(p_audio: *AudioFragment, p_max_samples: c_int) void;
    pub const setMaxSamples = gegl_audio_fragment_set_max_samples;

    extern fn gegl_audio_fragment_set_pos(p_audio: *AudioFragment, p_pos: c_int) void;
    pub const setPos = gegl_audio_fragment_set_pos;

    extern fn gegl_audio_fragment_set_sample_count(p_audio: *AudioFragment, p_sample_count: c_int) void;
    pub const setSampleCount = gegl_audio_fragment_set_sample_count;

    extern fn gegl_audio_fragment_set_sample_rate(p_audio: *AudioFragment, p_sample_rate: c_int) void;
    pub const setSampleRate = gegl_audio_fragment_set_sample_rate;

    extern fn gegl_audio_fragment_get_type() usize;
    pub const getGObjectType = gegl_audio_fragment_get_type;

    extern fn g_object_ref(p_self: *gegl.AudioFragment) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.AudioFragment) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AudioFragment, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Buffer = opaque {
    pub const Parent = gegl.TileHandler;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Buffer;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const abyss_height = struct {
            pub const name = "abyss-height";

            pub const Type = c_int;
        };

        pub const abyss_width = struct {
            pub const name = "abyss-width";

            pub const Type = c_int;
        };

        pub const abyss_x = struct {
            pub const name = "abyss-x";

            pub const Type = c_int;
        };

        pub const abyss_y = struct {
            pub const name = "abyss-y";

            pub const Type = c_int;
        };

        pub const backend = struct {
            pub const name = "backend";

            pub const Type = ?*gegl.TileBackend;
        };

        pub const format = struct {
            pub const name = "format";

            pub const Type = ?*anyopaque;
        };

        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        pub const initialized = struct {
            pub const name = "initialized";

            pub const Type = c_int;
        };

        pub const path = struct {
            pub const name = "path";

            pub const Type = ?[*:0]u8;
        };

        pub const pixels = struct {
            pub const name = "pixels";

            pub const Type = c_int;
        };

        pub const px_size = struct {
            pub const name = "px-size";

            pub const Type = c_int;
        };

        pub const shift_x = struct {
            pub const name = "shift-x";

            pub const Type = c_int;
        };

        pub const shift_y = struct {
            pub const name = "shift-y";

            pub const Type = c_int;
        };

        pub const tile_height = struct {
            pub const name = "tile-height";

            pub const Type = c_int;
        };

        pub const tile_width = struct {
            pub const name = "tile-width";

            pub const Type = c_int;
        };

        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };

        pub const x = struct {
            pub const name = "x";

            pub const Type = c_int;
        };

        pub const y = struct {
            pub const name = "y";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gegl.Rectangle, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Buffer, p_instance))),
                    gobject.signalLookup("changed", Buffer.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Loads an existing GeglBuffer from disk, if it has previously been saved with
    /// gegl_buffer_save it should be possible to open through any GIO transport, buffers
    /// that have been used as swap needs random access to be opened.
    extern fn gegl_buffer_load(p_path: [*:0]const u8) *gegl.Buffer;
    pub const load = gegl_buffer_load;

    /// Open an existing on-disk GeglBuffer, this buffer is opened in a monitored
    /// state so multiple instances of gegl can share the same buffer. Sets on
    /// one buffer are reflected in the other.
    extern fn gegl_buffer_open(p_path: [*:0]const u8) *gegl.Buffer;
    pub const open = gegl_buffer_open;

    /// Generates a unique filename in the GEGL swap directory, suitable for
    /// using as swap space.  When the file is no longer needed, it may be
    /// removed with `gegl.Buffer.swapRemoveFile`; otherwise, it will be
    /// removed when `gegl.exit` is called.
    extern fn gegl_buffer_swap_create_file(p_suffix: ?[*:0]const u8) ?[*:0]u8;
    pub const swapCreateFile = gegl_buffer_swap_create_file;

    /// Tests if `path` is a swap file, that is, if it has been created
    /// with `gegl.Buffer.swapCreateFile`, and hasn't been removed
    /// yet.
    extern fn gegl_buffer_swap_has_file(p_path: [*:0]const u8) c_int;
    pub const swapHasFile = gegl_buffer_swap_has_file;

    /// Removes a swap file, generated using `gegl.Buffer.swapCreateFile`,
    /// unlinking the file, if exists.
    extern fn gegl_buffer_swap_remove_file(p_path: [*:0]const u8) void;
    pub const swapRemoveFile = gegl_buffer_swap_remove_file;

    /// Create a new GeglBuffer with the given format and dimensions.
    extern fn gegl_buffer_introspectable_new(p_format_name: [*:0]const u8, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) *gegl.Buffer;
    pub const introspectableNew = gegl_buffer_introspectable_new;

    /// Creates a GeglBuffer backed by a linear memory buffer, of the given
    /// `extent` in the specified `format`. babl_format ("R'G'B'A u8") for instance
    /// to make a normal 8bit buffer.
    extern fn gegl_buffer_linear_new(p_extent: *const gegl.Rectangle, p_format: *const babl.Object) *gegl.Buffer;
    pub const linearNew = gegl_buffer_linear_new;

    /// Creates a GeglBuffer backed by a linear memory buffer that already exists,
    /// of the given `extent` in the specified `format`. babl_format ("R'G'B'A u8")
    /// for instance to make a normal 8bit buffer.
    extern fn gegl_buffer_linear_new_from_data(p_data: ?*anyopaque, p_format: *const babl.Object, p_extent: *const gegl.Rectangle, p_rowstride: c_int, p_destroy_fn: glib.DestroyNotify, p_destroy_fn_data: ?*anyopaque) *gegl.Buffer;
    pub const linearNewFromData = gegl_buffer_linear_new_from_data;

    /// Create a new GeglBuffer of a given format with a given extent. It is
    /// possible to pass in NULL for both extent and format, a NULL extent creates
    /// an empty buffer and a NULL format makes the buffer default to "RGBA float".
    extern fn gegl_buffer_new(p_extent: *const gegl.Rectangle, p_format: *const babl.Object) *gegl.Buffer;
    pub const new = gegl_buffer_new;

    /// Create a new GeglBuffer from a backend, if NULL is passed in the extent of
    /// the buffer will be inherited from the extent of the backend.
    ///
    /// returns a GeglBuffer, that holds a reference to the provided backend.
    extern fn gegl_buffer_new_for_backend(p_extent: *const gegl.Rectangle, p_backend: *gegl.TileBackend) *gegl.Buffer;
    pub const newForBackend = gegl_buffer_new_for_backend;

    /// Add a new tile handler in the existing chain of tile handler of a GeglBuffer.
    extern fn gegl_buffer_add_handler(p_buffer: *Buffer, p_handler: ?*anyopaque) void;
    pub const addHandler = gegl_buffer_add_handler;

    /// Clears the provided rectangular region by setting all the associated memory
    /// to 0.
    extern fn gegl_buffer_clear(p_buffer: *Buffer, p_roi: *const gegl.Rectangle) void;
    pub const clear = gegl_buffer_clear;

    /// Copy a region from source buffer to destination buffer.
    ///
    /// If the babl_formats of the buffers are the same, and the tile boundaries
    /// align, this will create copy-on-write tiles in the destination buffer.
    ///
    /// This function never does any scaling. When src_rect and dst_rect do not have
    /// the same width and height, the size of src_rect is used.
    extern fn gegl_buffer_copy(p_src: *Buffer, p_src_rect: *const gegl.Rectangle, p_repeat_mode: gegl.AbyssPolicy, p_dst: *gegl.Buffer, p_dst_rect: *const gegl.Rectangle) void;
    pub const copy = gegl_buffer_copy;

    /// Create a new sub GeglBuffer, that is a view on a larger buffer.
    extern fn gegl_buffer_create_sub_buffer(p_buffer: *Buffer, p_extent: *const gegl.Rectangle) *gegl.Buffer;
    pub const createSubBuffer = gegl_buffer_create_sub_buffer;

    /// Duplicate a buffer (internally uses gegl_buffer_copy). Aligned tiles
    /// will create copy-on-write clones in the new buffer.
    extern fn gegl_buffer_dup(p_buffer: *Buffer) *gegl.Buffer;
    pub const dup = gegl_buffer_dup;

    /// Flushes all unsaved data to disk, this is not necessary for shared
    /// geglbuffers opened with gegl_buffer_open since they auto-sync on writes.
    extern fn gegl_buffer_flush(p_buffer: *Buffer) void;
    pub const flush = gegl_buffer_flush;

    /// Invokes the external flush function, if any is set on the provided buffer -
    /// this ensures that data pending - in the current implementation only OpenCL -
    /// externally to be synchronized with the buffer. Multi threaded code should
    /// call such a synchronization before branching out to avoid each of the
    /// threads having an implicit synchronization of its own.
    extern fn gegl_buffer_flush_ext(p_buffer: *Buffer, p_rect: *const gegl.Rectangle) void;
    pub const flushExt = gegl_buffer_flush_ext;

    /// Blocks emission of the "changed" signal for `buffer`.
    ///
    /// While the signal is blocked, changes to `buffer` are accumulated, and will
    /// be emitted once the signal is unblocked, using `gegl.Buffer.thawChanged`.
    extern fn gegl_buffer_freeze_changed(p_buffer: *Buffer) void;
    pub const freezeChanged = gegl_buffer_freeze_changed;

    /// Fetch a rectangular linear buffer of pixel data from the GeglBuffer, the
    /// data is converted to the desired BablFormat, if the BablFormat stored and
    /// fetched is the same this amounts to a series of memcpy's aligned to demux
    /// the tile structure into a linear buffer.
    extern fn gegl_buffer_get(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_scale: f64, p_format: *const babl.Object, p_dest: ?*anyopaque, p_rowstride: c_int, p_repeat_mode: gegl.AbyssPolicy) void;
    pub const get = gegl_buffer_get;

    /// Return the abyss extent of a buffer, this expands out to the parents extent in
    /// subbuffers.
    extern fn gegl_buffer_get_abyss(p_buffer: *Buffer) *const gegl.Rectangle;
    pub const getAbyss = gegl_buffer_get_abyss;

    /// Returns a pointer to a GeglRectangle structure defining the geometry of a
    /// specific GeglBuffer, this is also the default width/height of buffers passed
    /// in to gegl_buffer_set and gegl_buffer_get (with a scale of 1.0 at least).
    extern fn gegl_buffer_get_extent(p_buffer: *Buffer) *const gegl.Rectangle;
    pub const getExtent = gegl_buffer_get_extent;

    /// Get the babl format of the buffer, this might not be the format the buffer
    /// was originally created with, you need to use gegl_buffer_set_format (buf,
    /// NULL); to retrieve the original format (potentially having saved away the
    /// original format of the buffer to re-set it.)
    extern fn gegl_buffer_get_format(p_buffer: *Buffer) *const babl.Object;
    pub const getFormat = gegl_buffer_get_format;

    extern fn gegl_buffer_get_tile(p_buffer: *Buffer, p_x: c_int, p_y: c_int, p_z: c_int) *gegl.Tile;
    pub const getTile = gegl_buffer_get_tile;

    /// Fetch a rectangular linear buffer of pixel data from the GeglBuffer.
    extern fn gegl_buffer_introspectable_get(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_scale: f64, p_format_name: ?[*:0]const u8, p_repeat_mode: gegl.AbyssPolicy, p_data_length: *c_uint) [*]u8;
    pub const introspectableGet = gegl_buffer_introspectable_get;

    /// Store a linear raster buffer into the GeglBuffer.
    extern fn gegl_buffer_introspectable_set(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_format_name: [*:0]const u8, p_src: [*]const u8, p_src_length: c_int) void;
    pub const introspectableSet = gegl_buffer_introspectable_set;

    /// Create a new buffer iterator, this buffer will be iterated through
    /// in linear chunks, some chunks might be full tiles the coordinates, see
    /// the documentation of gegl_buffer_iterator_next for how to use it and
    /// destroy it.
    extern fn gegl_buffer_iterator_new(p_buffer: *Buffer, p_roi: *const gegl.Rectangle, p_level: c_int, p_format: *const babl.Object, p_access_mode: gegl.AccessMode, p_abyss_policy: gegl.AbyssPolicy, p_max_slots: c_int) *gegl.BufferIterator;
    pub const iteratorNew = gegl_buffer_iterator_new;

    /// This function makes sure GeglBuffer and underlying code is aware of changes
    /// being made to the linear buffer. If the request was not a compatible one
    /// it is written back to the buffer. Multiple concurrent users can be handed
    /// the same buffer (both raw access and converted).
    extern fn gegl_buffer_linear_close(p_buffer: *Buffer, p_linear: ?*anyopaque) void;
    pub const linearClose = gegl_buffer_linear_close;

    /// Raw direct random access to the full data of a buffer in linear memory.
    extern fn gegl_buffer_linear_open(p_buffer: *Buffer, p_extent: ?*const gegl.Rectangle, p_rowstride: ?*c_int, p_format: ?*const babl.Object) ?*anyopaque;
    pub const linearOpen = gegl_buffer_linear_open;

    /// Remove the provided tile handler in the existing chain of tile handler of a GeglBuffer.
    extern fn gegl_buffer_remove_handler(p_buffer: *Buffer, p_handler: ?*anyopaque) void;
    pub const removeHandler = gegl_buffer_remove_handler;

    /// Query interpolate pixel values at a given coordinate using a specified form
    /// of interpolation.
    ///
    /// If you intend to take multiple samples, consider using
    /// `gegl.Buffer.samplerNew` to create a sampler object instead, which is more
    /// efficient.
    extern fn gegl_buffer_sample(p_buffer: *Buffer, p_x: f64, p_y: f64, p_scale: *gegl.BufferMatrix2, p_dest: ?*anyopaque, p_format: *const babl.Object, p_sampler_type: gegl.SamplerType, p_repeat_mode: gegl.AbyssPolicy) void;
    pub const sample = gegl_buffer_sample;

    /// Query interpolate pixel values at a given coordinate using a specified form
    /// of interpolation.
    ///
    /// If you intend to take multiple samples, consider using
    /// `gegl.Buffer.samplerNewAtLevel` to create a sampler object instead, which
    /// is more efficient.
    extern fn gegl_buffer_sample_at_level(p_buffer: *Buffer, p_x: f64, p_y: f64, p_scale: *gegl.BufferMatrix2, p_dest: ?*anyopaque, p_format: *const babl.Object, p_level: c_int, p_sampler_type: gegl.SamplerType, p_repeat_mode: gegl.AbyssPolicy) void;
    pub const sampleAtLevel = gegl_buffer_sample_at_level;

    /// Clean up resources used by sampling framework of buffer.
    extern fn gegl_buffer_sample_cleanup(p_buffer: *Buffer) void;
    pub const sampleCleanup = gegl_buffer_sample_cleanup;

    /// Create a new sampler, when you are done with the sampler, g_object_unref
    /// it.
    ///
    /// Samplers only hold weak references to buffers, so if its buffer is freed
    /// the sampler will become invalid.
    extern fn gegl_buffer_sampler_new(p_buffer: *Buffer, p_format: *const babl.Object, p_sampler_type: gegl.SamplerType) *gegl.Sampler;
    pub const samplerNew = gegl_buffer_sampler_new;

    /// Create a new sampler, when you are done with the sampler, g_object_unref
    /// it.
    ///
    /// Samplers only hold weak references to buffers, so if its buffer is freed
    /// the sampler will become invalid.
    extern fn gegl_buffer_sampler_new_at_level(p_buffer: *Buffer, p_format: *const babl.Object, p_sampler_type: gegl.SamplerType, p_level: c_int) *gegl.Sampler;
    pub const samplerNewAtLevel = gegl_buffer_sampler_new_at_level;

    /// Write a GeglBuffer to a file.
    extern fn gegl_buffer_save(p_buffer: *Buffer, p_path: [*:0]const u8, p_roi: *const gegl.Rectangle) void;
    pub const save = gegl_buffer_save;

    /// Store a linear raster buffer into the GeglBuffer.
    extern fn gegl_buffer_set(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_mipmap_level: c_int, p_format: *const babl.Object, p_src: ?*anyopaque, p_rowstride: c_int) void;
    pub const set = gegl_buffer_set;

    /// Changes the size and position of the abyss rectangle of a buffer.
    ///
    /// Returns TRUE if the change of abyss was successful.
    extern fn gegl_buffer_set_abyss(p_buffer: *Buffer, p_abyss: *const gegl.Rectangle) c_int;
    pub const setAbyss = gegl_buffer_set_abyss;

    /// Sets the region covered by rect to the specified color.
    extern fn gegl_buffer_set_color(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_color: *gegl.Color) void;
    pub const setColor = gegl_buffer_set_color;

    /// Sets the region covered by rect to the the provided pixel.
    extern fn gegl_buffer_set_color_from_pixel(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_pixel: ?*const anyopaque, p_pixel_format: *const babl.Object) void;
    pub const setColorFromPixel = gegl_buffer_set_color_from_pixel;

    /// Changes the size and position that is considered active in a buffer, this
    /// operation is valid on any buffer, reads on subbuffers outside the master
    /// buffer's extent are at the moment undefined.
    ///
    /// Returns TRUE if the change of extent was successful.
    extern fn gegl_buffer_set_extent(p_buffer: *Buffer, p_extent: *const gegl.Rectangle) c_int;
    pub const setExtent = gegl_buffer_set_extent;

    /// Set the babl format of the buffer, setting the babl format of the buffer
    /// requires the new format to have exactly the same bytes per pixel as the
    /// original format. If NULL is passed in the format of the buffer is reset to
    /// the original format.
    extern fn gegl_buffer_set_format(p_buffer: *Buffer, p_format: *const babl.Object) *const babl.Object;
    pub const setFormat = gegl_buffer_set_format;

    /// Fill a region with a repeating pattern. Offsets parameters are
    /// relative to the origin (0, 0) and not to the rectangle. So be carefull
    /// about the origin of `pattern` and `buffer` extents.
    extern fn gegl_buffer_set_pattern(p_buffer: *Buffer, p_rect: *const gegl.Rectangle, p_pattern: *gegl.Buffer, p_x_offset: c_int, p_y_offset: c_int) void;
    pub const setPattern = gegl_buffer_set_pattern;

    /// Checks if a pair of buffers share the same underlying tile storage.
    ///
    /// Returns TRUE if `buffer1` and `buffer2` share the same storage.
    extern fn gegl_buffer_share_storage(p_buffer1: *Buffer, p_buffer2: *gegl.Buffer) c_int;
    pub const shareStorage = gegl_buffer_share_storage;

    /// This function should be used instead of g_signal_connect when connecting to
    /// the GeglBuffer::changed signal handler, GeglBuffer contains additional
    /// machinery to avoid the overhead of changes when no signal handler have been
    /// connected, if regular g_signal_connect is used; then no signals will be
    /// emitted.
    extern fn gegl_buffer_signal_connect(p_buffer: *Buffer, p_detailed_signal: [*:0]const u8, p_c_handler: gobject.Callback, p_data: ?*anyopaque) c_long;
    pub const signalConnect = gegl_buffer_signal_connect;

    /// Unblocks emission of the "changed" signal for `buffer`.
    ///
    /// Once all calls to `gegl.Buffer.freezeChanged` are matched by corresponding
    /// calls to `gegl.Buffer.freezeChanged`, all accumulated changes are emitted.
    extern fn gegl_buffer_thaw_changed(p_buffer: *Buffer) void;
    pub const thawChanged = gegl_buffer_thaw_changed;

    extern fn gegl_buffer_get_type() usize;
    pub const getGObjectType = gegl_buffer_get_type;

    extern fn g_object_ref(p_self: *gegl.Buffer) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Buffer) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Buffer, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Color = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gegl.ColorClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*gegl.ColorPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const string = struct {
            pub const name = "string";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gegl.Color`.
    ///
    /// Returns the newly created `gegl.Color`.
    extern fn gegl_color_new(p_string: [*:0]const u8) *gegl.Color;
    pub const new = gegl_color_new;

    /// Creates a copy of `color`.
    extern fn gegl_color_duplicate(p_color: *Color) *gegl.Color;
    pub const duplicate = gegl_color_duplicate;

    extern fn gegl_color_get_bytes(p_color: *Color, p_format: *const babl.Object) *glib.Bytes;
    pub const getBytes = gegl_color_get_bytes;

    /// Retrieves the current set color stored as `space`.
    /// If `space` is `NULL`, this is equivalent to requesting color in the default
    /// naive CMYK space.
    extern fn gegl_color_get_cmyk(p_color: *Color, p_cyan: *f64, p_magenta: *f64, p_yellow: *f64, p_key: *f64, p_alpha: *f64, p_space: ?*const babl.Object) void;
    pub const getCmyk = gegl_color_get_cmyk;

    /// Get the component values of the color in `format`.
    extern fn gegl_color_get_components(p_color: *Color, p_format: *gobject.Value, p_components_length: *c_int) [*]f64;
    pub const getComponents = gegl_color_get_components;

    extern fn gegl_color_get_format(p_color: *Color) *const babl.Object;
    pub const getFormat = gegl_color_get_format;

    /// Retrieves the current set color stored as `space`.
    /// If `space` is `NULL`, this is equivalent to requesting color in the default
    /// sRGB space.
    extern fn gegl_color_get_hsla(p_color: *Color, p_hue: *f64, p_saturation: *f64, p_lightness: *f64, p_alpha: *f64, p_space: ?*const babl.Object) void;
    pub const getHsla = gegl_color_get_hsla;

    /// Retrieves the current set color stored as `space`.
    /// If `space` is `NULL`, this is equivalent to requesting color in the default
    /// sRGB space.
    extern fn gegl_color_get_hsva(p_color: *Color, p_hue: *f64, p_saturation: *f64, p_value: *f64, p_alpha: *f64, p_space: ?*const babl.Object) void;
    pub const getHsva = gegl_color_get_hsva;

    /// Store the color in a pixel in the given format.
    extern fn gegl_color_get_pixel(p_color: *Color, p_format: *const babl.Object, p_pixel: ?*anyopaque) void;
    pub const getPixel = gegl_color_get_pixel;

    /// Retrieves the current set color as linear light non premultipled RGBA data,
    /// any of the return pointers can be omitted.
    extern fn gegl_color_get_rgba(p_color: *Color, p_red: *f64, p_green: *f64, p_blue: *f64, p_alpha: *f64) void;
    pub const getRgba = gegl_color_get_rgba;

    /// Retrieves the current set color stored as `space`.
    /// If `space` is `NULL`, this is equivalent to requesting color in sRGB.
    extern fn gegl_color_get_rgba_with_space(p_color: *Color, p_red: *f64, p_green: *f64, p_blue: *f64, p_alpha: *f64, p_space: *const babl.Object) void;
    pub const getRgbaWithSpace = gegl_color_get_rgba_with_space;

    /// Set a GeglColor from a pixel stored in a `glib.Bytes` and it's babl format.
    extern fn gegl_color_set_bytes(p_color: *Color, p_format: *const babl.Object, p_bytes: *glib.Bytes) void;
    pub const setBytes = gegl_color_set_bytes;

    /// Set color as CMYK data stored as `space`. If `space` is `NULL`, this is
    /// equivalent to storing with the default naive CMYK space.
    extern fn gegl_color_set_cmyk(p_color: *Color, p_cyan: f64, p_magenta: f64, p_yellow: f64, p_key: f64, p_alpha: f64, p_space: ?*const babl.Object) void;
    pub const setCmyk = gegl_color_set_cmyk;

    /// Set the color using the component values as `format`.
    extern fn gegl_color_set_components(p_color: *Color, p_format: *gobject.Value, p_components: [*]f64, p_components_length: c_int) void;
    pub const setComponents = gegl_color_set_components;

    /// Set color as HSLA data stored as `space`. If `space` is `NULL`, this is
    /// equivalent to storing with the default sRGB space.
    extern fn gegl_color_set_hsla(p_color: *Color, p_hue: f64, p_saturation: f64, p_lightness: f64, p_alpha: f64, p_space: ?*const babl.Object) void;
    pub const setHsla = gegl_color_set_hsla;

    /// Set color as HSVA data stored as `space`. If `space` is `NULL`, this is
    /// equivalent to storing with the default sRGB space.
    extern fn gegl_color_set_hsva(p_color: *Color, p_hue: f64, p_saturation: f64, p_value: f64, p_alpha: f64, p_space: ?*const babl.Object) void;
    pub const setHsva = gegl_color_set_hsva;

    /// Set a GeglColor from a pointer to a pixel and it's babl format.
    extern fn gegl_color_set_pixel(p_color: *Color, p_format: *const babl.Object, p_pixel: *anyopaque) void;
    pub const setPixel = gegl_color_set_pixel;

    /// Set color as linear light non premultipled RGBA data
    extern fn gegl_color_set_rgba(p_color: *Color, p_red: f64, p_green: f64, p_blue: f64, p_alpha: f64) void;
    pub const setRgba = gegl_color_set_rgba;

    /// Set color as RGBA data stored as `space`. If `space` is `NULL`, this is
    /// equivalent to storing as sRGB.
    extern fn gegl_color_set_rgba_with_space(p_color: *Color, p_red: f64, p_green: f64, p_blue: f64, p_alpha: f64, p_space: *const babl.Object) void;
    pub const setRgbaWithSpace = gegl_color_set_rgba_with_space;

    extern fn gegl_color_get_type() usize;
    pub const getGObjectType = gegl_color_get_type;

    extern fn g_object_ref(p_self: *gegl.Color) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Color) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Color, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Config = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Config;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const application_license = struct {
            pub const name = "application-license";

            pub const Type = ?[*:0]u8;
        };

        pub const chunk_size = struct {
            pub const name = "chunk-size";

            pub const Type = c_int;
        };

        pub const mipmap_rendering = struct {
            pub const name = "mipmap-rendering";

            pub const Type = c_int;
        };

        pub const quality = struct {
            pub const name = "quality";

            pub const Type = f64;
        };

        pub const queue_size = struct {
            pub const name = "queue-size";

            pub const Type = c_int;
        };

        pub const swap = struct {
            pub const name = "swap";

            pub const Type = ?[*:0]u8;
        };

        pub const swap_compression = struct {
            pub const name = "swap-compression";

            pub const Type = ?[*:0]u8;
        };

        pub const threads = struct {
            pub const name = "threads";

            pub const Type = c_int;
        };

        pub const tile_cache_size = struct {
            pub const name = "tile-cache-size";

            pub const Type = u64;
        };

        pub const tile_height = struct {
            pub const name = "tile-height";

            pub const Type = c_int;
        };

        pub const tile_width = struct {
            pub const name = "tile-width";

            pub const Type = c_int;
        };

        pub const use_opencl = struct {
            pub const name = "use-opencl";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gegl_config_get_type() usize;
    pub const getGObjectType = gegl_config_get_type;

    extern fn g_object_ref(p_self: *gegl.Config) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Config) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Config, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Curve = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gegl.CurveClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a `gegl.Curve` that can store a curve with values between `y_min` and
    /// `y_max`.
    ///
    /// Returns the newly created `gegl.Curve`.
    extern fn gegl_curve_new(p_y_min: f64, p_y_max: f64) *gegl.Curve;
    pub const new = gegl_curve_new;

    /// Create a default `gegl.Curve` with an identify mapping of
    /// (0.0..1.0) -> (0.0..1.0).
    ///
    /// Returns the newly created default `gegl.Curve`.
    extern fn gegl_curve_new_default() *gegl.Curve;
    pub const newDefault = gegl_curve_new_default;

    /// Add a point to the curve at `x` `y` (replacing the value exactly for `x` if it
    /// already exists.
    extern fn gegl_curve_add_point(p_curve: *Curve, p_x: f64, p_y: f64) c_uint;
    pub const addPoint = gegl_curve_add_point;

    /// Retrieve the number of points in the curve.
    ///
    /// Returns the number of points for the coordinates in the curve.
    extern fn gegl_curve_calc_value(p_curve: *Curve, p_x: f64) f64;
    pub const calcValue = gegl_curve_calc_value;

    /// Compute a set (lookup table) of coordinates.
    extern fn gegl_curve_calc_values(p_curve: *Curve, p_x_min: f64, p_x_max: f64, p_num_samples: c_uint, p_xs: *f64, p_ys: *f64) void;
    pub const calcValues = gegl_curve_calc_values;

    /// Create a copy of `curve`.
    extern fn gegl_curve_duplicate(p_curve: *Curve) *gegl.Curve;
    pub const duplicate = gegl_curve_duplicate;

    /// Retrive the coordinates for an index.
    extern fn gegl_curve_get_point(p_curve: *Curve, p_index: c_uint, p_x: *f64, p_y: *f64) void;
    pub const getPoint = gegl_curve_get_point;

    /// Get the bounds on the values of the curve and store the values in
    /// the return locaitons provided in `min_y` and `max_y`.
    extern fn gegl_curve_get_y_bounds(p_curve: *Curve, p_min_y: *f64, p_max_y: *f64) void;
    pub const getYBounds = gegl_curve_get_y_bounds;

    /// Retrieve the number of points in the curve.
    ///
    /// Returns the number of points for the coordinates in the curve.
    extern fn gegl_curve_num_points(p_curve: *Curve) c_uint;
    pub const numPoints = gegl_curve_num_points;

    /// Replace an existing point in a curve.
    extern fn gegl_curve_set_point(p_curve: *Curve, p_index: c_uint, p_x: f64, p_y: f64) void;
    pub const setPoint = gegl_curve_set_point;

    extern fn gegl_curve_get_type() usize;
    pub const getGObjectType = gegl_curve_get_type;

    extern fn g_object_ref(p_self: *gegl.Curve) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Curve) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Curve, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataHash = opaque {
    pub const Parent = gegl.MetadataStore;
    pub const Implements = [_]type{gegl.Metadata};
    pub const Class = gegl.MetadataHashClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Create a new `gegl.MetadataHash`
    extern fn gegl_metadata_hash_new() *gegl.MetadataHash;
    pub const new = gegl_metadata_hash_new;

    extern fn gegl_metadata_hash_get_type() usize;
    pub const getGObjectType = gegl_metadata_hash_get_type;

    extern fn g_object_ref(p_self: *gegl.MetadataHash) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.MetadataHash) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MetadataHash, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataStore = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gegl.Metadata};
    pub const Class = gegl.MetadataStoreClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// The _declare virtual method creates a metadata variable in the
        /// underlying data store. It implements `gegl.MetadataStore.declare`. A
        /// `gobject.ParamSpec` is used to describe the variable.  If the metadata shadows an
        /// object property, shadow should be `TRUE`, otherwise `FALSE`.  It is acceptable
        /// for a subclass to provide additional variables which are implicitly
        /// declared, that is, they need not be declared using
        /// `gegl.MetadataStore.declare`, however the `pspec` method must still retrieve
        /// a `gobject.ParamSpec` describing such variables.  This method MUST be provided by
        /// the subclass.
        pub const _declare = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_shadow: c_int) void {
                return gobject.ext.as(MetadataStore.Class, p_class).f__declare.?(gobject.ext.as(MetadataStore, p_self), p_pspec, p_shadow);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_shadow: c_int) callconv(.c) void) void {
                gobject.ext.as(MetadataStore.Class, p_class).f__declare = @ptrCast(p_implementation);
            }
        };

        /// Return a pointer to a `gobject.Value` with the value of the metadata
        /// variable or `NULL` if not declared or the variable does not contain a valid
        /// value.  Implements `gegl.MetadataStore.getValue`.  This method MUST be
        /// provided by the subclass.
        pub const _get_value = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) *const gobject.Value {
                return gobject.ext.as(MetadataStore.Class, p_class).f__get_value.?(gobject.ext.as(MetadataStore, p_self), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) *const gobject.Value) void {
                gobject.ext.as(MetadataStore.Class, p_class).f__get_value = @ptrCast(p_implementation);
            }
        };

        /// This method is called to optionally generate a value to be
        /// written to and image file. If no generator is available it returns `FALSE`
        /// and the registered mapping is used. If a generator is available it should
        /// create a suitable value to be written to the image file and return `TRUE`.
        /// The default method checks if a signal handler is registered for the
        /// generate-value signal with the variable name as the detail parameter. If a
        /// handler is registered it emits the signal with an initialised `gobject.Value` to
        /// receive the file metadata and returns `TRUE` otherwise `FALSE`.  `parse_value`
        /// and `generate_value` are provided to handle the case where some file formats
        /// overload, for example, image comments. A typical case is formatting many
        /// values into a TIFF file's ImageDescription field.
        pub const generate_value = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *gobject.Value) c_int {
                return gobject.ext.as(MetadataStore.Class, p_class).f_generate_value.?(gobject.ext.as(MetadataStore, p_self), p_pspec, p_transform, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *gobject.Value) callconv(.c) c_int) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_generate_value = @ptrCast(p_implementation);
            }
        };

        /// Test whether the `gegl.MetadataStore` contains a value for the specified name.
        pub const has_value = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) c_int {
                return gobject.ext.as(MetadataStore.Class, p_class).f_has_value.?(gobject.ext.as(MetadataStore, p_self), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_has_value = @ptrCast(p_implementation);
            }
        };

        /// This method is called to optionally parse image file metadata
        /// prior to setting metadata variables in the `gegl.MetadataStore`. If no parser
        /// is available it returns `FALSE` and the registered mapping is used.  If a
        /// parser available it should set one or more metadata variables using
        /// `gegl.MetadataStore.setValue` and return `TRUE`. Note that the parser MUST
        /// return `TRUE` even if setting individual values fails.  The default method
        /// checks if a signal handler is registered for the parse-value signal with
        /// the variable name as the detail parameter. If a handler is registered it
        /// emits the signal with the file metadata provided as a `gobject.Value` and returns
        /// `TRUE` otherwise `FALSE`.
        pub const parse_value = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *const gobject.Value) c_int {
                return gobject.ext.as(MetadataStore.Class, p_class).f_parse_value.?(gobject.ext.as(MetadataStore, p_self), p_pspec, p_transform, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *const gobject.Value) callconv(.c) c_int) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_parse_value = @ptrCast(p_implementation);
            }
        };

        /// The pspec virtual method returns the `gobject.ParamSpec` used to declare a
        /// metadata variable. It is used to implement
        /// `gegl.MetadataStore.typeofValue`. This method MUST be provided by the
        /// subclass.
        pub const pspec = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) *gobject.ParamSpec {
                return gobject.ext.as(MetadataStore.Class, p_class).f_pspec.?(gobject.ext.as(MetadataStore, p_self), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) *gobject.ParamSpec) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_pspec = @ptrCast(p_implementation);
            }
        };

        /// This method is called after a file loader or saver registers
        /// a `gegl.MetadataMap` and before any further processing takes place.  It is
        /// intended to allow an application to create further application-specific
        /// mappings using `gegl.MetadataStore.register`.  `gegl.MetadataStore` provides
        /// a default method which emits the `::mapped` signal.
        pub const register_hook = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file_module_name: [*:0]const u8, p_flags: c_uint) void {
                return gobject.ext.as(MetadataStore.Class, p_class).f_register_hook.?(gobject.ext.as(MetadataStore, p_self), p_file_module_name, p_flags);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file_module_name: [*:0]const u8, p_flags: c_uint) callconv(.c) void) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_register_hook = @ptrCast(p_implementation);
            }
        };

        /// Set the specified metadata value. If `value` is `NULL` the default value from
        /// the associated `gobject.ParamSpec` is used. This operation will fail if the value
        /// has not been previously declared.  A `changed::name` signal is emitted when
        /// the value is set. If the value is shadowed by a property a `notify::name`
        /// signal is also emitted.
        pub const set_value = struct {
            pub fn call(p_class: anytype, p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: *const gobject.Value) void {
                return gobject.ext.as(MetadataStore.Class, p_class).f_set_value.?(gobject.ext.as(MetadataStore, p_self), p_name, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_self: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_value: *const gobject.Value) callconv(.c) void) void {
                gobject.ext.as(MetadataStore.Class, p_class).f_set_value = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Name of image creator.
        pub const artist = struct {
            pub const name = "artist";

            pub const Type = ?[*:0]u8;
        };

        /// Miscellaneous comment; conversion from GIF comment.
        pub const comment = struct {
            pub const name = "comment";

            pub const Type = ?[*:0]u8;
        };

        /// Copyright notice.
        pub const copyright = struct {
            pub const name = "copyright";

            pub const Type = ?[*:0]u8;
        };

        /// Description of image (possibly long).
        pub const description = struct {
            pub const name = "description";

            pub const Type = ?[*:0]u8;
        };

        /// Legal disclaimer.
        pub const disclaimer = struct {
            pub const name = "disclaimer";

            pub const Type = ?[*:0]u8;
        };

        /// Current file loader/saver module name. Valid only while a `gegl.Metadata`
        /// mapping is registered. This property is mainly provided for use in signal
        /// handlers.
        pub const file_module_name = struct {
            pub const name = "file-module-name";

            pub const Type = ?[*:0]u8;
        };

        /// A `gegl.ResolutionUnit` specifying units for the image resolution (density).
        pub const resolution_unit = struct {
            pub const name = "resolution-unit";

            pub const Type = gegl.ResolutionUnit;
        };

        /// X resolution or density in dots per unit.
        pub const resolution_x = struct {
            pub const name = "resolution-x";

            pub const Type = f64;
        };

        /// Y resolution or density in dots per unit.
        pub const resolution_y = struct {
            pub const name = "resolution-y";

            pub const Type = f64;
        };

        /// Software used to create the image.
        pub const software = struct {
            pub const name = "software";

            pub const Type = ?[*:0]u8;
        };

        /// Device used to create the image.
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?[*:0]u8;
        };

        /// Time of original image creation.
        pub const timestamp = struct {
            pub const name = "timestamp";

            pub const Type = ?*glib.DateTime;
        };

        /// Short (one line) title or caption for image.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Warning of nature of content.
        pub const warning = struct {
            pub const name = "warning";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// `::changed` is emitted when a metadata value is changed. This is analogous
        /// to the `GObject::notify` signal.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_pspec: *gobject.ParamSpec, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MetadataStore, p_instance))),
                    gobject.signalLookup("changed", MetadataStore.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// If a signal handler is connected to `::generate-value` a signal is emitted
        /// when the file module accesses a value using `gegl_metadata_get_value`.
        /// The signal handler must generate a value of the type specified in the pspec
        /// argument. The signal handler's return value indicates the success of the
        /// operation.
        ///
        /// If no handler is connected the mapped metadata value is accessed normally,
        pub const generate_value = struct {
            pub const name = "generate-value";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_pspec: *gobject.ParamSpec, p_value: *gobject.Value, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MetadataStore, p_instance))),
                    gobject.signalLookup("generate-value", MetadataStore.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// `::mapped` is emitted after a file module registers a mapping and before
        /// other processing takes place.  An application may respond to the signal by
        /// registering additional mappings or overriding existing values, for example
        /// it might override the TIFF ImageDescription tag to format multiple metadata
        /// values into the description.
        pub const mapped = struct {
            pub const name = "mapped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_file_module: [*:0]u8, p_exclude_unmapped: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MetadataStore, p_instance))),
                    gobject.signalLookup("mapped", MetadataStore.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// If a signal handler is connected to `::parse-value` a signal is emitted when
        /// the file module accesses a value using `gegl_metadata_set_value`.  The
        /// signal handler should parse the value supplied in the `gobject.Value` and may set
        /// any number of metadata values using `gegl.MetadataStore.setValue`.
        ///
        /// If no handler is connected the mapped metadata value is set normally,
        pub const parse_value = struct {
            pub const name = "parse-value";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_pspec: *gobject.ParamSpec, p_value: *gobject.Value, P_Data) callconv(.c) c_int, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MetadataStore, p_instance))),
                    gobject.signalLookup("parse-value", MetadataStore.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// `::unmapped` is emitted when a file module tries to look up an unmapped
        /// metadata name. When the handler returns a second attempt is made to look
        /// up the metadata.
        pub const unmapped = struct {
            pub const name = "unmapped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_file_module: [*:0]u8, p_local_name: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MetadataStore, p_instance))),
                    gobject.signalLookup("unmapped", MetadataStore.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Declare a metadata value using a `gobject.ParamSpec`.
    extern fn gegl_metadata_store_declare(p_self: *MetadataStore, p_pspec: *gobject.ParamSpec) void;
    pub const declare = gegl_metadata_store_declare;

    /// Get name of image creator.
    extern fn gegl_metadata_store_get_artist(p_self: *MetadataStore) [*:0]const u8;
    pub const getArtist = gegl_metadata_store_get_artist;

    /// Get the comment.
    extern fn gegl_metadata_store_get_comment(p_self: *MetadataStore) [*:0]const u8;
    pub const getComment = gegl_metadata_store_get_comment;

    /// Get the copyright notice.
    extern fn gegl_metadata_store_get_copyright(p_self: *MetadataStore) [*:0]const u8;
    pub const getCopyright = gegl_metadata_store_get_copyright;

    /// Get description of image.
    extern fn gegl_metadata_store_get_description(p_self: *MetadataStore) [*:0]const u8;
    pub const getDescription = gegl_metadata_store_get_description;

    /// Get the legal disclaimer.
    extern fn gegl_metadata_store_get_disclaimer(p_self: *MetadataStore) [*:0]const u8;
    pub const getDisclaimer = gegl_metadata_store_get_disclaimer;

    /// Return the name registered by the current file module.
    extern fn gegl_metadata_store_get_file_module_name(p_self: *MetadataStore) [*:0]const u8;
    pub const getFileModuleName = gegl_metadata_store_get_file_module_name;

    /// Get the units used for resolution.
    extern fn gegl_metadata_store_get_resolution_unit(p_self: *MetadataStore) gegl.ResolutionUnit;
    pub const getResolutionUnit = gegl_metadata_store_get_resolution_unit;

    /// Get the X resolution or density in dots per unit.
    extern fn gegl_metadata_store_get_resolution_x(p_self: *MetadataStore) f64;
    pub const getResolutionX = gegl_metadata_store_get_resolution_x;

    /// Get the Y resolution or density in dots per unit.
    extern fn gegl_metadata_store_get_resolution_y(p_self: *MetadataStore) f64;
    pub const getResolutionY = gegl_metadata_store_get_resolution_y;

    /// Get software used to create the image.
    extern fn gegl_metadata_store_get_software(p_self: *MetadataStore) [*:0]const u8;
    pub const getSoftware = gegl_metadata_store_get_software;

    /// Get device used to create the image.
    extern fn gegl_metadata_store_get_source(p_self: *MetadataStore) [*:0]const u8;
    pub const getSource = gegl_metadata_store_get_source;

    /// A slightly more efficient version of `gegl.MetadataStore.getValue`
    /// for string values avoiding a duplication. Otherwise it behaves the same
    /// `gegl.MetadataStore.getValue`.
    extern fn gegl_metadata_store_get_string(p_self: *MetadataStore, p_name: [*:0]const u8) [*:0]const u8;
    pub const getString = gegl_metadata_store_get_string;

    /// Get time of original image creation.
    extern fn gegl_metadata_store_get_timestamp(p_self: *MetadataStore) *glib.DateTime;
    pub const getTimestamp = gegl_metadata_store_get_timestamp;

    /// Get title or caption for image.
    extern fn gegl_metadata_store_get_title(p_self: *MetadataStore) [*:0]const u8;
    pub const getTitle = gegl_metadata_store_get_title;

    /// Retrieve the metadata value. `value` must be initialised with a compatible
    /// type. If the value is unset or has not been previously declared `value` is
    /// unchanged and an error message is logged.
    extern fn gegl_metadata_store_get_value(p_self: *MetadataStore, p_name: [*:0]const u8, p_value: *gobject.Value) void;
    pub const getValue = gegl_metadata_store_get_value;

    /// Get warning.
    extern fn gegl_metadata_store_get_warning(p_self: *MetadataStore) [*:0]const u8;
    pub const getWarning = gegl_metadata_store_get_warning;

    /// Test whether the `gegl.MetadataStore` contains a value for the specified name.
    extern fn gegl_metadata_store_has_value(p_self: *MetadataStore, p_name: [*:0]const u8) c_int;
    pub const hasValue = gegl_metadata_store_has_value;

    /// `gegl.MetadataStore.notify` is called by subclasses when the value of a
    /// metadata variable changes. It emits the `::changed` signal with the variable
    /// name as the detail parameter.  Set `shadow` = `TRUE` if variable is shadowed
    /// by a property so that a notify signal is emitted with the property name as
    /// the detail parameter.
    extern fn gegl_metadata_store_notify(p_self: *MetadataStore, p_pspec: *gobject.ParamSpec, p_shadow: c_int) void;
    pub const notify = gegl_metadata_store_notify;

    extern fn gegl_metadata_store_register(p_self: *MetadataStore, p_local_name: [*:0]const u8, p_name: [*:0]const u8, p_transform: gobject.ValueTransform) void;
    pub const register = gegl_metadata_store_register;

    /// Set name of image creator.
    extern fn gegl_metadata_store_set_artist(p_self: *MetadataStore, p_artist: [*:0]const u8) void;
    pub const setArtist = gegl_metadata_store_set_artist;

    /// Set the miscellaneous comment; conversion from GIF comment.
    extern fn gegl_metadata_store_set_comment(p_self: *MetadataStore, p_comment: [*:0]const u8) void;
    pub const setComment = gegl_metadata_store_set_comment;

    /// Set the copyright notice.
    extern fn gegl_metadata_store_set_copyright(p_self: *MetadataStore, p_copyright: [*:0]const u8) void;
    pub const setCopyright = gegl_metadata_store_set_copyright;

    /// Set description of image.
    extern fn gegl_metadata_store_set_description(p_self: *MetadataStore, p_description: [*:0]const u8) void;
    pub const setDescription = gegl_metadata_store_set_description;

    /// Set the legal disclaimer.
    extern fn gegl_metadata_store_set_disclaimer(p_self: *MetadataStore, p_disclaimer: [*:0]const u8) void;
    pub const setDisclaimer = gegl_metadata_store_set_disclaimer;

    /// Set the units used for the resolution (density) values.
    extern fn gegl_metadata_store_set_resolution_unit(p_self: *MetadataStore, p_unit: gegl.ResolutionUnit) void;
    pub const setResolutionUnit = gegl_metadata_store_set_resolution_unit;

    /// Set the X resolution or density in dots per unit.
    extern fn gegl_metadata_store_set_resolution_x(p_self: *MetadataStore, p_resolution_x: f64) void;
    pub const setResolutionX = gegl_metadata_store_set_resolution_x;

    /// Set the Y resolution or density in dots per unit.
    extern fn gegl_metadata_store_set_resolution_y(p_self: *MetadataStore, p_resolution_y: f64) void;
    pub const setResolutionY = gegl_metadata_store_set_resolution_y;

    /// Set software used to create the image.
    extern fn gegl_metadata_store_set_software(p_self: *MetadataStore, p_software: [*:0]const u8) void;
    pub const setSoftware = gegl_metadata_store_set_software;

    /// Set device used to create the image.
    extern fn gegl_metadata_store_set_source(p_self: *MetadataStore, p_source: [*:0]const u8) void;
    pub const setSource = gegl_metadata_store_set_source;

    /// A slightly more efficient version of `gegl.MetadataStore.setValue`
    /// for string values avoiding a duplication. Otherwise it behaves the same
    /// `gegl.MetadataStore.setValue`.
    extern fn gegl_metadata_store_set_string(p_self: *MetadataStore, p_name: [*:0]const u8, p_string: [*:0]const u8) void;
    pub const setString = gegl_metadata_store_set_string;

    /// Set time of original image creation.
    extern fn gegl_metadata_store_set_timestamp(p_self: *MetadataStore, p_timestamp: *const glib.DateTime) void;
    pub const setTimestamp = gegl_metadata_store_set_timestamp;

    /// Set title or caption for image.
    extern fn gegl_metadata_store_set_title(p_self: *MetadataStore, p_title: [*:0]const u8) void;
    pub const setTitle = gegl_metadata_store_set_title;

    /// Set the specified metadata value. If `value` is `NULL` the default value from
    /// the associated `gobject.ParamSpec` is used. This operation will fail if the value
    /// has not been previously declared.  A `changed::name` signal is emitted when
    /// the value is set. If the value is shadowed by a property a `notify::name`
    /// signal is also emitted.
    extern fn gegl_metadata_store_set_value(p_self: *MetadataStore, p_name: [*:0]const u8, p_value: *const gobject.Value) void;
    pub const setValue = gegl_metadata_store_set_value;

    /// Set the warning of nature of content.
    extern fn gegl_metadata_store_set_warning(p_self: *MetadataStore, p_warning: [*:0]const u8) void;
    pub const setWarning = gegl_metadata_store_set_warning;

    /// Get the declared type of the value in the `gegl.MetadataStore`.
    extern fn gegl_metadata_store_typeof_value(p_self: *MetadataStore, p_name: [*:0]const u8) usize;
    pub const typeofValue = gegl_metadata_store_typeof_value;

    extern fn gegl_metadata_store_get_type() usize;
    pub const getGObjectType = gegl_metadata_store_get_type;

    extern fn g_object_ref(p_self: *gegl.MetadataStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.MetadataStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MetadataStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Node = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Node;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const cache_policy = struct {
            pub const name = "cache-policy";

            pub const Type = gegl.CachePolicy;
        };

        pub const dont_cache = struct {
            pub const name = "dont-cache";

            pub const Type = c_int;
        };

        pub const gegl_operation = struct {
            pub const name = "gegl-operation";

            pub const Type = ?*gegl.Operation;
        };

        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        pub const operation = struct {
            pub const name = "operation";

            pub const Type = ?[*:0]u8;
        };

        pub const passthrough = struct {
            pub const name = "passthrough";

            pub const Type = c_int;
        };

        pub const use_opencl = struct {
            pub const name = "use-opencl";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const computed = struct {
            pub const name = "computed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gegl.Rectangle, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Node, p_instance))),
                    gobject.signalLookup("computed", Node.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const invalidated = struct {
            pub const name = "invalidated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gegl.Rectangle, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Node, p_instance))),
                    gobject.signalLookup("invalidated", Node.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const progress = struct {
            pub const name = "progress";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Node, p_instance))),
                    gobject.signalLookup("progress", Node.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new graph that can contain further processing nodes.
    extern fn gegl_node_new() *gegl.Node;
    pub const new = gegl_node_new;

    /// The `gegl.Node` returned contains the graph described by the tree of stacks
    /// in the XML document. The tree is connected to the "output" pad of the
    /// returned node and thus can be used directly for processing.
    extern fn gegl_node_new_from_file(p_path: [*:0]const u8) *gegl.Node;
    pub const newFromFile = gegl_node_new_from_file;

    extern fn gegl_node_new_from_serialized(p_chaindata: [*:0]const u8, p_path_root: [*:0]const u8) *gegl.Node;
    pub const newFromSerialized = gegl_node_new_from_serialized;

    /// The `gegl.Node` returned contains the graph described by the tree of stacks
    /// in the XML document. The tree is connected to the "output" pad of the
    /// returned node and thus can be used directly for processing.
    extern fn gegl_node_new_from_xml(p_xmldata: [*:0]const u8, p_path_root: [*:0]const u8) *gegl.Node;
    pub const newFromXml = gegl_node_new_from_xml;

    /// Make the GeglNode `graph`, take a reference on child. This reference
    /// will be dropped when the reference count on the graph reaches zero.
    extern fn gegl_node_add_child(p_graph: *Node, p_child: *gegl.Node) *gegl.Node;
    pub const addChild = gegl_node_add_child;

    /// Render a rectangular region from a node.
    extern fn gegl_node_blit(p_node: *Node, p_scale: f64, p_roi: *const gegl.Rectangle, p_format: *const babl.Object, p_destination_buf: ?*anyopaque, p_rowstride: c_int, p_flags: gegl.BlitFlags) void;
    pub const blit = gegl_node_blit;

    /// Render a rectangular region from a node to the given buffer.
    extern fn gegl_node_blit_buffer(p_node: *Node, p_buffer: ?*gegl.Buffer, p_roi: ?*const gegl.Rectangle, p_level: c_int, p_abyss_policy: gegl.AbyssPolicy) void;
    pub const blitBuffer = gegl_node_blit_buffer;

    /// Makes a connection between the pads of two nodes, one pad should
    /// be a source pad the other a sink pad, order does not matter.
    ///
    /// Returns TRUE if the connection was successfully made.
    extern fn gegl_node_connect(p_a: *Node, p_a_pad_name: [*:0]const u8, p_b: *gegl.Node, p_b_pad_name: [*:0]const u8) c_int;
    pub const connect = gegl_node_connect;

    /// Makes a connection between the pads of two nodes.
    ///
    /// Returns TRUE if the connection was successfully made.
    extern fn gegl_node_connect_from(p_sink: *Node, p_input_pad_name: [*:0]const u8, p_source: *gegl.Node, p_output_pad_name: [*:0]const u8) c_int;
    pub const connectFrom = gegl_node_connect_from;

    /// Makes a connection between the pads of two nodes.
    ///
    /// Returns TRUE if the connection was successfully made.
    extern fn gegl_node_connect_to(p_source: *Node, p_output_pad_name: [*:0]const u8, p_sink: *gegl.Node, p_input_pad_name: [*:0]const u8) c_int;
    pub const connectTo = gegl_node_connect_to;

    /// Creates a new processing node that performs the specified operation.
    /// All properties of the operation will have their default values. This
    /// is included as an addition to `gegl.Node.newChild` in the public API to have
    /// a non varargs entry point for bindings as well as sometimes simpler more
    /// readable code.
    extern fn gegl_node_create_child(p_parent: *Node, p_operation: [*:0]const u8) *gegl.Node;
    pub const createChild = gegl_node_create_child;

    /// Performs hit detection by returning the node providing data at a given
    /// coordinate pair. Currently operates only on bounding boxes and not
    /// pixel data.
    extern fn gegl_node_detect(p_node: *Node, p_x: c_int, p_y: c_int) *gegl.Node;
    pub const detect = gegl_node_detect;

    /// Disconnects node connected to `input_pad` of `node` (if any).
    ///
    /// Returns TRUE if a connection was broken.
    extern fn gegl_node_disconnect(p_node: *Node, p_input_pad: [*:0]const u8) c_int;
    pub const disconnect = gegl_node_disconnect;

    extern fn gegl_node_find_property(p_node: *Node, p_property_name: [*:0]const u8) *gobject.ParamSpec;
    pub const findProperty = gegl_node_find_property;

    /// Gets properties of a `gegl.Node`.
    /// ---
    /// double level;
    /// char  *path;
    ///
    /// gegl_node_get (png_save, "path", &path, NULL);
    /// gegl_node_get (threshold, "level", &level, NULL);
    extern fn gegl_node_get(p_node: *Node, p_first_property_name: [*:0]const u8, ...) void;
    pub const get = gegl_node_get;

    /// Returns the position and dimensions of a rectangle spanning the area
    /// defined by a node.
    extern fn gegl_node_get_bounding_box(p_node: *Node) gegl.Rectangle;
    pub const getBoundingBox = gegl_node_get_bounding_box;

    extern fn gegl_node_get_children(p_node: *Node) *glib.SList;
    pub const getChildren = gegl_node_get_children;

    /// Retrieve which pads on which nodes are connected to a named output_pad,
    /// and the number of connections. Both the location for the generated
    /// nodes array and pads array can be left as NULL. If they are non NULL
    /// both should be freed with g_free. The arrays are NULL terminated.
    ///
    /// Returns the number of consumers connected to this output_pad.
    extern fn gegl_node_get_consumers(p_node: *Node, p_output_pad: [*:0]const u8, p_nodes: ?*[*]*gegl.Node, p_pads: ?*[*][*:0]const u8) c_int;
    pub const getConsumers = gegl_node_get_consumers;

    extern fn gegl_node_get_gegl_operation(p_node: *Node) ?*gegl.Operation;
    pub const getGeglOperation = gegl_node_get_gegl_operation;

    /// Proxies are used to route between nodes of a subgraph contained within
    /// a node.
    extern fn gegl_node_get_input_proxy(p_node: *Node, p_pad_name: [*:0]const u8) *gegl.Node;
    pub const getInputProxy = gegl_node_get_input_proxy;

    extern fn gegl_node_get_operation(p_node: *const Node) [*:0]const u8;
    pub const getOperation = gegl_node_get_operation;

    /// Proxies are used to route between nodes of a subgraph contained within
    /// a node.
    extern fn gegl_node_get_output_proxy(p_node: *Node, p_pad_name: [*:0]const u8) *gegl.Node;
    pub const getOutputProxy = gegl_node_get_output_proxy;

    extern fn gegl_node_get_pad_description(p_node: *Node, p_pad_name: [*:0]const u8) [*:0]const u8;
    pub const getPadDescription = gegl_node_get_pad_description;

    extern fn gegl_node_get_pad_label(p_node: *Node, p_pad_name: [*:0]const u8) [*:0]const u8;
    pub const getPadLabel = gegl_node_get_pad_label;

    /// Returns a GeglNode that keeps a reference on a child.
    extern fn gegl_node_get_parent(p_node: *Node) *gegl.Node;
    pub const getParent = gegl_node_get_parent;

    extern fn gegl_node_get_passthrough(p_node: *Node) c_int;
    pub const getPassthrough = gegl_node_get_passthrough;

    extern fn gegl_node_get_producer(p_node: *Node, p_input_pad_name: [*:0]const u8, p_output_pad_name: ?*[*:0]u8) *gegl.Node;
    pub const getProducer = gegl_node_get_producer;

    /// This is mainly included for language bindings. Using `gegl.Node.get` is
    /// more convenient when programming in C.
    extern fn gegl_node_get_property(p_node: *Node, p_property_name: [*:0]const u8, p_value: *gobject.Value) void;
    pub const getProperty = gegl_node_get_property;

    /// valist version of `gegl.Node.get`
    extern fn gegl_node_get_valist(p_node: *Node, p_first_property_name: [*:0]const u8, p_args: std.builtin.VaList) void;
    pub const getValist = gegl_node_get_valist;

    /// Returns TRUE if the node has a pad with the specified name
    extern fn gegl_node_has_pad(p_node: *Node, p_pad_name: [*:0]const u8) c_int;
    pub const hasPad = gegl_node_has_pad;

    /// Returns the position and dimensions of a rectangle spanning the area
    /// defined by a node.
    extern fn gegl_node_introspectable_get_bounding_box(p_node: *Node) *gegl.Rectangle;
    pub const introspectableGetBoundingBox = gegl_node_introspectable_get_bounding_box;

    extern fn gegl_node_introspectable_get_property(p_node: *Node, p_property_name: [*:0]const u8) *gobject.Value;
    pub const introspectableGetProperty = gegl_node_introspectable_get_property;

    extern fn gegl_node_is_graph(p_node: *Node) c_int;
    pub const isGraph = gegl_node_is_graph;

    /// This is equivalent to gegl_node_connect (source, "output", sink, "input");
    extern fn gegl_node_link(p_source: *Node, p_sink: *gegl.Node) void;
    pub const link = gegl_node_link;

    /// Synthetic sugar for linking a chain of nodes with "output"->"input". The
    /// list is NULL terminated.
    extern fn gegl_node_link_many(p_source: *Node, p_first_sink: *gegl.Node, ...) void;
    pub const linkMany = gegl_node_link_many;

    /// If the node has any input pads this function returns a null terminated
    /// array of pad names, otherwise it returns NULL. The return value can be
    /// freed with `glib.strfreev`.
    extern fn gegl_node_list_input_pads(p_node: *Node) [*][*:0]u8;
    pub const listInputPads = gegl_node_list_input_pads;

    /// If the node has any output pads this function returns a null terminated
    /// array of pad names, otherwise it returns NULL. The return value can be
    /// freed with `glib.strfreev`.
    extern fn gegl_node_list_output_pads(p_node: *Node) [*][*:0]u8;
    pub const listOutputPads = gegl_node_list_output_pads;

    /// Creates a new processing node that performs the specified operation with
    /// a NULL terminated list of key/value pairs for initial parameter values
    /// configuring the operation. Usually the first pair should be "operation"
    /// and the type of operation to be associated. If no operation is provided
    /// the node doesn't have an initial operation and can be used to construct
    /// a subgraph with special middle-man routing nodes created with
    /// `gegl.Node.getOutputProxy` and `gegl.Node.getInputProxy`.
    extern fn gegl_node_new_child(p_parent: *Node, p_first_property_name: [*:0]const u8, ...) *gegl.Node;
    pub const newChild = gegl_node_new_child;

    extern fn gegl_node_new_processor(p_node: *Node, p_rectangle: *const gegl.Rectangle) *gegl.Processor;
    pub const newProcessor = gegl_node_new_processor;

    /// Render a composition. This can be used for instance on a node with a "png-save"
    /// operation to render all necessary data, and make it be written to file. This
    /// function wraps the usage of a GeglProcessor in a single blocking function
    /// call. If you need a non-blocking operation, then make a direct use of
    /// `gegl.Processor.work`. See `gegl.Processor`.
    ///
    /// ---
    /// GeglNode      *gegl;
    /// GeglRectangle  roi;
    /// GeglNode      *png_save;
    /// unsigned char *buffer;
    ///
    /// gegl = gegl_parse_xml (xml_data);
    /// roi      = gegl_node_get_bounding_box (gegl);
    /// # create png_save from the graph, the parent/child relationship
    /// # only mean anything when it comes to memory management.
    /// png_save = gegl_node_new_child (gegl,
    ///                                 "operation", "gegl:png-save",
    ///                                 "path",      "output.png",
    ///                                 NULL);
    ///
    /// gegl_node_link (gegl, png_save);
    /// gegl_node_process (png_save);
    ///
    /// buffer = malloc (roi.w*roi.h*4);
    /// gegl_node_blit (gegl,
    ///                 1.0,
    ///                 &roi,
    ///                 babl_format("R'G'B'A u8"),
    ///                 buffer,
    ///                 GEGL_AUTO_ROWSTRIDE,
    ///                 GEGL_BLIT_DEFAULT);
    extern fn gegl_node_process(p_sink_node: *Node) void;
    pub const process = gegl_node_process;

    extern fn gegl_node_progress(p_node: *Node, p_progress: f64, p_message: [*:0]u8) void;
    pub const progress = gegl_node_progress;

    /// Removes a child from a GeglNode. The reference previously held will be
    /// dropped so increase the reference count before removing when reparenting
    /// a child between two graphs.
    extern fn gegl_node_remove_child(p_graph: *Node, p_child: *gegl.Node) *gegl.Node;
    pub const removeChild = gegl_node_remove_child;

    /// Set properties on a node, possible properties to be set are the properties
    /// of the currently set operations as well as <em>"name"</em> and
    /// <em>"operation"</em>. <em>"operation"</em> changes the current operations
    /// set for the node, <em>"name"</em> doesn't have any role internally in
    /// GEGL.
    /// ---
    /// gegl_node_set (node, "brightness", -0.2,
    ///                      "contrast",   2.0,
    ///                      NULL);
    extern fn gegl_node_set(p_node: *Node, p_first_property_name: [*:0]const u8, ...) void;
    pub const set = gegl_node_set;

    extern fn gegl_node_set_enum_as_string(p_node: *Node, p_key: [*:0]const u8, p_value: [*:0]const u8) void;
    pub const setEnumAsString = gegl_node_set_enum_as_string;

    extern fn gegl_node_set_passthrough(p_node: *Node, p_passthrough: c_int) void;
    pub const setPassthrough = gegl_node_set_passthrough;

    /// This is mainly included for language bindings. Using `gegl.Node.set` is
    /// more convenient when programming in C.
    extern fn gegl_node_set_property(p_node: *Node, p_property_name: [*:0]const u8, p_value: *const gobject.Value) void;
    pub const setProperty = gegl_node_set_property;

    /// Sets the right value in animated properties of this node and all its
    /// dependendcies to be the specified time position.
    extern fn gegl_node_set_time(p_node: *Node, p_time: f64) void;
    pub const setTime = gegl_node_set_time;

    /// valist version of `gegl.Node.set`
    extern fn gegl_node_set_valist(p_node: *Node, p_first_property_name: [*:0]const u8, p_args: std.builtin.VaList) void;
    pub const setValist = gegl_node_set_valist;

    /// Returns a freshly allocated \0 terminated string containing a XML
    /// serialization of the composition produced by a node (and thus also
    /// the nodes contributing data to the specified node). To export a
    /// gegl graph, connect the internal output node to an output proxy (see
    /// `gegl.Node.getOutputProxy`.) and use the proxy node as the basis
    /// for the serialization.
    extern fn gegl_node_to_xml(p_node: *Node, p_path_root: [*:0]const u8) [*:0]u8;
    pub const toXml = gegl_node_to_xml;

    /// Returns a freshly allocated \0 terminated string containing a XML
    /// serialization of a segment of a graph from `head` to `tail` nodes.
    /// If `tail` is `NULL` then this behaves just like `gegl.Node.toXml`.
    extern fn gegl_node_to_xml_full(p_head: *Node, p_tail: ?*gegl.Node, p_path_root: [*:0]const u8) [*:0]u8;
    pub const toXmlFull = gegl_node_to_xml_full;

    extern fn gegl_node_get_type() usize;
    pub const getGObjectType = gegl_node_get_type;

    extern fn g_object_ref(p_self: *gegl.Node) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Node) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Node, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Operation = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Operation;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_operation_find_property(p_operation_type: [*:0]const u8, p_property_name: [*:0]const u8) *gobject.ParamSpec;
    pub const findProperty = gegl_operation_find_property;

    extern fn gegl_operation_get_key(p_operation_type: [*:0]const u8, p_key_name: [*:0]const u8) [*:0]const u8;
    pub const getKey = gegl_operation_get_key;

    extern fn gegl_operation_get_op_version(p_op_name: [*:0]const u8) [*:0]const u8;
    pub const getOpVersion = gegl_operation_get_op_version;

    extern fn gegl_operation_get_property_key(p_operation_type: [*:0]const u8, p_property_name: [*:0]const u8, p_property_key_name: [*:0]const u8) [*:0]const u8;
    pub const getPropertyKey = gegl_operation_get_property_key;

    extern fn gegl_operation_list_keys(p_operation_type: [*:0]const u8, p_n_keys: *c_uint) [*][*:0]u8;
    pub const listKeys = gegl_operation_list_keys;

    extern fn gegl_operation_list_properties(p_operation_type: [*:0]const u8, p_n_properties_p: *c_uint) [*]*gobject.ParamSpec;
    pub const listProperties = gegl_operation_list_properties;

    extern fn gegl_operation_list_property_keys(p_operation_type: [*:0]const u8, p_property_name: [*:0]const u8, p_n_keys: *c_uint) [*][*:0]u8;
    pub const listPropertyKeys = gegl_operation_list_property_keys;

    extern fn gegl_operation_get_type() usize;
    pub const getGObjectType = gegl_operation_get_type;

    extern fn g_object_ref(p_self: *gegl.Operation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Operation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Operation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamAudioFragment = opaque {
    pub const Parent = gobject.ParamSpec;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamAudioFragment;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_audio_fragment_get_type() usize;
    pub const getGObjectType = gegl_param_audio_fragment_get_type;

    pub fn as(p_instance: *ParamAudioFragment, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamColor = opaque {
    pub const Parent = gobject.ParamSpec;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamColor;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_color_get_type() usize;
    pub const getGObjectType = gegl_param_color_get_type;

    pub fn as(p_instance: *ParamColor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamCurve = opaque {
    pub const Parent = gobject.ParamSpec;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamCurve;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_curve_get_type() usize;
    pub const getGObjectType = gegl_param_curve_get_type;

    pub fn as(p_instance: *ParamCurve, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamDouble = opaque {
    pub const Parent = gobject.ParamSpecDouble;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamDouble;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_double_get_type() usize;
    pub const getGObjectType = gegl_param_double_get_type;

    pub fn as(p_instance: *ParamDouble, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamEnum = opaque {
    pub const Parent = gobject.ParamSpecEnum;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamEnum;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_enum_get_type() usize;
    pub const getGObjectType = gegl_param_enum_get_type;

    pub fn as(p_instance: *ParamEnum, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamFilePath = opaque {
    pub const Parent = gobject.ParamSpecString;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamFilePath;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_file_path_get_type() usize;
    pub const getGObjectType = gegl_param_file_path_get_type;

    pub fn as(p_instance: *ParamFilePath, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamFormat = opaque {
    pub const Parent = gobject.ParamSpecPointer;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamFormat;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_format_get_type() usize;
    pub const getGObjectType = gegl_param_format_get_type;

    pub fn as(p_instance: *ParamFormat, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamInt = opaque {
    pub const Parent = gobject.ParamSpecInt;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamInt;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_int_get_type() usize;
    pub const getGObjectType = gegl_param_int_get_type;

    pub fn as(p_instance: *ParamInt, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamPath = opaque {
    pub const Parent = gobject.ParamSpec;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamPath;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_path_get_type() usize;
    pub const getGObjectType = gegl_param_path_get_type;

    pub fn as(p_instance: *ParamPath, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSeed = opaque {
    pub const Parent = gobject.ParamSpecUInt;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamSeed;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_seed_get_type() usize;
    pub const getGObjectType = gegl_param_seed_get_type;

    pub fn as(p_instance: *ParamSeed, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamString = opaque {
    pub const Parent = gobject.ParamSpecString;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamString;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_string_get_type() usize;
    pub const getGObjectType = gegl_param_string_get_type;

    pub fn as(p_instance: *ParamString, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamUri = opaque {
    pub const Parent = gobject.ParamSpecString;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = ParamUri;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_param_uri_get_type() usize;
    pub const getGObjectType = gegl_param_uri_get_type;

    pub fn as(p_instance: *ParamUri, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Path = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gegl.PathClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: ?*anyopaque, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Path, p_instance))),
                    gobject.signalLookup("changed", Path.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Add a new flattener, the flattener should produce a type of path that
    /// GeglPath already understands, if the flattener is unable to flatten
    /// the incoming path (doesn't understand the instructions), the original
    /// path should be returned.
    extern fn gegl_path_add_flattener(p_func: gegl.FlattenerFunc) void;
    pub const addFlattener = gegl_path_add_flattener;

    /// Adds a new type to the path system, FIXME this should probably
    /// return something on registration conflicts, for now it expects
    /// all registered paths to be aware of each other.
    extern fn gegl_path_add_type(p_type: u8, p_items: c_int, p_description: [*:0]const u8) void;
    pub const addType = gegl_path_add_type;

    /// Creates a new `gegl.Path` with no nodes.
    ///
    /// Returns the newly created `gegl.Path`
    extern fn gegl_path_new() *gegl.Path;
    pub const new = gegl_path_new;

    /// Creates a new `gegl.Path` with the nodes described in the string
    /// `instructions`. See `gegl.Path.parseString` for details of the
    /// format of the string.
    ///
    /// Returns the newly created `gegl.Path`
    extern fn gegl_path_new_from_string(p_instructions: [*:0]const u8) *gegl.Path;
    pub const newFromString = gegl_path_new_from_string;

    /// Use as follows: gegl_path_append (path, 'M', 0.0, 0.0);
    /// and gegl_path_append (path, 'C', 10.0, 10.0, 50.0, 10.0, 60.0, 0.0) the
    /// number of arguments are determined from the instruction provided.
    extern fn gegl_path_append(p_path: *Path, ...) void;
    pub const append = gegl_path_append;

    /// Compute the coordinates of the path at the `position` (length measured from
    /// start of path, not including discontinuities).
    extern fn gegl_path_calc(p_path: *Path, p_pos: f64, p_x: *f64, p_y: *f64) c_int;
    pub const calc = gegl_path_calc;

    /// Compute `num_samples` for a path into the provided arrays `xs` and `ys`
    /// the returned values include the start and end positions of the path.
    extern fn gegl_path_calc_values(p_path: *Path, p_num_samples: c_uint, p_xs: *[*]f64, p_ys: *[*]f64) void;
    pub const calcValues = gegl_path_calc_values;

    /// Compute a corresponding y coordinate for a given x input coordinate,
    /// returns 0 if computed correctly and -1 if the path doesn't exist for the
    /// specified x coordinate.
    extern fn gegl_path_calc_y_for_x(p_path: *Path, p_x: f64, p_y: *f64) c_int;
    pub const calcYForX = gegl_path_calc_y_for_x;

    /// Remove all nods from a `path`.
    extern fn gegl_path_clear(p_path: *Path) void;
    pub const clear = gegl_path_clear;

    /// Figure out what and where on a path is closest to arbitrary coordinates.
    ///
    /// Returns the length along the path where the closest point was encountered.
    extern fn gegl_path_closest_point(p_path: *Path, p_x: f64, p_y: f64, p_on_path_x: *f64, p_on_path_y: *f64, p_node_pos_before: *c_int) f64;
    pub const closestPoint = gegl_path_closest_point;

    /// Marks the path as dirty and issues an invalidation for the path rendering,
    /// use this if modifying the values of a GeglPathPoint inline.
    extern fn gegl_path_dirty(p_path: *Path) void;
    pub const dirty = gegl_path_dirty;

    /// Execute a provided function for every node in the path (useful for
    /// drawing and otherwise traversing a path.)
    extern fn gegl_path_foreach(p_path: *Path, p_each_item: gegl.NodeFunction, p_user_data: ?*anyopaque) void;
    pub const foreach = gegl_path_foreach;

    /// Execute a provided function for the segments of a poly line approximating
    /// the path.
    extern fn gegl_path_foreach_flat(p_path: *Path, p_each_item: gegl.NodeFunction, p_user_data: ?*anyopaque) void;
    pub const foreachFlat = gegl_path_foreach_flat;

    /// Make the `GeglPath` stop firing signals as it changes must be paired with a
    /// `gegl.Path.thaw` for the signals to start again.
    extern fn gegl_path_freeze(p_path: *Path) void;
    pub const freeze = gegl_path_freeze;

    /// Compute the bounding box of a path.
    extern fn gegl_path_get_bounds(p_self: *Path, p_min_x: *f64, p_max_x: *f64, p_min_y: *f64, p_max_y: *f64) void;
    pub const getBounds = gegl_path_get_bounds;

    /// Return a polyline version of `path`
    extern fn gegl_path_get_flat_path(p_path: *Path) *gegl.PathList;
    pub const getFlatPath = gegl_path_get_flat_path;

    /// Returns the total length of the path.
    extern fn gegl_path_get_length(p_path: *Path) f64;
    pub const getLength = gegl_path_get_length;

    /// Get the transformation matrix of the path.
    extern fn gegl_path_get_matrix(p_path: *Path, p_matrix: *gegl.Matrix3) void;
    pub const getMatrix = gegl_path_get_matrix;

    /// Retrieves the number of nodes in the path.
    extern fn gegl_path_get_n_nodes(p_path: *Path) c_int;
    pub const getNNodes = gegl_path_get_n_nodes;

    /// Retrieve the node of the path at position `pos`.
    ///
    /// Returns TRUE if the node was successfully retrieved.
    extern fn gegl_path_get_node(p_path: *Path, p_index: c_int, p_node: *gegl.PathItem) c_int;
    pub const getNode = gegl_path_get_node;

    /// Return the internal untouched `gegl.PathList`
    extern fn gegl_path_get_path(p_path: *Path) *gegl.PathList;
    pub const getPath = gegl_path_get_path;

    /// Insert the new node `node` at position `pos` in `path`.
    /// if `pos` = -1, the node is added in the last position.
    extern fn gegl_path_insert_node(p_path: *Path, p_pos: c_int, p_node: *const gegl.PathItem) void;
    pub const insertNode = gegl_path_insert_node;

    /// Check if the path contains any nodes.
    ///
    /// Returns TRUE if the path has no nodes.
    extern fn gegl_path_is_empty(p_path: *Path) c_int;
    pub const isEmpty = gegl_path_is_empty;

    /// Parses `instructions` and appends corresponding nodes to path (call
    /// `gegl_path_clean` first if you want to replace the existing path.
    extern fn gegl_path_parse_string(p_path: *Path, p_instructions: [*:0]const u8) void;
    pub const parseString = gegl_path_parse_string;

    /// Removes the node number `pos` in `path`.
    extern fn gegl_path_remove_node(p_path: *Path, p_pos: c_int) void;
    pub const removeNode = gegl_path_remove_node;

    /// Replaces the exiting node at position `pos` in `path`.
    extern fn gegl_path_replace_node(p_path: *Path, p_pos: c_int, p_node: *const gegl.PathItem) void;
    pub const replaceNode = gegl_path_replace_node;

    /// Set the transformation matrix of the path.
    ///
    /// The path is transformed through this matrix when being evaluated,
    /// causing the calculated positions and length to be changed by the transform.
    extern fn gegl_path_set_matrix(p_path: *Path, p_matrix: *gegl.Matrix3) void;
    pub const setMatrix = gegl_path_set_matrix;

    /// Restart firing signals (unless the path has been frozen multiple times).
    extern fn gegl_path_thaw(p_path: *Path) void;
    pub const thaw = gegl_path_thaw;

    /// Serialize the paths nodes to a string.
    extern fn gegl_path_to_string(p_path: *Path) [*:0]u8;
    pub const toString = gegl_path_to_string;

    extern fn gegl_path_get_type() usize;
    pub const getGObjectType = gegl_path_get_type;

    extern fn g_object_ref(p_self: *gegl.Path) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Path) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Path, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Processor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Processor;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const chunksize = struct {
            pub const name = "chunksize";

            pub const Type = c_int;
        };

        pub const node = struct {
            pub const name = "node";

            pub const Type = ?*gegl.Node;
        };

        pub const progress = struct {
            pub const name = "progress";

            pub const Type = f64;
        };

        pub const rectangle = struct {
            pub const name = "rectangle";

            pub const Type = ?*anyopaque;
        };
    };

    pub const signals = struct {};

    /// Returns the (cache) buffer the processor is rendering into, another way of
    /// getting to the same pixel data is calling gegl_node_blit with flags
    /// indicating that we want caching and accept dirty data.
    extern fn gegl_processor_get_buffer(p_processor: *Processor) *gegl.Buffer;
    pub const getBuffer = gegl_processor_get_buffer;

    extern fn gegl_processor_set_level(p_processor: *Processor, p_level: c_int) void;
    pub const setLevel = gegl_processor_set_level;

    /// Change the rectangle a `gegl.Processor` is working on.
    extern fn gegl_processor_set_rectangle(p_processor: *Processor, p_rectangle: *const gegl.Rectangle) void;
    pub const setRectangle = gegl_processor_set_rectangle;

    extern fn gegl_processor_set_scale(p_processor: *Processor, p_scale: f64) void;
    pub const setScale = gegl_processor_set_scale;

    /// Do an iteration of work for the processor.
    ///
    /// Returns TRUE if there is more work to be done.
    ///
    /// ---
    /// GeglProcessor *processor = gegl_node_new_processor (node, &roi);
    /// double         progress;
    ///
    /// while (gegl_processor_work (processor, &progress))
    ///   g_warning ("`f`%% complete", progress);
    /// g_object_unref (processor);
    extern fn gegl_processor_work(p_processor: *Processor, p_progress: *f64) c_int;
    pub const work = gegl_processor_work;

    extern fn gegl_processor_get_type() usize;
    pub const getGObjectType = gegl_processor_get_type;

    extern fn g_object_ref(p_self: *gegl.Processor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Processor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Processor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Stats = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Stats;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const active_threads = struct {
            pub const name = "active-threads";

            pub const Type = c_int;
        };

        pub const assigned_threads = struct {
            pub const name = "assigned-threads";

            pub const Type = c_int;
        };

        pub const scratch_total = struct {
            pub const name = "scratch-total";

            pub const Type = u64;
        };

        pub const swap_busy = struct {
            pub const name = "swap-busy";

            pub const Type = c_int;
        };

        pub const swap_file_size = struct {
            pub const name = "swap-file-size";

            pub const Type = u64;
        };

        pub const swap_queue_full = struct {
            pub const name = "swap-queue-full";

            pub const Type = c_int;
        };

        pub const swap_queue_stalls = struct {
            pub const name = "swap-queue-stalls";

            pub const Type = c_int;
        };

        pub const swap_queued_total = struct {
            pub const name = "swap-queued-total";

            pub const Type = u64;
        };

        pub const swap_read_total = struct {
            pub const name = "swap-read-total";

            pub const Type = u64;
        };

        pub const swap_reading = struct {
            pub const name = "swap-reading";

            pub const Type = c_int;
        };

        pub const swap_total = struct {
            pub const name = "swap-total";

            pub const Type = u64;
        };

        pub const swap_total_uncompressed = struct {
            pub const name = "swap-total-uncompressed";

            pub const Type = u64;
        };

        pub const swap_write_total = struct {
            pub const name = "swap-write-total";

            pub const Type = u64;
        };

        pub const swap_writing = struct {
            pub const name = "swap-writing";

            pub const Type = c_int;
        };

        pub const tile_alloc_total = struct {
            pub const name = "tile-alloc-total";

            pub const Type = u64;
        };

        pub const tile_cache_hits = struct {
            pub const name = "tile-cache-hits";

            pub const Type = c_int;
        };

        pub const tile_cache_misses = struct {
            pub const name = "tile-cache-misses";

            pub const Type = c_int;
        };

        pub const tile_cache_total = struct {
            pub const name = "tile-cache-total";

            pub const Type = u64;
        };

        pub const tile_cache_total_max = struct {
            pub const name = "tile-cache-total-max";

            pub const Type = u64;
        };

        pub const tile_cache_total_uncompressed = struct {
            pub const name = "tile-cache-total-uncompressed";

            pub const Type = u64;
        };

        pub const zoom_total = struct {
            pub const name = "zoom-total";

            pub const Type = u64;
        };
    };

    pub const signals = struct {};

    extern fn gegl_stats_get_type() usize;
    pub const getGObjectType = gegl_stats_get_type;

    extern fn g_object_ref(p_self: *gegl.Stats) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Stats) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Stats, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileBackend = extern struct {
    pub const Parent = gegl.TileSource;
    pub const Implements = [_]type{};
    pub const Class = gegl.TileBackendClass;
    f_parent_instance: gegl.TileSource,
    f_priv: ?*gegl.TileBackendPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const flush_on_destroy = struct {
            pub const name = "flush-on-destroy";

            pub const Type = c_int;
        };

        pub const format = struct {
            pub const name = "format";

            pub const Type = ?*anyopaque;
        };

        pub const px_size = struct {
            pub const name = "px-size";

            pub const Type = c_int;
        };

        pub const tile_height = struct {
            pub const name = "tile-height";

            pub const Type = c_int;
        };

        pub const tile_size = struct {
            pub const name = "tile-size";

            pub const Type = c_int;
        };

        pub const tile_width = struct {
            pub const name = "tile-width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Delete a swap file from disk. This must be used by tile backends which may
    /// swap to disk under certain circonstances.
    ///
    /// For safety, this function will check that the swap file is in the swap
    /// directory before deletion but it won't perform any other check.
    extern fn gegl_tile_backend_unlink_swap(p_path: [*:0]u8) void;
    pub const unlinkSwap = gegl_tile_backend_unlink_swap;

    /// The default tile-backend command handler.  Tile backends should forward
    /// commands they don't handle themselves to this function.
    extern fn gegl_tile_backend_command(p_backend: *TileBackend, p_command: gegl.TileCommand, p_x: c_int, p_y: c_int, p_z: c_int, p_data: ?*anyopaque) ?*anyopaque;
    pub const command = gegl_tile_backend_command;

    extern fn gegl_tile_backend_get_extent(p_tile_backend: *TileBackend) gegl.Rectangle;
    pub const getExtent = gegl_tile_backend_get_extent;

    extern fn gegl_tile_backend_get_flush_on_destroy(p_tile_backend: *TileBackend) c_int;
    pub const getFlushOnDestroy = gegl_tile_backend_get_flush_on_destroy;

    /// Gets pixel format of `tile_backend`
    extern fn gegl_tile_backend_get_format(p_tile_backend: *TileBackend) *const babl.Object;
    pub const getFormat = gegl_tile_backend_get_format;

    extern fn gegl_tile_backend_get_tile_height(p_tile_backend: *TileBackend) c_int;
    pub const getTileHeight = gegl_tile_backend_get_tile_height;

    extern fn gegl_tile_backend_get_tile_size(p_tile_backend: *TileBackend) c_int;
    pub const getTileSize = gegl_tile_backend_get_tile_size;

    extern fn gegl_tile_backend_get_tile_width(p_tile_backend: *TileBackend) c_int;
    pub const getTileWidth = gegl_tile_backend_get_tile_width;

    /// Gets a pointer to the GeglTileStorage that uses the backend
    extern fn gegl_tile_backend_peek_storage(p_tile_backend: *TileBackend) *gegl.TileSource;
    pub const peekStorage = gegl_tile_backend_peek_storage;

    /// Specify the extent of the backend, can be used to pre-prime the
    /// backend with the width/height information when constructing proxy
    /// GeglBuffers to interact with other systems
    extern fn gegl_tile_backend_set_extent(p_tile_backend: *TileBackend, p_rectangle: *const gegl.Rectangle) void;
    pub const setExtent = gegl_tile_backend_set_extent;

    /// Control whether cached data will be written to the backend before it
    /// is destroyed. If false unwritten data will be discarded.
    extern fn gegl_tile_backend_set_flush_on_destroy(p_tile_backend: *TileBackend, p_flush_on_destroy: c_int) void;
    pub const setFlushOnDestroy = gegl_tile_backend_set_flush_on_destroy;

    extern fn gegl_tile_backend_get_type() usize;
    pub const getGObjectType = gegl_tile_backend_get_type;

    extern fn g_object_ref(p_self: *gegl.TileBackend) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.TileBackend) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TileBackend, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileHandler = extern struct {
    pub const Parent = gegl.TileSource;
    pub const Implements = [_]type{};
    pub const Class = gegl.TileHandlerClass;
    f_parent_instance: gegl.TileSource,
    f_source: ?*gegl.TileSource,
    f_priv: ?*gegl.TileHandlerPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const source = struct {
            pub const name = "source";

            pub const Type = ?*gobject.Object;
        };
    };

    pub const signals = struct {};

    /// Create a new tile associated with this tile handler.
    extern fn gegl_tile_handler_create_tile(p_handler: *TileHandler, p_x: c_int, p_y: c_int, p_z: c_int) *gegl.Tile;
    pub const createTile = gegl_tile_handler_create_tile;

    extern fn gegl_tile_handler_damage_rect(p_handler: *TileHandler, p_rect: *const gegl.Rectangle) void;
    pub const damageRect = gegl_tile_handler_damage_rect;

    extern fn gegl_tile_handler_damage_tile(p_handler: *TileHandler, p_x: c_int, p_y: c_int, p_z: c_int, p_damage: u64) void;
    pub const damageTile = gegl_tile_handler_damage_tile;

    /// Create a duplicate of `tile`, associated with this tile handler.
    extern fn gegl_tile_handler_dup_tile(p_handler: *TileHandler, p_tile: *gegl.Tile, p_x: c_int, p_y: c_int, p_z: c_int) *gegl.Tile;
    pub const dupTile = gegl_tile_handler_dup_tile;

    /// Fetches the tile at the given coordinates from `handler` source.  If the tile
    /// doesn't exist, or if `handler` doesn't have a source, creates a new tile
    /// associated with this tile handler.
    ///
    /// If `preserve_data` is FALSE, the tile contents are unspecified.
    extern fn gegl_tile_handler_get_source_tile(p_handler: *TileHandler, p_x: c_int, p_y: c_int, p_z: c_int, p_preserve_data: c_int) *gegl.Tile;
    pub const getSourceTile = gegl_tile_handler_get_source_tile;

    /// Fetches the tile at the given coordinates from `handler`.  If the tile
    /// doesn't exist, creates a new tile associated with this tile handler.
    ///
    /// If `preserve_data` is FALSE, the tile contents are unspecified.
    extern fn gegl_tile_handler_get_tile(p_handler: *TileHandler, p_x: c_int, p_y: c_int, p_z: c_int, p_preserve_data: c_int) *gegl.Tile;
    pub const getTile = gegl_tile_handler_get_tile;

    extern fn gegl_tile_handler_lock(p_handler: *TileHandler) void;
    pub const lock = gegl_tile_handler_lock;

    extern fn gegl_tile_handler_set_source(p_handler: *TileHandler, p_source: *gegl.TileSource) void;
    pub const setSource = gegl_tile_handler_set_source;

    extern fn gegl_tile_handler_unlock(p_handler: *TileHandler) void;
    pub const unlock = gegl_tile_handler_unlock;

    extern fn gegl_tile_handler_get_type() usize;
    pub const getGObjectType = gegl_tile_handler_get_type;

    extern fn g_object_ref(p_self: *gegl.TileHandler) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.TileHandler) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TileHandler, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileSource = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gegl.TileSourceClass;
    f_parent_instance: gobject.Object,
    f_command: ?gegl.TileSourceCommand,
    f_padding: [4]*anyopaque,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gegl_tile_source_get_type() usize;
    pub const getGObjectType = gegl_tile_source_get_type;

    extern fn g_object_ref(p_self: *gegl.TileSource) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.TileSource) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TileSource, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Metadata = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = gegl.MetadataInterface;
    pub const virtual_methods = struct {
        /// Retrieve resolution from the application image metadata.  Intended for use
        /// by the image file writer.  If resolution is not supported by the application
        /// or if the operation fails `FALSE` is returned and the resolution values are
        /// not updated.
        pub const get_resolution = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_unit: *gegl.ResolutionUnit, p_x: *f32, p_y: *f32) c_int {
                return gobject.ext.as(Metadata.Iface, p_class).f_get_resolution.?(gobject.ext.as(Metadata, p_metadata), p_unit, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_unit: *gegl.ResolutionUnit, p_x: *f32, p_y: *f32) callconv(.c) c_int) void {
                gobject.ext.as(Metadata.Iface, p_class).f_get_resolution = @ptrCast(p_implementation);
            }
        };

        /// Retrieve image file metadata from the application.  Intended for use by the
        /// image file writer. If the operation fails it returns `FALSE` and `value` is
        /// not updated.
        pub const iter_get_value = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_value: *gobject.Value) c_int {
                return gobject.ext.as(Metadata.Iface, p_class).f_iter_get_value.?(gobject.ext.as(Metadata, p_metadata), p_iter, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_value: *gobject.Value) callconv(.c) c_int) void {
                gobject.ext.as(Metadata.Iface, p_class).f_iter_get_value = @ptrCast(p_implementation);
            }
        };

        /// Initialise an iterator to find all supported metadata keys.
        pub const iter_init = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter) void {
                return gobject.ext.as(Metadata.Iface, p_class).f_iter_init.?(gobject.ext.as(Metadata, p_metadata), p_iter);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter) callconv(.c) void) void {
                gobject.ext.as(Metadata.Iface, p_class).f_iter_init = @ptrCast(p_implementation);
            }
        };

        /// Look up the specified key and initialise an iterator to reference the
        /// associated metadata. The iterator is used in conjunction with
        /// `gegl_metadata_set_value` and `gegl_metadata_get_value`. Note that this
        /// iterator is not valid for `gegl.Metadata.iterNext`.
        pub const iter_lookup = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_key: [*:0]const u8) c_int {
                return gobject.ext.as(Metadata.Iface, p_class).f_iter_lookup.?(gobject.ext.as(Metadata, p_metadata), p_iter, p_key);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_key: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Metadata.Iface, p_class).f_iter_lookup = @ptrCast(p_implementation);
            }
        };

        /// Move the iterator to the next metadata item
        pub const iter_next = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter) [*:0]const u8 {
                return gobject.ext.as(Metadata.Iface, p_class).f_iter_next.?(gobject.ext.as(Metadata, p_metadata), p_iter);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Metadata.Iface, p_class).f_iter_next = @ptrCast(p_implementation);
            }
        };

        /// Set application data retrieved from image file's metadata.  Intended for use
        /// by the image file reader.  If the operation fails it returns `FALSE` and
        /// `value` is ignored.
        pub const iter_set_value = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_value: *const gobject.Value) c_int {
                return gobject.ext.as(Metadata.Iface, p_class).f_iter_set_value.?(gobject.ext.as(Metadata, p_metadata), p_iter, p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_iter: *gegl.MetadataIter, p_value: *const gobject.Value) callconv(.c) c_int) void {
                gobject.ext.as(Metadata.Iface, p_class).f_iter_set_value = @ptrCast(p_implementation);
            }
        };

        /// Set the name of the file module and pass an array of mappings from
        /// file-format specific metadata names to those used by Gegl. A GValue
        /// transformation function may be supplied, e.g. to parse or format timestamps.
        pub const register_map = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file_module: [*:0]const u8, p_flags: c_uint, p_map: [*]const gegl.MetadataMap, p_n_map: usize) void {
                return gobject.ext.as(Metadata.Iface, p_class).f_register_map.?(gobject.ext.as(Metadata, p_metadata), p_file_module, p_flags, p_map, p_n_map);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_file_module: [*:0]const u8, p_flags: c_uint, p_map: [*]const gegl.MetadataMap, p_n_map: usize) callconv(.c) void) void {
                gobject.ext.as(Metadata.Iface, p_class).f_register_map = @ptrCast(p_implementation);
            }
        };

        /// Set resolution retrieved from image file's metadata.  Intended for use by
        /// the image file reader.  If resolution is not supported by the application or
        /// if the operation fails `FALSE` is returned and the values are ignored.
        pub const set_resolution = struct {
            pub fn call(p_class: anytype, p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_unit: gegl.ResolutionUnit, p_x: f32, p_y: f32) c_int {
                return gobject.ext.as(Metadata.Iface, p_class).f_set_resolution.?(gobject.ext.as(Metadata, p_metadata), p_unit, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_metadata: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_unit: gegl.ResolutionUnit, p_x: f32, p_y: f32) callconv(.c) c_int) void {
                gobject.ext.as(Metadata.Iface, p_class).f_set_resolution = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Retrieve resolution from the application image metadata.  Intended for use
    /// by the image file writer.  If resolution is not supported by the application
    /// or if the operation fails `FALSE` is returned and the resolution values are
    /// not updated.
    extern fn gegl_metadata_get_resolution(p_metadata: *Metadata, p_unit: *gegl.ResolutionUnit, p_x: *f32, p_y: *f32) c_int;
    pub const getResolution = gegl_metadata_get_resolution;

    /// Retrieve image file metadata from the application.  Intended for use by the
    /// image file writer. If the operation fails it returns `FALSE` and `value` is
    /// not updated.
    extern fn gegl_metadata_iter_get_value(p_metadata: *Metadata, p_iter: *gegl.MetadataIter, p_value: *gobject.Value) c_int;
    pub const iterGetValue = gegl_metadata_iter_get_value;

    /// Initialise an iterator to find all supported metadata keys.
    extern fn gegl_metadata_iter_init(p_metadata: *Metadata, p_iter: *gegl.MetadataIter) void;
    pub const iterInit = gegl_metadata_iter_init;

    /// Look up the specified key and initialise an iterator to reference the
    /// associated metadata. The iterator is used in conjunction with
    /// `gegl_metadata_set_value` and `gegl_metadata_get_value`. Note that this
    /// iterator is not valid for `gegl.Metadata.iterNext`.
    extern fn gegl_metadata_iter_lookup(p_metadata: *Metadata, p_iter: *gegl.MetadataIter, p_key: [*:0]const u8) c_int;
    pub const iterLookup = gegl_metadata_iter_lookup;

    /// Move the iterator to the next metadata item
    extern fn gegl_metadata_iter_next(p_metadata: *Metadata, p_iter: *gegl.MetadataIter) [*:0]const u8;
    pub const iterNext = gegl_metadata_iter_next;

    /// Set application data retrieved from image file's metadata.  Intended for use
    /// by the image file reader.  If the operation fails it returns `FALSE` and
    /// `value` is ignored.
    extern fn gegl_metadata_iter_set_value(p_metadata: *Metadata, p_iter: *gegl.MetadataIter, p_value: *const gobject.Value) c_int;
    pub const iterSetValue = gegl_metadata_iter_set_value;

    /// Set the name of the file module and pass an array of mappings from
    /// file-format specific metadata names to those used by Gegl. A GValue
    /// transformation function may be supplied, e.g. to parse or format timestamps.
    extern fn gegl_metadata_register_map(p_metadata: *Metadata, p_file_module: [*:0]const u8, p_flags: c_uint, p_map: [*]const gegl.MetadataMap, p_n_map: usize) void;
    pub const registerMap = gegl_metadata_register_map;

    /// Set resolution retrieved from image file's metadata.  Intended for use by
    /// the image file reader.  If resolution is not supported by the application or
    /// if the operation fails `FALSE` is returned and the values are ignored.
    extern fn gegl_metadata_set_resolution(p_metadata: *Metadata, p_unit: gegl.ResolutionUnit, p_x: f32, p_y: f32) c_int;
    pub const setResolution = gegl_metadata_set_resolution;

    /// Unregister the file module mappings and any further mappings added or
    /// modified by the application.  This should be called after the file module
    /// completes operations.
    extern fn gegl_metadata_unregister_map(p_metadata: *Metadata) void;
    pub const unregisterMap = gegl_metadata_unregister_map;

    extern fn gegl_metadata_get_type() usize;
    pub const getGObjectType = gegl_metadata_get_type;

    extern fn g_object_ref(p_self: *gegl.Metadata) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gegl.Metadata) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Metadata, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AudioFragmentClass = extern struct {
    pub const Instance = gegl.AudioFragment;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *AudioFragmentClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AudioFragmentPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BufferIterator = extern struct {
    f_length: c_int,
    f_priv: ?*gegl.BufferIteratorPriv,
    f_items: ?[*]gegl.BufferIteratorItem,

    /// Create a new buffer iterator without adding any buffers.
    extern fn gegl_buffer_iterator_empty_new(p_max_slots: c_int) *gegl.BufferIterator;
    pub const emptyNew = gegl_buffer_iterator_empty_new;

    /// Adds an additional buffer iterator that will be processed in sync with
    /// the original one, if the buffer doesn't align with the other for tile access
    /// the corresponding scans and regions will be serialized automatically using
    /// gegl_buffer_get.
    ///
    /// If the buffer shares its tiles with a previously-added buffer (in
    /// particular, if the same buffer is added more than once), and at least one of
    /// the buffers is accessed for writing, the corresponding iterated-over areas
    /// should either completely overlap, or not overlap at all, in the coordinate-
    /// system of the underlying tile storage (that is, after shifting each area by
    /// the corresponding buffer's shift-x and shift-y properties).  If the areas
    /// overlap, at most one of the buffers may be accessed for writing, and the
    /// data pointers of the corresponding iterator items may refer to the same
    /// data.
    extern fn gegl_buffer_iterator_add(p_iterator: *BufferIterator, p_buffer: *gegl.Buffer, p_roi: *const gegl.Rectangle, p_level: c_int, p_format: *const babl.Object, p_access_mode: gegl.AccessMode, p_abyss_policy: gegl.AbyssPolicy) c_int;
    pub const add = gegl_buffer_iterator_add;

    /// Do an iteration, this causes a new set of iterator->data[] to become
    /// available if there is more data to process. Changed data from a previous
    /// iteration step will also be saved now. When there is no more data to
    /// be processed FALSE will be returned (and the iterator handle is no longer
    /// valid).
    extern fn gegl_buffer_iterator_next(p_iterator: *BufferIterator) c_int;
    pub const next = gegl_buffer_iterator_next;

    /// Cancels the current iteration, freeing up any temporary resources. The
    /// iterator handle is no longer valid after invoking this function.
    extern fn gegl_buffer_iterator_stop(p_iterator: *BufferIterator) void;
    pub const stop = gegl_buffer_iterator_stop;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BufferIteratorItem = extern struct {
    f_data: ?*anyopaque,
    f_roi: gegl.Rectangle,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BufferIteratorPriv = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BufferMatrix2 = extern struct {
    f_coeff: [4]f64,

    extern fn gegl_buffer_matrix2_determinant(p_matrix: *BufferMatrix2) f64;
    pub const determinant = gegl_buffer_matrix2_determinant;

    extern fn gegl_buffer_matrix2_is_identity(p_matrix: *BufferMatrix2) c_int;
    pub const isIdentity = gegl_buffer_matrix2_is_identity;

    extern fn gegl_buffer_matrix2_is_scale(p_matrix: *BufferMatrix2) c_int;
    pub const isScale = gegl_buffer_matrix2_is_scale;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorClass = extern struct {
    pub const Instance = gegl.Color;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CurveClass = extern struct {
    pub const Instance = gegl.Curve;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *CurveClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Lookup = extern struct {
    f_function: ?gegl.LookupFunction,
    f_data: ?*anyopaque,
    f_shift: c_int,
    f_positive_min: u32,
    f_positive_max: u32,
    f_negative_min: u32,
    f_negative_max: u32,
    f_bitmask: [25600]u32,
    f_table: ?[*]f32,

    extern fn gegl_lookup_new(p_function: gegl.LookupFunction, p_data: ?*anyopaque) *gegl.Lookup;
    pub const new = gegl_lookup_new;

    extern fn gegl_lookup_new_full(p_function: gegl.LookupFunction, p_data: ?*anyopaque, p_start: f32, p_end: f32, p_precision: f32) *gegl.Lookup;
    pub const newFull = gegl_lookup_new_full;

    extern fn gegl_lookup_free(p_lookup: *Lookup) void;
    pub const free = gegl_lookup_free;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Matrix3 = extern struct {
    f_coeff: [9]f64,

    extern fn gegl_matrix3_new() *gegl.Matrix3;
    pub const new = gegl_matrix3_new;

    /// Returns a copy of `src`.
    extern fn gegl_matrix3_copy(p_matrix: *const Matrix3) *gegl.Matrix3;
    pub const copy = gegl_matrix3_copy;

    /// Copies the matrix in `src` into `dst`.
    extern fn gegl_matrix3_copy_into(p_dst: *Matrix3, p_src: *const gegl.Matrix3) void;
    pub const copyInto = gegl_matrix3_copy_into;

    /// Returns the determinant for the matrix.
    extern fn gegl_matrix3_determinant(p_matrix: *const Matrix3) f64;
    pub const determinant = gegl_matrix3_determinant;

    /// Check if two matrices are equal.
    ///
    /// Returns TRUE if the matrices are equal.
    extern fn gegl_matrix3_equal(p_matrix1: *const Matrix3, p_matrix2: *const gegl.Matrix3) c_int;
    pub const equal = gegl_matrix3_equal;

    /// Set the provided `matrix` to the identity matrix.
    extern fn gegl_matrix3_identity(p_matrix: *Matrix3) void;
    pub const identity = gegl_matrix3_identity;

    /// Inverts `matrix`.
    extern fn gegl_matrix3_invert(p_matrix: *Matrix3) void;
    pub const invert = gegl_matrix3_invert;

    /// Check if a matrix only does an affine transformation.
    ///
    /// Returns TRUE if the matrix only does an affine transformation.
    extern fn gegl_matrix3_is_affine(p_matrix: *const Matrix3) c_int;
    pub const isAffine = gegl_matrix3_is_affine;

    /// Check if a matrix is the identity matrix.
    ///
    /// Returns TRUE if the matrix is the identity matrix.
    extern fn gegl_matrix3_is_identity(p_matrix: *const Matrix3) c_int;
    pub const isIdentity = gegl_matrix3_is_identity;

    /// Check if a matrix only does scaling.
    ///
    /// Returns TRUE if the matrix only does scaling.
    extern fn gegl_matrix3_is_scale(p_matrix: *const Matrix3) c_int;
    pub const isScale = gegl_matrix3_is_scale;

    /// Check if a matrix only does translation.
    ///
    /// Returns TRUE if the matrix only does trasnlation.
    extern fn gegl_matrix3_is_translate(p_matrix: *const Matrix3) c_int;
    pub const isTranslate = gegl_matrix3_is_translate;

    /// Multiples `product` = `left` · `right`
    extern fn gegl_matrix3_multiply(p_left: *const Matrix3, p_right: *const gegl.Matrix3, p_product: *gegl.Matrix3) void;
    pub const multiply = gegl_matrix3_multiply;

    /// Shift the origin of the transformation specified by `matrix`
    /// to (`x`, `y`). In other words, calculate the matrix that:
    ///
    /// 1. Translates the input by (-`x`, -`y`).
    ///
    /// 2. Transforms the result using the original `matrix`.
    ///
    /// 3. Translates the result by (`x`, `y`).
    extern fn gegl_matrix3_originate(p_matrix: *Matrix3, p_x: f64, p_y: f64) void;
    pub const originate = gegl_matrix3_originate;

    /// Parse a transofmation matrix from a string.
    extern fn gegl_matrix3_parse_string(p_matrix: *Matrix3, p_string: [*:0]const u8) void;
    pub const parseString = gegl_matrix3_parse_string;

    /// Rounds numerical errors in `matrix` to the nearest integer.
    extern fn gegl_matrix3_round_error(p_matrix: *Matrix3) void;
    pub const roundError = gegl_matrix3_round_error;

    /// Serialize a `gegl.Matrix3` to a string.
    ///
    /// Returns a freshly allocated string representing that `gegl.Matrix3`, the
    /// returned string should be `glib.free`'d.
    extern fn gegl_matrix3_to_string(p_matrix: *const Matrix3) [*:0]u8;
    pub const toString = gegl_matrix3_to_string;

    /// transforms the coordinates provided in `x` and `y` and changes to the
    /// coordinates gotten when the transformed with the matrix.
    extern fn gegl_matrix3_transform_point(p_matrix: *const Matrix3, p_x: *f64, p_y: *f64) void;
    pub const transformPoint = gegl_matrix3_transform_point;

    extern fn gegl_matrix3_get_type() usize;
    pub const getGObjectType = gegl_matrix3_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MetadataHashClass = extern struct {
    pub const Instance = gegl.MetadataHash;

    f_parent_class: gegl.MetadataStoreClass,

    pub fn as(p_instance: *MetadataHashClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `gegl.Metadata` interface structure.
pub const MetadataInterface = extern struct {
    pub const Instance = gegl.Metadata;

    f_base_iface: gobject.TypeInterface,
    /// See `gegl.Metadata.registerMap`.  If called with a NULL map,
    /// the registration is deleted.
    f_register_map: ?*const fn (p_metadata: *gegl.Metadata, p_file_module: [*:0]const u8, p_flags: c_uint, p_map: [*]const gegl.MetadataMap, p_n_map: usize) callconv(.c) void,
    /// See `gegl.Metadata.setResolution`.
    f_set_resolution: ?*const fn (p_metadata: *gegl.Metadata, p_unit: gegl.ResolutionUnit, p_x: f32, p_y: f32) callconv(.c) c_int,
    /// See `gegl.Metadata.getResolution`.
    f_get_resolution: ?*const fn (p_metadata: *gegl.Metadata, p_unit: *gegl.ResolutionUnit, p_x: *f32, p_y: *f32) callconv(.c) c_int,
    /// See `gegl.Metadata.iterLookup`.
    f_iter_lookup: ?*const fn (p_metadata: *gegl.Metadata, p_iter: *gegl.MetadataIter, p_key: [*:0]const u8) callconv(.c) c_int,
    /// See `gegl.Metadata.iterInit`.
    f_iter_init: ?*const fn (p_metadata: *gegl.Metadata, p_iter: *gegl.MetadataIter) callconv(.c) void,
    /// See `gegl.Metadata.iterNext`.
    f_iter_next: ?*const fn (p_metadata: *gegl.Metadata, p_iter: *gegl.MetadataIter) callconv(.c) [*:0]const u8,
    /// See `gegl.Metadata.iterSetValue`.
    f_iter_set_value: ?*const fn (p_metadata: *gegl.Metadata, p_iter: *gegl.MetadataIter, p_value: *const gobject.Value) callconv(.c) c_int,
    /// See `gegl.Metadata.iterGetValue`.
    f_iter_get_value: ?*const fn (p_metadata: *gegl.Metadata, p_iter: *gegl.MetadataIter, p_value: *gobject.Value) callconv(.c) c_int,

    pub fn as(p_instance: *MetadataInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque type representing a metadata iterator.
pub const MetadataIter = extern struct {
    f_stamp: c_uint,
    f_user_data: ?*anyopaque,
    f_user_data2: ?*anyopaque,
    f_user_data3: ?*anyopaque,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Struct to describe how a metadata variable is mapped from the name used by
/// the image file module to the name used by Gegl.  An optional transform
/// function may be specified, e.g. to transform from a `GDatetime` to a string.
pub const MetadataMap = extern struct {
    /// Name of metadata variable used in the file module.
    f_local_name: ?[*:0]const u8,
    /// Standard metadata variable name used by Gegl.
    f_name: ?[*:0]const u8,
    /// Optional `gobject.Value` transform function.
    f_transform: ?gobject.ValueTransform,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The class structure for the `gegl.MetadataStore`
pub const MetadataStoreClass = extern struct {
    pub const Instance = gegl.MetadataStore;

    f_parent_class: gobject.ObjectClass,
    /// The _declare virtual method creates a metadata variable in the
    /// underlying data store. It implements `gegl.MetadataStore.declare`. A
    /// `gobject.ParamSpec` is used to describe the variable.  If the metadata shadows an
    /// object property, shadow should be `TRUE`, otherwise `FALSE`.  It is acceptable
    /// for a subclass to provide additional variables which are implicitly
    /// declared, that is, they need not be declared using
    /// `gegl.MetadataStore.declare`, however the `pspec` method must still retrieve
    /// a `gobject.ParamSpec` describing such variables.  This method MUST be provided by
    /// the subclass.
    f__declare: ?*const fn (p_self: *gegl.MetadataStore, p_pspec: *gobject.ParamSpec, p_shadow: c_int) callconv(.c) void,
    /// The pspec virtual method returns the `gobject.ParamSpec` used to declare a
    /// metadata variable. It is used to implement
    /// `gegl.MetadataStore.typeofValue`. This method MUST be provided by the
    /// subclass.
    f_pspec: ?*const fn (p_self: *gegl.MetadataStore, p_name: [*:0]const u8) callconv(.c) *gobject.ParamSpec,
    /// Set a metadata variable using a `gobject.Value`. Implements
    /// `gegl.MetadataStore.setValue`.  The metadata variable should be declared
    /// and the `gobject.Value` must be of the correct type.  Note that failure to set a
    /// variable may be dependent of properties of the underlying storage mechanism.
    /// This method MUST be provided by the subclass.
    f_set_value: ?*const fn (p_self: *gegl.MetadataStore, p_name: [*:0]const u8, p_value: *const gobject.Value) callconv(.c) void,
    /// Return a pointer to a `gobject.Value` with the value of the metadata
    /// variable or `NULL` if not declared or the variable does not contain a valid
    /// value.  Implements `gegl.MetadataStore.getValue`.  This method MUST be
    /// provided by the subclass.
    f__get_value: ?*const fn (p_self: *gegl.MetadataStore, p_name: [*:0]const u8) callconv(.c) *const gobject.Value,
    /// The has_value virtual method implements
    /// `gegl.MetadataStore.hasValue` It should return `TRUE` if the variable is
    /// declared and contains a valid value of the correct type, otherwise `FALSE`.
    /// This method MUST be provided by the subclass.
    f_has_value: ?*const fn (p_self: *gegl.MetadataStore, p_name: [*:0]const u8) callconv(.c) c_int,
    /// This method is called after a file loader or saver registers
    /// a `gegl.MetadataMap` and before any further processing takes place.  It is
    /// intended to allow an application to create further application-specific
    /// mappings using `gegl.MetadataStore.register`.  `gegl.MetadataStore` provides
    /// a default method which emits the `::mapped` signal.
    f_register_hook: ?*const fn (p_self: *gegl.MetadataStore, p_file_module_name: [*:0]const u8, p_flags: c_uint) callconv(.c) void,
    /// This method is called to optionally parse image file metadata
    /// prior to setting metadata variables in the `gegl.MetadataStore`. If no parser
    /// is available it returns `FALSE` and the registered mapping is used.  If a
    /// parser available it should set one or more metadata variables using
    /// `gegl.MetadataStore.setValue` and return `TRUE`. Note that the parser MUST
    /// return `TRUE` even if setting individual values fails.  The default method
    /// checks if a signal handler is registered for the parse-value signal with
    /// the variable name as the detail parameter. If a handler is registered it
    /// emits the signal with the file metadata provided as a `gobject.Value` and returns
    /// `TRUE` otherwise `FALSE`.
    f_parse_value: ?*const fn (p_self: *gegl.MetadataStore, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *const gobject.Value) callconv(.c) c_int,
    /// This method is called to optionally generate a value to be
    /// written to and image file. If no generator is available it returns `FALSE`
    /// and the registered mapping is used. If a generator is available it should
    /// create a suitable value to be written to the image file and return `TRUE`.
    /// The default method checks if a signal handler is registered for the
    /// generate-value signal with the variable name as the detail parameter. If a
    /// handler is registered it emits the signal with an initialised `gobject.Value` to
    /// receive the file metadata and returns `TRUE` otherwise `FALSE`.  `parse_value`
    /// and `generate_value` are provided to handle the case where some file formats
    /// overload, for example, image comments. A typical case is formatting many
    /// values into a TIFF file's ImageDescription field.
    f_generate_value: ?*const fn (p_self: *gegl.MetadataStore, p_pspec: *gobject.ParamSpec, p_transform: gobject.ValueTransform, p_value: *gobject.Value) callconv(.c) c_int,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *MetadataStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OperationContext = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecDouble = extern struct {
    f_parent_instance: gobject.ParamSpecDouble,
    f_ui_minimum: f64,
    f_ui_maximum: f64,
    f_ui_gamma: f64,
    f_ui_step_small: f64,
    f_ui_step_big: f64,
    f_ui_digits: c_int,

    extern fn gegl_param_spec_double_set_digits(p_pspec: *ParamSpecDouble, p_digits: c_int) void;
    pub const setDigits = gegl_param_spec_double_set_digits;

    extern fn gegl_param_spec_double_set_steps(p_pspec: *ParamSpecDouble, p_small_step: f64, p_big_step: f64) void;
    pub const setSteps = gegl_param_spec_double_set_steps;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecEnum = extern struct {
    f_parent_instance: gobject.ParamSpecEnum,
    f_excluded_values: ?*glib.SList,

    extern fn gegl_param_spec_enum_exclude_value(p_espec: *ParamSpecEnum, p_value: c_int) void;
    pub const excludeValue = gegl_param_spec_enum_exclude_value;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecFilePath = extern struct {
    f_parent_instance: gobject.ParamSpecString,
    bitfields0: packed struct(c_uint) {
        f_no_validate: u1,
        f_null_ok: u1,
        _: u30,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecFormat = extern struct {
    f_parent_instance: gobject.ParamSpecPointer,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecInt = extern struct {
    f_parent_instance: gobject.ParamSpecInt,
    f_ui_minimum: c_int,
    f_ui_maximum: c_int,
    f_ui_gamma: f64,
    f_ui_step_small: c_int,
    f_ui_step_big: c_int,

    extern fn gegl_param_spec_int_set_steps(p_pspec: *ParamSpecInt, p_small_step: c_int, p_big_step: c_int) void;
    pub const setSteps = gegl_param_spec_int_set_steps;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecSeed = extern struct {
    f_parent_instance: gobject.ParamSpecUInt,
    f_ui_minimum: c_uint,
    f_ui_maximum: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecString = extern struct {
    f_parent_instance: gobject.ParamSpecString,
    bitfields0: packed struct(c_uint) {
        f_no_validate: u1,
        f_null_ok: u1,
        _: u30,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ParamSpecUri = extern struct {
    f_parent_instance: gobject.ParamSpecString,
    bitfields0: packed struct(c_uint) {
        f_no_validate: u1,
        f_null_ok: u1,
        _: u30,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathClass = opaque {
    pub const Instance = gegl.Path;

    pub fn as(p_instance: *PathClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathItem = extern struct {
    f_type: u8,
    f_point: [4]gegl.PathPoint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathList = extern struct {
    f_next: ?*anyopaque,
    f_d: gegl.PathItem,

    /// Appends to path list, if head is NULL a new list is created
    extern fn gegl_path_list_append(p_head: *PathList, ...) *gegl.PathList;
    pub const append = gegl_path_list_append;

    /// Frees up a path list
    extern fn gegl_path_list_destroy(p_path: *PathList) *gegl.PathList;
    pub const destroy = gegl_path_list_destroy;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathPoint = extern struct {
    f_x: f32,
    f_y: f32,

    /// Compute the distance between `gegl.PathPoint` `a` and `b`
    extern fn gegl_path_point_dist(p_a: *PathPoint, p_b: *gegl.PathPoint) f64;
    pub const dist = gegl_path_point_dist;

    /// linear interpolation between two `gegl.PathPoint`
    extern fn gegl_path_point_lerp(p_dest: *PathPoint, p_a: *gegl.PathPoint, p_b: *gegl.PathPoint, p_t: f32) void;
    pub const lerp = gegl_path_point_lerp;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Random = opaque {
    /// Creates a new random number generator initialized with a random seed.
    /// This structure needs to be freed by the user with `gegl.Random.free`;
    extern fn gegl_random_new() *gegl.Random;
    pub const new = gegl_random_new;

    /// Return an opaque structure associated to the seed.
    /// This structure needs to be freed by the user with `gegl.Random.free`;
    extern fn gegl_random_new_with_seed(p_seed: u32) *gegl.Random;
    pub const newWithSeed = gegl_random_new_with_seed;

    /// Return a new copy of an existing GeglRandom
    extern fn gegl_random_duplicate(p_rand: *Random) *gegl.Random;
    pub const duplicate = gegl_random_duplicate;

    /// Return a random floating point number in range 0.0 .. 1.0.
    extern fn gegl_random_float(p_rand: *const Random, p_x: c_int, p_y: c_int, p_z: c_int, p_n: c_int) f32;
    pub const float = gegl_random_float;

    /// Return a random floating point number in the range specified,
    /// for the given x,y coordinates and GeglRandom provided, if multiple different
    /// numbers are needed pass in incrementing n's.
    extern fn gegl_random_float_range(p_rand: *const Random, p_x: c_int, p_y: c_int, p_z: c_int, p_n: c_int, p_min: f32, p_max: f32) f32;
    pub const floatRange = gegl_random_float_range;

    /// Free a GeglRandom structure created with `gegl.Random.new` or
    /// `gegl.Random.newWithSeed`
    extern fn gegl_random_free(p_rand: *Random) void;
    pub const free = gegl_random_free;

    /// Return a random integer number in range 0 .. MAX_UINT
    extern fn gegl_random_int(p_rand: *const Random, p_x: c_int, p_y: c_int, p_z: c_int, p_n: c_int) u32;
    pub const int = gegl_random_int;

    /// Return a random integer point number in the range specified,
    /// for the given x,y coordinates and GeglRandom provided, if multiple different
    /// numbers are needed pass in incrementing n's.
    extern fn gegl_random_int_range(p_rand: *const Random, p_x: c_int, p_y: c_int, p_z: c_int, p_n: c_int, p_min: c_int, p_max: c_int) i32;
    pub const intRange = gegl_random_int_range;

    /// Change the seed of an existing GeglRandom.
    extern fn gegl_random_set_seed(p_rand: *Random, p_seed: u32) void;
    pub const setSeed = gegl_random_set_seed;

    extern fn gegl_random_get_type() usize;
    pub const getGObjectType = gegl_random_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Rectangle = extern struct {
    f_x: c_int,
    f_y: c_int,
    f_width: c_int,
    f_height: c_int,

    /// Returns a GeglRectangle that represents an infininte plane.
    extern fn gegl_rectangle_infinite_plane() gegl.Rectangle;
    pub const infinitePlane = gegl_rectangle_infinite_plane;

    /// Creates a new rectangle set with the values from `x`, `y`, `width` and `height`.
    extern fn gegl_rectangle_new(p_x: c_int, p_y: c_int, p_width: c_uint, p_height: c_uint) *gegl.Rectangle;
    pub const new = gegl_rectangle_new;

    /// Aligns `rectangle` to a regular tile grid, of which `tile` is a representative
    /// tile, and stores the result in `destination`.
    ///
    /// `alignment` can be one of:
    ///
    ///   GEGL_RECTANGLE_ALIGNMENT_SUBSET:  Calculate the biggest aligned rectangle
    ///   contained in `rectangle`.
    ///
    ///   GEGL_RECTANGLE_ALIGNMENT_SUPERSET:  Calculate the smallest aligned
    ///   rectangle containing `rectangle`.
    ///
    ///   GEGL_RECTANGLE_ALIGNMENT_NEAREST:  Calculate the nearest aligned rectangle
    ///   to `rectangle`.
    ///
    /// `destination` may point to the same object as `rectangle` or `tile`.
    ///
    /// Returns TRUE if the result is not empty.
    extern fn gegl_rectangle_align(p_destination: *Rectangle, p_rectangle: *const gegl.Rectangle, p_tile: *const gegl.Rectangle, p_alignment: gegl.RectangleAlignment) c_int;
    pub const @"align" = gegl_rectangle_align;

    /// Aligns `rectangle` to the tile grid of `buffer`, and stores the result in
    /// `destination`.
    ///
    /// `alignment` has the same meaning as for `gegl.Rectangle.@"align"`.
    ///
    /// `destination` may point to the same object as `rectangle`.
    ///
    /// Returns TRUE if the result is not empty.
    extern fn gegl_rectangle_align_to_buffer(p_destination: *Rectangle, p_rectangle: *const gegl.Rectangle, p_buffer: *gegl.Buffer, p_alignment: gegl.RectangleAlignment) c_int;
    pub const alignToBuffer = gegl_rectangle_align_to_buffer;

    /// Computes the bounding box of the rectangles `source1` and `source2` and stores the
    /// resulting bounding box in `destination`.
    ///
    /// `destination` may point to the same object as `source1` or `source2`.
    extern fn gegl_rectangle_bounding_box(p_destination: *Rectangle, p_source1: *const gegl.Rectangle, p_source2: *const gegl.Rectangle) void;
    pub const boundingBox = gegl_rectangle_bounding_box;

    /// Checks if the `gegl.Rectangle` `child` is fully contained within `parent`.
    ///
    /// Returns TRUE if the `child` is fully contained in `parent`.
    extern fn gegl_rectangle_contains(p_parent: *const Rectangle, p_child: *const gegl.Rectangle) c_int;
    pub const contains = gegl_rectangle_contains;

    /// Copies the rectangle information stored in `source` over the information in
    /// `destination`.
    ///
    /// `destination` may point to the same object as `source`.
    extern fn gegl_rectangle_copy(p_destination: *Rectangle, p_source: *const gegl.Rectangle) void;
    pub const copy = gegl_rectangle_copy;

    /// For debugging purposes, not stable API.
    extern fn gegl_rectangle_dump(p_rectangle: *const Rectangle) void;
    pub const dump = gegl_rectangle_dump;

    /// Create a new copy of `rectangle`.
    extern fn gegl_rectangle_dup(p_rectangle: *const Rectangle) *gegl.Rectangle;
    pub const dup = gegl_rectangle_dup;

    /// Check if two `GeglRectangles` are equal.
    ///
    /// Returns TRUE if `rectangle` and `rectangle2` are equal.
    extern fn gegl_rectangle_equal(p_rectangle1: *const Rectangle, p_rectangle2: *const gegl.Rectangle) c_int;
    pub const equal = gegl_rectangle_equal;

    /// Check if a rectangle is equal to a set of parameters.
    ///
    /// Returns TRUE if `rectangle` and `x`,`y` `width` x `height` are equal.
    extern fn gegl_rectangle_equal_coords(p_rectangle: *const Rectangle, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) c_int;
    pub const equalCoords = gegl_rectangle_equal_coords;

    /// Calculates the intersection of two rectangles. If the rectangles do not
    /// intersect, dest's width and height are set to 0 and its x and y values
    /// are undefined.
    ///
    /// `dest` may point to the same object as `src1` or `src2`.
    ///
    /// Returns TRUE if the rectangles intersect.
    extern fn gegl_rectangle_intersect(p_dest: *Rectangle, p_src1: *const gegl.Rectangle, p_src2: *const gegl.Rectangle) c_int;
    pub const intersect = gegl_rectangle_intersect;

    /// Check if a rectangle has zero area.
    ///
    /// Returns TRUE if the width or height of `rectangle` is 0.
    extern fn gegl_rectangle_is_empty(p_rectangle: *const Rectangle) c_int;
    pub const isEmpty = gegl_rectangle_is_empty;

    /// Returns TRUE if the GeglRectangle represents an infininte plane,
    /// FALSE otherwise.
    extern fn gegl_rectangle_is_infinite_plane(p_rectangle: *const Rectangle) c_int;
    pub const isInfinitePlane = gegl_rectangle_is_infinite_plane;

    /// Sets the `x`, `y`, `width` and `height` on `rectangle`.
    extern fn gegl_rectangle_set(p_rectangle: *Rectangle, p_x: c_int, p_y: c_int, p_width: c_uint, p_height: c_uint) void;
    pub const set = gegl_rectangle_set;

    /// Subtracts `subtrahend` from `minuend`, and stores the resulting rectangles in
    /// `destination`.  Between 0 and 4 disjoint rectangles may be produced.
    ///
    /// `destination` may contain `minuend` or `subtrahend`.
    ///
    /// Returns the number of resulting rectangles.
    extern fn gegl_rectangle_subtract(p_destination: *Rectangle, p_minuend: *const gegl.Rectangle, p_subtrahend: *const gegl.Rectangle) c_int;
    pub const subtract = gegl_rectangle_subtract;

    /// Computes the bounding box of the area formed by subtracting `subtrahend`
    /// from `minuend`, and stores the result in `destination`.
    ///
    /// `destination` may point to the same object as `minuend` or `subtrahend`.
    ///
    /// Returns TRUE if the result is not empty.
    extern fn gegl_rectangle_subtract_bounding_box(p_destination: *Rectangle, p_minuend: *const gegl.Rectangle, p_subtrahend: *const gegl.Rectangle) c_int;
    pub const subtractBoundingBox = gegl_rectangle_subtract_bounding_box;

    /// Computes the symmetric difference of the rectangles `source1` and `source2`,
    /// and stores the resulting rectangles in `destination`.  Between 0 and 4
    /// disjoint rectangles may be produced.
    ///
    /// `destination` may contain `rectangle1` or `rectangle2`.
    ///
    /// Returns the number of resulting rectangles.
    extern fn gegl_rectangle_xor(p_destination: *Rectangle, p_source1: *const gegl.Rectangle, p_source2: *const gegl.Rectangle) c_int;
    pub const xor = gegl_rectangle_xor;

    extern fn gegl_rectangle_get_type() usize;
    pub const getGObjectType = gegl_rectangle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Sampler = opaque {
    /// Perform a sampling with the provided `sampler`.
    extern fn gegl_sampler_get(p_sampler: *Sampler, p_x: f64, p_y: f64, p_scale: *gegl.BufferMatrix2, p_output: ?*anyopaque, p_repeat_mode: gegl.AbyssPolicy) void;
    pub const get = gegl_sampler_get;

    extern fn gegl_sampler_get_context_rect(p_sampler: *Sampler) *const gegl.Rectangle;
    pub const getContextRect = gegl_sampler_get_context_rect;

    /// Get the raw sampler function, the raw sampler function does not do
    /// additional NaN / inifinity checks on passed in coordinates.
    extern fn gegl_sampler_get_fun(p_sampler: *Sampler) gegl.SamplerGetFun;
    pub const getFun = gegl_sampler_get_fun;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Tile = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileBackendClass = extern struct {
    pub const Instance = gegl.TileBackend;

    f_parent_class: gegl.TileSourceClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *TileBackendClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileBackendPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileCopyParams = extern struct {
    f_dst_buffer: ?*gegl.Buffer,
    f_dst_x: c_int,
    f_dst_y: c_int,
    f_dst_z: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileHandlerClass = extern struct {
    pub const Instance = gegl.TileHandler;

    f_parent_class: gegl.TileSourceClass,

    pub fn as(p_instance: *TileHandlerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileHandlerPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileSourceClass = extern struct {
    pub const Instance = gegl.TileSource;

    f_parent_class: gobject.ObjectClass,
    f_padding: [4]*anyopaque,

    pub fn as(p_instance: *TileSourceClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AbyssPolicy = enum(c_int) {
    none = 0,
    clamp = 1,
    loop = 2,
    black = 3,
    white = 4,
    _,

    extern fn gegl_abyss_policy_get_type() usize;
    pub const getGObjectType = gegl_abyss_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BablVariant = enum(c_int) {
    float = 0,
    linear = 1,
    non_linear = 2,
    perceptual = 3,
    linear_premultiplied = 4,
    perceptual_premultiplied = 5,
    linear_premultiplied_if_alpha = 6,
    perceptual_premultiplied_if_alpha = 7,
    add_alpha = 8,
    _,

    extern fn gegl_babl_variant_get_type() usize;
    pub const getGObjectType = gegl_babl_variant_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CachePolicy = enum(c_int) {
    auto = 0,
    never = 1,
    always = 2,
    _,

    extern fn gegl_cache_policy_get_type() usize;
    pub const getGObjectType = gegl_cache_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DistanceMetric = enum(c_int) {
    euclidean = 0,
    manhattan = 1,
    chebyshev = 2,
    _,

    extern fn gegl_distance_metric_get_type() usize;
    pub const getGObjectType = gegl_distance_metric_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DitherMethod = enum(c_int) {
    none = 0,
    floyd_steinberg = 1,
    bayer = 2,
    random = 3,
    random_covariant = 4,
    add = 5,
    add_covariant = 6,
    xor = 7,
    xor_covariant = 8,
    blue_noise = 9,
    blue_noise_covariant = 10,
    _,

    extern fn gegl_dither_method_get_type() usize;
    pub const getGObjectType = gegl_dither_method_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags controlling the mapping strategy.
pub const MapFlags = enum(c_int) {
    map_exclude_unmapped = 1,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Orientation = enum(c_int) {
    horizontal = 0,
    vertical = 1,
    _,

    extern fn gegl_orientation_get_type() usize;
    pub const getGObjectType = gegl_orientation_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RectangleAlignment = enum(c_int) {
    subset = 0,
    superset = 1,
    nearest = 2,
    _,

    extern fn gegl_rectangle_alignment_get_type() usize;
    pub const getGObjectType = gegl_rectangle_alignment_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumerated type specifying resolution (density) units.  If resolution
/// units are unknown, X and Y resolution specify the pixel aspect ratio.
pub const ResolutionUnit = enum(c_int) {
    none = 0,
    dpi = 1,
    dpm = 2,
    _,

    extern fn gegl_resolution_unit_get_type() usize;
    pub const getGObjectType = gegl_resolution_unit_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SamplerType = enum(c_int) {
    nearest = 0,
    linear = 1,
    cubic = 2,
    nohalo = 3,
    lohalo = 4,
    _,

    extern fn gegl_sampler_type_get_type() usize;
    pub const getGObjectType = gegl_sampler_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SplitStrategy = enum(c_int) {
    auto = 0,
    horizontal = 1,
    vertical = 2,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TileCommand = enum(c_int) {
    egl_tile_idle = 0,
    egl_tile_set = 1,
    egl_tile_get = 2,
    egl_tile_is_cached = 3,
    egl_tile_exist = 4,
    egl_tile_void = 5,
    egl_tile_flush = 6,
    egl_tile_refetch = 7,
    egl_tile_reinit = 8,
    gegl_tile_last_0_4_8_command = 9,
    egl_tile_last_command = 10,
    _,

    pub const egl_tile_copy = TileCommand.gegl_tile_last_0_4_8_command;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AccessMode = packed struct(c_uint) {
    read: bool = false,
    write: bool = false,
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

    pub const flags_read: AccessMode = @bitCast(@as(c_uint, 1));
    pub const flags_write: AccessMode = @bitCast(@as(c_uint, 2));
    pub const flags_readwrite: AccessMode = @bitCast(@as(c_uint, 3));
    extern fn gegl_access_mode_get_type() usize;
    pub const getGObjectType = gegl_access_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BlitFlags = packed struct(c_uint) {
    cache: bool = false,
    dirty: bool = false,
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

    pub const flags_default: BlitFlags = @bitCast(@as(c_uint, 0));
    pub const flags_cache: BlitFlags = @bitCast(@as(c_uint, 1));
    pub const flags_dirty: BlitFlags = @bitCast(@as(c_uint, 2));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PadType = packed struct(c_uint) {
    _padding0: bool = false,
    _padding1: bool = false,
    _padding2: bool = false,
    _padding3: bool = false,
    _padding4: bool = false,
    _padding5: bool = false,
    _padding6: bool = false,
    _padding7: bool = false,
    output: bool = false,
    input: bool = false,
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

    pub const flags_output: PadType = @bitCast(@as(c_uint, 256));
    pub const flags_input: PadType = @bitCast(@as(c_uint, 512));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SerializeFlag = packed struct(c_uint) {
    trim_defaults: bool = false,
    version: bool = false,
    indent: bool = false,
    bake_anim: bool = false,
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

    pub const flags_trim_defaults: SerializeFlag = @bitCast(@as(c_uint, 1));
    pub const flags_version: SerializeFlag = @bitCast(@as(c_uint, 2));
    pub const flags_indent: SerializeFlag = @bitCast(@as(c_uint, 4));
    pub const flags_bake_anim: SerializeFlag = @bitCast(@as(c_uint, 8));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Apply the operation to buffer, overwritting the contents of buffer.
extern fn gegl_apply_op(p_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, ...) void;
pub const applyOp = gegl_apply_op;

/// Apply the operation to buffer, overwritting the contents of buffer.
extern fn gegl_apply_op_valist(p_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, p_var_args: std.builtin.VaList) void;
pub const applyOpValist = gegl_apply_op_valist;

extern fn gegl_babl_variant(p_format: *const babl.Object, p_variant: gegl.BablVariant) *const babl.Object;
pub const bablVariant = gegl_babl_variant;

/// allocated 0'd memory.
extern fn gegl_calloc(p_size: usize, p_n_memb: c_int) ?*anyopaque;
pub const calloc = gegl_calloc;

/// Disable OpenCL
extern fn gegl_cl_disable() void;
pub const clDisable = gegl_cl_disable;

/// Initialize and enable OpenCL, calling this function again
/// will re-enable OpenCL if it has been disabled.
extern fn gegl_cl_init(p_error: ?*?*glib.Error) c_int;
pub const clInit = gegl_cl_init;

/// Check if OpenCL is enabled.
extern fn gegl_cl_is_accelerated() c_int;
pub const clIsAccelerated = gegl_cl_is_accelerated;

/// Returns a GeglConfig object with properties that can be manipulated to control
/// GEGLs behavior.
extern fn gegl_config() *gegl.Config;
pub const config = gegl_config;

/// Create a node chain from an unparsed commandline string.
extern fn gegl_create_chain(p_ops: [*:0]const u8, p_op_start: *gegl.Node, p_op_end: *gegl.Node, p_time: f64, p_rel_dim: c_int, p_path_root: [*:0]const u8, p_error: ?*?*glib.Error) void;
pub const createChain = gegl_create_chain;

/// Create a node chain from argv style list of op data.
extern fn gegl_create_chain_argv(p_ops: *[*:0]u8, p_op_start: *gegl.Node, p_op_end: *gegl.Node, p_time: f64, p_rel_dim: c_int, p_path_root: [*:0]const u8, p_error: ?*?*glib.Error) void;
pub const createChainArgv = gegl_create_chain_argv;

/// Call this function when you're done using GEGL. It will clean up
/// caches and write/dump debug information if the correct debug flags
/// are set.
extern fn gegl_exit() void;
pub const exit = gegl_exit;

/// Apply the operation to source_buffer, returning the result in a new buffer.
extern fn gegl_filter_op(p_source_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, ...) *gegl.Buffer;
pub const filterOp = gegl_filter_op;

/// Apply the operation to source_buffer, returning the result in a new buffer.
extern fn gegl_filter_op_valist(p_source_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, p_var_args: std.builtin.VaList) *gegl.Buffer;
pub const filterOpValist = gegl_filter_op_valist;

/// Returns a value sutable to pass to the GeglBuffer constructor
/// or any other property that expects a Babl format.
extern fn gegl_format(p_format_name: [*:0]const u8) ?*gobject.Value;
pub const format = gegl_format;

extern fn gegl_format_get_name(p_format: *gobject.Value) ?[*:0]const u8;
pub const formatGetName = gegl_format_get_name;

/// Frees the memory pointed to by `mem`. If `mem` is NULL, does nothing.
extern fn gegl_free(p_mem: ?*anyopaque) void;
pub const free = gegl_free;

/// Returns a GOptionGroup for the commandline arguments recognized
/// by GEGL. You should add this group to your GOptionContext
/// with `glib.OptionContext.addGroup` if you are using
/// `glib.OptionContext.parse` to parse your commandline arguments.
extern fn gegl_get_option_group() *glib.OptionGroup;
pub const getOptionGroup = gegl_get_option_group;

/// This function fetches the version of the GEGL library being used by
/// the running process.
extern fn gegl_get_version(p_major: *c_int, p_minor: *c_int, p_micro: *c_int) void;
pub const getVersion = gegl_get_version;

/// Dump the bounds and format of each node in the graph to stdout.
extern fn gegl_graph_dump_outputs(p_node: *gegl.Node) void;
pub const graphDumpOutputs = gegl_graph_dump_outputs;

/// Dump the region that will be rendered for each node to fulfill
/// the request.
extern fn gegl_graph_dump_request(p_node: *gegl.Node, p_roi: *const gegl.Rectangle) void;
pub const graphDumpRequest = gegl_graph_dump_request;

extern fn gegl_has_operation(p_operation_type: [*:0]const u8) c_int;
pub const hasOperation = gegl_has_operation;

/// Call this function before using any other GEGL functions. It will
/// initialize everything needed to operate GEGL and parses some
/// standard command line options.  `argc` and `argv` are adjusted
/// accordingly so your own code will never see those standard
/// arguments.
///
/// Note that there is an alternative way to initialize GEGL: if you
/// are calling `glib.OptionContext.parse` with the option group returned
/// by `gegl.getOptionGroup``gegl.getOptionGroup`, you don't have to call `gegl.init``gegl.init`.
extern fn gegl_init(p_argc: ?*c_int, p_argv: ?*[*][*:0]u8) void;
pub const init = gegl_init;

extern fn gegl_is_main_thread() c_int;
pub const isMainThread = gegl_is_main_thread;

extern fn gegl_list_operations(p_n_operations_p: *c_uint) [*][*:0]u8;
pub const listOperations = gegl_list_operations;

/// Load all gegl modules found in the given directory.
extern fn gegl_load_module_directory(p_path: [*:0]const u8) void;
pub const loadModuleDirectory = gegl_load_module_directory;

/// Allocates `n_bytes` of memory. If `n_bytes` is 0, returns NULL.
///
/// Returns a pointer to the allocated memory.
extern fn gegl_malloc(p_n_bytes: usize) ?*anyopaque;
pub const malloc = gegl_malloc;

/// Checks if all the bytes of the memory block `ptr`, of size `size`,
/// are equal to zero.
extern fn gegl_memeq_zero(p_ptr: ?*const anyopaque, p_size: usize) c_int;
pub const memeqZero = gegl_memeq_zero;

/// Fill `dst_ptr` with `count` copies of the bytes in `src_ptr`.
extern fn gegl_memset_pattern(p_dst_ptr: ?*anyopaque, p_src_ptr: ?*const anyopaque, p_pattern_size: c_int, p_count: c_int) void;
pub const memsetPattern = gegl_memset_pattern;

/// Distributes the execution of a function across multiple threads,
/// by calling it with a different index on each thread.
extern fn gegl_parallel_distribute(p_max_n: c_int, p_func: gegl.ParallelDistributeFunc, p_user_data: ?*anyopaque) void;
pub const parallelDistribute = gegl_parallel_distribute;

/// Distributes the processing of a planar data-structure across
/// multiple threads, by calling the given function with different
/// sub-areas on different threads.
extern fn gegl_parallel_distribute_area(p_area: *const gegl.Rectangle, p_thread_cost: f64, p_split_strategy: gegl.SplitStrategy, p_func: gegl.ParallelDistributeAreaFunc, p_user_data: ?*anyopaque) void;
pub const parallelDistributeArea = gegl_parallel_distribute_area;

/// Distributes the processing of a linear data-structure across
/// multiple threads, by calling the given function with different
/// sub-ranges on different threads.
extern fn gegl_parallel_distribute_range(p_size: usize, p_thread_cost: f64, p_func: gegl.ParallelDistributeRangeFunc, p_user_data: ?*anyopaque) void;
pub const parallelDistributeRange = gegl_parallel_distribute_range;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.AudioFragment` property.
extern fn gegl_param_spec_audio_fragment(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecAudioFragment = gegl_param_spec_audio_fragment;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Color` property.
extern fn gegl_param_spec_color(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_color: *gegl.Color, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecColor = gegl_param_spec_color;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Color` property.
extern fn gegl_param_spec_color_from_string(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_color_string: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecColorFromString = gegl_param_spec_color_from_string;

/// Get the default color value of the param spec
extern fn gegl_param_spec_color_get_default(p_self: *gobject.ParamSpec) *gegl.Color;
pub const paramSpecColorGetDefault = gegl_param_spec_color_get_default;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Curve` property.
extern fn gegl_param_spec_curve(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_curve: *gegl.Curve, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecCurve = gegl_param_spec_curve;

/// Creates a new `gegl.ParamSpecDouble` instance.
extern fn gegl_param_spec_double(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_minimum: f64, p_maximum: f64, p_default_value: f64, p_ui_minimum: f64, p_ui_maximum: f64, p_ui_gamma: f64, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecDouble = gegl_param_spec_double;

/// Creates a new `gegl.ParamSpecEnum` instance.
extern fn gegl_param_spec_enum(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_enum_type: usize, p_default_value: c_int, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecEnum = gegl_param_spec_enum;

/// Creates a new `gegl.ParamSpecFilePath` instance.
extern fn gegl_param_spec_file_path(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_no_validate: c_int, p_null_ok: c_int, p_default_value: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecFilePath = gegl_param_spec_file_path;

/// Creates a new `gegl.ParamSpecFormat` instance specifying a Babl format.
extern fn gegl_param_spec_format(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecFormat = gegl_param_spec_format;

extern fn gegl_param_spec_get_property_key(p_pspec: *gobject.ParamSpec, p_key_name: [*:0]const u8) [*:0]const u8;
pub const paramSpecGetPropertyKey = gegl_param_spec_get_property_key;

/// Creates a new `gegl.ParamSpecInt` instance.
extern fn gegl_param_spec_int(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_minimum: c_int, p_maximum: c_int, p_default_value: c_int, p_ui_minimum: c_int, p_ui_maximum: c_int, p_ui_gamma: f64, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecInt = gegl_param_spec_int;

/// Creates a new `gobject.ParamSpec` instance specifying a `gegl.Path` property.
extern fn gegl_param_spec_path(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_default_path: *gegl.Path, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecPath = gegl_param_spec_path;

/// Creates a new `gegl.ParamSpecSeed` instance specifying an integer random seed.
extern fn gegl_param_spec_seed(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecSeed = gegl_param_spec_seed;

extern fn gegl_param_spec_set_property_key(p_pspec: *gobject.ParamSpec, p_key_name: [*:0]const u8, p_value: [*:0]const u8) void;
pub const paramSpecSetPropertyKey = gegl_param_spec_set_property_key;

/// Creates a new `gegl.ParamSpecString` instance.
extern fn gegl_param_spec_string(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_no_validate: c_int, p_null_ok: c_int, p_default_value: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecString = gegl_param_spec_string;

/// Creates a new `gegl.ParamSpecUri` instance.
extern fn gegl_param_spec_uri(p_name: [*:0]const u8, p_nick: [*:0]const u8, p_blurb: [*:0]const u8, p_no_validate: c_int, p_null_ok: c_int, p_default_value: [*:0]const u8, p_flags: gobject.ParamFlags) *gobject.ParamSpec;
pub const paramSpecUri = gegl_param_spec_uri;

/// Apply the operation to source_buffer, writing the results to target_buffer.
extern fn gegl_render_op(p_source_buffer: *gegl.Buffer, p_target_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, ...) void;
pub const renderOp = gegl_render_op;

/// Apply the operation to source_buffer, writing the results to target_buffer.
extern fn gegl_render_op_valist(p_source_buffer: *gegl.Buffer, p_target_buffer: *gegl.Buffer, p_operation_name: [*:0]const u8, p_var_args: std.builtin.VaList) void;
pub const renderOpValist = gegl_render_op_valist;

/// Resets the cumulative data gathered by the `gegl.Stats` object returned
/// by `gegl.stats``gegl.stats`.
extern fn gegl_reset_stats() void;
pub const resetStats = gegl_reset_stats;

/// Allocates `size` bytes of scratch memory.
///
/// Returns a pointer to the allocated memory.
extern fn gegl_scratch_alloc(p_size: usize) ?*anyopaque;
pub const scratchAlloc = gegl_scratch_alloc;

/// Allocates `size` bytes of scratch memory, initialized to zero.
///
/// Returns a pointer to the allocated memory.
extern fn gegl_scratch_alloc0(p_size: usize) ?*anyopaque;
pub const scratchAlloc0 = gegl_scratch_alloc0;

/// Frees the memory pointed to by `ptr`.
///
/// The memory must have been allocated using one of the scratch-memory
/// allocation functions.
extern fn gegl_scratch_free(p_ptr: ?*anyopaque) void;
pub const scratchFree = gegl_scratch_free;

extern fn gegl_serialize(p_start: *gegl.Node, p_end: *gegl.Node, p_basepath: [*:0]const u8, p_serialize_flags: gegl.SerializeFlag) [*:0]u8;
pub const serialize = gegl_serialize;

/// Returns a GeglStats object with properties that can be read to monitor
/// GEGL statistics.
extern fn gegl_stats() *gegl.Stats;
pub const stats = gegl_stats;

/// Allocates `n_bytes` of memory. If allocation fails, or if `n_bytes` is 0,
/// returns `NULL`.
///
/// Returns a pointer to the allocated memory, or NULL.
extern fn gegl_try_malloc(p_n_bytes: usize) ?*anyopaque;
pub const tryMalloc = gegl_try_malloc;

pub const FlattenerFunc = *const fn (p_original: *gegl.PathList) callconv(.c) *gegl.PathList;

pub const LookupFunction = *const fn (p_value: f32, p_data: ?*anyopaque) callconv(.c) f32;

pub const NodeFunction = *const fn (p_node: *const gegl.PathItem, p_user_data: ?*anyopaque) callconv(.c) void;

/// Specifies the type of function passed to
/// `gegl.parallelDistributeArea`.
///
/// The function should process the sub-area specified by `area`.
pub const ParallelDistributeAreaFunc = *const fn (p_area: *const gegl.Rectangle, p_user_data: ?*anyopaque) callconv(.c) void;

/// Specifies the type of function passed to `gegl.parallelDistribute`.
///
/// The function should process the `i`-th part of the data, out of `n`
/// equal parts.  `n` may be less-than or equal-to the `max_n` argument
/// passed to `gegl.parallelDistribute`.
pub const ParallelDistributeFunc = *const fn (p_i: c_int, p_n: c_int, p_user_data: ?*anyopaque) callconv(.c) void;

/// Specifies the type of function passed to
/// `gegl.parallelDistributeRange`.
///
/// The function should process `size` elements of the data, starting
/// at `offset`.
pub const ParallelDistributeRangeFunc = *const fn (p_offset: usize, p_size: usize, p_user_data: ?*anyopaque) callconv(.c) void;

pub const SamplerGetFun = *const fn (p_self: *gegl.Sampler, p_x: f64, p_y: f64, p_scale: *gegl.BufferMatrix2, p_output: ?*anyopaque, p_repeat_mode: gegl.AbyssPolicy) callconv(.c) void;

pub const TileCallback = *const fn (p_tile: *gegl.Tile, p_user_data: ?*anyopaque) callconv(.c) void;

pub const TileSourceCommand = *const fn (p_gegl_tile_source: *gegl.TileSource, p_command: gegl.TileCommand, p_x: c_int, p_y: c_int, p_z: c_int, p_data: ?*anyopaque) callconv(.c) ?*anyopaque;

pub const AUTO_ROWSTRIDE = 0;
pub const CH_BACK_CENTER = 256;
pub const CH_BACK_LEFT = 16;
pub const CH_BACK_RIGHT = 32;
pub const CH_FRONT_CENTER = 4;
pub const CH_FRONT_LEFT = 1;
pub const CH_FRONT_LEFT_OF_CENTER = 64;
pub const CH_FRONT_RIGHT = 2;
pub const CH_FRONT_RIGHT_OF_CENTER = 128;
pub const CH_LAYOUT_2POINT1 = 0;
pub const CH_LAYOUT_2_1 = 0;
pub const CH_LAYOUT_2_2 = 0;
pub const CH_LAYOUT_3POINT1 = 0;
pub const CH_LAYOUT_4POINT0 = 0;
pub const CH_LAYOUT_4POINT1 = 0;
pub const CH_LAYOUT_5POINT0 = 0;
pub const CH_LAYOUT_5POINT0_BACK = 0;
pub const CH_LAYOUT_5POINT1 = 0;
pub const CH_LAYOUT_5POINT1_BACK = 0;
pub const CH_LAYOUT_6POINT0 = 0;
pub const CH_LAYOUT_6POINT0_FRONT = 0;
pub const CH_LAYOUT_6POINT1 = 0;
pub const CH_LAYOUT_6POINT1_BACK = 0;
pub const CH_LAYOUT_6POINT1_FRONT = 0;
pub const CH_LAYOUT_7POINT0 = 0;
pub const CH_LAYOUT_7POINT0_FRONT = 0;
pub const CH_LAYOUT_7POINT1 = 0;
pub const CH_LAYOUT_7POINT1_WIDE = 0;
pub const CH_LAYOUT_7POINT1_WIDE_BACK = 0;
pub const CH_LAYOUT_HEXADECAGONAL = 0;
pub const CH_LAYOUT_HEXAGONAL = 0;
pub const CH_LAYOUT_NATIVE = 9223372036854775808;
pub const CH_LAYOUT_OCTAGONAL = 0;
pub const CH_LAYOUT_QUAD = 0;
pub const CH_LAYOUT_STEREO = 0;
pub const CH_LAYOUT_STEREO_DOWNMIX = 0;
pub const CH_LAYOUT_SURROUND = 0;
pub const CH_LOW_FREQUENCY = 8;
pub const CH_LOW_FREQUENCY_2 = 34359738368;
pub const CH_SIDE_LEFT = 512;
pub const CH_SIDE_RIGHT = 1024;
pub const CH_STEREO_LEFT = 536870912;
pub const CH_STEREO_RIGHT = 1073741824;
pub const CH_SURROUND_DIRECT_LEFT = 8589934592;
pub const CH_SURROUND_DIRECT_RIGHT = 17179869184;
pub const CH_TOP_BACK_CENTER = 65536;
pub const CH_TOP_BACK_LEFT = 32768;
pub const CH_TOP_BACK_RIGHT = 131072;
pub const CH_TOP_CENTER = 2048;
pub const CH_TOP_FRONT_CENTER = 8192;
pub const CH_TOP_FRONT_LEFT = 4096;
pub const CH_TOP_FRONT_RIGHT = 16384;
pub const CH_WIDE_LEFT = 2147483648;
pub const CH_WIDE_RIGHT = 4294967296;
pub const FLOAT_EPSILON = 0.000010;
pub const LOOKUP_MAX_ENTRIES = 819200;
pub const MAJOR_VERSION = 0;
pub const MAX_AUDIO_CHANNELS = 8;
pub const MICRO_VERSION = 58;
pub const MINOR_VERSION = 4;
pub const PARAM_NO_VALIDATE = 64;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
