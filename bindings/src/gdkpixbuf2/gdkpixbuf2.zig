pub const ext = @import("ext.zig");
const gdkpixbuf = @This();

const std = @import("std");
const compat = @import("compat");
const gio = @import("gio2");
const gobject = @import("gobject2");
const glib = @import("glib2");
const gmodule = @import("gmodule2");
/// A pixel buffer.
///
/// `GdkPixbuf` contains information about an image's pixel data,
/// its color space, bits per sample, width and height, and the
/// rowstride (the number of bytes between the start of one row
/// and the start of the next).
///
/// ## Creating new `GdkPixbuf`
///
/// The most basic way to create a pixbuf is to wrap an existing pixel
/// buffer with a `gdkpixbuf.Pixbuf` instance. You can use the
/// `gdkpixbuf.Pixbuf.newFromData` function to do this.
///
/// Every time you create a new `GdkPixbuf` instance for some data, you
/// will need to specify the destroy notification function that will be
/// called when the data buffer needs to be freed; this will happen when
/// a `GdkPixbuf` is finalized by the reference counting functions. If
/// you have a chunk of static data compiled into your application, you
/// can pass in `NULL` as the destroy notification function so that the
/// data will not be freed.
///
/// The `gdkpixbuf.Pixbuf.new` constructor function can be used
/// as a convenience to create a pixbuf with an empty buffer; this is
/// equivalent to allocating a data buffer using ``malloc`` and then
/// wrapping it with ``gdkpixbuf.Pixbuf.newFromData``. The ``gdkpixbuf.Pixbuf.new``
/// function will compute an optimal rowstride so that rendering can be
/// performed with an efficient algorithm.
///
/// As a special case, you can use the `gdkpixbuf.Pixbuf.newFromXpmData`
/// function to create a pixbuf from inline XPM image data.
///
/// You can also copy an existing pixbuf with the `Pixbuf.copy`
/// function. This is not the same as just acquiring a reference to
/// the old pixbuf instance: the copy function will actually duplicate
/// the pixel data in memory and create a new `Pixbuf` instance
/// for it.
///
/// ## Reference counting
///
/// `GdkPixbuf` structures are reference counted. This means that an
/// application can share a single pixbuf among many parts of the
/// code. When a piece of the program needs to use a pixbuf, it should
/// acquire a reference to it by calling ``gobject.Object.ref``; when it no
/// longer needs the pixbuf, it should release the reference it acquired
/// by calling ``gobject.Object.unref``. The resources associated with a
/// `GdkPixbuf` will be freed when its reference count drops to zero.
/// Newly-created `GdkPixbuf` instances start with a reference count
/// of one.
///
/// ## Image Data
///
/// Image data in a pixbuf is stored in memory in an uncompressed,
/// packed format. Rows in the image are stored top to bottom, and
/// in each row pixels are stored from left to right.
///
/// There may be padding at the end of a row.
///
/// The "rowstride" value of a pixbuf, as returned by `gdkpixbuf.Pixbuf.getRowstride`,
/// indicates the number of bytes between rows.
///
/// **NOTE**: If you are copying raw pixbuf data with ``memcpy`` note that the
/// last row in the pixbuf may not be as wide as the full rowstride, but rather
/// just as wide as the pixel data needs to be; that is: it is unsafe to do
/// `memcpy (dest, pixels, rowstride * height)` to copy a whole pixbuf. Use
/// `gdkpixbuf.Pixbuf.copy` instead, or compute the width in bytes of the
/// last row as:
///
/// ```c
/// last_row = width * ((n_channels * bits_per_sample + 7) / 8);
/// ```
///
/// The same rule applies when iterating over each row of a `GdkPixbuf` pixels
/// array.
///
/// The following code illustrates a simple ``put_pixel``
/// function for RGB pixbufs with 8 bits per channel with an alpha
/// channel.
///
/// ```c
/// static void
/// put_pixel (GdkPixbuf *pixbuf,
///            int x,
///        int y,
///        guchar red,
///        guchar green,
///        guchar blue,
///        guchar alpha)
/// {
///   int n_channels = gdk_pixbuf_get_n_channels (pixbuf);
///
///   // Ensure that the pixbuf is valid
///   g_assert (gdk_pixbuf_get_colorspace (pixbuf) == GDK_COLORSPACE_RGB);
///   g_assert (gdk_pixbuf_get_bits_per_sample (pixbuf) == 8);
///   g_assert (gdk_pixbuf_get_has_alpha (pixbuf));
///   g_assert (n_channels == 4);
///
///   int width = gdk_pixbuf_get_width (pixbuf);
///   int height = gdk_pixbuf_get_height (pixbuf);
///
///   // Ensure that the coordinates are in a valid range
///   g_assert (x >= 0 && x < width);
///   g_assert (y >= 0 && y < height);
///
///   int rowstride = gdk_pixbuf_get_rowstride (pixbuf);
///
///   // The pixel buffer in the GdkPixbuf instance
///   guchar *pixels = gdk_pixbuf_get_pixels (pixbuf);
///
///   // The pixel we wish to modify
///   guchar *p = pixels + y * rowstride + x * n_channels;
///   p[0] = red;
///   p[1] = green;
///   p[2] = blue;
///   p[3] = alpha;
/// }
/// ```
///
/// ## Loading images
///
/// The `GdkPixBuf` class provides a simple mechanism for loading
/// an image from a file in synchronous and asynchronous fashion.
///
/// For GUI applications, it is recommended to use the asynchronous
/// stream API to avoid blocking the control flow of the application.
///
/// Additionally, `GdkPixbuf` provides the `gdkpixbuf.@"PixbufLoader`"`
/// API for progressive image loading.
///
/// ## Saving images
///
/// The `GdkPixbuf` class provides methods for saving image data in
/// a number of file formats. The formatted data can be written to a
/// file or to a memory buffer. `GdkPixbuf` can also call a user-defined
/// callback on the data, which allows to e.g. write the image
/// to a socket or store it in a database.
pub const Pixbuf = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{ gio.Icon, gio.LoadableIcon };
    pub const Class = opaque {
        pub const Instance = Pixbuf;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The number of bits per sample.
        ///
        /// Currently only 8 bit per sample are supported.
        pub const bits_per_sample = struct {
            pub const name = "bits-per-sample";

            pub const Type = c_int;
        };

        /// The color space of the pixbuf.
        ///
        /// Currently, only `GDK_COLORSPACE_RGB` is supported.
        pub const colorspace = struct {
            pub const name = "colorspace";

            pub const Type = gdkpixbuf.Colorspace;
        };

        /// Whether the pixbuf has an alpha channel.
        pub const has_alpha = struct {
            pub const name = "has-alpha";

            pub const Type = c_int;
        };

        /// The number of rows of the pixbuf.
        pub const height = struct {
            pub const name = "height";

            pub const Type = c_int;
        };

        /// The number of samples per pixel.
        ///
        /// Currently, only 3 or 4 samples per pixel are supported.
        pub const n_channels = struct {
            pub const name = "n-channels";

            pub const Type = c_int;
        };

        pub const pixel_bytes = struct {
            pub const name = "pixel-bytes";

            pub const Type = ?*glib.Bytes;
        };

        /// A pointer to the pixel data of the pixbuf.
        pub const pixels = struct {
            pub const name = "pixels";

            pub const Type = ?*anyopaque;
        };

        /// The number of bytes between the start of a row and
        /// the start of the next row.
        ///
        /// This number must (obviously) be at least as large as the
        /// width of the pixbuf.
        pub const rowstride = struct {
            pub const name = "rowstride";

            pub const Type = c_int;
        };

        /// The number of columns of the pixbuf.
        pub const width = struct {
            pub const name = "width";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Calculates the rowstride that an image created with those values would
    /// have.
    ///
    /// This function is useful for front-ends and backends that want to check
    /// image values without needing to create a `GdkPixbuf`.
    extern fn gdk_pixbuf_calculate_rowstride(p_colorspace: gdkpixbuf.Colorspace, p_has_alpha: c_int, p_bits_per_sample: c_int, p_width: c_int, p_height: c_int) c_int;
    pub const calculateRowstride = gdk_pixbuf_calculate_rowstride;

    /// Parses an image file far enough to determine its format and size.
    extern fn gdk_pixbuf_get_file_info(p_filename: [*:0]const u8, p_width: ?*c_int, p_height: ?*c_int) ?*gdkpixbuf.PixbufFormat;
    pub const getFileInfo = gdk_pixbuf_get_file_info;

    /// Asynchronously parses an image file far enough to determine its
    /// format and size.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.getFileInfo`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the
    /// main thread. You can then call `gdkpixbuf.Pixbuf.getFileInfoFinish` to
    /// get the result of the operation.
    extern fn gdk_pixbuf_get_file_info_async(p_filename: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const getFileInfoAsync = gdk_pixbuf_get_file_info_async;

    /// Finishes an asynchronous pixbuf parsing operation started with
    /// `gdkpixbuf.Pixbuf.getFileInfoAsync`.
    extern fn gdk_pixbuf_get_file_info_finish(p_async_result: *gio.AsyncResult, p_width: *c_int, p_height: *c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufFormat;
    pub const getFileInfoFinish = gdk_pixbuf_get_file_info_finish;

    /// Obtains the available information about the image formats supported
    /// by GdkPixbuf.
    extern fn gdk_pixbuf_get_formats() *glib.SList;
    pub const getFormats = gdk_pixbuf_get_formats;

    /// Initalizes the gdk-pixbuf loader modules referenced by the `loaders.cache`
    /// file present inside that directory.
    ///
    /// This is to be used by applications that want to ship certain loaders
    /// in a different location from the system ones.
    ///
    /// This is needed when the OS or runtime ships a minimal number of loaders
    /// so as to reduce the potential attack surface of carefully crafted image
    /// files, especially for uncommon file types. Applications that require
    /// broader image file types coverage, such as image viewers, would be
    /// expected to ship the gdk-pixbuf modules in a separate location, bundled
    /// with the application in a separate directory from the OS or runtime-
    /// provided modules.
    extern fn gdk_pixbuf_init_modules(p_path: [*:0]const u8, p_error: ?*?*glib.Error) c_int;
    pub const initModules = gdk_pixbuf_init_modules;

    /// Creates a new pixbuf by asynchronously loading an image from an input stream.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.newFromStream`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the main thread.
    /// You can then call `gdkpixbuf.Pixbuf.newFromStreamFinish` to get the result of
    /// the operation.
    extern fn gdk_pixbuf_new_from_stream_async(p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const newFromStreamAsync = gdk_pixbuf_new_from_stream_async;

    /// Creates a new pixbuf by asynchronously loading an image from an input stream.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.newFromStreamAtScale`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the main thread.
    /// You can then call `gdkpixbuf.Pixbuf.newFromStreamFinish` to get the result of the operation.
    extern fn gdk_pixbuf_new_from_stream_at_scale_async(p_stream: *gio.InputStream, p_width: c_int, p_height: c_int, p_preserve_aspect_ratio: c_int, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const newFromStreamAtScaleAsync = gdk_pixbuf_new_from_stream_at_scale_async;

    /// Finishes an asynchronous pixbuf save operation started with
    /// `gdkpixbuf.Pixbuf.saveToStreamAsync`.
    extern fn gdk_pixbuf_save_to_stream_finish(p_async_result: *gio.AsyncResult, p_error: ?*?*glib.Error) c_int;
    pub const saveToStreamFinish = gdk_pixbuf_save_to_stream_finish;

    /// Creates a new `GdkPixbuf` structure and allocates a buffer for it.
    ///
    /// If the allocation of the buffer failed, this function will return `NULL`.
    ///
    /// The buffer has an optimal rowstride. Note that the buffer is not cleared;
    /// you will have to fill it completely yourself.
    extern fn gdk_pixbuf_new(p_colorspace: gdkpixbuf.Colorspace, p_has_alpha: c_int, p_bits_per_sample: c_int, p_width: c_int, p_height: c_int) ?*gdkpixbuf.Pixbuf;
    pub const new = gdk_pixbuf_new;

    /// Creates a new `gdkpixbuf.Pixbuf` out of in-memory readonly image data.
    ///
    /// Currently only RGB images with 8 bits per sample are supported.
    ///
    /// This is the `GBytes` variant of `gdkpixbuf.Pixbuf.newFromData`, useful
    /// for language bindings.
    extern fn gdk_pixbuf_new_from_bytes(p_data: *glib.Bytes, p_colorspace: gdkpixbuf.Colorspace, p_has_alpha: c_int, p_bits_per_sample: c_int, p_width: c_int, p_height: c_int, p_rowstride: c_int) *gdkpixbuf.Pixbuf;
    pub const newFromBytes = gdk_pixbuf_new_from_bytes;

    /// Creates a new `gdkpixbuf.Pixbuf` out of in-memory image data.
    ///
    /// Currently only RGB images with 8 bits per sample are supported.
    ///
    /// Since you are providing a pre-allocated pixel buffer, you must also
    /// specify a way to free that data.  This is done with a function of
    /// type `GdkPixbufDestroyNotify`.  When a pixbuf created with is
    /// finalized, your destroy notification function will be called, and
    /// it is its responsibility to free the pixel array.
    ///
    /// See also: `gdkpixbuf.Pixbuf.newFromBytes`
    extern fn gdk_pixbuf_new_from_data(p_data: [*]const u8, p_colorspace: gdkpixbuf.Colorspace, p_has_alpha: c_int, p_bits_per_sample: c_int, p_width: c_int, p_height: c_int, p_rowstride: c_int, p_destroy_fn: ?gdkpixbuf.PixbufDestroyNotify, p_destroy_fn_data: ?*anyopaque) *gdkpixbuf.Pixbuf;
    pub const newFromData = gdk_pixbuf_new_from_data;

    /// Creates a new pixbuf by loading an image from a file.
    ///
    /// The file format is detected automatically.
    ///
    /// If `NULL` is returned, then `error` will be set. Possible errors are:
    ///
    ///  - the file could not be opened
    ///  - there is no loader for the file's format
    ///  - there is not enough memory to allocate the image buffer
    ///  - the image buffer contains invalid data
    ///
    /// The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
    extern fn gdk_pixbuf_new_from_file(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromFile = gdk_pixbuf_new_from_file;

    /// Creates a new pixbuf by loading an image from a file.
    ///
    /// The file format is detected automatically.
    ///
    /// If `NULL` is returned, then `error` will be set. Possible errors are:
    ///
    ///  - the file could not be opened
    ///  - there is no loader for the file's format
    ///  - there is not enough memory to allocate the image buffer
    ///  - the image buffer contains invalid data
    ///
    /// The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
    ///
    /// The image will be scaled to fit in the requested size, optionally preserving
    /// the image's aspect ratio.
    ///
    /// When preserving the aspect ratio, a `width` of -1 will cause the image
    /// to be scaled to the exact given height, and a `height` of -1 will cause
    /// the image to be scaled to the exact given width. When not preserving
    /// aspect ratio, a `width` or `height` of -1 means to not scale the image
    /// at all in that dimension. Negative values for `width` and `height` are
    /// allowed since 2.8.
    extern fn gdk_pixbuf_new_from_file_at_scale(p_filename: [*:0]const u8, p_width: c_int, p_height: c_int, p_preserve_aspect_ratio: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromFileAtScale = gdk_pixbuf_new_from_file_at_scale;

    /// Creates a new pixbuf by loading an image from a file.
    ///
    /// The file format is detected automatically.
    ///
    /// If `NULL` is returned, then `error` will be set. Possible errors are:
    ///
    ///  - the file could not be opened
    ///  - there is no loader for the file's format
    ///  - there is not enough memory to allocate the image buffer
    ///  - the image buffer contains invalid data
    ///
    /// The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
    ///
    /// The image will be scaled to fit in the requested size, preserving
    /// the image's aspect ratio. Note that the returned pixbuf may be smaller
    /// than `width` x `height`, if the aspect ratio requires it. To load
    /// and image at the requested size, regardless of aspect ratio, use
    /// `gdkpixbuf.Pixbuf.newFromFileAtScale`.
    extern fn gdk_pixbuf_new_from_file_at_size(p_filename: [*:0]const u8, p_width: c_int, p_height: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromFileAtSize = gdk_pixbuf_new_from_file_at_size;

    /// Creates a `GdkPixbuf` from a flat representation that is suitable for
    /// storing as inline data in a program.
    ///
    /// This is useful if you want to ship a program with images, but don't want
    /// to depend on any external files.
    ///
    /// GdkPixbuf ships with a program called `gdk-pixbuf-csource`, which allows
    /// for conversion of `GdkPixbuf`s into such a inline representation.
    ///
    /// In almost all cases, you should pass the `--raw` option to
    /// `gdk-pixbuf-csource`. A sample invocation would be:
    ///
    /// ```
    /// gdk-pixbuf-csource --raw --name=myimage_inline myimage.png
    /// ```
    ///
    /// For the typical case where the inline pixbuf is read-only static data,
    /// you don't need to copy the pixel data unless you intend to write to
    /// it, so you can pass `FALSE` for `copy_pixels`. If you pass `--rle` to
    /// `gdk-pixbuf-csource`, a copy will be made even if `copy_pixels` is `FALSE`,
    /// so using this option is generally a bad idea.
    ///
    /// If you create a pixbuf from const inline data compiled into your
    /// program, it's probably safe to ignore errors and disable length checks,
    /// since things will always succeed:
    ///
    /// ```c
    /// pixbuf = gdk_pixbuf_new_from_inline (-1, myimage_inline, FALSE, NULL);
    /// ```
    ///
    /// For non-const inline data, you could get out of memory. For untrusted
    /// inline data located at runtime, you could have corrupt inline data in
    /// addition.
    extern fn gdk_pixbuf_new_from_inline(p_data_length: c_int, p_data: [*]const u8, p_copy_pixels: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromInline = gdk_pixbuf_new_from_inline;

    /// Creates a new pixbuf by loading an image from an resource.
    ///
    /// The file format is detected automatically. If `NULL` is returned, then
    /// `error` will be set.
    extern fn gdk_pixbuf_new_from_resource(p_resource_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromResource = gdk_pixbuf_new_from_resource;

    /// Creates a new pixbuf by loading an image from an resource.
    ///
    /// The file format is detected automatically. If `NULL` is returned, then
    /// `error` will be set.
    ///
    /// The image will be scaled to fit in the requested size, optionally
    /// preserving the image's aspect ratio. When preserving the aspect ratio,
    /// a `width` of -1 will cause the image to be scaled to the exact given
    /// height, and a `height` of -1 will cause the image to be scaled to the
    /// exact given width. When not preserving aspect ratio, a `width` or
    /// `height` of -1 means to not scale the image at all in that dimension.
    ///
    /// The stream is not closed.
    extern fn gdk_pixbuf_new_from_resource_at_scale(p_resource_path: [*:0]const u8, p_width: c_int, p_height: c_int, p_preserve_aspect_ratio: c_int, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromResourceAtScale = gdk_pixbuf_new_from_resource_at_scale;

    /// Creates a new pixbuf by loading an image from an input stream.
    ///
    /// The file format is detected automatically.
    ///
    /// If `NULL` is returned, then `error` will be set.
    ///
    /// The `cancellable` can be used to abort the operation from another thread.
    /// If the operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
    /// returned. Other possible errors are in the `GDK_PIXBUF_ERROR` and
    /// `G_IO_ERROR` domains.
    ///
    /// The stream is not closed.
    extern fn gdk_pixbuf_new_from_stream(p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromStream = gdk_pixbuf_new_from_stream;

    /// Creates a new pixbuf by loading an image from an input stream.
    ///
    /// The file format is detected automatically. If `NULL` is returned, then
    /// `error` will be set. The `cancellable` can be used to abort the operation
    /// from another thread. If the operation was cancelled, the error
    /// `G_IO_ERROR_CANCELLED` will be returned. Other possible errors are in
    /// the `GDK_PIXBUF_ERROR` and `G_IO_ERROR` domains.
    ///
    /// The image will be scaled to fit in the requested size, optionally
    /// preserving the image's aspect ratio.
    ///
    /// When preserving the aspect ratio, a `width` of -1 will cause the image to be
    /// scaled to the exact given height, and a `height` of -1 will cause the image
    /// to be scaled to the exact given width. If both `width` and `height` are
    /// given, this function will behave as if the smaller of the two values
    /// is passed as -1.
    ///
    /// When not preserving aspect ratio, a `width` or `height` of -1 means to not
    /// scale the image at all in that dimension.
    ///
    /// The stream is not closed.
    extern fn gdk_pixbuf_new_from_stream_at_scale(p_stream: *gio.InputStream, p_width: c_int, p_height: c_int, p_preserve_aspect_ratio: c_int, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromStreamAtScale = gdk_pixbuf_new_from_stream_at_scale;

    /// Finishes an asynchronous pixbuf creation operation started with
    /// `gdkpixbuf.Pixbuf.newFromStreamAsync`.
    extern fn gdk_pixbuf_new_from_stream_finish(p_async_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*gdkpixbuf.Pixbuf;
    pub const newFromStreamFinish = gdk_pixbuf_new_from_stream_finish;

    /// Creates a new pixbuf by parsing XPM data in memory.
    ///
    /// This data is commonly the result of including an XPM file into a
    /// program's C source.
    extern fn gdk_pixbuf_new_from_xpm_data(p_data: [*][*:0]const u8) *gdkpixbuf.Pixbuf;
    pub const newFromXpmData = gdk_pixbuf_new_from_xpm_data;

    /// Takes an existing pixbuf and adds an alpha channel to it.
    ///
    /// If the existing pixbuf already had an alpha channel, the channel
    /// values are copied from the original; otherwise, the alpha channel
    /// is initialized to 255 (full opacity).
    ///
    /// If `substitute_color` is `TRUE`, then the color specified by the
    /// (`r`, `g`, `b`) arguments will be assigned zero opacity. That is,
    /// if you pass `(255, 255, 255)` for the substitute color, all white
    /// pixels will become fully transparent.
    ///
    /// If `substitute_color` is `FALSE`, then the (`r`, `g`, `b`) arguments
    /// will be ignored.
    extern fn gdk_pixbuf_add_alpha(p_pixbuf: *const Pixbuf, p_substitute_color: c_int, p_r: u8, p_g: u8, p_b: u8) *gdkpixbuf.Pixbuf;
    pub const addAlpha = gdk_pixbuf_add_alpha;

    /// Takes an existing pixbuf and checks for the presence of an
    /// associated "orientation" option.
    ///
    /// The orientation option may be provided by the JPEG loader (which
    /// reads the exif orientation tag) or the TIFF loader (which reads
    /// the TIFF orientation tag, and compensates it for the partial
    /// transforms performed by libtiff).
    ///
    /// If an orientation option/tag is present, the appropriate transform
    /// will be performed so that the pixbuf is oriented correctly.
    extern fn gdk_pixbuf_apply_embedded_orientation(p_src: *Pixbuf) ?*gdkpixbuf.Pixbuf;
    pub const applyEmbeddedOrientation = gdk_pixbuf_apply_embedded_orientation;

    /// Creates a transformation of the source image `src` by scaling by
    /// `scale_x` and `scale_y` then translating by `offset_x` and `offset_y`.
    ///
    /// This gives an image in the coordinates of the destination pixbuf.
    /// The rectangle (`dest_x`, `dest_y`, `dest_width`, `dest_height`)
    /// is then alpha blended onto the corresponding rectangle of the
    /// original destination image.
    ///
    /// When the destination rectangle contains parts not in the source
    /// image, the data at the edges of the source image is replicated
    /// to infinity.
    ///
    /// ![](composite.png)
    extern fn gdk_pixbuf_composite(p_src: *const Pixbuf, p_dest: *gdkpixbuf.Pixbuf, p_dest_x: c_int, p_dest_y: c_int, p_dest_width: c_int, p_dest_height: c_int, p_offset_x: f64, p_offset_y: f64, p_scale_x: f64, p_scale_y: f64, p_interp_type: gdkpixbuf.InterpType, p_overall_alpha: c_int) void;
    pub const composite = gdk_pixbuf_composite;

    /// Creates a transformation of the source image `src` by scaling by
    /// `scale_x` and `scale_y` then translating by `offset_x` and `offset_y`,
    /// then alpha blends the rectangle (`dest_x` ,`dest_y`, `dest_width`,
    /// `dest_height`) of the resulting image with a checkboard of the
    /// colors `color1` and `color2` and renders it onto the destination
    /// image.
    ///
    /// If the source image has no alpha channel, and `overall_alpha` is 255, a fast
    /// path is used which omits the alpha blending and just performs the scaling.
    ///
    /// See `gdkpixbuf.Pixbuf.compositeColorSimple` for a simpler variant of this
    /// function suitable for many tasks.
    extern fn gdk_pixbuf_composite_color(p_src: *const Pixbuf, p_dest: *gdkpixbuf.Pixbuf, p_dest_x: c_int, p_dest_y: c_int, p_dest_width: c_int, p_dest_height: c_int, p_offset_x: f64, p_offset_y: f64, p_scale_x: f64, p_scale_y: f64, p_interp_type: gdkpixbuf.InterpType, p_overall_alpha: c_int, p_check_x: c_int, p_check_y: c_int, p_check_size: c_int, p_color1: u32, p_color2: u32) void;
    pub const compositeColor = gdk_pixbuf_composite_color;

    /// Creates a new pixbuf by scaling `src` to `dest_width` x `dest_height`
    /// and alpha blending the result with a checkboard of colors `color1`
    /// and `color2`.
    extern fn gdk_pixbuf_composite_color_simple(p_src: *const Pixbuf, p_dest_width: c_int, p_dest_height: c_int, p_interp_type: gdkpixbuf.InterpType, p_overall_alpha: c_int, p_check_size: c_int, p_color1: u32, p_color2: u32) ?*gdkpixbuf.Pixbuf;
    pub const compositeColorSimple = gdk_pixbuf_composite_color_simple;

    /// Creates a new `GdkPixbuf` with a copy of the information in the specified
    /// `pixbuf`.
    ///
    /// Note that this does not copy the options set on the original `GdkPixbuf`,
    /// use `gdkpixbuf.Pixbuf.copyOptions` for this.
    extern fn gdk_pixbuf_copy(p_pixbuf: *const Pixbuf) ?*gdkpixbuf.Pixbuf;
    pub const copy = gdk_pixbuf_copy;

    /// Copies a rectangular area from `src_pixbuf` to `dest_pixbuf`.
    ///
    /// Conversion of pixbuf formats is done automatically.
    ///
    /// If the source rectangle overlaps the destination rectangle on the
    /// same pixbuf, it will be overwritten during the copy operation.
    /// Therefore, you can not use this function to scroll a pixbuf.
    extern fn gdk_pixbuf_copy_area(p_src_pixbuf: *const Pixbuf, p_src_x: c_int, p_src_y: c_int, p_width: c_int, p_height: c_int, p_dest_pixbuf: *gdkpixbuf.Pixbuf, p_dest_x: c_int, p_dest_y: c_int) void;
    pub const copyArea = gdk_pixbuf_copy_area;

    /// Copies the key/value pair options attached to a `GdkPixbuf` to another
    /// `GdkPixbuf`.
    ///
    /// This is useful to keep original metadata after having manipulated
    /// a file. However be careful to remove metadata which you've already
    /// applied, such as the "orientation" option after rotating the image.
    extern fn gdk_pixbuf_copy_options(p_src_pixbuf: *Pixbuf, p_dest_pixbuf: *gdkpixbuf.Pixbuf) c_int;
    pub const copyOptions = gdk_pixbuf_copy_options;

    /// Clears a pixbuf to the given RGBA value, converting the RGBA value into
    /// the pixbuf's pixel format.
    ///
    /// The alpha component will be ignored if the pixbuf doesn't have an alpha
    /// channel.
    extern fn gdk_pixbuf_fill(p_pixbuf: *Pixbuf, p_pixel: u32) void;
    pub const fill = gdk_pixbuf_fill;

    /// Flips a pixbuf horizontally or vertically and returns the
    /// result in a new pixbuf.
    extern fn gdk_pixbuf_flip(p_src: *const Pixbuf, p_horizontal: c_int) ?*gdkpixbuf.Pixbuf;
    pub const flip = gdk_pixbuf_flip;

    /// Queries the number of bits per color sample in a pixbuf.
    extern fn gdk_pixbuf_get_bits_per_sample(p_pixbuf: *const Pixbuf) c_int;
    pub const getBitsPerSample = gdk_pixbuf_get_bits_per_sample;

    /// Returns the length of the pixel data, in bytes.
    extern fn gdk_pixbuf_get_byte_length(p_pixbuf: *const Pixbuf) usize;
    pub const getByteLength = gdk_pixbuf_get_byte_length;

    /// Queries the color space of a pixbuf.
    extern fn gdk_pixbuf_get_colorspace(p_pixbuf: *const Pixbuf) gdkpixbuf.Colorspace;
    pub const getColorspace = gdk_pixbuf_get_colorspace;

    /// Queries whether a pixbuf has an alpha channel (opacity information).
    extern fn gdk_pixbuf_get_has_alpha(p_pixbuf: *const Pixbuf) c_int;
    pub const getHasAlpha = gdk_pixbuf_get_has_alpha;

    /// Queries the height of a pixbuf.
    extern fn gdk_pixbuf_get_height(p_pixbuf: *const Pixbuf) c_int;
    pub const getHeight = gdk_pixbuf_get_height;

    /// Queries the number of channels of a pixbuf.
    extern fn gdk_pixbuf_get_n_channels(p_pixbuf: *const Pixbuf) c_int;
    pub const getNChannels = gdk_pixbuf_get_n_channels;

    /// Looks up `key` in the list of options that may have been attached to the
    /// `pixbuf` when it was loaded, or that may have been attached by another
    /// function using `gdkpixbuf.Pixbuf.setOption`.
    ///
    /// For instance, the ANI loader provides "Title" and "Artist" options.
    /// The ICO, XBM, and XPM loaders provide "x_hot" and "y_hot" hot-spot
    /// options for cursor definitions. The PNG loader provides the tEXt ancillary
    /// chunk key/value pairs as options. Since 2.12, the TIFF and JPEG loaders
    /// return an "orientation" option string that corresponds to the embedded
    /// TIFF/Exif orientation tag (if present). Since 2.32, the TIFF loader sets
    /// the "multipage" option string to "yes" when a multi-page TIFF is loaded.
    /// Since 2.32 the JPEG and PNG loaders set "x-dpi" and "y-dpi" if the file
    /// contains image density information in dots per inch.
    /// Since 2.36.6, the JPEG loader sets the "comment" option with the comment
    /// EXIF tag.
    extern fn gdk_pixbuf_get_option(p_pixbuf: *Pixbuf, p_key: [*:0]const u8) ?[*:0]const u8;
    pub const getOption = gdk_pixbuf_get_option;

    /// Returns a `GHashTable` with a list of all the options that may have been
    /// attached to the `pixbuf` when it was loaded, or that may have been
    /// attached by another function using `gdkpixbuf.Pixbuf.setOption`.
    extern fn gdk_pixbuf_get_options(p_pixbuf: *Pixbuf) *glib.HashTable;
    pub const getOptions = gdk_pixbuf_get_options;

    /// Queries a pointer to the pixel data of a pixbuf.
    ///
    /// This function will cause an implicit copy of the pixbuf data if the
    /// pixbuf was created from read-only data.
    ///
    /// Please see the section on [image data](class.Pixbuf.html`image`-data) for information
    /// about how the pixel data is stored in memory.
    extern fn gdk_pixbuf_get_pixels(p_pixbuf: *const Pixbuf) [*]u8;
    pub const getPixels = gdk_pixbuf_get_pixels;

    /// Queries a pointer to the pixel data of a pixbuf.
    ///
    /// This function will cause an implicit copy of the pixbuf data if the
    /// pixbuf was created from read-only data.
    ///
    /// Please see the section on [image data](class.Pixbuf.html`image`-data) for information
    /// about how the pixel data is stored in memory.
    extern fn gdk_pixbuf_get_pixels_with_length(p_pixbuf: *const Pixbuf, p_length: *c_uint) [*]u8;
    pub const getPixelsWithLength = gdk_pixbuf_get_pixels_with_length;

    /// Queries the rowstride of a pixbuf, which is the number of bytes between
    /// the start of a row and the start of the next row.
    extern fn gdk_pixbuf_get_rowstride(p_pixbuf: *const Pixbuf) c_int;
    pub const getRowstride = gdk_pixbuf_get_rowstride;

    /// Queries the width of a pixbuf.
    extern fn gdk_pixbuf_get_width(p_pixbuf: *const Pixbuf) c_int;
    pub const getWidth = gdk_pixbuf_get_width;

    /// Creates a new pixbuf which represents a sub-region of `src_pixbuf`.
    ///
    /// The new pixbuf shares its pixels with the original pixbuf, so
    /// writing to one affects both.  The new pixbuf holds a reference to
    /// `src_pixbuf`, so `src_pixbuf` will not be finalized until the new
    /// pixbuf is finalized.
    ///
    /// Note that if `src_pixbuf` is read-only, this function will force it
    /// to be mutable.
    extern fn gdk_pixbuf_new_subpixbuf(p_src_pixbuf: *Pixbuf, p_src_x: c_int, p_src_y: c_int, p_width: c_int, p_height: c_int) *gdkpixbuf.Pixbuf;
    pub const newSubpixbuf = gdk_pixbuf_new_subpixbuf;

    /// Provides a `glib.Bytes` buffer containing the raw pixel data; the data
    /// must not be modified.
    ///
    /// This function allows skipping the implicit copy that must be made
    /// if `gdkpixbuf.Pixbuf.getPixels` is called on a read-only pixbuf.
    extern fn gdk_pixbuf_read_pixel_bytes(p_pixbuf: *const Pixbuf) *glib.Bytes;
    pub const readPixelBytes = gdk_pixbuf_read_pixel_bytes;

    /// Provides a read-only pointer to the raw pixel data.
    ///
    /// This function allows skipping the implicit copy that must be made
    /// if `gdkpixbuf.Pixbuf.getPixels` is called on a read-only pixbuf.
    extern fn gdk_pixbuf_read_pixels(p_pixbuf: *const Pixbuf) *const u8;
    pub const readPixels = gdk_pixbuf_read_pixels;

    /// Adds a reference to a pixbuf.
    extern fn gdk_pixbuf_ref(p_pixbuf: *Pixbuf) *gdkpixbuf.Pixbuf;
    pub const ref = gdk_pixbuf_ref;

    /// Removes the key/value pair option attached to a `GdkPixbuf`.
    extern fn gdk_pixbuf_remove_option(p_pixbuf: *Pixbuf, p_key: [*:0]const u8) c_int;
    pub const removeOption = gdk_pixbuf_remove_option;

    /// Rotates a pixbuf by a multiple of 90 degrees, and returns the
    /// result in a new pixbuf.
    ///
    /// If `angle` is 0, this function will return a copy of `src`.
    extern fn gdk_pixbuf_rotate_simple(p_src: *const Pixbuf, p_angle: gdkpixbuf.PixbufRotation) ?*gdkpixbuf.Pixbuf;
    pub const rotateSimple = gdk_pixbuf_rotate_simple;

    /// Modifies saturation and optionally pixelates `src`, placing the result in
    /// `dest`.
    ///
    /// The `src` and `dest` pixbufs must have the same image format, size, and
    /// rowstride.
    ///
    /// The `src` and `dest` arguments may be the same pixbuf with no ill effects.
    ///
    /// If `saturation` is 1.0 then saturation is not changed. If it's less than 1.0,
    /// saturation is reduced (the image turns toward grayscale); if greater than
    /// 1.0, saturation is increased (the image gets more vivid colors).
    ///
    /// If `pixelate` is `TRUE`, then pixels are faded in a checkerboard pattern to
    /// create a pixelated image.
    extern fn gdk_pixbuf_saturate_and_pixelate(p_src: *const Pixbuf, p_dest: *gdkpixbuf.Pixbuf, p_saturation: f32, p_pixelate: c_int) void;
    pub const saturateAndPixelate = gdk_pixbuf_saturate_and_pixelate;

    /// Saves pixbuf to a file in format `type`. By default, "jpeg", "png", "ico"
    /// and "bmp" are possible file formats to save in, but more formats may be
    /// installed. The list of all writable formats can be determined in the
    /// following way:
    ///
    /// ```c
    /// void add_if_writable (GdkPixbufFormat *data, GSList **list)
    /// {
    ///   if (gdk_pixbuf_format_is_writable (data))
    ///     *list = g_slist_prepend (*list, data);
    /// }
    ///
    /// GSList *formats = gdk_pixbuf_get_formats ();
    /// GSList *writable_formats = NULL;
    /// g_slist_foreach (formats, add_if_writable, &writable_formats);
    /// g_slist_free (formats);
    /// ```
    ///
    /// If `error` is set, `FALSE` will be returned. Possible errors include
    /// those in the `GDK_PIXBUF_ERROR` domain and those in the `G_FILE_ERROR`
    /// domain.
    ///
    /// The variable argument list should be `NULL`-terminated; if not empty,
    /// it should contain pairs of strings that modify the save
    /// parameters. For example:
    ///
    /// ```c
    /// gdk_pixbuf_save (pixbuf, handle, "jpeg", &error, "quality", "100", NULL);
    /// ```
    ///
    /// Currently only few parameters exist.
    ///
    /// JPEG images can be saved with a "quality" parameter; its value should be
    /// in the range `[0, 100]`. JPEG and PNG density can be set by setting the
    /// "x-dpi" and "y-dpi" parameters to the appropriate values in dots per inch.
    ///
    /// Text chunks can be attached to PNG images by specifying parameters of
    /// the form "tEXt::key", where key is an ASCII string of length 1-79.
    /// The values are UTF-8 encoded strings. The PNG compression level can
    /// be specified using the "compression" parameter; it's value is in an
    /// integer in the range of `[0, 9]`.
    ///
    /// ICC color profiles can also be embedded into PNG, JPEG and TIFF images.
    /// The "icc-profile" value should be the complete ICC profile encoded
    /// into base64.
    ///
    /// ```c
    /// char *contents;
    /// gsize length;
    ///
    /// // icm_path is set elsewhere
    /// g_file_get_contents (icm_path, &contents, &length, NULL);
    ///
    /// char *contents_encode = g_base64_encode ((const guchar *) contents, length);
    ///
    /// gdk_pixbuf_save (pixbuf, handle, "png", &error, "icc-profile", contents_encode, NULL);
    /// ```
    ///
    /// TIFF images recognize:
    ///
    ///  1. a "bits-per-sample" option (integer) which can be either 1 for saving
    ///     bi-level CCITTFAX4 images, or 8 for saving 8-bits per sample
    ///  2. a "compression" option (integer) which can be 1 for no compression,
    ///     2 for Huffman, 5 for LZW, 7 for JPEG and 8 for DEFLATE (see the libtiff
    ///     documentation and tiff.h for all supported codec values)
    ///  3. an "icc-profile" option (zero-terminated string) containing a base64
    ///     encoded ICC color profile.
    ///
    /// ICO images can be saved in depth 16, 24, or 32, by using the "depth"
    /// parameter. When the ICO saver is given "x_hot" and "y_hot" parameters,
    /// it produces a CUR instead of an ICO.
    extern fn gdk_pixbuf_save(p_pixbuf: *Pixbuf, p_filename: [*:0]const u8, p_type: [*:0]const u8, p_error: ?**glib.Error, ...) c_int;
    pub const save = gdk_pixbuf_save;

    /// Saves pixbuf to a new buffer in format `type`, which is currently "jpeg",
    /// "png", "tiff", "ico" or "bmp".
    ///
    /// This is a convenience function that uses ``gdkpixbuf.Pixbuf.saveToCallback``
    /// to do the real work.
    ///
    /// Note that the buffer is not `NUL`-terminated and may contain embedded `NUL`
    /// characters.
    ///
    /// If `error` is set, `FALSE` will be returned and `buffer` will be set to
    /// `NULL`. Possible errors include those in the `GDK_PIXBUF_ERROR`
    /// domain.
    ///
    /// See ``gdkpixbuf.Pixbuf.save`` for more details.
    extern fn gdk_pixbuf_save_to_buffer(p_pixbuf: *Pixbuf, p_buffer: *[*]u8, p_buffer_size: *usize, p_type: [*:0]const u8, p_error: ?**glib.Error, ...) c_int;
    pub const saveToBuffer = gdk_pixbuf_save_to_buffer;

    /// Vector version of ``gdkpixbuf.Pixbuf.saveToBuffer``.
    ///
    /// Saves pixbuf to a new buffer in format `type`, which is currently "jpeg",
    /// "tiff", "png", "ico" or "bmp".
    ///
    /// See `gdkpixbuf.Pixbuf.saveToBuffer` for more details.
    extern fn gdk_pixbuf_save_to_bufferv(p_pixbuf: *Pixbuf, p_buffer: *[*]u8, p_buffer_size: *usize, p_type: [*:0]const u8, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const saveToBufferv = gdk_pixbuf_save_to_bufferv;

    /// Saves pixbuf in format `type` by feeding the produced data to a
    /// callback.
    ///
    /// This function can be used when you want to store the image to something
    /// other than a file, such as an in-memory buffer or a socket.
    ///
    /// If `error` is set, `FALSE` will be returned. Possible errors
    /// include those in the `GDK_PIXBUF_ERROR` domain and whatever the save
    /// function generates.
    ///
    /// See `gdkpixbuf.Pixbuf.save` for more details.
    extern fn gdk_pixbuf_save_to_callback(p_pixbuf: *Pixbuf, p_save_func: gdkpixbuf.PixbufSaveFunc, p_user_data: ?*anyopaque, p_type: [*:0]const u8, p_error: ?**glib.Error, ...) c_int;
    pub const saveToCallback = gdk_pixbuf_save_to_callback;

    /// Vector version of ``gdkpixbuf.Pixbuf.saveToCallback``.
    ///
    /// Saves pixbuf to a callback in format `type`, which is currently "jpeg",
    /// "png", "tiff", "ico" or "bmp".
    ///
    /// If `error` is set, `FALSE` will be returned.
    ///
    /// See `gdkpixbuf.Pixbuf.saveToCallback` for more details.
    extern fn gdk_pixbuf_save_to_callbackv(p_pixbuf: *Pixbuf, p_save_func: gdkpixbuf.PixbufSaveFunc, p_user_data: ?*anyopaque, p_type: [*:0]const u8, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const saveToCallbackv = gdk_pixbuf_save_to_callbackv;

    /// Saves `pixbuf` to an output stream.
    ///
    /// Supported file formats are currently "jpeg", "tiff", "png", "ico" or
    /// "bmp". See ``gdkpixbuf.Pixbuf.saveToBuffer`` for more details.
    ///
    /// The `cancellable` can be used to abort the operation from another
    /// thread. If the operation was cancelled, the error `G_IO_ERROR_CANCELLED`
    /// will be returned. Other possible errors are in the `GDK_PIXBUF_ERROR`
    /// and `G_IO_ERROR` domains.
    ///
    /// The stream is not closed at the end of this call.
    extern fn gdk_pixbuf_save_to_stream(p_pixbuf: *Pixbuf, p_stream: *gio.OutputStream, p_type: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_error: ?**glib.Error, ...) c_int;
    pub const saveToStream = gdk_pixbuf_save_to_stream;

    /// Saves `pixbuf` to an output stream asynchronously.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.saveToStream`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the main thread.
    ///
    /// You can then call `gdkpixbuf.Pixbuf.saveToStreamFinish` to get the result of
    /// the operation.
    extern fn gdk_pixbuf_save_to_stream_async(p_pixbuf: *Pixbuf, p_stream: *gio.OutputStream, p_type: [*:0]const u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque, ...) void;
    pub const saveToStreamAsync = gdk_pixbuf_save_to_stream_async;

    /// Saves `pixbuf` to an output stream.
    ///
    /// Supported file formats are currently "jpeg", "tiff", "png", "ico" or
    /// "bmp".
    ///
    /// See `gdkpixbuf.Pixbuf.saveToStream` for more details.
    extern fn gdk_pixbuf_save_to_streamv(p_pixbuf: *Pixbuf, p_stream: *gio.OutputStream, p_type: [*:0]const u8, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) c_int;
    pub const saveToStreamv = gdk_pixbuf_save_to_streamv;

    /// Saves `pixbuf` to an output stream asynchronously.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.saveToStreamv`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the main thread.
    ///
    /// You can then call `gdkpixbuf.Pixbuf.saveToStreamFinish` to get the result of
    /// the operation.
    extern fn gdk_pixbuf_save_to_streamv_async(p_pixbuf: *Pixbuf, p_stream: *gio.OutputStream, p_type: [*:0]const u8, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const saveToStreamvAsync = gdk_pixbuf_save_to_streamv_async;

    /// Vector version of ``gdkpixbuf.Pixbuf.save``.
    ///
    /// Saves pixbuf to a file in `type`, which is currently "jpeg", "png", "tiff", "ico" or "bmp".
    ///
    /// If `error` is set, `FALSE` will be returned.
    ///
    /// See `gdkpixbuf.Pixbuf.save` for more details.
    extern fn gdk_pixbuf_savev(p_pixbuf: *Pixbuf, p_filename: [*:0]const u8, p_type: [*:0]const u8, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_error: ?*?*glib.Error) c_int;
    pub const savev = gdk_pixbuf_savev;

    /// Creates a transformation of the source image `src` by scaling by
    /// `scale_x` and `scale_y` then translating by `offset_x` and `offset_y`,
    /// then renders the rectangle (`dest_x`, `dest_y`, `dest_width`,
    /// `dest_height`) of the resulting image onto the destination image
    /// replacing the previous contents.
    ///
    /// Try to use `gdkpixbuf.Pixbuf.scaleSimple` first; this function is
    /// the industrial-strength power tool you can fall back to, if
    /// `gdkpixbuf.Pixbuf.scaleSimple` isn't powerful enough.
    ///
    /// If the source rectangle overlaps the destination rectangle on the
    /// same pixbuf, it will be overwritten during the scaling which
    /// results in rendering artifacts.
    extern fn gdk_pixbuf_scale(p_src: *const Pixbuf, p_dest: *gdkpixbuf.Pixbuf, p_dest_x: c_int, p_dest_y: c_int, p_dest_width: c_int, p_dest_height: c_int, p_offset_x: f64, p_offset_y: f64, p_scale_x: f64, p_scale_y: f64, p_interp_type: gdkpixbuf.InterpType) void;
    pub const scale = gdk_pixbuf_scale;

    /// Create a new pixbuf containing a copy of `src` scaled to
    /// `dest_width` x `dest_height`.
    ///
    /// This function leaves `src` unaffected.
    ///
    /// The `interp_type` should be `GDK_INTERP_NEAREST` if you want maximum
    /// speed (but when scaling down `GDK_INTERP_NEAREST` is usually unusably
    /// ugly). The default `interp_type` should be `GDK_INTERP_BILINEAR` which
    /// offers reasonable quality and speed.
    ///
    /// You can scale a sub-portion of `src` by creating a sub-pixbuf
    /// pointing into `src`; see `gdkpixbuf.Pixbuf.newSubpixbuf`.
    ///
    /// If `dest_width` and `dest_height` are equal to the width and height of
    /// `src`, this function will return an unscaled copy of `src`.
    ///
    /// For more complicated scaling/alpha blending see `gdkpixbuf.Pixbuf.scale`
    /// and `gdkpixbuf.Pixbuf.composite`.
    extern fn gdk_pixbuf_scale_simple(p_src: *const Pixbuf, p_dest_width: c_int, p_dest_height: c_int, p_interp_type: gdkpixbuf.InterpType) ?*gdkpixbuf.Pixbuf;
    pub const scaleSimple = gdk_pixbuf_scale_simple;

    /// Attaches a key/value pair as an option to a `GdkPixbuf`.
    ///
    /// If `key` already exists in the list of options attached to the `pixbuf`,
    /// the new value is ignored and `FALSE` is returned.
    extern fn gdk_pixbuf_set_option(p_pixbuf: *Pixbuf, p_key: [*:0]const u8, p_value: [*:0]const u8) c_int;
    pub const setOption = gdk_pixbuf_set_option;

    /// Removes a reference from a pixbuf.
    extern fn gdk_pixbuf_unref(p_pixbuf: *Pixbuf) void;
    pub const unref = gdk_pixbuf_unref;

    extern fn gdk_pixbuf_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_get_type;

    pub fn as(p_instance: *Pixbuf, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque object representing an animation.
///
/// The GdkPixBuf library provides a simple mechanism to load and
/// represent animations. An animation is conceptually a series of
/// frames to be displayed over time.
///
/// The animation may not be represented as a series of frames
/// internally; for example, it may be stored as a sprite and
/// instructions for moving the sprite around a background.
///
/// To display an animation you don't need to understand its
/// representation, however; you just ask `GdkPixbuf` what should
/// be displayed at a given point in time.
pub const PixbufAnimation = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdkpixbuf.PixbufAnimationClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Get an iterator for displaying an animation.
        ///
        /// The iterator provides the frames that should be displayed at a
        /// given time.
        ///
        /// `start_time` would normally come from `glib.getCurrentTime`, and marks
        /// the beginning of animation playback. After creating an iterator, you
        /// should immediately display the pixbuf returned by
        /// `gdkpixbuf.PixbufAnimationIter.getPixbuf`. Then, you should install
        /// a timeout (with `glib.timeoutAdd`) or by some other mechanism ensure
        /// that you'll update the image after
        /// `gdkpixbuf.PixbufAnimationIter.getDelayTime` milliseconds. Each time
        /// the image is updated, you should reinstall the timeout with the new,
        /// possibly-changed delay time.
        ///
        /// As a shortcut, if `start_time` is `NULL`, the result of
        /// `glib.getCurrentTime` will be used automatically.
        ///
        /// To update the image (i.e. possibly change the result of
        /// `gdkpixbuf.PixbufAnimationIter.getPixbuf` to a new frame of the animation),
        /// call `gdkpixbuf.PixbufAnimationIter.advance`.
        ///
        /// If you're using `gdkpixbuf.PixbufLoader`, in addition to updating the image
        /// after the delay time, you should also update it whenever you
        /// receive the area_updated signal and
        /// `gdkpixbuf.PixbufAnimationIter.onCurrentlyLoadingFrame` returns
        /// `TRUE`. In this case, the frame currently being fed into the loader
        /// has received new data, so needs to be refreshed. The delay time for
        /// a frame may also be modified after an area_updated signal, for
        /// example if the delay time for a frame is encoded in the data after
        /// the frame itself. So your timeout should be reinstalled after any
        /// area_updated signal.
        ///
        /// A delay time of -1 is possible, indicating "infinite".
        pub const get_iter = struct {
            pub fn call(p_class: anytype, p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_time: ?*const glib.TimeVal) *gdkpixbuf.PixbufAnimationIter {
                return gobject.ext.as(PixbufAnimation.Class, p_class).f_get_iter.?(gobject.ext.as(PixbufAnimation, p_animation), p_start_time);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_time: ?*const glib.TimeVal) callconv(.c) *gdkpixbuf.PixbufAnimationIter) void {
                gobject.ext.as(PixbufAnimation.Class, p_class).f_get_iter = @ptrCast(p_implementation);
            }
        };

        pub const get_size = struct {
            pub fn call(p_class: anytype, p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: *c_int, p_height: *c_int) void {
                return gobject.ext.as(PixbufAnimation.Class, p_class).f_get_size.?(gobject.ext.as(PixbufAnimation, p_animation), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: *c_int, p_height: *c_int) callconv(.c) void) void {
                gobject.ext.as(PixbufAnimation.Class, p_class).f_get_size = @ptrCast(p_implementation);
            }
        };

        /// Retrieves a static image for the animation.
        ///
        /// If an animation is really just a plain image (has only one frame),
        /// this function returns that image.
        ///
        /// If the animation is an animation, this function returns a reasonable
        /// image to use as a static unanimated image, which might be the first
        /// frame, or something more sophisticated depending on the file format.
        ///
        /// If an animation hasn't loaded any frames yet, this function will
        /// return `NULL`.
        pub const get_static_image = struct {
            pub fn call(p_class: anytype, p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gdkpixbuf.Pixbuf {
                return gobject.ext.as(PixbufAnimation.Class, p_class).f_get_static_image.?(gobject.ext.as(PixbufAnimation, p_animation));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gdkpixbuf.Pixbuf) void {
                gobject.ext.as(PixbufAnimation.Class, p_class).f_get_static_image = @ptrCast(p_implementation);
            }
        };

        /// Checks whether the animation is a static image.
        ///
        /// If you load a file with `gdkpixbuf.PixbufAnimation.newFromFile` and it
        /// turns out to be a plain, unanimated image, then this function will
        /// return `TRUE`. Use `gdkpixbuf.PixbufAnimation.getStaticImage` to retrieve
        /// the image.
        pub const is_static_image = struct {
            pub fn call(p_class: anytype, p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(PixbufAnimation.Class, p_class).f_is_static_image.?(gobject.ext.as(PixbufAnimation, p_animation));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_animation: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(PixbufAnimation.Class, p_class).f_is_static_image = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new animation by asynchronously loading an image from an input stream.
    ///
    /// For more details see `gdkpixbuf.Pixbuf.newFromStream`, which is the synchronous
    /// version of this function.
    ///
    /// When the operation is finished, `callback` will be called in the main thread.
    /// You can then call `gdkpixbuf.PixbufAnimation.newFromStreamFinish` to get the
    /// result of the operation.
    extern fn gdk_pixbuf_animation_new_from_stream_async(p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_callback: ?gio.AsyncReadyCallback, p_user_data: ?*anyopaque) void;
    pub const newFromStreamAsync = gdk_pixbuf_animation_new_from_stream_async;

    /// Creates a new animation by loading it from a file.
    ///
    /// The file format is detected automatically.
    ///
    /// If the file's format does not support multi-frame images, then an animation
    /// with a single frame will be created.
    ///
    /// Possible errors are in the `GDK_PIXBUF_ERROR` and `G_FILE_ERROR` domains.
    extern fn gdk_pixbuf_animation_new_from_file(p_filename: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufAnimation;
    pub const newFromFile = gdk_pixbuf_animation_new_from_file;

    /// Creates a new pixbuf animation by loading an image from an resource.
    ///
    /// The file format is detected automatically. If `NULL` is returned, then
    /// `error` will be set.
    extern fn gdk_pixbuf_animation_new_from_resource(p_resource_path: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufAnimation;
    pub const newFromResource = gdk_pixbuf_animation_new_from_resource;

    /// Creates a new animation by loading it from an input stream.
    ///
    /// The file format is detected automatically.
    ///
    /// If `NULL` is returned, then `error` will be set.
    ///
    /// The `cancellable` can be used to abort the operation from another thread.
    /// If the operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
    /// returned. Other possible errors are in the `GDK_PIXBUF_ERROR` and
    /// `G_IO_ERROR` domains.
    ///
    /// The stream is not closed.
    extern fn gdk_pixbuf_animation_new_from_stream(p_stream: *gio.InputStream, p_cancellable: ?*gio.Cancellable, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufAnimation;
    pub const newFromStream = gdk_pixbuf_animation_new_from_stream;

    /// Finishes an asynchronous pixbuf animation creation operation started with
    /// `gdkpixbuf.PixbufAnimation.newFromStreamAsync`.
    extern fn gdk_pixbuf_animation_new_from_stream_finish(p_async_result: *gio.AsyncResult, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufAnimation;
    pub const newFromStreamFinish = gdk_pixbuf_animation_new_from_stream_finish;

    /// Queries the height of the bounding box of a pixbuf animation.
    extern fn gdk_pixbuf_animation_get_height(p_animation: *PixbufAnimation) c_int;
    pub const getHeight = gdk_pixbuf_animation_get_height;

    /// Get an iterator for displaying an animation.
    ///
    /// The iterator provides the frames that should be displayed at a
    /// given time.
    ///
    /// `start_time` would normally come from `glib.getCurrentTime`, and marks
    /// the beginning of animation playback. After creating an iterator, you
    /// should immediately display the pixbuf returned by
    /// `gdkpixbuf.PixbufAnimationIter.getPixbuf`. Then, you should install
    /// a timeout (with `glib.timeoutAdd`) or by some other mechanism ensure
    /// that you'll update the image after
    /// `gdkpixbuf.PixbufAnimationIter.getDelayTime` milliseconds. Each time
    /// the image is updated, you should reinstall the timeout with the new,
    /// possibly-changed delay time.
    ///
    /// As a shortcut, if `start_time` is `NULL`, the result of
    /// `glib.getCurrentTime` will be used automatically.
    ///
    /// To update the image (i.e. possibly change the result of
    /// `gdkpixbuf.PixbufAnimationIter.getPixbuf` to a new frame of the animation),
    /// call `gdkpixbuf.PixbufAnimationIter.advance`.
    ///
    /// If you're using `gdkpixbuf.PixbufLoader`, in addition to updating the image
    /// after the delay time, you should also update it whenever you
    /// receive the area_updated signal and
    /// `gdkpixbuf.PixbufAnimationIter.onCurrentlyLoadingFrame` returns
    /// `TRUE`. In this case, the frame currently being fed into the loader
    /// has received new data, so needs to be refreshed. The delay time for
    /// a frame may also be modified after an area_updated signal, for
    /// example if the delay time for a frame is encoded in the data after
    /// the frame itself. So your timeout should be reinstalled after any
    /// area_updated signal.
    ///
    /// A delay time of -1 is possible, indicating "infinite".
    extern fn gdk_pixbuf_animation_get_iter(p_animation: *PixbufAnimation, p_start_time: ?*const glib.TimeVal) *gdkpixbuf.PixbufAnimationIter;
    pub const getIter = gdk_pixbuf_animation_get_iter;

    /// Retrieves a static image for the animation.
    ///
    /// If an animation is really just a plain image (has only one frame),
    /// this function returns that image.
    ///
    /// If the animation is an animation, this function returns a reasonable
    /// image to use as a static unanimated image, which might be the first
    /// frame, or something more sophisticated depending on the file format.
    ///
    /// If an animation hasn't loaded any frames yet, this function will
    /// return `NULL`.
    extern fn gdk_pixbuf_animation_get_static_image(p_animation: *PixbufAnimation) *gdkpixbuf.Pixbuf;
    pub const getStaticImage = gdk_pixbuf_animation_get_static_image;

    /// Queries the width of the bounding box of a pixbuf animation.
    extern fn gdk_pixbuf_animation_get_width(p_animation: *PixbufAnimation) c_int;
    pub const getWidth = gdk_pixbuf_animation_get_width;

    /// Checks whether the animation is a static image.
    ///
    /// If you load a file with `gdkpixbuf.PixbufAnimation.newFromFile` and it
    /// turns out to be a plain, unanimated image, then this function will
    /// return `TRUE`. Use `gdkpixbuf.PixbufAnimation.getStaticImage` to retrieve
    /// the image.
    extern fn gdk_pixbuf_animation_is_static_image(p_animation: *PixbufAnimation) c_int;
    pub const isStaticImage = gdk_pixbuf_animation_is_static_image;

    /// Adds a reference to an animation.
    extern fn gdk_pixbuf_animation_ref(p_animation: *PixbufAnimation) *gdkpixbuf.PixbufAnimation;
    pub const ref = gdk_pixbuf_animation_ref;

    /// Removes a reference from an animation.
    extern fn gdk_pixbuf_animation_unref(p_animation: *PixbufAnimation) void;
    pub const unref = gdk_pixbuf_animation_unref;

    extern fn gdk_pixbuf_animation_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_animation_get_type;

    pub fn as(p_instance: *PixbufAnimation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque object representing an iterator which points to a
/// certain position in an animation.
pub const PixbufAnimationIter = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdkpixbuf.PixbufAnimationIterClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        /// Possibly advances an animation to a new frame.
        ///
        /// Chooses the frame based on the start time passed to
        /// `gdkpixbuf.PixbufAnimation.getIter`.
        ///
        /// `current_time` would normally come from `glib.getCurrentTime`, and
        /// must be greater than or equal to the time passed to
        /// `gdkpixbuf.PixbufAnimation.getIter`, and must increase or remain
        /// unchanged each time `gdkpixbuf.PixbufAnimationIter.getPixbuf` is
        /// called. That is, you can't go backward in time; animations only
        /// play forward.
        ///
        /// As a shortcut, pass `NULL` for the current time and `glib.getCurrentTime`
        /// will be invoked on your behalf. So you only need to explicitly pass
        /// `current_time` if you're doing something odd like playing the animation
        /// at double speed.
        ///
        /// If this function returns `FALSE`, there's no need to update the animation
        /// display, assuming the display had been rendered prior to advancing;
        /// if `TRUE`, you need to call `gdkpixbuf.PixbufAnimationIter.getPixbuf`
        /// and update the display with the new pixbuf.
        pub const advance = struct {
            pub fn call(p_class: anytype, p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_time: ?*const glib.TimeVal) c_int {
                return gobject.ext.as(PixbufAnimationIter.Class, p_class).f_advance.?(gobject.ext.as(PixbufAnimationIter, p_iter), p_current_time);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_current_time: ?*const glib.TimeVal) callconv(.c) c_int) void {
                gobject.ext.as(PixbufAnimationIter.Class, p_class).f_advance = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of milliseconds the current pixbuf should be displayed,
        /// or -1 if the current pixbuf should be displayed forever.
        ///
        /// The ``glib.timeoutAdd`` function conveniently takes a timeout in milliseconds,
        /// so you can use a timeout to schedule the next update.
        ///
        /// Note that some formats, like GIF, might clamp the timeout values in the
        /// image file to avoid updates that are just too quick. The minimum timeout
        /// for GIF images is currently 20 milliseconds.
        pub const get_delay_time = struct {
            pub fn call(p_class: anytype, p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(PixbufAnimationIter.Class, p_class).f_get_delay_time.?(gobject.ext.as(PixbufAnimationIter, p_iter));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(PixbufAnimationIter.Class, p_class).f_get_delay_time = @ptrCast(p_implementation);
            }
        };

        /// Gets the current pixbuf which should be displayed.
        ///
        /// The pixbuf might not be the same size as the animation itself
        /// (`gdkpixbuf.PixbufAnimation.getWidth`, `gdkpixbuf.PixbufAnimation.getHeight`).
        ///
        /// This pixbuf should be displayed for `gdkpixbuf.PixbufAnimationIter.getDelayTime`
        /// milliseconds.
        ///
        /// The caller of this function does not own a reference to the returned
        /// pixbuf; the returned pixbuf will become invalid when the iterator
        /// advances to the next frame, which may happen anytime you call
        /// `gdkpixbuf.PixbufAnimationIter.advance`.
        ///
        /// Copy the pixbuf to keep it (don't just add a reference), as it may get
        /// recycled as you advance the iterator.
        pub const get_pixbuf = struct {
            pub fn call(p_class: anytype, p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gdkpixbuf.Pixbuf {
                return gobject.ext.as(PixbufAnimationIter.Class, p_class).f_get_pixbuf.?(gobject.ext.as(PixbufAnimationIter, p_iter));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gdkpixbuf.Pixbuf) void {
                gobject.ext.as(PixbufAnimationIter.Class, p_class).f_get_pixbuf = @ptrCast(p_implementation);
            }
        };

        /// Used to determine how to respond to the area_updated signal on
        /// `gdkpixbuf.PixbufLoader` when loading an animation.
        ///
        /// The `::area_updated` signal is emitted for an area of the frame currently
        /// streaming in to the loader. So if you're on the currently loading frame,
        /// you will need to redraw the screen for the updated area.
        pub const on_currently_loading_frame = struct {
            pub fn call(p_class: anytype, p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(PixbufAnimationIter.Class, p_class).f_on_currently_loading_frame.?(gobject.ext.as(PixbufAnimationIter, p_iter));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_iter: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(PixbufAnimationIter.Class, p_class).f_on_currently_loading_frame = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Possibly advances an animation to a new frame.
    ///
    /// Chooses the frame based on the start time passed to
    /// `gdkpixbuf.PixbufAnimation.getIter`.
    ///
    /// `current_time` would normally come from `glib.getCurrentTime`, and
    /// must be greater than or equal to the time passed to
    /// `gdkpixbuf.PixbufAnimation.getIter`, and must increase or remain
    /// unchanged each time `gdkpixbuf.PixbufAnimationIter.getPixbuf` is
    /// called. That is, you can't go backward in time; animations only
    /// play forward.
    ///
    /// As a shortcut, pass `NULL` for the current time and `glib.getCurrentTime`
    /// will be invoked on your behalf. So you only need to explicitly pass
    /// `current_time` if you're doing something odd like playing the animation
    /// at double speed.
    ///
    /// If this function returns `FALSE`, there's no need to update the animation
    /// display, assuming the display had been rendered prior to advancing;
    /// if `TRUE`, you need to call `gdkpixbuf.PixbufAnimationIter.getPixbuf`
    /// and update the display with the new pixbuf.
    extern fn gdk_pixbuf_animation_iter_advance(p_iter: *PixbufAnimationIter, p_current_time: ?*const glib.TimeVal) c_int;
    pub const advance = gdk_pixbuf_animation_iter_advance;

    /// Gets the number of milliseconds the current pixbuf should be displayed,
    /// or -1 if the current pixbuf should be displayed forever.
    ///
    /// The ``glib.timeoutAdd`` function conveniently takes a timeout in milliseconds,
    /// so you can use a timeout to schedule the next update.
    ///
    /// Note that some formats, like GIF, might clamp the timeout values in the
    /// image file to avoid updates that are just too quick. The minimum timeout
    /// for GIF images is currently 20 milliseconds.
    extern fn gdk_pixbuf_animation_iter_get_delay_time(p_iter: *PixbufAnimationIter) c_int;
    pub const getDelayTime = gdk_pixbuf_animation_iter_get_delay_time;

    /// Gets the current pixbuf which should be displayed.
    ///
    /// The pixbuf might not be the same size as the animation itself
    /// (`gdkpixbuf.PixbufAnimation.getWidth`, `gdkpixbuf.PixbufAnimation.getHeight`).
    ///
    /// This pixbuf should be displayed for `gdkpixbuf.PixbufAnimationIter.getDelayTime`
    /// milliseconds.
    ///
    /// The caller of this function does not own a reference to the returned
    /// pixbuf; the returned pixbuf will become invalid when the iterator
    /// advances to the next frame, which may happen anytime you call
    /// `gdkpixbuf.PixbufAnimationIter.advance`.
    ///
    /// Copy the pixbuf to keep it (don't just add a reference), as it may get
    /// recycled as you advance the iterator.
    extern fn gdk_pixbuf_animation_iter_get_pixbuf(p_iter: *PixbufAnimationIter) *gdkpixbuf.Pixbuf;
    pub const getPixbuf = gdk_pixbuf_animation_iter_get_pixbuf;

    /// Used to determine how to respond to the area_updated signal on
    /// `gdkpixbuf.PixbufLoader` when loading an animation.
    ///
    /// The `::area_updated` signal is emitted for an area of the frame currently
    /// streaming in to the loader. So if you're on the currently loading frame,
    /// you will need to redraw the screen for the updated area.
    extern fn gdk_pixbuf_animation_iter_on_currently_loading_frame(p_iter: *PixbufAnimationIter) c_int;
    pub const onCurrentlyLoadingFrame = gdk_pixbuf_animation_iter_on_currently_loading_frame;

    extern fn gdk_pixbuf_animation_iter_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_animation_iter_get_type;

    extern fn g_object_ref(p_self: *gdkpixbuf.PixbufAnimationIter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkpixbuf.PixbufAnimationIter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PixbufAnimationIter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Incremental image loader.
///
/// `GdkPixbufLoader` provides a way for applications to drive the
/// process of loading an image, by letting them send the image data
/// directly to the loader instead of having the loader read the data
/// from a file. Applications can use this functionality instead of
/// ``gdkpixbuf.Pixbuf.newFromFile`` or ``gdkpixbuf.PixbufAnimation.newFromFile``
/// when they need to parse image data in small chunks. For example,
/// it should be used when reading an image from a (potentially) slow
/// network connection, or when loading an extremely large file.
///
/// To use `GdkPixbufLoader` to load an image, create a new instance,
/// and call `gdkpixbuf.PixbufLoader.write` to send the data
/// to it. When done, `gdkpixbuf.PixbufLoader.close` should be
/// called to end the stream and finalize everything.
///
/// The loader will emit three important signals throughout the process:
///
///  - `gdkpixbuf.PixbufLoader.signals.size_prepared` will be emitted as
///    soon as the image has enough information to determine the size of
///    the image to be used. If you want to scale the image while loading
///    it, you can call `gdkpixbuf.PixbufLoader.setSize` in
///    response to this signal.
///  - `gdkpixbuf.PixbufLoader.signals.area_prepared` will be emitted as
///    soon as the pixbuf of the desired has been allocated. You can obtain
///    the `GdkPixbuf` instance by calling `gdkpixbuf.PixbufLoader.getPixbuf`.
///    If you want to use it, simply acquire a reference to it. You can
///    also call ``gdkpixbuf.PixbufLoader.getPixbuf`` later to get the same
///    pixbuf.
///  - `gdkpixbuf.PixbufLoader.signals.area_updated` will be emitted every
///    time a region is updated. This way you can update a partially
///    completed image. Note that you do not know anything about the
///    completeness of an image from the updated area. For example, in an
///    interlaced image you will need to make several passes before the
///    image is done loading.
///
/// ## Loading an animation
///
/// Loading an animation is almost as easy as loading an image. Once the
/// first `gdkpixbuf.PixbufLoader.signals.area_prepared` signal has been
/// emitted, you can call `gdkpixbuf.PixbufLoader.getAnimation` to
/// get the `gdkpixbuf.PixbufAnimation` instance, and then call
/// and `gdkpixbuf.PixbufAnimation.getIter` to get a
/// `gdkpixbuf.PixbufAnimationIter` to retrieve the pixbuf for the
/// desired time stamp.
pub const PixbufLoader = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdkpixbuf.PixbufLoaderClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*anyopaque,

    pub const virtual_methods = struct {
        pub const area_prepared = struct {
            pub fn call(p_class: anytype, p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(PixbufLoader.Class, p_class).f_area_prepared.?(gobject.ext.as(PixbufLoader, p_loader));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(PixbufLoader.Class, p_class).f_area_prepared = @ptrCast(p_implementation);
            }
        };

        pub const area_updated = struct {
            pub fn call(p_class: anytype, p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void {
                return gobject.ext.as(PixbufLoader.Class, p_class).f_area_updated.?(gobject.ext.as(PixbufLoader, p_loader), p_x, p_y, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void) void {
                gobject.ext.as(PixbufLoader.Class, p_class).f_area_updated = @ptrCast(p_implementation);
            }
        };

        pub const closed = struct {
            pub fn call(p_class: anytype, p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(PixbufLoader.Class, p_class).f_closed.?(gobject.ext.as(PixbufLoader, p_loader));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(PixbufLoader.Class, p_class).f_closed = @ptrCast(p_implementation);
            }
        };

        pub const size_prepared = struct {
            pub fn call(p_class: anytype, p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) void {
                return gobject.ext.as(PixbufLoader.Class, p_class).f_size_prepared.?(gobject.ext.as(PixbufLoader, p_loader), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_loader: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) callconv(.c) void) void {
                gobject.ext.as(PixbufLoader.Class, p_class).f_size_prepared = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal is emitted when the pixbuf loader has allocated the
        /// pixbuf in the desired size.
        ///
        /// After this signal is emitted, applications can call
        /// `gdkpixbuf.PixbufLoader.getPixbuf` to fetch the partially-loaded
        /// pixbuf.
        pub const area_prepared = struct {
            pub const name = "area-prepared";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PixbufLoader, p_instance))),
                    gobject.signalLookup("area-prepared", PixbufLoader.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when a significant area of the image being
        /// loaded has been updated.
        ///
        /// Normally it means that a complete scanline has been read in, but
        /// it could be a different area as well.
        ///
        /// Applications can use this signal to know when to repaint
        /// areas of an image that is being loaded.
        pub const area_updated = struct {
            pub const name = "area-updated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PixbufLoader, p_instance))),
                    gobject.signalLookup("area-updated", PixbufLoader.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when `gdkpixbuf.PixbufLoader.close` is called.
        ///
        /// It can be used by different parts of an application to receive
        /// notification when an image loader is closed by the code that
        /// drives it.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PixbufLoader, p_instance))),
                    gobject.signalLookup("closed", PixbufLoader.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted when the pixbuf loader has been fed the
        /// initial amount of data that is required to figure out the size
        /// of the image that it will create.
        ///
        /// Applications can call `gdkpixbuf.PixbufLoader.setSize` in response
        /// to this signal to set the desired size to which the image
        /// should be scaled.
        pub const size_prepared = struct {
            pub const name = "size-prepared";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_width: c_int, p_height: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PixbufLoader, p_instance))),
                    gobject.signalLookup("size-prepared", PixbufLoader.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new pixbuf loader object.
    extern fn gdk_pixbuf_loader_new() *gdkpixbuf.PixbufLoader;
    pub const new = gdk_pixbuf_loader_new;

    /// Creates a new pixbuf loader object that always attempts to parse
    /// image data as if it were an image of MIME type `mime_type`, instead of
    /// identifying the type automatically.
    ///
    /// This function is useful if you want an error if the image isn't the
    /// expected MIME type; for loading image formats that can't be reliably
    /// identified by looking at the data; or if the user manually forces a
    /// specific MIME type.
    ///
    /// The list of supported mime types depends on what image loaders
    /// are installed, but typically "image/png", "image/jpeg", "image/gif",
    /// "image/tiff" and "image/x-xpixmap" are among the supported mime types.
    /// To obtain the full list of supported mime types, call
    /// `gdkpixbuf.PixbufFormat.getMimeTypes` on each of the `gdkpixbuf.PixbufFormat`
    /// structs returned by `gdkpixbuf.Pixbuf.getFormats`.
    extern fn gdk_pixbuf_loader_new_with_mime_type(p_mime_type: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufLoader;
    pub const newWithMimeType = gdk_pixbuf_loader_new_with_mime_type;

    /// Creates a new pixbuf loader object that always attempts to parse
    /// image data as if it were an image of type `image_type`, instead of
    /// identifying the type automatically.
    ///
    /// This function is useful if you want an error if the image isn't the
    /// expected type; for loading image formats that can't be reliably
    /// identified by looking at the data; or if the user manually forces
    /// a specific type.
    ///
    /// The list of supported image formats depends on what image loaders
    /// are installed, but typically "png", "jpeg", "gif", "tiff" and
    /// "xpm" are among the supported formats. To obtain the full list of
    /// supported image formats, call `gdkpixbuf.PixbufFormat.getName` on each
    /// of the `gdkpixbuf.PixbufFormat` structs returned by `gdkpixbuf.Pixbuf.getFormats`.
    extern fn gdk_pixbuf_loader_new_with_type(p_image_type: [*:0]const u8, p_error: ?*?*glib.Error) ?*gdkpixbuf.PixbufLoader;
    pub const newWithType = gdk_pixbuf_loader_new_with_type;

    /// Informs a pixbuf loader that no further writes with
    /// `gdkpixbuf.PixbufLoader.write` will occur, so that it can free its
    /// internal loading structures.
    ///
    /// This function also tries to parse any data that hasn't yet been parsed;
    /// if the remaining data is partial or corrupt, an error will be returned.
    ///
    /// If `FALSE` is returned, `error` will be set to an error from the
    /// `GDK_PIXBUF_ERROR` or `G_FILE_ERROR` domains.
    ///
    /// If you're just cancelling a load rather than expecting it to be finished,
    /// passing `NULL` for `error` to ignore it is reasonable.
    ///
    /// Remember that this function does not release a reference on the loader, so
    /// you will need to explicitly release any reference you hold.
    extern fn gdk_pixbuf_loader_close(p_loader: *PixbufLoader, p_error: ?*?*glib.Error) c_int;
    pub const close = gdk_pixbuf_loader_close;

    /// Queries the `gdkpixbuf.PixbufAnimation` that a pixbuf loader is currently creating.
    ///
    /// In general it only makes sense to call this function after the
    /// `gdkpixbuf.PixbufLoader.signals.area_prepared` signal has been emitted by
    /// the loader.
    ///
    /// If the loader doesn't have enough bytes yet, and hasn't emitted the `area-prepared`
    /// signal, this function will return `NULL`.
    extern fn gdk_pixbuf_loader_get_animation(p_loader: *PixbufLoader) ?*gdkpixbuf.PixbufAnimation;
    pub const getAnimation = gdk_pixbuf_loader_get_animation;

    /// Obtains the available information about the format of the
    /// currently loading image file.
    extern fn gdk_pixbuf_loader_get_format(p_loader: *PixbufLoader) ?*gdkpixbuf.PixbufFormat;
    pub const getFormat = gdk_pixbuf_loader_get_format;

    /// Queries the `gdkpixbuf.Pixbuf` that a pixbuf loader is currently creating.
    ///
    /// In general it only makes sense to call this function after the
    /// `gdkpixbuf.PixbufLoader.signals.area_prepared` signal has been
    /// emitted by the loader; this means that enough data has been read
    /// to know the size of the image that will be allocated.
    ///
    /// If the loader has not received enough data via `gdkpixbuf.PixbufLoader.write`,
    /// then this function returns `NULL`.
    ///
    /// The returned pixbuf will be the same in all future calls to the loader,
    /// so if you want to keep using it, you should acquire a reference to it.
    ///
    /// Additionally, if the loader is an animation, it will return the "static
    /// image" of the animation (see `gdkpixbuf.PixbufAnimation.getStaticImage`).
    extern fn gdk_pixbuf_loader_get_pixbuf(p_loader: *PixbufLoader) ?*gdkpixbuf.Pixbuf;
    pub const getPixbuf = gdk_pixbuf_loader_get_pixbuf;

    /// Causes the image to be scaled while it is loaded.
    ///
    /// The desired image size can be determined relative to the original
    /// size of the image by calling `gdkpixbuf.PixbufLoader.setSize` from a
    /// signal handler for the ::size-prepared signal.
    ///
    /// Attempts to set the desired image size  are ignored after the
    /// emission of the ::size-prepared signal.
    extern fn gdk_pixbuf_loader_set_size(p_loader: *PixbufLoader, p_width: c_int, p_height: c_int) void;
    pub const setSize = gdk_pixbuf_loader_set_size;

    /// Parses the next `count` bytes in the given image buffer.
    extern fn gdk_pixbuf_loader_write(p_loader: *PixbufLoader, p_buf: [*]const u8, p_count: usize, p_error: ?*?*glib.Error) c_int;
    pub const write = gdk_pixbuf_loader_write;

    /// Parses the next contents of the given image buffer.
    extern fn gdk_pixbuf_loader_write_bytes(p_loader: *PixbufLoader, p_buffer: *glib.Bytes, p_error: ?*?*glib.Error) c_int;
    pub const writeBytes = gdk_pixbuf_loader_write_bytes;

    extern fn gdk_pixbuf_loader_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_loader_get_type;

    extern fn g_object_ref(p_self: *gdkpixbuf.PixbufLoader) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkpixbuf.PixbufLoader) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PixbufLoader, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PixbufNonAnim = opaque {
    pub const Parent = gdkpixbuf.PixbufAnimation;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = PixbufNonAnim;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_pixbuf_non_anim_new(p_pixbuf: *gdkpixbuf.Pixbuf) *gdkpixbuf.PixbufNonAnim;
    pub const new = gdk_pixbuf_non_anim_new;

    extern fn gdk_pixbuf_non_anim_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_non_anim_get_type;

    extern fn g_object_ref(p_self: *gdkpixbuf.PixbufNonAnim) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkpixbuf.PixbufNonAnim) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PixbufNonAnim, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque struct representing a simple animation.
pub const PixbufSimpleAnim = opaque {
    pub const Parent = gdkpixbuf.PixbufAnimation;
    pub const Implements = [_]type{};
    pub const Class = gdkpixbuf.PixbufSimpleAnimClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the animation should loop when it reaches the end.
        pub const loop = struct {
            pub const name = "loop";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a new, empty animation.
    extern fn gdk_pixbuf_simple_anim_new(p_width: c_int, p_height: c_int, p_rate: f32) *gdkpixbuf.PixbufSimpleAnim;
    pub const new = gdk_pixbuf_simple_anim_new;

    /// Adds a new frame to `animation`. The `pixbuf` must
    /// have the dimensions specified when the animation
    /// was constructed.
    extern fn gdk_pixbuf_simple_anim_add_frame(p_animation: *PixbufSimpleAnim, p_pixbuf: *gdkpixbuf.Pixbuf) void;
    pub const addFrame = gdk_pixbuf_simple_anim_add_frame;

    /// Gets whether `animation` should loop indefinitely when it reaches the end.
    extern fn gdk_pixbuf_simple_anim_get_loop(p_animation: *PixbufSimpleAnim) c_int;
    pub const getLoop = gdk_pixbuf_simple_anim_get_loop;

    /// Sets whether `animation` should loop indefinitely when it reaches the end.
    extern fn gdk_pixbuf_simple_anim_set_loop(p_animation: *PixbufSimpleAnim, p_loop: c_int) void;
    pub const setLoop = gdk_pixbuf_simple_anim_set_loop;

    extern fn gdk_pixbuf_simple_anim_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_simple_anim_get_type;

    extern fn g_object_ref(p_self: *gdkpixbuf.PixbufSimpleAnim) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkpixbuf.PixbufSimpleAnim) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PixbufSimpleAnim, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PixbufSimpleAnimIter = opaque {
    pub const Parent = gdkpixbuf.PixbufAnimationIter;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = PixbufSimpleAnimIter;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gdk_pixbuf_simple_anim_iter_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_simple_anim_iter_get_type;

    extern fn g_object_ref(p_self: *gdkpixbuf.PixbufSimpleAnimIter) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdkpixbuf.PixbufSimpleAnimIter) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PixbufSimpleAnimIter, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Modules supporting animations must derive a type from
/// `gdkpixbuf.PixbufAnimation`, providing suitable implementations of the
/// virtual functions.
pub const PixbufAnimationClass = extern struct {
    pub const Instance = gdkpixbuf.PixbufAnimation;

    /// the parent class
    f_parent_class: gobject.ObjectClass,
    f_is_static_image: ?*const fn (p_animation: *gdkpixbuf.PixbufAnimation) callconv(.c) c_int,
    f_get_static_image: ?*const fn (p_animation: *gdkpixbuf.PixbufAnimation) callconv(.c) *gdkpixbuf.Pixbuf,
    f_get_size: ?*const fn (p_animation: *gdkpixbuf.PixbufAnimation, p_width: *c_int, p_height: *c_int) callconv(.c) void,
    f_get_iter: ?*const fn (p_animation: *gdkpixbuf.PixbufAnimation, p_start_time: ?*const glib.TimeVal) callconv(.c) *gdkpixbuf.PixbufAnimationIter,

    pub fn as(p_instance: *PixbufAnimationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Modules supporting animations must derive a type from
/// `gdkpixbuf.PixbufAnimationIter`, providing suitable implementations of the
/// virtual functions.
pub const PixbufAnimationIterClass = extern struct {
    pub const Instance = gdkpixbuf.PixbufAnimationIter;

    /// the parent class
    f_parent_class: gobject.ObjectClass,
    f_get_delay_time: ?*const fn (p_iter: *gdkpixbuf.PixbufAnimationIter) callconv(.c) c_int,
    f_get_pixbuf: ?*const fn (p_iter: *gdkpixbuf.PixbufAnimationIter) callconv(.c) *gdkpixbuf.Pixbuf,
    f_on_currently_loading_frame: ?*const fn (p_iter: *gdkpixbuf.PixbufAnimationIter) callconv(.c) c_int,
    f_advance: ?*const fn (p_iter: *gdkpixbuf.PixbufAnimationIter, p_current_time: ?*const glib.TimeVal) callconv(.c) c_int,

    pub fn as(p_instance: *PixbufAnimationIterClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GdkPixbufFormat` contains information about the image format accepted
/// by a module.
///
/// Only modules should access the fields directly, applications should
/// use the `gdk_pixbuf_format_*` family of functions.
pub const PixbufFormat = extern struct {
    /// the name of the image format
    f_name: ?[*:0]u8,
    /// the signature of the module
    f_signature: ?*gdkpixbuf.PixbufModulePattern,
    /// the message domain for the `description`
    f_domain: ?[*:0]u8,
    /// a description of the image format
    f_description: ?[*:0]u8,
    /// the MIME types for the image format
    f_mime_types: ?[*][*:0]u8,
    /// typical filename extensions for the
    ///   image format
    f_extensions: ?[*][*:0]u8,
    /// a combination of `GdkPixbufFormatFlags`
    f_flags: u32,
    /// a boolean determining whether the loader is disabled`
    f_disabled: c_int,
    /// a string containing license information, typically set to
    ///   shorthands like "GPL", "LGPL", etc.
    f_license: ?[*:0]u8,

    /// Creates a copy of `format`.
    extern fn gdk_pixbuf_format_copy(p_format: *const PixbufFormat) *gdkpixbuf.PixbufFormat;
    pub const copy = gdk_pixbuf_format_copy;

    /// Frees the resources allocated when copying a `GdkPixbufFormat`
    /// using `gdkpixbuf.PixbufFormat.copy`
    extern fn gdk_pixbuf_format_free(p_format: *PixbufFormat) void;
    pub const free = gdk_pixbuf_format_free;

    /// Returns a description of the format.
    extern fn gdk_pixbuf_format_get_description(p_format: *PixbufFormat) [*:0]u8;
    pub const getDescription = gdk_pixbuf_format_get_description;

    /// Returns the filename extensions typically used for files in the
    /// given format.
    extern fn gdk_pixbuf_format_get_extensions(p_format: *PixbufFormat) [*][*:0]u8;
    pub const getExtensions = gdk_pixbuf_format_get_extensions;

    /// Returns information about the license of the image loader for the format.
    ///
    /// The returned string should be a shorthand for a well known license, e.g.
    /// "LGPL", "GPL", "QPL", "GPL/QPL", or "other" to indicate some other license.
    extern fn gdk_pixbuf_format_get_license(p_format: *PixbufFormat) [*:0]u8;
    pub const getLicense = gdk_pixbuf_format_get_license;

    /// Returns the mime types supported by the format.
    extern fn gdk_pixbuf_format_get_mime_types(p_format: *PixbufFormat) [*][*:0]u8;
    pub const getMimeTypes = gdk_pixbuf_format_get_mime_types;

    /// Returns the name of the format.
    extern fn gdk_pixbuf_format_get_name(p_format: *PixbufFormat) [*:0]u8;
    pub const getName = gdk_pixbuf_format_get_name;

    /// Returns whether this image format is disabled.
    ///
    /// See `gdkpixbuf.PixbufFormat.setDisabled`.
    extern fn gdk_pixbuf_format_is_disabled(p_format: *PixbufFormat) c_int;
    pub const isDisabled = gdk_pixbuf_format_is_disabled;

    /// Returns `TRUE` if the save option specified by `option_key` is supported when
    /// saving a pixbuf using the module implementing `format`.
    ///
    /// See `gdkpixbuf.Pixbuf.save` for more information about option keys.
    extern fn gdk_pixbuf_format_is_save_option_supported(p_format: *PixbufFormat, p_option_key: [*:0]const u8) c_int;
    pub const isSaveOptionSupported = gdk_pixbuf_format_is_save_option_supported;

    /// Returns whether this image format is scalable.
    ///
    /// If a file is in a scalable format, it is preferable to load it at
    /// the desired size, rather than loading it at the default size and
    /// scaling the resulting pixbuf to the desired size.
    extern fn gdk_pixbuf_format_is_scalable(p_format: *PixbufFormat) c_int;
    pub const isScalable = gdk_pixbuf_format_is_scalable;

    /// Returns whether pixbufs can be saved in the given format.
    extern fn gdk_pixbuf_format_is_writable(p_format: *PixbufFormat) c_int;
    pub const isWritable = gdk_pixbuf_format_is_writable;

    /// Disables or enables an image format.
    ///
    /// If a format is disabled, GdkPixbuf won't use the image loader for
    /// this format to load images.
    ///
    /// Applications can use this to avoid using image loaders with an
    /// inappropriate license, see `gdkpixbuf.PixbufFormat.getLicense`.
    extern fn gdk_pixbuf_format_set_disabled(p_format: *PixbufFormat, p_disabled: c_int) void;
    pub const setDisabled = gdk_pixbuf_format_set_disabled;

    extern fn gdk_pixbuf_format_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_format_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PixbufLoaderClass = extern struct {
    pub const Instance = gdkpixbuf.PixbufLoader;

    f_parent_class: gobject.ObjectClass,
    f_size_prepared: ?*const fn (p_loader: *gdkpixbuf.PixbufLoader, p_width: c_int, p_height: c_int) callconv(.c) void,
    f_area_prepared: ?*const fn (p_loader: *gdkpixbuf.PixbufLoader) callconv(.c) void,
    f_area_updated: ?*const fn (p_loader: *gdkpixbuf.PixbufLoader, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) callconv(.c) void,
    f_closed: ?*const fn (p_loader: *gdkpixbuf.PixbufLoader) callconv(.c) void,

    pub fn as(p_instance: *PixbufLoaderClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `GdkPixbufModule` contains the necessary functions to load and save
/// images in a certain file format.
///
/// If `GdkPixbuf` has been compiled with `GModule` support, it can be extended
/// by modules which can load (and perhaps also save) new image and animation
/// formats.
///
/// ## Implementing modules
///
/// The `GdkPixbuf` interfaces needed for implementing modules are contained in
/// `gdk-pixbuf-io.h` (and `gdk-pixbuf-animation.h` if the module supports
/// animations). They are not covered by the same stability guarantees as the
/// regular GdkPixbuf API. To underline this fact, they are protected by the
/// `GDK_PIXBUF_ENABLE_BACKEND` pre-processor symbol.
///
/// Each loadable module must contain a `GdkPixbufModuleFillVtableFunc` function
/// named `fill_vtable`, which will get called when the module
/// is loaded and must set the function pointers of the `GdkPixbufModule`.
///
/// In order to make format-checking work before actually loading the modules
/// (which may require calling `dlopen` to load image libraries), modules export
/// their signatures (and other information) via the `fill_info` function. An
/// external utility, `gdk-pixbuf-query-loaders`, uses this to create a text
/// file containing a list of all available loaders and  their signatures.
/// This file is then read at runtime by `GdkPixbuf` to obtain the list of
/// available loaders and their signatures.
///
/// Modules may only implement a subset of the functionality available via
/// `GdkPixbufModule`. If a particular functionality is not implemented, the
/// `fill_vtable` function will simply not set the corresponding
/// function pointers of the `GdkPixbufModule` structure. If a module supports
/// incremental loading (i.e. provides `begin_load`, `stop_load` and
/// `load_increment`), it doesn't have to implement `load`, since `GdkPixbuf`
/// can supply a generic `load` implementation wrapping the incremental loading.
///
/// ## Installing modules
///
/// Installing a module is a two-step process:
///
///  - copy the module file(s) to the loader directory (normally
///    `$libdir/gdk-pixbuf-2.0/$version/loaders`, unless overridden by the
///    environment variable `GDK_PIXBUF_MODULEDIR`)
///  - call `gdk-pixbuf-query-loaders` to update the module file (normally
///    `$libdir/gdk-pixbuf-2.0/$version/loaders.cache`, unless overridden
///    by the environment variable `GDK_PIXBUF_MODULE_FILE`)
pub const PixbufModule = extern struct {
    /// the name of the module, usually the same as the
    ///  usual file extension for images of this type, eg. "xpm", "jpeg" or "png".
    f_module_name: ?[*:0]u8,
    /// the path from which the module is loaded.
    f_module_path: ?[*:0]u8,
    /// the loaded `GModule`.
    f_module: ?*gmodule.Module,
    /// a `GdkPixbufFormat` holding information about the module.
    f_info: ?*gdkpixbuf.PixbufFormat,
    /// loads an image from a file.
    f_load: ?gdkpixbuf.PixbufModuleLoadFunc,
    /// loads an image from data in memory.
    f_load_xpm_data: ?gdkpixbuf.PixbufModuleLoadXpmDataFunc,
    /// begins an incremental load.
    f_begin_load: ?gdkpixbuf.PixbufModuleBeginLoadFunc,
    /// stops an incremental load.
    f_stop_load: ?gdkpixbuf.PixbufModuleStopLoadFunc,
    /// continues an incremental load.
    f_load_increment: ?gdkpixbuf.PixbufModuleIncrementLoadFunc,
    /// loads an animation from a file.
    f_load_animation: ?gdkpixbuf.PixbufModuleLoadAnimationFunc,
    /// saves a `GdkPixbuf` to a file.
    f_save: ?gdkpixbuf.PixbufModuleSaveFunc,
    /// saves a `GdkPixbuf` by calling the given `GdkPixbufSaveFunc`.
    f_save_to_callback: ?gdkpixbuf.PixbufModuleSaveCallbackFunc,
    /// returns whether a save option key is supported by the module
    f_is_save_option_supported: ?gdkpixbuf.PixbufModuleSaveOptionSupportedFunc,
    f__reserved1: ?*const fn () callconv(.c) void,
    f__reserved2: ?*const fn () callconv(.c) void,
    f__reserved3: ?*const fn () callconv(.c) void,
    f__reserved4: ?*const fn () callconv(.c) void,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The signature prefix for a module.
///
/// The signature of a module is a set of prefixes. Prefixes are encoded as
/// pairs of ordinary strings, where the second string, called the mask, if
/// not `NULL`, must be of the same length as the first one and may contain
/// ' ', '!', 'x', 'z', and 'n' to indicate bytes that must be matched,
/// not matched, "don't-care"-bytes, zeros and non-zeros, respectively.
///
/// Each prefix has an associated integer that describes the relevance of
/// the prefix, with 0 meaning a mismatch and 100 a "perfect match".
///
/// Starting with gdk-pixbuf 2.8, the first byte of the mask may be '*',
/// indicating an unanchored pattern that matches not only at the beginning,
/// but also in the middle. Versions prior to 2.8 will interpret the '*'
/// like an 'x'.
///
/// The signature of a module is stored as an array of
/// `GdkPixbufModulePatterns`. The array is terminated by a pattern
/// where the `prefix` is `NULL`.
///
/// ```c
/// GdkPixbufModulePattern *signature[] = {
///   { "abcdx", " !x z", 100 },
///   { "bla", NULL,  90 },
///   { NULL, NULL, 0 }
/// };
/// ```
///
/// In the example above, the signature matches e.g. "auud\0" with
/// relevance 100, and "blau" with relevance 90.
pub const PixbufModulePattern = extern struct {
    /// the prefix for this pattern
    f_prefix: ?[*:0]u8,
    /// mask containing bytes which modify how the prefix is matched against
    ///  test data
    f_mask: ?[*:0]u8,
    /// relevance of this pattern
    f_relevance: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PixbufSimpleAnimClass = opaque {
    pub const Instance = gdkpixbuf.PixbufSimpleAnim;

    pub fn as(p_instance: *PixbufSimpleAnimClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This enumeration defines the color spaces that are supported by
/// the gdk-pixbuf library.
///
/// Currently only RGB is supported.
pub const Colorspace = enum(c_int) {
    rgb = 0,
    _,

    extern fn gdk_colorspace_get_type() usize;
    pub const getGObjectType = gdk_colorspace_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Interpolation modes for scaling functions.
///
/// The `GDK_INTERP_NEAREST` mode is the fastest scaling method, but has
/// horrible quality when scaling down; `GDK_INTERP_BILINEAR` is the best
/// choice if you aren't sure what to choose, it has a good speed/quality
/// balance.
///
/// **Note**: Cubic filtering is missing from the list; hyperbolic
/// interpolation is just as fast and results in higher quality.
pub const InterpType = enum(c_int) {
    nearest = 0,
    tiles = 1,
    bilinear = 2,
    hyper = 3,
    _,

    extern fn gdk_interp_type_get_type() usize;
    pub const getGObjectType = gdk_interp_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Control the alpha channel for drawables.
///
/// These values can be passed to `gdk_pixbuf_xlib_render_to_drawable_alpha`
/// in gdk-pixbuf-xlib to control how the alpha channel of an image should
/// be handled.
///
/// This function can create a bilevel clipping mask (black and white) and use
/// it while painting the image.
///
/// In the future, when the X Window System gets an alpha channel extension,
/// it will be possible to do full alpha compositing onto arbitrary drawables.
/// For now both cases fall back to a bilevel clipping mask.
pub const PixbufAlphaMode = enum(c_int) {
    bilevel = 0,
    full = 1,
    _,

    extern fn gdk_pixbuf_alpha_mode_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_alpha_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An error code in the `GDK_PIXBUF_ERROR` domain.
///
/// Many gdk-pixbuf operations can cause errors in this domain, or in
/// the `G_FILE_ERROR` domain.
pub const PixbufError = enum(c_int) {
    corrupt_image = 0,
    insufficient_memory = 1,
    bad_option = 2,
    unknown_type = 3,
    unsupported_operation = 4,
    failed = 5,
    incomplete_animation = 6,
    _,

    extern fn gdk_pixbuf_error_quark() glib.Quark;
    pub const quark = gdk_pixbuf_error_quark;

    extern fn gdk_pixbuf_error_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The possible rotations which can be passed to `gdkpixbuf.Pixbuf.rotateSimple`.
///
/// To make them easier to use, their numerical values are the actual degrees.
pub const PixbufRotation = enum(c_int) {
    none = 0,
    counterclockwise = 90,
    upsidedown = 180,
    clockwise = 270,
    _,

    extern fn gdk_pixbuf_rotation_get_type() usize;
    pub const getGObjectType = gdk_pixbuf_rotation_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags which allow a module to specify further details about the supported
/// operations.
pub const PixbufFormatFlags = packed struct(c_uint) {
    writable: bool = false,
    scalable: bool = false,
    threadsafe: bool = false,
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

    pub const flags_writable: PixbufFormatFlags = @bitCast(@as(c_uint, 1));
    pub const flags_scalable: PixbufFormatFlags = @bitCast(@as(c_uint, 2));
    pub const flags_threadsafe: PixbufFormatFlags = @bitCast(@as(c_uint, 4));

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A function of this type is responsible for freeing the pixel array
/// of a pixbuf.
///
/// The `gdkpixbuf.Pixbuf.newFromData` function lets you pass in a pre-allocated
/// pixel array so that a pixbuf can be created from it; in this case you
/// will need to pass in a function of type `GdkPixbufDestroyNotify` so that
/// the pixel data can be freed when the pixbuf is finalized.
pub const PixbufDestroyNotify = *const fn (p_pixels: [*]u8, p_data: ?*anyopaque) callconv(.c) void;

/// Sets up the image loading state.
///
/// The image loader is responsible for storing the given function pointers
/// and user data, and call them when needed.
///
/// The image loader should set up an internal state object, and return it
/// from this function; the state object will then be updated from the
/// `gdkpixbuf.PixbufModuleIncrementLoadFunc` callback, and will be freed
/// by `gdkpixbuf.PixbufModuleStopLoadFunc` callback.
pub const PixbufModuleBeginLoadFunc = *const fn (p_size_func: gdkpixbuf.PixbufModuleSizeFunc, p_prepared_func: gdkpixbuf.PixbufModulePreparedFunc, p_updated_func: gdkpixbuf.PixbufModuleUpdatedFunc, p_user_data: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) ?*anyopaque;

/// Defines the type of the function used to fill a
/// `gdkpixbuf.PixbufFormat` structure with information about a module.
pub const PixbufModuleFillInfoFunc = *const fn (p_info: *gdkpixbuf.PixbufFormat) callconv(.c) void;

/// Defines the type of the function used to set the vtable of a
/// `gdkpixbuf.PixbufModule` when it is loaded.
pub const PixbufModuleFillVtableFunc = *const fn (p_module: *gdkpixbuf.PixbufModule) callconv(.c) void;

/// Incrementally loads a buffer into the image data.
pub const PixbufModuleIncrementLoadFunc = *const fn (p_context: ?*anyopaque, p_buf: [*]const u8, p_size: c_uint, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Loads a file from a standard C file stream into a new `GdkPixbufAnimation`.
///
/// In case of error, this function should return `NULL` and set the `error` argument.
pub const PixbufModuleLoadAnimationFunc = *const fn (p_f: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) ?*gdkpixbuf.PixbufAnimation;

/// Loads a file from a standard C file stream into a new `GdkPixbuf`.
///
/// In case of error, this function should return `NULL` and set the `error` argument.
pub const PixbufModuleLoadFunc = *const fn (p_f: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) ?*gdkpixbuf.Pixbuf;

/// Loads XPM data into a new `GdkPixbuf`.
pub const PixbufModuleLoadXpmDataFunc = *const fn (p_data: [*][*:0]const u8) callconv(.c) *gdkpixbuf.Pixbuf;

/// Defines the type of the function that gets called once the initial
/// setup of `pixbuf` is done.
///
/// `gdkpixbuf.PixbufLoader` uses a function of this type to emit the
/// "<link linkend="GdkPixbufLoader-area-prepared">area_prepared</link>"
/// signal.
pub const PixbufModulePreparedFunc = *const fn (p_pixbuf: *gdkpixbuf.Pixbuf, p_anim: *gdkpixbuf.PixbufAnimation, p_user_data: ?*anyopaque) callconv(.c) void;

/// Saves a `GdkPixbuf` by calling the provided function.
///
/// The optional `option_keys` and `option_values` arrays contain the keys and
/// values (in the same order) for attributes to be saved alongside the image
/// data.
pub const PixbufModuleSaveCallbackFunc = *const fn (p_save_func: gdkpixbuf.PixbufSaveFunc, p_user_data: ?*anyopaque, p_pixbuf: *gdkpixbuf.Pixbuf, p_option_keys: ?[*][*:0]u8, p_option_values: ?[*][*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Saves a `GdkPixbuf` into a standard C file stream.
///
/// The optional `param_keys` and `param_values` arrays contain the keys and
/// values (in the same order) for attributes to be saved alongside the image
/// data.
pub const PixbufModuleSaveFunc = *const fn (p_f: ?*anyopaque, p_pixbuf: *gdkpixbuf.Pixbuf, p_param_keys: ?[*][*:0]u8, p_param_values: ?[*][*:0]u8, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Checks whether the given `option_key` is supported when saving.
pub const PixbufModuleSaveOptionSupportedFunc = *const fn (p_option_key: [*:0]const u8) callconv(.c) c_int;

/// Defines the type of the function that gets called once the size
/// of the loaded image is known.
///
/// The function is expected to set `width` and `height` to the desired
/// size to which the image should be scaled. If a module has no efficient
/// way to achieve the desired scaling during the loading of the image, it may
/// either ignore the size request, or only approximate it - gdk-pixbuf will
/// then perform the required scaling on the completely loaded image.
///
/// If the function sets `width` or `height` to zero, the module should interpret
/// this as a hint that it will be closed soon and shouldn't allocate further
/// resources. This convention is used to implement `gdkpixbuf.Pixbuf.getFileInfo`
/// efficiently.
pub const PixbufModuleSizeFunc = *const fn (p_width: *c_int, p_height: *c_int, p_user_data: ?*anyopaque) callconv(.c) void;

/// Finalizes the image loading state.
///
/// This function is called on success and error states.
pub const PixbufModuleStopLoadFunc = *const fn (p_context: ?*anyopaque, p_error: ?*?*glib.Error) callconv(.c) c_int;

/// Defines the type of the function that gets called every time a region
/// of `pixbuf` is updated.
///
/// `gdkpixbuf.PixbufLoader` uses a function of this type to emit the
/// "<link linkend="GdkPixbufLoader-area-updated">area_updated</link>"
/// signal.
pub const PixbufModuleUpdatedFunc = *const fn (p_pixbuf: *gdkpixbuf.Pixbuf, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_user_data: ?*anyopaque) callconv(.c) void;

/// Save functions used by `gdkpixbuf.Pixbuf.saveToCallback`.
///
/// This function is called once for each block of bytes that is "written"
/// by ``gdkpixbuf.Pixbuf.saveToCallback``.
///
/// If successful it should return `TRUE`; if an error occurs it should set
/// `error` and return `FALSE`, in which case ``gdkpixbuf.Pixbuf.saveToCallback``
/// will fail with the same error.
pub const PixbufSaveFunc = *const fn (p_buf: [*]const u8, p_count: usize, p_error: **glib.Error, p_data: ?*anyopaque) callconv(.c) c_int;

/// Major version of gdk-pixbuf library, that is the "0" in
/// "0.8.2" for example.
pub const PIXBUF_MAJOR = 2;
/// Micro version of gdk-pixbuf library, that is the "2" in
/// "0.8.2" for example.
pub const PIXBUF_MICRO = 10;
/// Minor version of gdk-pixbuf library, that is the "8" in
/// "0.8.2" for example.
pub const PIXBUF_MINOR = 42;
/// Contains the full version of GdkPixbuf as a string.
///
/// This is the version being compiled against; contrast with
/// `gdk_pixbuf_version`.
pub const PIXBUF_VERSION = "2.42.10";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
