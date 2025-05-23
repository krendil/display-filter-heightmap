pub const ext = @import("ext.zig");
const gdk = @This();

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
const gdkpixbuf = @import("gdkpixbuf2");
/// Used to represent native events (XEvents for the X11
/// backend, MSGs for Win32).
pub const XEvent = void;

/// GdkAppLaunchContext is an implementation of `gio.AppLaunchContext` that
/// handles launching an application in a graphical context. It provides
/// startup notification and allows to launch applications on a specific
/// screen or workspace.
///
/// ## Launching an application
///
/// ```
/// GdkAppLaunchContext *context;
///
/// context = gdk_display_get_app_launch_context (display);
///
/// gdk_app_launch_context_set_screen (screen);
/// gdk_app_launch_context_set_timestamp (event->time);
///
/// if (!g_app_info_launch_default_for_uri ("http://www.gtk.org", context, &error))
///   g_warning ("Launching failed: `s`\n", error->message);
///
/// g_object_unref (context);
/// ```
pub const AppLaunchContext = opaque {
    pub const Parent = gio.AppLaunchContext;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = AppLaunchContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gdk.AppLaunchContext`.
    extern fn gdk_app_launch_context_new() *gdk.AppLaunchContext;
    pub const new = gdk_app_launch_context_new;

    /// Sets the workspace on which applications will be launched when
    /// using this context when running under a window manager that
    /// supports multiple workspaces, as described in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec).
    ///
    /// When the workspace is not specified or `desktop` is set to -1,
    /// it is up to the window manager to pick one, typically it will
    /// be the current workspace.
    extern fn gdk_app_launch_context_set_desktop(p_context: *AppLaunchContext, p_desktop: c_int) void;
    pub const setDesktop = gdk_app_launch_context_set_desktop;

    /// Sets the display on which applications will be launched when
    /// using this context. See also `gdk.AppLaunchContext.setScreen`.
    extern fn gdk_app_launch_context_set_display(p_context: *AppLaunchContext, p_display: *gdk.Display) void;
    pub const setDisplay = gdk_app_launch_context_set_display;

    /// Sets the icon for applications that are launched with this
    /// context.
    ///
    /// Window Managers can use this information when displaying startup
    /// notification.
    ///
    /// See also `gdk.AppLaunchContext.setIconName`.
    extern fn gdk_app_launch_context_set_icon(p_context: *AppLaunchContext, p_icon: ?*gio.Icon) void;
    pub const setIcon = gdk_app_launch_context_set_icon;

    /// Sets the icon for applications that are launched with this context.
    /// The `icon_name` will be interpreted in the same way as the Icon field
    /// in desktop files. See also `gdk.AppLaunchContext.setIcon`.
    ///
    /// If both `icon` and `icon_name` are set, the `icon_name` takes priority.
    /// If neither `icon` or `icon_name` is set, the icon is taken from either
    /// the file that is passed to launched application or from the `gio.AppInfo`
    /// for the launched application itself.
    extern fn gdk_app_launch_context_set_icon_name(p_context: *AppLaunchContext, p_icon_name: ?[*:0]const u8) void;
    pub const setIconName = gdk_app_launch_context_set_icon_name;

    /// Sets the screen on which applications will be launched when
    /// using this context. See also `gdk.AppLaunchContext.setDisplay`.
    ///
    /// Note that, typically, a `gdk.Screen` represents a logical screen,
    /// not a physical monitor.
    ///
    /// If both `screen` and `display` are set, the `screen` takes priority.
    /// If neither `screen` or `display` are set, the default screen and
    /// display are used.
    extern fn gdk_app_launch_context_set_screen(p_context: *AppLaunchContext, p_screen: *gdk.Screen) void;
    pub const setScreen = gdk_app_launch_context_set_screen;

    /// Sets the timestamp of `context`. The timestamp should ideally
    /// be taken from the event that triggered the launch.
    ///
    /// Window managers can use this information to avoid moving the
    /// focus to the newly launched application when the user is busy
    /// typing in another window. This is also known as 'focus stealing
    /// prevention'.
    extern fn gdk_app_launch_context_set_timestamp(p_context: *AppLaunchContext, p_timestamp: u32) void;
    pub const setTimestamp = gdk_app_launch_context_set_timestamp;

    extern fn gdk_app_launch_context_get_type() usize;
    pub const getGObjectType = gdk_app_launch_context_get_type;

    extern fn g_object_ref(p_self: *gdk.AppLaunchContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.AppLaunchContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AppLaunchContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.Cursor` represents a cursor. Its contents are private.
pub const Cursor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Cursor;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const cursor_type = struct {
            pub const name = "cursor-type";

            pub const Type = gdk.CursorType;
        };

        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {};

    /// Creates a new cursor from the set of builtin cursors for the default display.
    /// See `gdk.Cursor.newForDisplay`.
    ///
    /// To make the cursor invisible, use `GDK_BLANK_CURSOR`.
    extern fn gdk_cursor_new(p_cursor_type: gdk.CursorType) *gdk.Cursor;
    pub const new = gdk_cursor_new;

    /// Creates a new cursor from the set of builtin cursors.
    extern fn gdk_cursor_new_for_display(p_display: *gdk.Display, p_cursor_type: gdk.CursorType) ?*gdk.Cursor;
    pub const newForDisplay = gdk_cursor_new_for_display;

    /// Creates a new cursor by looking up `name` in the current cursor
    /// theme.
    ///
    /// A recommended set of cursor names that will work across different
    /// platforms can be found in the CSS specification:
    /// - "none"
    /// - ![](default_cursor.png) "default"
    /// - ![](help_cursor.png) "help"
    /// - ![](pointer_cursor.png) "pointer"
    /// - ![](context_menu_cursor.png) "context-menu"
    /// - ![](progress_cursor.png) "progress"
    /// - ![](wait_cursor.png) "wait"
    /// - ![](cell_cursor.png) "cell"
    /// - ![](crosshair_cursor.png) "crosshair"
    /// - ![](text_cursor.png) "text"
    /// - ![](vertical_text_cursor.png) "vertical-text"
    /// - ![](alias_cursor.png) "alias"
    /// - ![](copy_cursor.png) "copy"
    /// - ![](no_drop_cursor.png) "no-drop"
    /// - ![](move_cursor.png) "move"
    /// - ![](not_allowed_cursor.png) "not-allowed"
    /// - ![](grab_cursor.png) "grab"
    /// - ![](grabbing_cursor.png) "grabbing"
    /// - ![](all_scroll_cursor.png) "all-scroll"
    /// - ![](col_resize_cursor.png) "col-resize"
    /// - ![](row_resize_cursor.png) "row-resize"
    /// - ![](n_resize_cursor.png) "n-resize"
    /// - ![](e_resize_cursor.png) "e-resize"
    /// - ![](s_resize_cursor.png) "s-resize"
    /// - ![](w_resize_cursor.png) "w-resize"
    /// - ![](ne_resize_cursor.png) "ne-resize"
    /// - ![](nw_resize_cursor.png) "nw-resize"
    /// - ![](sw_resize_cursor.png) "sw-resize"
    /// - ![](se_resize_cursor.png) "se-resize"
    /// - ![](ew_resize_cursor.png) "ew-resize"
    /// - ![](ns_resize_cursor.png) "ns-resize"
    /// - ![](nesw_resize_cursor.png) "nesw-resize"
    /// - ![](nwse_resize_cursor.png) "nwse-resize"
    /// - ![](zoom_in_cursor.png) "zoom-in"
    /// - ![](zoom_out_cursor.png) "zoom-out"
    ///
    /// Additionally, the following cursor names are supported, which are
    /// not in the CSS specification:
    /// - ![](dnd_ask_cursor.png) "dnd-ask"
    /// - ![](all_resize_cursor.png) "all-resize"
    extern fn gdk_cursor_new_from_name(p_display: *gdk.Display, p_name: [*:0]const u8) ?*gdk.Cursor;
    pub const newFromName = gdk_cursor_new_from_name;

    /// Creates a new cursor from a pixbuf.
    ///
    /// Not all GDK backends support RGBA cursors. If they are not
    /// supported, a monochrome approximation will be displayed.
    /// The functions `gdk.Display.supportsCursorAlpha` and
    /// `gdk.Display.supportsCursorColor` can be used to determine
    /// whether RGBA cursors are supported;
    /// `gdk.Display.getDefaultCursorSize` and
    /// `gdk.Display.getMaximalCursorSize` give information about
    /// cursor sizes.
    ///
    /// If `x` or `y` are `-1`, the pixbuf must have
    /// options named “x_hot” and “y_hot”, resp., containing
    /// integer values between `0` and the width resp. height of
    /// the pixbuf. (Since: 3.0)
    ///
    /// On the X backend, support for RGBA cursors requires a
    /// sufficently new version of the X Render extension.
    extern fn gdk_cursor_new_from_pixbuf(p_display: *gdk.Display, p_pixbuf: *gdkpixbuf.Pixbuf, p_x: c_int, p_y: c_int) *gdk.Cursor;
    pub const newFromPixbuf = gdk_cursor_new_from_pixbuf;

    /// Creates a new cursor from a cairo image surface.
    ///
    /// Not all GDK backends support RGBA cursors. If they are not
    /// supported, a monochrome approximation will be displayed.
    /// The functions `gdk.Display.supportsCursorAlpha` and
    /// `gdk.Display.supportsCursorColor` can be used to determine
    /// whether RGBA cursors are supported;
    /// `gdk.Display.getDefaultCursorSize` and
    /// `gdk.Display.getMaximalCursorSize` give information about
    /// cursor sizes.
    ///
    /// On the X backend, support for RGBA cursors requires a
    /// sufficently new version of the X Render extension.
    extern fn gdk_cursor_new_from_surface(p_display: *gdk.Display, p_surface: *cairo.Surface, p_x: f64, p_y: f64) *gdk.Cursor;
    pub const newFromSurface = gdk_cursor_new_from_surface;

    /// Returns the cursor type for this cursor.
    extern fn gdk_cursor_get_cursor_type(p_cursor: *Cursor) gdk.CursorType;
    pub const getCursorType = gdk_cursor_get_cursor_type;

    /// Returns the display on which the `gdk.Cursor` is defined.
    extern fn gdk_cursor_get_display(p_cursor: *Cursor) *gdk.Display;
    pub const getDisplay = gdk_cursor_get_display;

    /// Returns a `gdkpixbuf.Pixbuf` with the image used to display the cursor.
    ///
    /// Note that depending on the capabilities of the windowing system and
    /// on the cursor, GDK may not be able to obtain the image data. In this
    /// case, `NULL` is returned.
    extern fn gdk_cursor_get_image(p_cursor: *Cursor) ?*gdkpixbuf.Pixbuf;
    pub const getImage = gdk_cursor_get_image;

    /// Returns a cairo image surface with the image used to display the cursor.
    ///
    /// Note that depending on the capabilities of the windowing system and
    /// on the cursor, GDK may not be able to obtain the image data. In this
    /// case, `NULL` is returned.
    extern fn gdk_cursor_get_surface(p_cursor: *Cursor, p_x_hot: ?*f64, p_y_hot: ?*f64) ?*cairo.Surface;
    pub const getSurface = gdk_cursor_get_surface;

    /// Adds a reference to `cursor`.
    extern fn gdk_cursor_ref(p_cursor: *Cursor) *gdk.Cursor;
    pub const ref = gdk_cursor_ref;

    /// Removes a reference from `cursor`, deallocating the cursor
    /// if no references remain.
    extern fn gdk_cursor_unref(p_cursor: *Cursor) void;
    pub const unref = gdk_cursor_unref;

    extern fn gdk_cursor_get_type() usize;
    pub const getGObjectType = gdk_cursor_get_type;

    pub fn as(p_instance: *Cursor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `gdk.Device` object represents a single input device, such
/// as a keyboard, a mouse, a touchpad, etc.
///
/// See the `gdk.DeviceManager` documentation for more information
/// about the various kinds of master and slave devices, and their
/// relationships.
pub const Device = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Device;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Associated pointer or keyboard with this device, if any. Devices of type `GDK_DEVICE_TYPE_MASTER`
        /// always come in keyboard/pointer pairs. Other device types will have a `NULL` associated device.
        pub const associated_device = struct {
            pub const name = "associated-device";

            pub const Type = ?*gdk.Device;
        };

        /// The axes currently available for this device.
        pub const axes = struct {
            pub const name = "axes";

            pub const Type = gdk.AxisFlags;
        };

        /// The `gdk.DeviceManager` the `gdk.Device` pertains to.
        pub const device_manager = struct {
            pub const name = "device-manager";

            pub const Type = ?*gdk.DeviceManager;
        };

        /// The `gdk.Display` the `gdk.Device` pertains to.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// Whether the device is represented by a cursor on the screen. Devices of type
        /// `GDK_DEVICE_TYPE_MASTER` will have `TRUE` here.
        pub const has_cursor = struct {
            pub const name = "has-cursor";

            pub const Type = c_int;
        };

        pub const input_mode = struct {
            pub const name = "input-mode";

            pub const Type = gdk.InputMode;
        };

        /// Source type for the device.
        pub const input_source = struct {
            pub const name = "input-source";

            pub const Type = gdk.InputSource;
        };

        /// Number of axes in the device.
        pub const n_axes = struct {
            pub const name = "n-axes";

            pub const Type = c_uint;
        };

        /// The device name.
        pub const name = struct {
            pub const name = "name";

            pub const Type = ?[*:0]u8;
        };

        /// The maximal number of concurrent touches on a touch device.
        /// Will be 0 if the device is not a touch device or if the number
        /// of touches is unknown.
        pub const num_touches = struct {
            pub const name = "num-touches";

            pub const Type = c_uint;
        };

        /// Product ID of this device, see `gdk.Device.getProductId`.
        pub const product_id = struct {
            pub const name = "product-id";

            pub const Type = ?[*:0]u8;
        };

        /// `gdk.Seat` of this device.
        pub const seat = struct {
            pub const name = "seat";

            pub const Type = ?*gdk.Seat;
        };

        pub const tool = struct {
            pub const name = "tool";

            pub const Type = ?*gdk.DeviceTool;
        };

        /// Device role in the device manager.
        pub const @"type" = struct {
            pub const name = "type";

            pub const Type = gdk.DeviceType;
        };

        /// Vendor ID of this device, see `gdk.Device.getVendorId`.
        pub const vendor_id = struct {
            pub const name = "vendor-id";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// The ::changed signal is emitted either when the `gdk.Device`
        /// has changed the number of either axes or keys. For example
        /// In X this will normally happen when the slave device routing
        /// events through the master device changes (for example, user
        /// switches from the USB mouse to a tablet), in that case the
        /// master device will change to reflect the new slave device
        /// axes and keys.
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Device, p_instance))),
                    gobject.signalLookup("changed", Device.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::tool-changed signal is emitted on pen/eraser
        /// `GdkDevices` whenever tools enter or leave proximity.
        pub const tool_changed = struct {
            pub const name = "tool-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Device, p_instance))),
                    gobject.signalLookup("tool-changed", Device.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Frees an array of `gdk.TimeCoord` that was returned by `gdk.Device.getHistory`.
    extern fn gdk_device_free_history(p_events: [*]*gdk.TimeCoord, p_n_events: c_int) void;
    pub const freeHistory = gdk_device_free_history;

    /// Determines information about the current keyboard grab.
    /// This is not public API and must not be used by applications.
    extern fn gdk_device_grab_info_libgtk_only(p_display: *gdk.Display, p_device: *gdk.Device, p_grab_window: **gdk.Window, p_owner_events: *c_int) c_int;
    pub const grabInfoLibgtkOnly = gdk_device_grab_info_libgtk_only;

    /// Returns the associated device to `device`, if `device` is of type
    /// `GDK_DEVICE_TYPE_MASTER`, it will return the paired pointer or
    /// keyboard.
    ///
    /// If `device` is of type `GDK_DEVICE_TYPE_SLAVE`, it will return
    /// the master device to which `device` is attached to.
    ///
    /// If `device` is of type `GDK_DEVICE_TYPE_FLOATING`, `NULL` will be
    /// returned, as there is no associated device.
    extern fn gdk_device_get_associated_device(p_device: *Device) ?*gdk.Device;
    pub const getAssociatedDevice = gdk_device_get_associated_device;

    /// Returns the axes currently available on the device.
    extern fn gdk_device_get_axes(p_device: *Device) gdk.AxisFlags;
    pub const getAxes = gdk_device_get_axes;

    /// Interprets an array of double as axis values for a given device,
    /// and locates the value in the array for a given axis use.
    extern fn gdk_device_get_axis(p_device: *Device, p_axes: [*]f64, p_use: gdk.AxisUse, p_value: *f64) c_int;
    pub const getAxis = gdk_device_get_axis;

    /// Returns the axis use for `index_`.
    extern fn gdk_device_get_axis_use(p_device: *Device, p_index_: c_uint) gdk.AxisUse;
    pub const getAxisUse = gdk_device_get_axis_use;

    /// Interprets an array of double as axis values for a given device,
    /// and locates the value in the array for a given axis label, as returned
    /// by `gdk.Device.listAxes`
    extern fn gdk_device_get_axis_value(p_device: *Device, p_axes: [*]f64, p_axis_label: gdk.Atom, p_value: *f64) c_int;
    pub const getAxisValue = gdk_device_get_axis_value;

    /// Returns the device type for `device`.
    extern fn gdk_device_get_device_type(p_device: *Device) gdk.DeviceType;
    pub const getDeviceType = gdk_device_get_device_type;

    /// Returns the `gdk.Display` to which `device` pertains.
    extern fn gdk_device_get_display(p_device: *Device) *gdk.Display;
    pub const getDisplay = gdk_device_get_display;

    /// Determines whether the pointer follows device motion.
    /// This is not meaningful for keyboard devices, which don't have a pointer.
    extern fn gdk_device_get_has_cursor(p_device: *Device) c_int;
    pub const getHasCursor = gdk_device_get_has_cursor;

    /// Obtains the motion history for a pointer device; given a starting and
    /// ending timestamp, return all events in the motion history for
    /// the device in the given range of time. Some windowing systems
    /// do not support motion history, in which case, `FALSE` will
    /// be returned. (This is not distinguishable from the case where
    /// motion history is supported and no events were found.)
    ///
    /// Note that there is also `gdk.Window.setEventCompression` to get
    /// more motion events delivered directly, independent of the windowing
    /// system.
    extern fn gdk_device_get_history(p_device: *Device, p_window: *gdk.Window, p_start: u32, p_stop: u32, p_events: ?*[*]*gdk.TimeCoord, p_n_events: ?*c_int) c_int;
    pub const getHistory = gdk_device_get_history;

    /// If `index_` has a valid keyval, this function will return `TRUE`
    /// and fill in `keyval` and `modifiers` with the keyval settings.
    extern fn gdk_device_get_key(p_device: *Device, p_index_: c_uint, p_keyval: *c_uint, p_modifiers: *gdk.ModifierType) c_int;
    pub const getKey = gdk_device_get_key;

    /// Gets information about which window the given pointer device is in, based on events
    /// that have been received so far from the display server. If another application
    /// has a pointer grab, or this application has a grab with owner_events = `FALSE`,
    /// `NULL` may be returned even if the pointer is physically over one of this
    /// application's windows.
    extern fn gdk_device_get_last_event_window(p_device: *Device) ?*gdk.Window;
    pub const getLastEventWindow = gdk_device_get_last_event_window;

    /// Determines the mode of the device.
    extern fn gdk_device_get_mode(p_device: *Device) gdk.InputMode;
    pub const getMode = gdk_device_get_mode;

    /// Returns the number of axes the device currently has.
    extern fn gdk_device_get_n_axes(p_device: *Device) c_int;
    pub const getNAxes = gdk_device_get_n_axes;

    /// Returns the number of keys the device currently has.
    extern fn gdk_device_get_n_keys(p_device: *Device) c_int;
    pub const getNKeys = gdk_device_get_n_keys;

    /// Determines the name of the device.
    extern fn gdk_device_get_name(p_device: *Device) [*:0]const u8;
    pub const getName = gdk_device_get_name;

    /// Gets the current location of `device`. As a slave device
    /// coordinates are those of its master pointer, This function
    /// may not be called on devices of type `GDK_DEVICE_TYPE_SLAVE`,
    /// unless there is an ongoing grab on them, see `gdk.Device.grab`.
    extern fn gdk_device_get_position(p_device: *Device, p_screen: ?**gdk.Screen, p_x: ?*c_int, p_y: ?*c_int) void;
    pub const getPosition = gdk_device_get_position;

    /// Gets the current location of `device` in double precision. As a slave device's
    /// coordinates are those of its master pointer, this function
    /// may not be called on devices of type `GDK_DEVICE_TYPE_SLAVE`,
    /// unless there is an ongoing grab on them. See `gdk.Device.grab`.
    extern fn gdk_device_get_position_double(p_device: *Device, p_screen: ?**gdk.Screen, p_x: ?*f64, p_y: ?*f64) void;
    pub const getPositionDouble = gdk_device_get_position_double;

    /// Returns the product ID of this device, or `NULL` if this information couldn't
    /// be obtained. This ID is retrieved from the device, and is thus constant for
    /// it. See `gdk.Device.getVendorId` for more information.
    extern fn gdk_device_get_product_id(p_device: *Device) ?[*:0]const u8;
    pub const getProductId = gdk_device_get_product_id;

    /// Returns the `gdk.Seat` the device belongs to.
    extern fn gdk_device_get_seat(p_device: *Device) *gdk.Seat;
    pub const getSeat = gdk_device_get_seat;

    /// Determines the type of the device.
    extern fn gdk_device_get_source(p_device: *Device) gdk.InputSource;
    pub const getSource = gdk_device_get_source;

    /// Gets the current state of a pointer device relative to `window`. As a slave
    /// device’s coordinates are those of its master pointer, this
    /// function may not be called on devices of type `GDK_DEVICE_TYPE_SLAVE`,
    /// unless there is an ongoing grab on them. See `gdk.Device.grab`.
    extern fn gdk_device_get_state(p_device: *Device, p_window: *gdk.Window, p_axes: ?[*]f64, p_mask: ?*gdk.ModifierType) void;
    pub const getState = gdk_device_get_state;

    /// Returns the vendor ID of this device, or `NULL` if this information couldn't
    /// be obtained. This ID is retrieved from the device, and is thus constant for
    /// it.
    ///
    /// This function, together with `gdk.Device.getProductId`, can be used to eg.
    /// compose `gio.Settings` paths to store settings for this device.
    ///
    /// ```
    ///  static GSettings *
    ///  get_device_settings (GdkDevice *device)
    ///  {
    ///    const gchar *vendor, *product;
    ///    GSettings *settings;
    ///    GdkDevice *device;
    ///    gchar *path;
    ///
    ///    vendor = gdk_device_get_vendor_id (device);
    ///    product = gdk_device_get_product_id (device);
    ///
    ///    path = g_strdup_printf ("/org/example/app/devices/`s`:`s`/", vendor, product);
    ///    settings = g_settings_new_with_path (DEVICE_SCHEMA, path);
    ///    g_free (path);
    ///
    ///    return settings;
    ///  }
    /// ```
    extern fn gdk_device_get_vendor_id(p_device: *Device) ?[*:0]const u8;
    pub const getVendorId = gdk_device_get_vendor_id;

    /// Obtains the window underneath `device`, returning the location of the device in `win_x` and `win_y`. Returns
    /// `NULL` if the window tree under `device` is not known to GDK (for example, belongs to another application).
    ///
    /// As a slave device coordinates are those of its master pointer, This
    /// function may not be called on devices of type `GDK_DEVICE_TYPE_SLAVE`,
    /// unless there is an ongoing grab on them, see `gdk.Device.grab`.
    extern fn gdk_device_get_window_at_position(p_device: *Device, p_win_x: ?*c_int, p_win_y: ?*c_int) ?*gdk.Window;
    pub const getWindowAtPosition = gdk_device_get_window_at_position;

    /// Obtains the window underneath `device`, returning the location of the device in `win_x` and `win_y` in
    /// double precision. Returns `NULL` if the window tree under `device` is not known to GDK (for example,
    /// belongs to another application).
    ///
    /// As a slave device coordinates are those of its master pointer, This
    /// function may not be called on devices of type `GDK_DEVICE_TYPE_SLAVE`,
    /// unless there is an ongoing grab on them, see `gdk.Device.grab`.
    extern fn gdk_device_get_window_at_position_double(p_device: *Device, p_win_x: ?*f64, p_win_y: ?*f64) ?*gdk.Window;
    pub const getWindowAtPositionDouble = gdk_device_get_window_at_position_double;

    /// Grabs the device so that all events coming from this device are passed to
    /// this application until the device is ungrabbed with `gdk.Device.ungrab`,
    /// or the window becomes unviewable. This overrides any previous grab on the device
    /// by this client.
    ///
    /// Note that `device` and `window` need to be on the same display.
    ///
    /// Device grabs are used for operations which need complete control over the
    /// given device events (either pointer or keyboard). For example in GTK+ this
    /// is used for Drag and Drop operations, popup menus and such.
    ///
    /// Note that if the event mask of an X window has selected both button press
    /// and button release events, then a button press event will cause an automatic
    /// pointer grab until the button is released. X does this automatically since
    /// most applications expect to receive button press and release events in pairs.
    /// It is equivalent to a pointer grab on the window with `owner_events` set to
    /// `TRUE`.
    ///
    /// If you set up anything at the time you take the grab that needs to be
    /// cleaned up when the grab ends, you should handle the `gdk.EventGrabBroken`
    /// events that are emitted when the grab ends unvoluntarily.
    extern fn gdk_device_grab(p_device: *Device, p_window: *gdk.Window, p_grab_ownership: gdk.GrabOwnership, p_owner_events: c_int, p_event_mask: gdk.EventMask, p_cursor: ?*gdk.Cursor, p_time_: u32) gdk.GrabStatus;
    pub const grab = gdk_device_grab;

    /// Returns a `glib.List` of `GdkAtoms`, containing the labels for
    /// the axes that `device` currently has.
    extern fn gdk_device_list_axes(p_device: *Device) *glib.List;
    pub const listAxes = gdk_device_list_axes;

    /// If the device if of type `GDK_DEVICE_TYPE_MASTER`, it will return
    /// the list of slave devices attached to it, otherwise it will return
    /// `NULL`
    extern fn gdk_device_list_slave_devices(p_device: *Device) ?*glib.List;
    pub const listSlaveDevices = gdk_device_list_slave_devices;

    /// Specifies how an axis of a device is used.
    extern fn gdk_device_set_axis_use(p_device: *Device, p_index_: c_uint, p_use: gdk.AxisUse) void;
    pub const setAxisUse = gdk_device_set_axis_use;

    /// Specifies the X key event to generate when a macro button of a device
    /// is pressed.
    extern fn gdk_device_set_key(p_device: *Device, p_index_: c_uint, p_keyval: c_uint, p_modifiers: gdk.ModifierType) void;
    pub const setKey = gdk_device_set_key;

    /// Sets a the mode of an input device. The mode controls if the
    /// device is active and whether the device’s range is mapped to the
    /// entire screen or to a single window.
    ///
    /// Note: This is only meaningful for floating devices, master devices (and
    /// slaves connected to these) drive the pointer cursor, which is not limited
    /// by the input mode.
    extern fn gdk_device_set_mode(p_device: *Device, p_mode: gdk.InputMode) c_int;
    pub const setMode = gdk_device_set_mode;

    /// Release any grab on `device`.
    extern fn gdk_device_ungrab(p_device: *Device, p_time_: u32) void;
    pub const ungrab = gdk_device_ungrab;

    /// Warps `device` in `display` to the point `x`,`y` on
    /// the screen `screen`, unless the device is confined
    /// to a window by a grab, in which case it will be moved
    /// as far as allowed by the grab. Warping the pointer
    /// creates events as if the user had moved the mouse
    /// instantaneously to the destination.
    ///
    /// Note that the pointer should normally be under the
    /// control of the user. This function was added to cover
    /// some rare use cases like keyboard navigation support
    /// for the color picker in the `GtkColorSelectionDialog`.
    extern fn gdk_device_warp(p_device: *Device, p_screen: *gdk.Screen, p_x: c_int, p_y: c_int) void;
    pub const warp = gdk_device_warp;

    extern fn gdk_device_get_type() usize;
    pub const getGObjectType = gdk_device_get_type;

    extern fn g_object_ref(p_self: *gdk.Device) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Device) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Device, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// In addition to a single pointer and keyboard for user interface input,
/// GDK contains support for a variety of input devices, including graphics
/// tablets, touchscreens and multiple pointers/keyboards interacting
/// simultaneously with the user interface. Such input devices often have
/// additional features, such as sub-pixel positioning information and
/// additional device-dependent information.
///
/// In order to query the device hierarchy and be aware of changes in the
/// device hierarchy (such as virtual devices being created or removed, or
/// physical devices being plugged or unplugged), GDK provides
/// `gdk.DeviceManager`.
///
/// By default, and if the platform supports it, GDK is aware of multiple
/// keyboard/pointer pairs and multitouch devices. This behavior can be
/// changed by calling `gdk.disableMultidevice` before `gdk.Display.open`.
/// There should rarely be a need to do that though, since GDK defaults
/// to a compatibility mode in which it will emit just one enter/leave
/// event pair for all devices on a window. To enable per-device
/// enter/leave events and other multi-pointer interaction features,
/// `gdk.Window.setSupportMultidevice` must be called on
/// `GdkWindows` (or `gtk_widget_set_support_multidevice` on widgets).
/// window. See the `gdk.Window.setSupportMultidevice` documentation
/// for more information.
///
/// On X11, multi-device support is implemented through XInput 2.
/// Unless `gdk.disableMultidevice` is called, the XInput 2
/// `gdk.DeviceManager` implementation will be used as the input source.
/// Otherwise either the core or XInput 1 implementations will be used.
///
/// For simple applications that don’t have any special interest in
/// input devices, the so-called “client pointer”
/// provides a reasonable approximation to a simple setup with a single
/// pointer and keyboard. The device that has been set as the client
/// pointer can be accessed via `gdk.DeviceManager.getClientPointer`.
///
/// Conceptually, in multidevice mode there are 2 device types. Virtual
/// devices (or master devices) are represented by the pointer cursors
/// and keyboard foci that are seen on the screen. Physical devices (or
/// slave devices) represent the hardware that is controlling the virtual
/// devices, and thus have no visible cursor on the screen.
///
/// Virtual devices are always paired, so there is a keyboard device for every
/// pointer device. Associations between devices may be inspected through
/// `gdk.Device.getAssociatedDevice`.
///
/// There may be several virtual devices, and several physical devices could
/// be controlling each of these virtual devices. Physical devices may also
/// be “floating”, which means they are not attached to any virtual device.
///
/// # Master and slave devices
///
/// ```
/// carlos`sacarino`:~$ xinput list
/// ⎡ Virtual core pointer                          id=2    [master pointer  (3)]
/// ⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
/// ⎜   ↳ Wacom ISDv4 E6 Pen stylus                 id=10   [slave  pointer  (2)]
/// ⎜   ↳ Wacom ISDv4 E6 Finger touch               id=11   [slave  pointer  (2)]
/// ⎜   ↳ SynPS/2 Synaptics TouchPad                id=13   [slave  pointer  (2)]
/// ⎜   ↳ TPPS/2 IBM TrackPoint                     id=14   [slave  pointer  (2)]
/// ⎜   ↳ Wacom ISDv4 E6 Pen eraser                 id=16   [slave  pointer  (2)]
/// ⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
///     ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
///     ↳ Power Button                              id=6    [slave  keyboard (3)]
///     ↳ Video Bus                                 id=7    [slave  keyboard (3)]
///     ↳ Sleep Button                              id=8    [slave  keyboard (3)]
///     ↳ Integrated Camera                         id=9    [slave  keyboard (3)]
///     ↳ AT Translated Set 2 keyboard              id=12   [slave  keyboard (3)]
///     ↳ ThinkPad Extra Buttons                    id=15   [slave  keyboard (3)]
/// ```
///
/// By default, GDK will automatically listen for events coming from all
/// master devices, setting the `gdk.Device` for all events coming from input
/// devices. Events containing device information are `GDK_MOTION_NOTIFY`,
/// `GDK_BUTTON_PRESS`, `GDK_2BUTTON_PRESS`, `GDK_3BUTTON_PRESS`,
/// `GDK_BUTTON_RELEASE`, `GDK_SCROLL`, `GDK_KEY_PRESS`, `GDK_KEY_RELEASE`,
/// `GDK_ENTER_NOTIFY`, `GDK_LEAVE_NOTIFY`, `GDK_FOCUS_CHANGE`,
/// `GDK_PROXIMITY_IN`, `GDK_PROXIMITY_OUT`, `GDK_DRAG_ENTER`, `GDK_DRAG_LEAVE`,
/// `GDK_DRAG_MOTION`, `GDK_DRAG_STATUS`, `GDK_DROP_START`, `GDK_DROP_FINISHED`
/// and `GDK_GRAB_BROKEN`. When dealing with an event on a master device,
/// it is possible to get the source (slave) device that the event originated
/// from via `gdk.Event.getSourceDevice`.
///
/// On a standard session, all physical devices are connected by default to
/// the "Virtual Core Pointer/Keyboard" master devices, hence routing all events
/// through these. This behavior is only modified by device grabs, where the
/// slave device is temporarily detached for as long as the grab is held, and
/// more permanently by user modifications to the device hierarchy.
///
/// On certain application specific setups, it may make sense
/// to detach a physical device from its master pointer, and mapping it to
/// an specific window. This can be achieved by the combination of
/// `gdk.Device.grab` and `gdk.Device.setMode`.
///
/// In order to listen for events coming from devices
/// other than a virtual device, `gdk.Window.setDeviceEvents` must be
/// called. Generally, this function can be used to modify the event mask
/// for any given device.
///
/// Input devices may also provide additional information besides X/Y.
/// For example, graphics tablets may also provide pressure and X/Y tilt
/// information. This information is device-dependent, and may be
/// queried through `gdk.Device.getAxis`. In multidevice mode, virtual
/// devices will change axes in order to always represent the physical
/// device that is routing events through it. Whenever the physical device
/// changes, the `gdk.Device.properties.n`-axes property will be notified, and
/// `gdk.Device.listAxes` will return the new device axes.
///
/// Devices may also have associated “keys” or
/// macro buttons. Such keys can be globally set to map into normal X
/// keyboard events. The mapping is set using `gdk.Device.setKey`.
///
/// In GTK+ 3.20, a new `gdk.Seat` object has been introduced that
/// supersedes `gdk.DeviceManager` and should be preferred in newly
/// written code.
pub const DeviceManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DeviceManager;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {
        /// The ::device-added signal is emitted either when a new master
        /// pointer is created, or when a slave (Hardware) input device
        /// is plugged in.
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DeviceManager, p_instance))),
                    gobject.signalLookup("device-added", DeviceManager.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::device-changed signal is emitted whenever a device
        /// has changed in the hierarchy, either slave devices being
        /// disconnected from their master device or connected to
        /// another one, or master devices being added or removed
        /// a slave device.
        ///
        /// If a slave device is detached from all master devices
        /// (`gdk.Device.getAssociatedDevice` returns `NULL`), its
        /// `gdk.DeviceType` will change to `GDK_DEVICE_TYPE_FLOATING`,
        /// if it's attached, it will change to `GDK_DEVICE_TYPE_SLAVE`.
        pub const device_changed = struct {
            pub const name = "device-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DeviceManager, p_instance))),
                    gobject.signalLookup("device-changed", DeviceManager.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::device-removed signal is emitted either when a master
        /// pointer is removed, or when a slave (Hardware) input device
        /// is unplugged.
        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DeviceManager, p_instance))),
                    gobject.signalLookup("device-removed", DeviceManager.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the client pointer, that is, the master pointer that acts as the core pointer
    /// for this application. In X11, window managers may change this depending on the interaction
    /// pattern under the presence of several pointers.
    ///
    /// You should use this function seldomly, only in code that isn’t triggered by a `gdk.Event`
    /// and there aren’t other means to get a meaningful `gdk.Device` to operate on.
    extern fn gdk_device_manager_get_client_pointer(p_device_manager: *DeviceManager) *gdk.Device;
    pub const getClientPointer = gdk_device_manager_get_client_pointer;

    /// Gets the `gdk.Display` associated to `device_manager`.
    extern fn gdk_device_manager_get_display(p_device_manager: *DeviceManager) ?*gdk.Display;
    pub const getDisplay = gdk_device_manager_get_display;

    /// Returns the list of devices of type `type` currently attached to
    /// `device_manager`.
    extern fn gdk_device_manager_list_devices(p_device_manager: *DeviceManager, p_type: gdk.DeviceType) *glib.List;
    pub const listDevices = gdk_device_manager_list_devices;

    extern fn gdk_device_manager_get_type() usize;
    pub const getGObjectType = gdk_device_manager_get_type;

    extern fn g_object_ref(p_self: *gdk.DeviceManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DeviceManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DeviceTool = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DeviceTool;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const axes = struct {
            pub const name = "axes";

            pub const Type = gdk.AxisFlags;
        };

        pub const hardware_id = struct {
            pub const name = "hardware-id";

            pub const Type = u64;
        };

        pub const serial = struct {
            pub const name = "serial";

            pub const Type = u64;
        };

        pub const tool_type = struct {
            pub const name = "tool-type";

            pub const Type = gdk.DeviceToolType;
        };
    };

    pub const signals = struct {};

    /// Gets the hardware ID of this tool, or 0 if it's not known. When
    /// non-zero, the identificator is unique for the given tool model,
    /// meaning that two identical tools will share the same `hardware_id`,
    /// but will have different serial numbers (see `gdk.DeviceTool.getSerial`).
    ///
    /// This is a more concrete (and device specific) method to identify
    /// a `gdk.DeviceTool` than `gdk.DeviceTool.getToolType`, as a tablet
    /// may support multiple devices with the same `gdk.DeviceToolType`,
    /// but having different hardware identificators.
    extern fn gdk_device_tool_get_hardware_id(p_tool: *DeviceTool) u64;
    pub const getHardwareId = gdk_device_tool_get_hardware_id;

    /// Gets the serial of this tool, this value can be used to identify a
    /// physical tool (eg. a tablet pen) across program executions.
    extern fn gdk_device_tool_get_serial(p_tool: *DeviceTool) u64;
    pub const getSerial = gdk_device_tool_get_serial;

    /// Gets the `gdk.DeviceToolType` of the tool.
    extern fn gdk_device_tool_get_tool_type(p_tool: *DeviceTool) gdk.DeviceToolType;
    pub const getToolType = gdk_device_tool_get_tool_type;

    extern fn gdk_device_tool_get_type() usize;
    pub const getGObjectType = gdk_device_tool_get_type;

    extern fn g_object_ref(p_self: *gdk.DeviceTool) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DeviceTool) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DeviceTool, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.Display` objects purpose are two fold:
///
/// - To manage and provide information about input devices (pointers and keyboards)
///
/// - To manage and provide information about the available `GdkScreens`
///
/// GdkDisplay objects are the GDK representation of an X Display,
/// which can be described as a workstation consisting of
/// a keyboard, a pointing device (such as a mouse) and one or more
/// screens.
/// It is used to open and keep track of various GdkScreen objects
/// currently instantiated by the application. It is also used to
/// access the keyboard(s) and mouse pointer(s) of the display.
///
/// Most of the input device handling has been factored out into
/// the separate `gdk.DeviceManager` object. Every display has a
/// device manager, which you can obtain using
/// `gdk.Display.getDeviceManager`.
pub const Display = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Display;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// The ::closed signal is emitted when the connection to the windowing
        /// system for `display` is closed.
        pub const closed = struct {
            pub const name = "closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_is_error: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("closed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::monitor-added signal is emitted whenever a monitor is
        /// added.
        pub const monitor_added = struct {
            pub const name = "monitor-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_monitor: *gdk.Monitor, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("monitor-added", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::monitor-removed signal is emitted whenever a monitor is
        /// removed.
        pub const monitor_removed = struct {
            pub const name = "monitor-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_monitor: *gdk.Monitor, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("monitor-removed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::opened signal is emitted when the connection to the windowing
        /// system for `display` is opened.
        pub const opened = struct {
            pub const name = "opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("opened", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::seat-added signal is emitted whenever a new seat is made
        /// known to the windowing system.
        pub const seat_added = struct {
            pub const name = "seat-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_seat: *gdk.Seat, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("seat-added", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::seat-removed signal is emitted whenever a seat is removed
        /// by the windowing system.
        pub const seat_removed = struct {
            pub const name = "seat-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_seat: *gdk.Seat, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Display, p_instance))),
                    gobject.signalLookup("seat-removed", Display.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the default `gdk.Display`. This is a convenience
    /// function for:
    /// `gdk_display_manager_get_default_display (gdk_display_manager_get ())`.
    extern fn gdk_display_get_default() ?*gdk.Display;
    pub const getDefault = gdk_display_get_default;

    /// Opens a display.
    extern fn gdk_display_open(p_display_name: [*:0]const u8) ?*gdk.Display;
    pub const open = gdk_display_open;

    /// Opens the default display specified by command line arguments or
    /// environment variables, sets it as the default display, and returns
    /// it. `gdk.parseArgs` must have been called first. If the default
    /// display has previously been set, simply returns that. An internal
    /// function that should not be used by applications.
    extern fn gdk_display_open_default_libgtk_only() ?*gdk.Display;
    pub const openDefaultLibgtkOnly = gdk_display_open_default_libgtk_only;

    /// Emits a short beep on `display`
    extern fn gdk_display_beep(p_display: *Display) void;
    pub const beep = gdk_display_beep;

    /// Closes the connection to the windowing system for the given display,
    /// and cleans up associated resources.
    extern fn gdk_display_close(p_display: *Display) void;
    pub const close = gdk_display_close;

    /// Returns `TRUE` if there is an ongoing grab on `device` for `display`.
    extern fn gdk_display_device_is_grabbed(p_display: *Display, p_device: *gdk.Device) c_int;
    pub const deviceIsGrabbed = gdk_display_device_is_grabbed;

    /// Flushes any requests queued for the windowing system; this happens automatically
    /// when the main loop blocks waiting for new events, but if your application
    /// is drawing without returning control to the main loop, you may need
    /// to call this function explicitly. A common case where this function
    /// needs to be called is when an application is executing drawing commands
    /// from a thread other than the thread where the main loop is running.
    ///
    /// This is most useful for X11. On windowing systems where requests are
    /// handled synchronously, this function will do nothing.
    extern fn gdk_display_flush(p_display: *Display) void;
    pub const flush = gdk_display_flush;

    /// Returns a `gdk.AppLaunchContext` suitable for launching
    /// applications on the given display.
    extern fn gdk_display_get_app_launch_context(p_display: *Display) *gdk.AppLaunchContext;
    pub const getAppLaunchContext = gdk_display_get_app_launch_context;

    /// Returns the default size to use for cursors on `display`.
    extern fn gdk_display_get_default_cursor_size(p_display: *Display) c_uint;
    pub const getDefaultCursorSize = gdk_display_get_default_cursor_size;

    /// Returns the default group leader window for all toplevel windows
    /// on `display`. This window is implicitly created by GDK.
    /// See `gdk.Window.setGroup`.
    extern fn gdk_display_get_default_group(p_display: *Display) *gdk.Window;
    pub const getDefaultGroup = gdk_display_get_default_group;

    /// Get the default `gdk.Screen` for `display`.
    extern fn gdk_display_get_default_screen(p_display: *Display) *gdk.Screen;
    pub const getDefaultScreen = gdk_display_get_default_screen;

    /// Returns the default `gdk.Seat` for this display.
    extern fn gdk_display_get_default_seat(p_display: *Display) *gdk.Seat;
    pub const getDefaultSeat = gdk_display_get_default_seat;

    /// Returns the `gdk.DeviceManager` associated to `display`.
    extern fn gdk_display_get_device_manager(p_display: *Display) ?*gdk.DeviceManager;
    pub const getDeviceManager = gdk_display_get_device_manager;

    /// Gets the next `gdk.Event` to be processed for `display`, fetching events from the
    /// windowing system if necessary.
    extern fn gdk_display_get_event(p_display: *Display) ?*gdk.Event;
    pub const getEvent = gdk_display_get_event;

    /// Gets the maximal size to use for cursors on `display`.
    extern fn gdk_display_get_maximal_cursor_size(p_display: *Display, p_width: *c_uint, p_height: *c_uint) void;
    pub const getMaximalCursorSize = gdk_display_get_maximal_cursor_size;

    /// Gets a monitor associated with this display.
    extern fn gdk_display_get_monitor(p_display: *Display, p_monitor_num: c_int) ?*gdk.Monitor;
    pub const getMonitor = gdk_display_get_monitor;

    /// Gets the monitor in which the point (`x`, `y`) is located,
    /// or a nearby monitor if the point is not in any monitor.
    extern fn gdk_display_get_monitor_at_point(p_display: *Display, p_x: c_int, p_y: c_int) *gdk.Monitor;
    pub const getMonitorAtPoint = gdk_display_get_monitor_at_point;

    /// Gets the monitor in which the largest area of `window`
    /// resides, or a monitor close to `window` if it is outside
    /// of all monitors.
    extern fn gdk_display_get_monitor_at_window(p_display: *Display, p_window: *gdk.Window) *gdk.Monitor;
    pub const getMonitorAtWindow = gdk_display_get_monitor_at_window;

    /// Gets the number of monitors that belong to `display`.
    ///
    /// The returned number is valid until the next emission of the
    /// `gdk.Display.signals.monitor`-added or `gdk.Display.signals.monitor`-removed signal.
    extern fn gdk_display_get_n_monitors(p_display: *Display) c_int;
    pub const getNMonitors = gdk_display_get_n_monitors;

    /// Gets the number of screen managed by the `display`.
    extern fn gdk_display_get_n_screens(p_display: *Display) c_int;
    pub const getNScreens = gdk_display_get_n_screens;

    /// Gets the name of the display.
    extern fn gdk_display_get_name(p_display: *Display) [*:0]const u8;
    pub const getName = gdk_display_get_name;

    /// Gets the current location of the pointer and the current modifier
    /// mask for a given display.
    extern fn gdk_display_get_pointer(p_display: *Display, p_screen: ?**gdk.Screen, p_x: ?*c_int, p_y: ?*c_int, p_mask: ?*gdk.ModifierType) void;
    pub const getPointer = gdk_display_get_pointer;

    /// Gets the primary monitor for the display.
    ///
    /// The primary monitor is considered the monitor where the “main desktop”
    /// lives. While normal application windows typically allow the window
    /// manager to place the windows, specialized desktop applications
    /// such as panels should place themselves on the primary monitor.
    extern fn gdk_display_get_primary_monitor(p_display: *Display) ?*gdk.Monitor;
    pub const getPrimaryMonitor = gdk_display_get_primary_monitor;

    /// Returns a screen object for one of the screens of the display.
    extern fn gdk_display_get_screen(p_display: *Display, p_screen_num: c_int) *gdk.Screen;
    pub const getScreen = gdk_display_get_screen;

    /// Obtains the window underneath the mouse pointer, returning the location
    /// of the pointer in that window in `win_x`, `win_y` for `screen`. Returns `NULL`
    /// if the window under the mouse pointer is not known to GDK (for example,
    /// belongs to another application).
    extern fn gdk_display_get_window_at_pointer(p_display: *Display, p_win_x: ?*c_int, p_win_y: ?*c_int) ?*gdk.Window;
    pub const getWindowAtPointer = gdk_display_get_window_at_pointer;

    /// Returns whether the display has events that are waiting
    /// to be processed.
    extern fn gdk_display_has_pending(p_display: *Display) c_int;
    pub const hasPending = gdk_display_has_pending;

    /// Finds out if the display has been closed.
    extern fn gdk_display_is_closed(p_display: *Display) c_int;
    pub const isClosed = gdk_display_is_closed;

    /// Release any keyboard grab
    extern fn gdk_display_keyboard_ungrab(p_display: *Display, p_time_: u32) void;
    pub const keyboardUngrab = gdk_display_keyboard_ungrab;

    /// Returns the list of available input devices attached to `display`.
    /// The list is statically allocated and should not be freed.
    extern fn gdk_display_list_devices(p_display: *Display) *glib.List;
    pub const listDevices = gdk_display_list_devices;

    /// Returns the list of seats known to `display`.
    extern fn gdk_display_list_seats(p_display: *Display) *glib.List;
    pub const listSeats = gdk_display_list_seats;

    /// Indicates to the GUI environment that the application has
    /// finished loading, using a given identifier.
    ///
    /// GTK+ will call this function automatically for `GtkWindow`
    /// with custom startup-notification identifier unless
    /// `gtk_window_set_auto_startup_notification` is called to
    /// disable that feature.
    extern fn gdk_display_notify_startup_complete(p_display: *Display, p_startup_id: [*:0]const u8) void;
    pub const notifyStartupComplete = gdk_display_notify_startup_complete;

    /// Gets a copy of the first `gdk.Event` in the `display`’s event queue, without
    /// removing the event from the queue.  (Note that this function will
    /// not get more events from the windowing system.  It only checks the events
    /// that have already been moved to the GDK event queue.)
    extern fn gdk_display_peek_event(p_display: *Display) ?*gdk.Event;
    pub const peekEvent = gdk_display_peek_event;

    /// Test if the pointer is grabbed.
    extern fn gdk_display_pointer_is_grabbed(p_display: *Display) c_int;
    pub const pointerIsGrabbed = gdk_display_pointer_is_grabbed;

    /// Release any pointer grab.
    extern fn gdk_display_pointer_ungrab(p_display: *Display, p_time_: u32) void;
    pub const pointerUngrab = gdk_display_pointer_ungrab;

    /// Appends a copy of the given event onto the front of the event
    /// queue for `display`.
    extern fn gdk_display_put_event(p_display: *Display, p_event: *const gdk.Event) void;
    pub const putEvent = gdk_display_put_event;

    /// Request `gdk.EventOwnerChange` events for ownership changes
    /// of the selection named by the given atom.
    extern fn gdk_display_request_selection_notification(p_display: *Display, p_selection: gdk.Atom) c_int;
    pub const requestSelectionNotification = gdk_display_request_selection_notification;

    /// Sets the double click distance (two clicks within this distance
    /// count as a double click and result in a `GDK_2BUTTON_PRESS` event).
    /// See also `gdk.Display.setDoubleClickTime`.
    /// Applications should not set this, it is a global
    /// user-configured setting.
    extern fn gdk_display_set_double_click_distance(p_display: *Display, p_distance: c_uint) void;
    pub const setDoubleClickDistance = gdk_display_set_double_click_distance;

    /// Sets the double click time (two clicks within this time interval
    /// count as a double click and result in a `GDK_2BUTTON_PRESS` event).
    /// Applications should not set this, it is a global
    /// user-configured setting.
    extern fn gdk_display_set_double_click_time(p_display: *Display, p_msec: c_uint) void;
    pub const setDoubleClickTime = gdk_display_set_double_click_time;

    /// Issues a request to the clipboard manager to store the
    /// clipboard data. On X11, this is a special program that works
    /// according to the
    /// [FreeDesktop Clipboard Specification](http://www.freedesktop.org/Standards/clipboard-manager-spec).
    extern fn gdk_display_store_clipboard(p_display: *Display, p_clipboard_window: *gdk.Window, p_time_: u32, p_targets: ?[*]const gdk.Atom, p_n_targets: c_int) void;
    pub const storeClipboard = gdk_display_store_clipboard;

    /// Returns whether the speicifed display supports clipboard
    /// persistance; i.e. if it’s possible to store the clipboard data after an
    /// application has quit. On X11 this checks if a clipboard daemon is
    /// running.
    extern fn gdk_display_supports_clipboard_persistence(p_display: *Display) c_int;
    pub const supportsClipboardPersistence = gdk_display_supports_clipboard_persistence;

    /// Returns `TRUE` if `gdk.Window.setComposited` can be used
    /// to redirect drawing on the window using compositing.
    ///
    /// Currently this only works on X11 with XComposite and
    /// XDamage extensions available.
    extern fn gdk_display_supports_composite(p_display: *Display) c_int;
    pub const supportsComposite = gdk_display_supports_composite;

    /// Returns `TRUE` if cursors can use an 8bit alpha channel
    /// on `display`. Otherwise, cursors are restricted to bilevel
    /// alpha (i.e. a mask).
    extern fn gdk_display_supports_cursor_alpha(p_display: *Display) c_int;
    pub const supportsCursorAlpha = gdk_display_supports_cursor_alpha;

    /// Returns `TRUE` if multicolored cursors are supported
    /// on `display`. Otherwise, cursors have only a forground
    /// and a background color.
    extern fn gdk_display_supports_cursor_color(p_display: *Display) c_int;
    pub const supportsCursorColor = gdk_display_supports_cursor_color;

    /// Returns `TRUE` if `gdk_window_input_shape_combine_mask` can
    /// be used to modify the input shape of windows on `display`.
    extern fn gdk_display_supports_input_shapes(p_display: *Display) c_int;
    pub const supportsInputShapes = gdk_display_supports_input_shapes;

    /// Returns whether `gdk.EventOwnerChange` events will be
    /// sent when the owner of a selection changes.
    extern fn gdk_display_supports_selection_notification(p_display: *Display) c_int;
    pub const supportsSelectionNotification = gdk_display_supports_selection_notification;

    /// Returns `TRUE` if `gdk_window_shape_combine_mask` can
    /// be used to create shaped windows on `display`.
    extern fn gdk_display_supports_shapes(p_display: *Display) c_int;
    pub const supportsShapes = gdk_display_supports_shapes;

    /// Flushes any requests queued for the windowing system and waits until all
    /// requests have been handled. This is often used for making sure that the
    /// display is synchronized with the current state of the program. Calling
    /// `gdk.Display.sync` before `gdk.errorTrapPop` makes sure that any errors
    /// generated from earlier requests are handled before the error trap is
    /// removed.
    ///
    /// This is most useful for X11. On windowing systems where requests are
    /// handled synchronously, this function will do nothing.
    extern fn gdk_display_sync(p_display: *Display) void;
    pub const sync = gdk_display_sync;

    /// Warps the pointer of `display` to the point `x`,`y` on
    /// the screen `screen`, unless the pointer is confined
    /// to a window by a grab, in which case it will be moved
    /// as far as allowed by the grab. Warping the pointer
    /// creates events as if the user had moved the mouse
    /// instantaneously to the destination.
    ///
    /// Note that the pointer should normally be under the
    /// control of the user. This function was added to cover
    /// some rare use cases like keyboard navigation support
    /// for the color picker in the `GtkColorSelectionDialog`.
    extern fn gdk_display_warp_pointer(p_display: *Display, p_screen: *gdk.Screen, p_x: c_int, p_y: c_int) void;
    pub const warpPointer = gdk_display_warp_pointer;

    extern fn gdk_display_get_type() usize;
    pub const getGObjectType = gdk_display_get_type;

    extern fn g_object_ref(p_self: *gdk.Display) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Display) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Display, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The purpose of the `gdk.DisplayManager` singleton object is to offer
/// notification when displays appear or disappear or the default display
/// changes.
///
/// You can use `gdk.DisplayManager.get` to obtain the `gdk.DisplayManager`
/// singleton, but that should be rarely necessary. Typically, initializing
/// GTK+ opens a display that you can work with without ever accessing the
/// `gdk.DisplayManager`.
///
/// The GDK library can be built with support for multiple backends.
/// The `gdk.DisplayManager` object determines which backend is used
/// at runtime.
///
/// When writing backend-specific code that is supposed to work with
/// multiple GDK backends, you have to consider both compile time and
/// runtime. At compile time, use the `GDK_WINDOWING_X11`, `GDK_WINDOWING_WIN32`
/// macros, etc. to find out which backends are present in the GDK library
/// you are building your application against. At runtime, use type-check
/// macros like `GDK_IS_X11_DISPLAY` to find out which backend is in use:
///
/// ## Backend-specific code
///
/// ```
/// `ifdef` GDK_WINDOWING_X11
///   if (GDK_IS_X11_DISPLAY (display))
///     {
///       // make X11-specific calls here
///     }
///   else
/// `endif`
/// `ifdef` GDK_WINDOWING_QUARTZ
///   if (GDK_IS_QUARTZ_DISPLAY (display))
///     {
///       // make Quartz-specific calls here
///     }
///   else
/// `endif`
///   g_error ("Unsupported GDK backend");
/// ```
pub const DisplayManager = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DisplayManager;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const default_display = struct {
            pub const name = "default-display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {
        /// The ::display-opened signal is emitted when a display is opened.
        pub const display_opened = struct {
            pub const name = "display-opened";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_display: *gdk.Display, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DisplayManager, p_instance))),
                    gobject.signalLookup("display-opened", DisplayManager.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the singleton `gdk.DisplayManager` object.
    ///
    /// When called for the first time, this function consults the
    /// `GDK_BACKEND` environment variable to find out which
    /// of the supported GDK backends to use (in case GDK has been compiled
    /// with multiple backends). Applications can use `gdk.setAllowedBackends`
    /// to limit what backends can be used.
    extern fn gdk_display_manager_get() *gdk.DisplayManager;
    pub const get = gdk_display_manager_get;

    /// Gets the default `gdk.Display`.
    extern fn gdk_display_manager_get_default_display(p_manager: *DisplayManager) ?*gdk.Display;
    pub const getDefaultDisplay = gdk_display_manager_get_default_display;

    /// List all currently open displays.
    extern fn gdk_display_manager_list_displays(p_manager: *DisplayManager) *glib.SList;
    pub const listDisplays = gdk_display_manager_list_displays;

    /// Opens a display.
    extern fn gdk_display_manager_open_display(p_manager: *DisplayManager, p_name: [*:0]const u8) ?*gdk.Display;
    pub const openDisplay = gdk_display_manager_open_display;

    /// Sets `display` as the default display.
    extern fn gdk_display_manager_set_default_display(p_manager: *DisplayManager, p_display: *gdk.Display) void;
    pub const setDefaultDisplay = gdk_display_manager_set_default_display;

    extern fn gdk_display_manager_get_type() usize;
    pub const getGObjectType = gdk_display_manager_get_type;

    extern fn g_object_ref(p_self: *gdk.DisplayManager) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DisplayManager) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DisplayManager, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DragContext = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = DragContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// A new action is being chosen for the drag and drop operation.
        ///
        /// This signal will only be emitted if the `gdk.DragContext` manages
        /// the drag and drop operation. See `gdk.DragContext.manageDnd`
        /// for more information.
        pub const action_changed = struct {
            pub const name = "action-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_action: gdk.DragAction, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DragContext, p_instance))),
                    gobject.signalLookup("action-changed", DragContext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The drag and drop operation was cancelled.
        ///
        /// This signal will only be emitted if the `gdk.DragContext` manages
        /// the drag and drop operation. See `gdk.DragContext.manageDnd`
        /// for more information.
        pub const cancel = struct {
            pub const name = "cancel";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_reason: gdk.DragCancelReason, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DragContext, p_instance))),
                    gobject.signalLookup("cancel", DragContext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The drag and drop operation was finished, the drag destination
        /// finished reading all data. The drag source can now free all
        /// miscellaneous data.
        ///
        /// This signal will only be emitted if the `gdk.DragContext` manages
        /// the drag and drop operation. See `gdk.DragContext.manageDnd`
        /// for more information.
        pub const dnd_finished = struct {
            pub const name = "dnd-finished";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DragContext, p_instance))),
                    gobject.signalLookup("dnd-finished", DragContext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The drag and drop operation was performed on an accepting client.
        ///
        /// This signal will only be emitted if the `gdk.DragContext` manages
        /// the drag and drop operation. See `gdk.DragContext.manageDnd`
        /// for more information.
        pub const drop_performed = struct {
            pub const name = "drop-performed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_time: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(DragContext, p_instance))),
                    gobject.signalLookup("drop-performed", DragContext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Determines the bitmask of actions proposed by the source if
    /// `gdk.DragContext.getSuggestedAction` returns `GDK_ACTION_ASK`.
    extern fn gdk_drag_context_get_actions(p_context: *DragContext) gdk.DragAction;
    pub const getActions = gdk_drag_context_get_actions;

    /// Returns the destination window for the DND operation.
    extern fn gdk_drag_context_get_dest_window(p_context: *DragContext) *gdk.Window;
    pub const getDestWindow = gdk_drag_context_get_dest_window;

    /// Returns the `gdk.Device` associated to the drag context.
    extern fn gdk_drag_context_get_device(p_context: *DragContext) *gdk.Device;
    pub const getDevice = gdk_drag_context_get_device;

    /// Returns the window on which the drag icon should be rendered
    /// during the drag operation. Note that the window may not be
    /// available until the drag operation has begun. GDK will move
    /// the window in accordance with the ongoing drag operation.
    /// The window is owned by `context` and will be destroyed when
    /// the drag operation is over.
    extern fn gdk_drag_context_get_drag_window(p_context: *DragContext) ?*gdk.Window;
    pub const getDragWindow = gdk_drag_context_get_drag_window;

    /// Returns the drag protocol that is used by this context.
    extern fn gdk_drag_context_get_protocol(p_context: *DragContext) gdk.DragProtocol;
    pub const getProtocol = gdk_drag_context_get_protocol;

    /// Determines the action chosen by the drag destination.
    extern fn gdk_drag_context_get_selected_action(p_context: *DragContext) gdk.DragAction;
    pub const getSelectedAction = gdk_drag_context_get_selected_action;

    /// Returns the `gdk.Window` where the DND operation started.
    extern fn gdk_drag_context_get_source_window(p_context: *DragContext) *gdk.Window;
    pub const getSourceWindow = gdk_drag_context_get_source_window;

    /// Determines the suggested drag action of the context.
    extern fn gdk_drag_context_get_suggested_action(p_context: *DragContext) gdk.DragAction;
    pub const getSuggestedAction = gdk_drag_context_get_suggested_action;

    /// Retrieves the list of targets of the context.
    extern fn gdk_drag_context_list_targets(p_context: *DragContext) *glib.List;
    pub const listTargets = gdk_drag_context_list_targets;

    /// Requests the drag and drop operation to be managed by `context`.
    /// When a drag and drop operation becomes managed, the `gdk.DragContext`
    /// will internally handle all input and source-side `gdk.EventDND` events
    /// as required by the windowing system.
    ///
    /// Once the drag and drop operation is managed, the drag context will
    /// emit the following signals:
    /// - The `gdk.DragContext.signals.action`-changed signal whenever the final action
    ///   to be performed by the drag and drop operation changes.
    /// - The `gdk.DragContext.signals.drop`-performed signal after the user performs
    ///   the drag and drop gesture (typically by releasing the mouse button).
    /// - The `gdk.DragContext.signals.dnd`-finished signal after the drag and drop
    ///   operation concludes (after all `GdkSelection` transfers happen).
    /// - The `gdk.DragContext.signals.cancel` signal if the drag and drop operation is
    ///   finished but doesn't happen over an accepting destination, or is
    ///   cancelled through other means.
    extern fn gdk_drag_context_manage_dnd(p_context: *DragContext, p_ipc_window: *gdk.Window, p_actions: gdk.DragAction) c_int;
    pub const manageDnd = gdk_drag_context_manage_dnd;

    /// Associates a `gdk.Device` to `context`, so all Drag and Drop events
    /// for `context` are emitted as if they came from this device.
    extern fn gdk_drag_context_set_device(p_context: *DragContext, p_device: *gdk.Device) void;
    pub const setDevice = gdk_drag_context_set_device;

    /// Sets the position of the drag window that will be kept
    /// under the cursor hotspot. Initially, the hotspot is at the
    /// top left corner of the drag window.
    extern fn gdk_drag_context_set_hotspot(p_context: *DragContext, p_hot_x: c_int, p_hot_y: c_int) void;
    pub const setHotspot = gdk_drag_context_set_hotspot;

    extern fn gdk_drag_context_get_type() usize;
    pub const getGObjectType = gdk_drag_context_get_type;

    extern fn g_object_ref(p_self: *gdk.DragContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DragContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DragContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.DrawingContext` is an object that represents the current drawing
/// state of a `gdk.Window`.
///
/// It's possible to use a `gdk.DrawingContext` to draw on a `gdk.Window`
/// via rendering API like Cairo or OpenGL.
///
/// A `gdk.DrawingContext` can only be created by calling `gdk.Window.beginDrawFrame`
/// and will be valid until a call to `gdk.Window.endDrawFrame`.
///
/// `gdk.DrawingContext` is available since GDK 3.22
pub const DrawingContext = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.DrawingContextClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The clip region applied to the drawing context.
        pub const clip = struct {
            pub const name = "clip";

            pub const Type = ?*cairo.Region;
        };

        /// The `gdk.Window` that created the drawing context.
        pub const window = struct {
            pub const name = "window";

            pub const Type = ?*gdk.Window;
        };
    };

    pub const signals = struct {};

    /// Retrieves a Cairo context to be used to draw on the `gdk.Window`
    /// that created the `gdk.DrawingContext`.
    ///
    /// The returned context is guaranteed to be valid as long as the
    /// `gdk.DrawingContext` is valid, that is between a call to
    /// `gdk.Window.beginDrawFrame` and `gdk.Window.endDrawFrame`.
    extern fn gdk_drawing_context_get_cairo_context(p_context: *DrawingContext) *cairo.Context;
    pub const getCairoContext = gdk_drawing_context_get_cairo_context;

    /// Retrieves a copy of the clip region used when creating the `context`.
    extern fn gdk_drawing_context_get_clip(p_context: *DrawingContext) ?*cairo.Region;
    pub const getClip = gdk_drawing_context_get_clip;

    /// Retrieves the window that created the drawing `context`.
    extern fn gdk_drawing_context_get_window(p_context: *DrawingContext) *gdk.Window;
    pub const getWindow = gdk_drawing_context_get_window;

    /// Checks whether the given `gdk.DrawingContext` is valid.
    extern fn gdk_drawing_context_is_valid(p_context: *DrawingContext) c_int;
    pub const isValid = gdk_drawing_context_is_valid;

    extern fn gdk_drawing_context_get_type() usize;
    pub const getGObjectType = gdk_drawing_context_get_type;

    extern fn g_object_ref(p_self: *gdk.DrawingContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DrawingContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawingContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.FrameClock` tells the application when to update and repaint a
/// window. This may be synced to the vertical refresh rate of the
/// monitor, for example. Even when the frame clock uses a simple timer
/// rather than a hardware-based vertical sync, the frame clock helps
/// because it ensures everything paints at the same time (reducing the
/// total number of frames). The frame clock can also automatically
/// stop painting when it knows the frames will not be visible, or
/// scale back animation framerates.
///
/// `gdk.FrameClock` is designed to be compatible with an OpenGL-based
/// implementation or with mozRequestAnimationFrame in Firefox,
/// for example.
///
/// A frame clock is idle until someone requests a frame with
/// `gdk.FrameClock.requestPhase`. At some later point that makes
/// sense for the synchronization being implemented, the clock will
/// process a frame and emit signals for each phase that has been
/// requested. (See the signals of the `gdk.FrameClock` class for
/// documentation of the phases. `GDK_FRAME_CLOCK_PHASE_UPDATE` and the
/// `gdk.FrameClock.signals.update` signal are most interesting for application
/// writers, and are used to update the animations, using the frame time
/// given by `gdk.FrameClock.getFrameTime`.
///
/// The frame time is reported in microseconds and generally in the same
/// timescale as `glib.getMonotonicTime`, however, it is not the same
/// as `glib.getMonotonicTime`. The frame time does not advance during
/// the time a frame is being painted, and outside of a frame, an attempt
/// is made so that all calls to `gdk.FrameClock.getFrameTime` that
/// are called at a “similar” time get the same value. This means that
/// if different animations are timed by looking at the difference in
/// time between an initial value from `gdk.FrameClock.getFrameTime`
/// and the value inside the `gdk.FrameClock.signals.update` signal of the clock,
/// they will stay exactly synchronized.
pub const FrameClock = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.FrameClockClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal ends processing of the frame. Applications
        /// should generally not handle this signal.
        pub const after_paint = struct {
            pub const name = "after-paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("after-paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal begins processing of the frame. Applications
        /// should generally not handle this signal.
        pub const before_paint = struct {
            pub const name = "before-paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("before-paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is used to flush pending motion events that
        /// are being batched up and compressed together. Applications
        /// should not handle this signal.
        pub const flush_events = struct {
            pub const name = "flush-events";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("flush-events", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted as the second step of toolkit and
        /// application processing of the frame. Any work to update
        /// sizes and positions of application elements should be
        /// performed. GTK+ normally handles this internally.
        pub const layout = struct {
            pub const name = "layout";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("layout", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted as the third step of toolkit and
        /// application processing of the frame. The frame is
        /// repainted. GDK normally handles this internally and
        /// produces expose events, which are turned into GTK+
        /// `GtkWidget.signals.draw` signals.
        pub const paint = struct {
            pub const name = "paint";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("paint", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted after processing of the frame is
        /// finished, and is handled internally by GTK+ to resume normal
        /// event processing. Applications should not handle this signal.
        pub const resume_events = struct {
            pub const name = "resume-events";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("resume-events", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted as the first step of toolkit and
        /// application processing of the frame. Animations should
        /// be updated using `gdk.FrameClock.getFrameTime`.
        /// Applications can connect directly to this signal, or
        /// use `gtk_widget_add_tick_callback` as a more convenient
        /// interface.
        pub const update = struct {
            pub const name = "update";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(FrameClock, p_instance))),
                    gobject.signalLookup("update", FrameClock.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Starts updates for an animation. Until a matching call to
    /// `gdk.FrameClock.endUpdating` is made, the frame clock will continually
    /// request a new frame with the `GDK_FRAME_CLOCK_PHASE_UPDATE` phase.
    /// This function may be called multiple times and frames will be
    /// requested until `gdk.FrameClock.endUpdating` is called the same
    /// number of times.
    extern fn gdk_frame_clock_begin_updating(p_frame_clock: *FrameClock) void;
    pub const beginUpdating = gdk_frame_clock_begin_updating;

    /// Stops updates for an animation. See the documentation for
    /// `gdk.FrameClock.beginUpdating`.
    extern fn gdk_frame_clock_end_updating(p_frame_clock: *FrameClock) void;
    pub const endUpdating = gdk_frame_clock_end_updating;

    /// Gets the frame timings for the current frame.
    extern fn gdk_frame_clock_get_current_timings(p_frame_clock: *FrameClock) ?*gdk.FrameTimings;
    pub const getCurrentTimings = gdk_frame_clock_get_current_timings;

    /// A `gdk.FrameClock` maintains a 64-bit counter that increments for
    /// each frame drawn.
    extern fn gdk_frame_clock_get_frame_counter(p_frame_clock: *FrameClock) i64;
    pub const getFrameCounter = gdk_frame_clock_get_frame_counter;

    /// Gets the time that should currently be used for animations.  Inside
    /// the processing of a frame, it’s the time used to compute the
    /// animation position of everything in a frame. Outside of a frame, it's
    /// the time of the conceptual “previous frame,” which may be either
    /// the actual previous frame time, or if that’s too old, an updated
    /// time.
    extern fn gdk_frame_clock_get_frame_time(p_frame_clock: *FrameClock) i64;
    pub const getFrameTime = gdk_frame_clock_get_frame_time;

    /// `gdk.FrameClock` internally keeps a history of `gdk.FrameTimings`
    /// objects for recent frames that can be retrieved with
    /// `gdk.FrameClock.getTimings`. The set of stored frames
    /// is the set from the counter values given by
    /// `gdk.FrameClock.getHistoryStart` and
    /// `gdk.FrameClock.getFrameCounter`, inclusive.
    extern fn gdk_frame_clock_get_history_start(p_frame_clock: *FrameClock) i64;
    pub const getHistoryStart = gdk_frame_clock_get_history_start;

    /// Using the frame history stored in the frame clock, finds the last
    /// known presentation time and refresh interval, and assuming that
    /// presentation times are separated by the refresh interval,
    /// predicts a presentation time that is a multiple of the refresh
    /// interval after the last presentation time, and later than `base_time`.
    extern fn gdk_frame_clock_get_refresh_info(p_frame_clock: *FrameClock, p_base_time: i64, p_refresh_interval_return: ?*i64, p_presentation_time_return: *i64) void;
    pub const getRefreshInfo = gdk_frame_clock_get_refresh_info;

    /// Retrieves a `gdk.FrameTimings` object holding timing information
    /// for the current frame or a recent frame. The `gdk.FrameTimings`
    /// object may not yet be complete: see `gdk.FrameTimings.getComplete`.
    extern fn gdk_frame_clock_get_timings(p_frame_clock: *FrameClock, p_frame_counter: i64) ?*gdk.FrameTimings;
    pub const getTimings = gdk_frame_clock_get_timings;

    /// Asks the frame clock to run a particular phase. The signal
    /// corresponding the requested phase will be emitted the next
    /// time the frame clock processes. Multiple calls to
    /// `gdk.FrameClock.requestPhase` will be combined together
    /// and only one frame processed. If you are displaying animated
    /// content and want to continually request the
    /// `GDK_FRAME_CLOCK_PHASE_UPDATE` phase for a period of time,
    /// you should use `gdk.FrameClock.beginUpdating` instead, since
    /// this allows GTK+ to adjust system parameters to get maximally
    /// smooth animations.
    extern fn gdk_frame_clock_request_phase(p_frame_clock: *FrameClock, p_phase: gdk.FrameClockPhase) void;
    pub const requestPhase = gdk_frame_clock_request_phase;

    extern fn gdk_frame_clock_get_type() usize;
    pub const getGObjectType = gdk_frame_clock_get_type;

    extern fn g_object_ref(p_self: *gdk.FrameClock) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.FrameClock) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FrameClock, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.GLContext` is an object representing the platform-specific
/// OpenGL drawing context.
///
/// `GdkGLContexts` are created for a `gdk.Window` using
/// `gdk.Window.createGlContext`, and the context will match
/// the `gdk.Visual` of the window.
///
/// A `gdk.GLContext` is not tied to any particular normal framebuffer.
/// For instance, it cannot draw to the `gdk.Window` back buffer. The GDK
/// repaint system is in full control of the painting to that. Instead,
/// you can create render buffers or textures and use `gdk.cairoDrawFromGl`
/// in the draw function of your widget to draw them. Then GDK will handle
/// the integration of your rendering with that of other widgets.
///
/// Support for `gdk.GLContext` is platform-specific, context creation
/// can fail, returning `NULL` context.
///
/// A `gdk.GLContext` has to be made "current" in order to start using
/// it, otherwise any OpenGL call will be ignored.
///
/// ## Creating a new OpenGL context
///
/// In order to create a new `gdk.GLContext` instance you need a
/// `gdk.Window`, which you typically get during the realize call
/// of a widget.
///
/// A `gdk.GLContext` is not realized until either `gdk.GLContext.makeCurrent`,
/// or until it is realized using `gdk.GLContext.realize`. It is possible to
/// specify details of the GL context like the OpenGL version to be used, or
/// whether the GL context should have extra state validation enabled after
/// calling `gdk.Window.createGlContext` by calling `gdk.GLContext.realize`.
/// If the realization fails you have the option to change the settings of the
/// `gdk.GLContext` and try again.
///
/// ## Using a GdkGLContext
///
/// You will need to make the `gdk.GLContext` the current context
/// before issuing OpenGL calls; the system sends OpenGL commands to
/// whichever context is current. It is possible to have multiple
/// contexts, so you always need to ensure that the one which you
/// want to draw with is the current one before issuing commands:
///
/// ```
///   gdk_gl_context_make_current (context);
/// ```
///
/// You can now perform your drawing using OpenGL commands.
///
/// You can check which `gdk.GLContext` is the current one by using
/// `gdk.GLContext.getCurrent`; you can also unset any `gdk.GLContext`
/// that is currently set by calling `gdk.GLContext.clearCurrent`.
pub const GLContext = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = GLContext;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `gdk.Display` used to create the `gdk.GLContext`.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        /// The `gdk.GLContext` that this context is sharing data with, or `NULL`
        pub const shared_context = struct {
            pub const name = "shared-context";

            pub const Type = ?*gdk.GLContext;
        };

        /// The `gdk.Window` the gl context is bound to.
        pub const window = struct {
            pub const name = "window";

            pub const Type = ?*gdk.Window;
        };
    };

    pub const signals = struct {};

    /// Clears the current `gdk.GLContext`.
    ///
    /// Any OpenGL call after this function returns will be ignored
    /// until `gdk.GLContext.makeCurrent` is called.
    extern fn gdk_gl_context_clear_current() void;
    pub const clearCurrent = gdk_gl_context_clear_current;

    /// Retrieves the current `gdk.GLContext`.
    extern fn gdk_gl_context_get_current() ?*gdk.GLContext;
    pub const getCurrent = gdk_gl_context_get_current;

    /// Retrieves the value set using `gdk.GLContext.setDebugEnabled`.
    extern fn gdk_gl_context_get_debug_enabled(p_context: *GLContext) c_int;
    pub const getDebugEnabled = gdk_gl_context_get_debug_enabled;

    /// Retrieves the `gdk.Display` the `context` is created for
    extern fn gdk_gl_context_get_display(p_context: *GLContext) ?*gdk.Display;
    pub const getDisplay = gdk_gl_context_get_display;

    /// Retrieves the value set using `gdk.GLContext.setForwardCompatible`.
    extern fn gdk_gl_context_get_forward_compatible(p_context: *GLContext) c_int;
    pub const getForwardCompatible = gdk_gl_context_get_forward_compatible;

    /// Retrieves the major and minor version requested by calling
    /// `gdk.GLContext.setRequiredVersion`.
    extern fn gdk_gl_context_get_required_version(p_context: *GLContext, p_major: ?*c_int, p_minor: ?*c_int) void;
    pub const getRequiredVersion = gdk_gl_context_get_required_version;

    /// Retrieves the `gdk.GLContext` that this `context` share data with.
    extern fn gdk_gl_context_get_shared_context(p_context: *GLContext) ?*gdk.GLContext;
    pub const getSharedContext = gdk_gl_context_get_shared_context;

    /// Checks whether the `context` is using an OpenGL or OpenGL ES profile.
    extern fn gdk_gl_context_get_use_es(p_context: *GLContext) c_int;
    pub const getUseEs = gdk_gl_context_get_use_es;

    /// Retrieves the OpenGL version of the `context`.
    ///
    /// The `context` must be realized prior to calling this function.
    extern fn gdk_gl_context_get_version(p_context: *GLContext, p_major: *c_int, p_minor: *c_int) void;
    pub const getVersion = gdk_gl_context_get_version;

    /// Retrieves the `gdk.Window` used by the `context`.
    extern fn gdk_gl_context_get_window(p_context: *GLContext) ?*gdk.Window;
    pub const getWindow = gdk_gl_context_get_window;

    /// Whether the `gdk.GLContext` is in legacy mode or not.
    ///
    /// The `gdk.GLContext` must be realized before calling this function.
    ///
    /// When realizing a GL context, GDK will try to use the OpenGL 3.2 core
    /// profile; this profile removes all the OpenGL API that was deprecated
    /// prior to the 3.2 version of the specification. If the realization is
    /// successful, this function will return `FALSE`.
    ///
    /// If the underlying OpenGL implementation does not support core profiles,
    /// GDK will fall back to a pre-3.2 compatibility profile, and this function
    /// will return `TRUE`.
    ///
    /// You can use the value returned by this function to decide which kind
    /// of OpenGL API to use, or whether to do extension discovery, or what
    /// kind of shader programs to load.
    extern fn gdk_gl_context_is_legacy(p_context: *GLContext) c_int;
    pub const isLegacy = gdk_gl_context_is_legacy;

    /// Makes the `context` the current one.
    extern fn gdk_gl_context_make_current(p_context: *GLContext) void;
    pub const makeCurrent = gdk_gl_context_make_current;

    /// Realizes the given `gdk.GLContext`.
    ///
    /// It is safe to call this function on a realized `gdk.GLContext`.
    extern fn gdk_gl_context_realize(p_context: *GLContext, p_error: ?*?*glib.Error) c_int;
    pub const realize = gdk_gl_context_realize;

    /// Sets whether the `gdk.GLContext` should perform extra validations and
    /// run time checking. This is useful during development, but has
    /// additional overhead.
    ///
    /// The `gdk.GLContext` must not be realized or made current prior to
    /// calling this function.
    extern fn gdk_gl_context_set_debug_enabled(p_context: *GLContext, p_enabled: c_int) void;
    pub const setDebugEnabled = gdk_gl_context_set_debug_enabled;

    /// Sets whether the `gdk.GLContext` should be forward compatible.
    ///
    /// Forward compatibile contexts must not support OpenGL functionality that
    /// has been marked as deprecated in the requested version; non-forward
    /// compatible contexts, on the other hand, must support both deprecated and
    /// non deprecated functionality.
    ///
    /// The `gdk.GLContext` must not be realized or made current prior to calling
    /// this function.
    extern fn gdk_gl_context_set_forward_compatible(p_context: *GLContext, p_compatible: c_int) void;
    pub const setForwardCompatible = gdk_gl_context_set_forward_compatible;

    /// Sets the major and minor version of OpenGL to request.
    ///
    /// Setting `major` and `minor` to zero will use the default values.
    ///
    /// The `gdk.GLContext` must not be realized or made current prior to calling
    /// this function.
    extern fn gdk_gl_context_set_required_version(p_context: *GLContext, p_major: c_int, p_minor: c_int) void;
    pub const setRequiredVersion = gdk_gl_context_set_required_version;

    /// Requests that GDK create a OpenGL ES context instead of an OpenGL one,
    /// if the platform and windowing system allows it.
    ///
    /// The `context` must not have been realized.
    ///
    /// By default, GDK will attempt to automatically detect whether the
    /// underlying GL implementation is OpenGL or OpenGL ES once the `context`
    /// is realized.
    ///
    /// You should check the return value of `gdk.GLContext.getUseEs` after
    /// calling `gdk.GLContext.realize` to decide whether to use the OpenGL or
    /// OpenGL ES API, extensions, or shaders.
    extern fn gdk_gl_context_set_use_es(p_context: *GLContext, p_use_es: c_int) void;
    pub const setUseEs = gdk_gl_context_set_use_es;

    extern fn gdk_gl_context_get_type() usize;
    pub const getGObjectType = gdk_gl_context_get_type;

    extern fn g_object_ref(p_self: *gdk.GLContext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.GLContext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GLContext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.Keymap` defines the translation from keyboard state
/// (including a hardware key, a modifier mask, and active keyboard group)
/// to a keyval. This translation has two phases. The first phase is
/// to determine the effective keyboard group and level for the keyboard
/// state; the second phase is to look up the keycode/group/level triplet
/// in the keymap and see what keyval it corresponds to.
pub const Keymap = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Keymap;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// The ::direction-changed signal gets emitted when the direction of
        /// the keymap changes.
        pub const direction_changed = struct {
            pub const name = "direction-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Keymap, p_instance))),
                    gobject.signalLookup("direction-changed", Keymap.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::keys-changed signal is emitted when the mapping represented by
        /// `keymap` changes.
        pub const keys_changed = struct {
            pub const name = "keys-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Keymap, p_instance))),
                    gobject.signalLookup("keys-changed", Keymap.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::state-changed signal is emitted when the state of the
        /// keyboard changes, e.g when Caps Lock is turned on or off.
        /// See `gdk.Keymap.getCapsLockState`.
        pub const state_changed = struct {
            pub const name = "state-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Keymap, p_instance))),
                    gobject.signalLookup("state-changed", Keymap.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the `gdk.Keymap` attached to the default display.
    extern fn gdk_keymap_get_default() *gdk.Keymap;
    pub const getDefault = gdk_keymap_get_default;

    /// Returns the `gdk.Keymap` attached to `display`.
    extern fn gdk_keymap_get_for_display(p_display: *gdk.Display) *gdk.Keymap;
    pub const getForDisplay = gdk_keymap_get_for_display;

    /// Maps the non-virtual modifiers (i.e Mod2, Mod3, ...) which are set
    /// in `state` to the virtual modifiers (i.e. Super, Hyper and Meta) and
    /// set the corresponding bits in `state`.
    ///
    /// GDK already does this before delivering key events, but for
    /// compatibility reasons, it only sets the first virtual modifier
    /// it finds, whereas this function sets all matching virtual modifiers.
    ///
    /// This function is useful when matching key events against
    /// accelerators.
    extern fn gdk_keymap_add_virtual_modifiers(p_keymap: *Keymap, p_state: *gdk.ModifierType) void;
    pub const addVirtualModifiers = gdk_keymap_add_virtual_modifiers;

    /// Returns whether the Caps Lock modifer is locked.
    extern fn gdk_keymap_get_caps_lock_state(p_keymap: *Keymap) c_int;
    pub const getCapsLockState = gdk_keymap_get_caps_lock_state;

    /// Returns the direction of effective layout of the keymap.
    extern fn gdk_keymap_get_direction(p_keymap: *Keymap) pango.Direction;
    pub const getDirection = gdk_keymap_get_direction;

    /// Returns the keyvals bound to `hardware_keycode`.
    /// The Nth `gdk.KeymapKey` in `keys` is bound to the Nth
    /// keyval in `keyvals`. Free the returned arrays with `glib.free`.
    /// When a keycode is pressed by the user, the keyval from
    /// this list of entries is selected by considering the effective
    /// keyboard group and level. See `gdk.Keymap.translateKeyboardState`.
    extern fn gdk_keymap_get_entries_for_keycode(p_keymap: *Keymap, p_hardware_keycode: c_uint, p_keys: ?*[*]gdk.KeymapKey, p_keyvals: ?*[*]c_uint, p_n_entries: *c_int) c_int;
    pub const getEntriesForKeycode = gdk_keymap_get_entries_for_keycode;

    /// Obtains a list of keycode/group/level combinations that will
    /// generate `keyval`. Groups and levels are two kinds of keyboard mode;
    /// in general, the level determines whether the top or bottom symbol
    /// on a key is used, and the group determines whether the left or
    /// right symbol is used. On US keyboards, the shift key changes the
    /// keyboard level, and there are no groups. A group switch key might
    /// convert a keyboard between Hebrew to English modes, for example.
    /// `gdk.EventKey` contains a `group` field that indicates the active
    /// keyboard group. The level is computed from the modifier mask.
    /// The returned array should be freed
    /// with `glib.free`.
    extern fn gdk_keymap_get_entries_for_keyval(p_keymap: *Keymap, p_keyval: c_uint, p_keys: *[*]gdk.KeymapKey, p_n_keys: *c_int) c_int;
    pub const getEntriesForKeyval = gdk_keymap_get_entries_for_keyval;

    /// Returns the modifier mask the `keymap`’s windowing system backend
    /// uses for a particular purpose.
    ///
    /// Note that this function always returns real hardware modifiers, not
    /// virtual ones (e.g. it will return `GDK_MOD1_MASK` rather than
    /// `GDK_META_MASK` if the backend maps MOD1 to META), so there are use
    /// cases where the return value of this function has to be transformed
    /// by `gdk.Keymap.addVirtualModifiers` in order to contain the
    /// expected result.
    extern fn gdk_keymap_get_modifier_mask(p_keymap: *Keymap, p_intent: gdk.ModifierIntent) gdk.ModifierType;
    pub const getModifierMask = gdk_keymap_get_modifier_mask;

    /// Returns the current modifier state.
    extern fn gdk_keymap_get_modifier_state(p_keymap: *Keymap) c_uint;
    pub const getModifierState = gdk_keymap_get_modifier_state;

    /// Returns whether the Num Lock modifer is locked.
    extern fn gdk_keymap_get_num_lock_state(p_keymap: *Keymap) c_int;
    pub const getNumLockState = gdk_keymap_get_num_lock_state;

    /// Returns whether the Scroll Lock modifer is locked.
    extern fn gdk_keymap_get_scroll_lock_state(p_keymap: *Keymap) c_int;
    pub const getScrollLockState = gdk_keymap_get_scroll_lock_state;

    /// Determines if keyboard layouts for both right-to-left and left-to-right
    /// languages are in use.
    extern fn gdk_keymap_have_bidi_layouts(p_keymap: *Keymap) c_int;
    pub const haveBidiLayouts = gdk_keymap_have_bidi_layouts;

    /// Looks up the keyval mapped to a keycode/group/level triplet.
    /// If no keyval is bound to `key`, returns 0. For normal user input,
    /// you want to use `gdk.Keymap.translateKeyboardState` instead of
    /// this function, since the effective group/level may not be
    /// the same as the current keyboard state.
    extern fn gdk_keymap_lookup_key(p_keymap: *Keymap, p_key: *const gdk.KeymapKey) c_uint;
    pub const lookupKey = gdk_keymap_lookup_key;

    /// Maps the virtual modifiers (i.e. Super, Hyper and Meta) which
    /// are set in `state` to their non-virtual counterparts (i.e. Mod2,
    /// Mod3,...) and set the corresponding bits in `state`.
    ///
    /// This function is useful when matching key events against
    /// accelerators.
    extern fn gdk_keymap_map_virtual_modifiers(p_keymap: *Keymap, p_state: *gdk.ModifierType) c_int;
    pub const mapVirtualModifiers = gdk_keymap_map_virtual_modifiers;

    /// Translates the contents of a `gdk.EventKey` into a keyval, effective
    /// group, and level. Modifiers that affected the translation and
    /// are thus unavailable for application use are returned in
    /// `consumed_modifiers`.
    /// See [Groups][key-group-explanation] for an explanation of
    /// groups and levels. The `effective_group` is the group that was
    /// actually used for the translation; some keys such as Enter are not
    /// affected by the active keyboard group. The `level` is derived from
    /// `state`. For convenience, `gdk.EventKey` already contains the translated
    /// keyval, so this function isn’t as useful as you might think.
    ///
    /// `consumed_modifiers` gives modifiers that should be masked outfrom `state`
    /// when comparing this key press to a hot key. For instance, on a US keyboard,
    /// the `plus` symbol is shifted, so when comparing a key press to a
    /// `<Control>plus` accelerator `<Shift>` should be masked out.
    ///
    /// ```
    /// // We want to ignore irrelevant modifiers like ScrollLock
    /// `define` ALL_ACCELS_MASK (GDK_CONTROL_MASK | GDK_SHIFT_MASK | GDK_MOD1_MASK)
    /// gdk_keymap_translate_keyboard_state (keymap, event->hardware_keycode,
    ///                                      event->state, event->group,
    ///                                      &keyval, NULL, NULL, &consumed);
    /// if (keyval == GDK_PLUS &&
    ///     (event->state & ~consumed & ALL_ACCELS_MASK) == GDK_CONTROL_MASK)
    ///   // Control was pressed
    /// ```
    ///
    /// An older interpretation `consumed_modifiers` was that it contained
    /// all modifiers that might affect the translation of the key;
    /// this allowed accelerators to be stored with irrelevant consumed
    /// modifiers, by doing:
    /// ```
    /// // XXX Don’t do this XXX
    /// if (keyval == accel_keyval &&
    ///     (event->state & ~consumed & ALL_ACCELS_MASK) == (accel_mods & ~consumed))
    ///   // Accelerator was pressed
    /// ```
    ///
    /// However, this did not work if multi-modifier combinations were
    /// used in the keymap, since, for instance, `<Control>` would be
    /// masked out even if only `<Control><Alt>` was used in the keymap.
    /// To support this usage as well as well as possible, all single
    /// modifier combinations that could affect the key for any combination
    /// of modifiers will be returned in `consumed_modifiers`; multi-modifier
    /// combinations are returned only when actually found in `state`. When
    /// you store accelerators, you should always store them with consumed
    /// modifiers removed. Store `<Control>plus`, not `<Control><Shift>plus`,
    extern fn gdk_keymap_translate_keyboard_state(p_keymap: *Keymap, p_hardware_keycode: c_uint, p_state: gdk.ModifierType, p_group: c_int, p_keyval: ?*c_uint, p_effective_group: ?*c_int, p_level: ?*c_int, p_consumed_modifiers: ?*gdk.ModifierType) c_int;
    pub const translateKeyboardState = gdk_keymap_translate_keyboard_state;

    extern fn gdk_keymap_get_type() usize;
    pub const getGObjectType = gdk_keymap_get_type;

    extern fn g_object_ref(p_self: *gdk.Keymap) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Keymap) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Keymap, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// GdkMonitor objects represent the individual outputs that are
/// associated with a `gdk.Display`. GdkDisplay has APIs to enumerate
/// monitors with `gdk.Display.getNMonitors` and `gdk.Display.getMonitor`, and
/// to find particular monitors with `gdk.Display.getPrimaryMonitor` or
/// `gdk.Display.getMonitorAtWindow`.
///
/// GdkMonitor was introduced in GTK+ 3.22 and supersedes earlier
/// APIs in GdkScreen to obtain monitor-related information.
pub const Monitor = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.MonitorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };

        pub const geometry = struct {
            pub const name = "geometry";

            pub const Type = ?*gdk.Rectangle;
        };

        pub const height_mm = struct {
            pub const name = "height-mm";

            pub const Type = c_int;
        };

        pub const manufacturer = struct {
            pub const name = "manufacturer";

            pub const Type = ?[*:0]u8;
        };

        pub const model = struct {
            pub const name = "model";

            pub const Type = ?[*:0]u8;
        };

        pub const refresh_rate = struct {
            pub const name = "refresh-rate";

            pub const Type = c_int;
        };

        pub const scale_factor = struct {
            pub const name = "scale-factor";

            pub const Type = c_int;
        };

        pub const subpixel_layout = struct {
            pub const name = "subpixel-layout";

            pub const Type = gdk.SubpixelLayout;
        };

        pub const width_mm = struct {
            pub const name = "width-mm";

            pub const Type = c_int;
        };

        pub const workarea = struct {
            pub const name = "workarea";

            pub const Type = ?*gdk.Rectangle;
        };
    };

    pub const signals = struct {
        pub const invalidate = struct {
            pub const name = "invalidate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Monitor, p_instance))),
                    gobject.signalLookup("invalidate", Monitor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the display that this monitor belongs to.
    extern fn gdk_monitor_get_display(p_monitor: *Monitor) *gdk.Display;
    pub const getDisplay = gdk_monitor_get_display;

    /// Retrieves the size and position of an individual monitor within the
    /// display coordinate space. The returned geometry is in  ”application pixels”,
    /// not in ”device pixels” (see `gdk.Monitor.getScaleFactor`).
    extern fn gdk_monitor_get_geometry(p_monitor: *Monitor, p_geometry: *gdk.Rectangle) void;
    pub const getGeometry = gdk_monitor_get_geometry;

    /// Gets the height in millimeters of the monitor.
    extern fn gdk_monitor_get_height_mm(p_monitor: *Monitor) c_int;
    pub const getHeightMm = gdk_monitor_get_height_mm;

    /// Gets the name or PNP ID of the monitor's manufacturer, if available.
    ///
    /// Note that this value might also vary depending on actual
    /// display backend.
    ///
    /// PNP ID registry is located at https://uefi.org/pnp_id_list
    extern fn gdk_monitor_get_manufacturer(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getManufacturer = gdk_monitor_get_manufacturer;

    /// Gets the a string identifying the monitor model, if available.
    extern fn gdk_monitor_get_model(p_monitor: *Monitor) ?[*:0]const u8;
    pub const getModel = gdk_monitor_get_model;

    /// Gets the refresh rate of the monitor, if available.
    ///
    /// The value is in milli-Hertz, so a refresh rate of 60Hz
    /// is returned as 60000.
    extern fn gdk_monitor_get_refresh_rate(p_monitor: *Monitor) c_int;
    pub const getRefreshRate = gdk_monitor_get_refresh_rate;

    /// Gets the internal scale factor that maps from monitor coordinates
    /// to the actual device pixels. On traditional systems this is 1, but
    /// on very high density outputs this can be a higher value (often 2).
    ///
    /// This can be used if you want to create pixel based data for a
    /// particular monitor, but most of the time you’re drawing to a window
    /// where it is better to use `gdk.Window.getScaleFactor` instead.
    extern fn gdk_monitor_get_scale_factor(p_monitor: *Monitor) c_int;
    pub const getScaleFactor = gdk_monitor_get_scale_factor;

    /// Gets information about the layout of red, green and blue
    /// primaries for each pixel in this monitor, if available.
    extern fn gdk_monitor_get_subpixel_layout(p_monitor: *Monitor) gdk.SubpixelLayout;
    pub const getSubpixelLayout = gdk_monitor_get_subpixel_layout;

    /// Gets the width in millimeters of the monitor.
    extern fn gdk_monitor_get_width_mm(p_monitor: *Monitor) c_int;
    pub const getWidthMm = gdk_monitor_get_width_mm;

    /// Retrieves the size and position of the “work area” on a monitor
    /// within the display coordinate space. The returned geometry is in
    /// ”application pixels”, not in ”device pixels” (see
    /// `gdk.Monitor.getScaleFactor`).
    ///
    /// The work area should be considered when positioning menus and
    /// similar popups, to avoid placing them below panels, docks or other
    /// desktop components.
    ///
    /// Note that not all backends may have a concept of workarea. This
    /// function will return the monitor geometry if a workarea is not
    /// available, or does not apply.
    extern fn gdk_monitor_get_workarea(p_monitor: *Monitor, p_workarea: *gdk.Rectangle) void;
    pub const getWorkarea = gdk_monitor_get_workarea;

    /// Gets whether this monitor should be considered primary
    /// (see `gdk.Display.getPrimaryMonitor`).
    extern fn gdk_monitor_is_primary(p_monitor: *Monitor) c_int;
    pub const isPrimary = gdk_monitor_is_primary;

    extern fn gdk_monitor_get_type() usize;
    pub const getGObjectType = gdk_monitor_get_type;

    extern fn g_object_ref(p_self: *gdk.Monitor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Monitor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Monitor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.Screen` objects are the GDK representation of the screen on
/// which windows can be displayed and on which the pointer moves.
/// X originally identified screens with physical screens, but
/// nowadays it is more common to have a single `gdk.Screen` which
/// combines several physical monitors (see `gdk.Screen.getNMonitors`).
///
/// GdkScreen is used throughout GDK and GTK+ to specify which screen
/// the top level windows are to be displayed on. it is also used to
/// query the screen specification and default settings such as
/// the default visual (`gdk.Screen.getSystemVisual`), the dimensions
/// of the physical monitors (`gdk.Screen.getMonitorGeometry`), etc.
pub const Screen = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Screen;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const font_options = struct {
            pub const name = "font-options";

            pub const Type = ?*anyopaque;
        };

        pub const resolution = struct {
            pub const name = "resolution";

            pub const Type = f64;
        };
    };

    pub const signals = struct {
        /// The ::composited-changed signal is emitted when the composited
        /// status of the screen changes
        pub const composited_changed = struct {
            pub const name = "composited-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Screen, p_instance))),
                    gobject.signalLookup("composited-changed", Screen.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::monitors-changed signal is emitted when the number, size
        /// or position of the monitors attached to the screen change.
        ///
        /// Only for X11 and OS X for now. A future implementation for Win32
        /// may be a possibility.
        pub const monitors_changed = struct {
            pub const name = "monitors-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Screen, p_instance))),
                    gobject.signalLookup("monitors-changed", Screen.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::size-changed signal is emitted when the pixel width or
        /// height of a screen changes.
        pub const size_changed = struct {
            pub const name = "size-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Screen, p_instance))),
                    gobject.signalLookup("size-changed", Screen.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the default screen for the default display. (See
    /// gdk_display_get_default ()).
    extern fn gdk_screen_get_default() ?*gdk.Screen;
    pub const getDefault = gdk_screen_get_default;

    /// Gets the height of the default screen in pixels. The returned
    /// size is in ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    extern fn gdk_screen_height() c_int;
    pub const height = gdk_screen_height;

    /// Returns the height of the default screen in millimeters.
    /// Note that on many X servers this value will not be correct.
    extern fn gdk_screen_height_mm() c_int;
    pub const heightMm = gdk_screen_height_mm;

    /// Gets the width of the default screen in pixels. The returned
    /// size is in ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    extern fn gdk_screen_width() c_int;
    pub const width = gdk_screen_width;

    /// Returns the width of the default screen in millimeters.
    /// Note that on many X servers this value will not be correct.
    extern fn gdk_screen_width_mm() c_int;
    pub const widthMm = gdk_screen_width_mm;

    /// Returns the screen’s currently active window.
    ///
    /// On X11, this is done by inspecting the _NET_ACTIVE_WINDOW property
    /// on the root window, as described in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec).
    /// If there is no currently currently active
    /// window, or the window manager does not support the
    /// _NET_ACTIVE_WINDOW hint, this function returns `NULL`.
    ///
    /// On other platforms, this function may return `NULL`, depending on whether
    /// it is implementable on that platform.
    ///
    /// The returned window should be unrefed using `gobject.Object.unref` when
    /// no longer needed.
    extern fn gdk_screen_get_active_window(p_screen: *Screen) ?*gdk.Window;
    pub const getActiveWindow = gdk_screen_get_active_window;

    /// Gets the display to which the `screen` belongs.
    extern fn gdk_screen_get_display(p_screen: *Screen) *gdk.Display;
    pub const getDisplay = gdk_screen_get_display;

    /// Gets any options previously set with `gdk.Screen.setFontOptions`.
    extern fn gdk_screen_get_font_options(p_screen: *Screen) ?*const cairo.FontOptions;
    pub const getFontOptions = gdk_screen_get_font_options;

    /// Gets the height of `screen` in pixels. The returned size is in
    /// ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    extern fn gdk_screen_get_height(p_screen: *Screen) c_int;
    pub const getHeight = gdk_screen_get_height;

    /// Returns the height of `screen` in millimeters.
    ///
    /// Note that this value is somewhat ill-defined when the screen
    /// has multiple monitors of different resolution. It is recommended
    /// to use the monitor dimensions instead.
    extern fn gdk_screen_get_height_mm(p_screen: *Screen) c_int;
    pub const getHeightMm = gdk_screen_get_height_mm;

    /// Returns the monitor number in which the point (`x`,`y`) is located.
    extern fn gdk_screen_get_monitor_at_point(p_screen: *Screen, p_x: c_int, p_y: c_int) c_int;
    pub const getMonitorAtPoint = gdk_screen_get_monitor_at_point;

    /// Returns the number of the monitor in which the largest area of the
    /// bounding rectangle of `window` resides.
    extern fn gdk_screen_get_monitor_at_window(p_screen: *Screen, p_window: *gdk.Window) c_int;
    pub const getMonitorAtWindow = gdk_screen_get_monitor_at_window;

    /// Retrieves the `gdk.Rectangle` representing the size and position of
    /// the individual monitor within the entire screen area. The returned
    /// geometry is in ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    ///
    /// Monitor numbers start at 0. To obtain the number of monitors of
    /// `screen`, use `gdk.Screen.getNMonitors`.
    ///
    /// Note that the size of the entire screen area can be retrieved via
    /// `gdk.Screen.getWidth` and `gdk.Screen.getHeight`.
    extern fn gdk_screen_get_monitor_geometry(p_screen: *Screen, p_monitor_num: c_int, p_dest: ?*gdk.Rectangle) void;
    pub const getMonitorGeometry = gdk_screen_get_monitor_geometry;

    /// Gets the height in millimeters of the specified monitor.
    extern fn gdk_screen_get_monitor_height_mm(p_screen: *Screen, p_monitor_num: c_int) c_int;
    pub const getMonitorHeightMm = gdk_screen_get_monitor_height_mm;

    /// Returns the output name of the specified monitor.
    /// Usually something like VGA, DVI, or TV, not the actual
    /// product name of the display device.
    extern fn gdk_screen_get_monitor_plug_name(p_screen: *Screen, p_monitor_num: c_int) ?[*:0]u8;
    pub const getMonitorPlugName = gdk_screen_get_monitor_plug_name;

    /// Returns the internal scale factor that maps from monitor coordinates
    /// to the actual device pixels. On traditional systems this is 1, but
    /// on very high density outputs this can be a higher value (often 2).
    ///
    /// This can be used if you want to create pixel based data for a
    /// particular monitor, but most of the time you’re drawing to a window
    /// where it is better to use `gdk.Window.getScaleFactor` instead.
    extern fn gdk_screen_get_monitor_scale_factor(p_screen: *Screen, p_monitor_num: c_int) c_int;
    pub const getMonitorScaleFactor = gdk_screen_get_monitor_scale_factor;

    /// Gets the width in millimeters of the specified monitor, if available.
    extern fn gdk_screen_get_monitor_width_mm(p_screen: *Screen, p_monitor_num: c_int) c_int;
    pub const getMonitorWidthMm = gdk_screen_get_monitor_width_mm;

    /// Retrieves the `gdk.Rectangle` representing the size and position of
    /// the “work area” on a monitor within the entire screen area. The returned
    /// geometry is in ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    ///
    /// The work area should be considered when positioning menus and
    /// similar popups, to avoid placing them below panels, docks or other
    /// desktop components.
    ///
    /// Note that not all backends may have a concept of workarea. This
    /// function will return the monitor geometry if a workarea is not
    /// available, or does not apply.
    ///
    /// Monitor numbers start at 0. To obtain the number of monitors of
    /// `screen`, use `gdk.Screen.getNMonitors`.
    extern fn gdk_screen_get_monitor_workarea(p_screen: *Screen, p_monitor_num: c_int, p_dest: ?*gdk.Rectangle) void;
    pub const getMonitorWorkarea = gdk_screen_get_monitor_workarea;

    /// Returns the number of monitors which `screen` consists of.
    extern fn gdk_screen_get_n_monitors(p_screen: *Screen) c_int;
    pub const getNMonitors = gdk_screen_get_n_monitors;

    /// Gets the index of `screen` among the screens in the display
    /// to which it belongs. (See `gdk.Screen.getDisplay`)
    extern fn gdk_screen_get_number(p_screen: *Screen) c_int;
    pub const getNumber = gdk_screen_get_number;

    /// Gets the primary monitor for `screen`.  The primary monitor
    /// is considered the monitor where the “main desktop” lives.
    /// While normal application windows typically allow the window
    /// manager to place the windows, specialized desktop applications
    /// such as panels should place themselves on the primary monitor.
    ///
    /// If no primary monitor is configured by the user, the return value
    /// will be 0, defaulting to the first monitor.
    extern fn gdk_screen_get_primary_monitor(p_screen: *Screen) c_int;
    pub const getPrimaryMonitor = gdk_screen_get_primary_monitor;

    /// Gets the resolution for font handling on the screen; see
    /// `gdk.Screen.setResolution` for full details.
    extern fn gdk_screen_get_resolution(p_screen: *Screen) f64;
    pub const getResolution = gdk_screen_get_resolution;

    /// Gets a visual to use for creating windows with an alpha channel.
    /// The windowing system on which GTK+ is running
    /// may not support this capability, in which case `NULL` will
    /// be returned. Even if a non-`NULL` value is returned, its
    /// possible that the window’s alpha channel won’t be honored
    /// when displaying the window on the screen: in particular, for
    /// X an appropriate windowing manager and compositing manager
    /// must be running to provide appropriate display.
    ///
    /// This functionality is not implemented in the Windows backend.
    ///
    /// For setting an overall opacity for a top-level window, see
    /// `gdk.Window.setOpacity`.
    extern fn gdk_screen_get_rgba_visual(p_screen: *Screen) ?*gdk.Visual;
    pub const getRgbaVisual = gdk_screen_get_rgba_visual;

    /// Gets the root window of `screen`.
    extern fn gdk_screen_get_root_window(p_screen: *Screen) *gdk.Window;
    pub const getRootWindow = gdk_screen_get_root_window;

    /// Retrieves a desktop-wide setting such as double-click time
    /// for the `gdk.Screen` `screen`.
    ///
    /// FIXME needs a list of valid settings here, or a link to
    /// more information.
    extern fn gdk_screen_get_setting(p_screen: *Screen, p_name: [*:0]const u8, p_value: *gobject.Value) c_int;
    pub const getSetting = gdk_screen_get_setting;

    /// Get the system’s default visual for `screen`.
    /// This is the visual for the root window of the display.
    /// The return value should not be freed.
    extern fn gdk_screen_get_system_visual(p_screen: *Screen) *gdk.Visual;
    pub const getSystemVisual = gdk_screen_get_system_visual;

    /// Obtains a list of all toplevel windows known to GDK on the screen `screen`.
    /// A toplevel window is a child of the root window (see
    /// `gdk.getDefaultRootWindow`).
    ///
    /// The returned list should be freed with `glib.List.free`, but
    /// its elements need not be freed.
    extern fn gdk_screen_get_toplevel_windows(p_screen: *Screen) *glib.List;
    pub const getToplevelWindows = gdk_screen_get_toplevel_windows;

    /// Gets the width of `screen` in pixels. The returned size is in
    /// ”application pixels”, not in ”device pixels” (see
    /// `gdk.Screen.getMonitorScaleFactor`).
    extern fn gdk_screen_get_width(p_screen: *Screen) c_int;
    pub const getWidth = gdk_screen_get_width;

    /// Gets the width of `screen` in millimeters.
    ///
    /// Note that this value is somewhat ill-defined when the screen
    /// has multiple monitors of different resolution. It is recommended
    /// to use the monitor dimensions instead.
    extern fn gdk_screen_get_width_mm(p_screen: *Screen) c_int;
    pub const getWidthMm = gdk_screen_get_width_mm;

    /// Returns a `glib.List` of `GdkWindows` representing the current
    /// window stack.
    ///
    /// On X11, this is done by inspecting the _NET_CLIENT_LIST_STACKING
    /// property on the root window, as described in the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec).
    /// If the window manager does not support the
    /// _NET_CLIENT_LIST_STACKING hint, this function returns `NULL`.
    ///
    /// On other platforms, this function may return `NULL`, depending on whether
    /// it is implementable on that platform.
    ///
    /// The returned list is newly allocated and owns references to the
    /// windows it contains, so it should be freed using `glib.List.free` and
    /// its windows unrefed using `gobject.Object.unref` when no longer needed.
    extern fn gdk_screen_get_window_stack(p_screen: *Screen) ?*glib.List;
    pub const getWindowStack = gdk_screen_get_window_stack;

    /// Returns whether windows with an RGBA visual can reasonably
    /// be expected to have their alpha channel drawn correctly on
    /// the screen.
    ///
    /// On X11 this function returns whether a compositing manager is
    /// compositing `screen`.
    extern fn gdk_screen_is_composited(p_screen: *Screen) c_int;
    pub const isComposited = gdk_screen_is_composited;

    /// Lists the available visuals for the specified `screen`.
    /// A visual describes a hardware image data format.
    /// For example, a visual might support 24-bit color, or 8-bit color,
    /// and might expect pixels to be in a certain format.
    ///
    /// Call `glib.List.free` on the return value when you’re finished with it.
    extern fn gdk_screen_list_visuals(p_screen: *Screen) *glib.List;
    pub const listVisuals = gdk_screen_list_visuals;

    /// Determines the name to pass to `gdk.Display.open` to get
    /// a `gdk.Display` with this screen as the default screen.
    extern fn gdk_screen_make_display_name(p_screen: *Screen) [*:0]u8;
    pub const makeDisplayName = gdk_screen_make_display_name;

    /// Sets the default font options for the screen. These
    /// options will be set on any `pango.Context`’s newly created
    /// with `gdk.pangoContextGetForScreen`. Changing the
    /// default set of font options does not affect contexts that
    /// have already been created.
    extern fn gdk_screen_set_font_options(p_screen: *Screen, p_options: ?*const cairo.FontOptions) void;
    pub const setFontOptions = gdk_screen_set_font_options;

    /// Sets the resolution for font handling on the screen. This is a
    /// scale factor between points specified in a `pango.FontDescription`
    /// and cairo units. The default value is 96, meaning that a 10 point
    /// font will be 13 units high. (10 * 96. / 72. = 13.3).
    extern fn gdk_screen_set_resolution(p_screen: *Screen, p_dpi: f64) void;
    pub const setResolution = gdk_screen_set_resolution;

    extern fn gdk_screen_get_type() usize;
    pub const getGObjectType = gdk_screen_get_type;

    extern fn g_object_ref(p_self: *gdk.Screen) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Screen) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Screen, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `gdk.Seat` object represents a collection of input devices
/// that belong to a user.
pub const Seat = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Seat;
    };
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `gdk.Display` of this seat.
        pub const display = struct {
            pub const name = "display";

            pub const Type = ?*gdk.Display;
        };
    };

    pub const signals = struct {
        /// The ::device-added signal is emitted when a new input
        /// device is related to this seat.
        pub const device_added = struct {
            pub const name = "device-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("device-added", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::device-removed signal is emitted when an
        /// input device is removed (e.g. unplugged).
        pub const device_removed = struct {
            pub const name = "device-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_device: *gdk.Device, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("device-removed", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::tool-added signal is emitted whenever a new tool
        /// is made known to the seat. The tool may later be assigned
        /// to a device (i.e. on proximity with a tablet). The device
        /// will emit the `gdk.Device.signals.tool`-changed signal accordingly.
        ///
        /// A same tool may be used by several devices.
        pub const tool_added = struct {
            pub const name = "tool-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("tool-added", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted whenever a tool is no longer known
        /// to this `seat`.
        pub const tool_removed = struct {
            pub const name = "tool-removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_tool: *gdk.DeviceTool, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Seat, p_instance))),
                    gobject.signalLookup("tool-removed", Seat.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the capabilities this `gdk.Seat` currently has.
    extern fn gdk_seat_get_capabilities(p_seat: *Seat) gdk.SeatCapabilities;
    pub const getCapabilities = gdk_seat_get_capabilities;

    /// Returns the `gdk.Display` this seat belongs to.
    extern fn gdk_seat_get_display(p_seat: *Seat) *gdk.Display;
    pub const getDisplay = gdk_seat_get_display;

    /// Returns the master device that routes keyboard events.
    extern fn gdk_seat_get_keyboard(p_seat: *Seat) ?*gdk.Device;
    pub const getKeyboard = gdk_seat_get_keyboard;

    /// Returns the master device that routes pointer events.
    extern fn gdk_seat_get_pointer(p_seat: *Seat) ?*gdk.Device;
    pub const getPointer = gdk_seat_get_pointer;

    /// Returns the slave devices that match the given capabilities.
    extern fn gdk_seat_get_slaves(p_seat: *Seat, p_capabilities: gdk.SeatCapabilities) *glib.List;
    pub const getSlaves = gdk_seat_get_slaves;

    /// Grabs the seat so that all events corresponding to the given `capabilities`
    /// are passed to this application until the seat is ungrabbed with `gdk.Seat.ungrab`,
    /// or the window becomes hidden. This overrides any previous grab on the
    /// seat by this client.
    ///
    /// As a rule of thumb, if a grab is desired over `GDK_SEAT_CAPABILITY_POINTER`,
    /// all other "pointing" capabilities (eg. `GDK_SEAT_CAPABILITY_TOUCH`) should
    /// be grabbed too, so the user is able to interact with all of those while
    /// the grab holds, you should thus use `GDK_SEAT_CAPABILITY_ALL_POINTING` most
    /// commonly.
    ///
    /// Grabs are used for operations which need complete control over the
    /// events corresponding to the given capabilities. For example in GTK+ this
    /// is used for Drag and Drop operations, popup menus and such.
    ///
    /// Note that if the event mask of a `gdk.Window` has selected both button press
    /// and button release events, or touch begin and touch end, then a press event
    /// will cause an automatic grab until the button is released, equivalent to a
    /// grab on the window with `owner_events` set to `TRUE`. This is done because most
    /// applications expect to receive paired press and release events.
    ///
    /// If you set up anything at the time you take the grab that needs to be
    /// cleaned up when the grab ends, you should handle the `gdk.EventGrabBroken`
    /// events that are emitted when the grab ends unvoluntarily.
    extern fn gdk_seat_grab(p_seat: *Seat, p_window: *gdk.Window, p_capabilities: gdk.SeatCapabilities, p_owner_events: c_int, p_cursor: ?*gdk.Cursor, p_event: ?*const gdk.Event, p_prepare_func: ?gdk.SeatGrabPrepareFunc, p_prepare_func_data: ?*anyopaque) gdk.GrabStatus;
    pub const grab = gdk_seat_grab;

    /// Releases a grab added through `gdk.Seat.grab`.
    extern fn gdk_seat_ungrab(p_seat: *Seat) void;
    pub const ungrab = gdk_seat_ungrab;

    extern fn gdk_seat_get_type() usize;
    pub const getGObjectType = gdk_seat_get_type;

    extern fn g_object_ref(p_self: *gdk.Seat) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Seat) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Seat, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.Visual` contains information about
/// a particular visual.
pub const Visual = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = opaque {
        pub const Instance = Visual;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Get the visual with the most available colors for the default
    /// GDK screen. The return value should not be freed.
    extern fn gdk_visual_get_best() *gdk.Visual;
    pub const getBest = gdk_visual_get_best;

    /// Get the best available depth for the default GDK screen.  “Best”
    /// means “largest,” i.e. 32 preferred over 24 preferred over 8 bits
    /// per pixel.
    extern fn gdk_visual_get_best_depth() c_int;
    pub const getBestDepth = gdk_visual_get_best_depth;

    /// Return the best available visual type for the default GDK screen.
    extern fn gdk_visual_get_best_type() gdk.VisualType;
    pub const getBestType = gdk_visual_get_best_type;

    /// Combines `gdk.Visual.getBestWithDepth` and
    /// `gdk.Visual.getBestWithType`.
    extern fn gdk_visual_get_best_with_both(p_depth: c_int, p_visual_type: gdk.VisualType) ?*gdk.Visual;
    pub const getBestWithBoth = gdk_visual_get_best_with_both;

    /// Get the best visual with depth `depth` for the default GDK screen.
    /// Color visuals and visuals with mutable colormaps are preferred
    /// over grayscale or fixed-colormap visuals. The return value should
    /// not be freed. `NULL` may be returned if no visual supports `depth`.
    extern fn gdk_visual_get_best_with_depth(p_depth: c_int) *gdk.Visual;
    pub const getBestWithDepth = gdk_visual_get_best_with_depth;

    /// Get the best visual of the given `visual_type` for the default GDK screen.
    /// Visuals with higher color depths are considered better. The return value
    /// should not be freed. `NULL` may be returned if no visual has type
    /// `visual_type`.
    extern fn gdk_visual_get_best_with_type(p_visual_type: gdk.VisualType) *gdk.Visual;
    pub const getBestWithType = gdk_visual_get_best_with_type;

    /// Get the system’s default visual for the default GDK screen.
    /// This is the visual for the root window of the display.
    /// The return value should not be freed.
    extern fn gdk_visual_get_system() *gdk.Visual;
    pub const getSystem = gdk_visual_get_system;

    /// Returns the number of significant bits per red, green and blue value.
    ///
    /// Not all GDK backend provide a meaningful value for this function.
    extern fn gdk_visual_get_bits_per_rgb(p_visual: *Visual) c_int;
    pub const getBitsPerRgb = gdk_visual_get_bits_per_rgb;

    /// Obtains values that are needed to calculate blue pixel values in TrueColor
    /// and DirectColor. The “mask” is the significant bits within the pixel.
    /// The “shift” is the number of bits left we must shift a primary for it
    /// to be in position (according to the "mask"). Finally, "precision" refers
    /// to how much precision the pixel value contains for a particular primary.
    extern fn gdk_visual_get_blue_pixel_details(p_visual: *Visual, p_mask: ?*u32, p_shift: ?*c_int, p_precision: ?*c_int) void;
    pub const getBluePixelDetails = gdk_visual_get_blue_pixel_details;

    /// Returns the byte order of this visual.
    ///
    /// The information returned by this function is only relevant
    /// when working with XImages, and not all backends return
    /// meaningful information for this.
    extern fn gdk_visual_get_byte_order(p_visual: *Visual) gdk.ByteOrder;
    pub const getByteOrder = gdk_visual_get_byte_order;

    /// Returns the size of a colormap for this visual.
    ///
    /// You have to use platform-specific APIs to manipulate colormaps.
    extern fn gdk_visual_get_colormap_size(p_visual: *Visual) c_int;
    pub const getColormapSize = gdk_visual_get_colormap_size;

    /// Returns the bit depth of this visual.
    extern fn gdk_visual_get_depth(p_visual: *Visual) c_int;
    pub const getDepth = gdk_visual_get_depth;

    /// Obtains values that are needed to calculate green pixel values in TrueColor
    /// and DirectColor. The “mask” is the significant bits within the pixel.
    /// The “shift” is the number of bits left we must shift a primary for it
    /// to be in position (according to the "mask"). Finally, "precision" refers
    /// to how much precision the pixel value contains for a particular primary.
    extern fn gdk_visual_get_green_pixel_details(p_visual: *Visual, p_mask: ?*u32, p_shift: ?*c_int, p_precision: ?*c_int) void;
    pub const getGreenPixelDetails = gdk_visual_get_green_pixel_details;

    /// Obtains values that are needed to calculate red pixel values in TrueColor
    /// and DirectColor. The “mask” is the significant bits within the pixel.
    /// The “shift” is the number of bits left we must shift a primary for it
    /// to be in position (according to the "mask"). Finally, "precision" refers
    /// to how much precision the pixel value contains for a particular primary.
    extern fn gdk_visual_get_red_pixel_details(p_visual: *Visual, p_mask: ?*u32, p_shift: ?*c_int, p_precision: ?*c_int) void;
    pub const getRedPixelDetails = gdk_visual_get_red_pixel_details;

    /// Gets the screen to which this visual belongs
    extern fn gdk_visual_get_screen(p_visual: *Visual) *gdk.Screen;
    pub const getScreen = gdk_visual_get_screen;

    /// Returns the type of visual this is (PseudoColor, TrueColor, etc).
    extern fn gdk_visual_get_visual_type(p_visual: *Visual) gdk.VisualType;
    pub const getVisualType = gdk_visual_get_visual_type;

    extern fn gdk_visual_get_type() usize;
    pub const getGObjectType = gdk_visual_get_type;

    extern fn g_object_ref(p_self: *gdk.Visual) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Visual) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Visual, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Window = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gdk.WindowClass;
    pub const virtual_methods = struct {
        pub const create_surface = struct {
            pub fn call(p_class: anytype, p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) *cairo.Surface {
                return gobject.ext.as(Window.Class, p_class).f_create_surface.?(gobject.ext.as(Window, p_window), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) callconv(.c) *cairo.Surface) void {
                gobject.ext.as(Window.Class, p_class).f_create_surface = @ptrCast(p_implementation);
            }
        };

        pub const from_embedder = struct {
            pub fn call(p_class: anytype, p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_embedder_x: f64, p_embedder_y: f64, p_offscreen_x: *f64, p_offscreen_y: *f64) void {
                return gobject.ext.as(Window.Class, p_class).f_from_embedder.?(gobject.ext.as(Window, p_window), p_embedder_x, p_embedder_y, p_offscreen_x, p_offscreen_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_embedder_x: f64, p_embedder_y: f64, p_offscreen_x: *f64, p_offscreen_y: *f64) callconv(.c) void) void {
                gobject.ext.as(Window.Class, p_class).f_from_embedder = @ptrCast(p_implementation);
            }
        };

        pub const pick_embedded_child = struct {
            pub fn call(p_class: anytype, p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: f64, p_y: f64) *gdk.Window {
                return gobject.ext.as(Window.Class, p_class).f_pick_embedded_child.?(gobject.ext.as(Window, p_window), p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: f64, p_y: f64) callconv(.c) *gdk.Window) void {
                gobject.ext.as(Window.Class, p_class).f_pick_embedded_child = @ptrCast(p_implementation);
            }
        };

        pub const to_embedder = struct {
            pub fn call(p_class: anytype, p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offscreen_x: f64, p_offscreen_y: f64, p_embedder_x: *f64, p_embedder_y: *f64) void {
                return gobject.ext.as(Window.Class, p_class).f_to_embedder.?(gobject.ext.as(Window, p_window), p_offscreen_x, p_offscreen_y, p_embedder_x, p_embedder_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_window: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offscreen_x: f64, p_offscreen_y: f64, p_embedder_x: *f64, p_embedder_y: *f64) callconv(.c) void) void {
                gobject.ext.as(Window.Class, p_class).f_to_embedder = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The mouse pointer for a `gdk.Window`. See `gdk.Window.setCursor` and
        /// `gdk.Window.getCursor` for details.
        pub const cursor = struct {
            pub const name = "cursor";

            pub const Type = ?*gdk.Cursor;
        };
    };

    pub const signals = struct {
        /// The ::create-surface signal is emitted when an offscreen window
        /// needs its surface (re)created, which happens either when the
        /// window is first drawn to, or when the window is being
        /// resized. The first signal handler that returns a non-`NULL`
        /// surface will stop any further signal emission, and its surface
        /// will be used.
        ///
        /// Note that it is not possible to access the window's previous
        /// surface from within any callback of this signal. Calling
        /// `gdk.offscreenWindowGetSurface` will lead to a crash.
        pub const create_surface = struct {
            pub const name = "create-surface";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_width: c_int, p_height: c_int, P_Data) callconv(.c) *cairo.Surface, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("create-surface", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::from-embedder signal is emitted to translate coordinates
        /// in the embedder of an offscreen window to the offscreen window.
        ///
        /// See also `gdk.Window.signals.to`-embedder.
        pub const from_embedder = struct {
            pub const name = "from-embedder";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_embedder_x: f64, p_embedder_y: f64, p_offscreen_x: *f64, p_offscreen_y: *f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("from-embedder", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the position of `window` is finalized after being moved to a
        /// destination rectangle.
        ///
        /// `window` might be flipped over the destination rectangle in order to keep
        /// it on-screen, in which case `flipped_x` and `flipped_y` will be set to `TRUE`
        /// accordingly.
        ///
        /// `flipped_rect` is the ideal position of `window` after any possible
        /// flipping, but before any possible sliding. `final_rect` is `flipped_rect`,
        /// but possibly translated in the case that flipping is still ineffective in
        /// keeping `window` on-screen.
        pub const moved_to_rect = struct {
            pub const name = "moved-to-rect";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_flipped_rect: ?*anyopaque, p_final_rect: ?*anyopaque, p_flipped_x: c_int, p_flipped_y: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("moved-to-rect", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::pick-embedded-child signal is emitted to find an embedded
        /// child at the given position.
        pub const pick_embedded_child = struct {
            pub const name = "pick-embedded-child";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_x: f64, p_y: f64, P_Data) callconv(.c) ?*gdk.Window, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("pick-embedded-child", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The ::to-embedder signal is emitted to translate coordinates
        /// in an offscreen window to its embedder.
        ///
        /// See also `gdk.Window.signals.from`-embedder.
        pub const to_embedder = struct {
            pub const name = "to-embedder";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_offscreen_x: f64, p_offscreen_y: f64, p_embedder_x: *f64, p_embedder_y: *f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("to-embedder", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Obtains the window underneath the mouse pointer, returning the
    /// location of that window in `win_x`, `win_y`. Returns `NULL` if the
    /// window under the mouse pointer is not known to GDK (if the window
    /// belongs to another application and a `gdk.Window` hasn’t been created
    /// for it with `gdk_window_foreign_new`)
    ///
    /// NOTE: For multihead-aware widgets or applications use
    /// `gdk.Display.getWindowAtPointer` instead.
    extern fn gdk_window_at_pointer(p_win_x: ?*c_int, p_win_y: ?*c_int) *gdk.Window;
    pub const atPointer = gdk_window_at_pointer;

    /// Constrains a desired width and height according to a
    /// set of geometry hints (such as minimum and maximum size).
    extern fn gdk_window_constrain_size(p_geometry: *gdk.Geometry, p_flags: gdk.WindowHints, p_width: c_int, p_height: c_int, p_new_width: *c_int, p_new_height: *c_int) void;
    pub const constrainSize = gdk_window_constrain_size;

    /// Calls `gdk.Window.processUpdates` for all windows (see `gdk.Window`)
    /// in the application.
    extern fn gdk_window_process_all_updates() void;
    pub const processAllUpdates = gdk_window_process_all_updates;

    /// With update debugging enabled, calls to
    /// `gdk.Window.invalidateRegion` clear the invalidated region of the
    /// screen to a noticeable color, and GDK pauses for a short time
    /// before sending exposes to windows during
    /// `gdk.Window.processUpdates`.  The net effect is that you can see
    /// the invalid region for each window and watch redraws as they
    /// occur. This allows you to diagnose inefficiencies in your application.
    ///
    /// In essence, because the GDK rendering model prevents all flicker,
    /// if you are redrawing the same region 400 times you may never
    /// notice, aside from noticing a speed problem. Enabling update
    /// debugging causes GTK to flicker slowly and noticeably, so you can
    /// see exactly what’s being redrawn when, in what order.
    ///
    /// The --gtk-debug=updates command line option passed to GTK+ programs
    /// enables this debug option at application startup time. That's
    /// usually more useful than calling `gdk.Window.setDebugUpdates`
    /// yourself, though you might want to use this function to enable
    /// updates sometime after application startup time.
    extern fn gdk_window_set_debug_updates(p_setting: c_int) void;
    pub const setDebugUpdates = gdk_window_set_debug_updates;

    /// Creates a new `gdk.Window` using the attributes from
    /// `attributes`. See `gdk.WindowAttr` and `gdk.WindowAttributesType` for
    /// more details.  Note: to use this on displays other than the default
    /// display, `parent` must be specified.
    extern fn gdk_window_new(p_parent: ?*gdk.Window, p_attributes: *gdk.WindowAttr, p_attributes_mask: c_int) *gdk.Window;
    pub const new = gdk_window_new;

    /// Adds an event filter to `window`, allowing you to intercept events
    /// before they reach GDK. This is a low-level operation and makes it
    /// easy to break GDK and/or GTK+, so you have to know what you're
    /// doing. Pass `NULL` for `window` to get all events for all windows,
    /// instead of events for a specific window.
    ///
    /// If you are interested in X GenericEvents, bear in mind that
    /// `XGetEventData` has been already called on the event, and
    /// `XFreeEventData` must not be called within `function`.
    extern fn gdk_window_add_filter(p_window: ?*Window, p_function: gdk.FilterFunc, p_data: ?*anyopaque) void;
    pub const addFilter = gdk_window_add_filter;

    /// Emits a short beep associated to `window` in the appropriate
    /// display, if supported. Otherwise, emits a short beep on
    /// the display just as `gdk.Display.beep`.
    extern fn gdk_window_beep(p_window: *Window) void;
    pub const beep = gdk_window_beep;

    /// Indicates that you are beginning the process of redrawing `region`
    /// on `window`, and provides you with a `gdk.DrawingContext`.
    ///
    /// If `window` is a top level `gdk.Window`, backed by a native window
    /// implementation, a backing store (offscreen buffer) large enough to
    /// contain `region` will be created. The backing store will be initialized
    /// with the background color or background surface for `window`. Then, all
    /// drawing operations performed on `window` will be diverted to the
    /// backing store. When you call `gdk_window_end_frame`, the contents of
    /// the backing store will be copied to `window`, making it visible
    /// on screen. Only the part of `window` contained in `region` will be
    /// modified; that is, drawing operations are clipped to `region`.
    ///
    /// The net result of all this is to remove flicker, because the user
    /// sees the finished product appear all at once when you call
    /// `gdk.Window.endDrawFrame`. If you draw to `window` directly without
    /// calling `gdk.Window.beginDrawFrame`, the user may see flicker
    /// as individual drawing operations are performed in sequence.
    ///
    /// When using GTK+, the widget system automatically places calls to
    /// `gdk.Window.beginDrawFrame` and `gdk.Window.endDrawFrame` around
    /// emissions of the `GtkWidget::draw` signal. That is, if you’re
    /// drawing the contents of the widget yourself, you can assume that the
    /// widget has a cleared background, is already set as the clip region,
    /// and already has a backing store. Therefore in most cases, application
    /// code in GTK does not need to call `gdk.Window.beginDrawFrame`
    /// explicitly.
    extern fn gdk_window_begin_draw_frame(p_window: *Window, p_region: *const cairo.Region) *gdk.DrawingContext;
    pub const beginDrawFrame = gdk_window_begin_draw_frame;

    /// Begins a window move operation (for a toplevel window).
    ///
    /// This function assumes that the drag is controlled by the
    /// client pointer device, use `gdk.Window.beginMoveDragForDevice`
    /// to begin a drag with a different device.
    extern fn gdk_window_begin_move_drag(p_window: *Window, p_button: c_int, p_root_x: c_int, p_root_y: c_int, p_timestamp: u32) void;
    pub const beginMoveDrag = gdk_window_begin_move_drag;

    /// Begins a window move operation (for a toplevel window).
    /// You might use this function to implement a “window move grip,” for
    /// example. The function works best with window managers that support the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec)
    /// but has a fallback implementation for other window managers.
    extern fn gdk_window_begin_move_drag_for_device(p_window: *Window, p_device: *gdk.Device, p_button: c_int, p_root_x: c_int, p_root_y: c_int, p_timestamp: u32) void;
    pub const beginMoveDragForDevice = gdk_window_begin_move_drag_for_device;

    /// A convenience wrapper around `gdk.Window.beginPaintRegion` which
    /// creates a rectangular region for you. See
    /// `gdk.Window.beginPaintRegion` for details.
    extern fn gdk_window_begin_paint_rect(p_window: *Window, p_rectangle: *const gdk.Rectangle) void;
    pub const beginPaintRect = gdk_window_begin_paint_rect;

    /// Indicates that you are beginning the process of redrawing `region`.
    /// A backing store (offscreen buffer) large enough to contain `region`
    /// will be created. The backing store will be initialized with the
    /// background color or background surface for `window`. Then, all
    /// drawing operations performed on `window` will be diverted to the
    /// backing store.  When you call `gdk.Window.endPaint`, the backing
    /// store will be copied to `window`, making it visible onscreen. Only
    /// the part of `window` contained in `region` will be modified; that is,
    /// drawing operations are clipped to `region`.
    ///
    /// The net result of all this is to remove flicker, because the user
    /// sees the finished product appear all at once when you call
    /// `gdk.Window.endPaint`. If you draw to `window` directly without
    /// calling `gdk.Window.beginPaintRegion`, the user may see flicker
    /// as individual drawing operations are performed in sequence.  The
    /// clipping and background-initializing features of
    /// `gdk.Window.beginPaintRegion` are conveniences for the
    /// programmer, so you can avoid doing that work yourself.
    ///
    /// When using GTK+, the widget system automatically places calls to
    /// `gdk.Window.beginPaintRegion` and `gdk.Window.endPaint` around
    /// emissions of the expose_event signal. That is, if you’re writing an
    /// expose event handler, you can assume that the exposed area in
    /// `gdk.EventExpose` has already been cleared to the window background,
    /// is already set as the clip region, and already has a backing store.
    /// Therefore in most cases, application code need not call
    /// `gdk.Window.beginPaintRegion`. (You can disable the automatic
    /// calls around expose events on a widget-by-widget basis by calling
    /// `gtk_widget_set_double_buffered`.)
    ///
    /// If you call this function multiple times before calling the
    /// matching `gdk.Window.endPaint`, the backing stores are pushed onto
    /// a stack. `gdk.Window.endPaint` copies the topmost backing store
    /// onscreen, subtracts the topmost region from all other regions in
    /// the stack, and pops the stack. All drawing operations affect only
    /// the topmost backing store in the stack. One matching call to
    /// `gdk.Window.endPaint` is required for each call to
    /// `gdk.Window.beginPaintRegion`.
    extern fn gdk_window_begin_paint_region(p_window: *Window, p_region: *const cairo.Region) void;
    pub const beginPaintRegion = gdk_window_begin_paint_region;

    /// Begins a window resize operation (for a toplevel window).
    ///
    /// This function assumes that the drag is controlled by the
    /// client pointer device, use `gdk.Window.beginResizeDragForDevice`
    /// to begin a drag with a different device.
    extern fn gdk_window_begin_resize_drag(p_window: *Window, p_edge: gdk.WindowEdge, p_button: c_int, p_root_x: c_int, p_root_y: c_int, p_timestamp: u32) void;
    pub const beginResizeDrag = gdk_window_begin_resize_drag;

    /// Begins a window resize operation (for a toplevel window).
    /// You might use this function to implement a “window resize grip,” for
    /// example; in fact `GtkStatusbar` uses it. The function works best
    /// with window managers that support the
    /// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec)
    /// but has a fallback implementation for other window managers.
    extern fn gdk_window_begin_resize_drag_for_device(p_window: *Window, p_edge: gdk.WindowEdge, p_device: *gdk.Device, p_button: c_int, p_root_x: c_int, p_root_y: c_int, p_timestamp: u32) void;
    pub const beginResizeDragForDevice = gdk_window_begin_resize_drag_for_device;

    /// Does nothing, present only for compatiblity.
    extern fn gdk_window_configure_finished(p_window: *Window) void;
    pub const configureFinished = gdk_window_configure_finished;

    /// Transforms window coordinates from a parent window to a child
    /// window, where the parent window is the normal parent as returned by
    /// `gdk.Window.getParent` for normal windows, and the window's
    /// embedder as returned by `gdk.offscreenWindowGetEmbedder` for
    /// offscreen windows.
    ///
    /// For normal windows, calling this function is equivalent to subtracting
    /// the return values of `gdk.Window.getPosition` from the parent coordinates.
    /// For offscreen windows however (which can be arbitrarily transformed),
    /// this function calls the GdkWindow::from-embedder: signal to translate
    /// the coordinates.
    ///
    /// You should always use this function when writing generic code that
    /// walks down a window hierarchy.
    ///
    /// See also: `gdk.Window.coordsToParent`
    extern fn gdk_window_coords_from_parent(p_window: *Window, p_parent_x: f64, p_parent_y: f64, p_x: ?*f64, p_y: ?*f64) void;
    pub const coordsFromParent = gdk_window_coords_from_parent;

    /// Transforms window coordinates from a child window to its parent
    /// window, where the parent window is the normal parent as returned by
    /// `gdk.Window.getParent` for normal windows, and the window's
    /// embedder as returned by `gdk.offscreenWindowGetEmbedder` for
    /// offscreen windows.
    ///
    /// For normal windows, calling this function is equivalent to adding
    /// the return values of `gdk.Window.getPosition` to the child coordinates.
    /// For offscreen windows however (which can be arbitrarily transformed),
    /// this function calls the GdkWindow::to-embedder: signal to translate
    /// the coordinates.
    ///
    /// You should always use this function when writing generic code that
    /// walks up a window hierarchy.
    ///
    /// See also: `gdk.Window.coordsFromParent`
    extern fn gdk_window_coords_to_parent(p_window: *Window, p_x: f64, p_y: f64, p_parent_x: ?*f64, p_parent_y: ?*f64) void;
    pub const coordsToParent = gdk_window_coords_to_parent;

    /// Creates a new `gdk.GLContext` matching the
    /// framebuffer format to the visual of the `gdk.Window`. The context
    /// is disconnected from any particular window or surface.
    ///
    /// If the creation of the `gdk.GLContext` failed, `error` will be set.
    ///
    /// Before using the returned `gdk.GLContext`, you will need to
    /// call `gdk.GLContext.makeCurrent` or `gdk.GLContext.realize`.
    extern fn gdk_window_create_gl_context(p_window: *Window, p_error: ?*?*glib.Error) ?*gdk.GLContext;
    pub const createGlContext = gdk_window_create_gl_context;

    /// Create a new image surface that is efficient to draw on the
    /// given `window`.
    ///
    /// Initially the surface contents are all 0 (transparent if contents
    /// have transparency, black otherwise.)
    ///
    /// The `width` and `height` of the new surface are not affected by
    /// the scaling factor of the `window`, or by the `scale` argument; they
    /// are the size of the surface in device pixels. If you wish to create
    /// an image surface capable of holding the contents of `window` you can
    /// use:
    ///
    /// ```
    ///   int scale = gdk_window_get_scale_factor (window);
    ///   int width = gdk_window_get_width (window) * scale;
    ///   int height = gdk_window_get_height (window) * scale;
    ///
    ///   // format is set elsewhere
    ///   cairo_surface_t *surface =
    ///     gdk_window_create_similar_image_surface (window,
    ///                                              format,
    ///                                              width, height,
    ///                                              scale);
    /// ```
    ///
    /// Note that unlike `cairo_surface_create_similar_image`, the new
    /// surface's device scale is set to `scale`, or to the scale factor of
    /// `window` if `scale` is 0.
    extern fn gdk_window_create_similar_image_surface(p_window: ?*Window, p_format: cairo.Format, p_width: c_int, p_height: c_int, p_scale: c_int) *cairo.Surface;
    pub const createSimilarImageSurface = gdk_window_create_similar_image_surface;

    /// Create a new surface that is as compatible as possible with the
    /// given `window`. For example the new surface will have the same
    /// fallback resolution and font options as `window`. Generally, the new
    /// surface will also use the same backend as `window`, unless that is
    /// not possible for some reason. The type of the returned surface may
    /// be examined with `cairo_surface_get_type`.
    ///
    /// Initially the surface contents are all 0 (transparent if contents
    /// have transparency, black otherwise.)
    extern fn gdk_window_create_similar_surface(p_window: *Window, p_content: cairo.Content, p_width: c_int, p_height: c_int) *cairo.Surface;
    pub const createSimilarSurface = gdk_window_create_similar_surface;

    /// Attempt to deiconify (unminimize) `window`. On X11 the window manager may
    /// choose to ignore the request to deiconify. When using GTK+,
    /// use `gtk_window_deiconify` instead of the `gdk.Window` variant. Or better yet,
    /// you probably want to use `gtk_window_present_with_time`, which raises the window, focuses it,
    /// unminimizes it, and puts it on the current desktop.
    extern fn gdk_window_deiconify(p_window: *Window) void;
    pub const deiconify = gdk_window_deiconify;

    /// Destroys the window system resources associated with `window` and decrements `window`'s
    /// reference count. The window system resources for all children of `window` are also
    /// destroyed, but the children’s reference counts are not decremented.
    ///
    /// Note that a window will not be destroyed automatically when its reference count
    /// reaches zero. You must call this function yourself before that happens.
    extern fn gdk_window_destroy(p_window: *Window) void;
    pub const destroy = gdk_window_destroy;

    extern fn gdk_window_destroy_notify(p_window: *Window) void;
    pub const destroyNotify = gdk_window_destroy_notify;

    /// Does nothing, present only for compatiblity.
    extern fn gdk_window_enable_synchronized_configure(p_window: *Window) void;
    pub const enableSynchronizedConfigure = gdk_window_enable_synchronized_configure;

    /// Indicates that the drawing of the contents of `window` started with
    /// `gdk_window_begin_frame` has been completed.
    ///
    /// This function will take care of destroying the `gdk.DrawingContext`.
    ///
    /// It is an error to call this function without a matching
    /// `gdk_window_begin_frame` first.
    extern fn gdk_window_end_draw_frame(p_window: *Window, p_context: *gdk.DrawingContext) void;
    pub const endDrawFrame = gdk_window_end_draw_frame;

    /// Indicates that the backing store created by the most recent call
    /// to `gdk.Window.beginPaintRegion` should be copied onscreen and
    /// deleted, leaving the next-most-recent backing store or no backing
    /// store at all as the active paint region. See
    /// `gdk.Window.beginPaintRegion` for full details.
    ///
    /// It is an error to call this function without a matching
    /// `gdk.Window.beginPaintRegion` first.
    extern fn gdk_window_end_paint(p_window: *Window) void;
    pub const endPaint = gdk_window_end_paint;

    /// Tries to ensure that there is a window-system native window for this
    /// GdkWindow. This may fail in some situations, returning `FALSE`.
    ///
    /// Offscreen window and children of them can never have native windows.
    ///
    /// Some backends may not support native child windows.
    extern fn gdk_window_ensure_native(p_window: *Window) c_int;
    pub const ensureNative = gdk_window_ensure_native;

    /// This function does nothing.
    extern fn gdk_window_flush(p_window: *Window) void;
    pub const flush = gdk_window_flush;

    /// Sets keyboard focus to `window`. In most cases, `gtk_window_present_with_time`
    /// should be used on a `GtkWindow`, rather than calling this function.
    extern fn gdk_window_focus(p_window: *Window, p_timestamp: u32) void;
    pub const focus = gdk_window_focus;

    /// Temporarily freezes a window and all its descendants such that it won't
    /// receive expose events.  The window will begin receiving expose events
    /// again when `gdk.Window.thawToplevelUpdatesLibgtkOnly` is called. If
    /// `gdk.Window.freezeToplevelUpdatesLibgtkOnly`
    /// has been called more than once,
    /// `gdk.Window.thawToplevelUpdatesLibgtkOnly` must be called
    /// an equal number of times to begin processing exposes.
    ///
    /// This function is not part of the GDK public API and is only
    /// for use by GTK+.
    extern fn gdk_window_freeze_toplevel_updates_libgtk_only(p_window: *Window) void;
    pub const freezeToplevelUpdatesLibgtkOnly = gdk_window_freeze_toplevel_updates_libgtk_only;

    /// Temporarily freezes a window such that it won’t receive expose
    /// events.  The window will begin receiving expose events again when
    /// `gdk.Window.thawUpdates` is called. If `gdk.Window.freezeUpdates`
    /// has been called more than once, `gdk.Window.thawUpdates` must be called
    /// an equal number of times to begin processing exposes.
    extern fn gdk_window_freeze_updates(p_window: *Window) void;
    pub const freezeUpdates = gdk_window_freeze_updates;

    /// Moves the window into fullscreen mode. This means the
    /// window covers the entire screen and is above any panels
    /// or task bars.
    ///
    /// If the window was already fullscreen, then this function does nothing.
    ///
    /// On X11, asks the window manager to put `window` in a fullscreen
    /// state, if the window manager supports this operation. Not all
    /// window managers support this, and some deliberately ignore it or
    /// don’t have a concept of “fullscreen”; so you can’t rely on the
    /// fullscreenification actually happening. But it will happen with
    /// most standard window managers, and GDK makes a best effort to get
    /// it to happen.
    extern fn gdk_window_fullscreen(p_window: *Window) void;
    pub const fullscreen = gdk_window_fullscreen;

    /// Moves the window into fullscreen mode on the given monitor. This means
    /// the window covers the entire screen and is above any panels or task bars.
    ///
    /// If the window was already fullscreen, then this function does nothing.
    extern fn gdk_window_fullscreen_on_monitor(p_window: *Window, p_monitor: c_int) void;
    pub const fullscreenOnMonitor = gdk_window_fullscreen_on_monitor;

    /// This function informs GDK that the geometry of an embedded
    /// offscreen window has changed. This is necessary for GDK to keep
    /// track of which offscreen window the pointer is in.
    extern fn gdk_window_geometry_changed(p_window: *Window) void;
    pub const geometryChanged = gdk_window_geometry_changed;

    /// Determines whether or not the desktop environment shuld be hinted that
    /// the window does not want to receive input focus.
    extern fn gdk_window_get_accept_focus(p_window: *Window) c_int;
    pub const getAcceptFocus = gdk_window_get_accept_focus;

    /// Gets the pattern used to clear the background on `window`.
    extern fn gdk_window_get_background_pattern(p_window: *Window) ?*cairo.Pattern;
    pub const getBackgroundPattern = gdk_window_get_background_pattern;

    /// Gets the list of children of `window` known to GDK.
    /// This function only returns children created via GDK,
    /// so for example it’s useless when used with the root window;
    /// it only returns windows an application created itself.
    ///
    /// The returned list must be freed, but the elements in the
    /// list need not be.
    extern fn gdk_window_get_children(p_window: *Window) *glib.List;
    pub const getChildren = gdk_window_get_children;

    /// Gets the list of children of `window` known to GDK with a
    /// particular `user_data` set on it.
    ///
    /// The returned list must be freed, but the elements in the
    /// list need not be.
    ///
    /// The list is returned in (relative) stacking order, i.e. the
    /// lowest window is first.
    extern fn gdk_window_get_children_with_user_data(p_window: *Window, p_user_data: ?*anyopaque) *glib.List;
    pub const getChildrenWithUserData = gdk_window_get_children_with_user_data;

    /// Computes the region of a window that potentially can be written
    /// to by drawing primitives. This region may not take into account
    /// other factors such as if the window is obscured by other windows,
    /// but no area outside of this region will be affected by drawing
    /// primitives.
    extern fn gdk_window_get_clip_region(p_window: *Window) *cairo.Region;
    pub const getClipRegion = gdk_window_get_clip_region;

    /// Determines whether `window` is composited.
    ///
    /// See `gdk.Window.setComposited`.
    extern fn gdk_window_get_composited(p_window: *Window) c_int;
    pub const getComposited = gdk_window_get_composited;

    /// Retrieves a `gdk.Cursor` pointer for the cursor currently set on the
    /// specified `gdk.Window`, or `NULL`.  If the return value is `NULL` then
    /// there is no custom cursor set on the specified window, and it is
    /// using the cursor for its parent window.
    extern fn gdk_window_get_cursor(p_window: *Window) ?*gdk.Cursor;
    pub const getCursor = gdk_window_get_cursor;

    /// Returns the decorations set on the GdkWindow with
    /// `gdk.Window.setDecorations`.
    extern fn gdk_window_get_decorations(p_window: *Window, p_decorations: *gdk.WMDecoration) c_int;
    pub const getDecorations = gdk_window_get_decorations;

    /// Retrieves a `gdk.Cursor` pointer for the `device` currently set on the
    /// specified `gdk.Window`, or `NULL`.  If the return value is `NULL` then
    /// there is no custom cursor set on the specified window, and it is
    /// using the cursor for its parent window.
    extern fn gdk_window_get_device_cursor(p_window: *Window, p_device: *gdk.Device) ?*gdk.Cursor;
    pub const getDeviceCursor = gdk_window_get_device_cursor;

    /// Returns the event mask for `window` corresponding to an specific device.
    extern fn gdk_window_get_device_events(p_window: *Window, p_device: *gdk.Device) gdk.EventMask;
    pub const getDeviceEvents = gdk_window_get_device_events;

    /// Obtains the current device position and modifier state.
    /// The position is given in coordinates relative to the upper left
    /// corner of `window`.
    ///
    /// Use `gdk.Window.getDevicePositionDouble` if you need subpixel precision.
    extern fn gdk_window_get_device_position(p_window: *Window, p_device: *gdk.Device, p_x: ?*c_int, p_y: ?*c_int, p_mask: ?*gdk.ModifierType) ?*gdk.Window;
    pub const getDevicePosition = gdk_window_get_device_position;

    /// Obtains the current device position in doubles and modifier state.
    /// The position is given in coordinates relative to the upper left
    /// corner of `window`.
    extern fn gdk_window_get_device_position_double(p_window: *Window, p_device: *gdk.Device, p_x: ?*f64, p_y: ?*f64, p_mask: ?*gdk.ModifierType) ?*gdk.Window;
    pub const getDevicePositionDouble = gdk_window_get_device_position_double;

    /// Gets the `gdk.Display` associated with a `gdk.Window`.
    extern fn gdk_window_get_display(p_window: *Window) *gdk.Display;
    pub const getDisplay = gdk_window_get_display;

    /// Finds out the DND protocol supported by a window.
    extern fn gdk_window_get_drag_protocol(p_window: *Window, p_target: ?**gdk.Window) gdk.DragProtocol;
    pub const getDragProtocol = gdk_window_get_drag_protocol;

    /// Obtains the parent of `window`, as known to GDK. Works like
    /// `gdk.Window.getParent` for normal windows, but returns the
    /// window’s embedder for offscreen windows.
    ///
    /// See also: `gdk.offscreenWindowGetEmbedder`
    extern fn gdk_window_get_effective_parent(p_window: *Window) *gdk.Window;
    pub const getEffectiveParent = gdk_window_get_effective_parent;

    /// Gets the toplevel window that’s an ancestor of `window`.
    ///
    /// Works like `gdk.Window.getToplevel`, but treats an offscreen window's
    /// embedder as its parent, using `gdk.Window.getEffectiveParent`.
    ///
    /// See also: `gdk.offscreenWindowGetEmbedder`
    extern fn gdk_window_get_effective_toplevel(p_window: *Window) *gdk.Window;
    pub const getEffectiveToplevel = gdk_window_get_effective_toplevel;

    /// Get the current event compression setting for this window.
    extern fn gdk_window_get_event_compression(p_window: *Window) c_int;
    pub const getEventCompression = gdk_window_get_event_compression;

    /// Gets the event mask for `window` for all master input devices. See
    /// `gdk.Window.setEvents`.
    extern fn gdk_window_get_events(p_window: *Window) gdk.EventMask;
    pub const getEvents = gdk_window_get_events;

    /// Determines whether or not the desktop environment should be hinted that the
    /// window does not want to receive input focus when it is mapped.
    extern fn gdk_window_get_focus_on_map(p_window: *Window) c_int;
    pub const getFocusOnMap = gdk_window_get_focus_on_map;

    /// Gets the frame clock for the window. The frame clock for a window
    /// never changes unless the window is reparented to a new toplevel
    /// window.
    extern fn gdk_window_get_frame_clock(p_window: *Window) *gdk.FrameClock;
    pub const getFrameClock = gdk_window_get_frame_clock;

    /// Obtains the bounding box of the window, including window manager
    /// titlebar/borders if any. The frame position is given in root window
    /// coordinates. To get the position of the window itself (rather than
    /// the frame) in root window coordinates, use `gdk.Window.getOrigin`.
    extern fn gdk_window_get_frame_extents(p_window: *Window, p_rect: *gdk.Rectangle) void;
    pub const getFrameExtents = gdk_window_get_frame_extents;

    /// Obtains the `gdk.FullscreenMode` of the `window`.
    extern fn gdk_window_get_fullscreen_mode(p_window: *Window) gdk.FullscreenMode;
    pub const getFullscreenMode = gdk_window_get_fullscreen_mode;

    /// Any of the return location arguments to this function may be `NULL`,
    /// if you aren’t interested in getting the value of that field.
    ///
    /// The X and Y coordinates returned are relative to the parent window
    /// of `window`, which for toplevels usually means relative to the
    /// window decorations (titlebar, etc.) rather than relative to the
    /// root window (screen-size background window).
    ///
    /// On the X11 platform, the geometry is obtained from the X server,
    /// so reflects the latest position of `window`; this may be out-of-sync
    /// with the position of `window` delivered in the most-recently-processed
    /// `gdk.EventConfigure`. `gdk.Window.getPosition` in contrast gets the
    /// position from the most recent configure event.
    ///
    /// Note: If `window` is not a toplevel, it is much better
    /// to call `gdk.Window.getPosition`, `gdk.Window.getWidth` and
    /// `gdk.Window.getHeight` instead, because it avoids the roundtrip to
    /// the X server and because these functions support the full 32-bit
    /// coordinate space, whereas `gdk.Window.getGeometry` is restricted to
    /// the 16-bit coordinates of X11.
    extern fn gdk_window_get_geometry(p_window: *Window, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getGeometry = gdk_window_get_geometry;

    /// Returns the group leader window for `window`. See `gdk.Window.setGroup`.
    extern fn gdk_window_get_group(p_window: *Window) *gdk.Window;
    pub const getGroup = gdk_window_get_group;

    /// Returns the height of the given `window`.
    ///
    /// On the X11 platform the returned size is the size reported in the
    /// most-recently-processed configure event, rather than the current
    /// size on the X server.
    extern fn gdk_window_get_height(p_window: *Window) c_int;
    pub const getHeight = gdk_window_get_height;

    /// Determines whether or not the window manager is hinted that `window`
    /// has modal behaviour.
    extern fn gdk_window_get_modal_hint(p_window: *Window) c_int;
    pub const getModalHint = gdk_window_get_modal_hint;

    /// Obtains the position of a window in root window coordinates.
    /// (Compare with `gdk.Window.getPosition` and
    /// `gdk.Window.getGeometry` which return the position of a window
    /// relative to its parent window.)
    extern fn gdk_window_get_origin(p_window: *Window, p_x: ?*c_int, p_y: ?*c_int) c_int;
    pub const getOrigin = gdk_window_get_origin;

    /// Obtains the parent of `window`, as known to GDK. Does not query the
    /// X server; thus this returns the parent as passed to `gdk.Window.new`,
    /// not the actual parent. This should never matter unless you’re using
    /// Xlib calls mixed with GDK calls on the X11 platform. It may also
    /// matter for toplevel windows, because the window manager may choose
    /// to reparent them.
    ///
    /// Note that you should use `gdk.Window.getEffectiveParent` when
    /// writing generic code that walks up a window hierarchy, because
    /// `gdk.Window.getParent` will most likely not do what you expect if
    /// there are offscreen windows in the hierarchy.
    extern fn gdk_window_get_parent(p_window: *Window) *gdk.Window;
    pub const getParent = gdk_window_get_parent;

    /// Returns whether input to the window is passed through to the window
    /// below.
    ///
    /// See `gdk.Window.setPassThrough` for details
    extern fn gdk_window_get_pass_through(p_window: *Window) c_int;
    pub const getPassThrough = gdk_window_get_pass_through;

    /// Obtains the current pointer position and modifier state.
    /// The position is given in coordinates relative to the upper left
    /// corner of `window`.
    extern fn gdk_window_get_pointer(p_window: *Window, p_x: ?*c_int, p_y: ?*c_int, p_mask: ?*gdk.ModifierType) ?*gdk.Window;
    pub const getPointer = gdk_window_get_pointer;

    /// Obtains the position of the window as reported in the
    /// most-recently-processed `gdk.EventConfigure`. Contrast with
    /// `gdk.Window.getGeometry` which queries the X server for the
    /// current window position, regardless of which events have been
    /// received or processed.
    ///
    /// The position coordinates are relative to the window’s parent window.
    extern fn gdk_window_get_position(p_window: *Window, p_x: ?*c_int, p_y: ?*c_int) void;
    pub const getPosition = gdk_window_get_position;

    /// Obtains the position of a window position in root
    /// window coordinates. This is similar to
    /// `gdk.Window.getOrigin` but allows you to pass
    /// in any position in the window, not just the origin.
    extern fn gdk_window_get_root_coords(p_window: *Window, p_x: c_int, p_y: c_int, p_root_x: *c_int, p_root_y: *c_int) void;
    pub const getRootCoords = gdk_window_get_root_coords;

    /// Obtains the top-left corner of the window manager frame in root
    /// window coordinates.
    extern fn gdk_window_get_root_origin(p_window: *Window, p_x: *c_int, p_y: *c_int) void;
    pub const getRootOrigin = gdk_window_get_root_origin;

    /// Returns the internal scale factor that maps from window coordiantes
    /// to the actual device pixels. On traditional systems this is 1, but
    /// on very high density outputs this can be a higher value (often 2).
    ///
    /// A higher value means that drawing is automatically scaled up to
    /// a higher resolution, so any code doing drawing will automatically look
    /// nicer. However, if you are supplying pixel-based data the scale
    /// value can be used to determine whether to use a pixel resource
    /// with higher resolution data.
    ///
    /// The scale of a window may change during runtime, if this happens
    /// a configure event will be sent to the toplevel window.
    extern fn gdk_window_get_scale_factor(p_window: *Window) c_int;
    pub const getScaleFactor = gdk_window_get_scale_factor;

    /// Gets the `gdk.Screen` associated with a `gdk.Window`.
    extern fn gdk_window_get_screen(p_window: *Window) *gdk.Screen;
    pub const getScreen = gdk_window_get_screen;

    /// Returns the event mask for `window` corresponding to the device class specified
    /// by `source`.
    extern fn gdk_window_get_source_events(p_window: *Window, p_source: gdk.InputSource) gdk.EventMask;
    pub const getSourceEvents = gdk_window_get_source_events;

    /// Gets the bitwise OR of the currently active window state flags,
    /// from the `gdk.WindowState` enumeration.
    extern fn gdk_window_get_state(p_window: *Window) gdk.WindowState;
    pub const getState = gdk_window_get_state;

    /// Returns `TRUE` if the window is aware of the existence of multiple
    /// devices.
    extern fn gdk_window_get_support_multidevice(p_window: *Window) c_int;
    pub const getSupportMultidevice = gdk_window_get_support_multidevice;

    /// Gets the toplevel window that’s an ancestor of `window`.
    ///
    /// Any window type but `GDK_WINDOW_CHILD` is considered a
    /// toplevel window, as is a `GDK_WINDOW_CHILD` window that
    /// has a root window as parent.
    ///
    /// Note that you should use `gdk.Window.getEffectiveToplevel` when
    /// you want to get to a window’s toplevel as seen on screen, because
    /// `gdk.Window.getToplevel` will most likely not do what you expect
    /// if there are offscreen windows in the hierarchy.
    extern fn gdk_window_get_toplevel(p_window: *Window) *gdk.Window;
    pub const getToplevel = gdk_window_get_toplevel;

    /// This function returns the type hint set for a window.
    extern fn gdk_window_get_type_hint(p_window: *Window) gdk.WindowTypeHint;
    pub const getTypeHint = gdk_window_get_type_hint;

    /// Transfers ownership of the update area from `window` to the caller
    /// of the function. That is, after calling this function, `window` will
    /// no longer have an invalid/dirty region; the update area is removed
    /// from `window` and handed to you. If a window has no update area,
    /// `gdk.Window.getUpdateArea` returns `NULL`. You are responsible for
    /// calling `cairo_region_destroy` on the returned region if it’s non-`NULL`.
    extern fn gdk_window_get_update_area(p_window: *Window) *cairo.Region;
    pub const getUpdateArea = gdk_window_get_update_area;

    /// Retrieves the user data for `window`, which is normally the widget
    /// that `window` belongs to. See `gdk.Window.setUserData`.
    extern fn gdk_window_get_user_data(p_window: *Window, p_data: ?*anyopaque) void;
    pub const getUserData = gdk_window_get_user_data;

    /// Computes the region of the `window` that is potentially visible.
    /// This does not necessarily take into account if the window is
    /// obscured by other windows, but no area outside of this region
    /// is visible.
    extern fn gdk_window_get_visible_region(p_window: *Window) *cairo.Region;
    pub const getVisibleRegion = gdk_window_get_visible_region;

    /// Gets the `gdk.Visual` describing the pixel format of `window`.
    extern fn gdk_window_get_visual(p_window: *Window) *gdk.Visual;
    pub const getVisual = gdk_window_get_visual;

    /// Returns the width of the given `window`.
    ///
    /// On the X11 platform the returned size is the size reported in the
    /// most-recently-processed configure event, rather than the current
    /// size on the X server.
    extern fn gdk_window_get_width(p_window: *Window) c_int;
    pub const getWidth = gdk_window_get_width;

    /// Gets the type of the window. See `gdk.WindowType`.
    extern fn gdk_window_get_window_type(p_window: *Window) gdk.WindowType;
    pub const getWindowType = gdk_window_get_window_type;

    /// Checks whether the window has a native window or not. Note that
    /// you can use `gdk.Window.ensureNative` if a native window is needed.
    extern fn gdk_window_has_native(p_window: *Window) c_int;
    pub const hasNative = gdk_window_has_native;

    /// For toplevel windows, withdraws them, so they will no longer be
    /// known to the window manager; for all windows, unmaps them, so
    /// they won’t be displayed. Normally done automatically as
    /// part of `gtk_widget_hide`.
    extern fn gdk_window_hide(p_window: *Window) void;
    pub const hide = gdk_window_hide;

    /// Asks to iconify (minimize) `window`. The window manager may choose
    /// to ignore the request, but normally will honor it. Using
    /// `gtk_window_iconify` is preferred, if you have a `GtkWindow` widget.
    ///
    /// This function only makes sense when `window` is a toplevel window.
    extern fn gdk_window_iconify(p_window: *Window) void;
    pub const iconify = gdk_window_iconify;

    /// Like `gdk.Window.shapeCombineRegion`, but the shape applies
    /// only to event handling. Mouse events which happen while
    /// the pointer position corresponds to an unset bit in the
    /// mask will be passed on the window below `window`.
    ///
    /// An input shape is typically used with RGBA windows.
    /// The alpha channel of the window defines which pixels are
    /// invisible and allows for nicely antialiased borders,
    /// and the input shape controls where the window is
    /// “clickable”.
    ///
    /// On the X11 platform, this requires version 1.1 of the
    /// shape extension.
    ///
    /// On the Win32 platform, this functionality is not present and the
    /// function does nothing.
    extern fn gdk_window_input_shape_combine_region(p_window: *Window, p_shape_region: *const cairo.Region, p_offset_x: c_int, p_offset_y: c_int) void;
    pub const inputShapeCombineRegion = gdk_window_input_shape_combine_region;

    /// Adds `region` to the update area for `window`. The update area is the
    /// region that needs to be redrawn, or “dirty region.” The call
    /// `gdk.Window.processUpdates` sends one or more expose events to the
    /// window, which together cover the entire update area. An
    /// application would normally redraw the contents of `window` in
    /// response to those expose events.
    ///
    /// GDK will call `gdk.Window.processAllUpdates` on your behalf
    /// whenever your program returns to the main loop and becomes idle, so
    /// normally there’s no need to do that manually, you just need to
    /// invalidate regions that you know should be redrawn.
    ///
    /// The `child_func` parameter controls whether the region of
    /// each child window that intersects `region` will also be invalidated.
    /// Only children for which `child_func` returns `TRUE` will have the area
    /// invalidated.
    extern fn gdk_window_invalidate_maybe_recurse(p_window: *Window, p_region: *const cairo.Region, p_child_func: ?gdk.WindowChildFunc, p_user_data: ?*anyopaque) void;
    pub const invalidateMaybeRecurse = gdk_window_invalidate_maybe_recurse;

    /// A convenience wrapper around `gdk.Window.invalidateRegion` which
    /// invalidates a rectangular region. See
    /// `gdk.Window.invalidateRegion` for details.
    extern fn gdk_window_invalidate_rect(p_window: *Window, p_rect: ?*const gdk.Rectangle, p_invalidate_children: c_int) void;
    pub const invalidateRect = gdk_window_invalidate_rect;

    /// Adds `region` to the update area for `window`. The update area is the
    /// region that needs to be redrawn, or “dirty region.” The call
    /// `gdk.Window.processUpdates` sends one or more expose events to the
    /// window, which together cover the entire update area. An
    /// application would normally redraw the contents of `window` in
    /// response to those expose events.
    ///
    /// GDK will call `gdk.Window.processAllUpdates` on your behalf
    /// whenever your program returns to the main loop and becomes idle, so
    /// normally there’s no need to do that manually, you just need to
    /// invalidate regions that you know should be redrawn.
    ///
    /// The `invalidate_children` parameter controls whether the region of
    /// each child window that intersects `region` will also be invalidated.
    /// If `FALSE`, then the update area for child windows will remain
    /// unaffected. See gdk_window_invalidate_maybe_recurse if you need
    /// fine grained control over which children are invalidated.
    extern fn gdk_window_invalidate_region(p_window: *Window, p_region: *const cairo.Region, p_invalidate_children: c_int) void;
    pub const invalidateRegion = gdk_window_invalidate_region;

    /// Check to see if a window is destroyed..
    extern fn gdk_window_is_destroyed(p_window: *Window) c_int;
    pub const isDestroyed = gdk_window_is_destroyed;

    /// Determines whether or not the window is an input only window.
    extern fn gdk_window_is_input_only(p_window: *Window) c_int;
    pub const isInputOnly = gdk_window_is_input_only;

    /// Determines whether or not the window is shaped.
    extern fn gdk_window_is_shaped(p_window: *Window) c_int;
    pub const isShaped = gdk_window_is_shaped;

    /// Check if the window and all ancestors of the window are
    /// mapped. (This is not necessarily "viewable" in the X sense, since
    /// we only check as far as we have GDK window parents, not to the root
    /// window.)
    extern fn gdk_window_is_viewable(p_window: *Window) c_int;
    pub const isViewable = gdk_window_is_viewable;

    /// Checks whether the window has been mapped (with `gdk.Window.show` or
    /// `gdk.Window.showUnraised`).
    extern fn gdk_window_is_visible(p_window: *Window) c_int;
    pub const isVisible = gdk_window_is_visible;

    /// Lowers `window` to the bottom of the Z-order (stacking order), so that
    /// other windows with the same parent window appear above `window`.
    /// This is true whether or not the other windows are visible.
    ///
    /// If `window` is a toplevel, the window manager may choose to deny the
    /// request to move the window in the Z-order, `gdk.Window.lower` only
    /// requests the restack, does not guarantee it.
    ///
    /// Note that `gdk.Window.show` raises the window again, so don’t call this
    /// function before `gdk.Window.show`. (Try `gdk.Window.showUnraised`.)
    extern fn gdk_window_lower(p_window: *Window) void;
    pub const lower = gdk_window_lower;

    /// If you call this during a paint (e.g. between `gdk.Window.beginPaintRegion`
    /// and `gdk.Window.endPaint` then GDK will mark the current clip region of the
    /// window as being drawn. This is required when mixing GL rendering via
    /// `gdk.cairoDrawFromGl` and cairo rendering, as otherwise GDK has no way
    /// of knowing when something paints over the GL-drawn regions.
    ///
    /// This is typically called automatically by GTK+ and you don't need
    /// to care about this.
    extern fn gdk_window_mark_paint_from_clip(p_window: *Window, p_cr: *cairo.Context) void;
    pub const markPaintFromClip = gdk_window_mark_paint_from_clip;

    /// Maximizes the window. If the window was already maximized, then
    /// this function does nothing.
    ///
    /// On X11, asks the window manager to maximize `window`, if the window
    /// manager supports this operation. Not all window managers support
    /// this, and some deliberately ignore it or don’t have a concept of
    /// “maximized”; so you can’t rely on the maximization actually
    /// happening. But it will happen with most standard window managers,
    /// and GDK makes a best effort to get it to happen.
    ///
    /// On Windows, reliably maximizes the window.
    extern fn gdk_window_maximize(p_window: *Window) void;
    pub const maximize = gdk_window_maximize;

    /// Merges the input shape masks for any child windows into the
    /// input shape mask for `window`. i.e. the union of all input masks
    /// for `window` and its children will become the new input mask
    /// for `window`. See `gdk.Window.inputShapeCombineRegion`.
    ///
    /// This function is distinct from `gdk.Window.setChildInputShapes`
    /// because it includes `window`’s input shape mask in the set of
    /// shapes to be merged.
    extern fn gdk_window_merge_child_input_shapes(p_window: *Window) void;
    pub const mergeChildInputShapes = gdk_window_merge_child_input_shapes;

    /// Merges the shape masks for any child windows into the
    /// shape mask for `window`. i.e. the union of all masks
    /// for `window` and its children will become the new mask
    /// for `window`. See `gdk.Window.shapeCombineRegion`.
    ///
    /// This function is distinct from `gdk.Window.setChildShapes`
    /// because it includes `window`’s shape mask in the set of shapes to
    /// be merged.
    extern fn gdk_window_merge_child_shapes(p_window: *Window) void;
    pub const mergeChildShapes = gdk_window_merge_child_shapes;

    /// Repositions a window relative to its parent window.
    /// For toplevel windows, window managers may ignore or modify the move;
    /// you should probably use `gtk_window_move` on a `GtkWindow` widget
    /// anyway, instead of using GDK functions. For child windows,
    /// the move will reliably succeed.
    ///
    /// If you’re also planning to resize the window, use `gdk.Window.moveResize`
    /// to both move and resize simultaneously, for a nicer visual effect.
    extern fn gdk_window_move(p_window: *Window, p_x: c_int, p_y: c_int) void;
    pub const move = gdk_window_move;

    /// Move the part of `window` indicated by `region` by `dy` pixels in the Y
    /// direction and `dx` pixels in the X direction. The portions of `region`
    /// that not covered by the new position of `region` are invalidated.
    ///
    /// Child windows are not moved.
    extern fn gdk_window_move_region(p_window: *Window, p_region: *const cairo.Region, p_dx: c_int, p_dy: c_int) void;
    pub const moveRegion = gdk_window_move_region;

    /// Equivalent to calling `gdk.Window.move` and `gdk.Window.resize`,
    /// except that both operations are performed at once, avoiding strange
    /// visual effects. (i.e. the user may be able to see the window first
    /// move, then resize, if you don’t use `gdk.Window.moveResize`.)
    extern fn gdk_window_move_resize(p_window: *Window, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void;
    pub const moveResize = gdk_window_move_resize;

    /// Moves `window` to `rect`, aligning their anchor points.
    ///
    /// `rect` is relative to the top-left corner of the window that `window` is
    /// transient for. `rect_anchor` and `window_anchor` determine anchor points on
    /// `rect` and `window` to pin together. `rect`'s anchor point can optionally be
    /// offset by `rect_anchor_dx` and `rect_anchor_dy`, which is equivalent to
    /// offsetting the position of `window`.
    ///
    /// `anchor_hints` determines how `window` will be moved if the anchor points cause
    /// it to move off-screen. For example, `GDK_ANCHOR_FLIP_X` will replace
    /// `GDK_GRAVITY_NORTH_WEST` with `GDK_GRAVITY_NORTH_EAST` and vice versa if
    /// `window` extends beyond the left or right edges of the monitor.
    ///
    /// Connect to the `gdk.Window.signals.moved`-to-rect signal to find out how it was
    /// actually positioned.
    extern fn gdk_window_move_to_rect(p_window: *Window, p_rect: *const gdk.Rectangle, p_rect_anchor: gdk.Gravity, p_window_anchor: gdk.Gravity, p_anchor_hints: gdk.AnchorHints, p_rect_anchor_dx: c_int, p_rect_anchor_dy: c_int) void;
    pub const moveToRect = gdk_window_move_to_rect;

    /// Like `gdk.Window.getChildren`, but does not copy the list of
    /// children, so the list does not need to be freed.
    extern fn gdk_window_peek_children(p_window: *Window) *glib.List;
    pub const peekChildren = gdk_window_peek_children;

    /// Sends one or more expose events to `window`. The areas in each
    /// expose event will cover the entire update area for the window (see
    /// `gdk.Window.invalidateRegion` for details). Normally GDK calls
    /// `gdk.Window.processAllUpdates` on your behalf, so there’s no
    /// need to call this function unless you want to force expose events
    /// to be delivered immediately and synchronously (vs. the usual
    /// case, where GDK delivers them in an idle handler). Occasionally
    /// this is useful to produce nicer scrolling behavior, for example.
    extern fn gdk_window_process_updates(p_window: *Window, p_update_children: c_int) void;
    pub const processUpdates = gdk_window_process_updates;

    /// Raises `window` to the top of the Z-order (stacking order), so that
    /// other windows with the same parent window appear below `window`.
    /// This is true whether or not the windows are visible.
    ///
    /// If `window` is a toplevel, the window manager may choose to deny the
    /// request to move the window in the Z-order, `gdk.Window.raise` only
    /// requests the restack, does not guarantee it.
    extern fn gdk_window_raise(p_window: *Window) void;
    pub const raise = gdk_window_raise;

    /// Registers a window as a potential drop destination.
    extern fn gdk_window_register_dnd(p_window: *Window) void;
    pub const registerDnd = gdk_window_register_dnd;

    /// Remove a filter previously added with `gdk.Window.addFilter`.
    extern fn gdk_window_remove_filter(p_window: *Window, p_function: gdk.FilterFunc, p_data: ?*anyopaque) void;
    pub const removeFilter = gdk_window_remove_filter;

    /// Reparents `window` into the given `new_parent`. The window being
    /// reparented will be unmapped as a side effect.
    extern fn gdk_window_reparent(p_window: *Window, p_new_parent: *gdk.Window, p_x: c_int, p_y: c_int) void;
    pub const reparent = gdk_window_reparent;

    /// Resizes `window`; for toplevel windows, asks the window manager to resize
    /// the window. The window manager may not allow the resize. When using GTK+,
    /// use `gtk_window_resize` instead of this low-level GDK function.
    ///
    /// Windows may not be resized below 1x1.
    ///
    /// If you’re also planning to move the window, use `gdk.Window.moveResize`
    /// to both move and resize simultaneously, for a nicer visual effect.
    extern fn gdk_window_resize(p_window: *Window, p_width: c_int, p_height: c_int) void;
    pub const resize = gdk_window_resize;

    /// Changes the position of  `window` in the Z-order (stacking order), so that
    /// it is above `sibling` (if `above` is `TRUE`) or below `sibling` (if `above` is
    /// `FALSE`).
    ///
    /// If `sibling` is `NULL`, then this either raises (if `above` is `TRUE`) or
    /// lowers the window.
    ///
    /// If `window` is a toplevel, the window manager may choose to deny the
    /// request to move the window in the Z-order, `gdk.Window.restack` only
    /// requests the restack, does not guarantee it.
    extern fn gdk_window_restack(p_window: *Window, p_sibling: ?*gdk.Window, p_above: c_int) void;
    pub const restack = gdk_window_restack;

    /// Scroll the contents of `window`, both pixels and children, by the
    /// given amount. `window` itself does not move. Portions of the window
    /// that the scroll operation brings in from offscreen areas are
    /// invalidated. The invalidated region may be bigger than what would
    /// strictly be necessary.
    ///
    /// For X11, a minimum area will be invalidated if the window has no
    /// subwindows, or if the edges of the window’s parent do not extend
    /// beyond the edges of the window. In other cases, a multi-step process
    /// is used to scroll the window which may produce temporary visual
    /// artifacts and unnecessary invalidations.
    extern fn gdk_window_scroll(p_window: *Window, p_dx: c_int, p_dy: c_int) void;
    pub const scroll = gdk_window_scroll;

    /// Setting `accept_focus` to `FALSE` hints the desktop environment that the
    /// window doesn’t want to receive input focus.
    ///
    /// On X, it is the responsibility of the window manager to interpret this
    /// hint. ICCCM-compliant window manager usually respect it.
    extern fn gdk_window_set_accept_focus(p_window: *Window, p_accept_focus: c_int) void;
    pub const setAcceptFocus = gdk_window_set_accept_focus;

    /// Sets the background color of `window`.
    ///
    /// However, when using GTK+, influence the background of a widget
    /// using a style class or CSS — if you’re an application — or with
    /// `gtk_style_context_set_background` — if you're implementing a
    /// custom widget.
    extern fn gdk_window_set_background(p_window: *Window, p_color: *const gdk.Color) void;
    pub const setBackground = gdk_window_set_background;

    /// Sets the background of `window`.
    ///
    /// A background of `NULL` means that the window won't have any background. On the
    /// X11 backend it's also possible to inherit the background from the parent
    /// window using `gdk_x11_get_parent_relative_pattern`.
    ///
    /// The windowing system will normally fill a window with its background
    /// when the window is obscured then exposed.
    extern fn gdk_window_set_background_pattern(p_window: *Window, p_pattern: ?*cairo.Pattern) void;
    pub const setBackgroundPattern = gdk_window_set_background_pattern;

    /// Sets the background color of `window`.
    ///
    /// See also `gdk.Window.setBackgroundPattern`.
    extern fn gdk_window_set_background_rgba(p_window: *Window, p_rgba: *const gdk.RGBA) void;
    pub const setBackgroundRgba = gdk_window_set_background_rgba;

    /// Sets the input shape mask of `window` to the union of input shape masks
    /// for all children of `window`, ignoring the input shape mask of `window`
    /// itself. Contrast with `gdk.Window.mergeChildInputShapes` which includes
    /// the input shape mask of `window` in the masks to be merged.
    extern fn gdk_window_set_child_input_shapes(p_window: *Window) void;
    pub const setChildInputShapes = gdk_window_set_child_input_shapes;

    /// Sets the shape mask of `window` to the union of shape masks
    /// for all children of `window`, ignoring the shape mask of `window`
    /// itself. Contrast with `gdk.Window.mergeChildShapes` which includes
    /// the shape mask of `window` in the masks to be merged.
    extern fn gdk_window_set_child_shapes(p_window: *Window) void;
    pub const setChildShapes = gdk_window_set_child_shapes;

    /// Sets a `gdk.Window` as composited, or unsets it. Composited
    /// windows do not automatically have their contents drawn to
    /// the screen. Drawing is redirected to an offscreen buffer
    /// and an expose event is emitted on the parent of the composited
    /// window. It is the responsibility of the parent’s expose handler
    /// to manually merge the off-screen content onto the screen in
    /// whatever way it sees fit.
    ///
    /// It only makes sense for child windows to be composited; see
    /// `gdk.Window.setOpacity` if you need translucent toplevel
    /// windows.
    ///
    /// An additional effect of this call is that the area of this
    /// window is no longer clipped from regions marked for
    /// invalidation on its parent. Draws done on the parent
    /// window are also no longer clipped by the child.
    ///
    /// This call is only supported on some systems (currently,
    /// only X11 with new enough Xcomposite and Xdamage extensions).
    /// You must call `gdk.Display.supportsComposite` to check if
    /// setting a window as composited is supported before
    /// attempting to do so.
    extern fn gdk_window_set_composited(p_window: *Window, p_composited: c_int) void;
    pub const setComposited = gdk_window_set_composited;

    /// Sets the default mouse pointer for a `gdk.Window`.
    ///
    /// Note that `cursor` must be for the same display as `window`.
    ///
    /// Use `gdk.Cursor.newForDisplay` or `gdk.Cursor.newFromPixbuf` to
    /// create the cursor. To make the cursor invisible, use `GDK_BLANK_CURSOR`.
    /// Passing `NULL` for the `cursor` argument to `gdk.Window.setCursor` means
    /// that `window` will use the cursor of its parent window. Most windows
    /// should use this default.
    extern fn gdk_window_set_cursor(p_window: *Window, p_cursor: ?*gdk.Cursor) void;
    pub const setCursor = gdk_window_set_cursor;

    /// “Decorations” are the features the window manager adds to a toplevel `gdk.Window`.
    /// This function sets the traditional Motif window manager hints that tell the
    /// window manager which decorations you would like your window to have.
    /// Usually you should use `gtk_window_set_decorated` on a `GtkWindow` instead of
    /// using the GDK function directly.
    ///
    /// The `decorations` argument is the logical OR of the fields in
    /// the `gdk.WMDecoration` enumeration. If `GDK_DECOR_ALL` is included in the
    /// mask, the other bits indicate which decorations should be turned off.
    /// If `GDK_DECOR_ALL` is not included, then the other bits indicate
    /// which decorations should be turned on.
    ///
    /// Most window managers honor a decorations hint of 0 to disable all decorations,
    /// but very few honor all possible combinations of bits.
    extern fn gdk_window_set_decorations(p_window: *Window, p_decorations: gdk.WMDecoration) void;
    pub const setDecorations = gdk_window_set_decorations;

    /// Sets a specific `gdk.Cursor` for a given device when it gets inside `window`.
    /// Use `gdk.Cursor.newForDisplay` or `gdk.Cursor.newFromPixbuf` to create
    /// the cursor. To make the cursor invisible, use `GDK_BLANK_CURSOR`. Passing
    /// `NULL` for the `cursor` argument to `gdk.Window.setCursor` means that
    /// `window` will use the cursor of its parent window. Most windows should
    /// use this default.
    extern fn gdk_window_set_device_cursor(p_window: *Window, p_device: *gdk.Device, p_cursor: *gdk.Cursor) void;
    pub const setDeviceCursor = gdk_window_set_device_cursor;

    /// Sets the event mask for a given device (Normally a floating device, not
    /// attached to any visible pointer) to `window`. For example, an event mask
    /// including `GDK_BUTTON_PRESS_MASK` means the window should report button
    /// press events. The event mask is the bitwise OR of values from the
    /// `gdk.EventMask` enumeration.
    ///
    /// See the [input handling overview][event-masks] for details.
    extern fn gdk_window_set_device_events(p_window: *Window, p_device: *gdk.Device, p_event_mask: gdk.EventMask) void;
    pub const setDeviceEvents = gdk_window_set_device_events;

    /// Determines whether or not extra unprocessed motion events in
    /// the event queue can be discarded. If `TRUE` only the most recent
    /// event will be delivered.
    ///
    /// Some types of applications, e.g. paint programs, need to see all
    /// motion events and will benefit from turning off event compression.
    ///
    /// By default, event compression is enabled.
    extern fn gdk_window_set_event_compression(p_window: *Window, p_event_compression: c_int) void;
    pub const setEventCompression = gdk_window_set_event_compression;

    /// The event mask for a window determines which events will be reported
    /// for that window from all master input devices. For example, an event mask
    /// including `GDK_BUTTON_PRESS_MASK` means the window should report button
    /// press events. The event mask is the bitwise OR of values from the
    /// `gdk.EventMask` enumeration.
    ///
    /// See the [input handling overview][event-masks] for details.
    extern fn gdk_window_set_events(p_window: *Window, p_event_mask: gdk.EventMask) void;
    pub const setEvents = gdk_window_set_events;

    /// Setting `focus_on_map` to `FALSE` hints the desktop environment that the
    /// window doesn’t want to receive input focus when it is mapped.
    /// focus_on_map should be turned off for windows that aren’t triggered
    /// interactively (such as popups from network activity).
    ///
    /// On X, it is the responsibility of the window manager to interpret
    /// this hint. Window managers following the freedesktop.org window
    /// manager extension specification should respect it.
    extern fn gdk_window_set_focus_on_map(p_window: *Window, p_focus_on_map: c_int) void;
    pub const setFocusOnMap = gdk_window_set_focus_on_map;

    /// Specifies whether the `window` should span over all monitors (in a multi-head
    /// setup) or only the current monitor when in fullscreen mode.
    ///
    /// The `mode` argument is from the `gdk.FullscreenMode` enumeration.
    /// If `GDK_FULLSCREEN_ON_ALL_MONITORS` is specified, the fullscreen `window` will
    /// span over all monitors from the `gdk.Screen`.
    ///
    /// On X11, searches through the list of monitors from the `gdk.Screen` the ones
    /// which delimit the 4 edges of the entire `gdk.Screen` and will ask the window
    /// manager to span the `window` over these monitors.
    ///
    /// If the XINERAMA extension is not available or not usable, this function
    /// has no effect.
    ///
    /// Not all window managers support this, so you can’t rely on the fullscreen
    /// window to span over the multiple monitors when `GDK_FULLSCREEN_ON_ALL_MONITORS`
    /// is specified.
    extern fn gdk_window_set_fullscreen_mode(p_window: *Window, p_mode: gdk.FullscreenMode) void;
    pub const setFullscreenMode = gdk_window_set_fullscreen_mode;

    /// Sets hints about the window management functions to make available
    /// via buttons on the window frame.
    ///
    /// On the X backend, this function sets the traditional Motif window
    /// manager hint for this purpose. However, few window managers do
    /// anything reliable or interesting with this hint. Many ignore it
    /// entirely.
    ///
    /// The `functions` argument is the logical OR of values from the
    /// `gdk.WMFunction` enumeration. If the bitmask includes `GDK_FUNC_ALL`,
    /// then the other bits indicate which functions to disable; if
    /// it doesn’t include `GDK_FUNC_ALL`, it indicates which functions to
    /// enable.
    extern fn gdk_window_set_functions(p_window: *Window, p_functions: gdk.WMFunction) void;
    pub const setFunctions = gdk_window_set_functions;

    /// Sets the geometry hints for `window`. Hints flagged in `geom_mask`
    /// are set, hints not flagged in `geom_mask` are unset.
    /// To unset all hints, use a `geom_mask` of 0 and a `geometry` of `NULL`.
    ///
    /// This function provides hints to the windowing system about
    /// acceptable sizes for a toplevel window. The purpose of
    /// this is to constrain user resizing, but the windowing system
    /// will typically  (but is not required to) also constrain the
    /// current size of the window to the provided values and
    /// constrain programatic resizing via `gdk.Window.resize` or
    /// `gdk.Window.moveResize`.
    ///
    /// Note that on X11, this effect has no effect on windows
    /// of type `GDK_WINDOW_TEMP` or windows where override redirect
    /// has been turned on via `gdk.Window.setOverrideRedirect`
    /// since these windows are not resizable by the user.
    ///
    /// Since you can’t count on the windowing system doing the
    /// constraints for programmatic resizes, you should generally
    /// call `gdk.Window.constrainSize` yourself to determine
    /// appropriate sizes.
    extern fn gdk_window_set_geometry_hints(p_window: *Window, p_geometry: *const gdk.Geometry, p_geom_mask: gdk.WindowHints) void;
    pub const setGeometryHints = gdk_window_set_geometry_hints;

    /// Sets the group leader window for `window`. By default,
    /// GDK sets the group leader for all toplevel windows
    /// to a global window implicitly created by GDK. With this function
    /// you can override this default.
    ///
    /// The group leader window allows the window manager to distinguish
    /// all windows that belong to a single application. It may for example
    /// allow users to minimize/unminimize all windows belonging to an
    /// application at once. You should only set a non-default group window
    /// if your application pretends to be multiple applications.
    extern fn gdk_window_set_group(p_window: *Window, p_leader: ?*gdk.Window) void;
    pub const setGroup = gdk_window_set_group;

    /// Sets a list of icons for the window. One of these will be used
    /// to represent the window when it has been iconified. The icon is
    /// usually shown in an icon box or some sort of task bar. Which icon
    /// size is shown depends on the window manager. The window manager
    /// can scale the icon  but setting several size icons can give better
    /// image quality since the window manager may only need to scale the
    /// icon by a small amount or not at all.
    ///
    /// Note that some platforms don't support window icons.
    extern fn gdk_window_set_icon_list(p_window: *Window, p_pixbufs: *glib.List) void;
    pub const setIconList = gdk_window_set_icon_list;

    /// Windows may have a name used while minimized, distinct from the
    /// name they display in their titlebar. Most of the time this is a bad
    /// idea from a user interface standpoint. But you can set such a name
    /// with this function, if you like.
    ///
    /// After calling this with a non-`NULL` `name`, calls to `gdk.Window.setTitle`
    /// will not update the icon title.
    ///
    /// Using `NULL` for `name` unsets the icon title; further calls to
    /// `gdk.Window.setTitle` will again update the icon title as well.
    ///
    /// Note that some platforms don't support window icons.
    extern fn gdk_window_set_icon_name(p_window: *Window, p_name: ?[*:0]const u8) void;
    pub const setIconName = gdk_window_set_icon_name;

    /// Registers an invalidate handler for a specific window. This
    /// will get called whenever a region in the window or its children
    /// is invalidated.
    ///
    /// This can be used to record the invalidated region, which is
    /// useful if you are keeping an offscreen copy of some region
    /// and want to keep it up to date. You can also modify the
    /// invalidated region in case you’re doing some effect where
    /// e.g. a child widget appears in multiple places.
    extern fn gdk_window_set_invalidate_handler(p_window: *Window, p_handler: gdk.WindowInvalidateHandlerFunc) void;
    pub const setInvalidateHandler = gdk_window_set_invalidate_handler;

    /// Set if `window` must be kept above other windows. If the
    /// window was already above, then this function does nothing.
    ///
    /// On X11, asks the window manager to keep `window` above, if the window
    /// manager supports this operation. Not all window managers support
    /// this, and some deliberately ignore it or don’t have a concept of
    /// “keep above”; so you can’t rely on the window being kept above.
    /// But it will happen with most standard window managers,
    /// and GDK makes a best effort to get it to happen.
    extern fn gdk_window_set_keep_above(p_window: *Window, p_setting: c_int) void;
    pub const setKeepAbove = gdk_window_set_keep_above;

    /// Set if `window` must be kept below other windows. If the
    /// window was already below, then this function does nothing.
    ///
    /// On X11, asks the window manager to keep `window` below, if the window
    /// manager supports this operation. Not all window managers support
    /// this, and some deliberately ignore it or don’t have a concept of
    /// “keep below”; so you can’t rely on the window being kept below.
    /// But it will happen with most standard window managers,
    /// and GDK makes a best effort to get it to happen.
    extern fn gdk_window_set_keep_below(p_window: *Window, p_setting: c_int) void;
    pub const setKeepBelow = gdk_window_set_keep_below;

    /// The application can use this hint to tell the window manager
    /// that a certain window has modal behaviour. The window manager
    /// can use this information to handle modal windows in a special
    /// way.
    ///
    /// You should only use this on windows for which you have
    /// previously called `gdk.Window.setTransientFor`
    extern fn gdk_window_set_modal_hint(p_window: *Window, p_modal: c_int) void;
    pub const setModalHint = gdk_window_set_modal_hint;

    /// Set `window` to render as partially transparent,
    /// with opacity 0 being fully transparent and 1 fully opaque. (Values
    /// of the opacity parameter are clamped to the [0,1] range.)
    ///
    /// For toplevel windows this depends on support from the windowing system
    /// that may not always be there. For instance, On X11, this works only on
    /// X screens with a compositing manager running. On Wayland, there is no
    /// per-window opacity value that the compositor would apply. Instead, use
    /// `gdk_window_set_opaque_region (window, NULL)` to tell the compositor
    /// that the entire window is (potentially) non-opaque, and draw your content
    /// with alpha, or use `gtk_widget_set_opacity` to set an overall opacity
    /// for your widgets.
    ///
    /// For child windows this function only works for non-native windows.
    ///
    /// For setting up per-pixel alpha topelevels, see `gdk.Screen.getRgbaVisual`,
    /// and for non-toplevels, see `gdk.Window.setComposited`.
    ///
    /// Support for non-toplevel windows was added in 3.8.
    extern fn gdk_window_set_opacity(p_window: *Window, p_opacity: f64) void;
    pub const setOpacity = gdk_window_set_opacity;

    /// For optimisation purposes, compositing window managers may
    /// like to not draw obscured regions of windows, or turn off blending
    /// during for these regions. With RGB windows with no transparency,
    /// this is just the shape of the window, but with ARGB32 windows, the
    /// compositor does not know what regions of the window are transparent
    /// or not.
    ///
    /// This function only works for toplevel windows.
    ///
    /// GTK+ will update this property automatically if
    /// the `window` background is opaque, as we know where the opaque regions
    /// are. If your window background is not opaque, please update this
    /// property in your `GtkWidget.signals.style`-updated handler.
    extern fn gdk_window_set_opaque_region(p_window: *Window, p_region: ?*cairo.Region) void;
    pub const setOpaqueRegion = gdk_window_set_opaque_region;

    /// An override redirect window is not under the control of the window manager.
    /// This means it won’t have a titlebar, won’t be minimizable, etc. - it will
    /// be entirely under the control of the application. The window manager
    /// can’t see the override redirect window at all.
    ///
    /// Override redirect should only be used for short-lived temporary
    /// windows, such as popup menus. `GtkMenu` uses an override redirect
    /// window in its implementation, for example.
    extern fn gdk_window_set_override_redirect(p_window: *Window, p_override_redirect: c_int) void;
    pub const setOverrideRedirect = gdk_window_set_override_redirect;

    /// Sets whether input to the window is passed through to the window
    /// below.
    ///
    /// The default value of this is `FALSE`, which means that pointer
    /// events that happen inside the window are send first to the window,
    /// but if the event is not selected by the event mask then the event
    /// is sent to the parent window, and so on up the hierarchy.
    ///
    /// If `pass_through` is `TRUE` then such pointer events happen as if the
    /// window wasn't there at all, and thus will be sent first to any
    /// windows below `window`. This is useful if the window is used in a
    /// transparent fashion. In the terminology of the web this would be called
    /// "pointer-events: none".
    ///
    /// Note that a window with `pass_through` `TRUE` can still have a subwindow
    /// without pass through, so you can get events on a subset of a window. And in
    /// that cases you would get the in-between related events such as the pointer
    /// enter/leave events on its way to the destination window.
    extern fn gdk_window_set_pass_through(p_window: *Window, p_pass_through: c_int) void;
    pub const setPassThrough = gdk_window_set_pass_through;

    /// When using GTK+, typically you should use `gtk_window_set_role` instead
    /// of this low-level function.
    ///
    /// The window manager and session manager use a window’s role to
    /// distinguish it from other kinds of window in the same application.
    /// When an application is restarted after being saved in a previous
    /// session, all windows with the same title and role are treated as
    /// interchangeable.  So if you have two windows with the same title
    /// that should be distinguished for session management purposes, you
    /// should set the role on those windows. It doesn’t matter what string
    /// you use for the role, as long as you have a different role for each
    /// non-interchangeable kind of window.
    extern fn gdk_window_set_role(p_window: *Window, p_role: [*:0]const u8) void;
    pub const setRole = gdk_window_set_role;

    /// Newer GTK+ windows using client-side decorations use extra geometry
    /// around their frames for effects like shadows and invisible borders.
    /// Window managers that want to maximize windows or snap to edges need
    /// to know where the extents of the actual frame lie, so that users
    /// don’t feel like windows are snapping against random invisible edges.
    ///
    /// Note that this property is automatically updated by GTK+, so this
    /// function should only be used by applications which do not use GTK+
    /// to create toplevel windows.
    extern fn gdk_window_set_shadow_width(p_window: *Window, p_left: c_int, p_right: c_int, p_top: c_int, p_bottom: c_int) void;
    pub const setShadowWidth = gdk_window_set_shadow_width;

    /// Toggles whether a window should appear in a pager (workspace
    /// switcher, or other desktop utility program that displays a small
    /// thumbnail representation of the windows on the desktop). If a
    /// window’s semantic type as specified with `gdk.Window.setTypeHint`
    /// already fully describes the window, this function should
    /// not be called in addition, instead you should
    /// allow the window to be treated according to standard policy for
    /// its semantic type.
    extern fn gdk_window_set_skip_pager_hint(p_window: *Window, p_skips_pager: c_int) void;
    pub const setSkipPagerHint = gdk_window_set_skip_pager_hint;

    /// Toggles whether a window should appear in a task list or window
    /// list. If a window’s semantic type as specified with
    /// `gdk.Window.setTypeHint` already fully describes the window, this
    /// function should not be called in addition,
    /// instead you should allow the window to be treated according to
    /// standard policy for its semantic type.
    extern fn gdk_window_set_skip_taskbar_hint(p_window: *Window, p_skips_taskbar: c_int) void;
    pub const setSkipTaskbarHint = gdk_window_set_skip_taskbar_hint;

    /// Sets the event mask for any floating device (i.e. not attached to any
    /// visible pointer) that has the source defined as `source`. This event
    /// mask will be applied both to currently existing, newly added devices
    /// after this call, and devices being attached/detached.
    extern fn gdk_window_set_source_events(p_window: *Window, p_source: gdk.InputSource, p_event_mask: gdk.EventMask) void;
    pub const setSourceEvents = gdk_window_set_source_events;

    /// When using GTK+, typically you should use `gtk_window_set_startup_id`
    /// instead of this low-level function.
    extern fn gdk_window_set_startup_id(p_window: *Window, p_startup_id: [*:0]const u8) void;
    pub const setStartupId = gdk_window_set_startup_id;

    /// Used to set the bit gravity of the given window to static, and flag
    /// it so all children get static subwindow gravity. This is used if you
    /// are implementing scary features that involve deep knowledge of the
    /// windowing system. Don’t worry about it.
    extern fn gdk_window_set_static_gravities(p_window: *Window, p_use_static: c_int) c_int;
    pub const setStaticGravities = gdk_window_set_static_gravities;

    /// This function will enable multidevice features in `window`.
    ///
    /// Multidevice aware windows will need to handle properly multiple,
    /// per device enter/leave events, device grabs and grab ownerships.
    extern fn gdk_window_set_support_multidevice(p_window: *Window, p_support_multidevice: c_int) void;
    pub const setSupportMultidevice = gdk_window_set_support_multidevice;

    /// Sets the title of a toplevel window, to be displayed in the titlebar.
    /// If you haven’t explicitly set the icon name for the window
    /// (using `gdk.Window.setIconName`), the icon name will be set to
    /// `title` as well. `title` must be in UTF-8 encoding (as with all
    /// user-readable strings in GDK/GTK+). `title` may not be `NULL`.
    extern fn gdk_window_set_title(p_window: *Window, p_title: [*:0]const u8) void;
    pub const setTitle = gdk_window_set_title;

    /// Indicates to the window manager that `window` is a transient dialog
    /// associated with the application window `parent`. This allows the
    /// window manager to do things like center `window` on `parent` and
    /// keep `window` above `parent`.
    ///
    /// See `gtk_window_set_transient_for` if you’re using `GtkWindow` or
    /// `GtkDialog`.
    extern fn gdk_window_set_transient_for(p_window: *Window, p_parent: *gdk.Window) void;
    pub const setTransientFor = gdk_window_set_transient_for;

    /// The application can use this call to provide a hint to the window
    /// manager about the functionality of a window. The window manager
    /// can use this information when determining the decoration and behaviour
    /// of the window.
    ///
    /// The hint must be set before the window is mapped.
    extern fn gdk_window_set_type_hint(p_window: *Window, p_hint: gdk.WindowTypeHint) void;
    pub const setTypeHint = gdk_window_set_type_hint;

    /// Toggles whether a window needs the user's
    /// urgent attention.
    extern fn gdk_window_set_urgency_hint(p_window: *Window, p_urgent: c_int) void;
    pub const setUrgencyHint = gdk_window_set_urgency_hint;

    /// For most purposes this function is deprecated in favor of
    /// `gobject.Object.setData`. However, for historical reasons GTK+ stores
    /// the `GtkWidget` that owns a `gdk.Window` as user data on the
    /// `gdk.Window`. So, custom widget implementations should use
    /// this function for that. If GTK+ receives an event for a `gdk.Window`,
    /// and the user data for the window is non-`NULL`, GTK+ will assume the
    /// user data is a `GtkWidget`, and forward the event to that widget.
    extern fn gdk_window_set_user_data(p_window: *Window, p_user_data: ?*gobject.Object) void;
    pub const setUserData = gdk_window_set_user_data;

    /// Makes pixels in `window` outside `shape_region` be transparent,
    /// so that the window may be nonrectangular.
    ///
    /// If `shape_region` is `NULL`, the shape will be unset, so the whole
    /// window will be opaque again. `offset_x` and `offset_y` are ignored
    /// if `shape_region` is `NULL`.
    ///
    /// On the X11 platform, this uses an X server extension which is
    /// widely available on most common platforms, but not available on
    /// very old X servers, and occasionally the implementation will be
    /// buggy. On servers without the shape extension, this function
    /// will do nothing.
    ///
    /// This function works on both toplevel and child windows.
    extern fn gdk_window_shape_combine_region(p_window: *Window, p_shape_region: ?*const cairo.Region, p_offset_x: c_int, p_offset_y: c_int) void;
    pub const shapeCombineRegion = gdk_window_shape_combine_region;

    /// Like `gdk.Window.showUnraised`, but also raises the window to the
    /// top of the window stack (moves the window to the front of the
    /// Z-order).
    ///
    /// This function maps a window so it’s visible onscreen. Its opposite
    /// is `gdk.Window.hide`.
    ///
    /// When implementing a `GtkWidget`, you should call this function on the widget's
    /// `gdk.Window` as part of the “map” method.
    extern fn gdk_window_show(p_window: *Window) void;
    pub const show = gdk_window_show;

    /// Shows a `gdk.Window` onscreen, but does not modify its stacking
    /// order. In contrast, `gdk.Window.show` will raise the window
    /// to the top of the window stack.
    ///
    /// On the X11 platform, in Xlib terms, this function calls
    /// `XMapWindow` (it also updates some internal GDK state, which means
    /// that you can’t really use `XMapWindow` directly on a GDK window).
    extern fn gdk_window_show_unraised(p_window: *Window) void;
    pub const showUnraised = gdk_window_show_unraised;

    /// Asks the windowing system to show the window menu. The window menu
    /// is the menu shown when right-clicking the titlebar on traditional
    /// windows managed by the window manager. This is useful for windows
    /// using client-side decorations, activating it with a right-click
    /// on the window decorations.
    extern fn gdk_window_show_window_menu(p_window: *Window, p_event: *gdk.Event) c_int;
    pub const showWindowMenu = gdk_window_show_window_menu;

    /// “Pins” a window such that it’s on all workspaces and does not scroll
    /// with viewports, for window managers that have scrollable viewports.
    /// (When using `GtkWindow`, `gtk_window_stick` may be more useful.)
    ///
    /// On the X11 platform, this function depends on window manager
    /// support, so may have no effect with many window managers. However,
    /// GDK will do the best it can to convince the window manager to stick
    /// the window. For window managers that don’t support this operation,
    /// there’s nothing you can do to force it to happen.
    extern fn gdk_window_stick(p_window: *Window) void;
    pub const stick = gdk_window_stick;

    /// Thaws a window frozen with
    /// `gdk.Window.freezeToplevelUpdatesLibgtkOnly`.
    ///
    /// This function is not part of the GDK public API and is only
    /// for use by GTK+.
    extern fn gdk_window_thaw_toplevel_updates_libgtk_only(p_window: *Window) void;
    pub const thawToplevelUpdatesLibgtkOnly = gdk_window_thaw_toplevel_updates_libgtk_only;

    /// Thaws a window frozen with `gdk.Window.freezeUpdates`.
    extern fn gdk_window_thaw_updates(p_window: *Window) void;
    pub const thawUpdates = gdk_window_thaw_updates;

    /// Moves the window out of fullscreen mode. If the window was not
    /// fullscreen, does nothing.
    ///
    /// On X11, asks the window manager to move `window` out of the fullscreen
    /// state, if the window manager supports this operation. Not all
    /// window managers support this, and some deliberately ignore it or
    /// don’t have a concept of “fullscreen”; so you can’t rely on the
    /// unfullscreenification actually happening. But it will happen with
    /// most standard window managers, and GDK makes a best effort to get
    /// it to happen.
    extern fn gdk_window_unfullscreen(p_window: *Window) void;
    pub const unfullscreen = gdk_window_unfullscreen;

    /// Unmaximizes the window. If the window wasn’t maximized, then this
    /// function does nothing.
    ///
    /// On X11, asks the window manager to unmaximize `window`, if the
    /// window manager supports this operation. Not all window managers
    /// support this, and some deliberately ignore it or don’t have a
    /// concept of “maximized”; so you can’t rely on the unmaximization
    /// actually happening. But it will happen with most standard window
    /// managers, and GDK makes a best effort to get it to happen.
    ///
    /// On Windows, reliably unmaximizes the window.
    extern fn gdk_window_unmaximize(p_window: *Window) void;
    pub const unmaximize = gdk_window_unmaximize;

    /// Reverse operation for `gdk.Window.stick`; see `gdk.Window.stick`,
    /// and `gtk_window_unstick`.
    extern fn gdk_window_unstick(p_window: *Window) void;
    pub const unstick = gdk_window_unstick;

    /// Withdraws a window (unmaps it and asks the window manager to forget about it).
    /// This function is not really useful as `gdk.Window.hide` automatically
    /// withdraws toplevel windows before hiding them.
    extern fn gdk_window_withdraw(p_window: *Window) void;
    pub const withdraw = gdk_window_withdraw;

    extern fn gdk_window_get_type() usize;
    pub const getGObjectType = gdk_window_get_type;

    extern fn g_object_ref(p_self: *gdk.Window) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.Window) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Window, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.DevicePad` is an interface implemented by devices of type
/// `GDK_SOURCE_TABLET_PAD`, it allows querying the features provided
/// by the pad device.
///
/// Tablet pads may contain one or more groups, each containing a subset
/// of the buttons/rings/strips available. `gdk.DevicePad.getNGroups`
/// can be used to obtain the number of groups, `gdk.DevicePad.getNFeatures`
/// and `gdk.DevicePad.getFeatureGroup` can be combined to find out the
/// number of buttons/rings/strips the device has, and how are they grouped.
///
/// Each of those groups have different modes, which may be used to map
/// each individual pad feature to multiple actions. Only one mode is
/// effective (current) for each given group, different groups may have
/// different current modes. The number of available modes in a group can
/// be found out through `gdk.DevicePad.getGroupNModes`, and the current
/// mode for a given group will be notified through the `gdk.EventPadGroupMode`
/// event.
pub const DevicePad = opaque {
    pub const Prerequisites = [_]type{gdk.Device};
    pub const Iface = gdk.DevicePadInterface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the group the given `feature` and `idx` belong to,
    /// or -1 if feature/index do not exist in `pad`.
    extern fn gdk_device_pad_get_feature_group(p_pad: *DevicePad, p_feature: gdk.DevicePadFeature, p_feature_idx: c_int) c_int;
    pub const getFeatureGroup = gdk_device_pad_get_feature_group;

    /// Returns the number of modes that `group` may have.
    extern fn gdk_device_pad_get_group_n_modes(p_pad: *DevicePad, p_group_idx: c_int) c_int;
    pub const getGroupNModes = gdk_device_pad_get_group_n_modes;

    /// Returns the number of features a tablet pad has.
    extern fn gdk_device_pad_get_n_features(p_pad: *DevicePad, p_feature: gdk.DevicePadFeature) c_int;
    pub const getNFeatures = gdk_device_pad_get_n_features;

    /// Returns the number of groups this pad device has. Pads have
    /// at least one group. A pad group is a subcollection of
    /// buttons/strip/rings that is affected collectively by a same
    /// current mode.
    extern fn gdk_device_pad_get_n_groups(p_pad: *DevicePad) c_int;
    pub const getNGroups = gdk_device_pad_get_n_groups;

    extern fn gdk_device_pad_get_type() usize;
    pub const getGObjectType = gdk_device_pad_get_type;

    extern fn g_object_ref(p_self: *gdk.DevicePad) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gdk.DevicePad) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DevicePad, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An opaque type representing a string as an index into a table
/// of strings on the X server.
pub const Atom = *opaque {
    /// Finds or creates an atom corresponding to a given string.
    extern fn gdk_atom_intern(p_atom_name: [*:0]const u8, p_only_if_exists: c_int) gdk.Atom;
    pub const intern = gdk_atom_intern;

    /// Finds or creates an atom corresponding to a given string.
    ///
    /// Note that this function is identical to `gdk.atomIntern` except
    /// that if a new `gdk.Atom` is created the string itself is used rather
    /// than a copy. This saves memory, but can only be used if the string
    /// will always exist. It can be used with statically
    /// allocated strings in the main program, but not with statically
    /// allocated memory in dynamically loaded modules, if you expect to
    /// ever unload the module again (e.g. do not use this function in
    /// GTK+ theme engines).
    extern fn gdk_atom_intern_static_string(p_atom_name: [*:0]const u8) gdk.Atom;
    pub const internStaticString = gdk_atom_intern_static_string;

    /// Determines the string corresponding to an atom.
    extern fn gdk_atom_name(p_atom: Atom) [*:0]u8;
    pub const name = gdk_atom_name;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.Color` is used to describe a color,
/// similar to the XColor struct used in the X11 drawing API.
pub const Color = extern struct {
    /// For allocated colors, the pixel value used to
    ///     draw this color on the screen. Not used anymore.
    f_pixel: u32,
    /// The red component of the color. This is
    ///     a value between 0 and 65535, with 65535 indicating
    ///     full intensity
    f_red: u16,
    /// The green component of the color
    f_green: u16,
    /// The blue component of the color
    f_blue: u16,

    /// Parses a textual specification of a color and fill in the
    /// `red`, `green`, and `blue` fields of a `gdk.Color`.
    ///
    /// The string can either one of a large set of standard names
    /// (taken from the X11 `rgb.txt` file), or it can be a hexadecimal
    /// value in the form “\#rgb” “\#rrggbb”, “\#rrrgggbbb” or
    /// “\#rrrrggggbbbb” where “r”, “g” and “b” are hex digits of
    /// the red, green, and blue components of the color, respectively.
    /// (White in the four forms is “\#fff”, “\#ffffff”, “\#fffffffff”
    /// and “\#ffffffffffff”).
    extern fn gdk_color_parse(p_spec: [*:0]const u8, p_color: *gdk.Color) c_int;
    pub const parse = gdk_color_parse;

    /// Makes a copy of a `gdk.Color`.
    ///
    /// The result must be freed using `gdk.Color.free`.
    extern fn gdk_color_copy(p_color: *const Color) *gdk.Color;
    pub const copy = gdk_color_copy;

    /// Compares two colors.
    extern fn gdk_color_equal(p_colora: *const Color, p_colorb: *const gdk.Color) c_int;
    pub const equal = gdk_color_equal;

    /// Frees a `gdk.Color` created with `gdk.Color.copy`.
    extern fn gdk_color_free(p_color: *Color) void;
    pub const free = gdk_color_free;

    /// A hash function suitable for using for a hash
    /// table that stores `GdkColors`.
    extern fn gdk_color_hash(p_color: *const Color) c_uint;
    pub const hash = gdk_color_hash;

    /// Returns a textual specification of `color` in the hexadecimal
    /// form “\#rrrrggggbbbb” where “r”, “g” and “b” are hex digits
    /// representing the red, green and blue components respectively.
    ///
    /// The returned string can be parsed by `gdk.colorParse`.
    extern fn gdk_color_to_string(p_color: *const Color) [*:0]u8;
    pub const toString = gdk_color_to_string;

    extern fn gdk_color_get_type() usize;
    pub const getGObjectType = gdk_color_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DevicePadInterface = opaque {
    pub const Instance = gdk.DevicePad;

    pub fn as(p_instance: *DevicePadInterface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawingContextClass = opaque {
    pub const Instance = gdk.DrawingContext;

    pub fn as(p_instance: *DrawingContextClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Contains the fields which are common to all event structs.
/// Any event pointer can safely be cast to a pointer to a `gdk.EventAny` to
/// access these fields.
pub const EventAny = extern struct {
    /// the type of the event.
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used for button press and button release events. The
/// `type` field will be one of `GDK_BUTTON_PRESS`,
/// `GDK_2BUTTON_PRESS`, `GDK_3BUTTON_PRESS` or `GDK_BUTTON_RELEASE`,
///
/// Double and triple-clicks result in a sequence of events being received.
/// For double-clicks the order of events will be:
///
/// - `GDK_BUTTON_PRESS`
/// - `GDK_BUTTON_RELEASE`
/// - `GDK_BUTTON_PRESS`
/// - `GDK_2BUTTON_PRESS`
/// - `GDK_BUTTON_RELEASE`
///
/// Note that the first click is received just like a normal
/// button press, while the second click results in a `GDK_2BUTTON_PRESS`
/// being received just after the `GDK_BUTTON_PRESS`.
///
/// Triple-clicks are very similar to double-clicks, except that
/// `GDK_3BUTTON_PRESS` is inserted after the third click. The order of the
/// events is:
///
/// - `GDK_BUTTON_PRESS`
/// - `GDK_BUTTON_RELEASE`
/// - `GDK_BUTTON_PRESS`
/// - `GDK_2BUTTON_PRESS`
/// - `GDK_BUTTON_RELEASE`
/// - `GDK_BUTTON_PRESS`
/// - `GDK_3BUTTON_PRESS`
/// - `GDK_BUTTON_RELEASE`
///
/// For a double click to occur, the second button press must occur within
/// 1/4 of a second of the first. For a triple click to occur, the third
/// button press must also occur within 1/2 second of the first button press.
pub const EventButton = extern struct {
    /// the type of the event (`GDK_BUTTON_PRESS`, `GDK_2BUTTON_PRESS`,
    ///   `GDK_3BUTTON_PRESS` or `GDK_BUTTON_RELEASE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the window.
    f_x: f64,
    /// the y coordinate of the pointer relative to the window.
    f_y: f64,
    /// `x`, `y` translated to the axes of `device`, or `NULL` if `device` is
    ///   the mouse.
    f_axes: ?*f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,
    /// the button which was pressed or released, numbered from 1 to 5.
    ///   Normally button 1 is the left mouse button, 2 is the middle button,
    ///   and 3 is the right button. On 2-button mice, the middle button can
    ///   often be simulated by pressing both mouse buttons together.
    f_button: c_uint,
    /// the master device that the event originated from. Use
    /// `gdk.Event.getSourceDevice` to get the slave device.
    f_device: ?*gdk.Device,
    /// the x coordinate of the pointer relative to the root of the
    ///   screen.
    f_x_root: f64,
    /// the y coordinate of the pointer relative to the root of the
    ///   screen.
    f_y_root: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when a window size or position has changed.
pub const EventConfigure = extern struct {
    /// the type of the event (`GDK_CONFIGURE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the new x coordinate of the window, relative to its parent.
    f_x: c_int,
    /// the new y coordinate of the window, relative to its parent.
    f_y: c_int,
    /// the new width of the window.
    f_width: c_int,
    /// the new height of the window.
    f_height: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when the pointer enters or leaves a window.
pub const EventCrossing = extern struct {
    /// the type of the event (`GDK_ENTER_NOTIFY` or `GDK_LEAVE_NOTIFY`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the window that was entered or left.
    f_subwindow: ?*gdk.Window,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the window.
    f_x: f64,
    /// the y coordinate of the pointer relative to the window.
    f_y: f64,
    /// the x coordinate of the pointer relative to the root of the screen.
    f_x_root: f64,
    /// the y coordinate of the pointer relative to the root of the screen.
    f_y_root: f64,
    /// the crossing mode (`GDK_CROSSING_NORMAL`, `GDK_CROSSING_GRAB`,
    ///  `GDK_CROSSING_UNGRAB`, `GDK_CROSSING_GTK_GRAB`, `GDK_CROSSING_GTK_UNGRAB` or
    ///  `GDK_CROSSING_STATE_CHANGED`).  `GDK_CROSSING_GTK_GRAB`, `GDK_CROSSING_GTK_UNGRAB`,
    ///  and `GDK_CROSSING_STATE_CHANGED` were added in 2.14 and are always synthesized,
    ///  never native.
    f_mode: gdk.CrossingMode,
    /// the kind of crossing that happened (`GDK_NOTIFY_INFERIOR`,
    ///  `GDK_NOTIFY_ANCESTOR`, `GDK_NOTIFY_VIRTUAL`, `GDK_NOTIFY_NONLINEAR` or
    ///  `GDK_NOTIFY_NONLINEAR_VIRTUAL`).
    f_detail: gdk.NotifyType,
    /// `TRUE` if `window` is the focus window or an inferior.
    f_focus: c_int,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during DND operations.
pub const EventDND = extern struct {
    /// the type of the event (`GDK_DRAG_ENTER`, `GDK_DRAG_LEAVE`,
    ///   `GDK_DRAG_MOTION`, `GDK_DRAG_STATUS`, `GDK_DROP_START` or
    ///   `GDK_DROP_FINISHED`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the `gdk.DragContext` for the current DND operation.
    f_context: ?*gdk.DragContext,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the root of the
    ///   screen, only set for `GDK_DRAG_MOTION` and `GDK_DROP_START`.
    f_x_root: c_short,
    /// the y coordinate of the pointer relative to the root of the
    ///   screen, only set for `GDK_DRAG_MOTION` and `GDK_DROP_START`.
    f_y_root: c_short,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when all or part of a window becomes visible and needs to be
/// redrawn.
pub const EventExpose = extern struct {
    /// the type of the event (`GDK_EXPOSE` or `GDK_DAMAGE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// bounding box of `region`.
    f_area: gdk.Rectangle,
    /// the region that needs to be redrawn.
    f_region: ?*cairo.Region,
    /// the number of contiguous `GDK_EXPOSE` events following this one.
    ///   The only use for this is “exposure compression”, i.e. handling all
    ///   contiguous `GDK_EXPOSE` events in one go, though GDK performs some
    ///   exposure compression so this is not normally needed.
    f_count: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a change of keyboard focus.
pub const EventFocus = extern struct {
    /// the type of the event (`GDK_FOCUS_CHANGE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// `TRUE` if the window has gained the keyboard focus, `FALSE` if
    ///   it has lost the focus.
    f_in: i16,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when a pointer or keyboard grab is broken. On X11, this happens
/// when the grab window becomes unviewable (i.e. it or one of its ancestors
/// is unmapped), or if the same application grabs the pointer or keyboard
/// again. Note that implicit grabs (which are initiated by button presses)
/// can also cause `gdk.EventGrabBroken` events.
pub const EventGrabBroken = extern struct {
    /// the type of the event (`GDK_GRAB_BROKEN`)
    f_type: gdk.EventType,
    /// the window which received the event, i.e. the window
    ///   that previously owned the grab
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// `TRUE` if a keyboard grab was broken, `FALSE` if a pointer
    ///   grab was broken
    f_keyboard: c_int,
    /// `TRUE` if the broken grab was implicit
    f_implicit: c_int,
    /// If this event is caused by another grab in the same
    ///   application, `grab_window` contains the new grab window. Otherwise
    ///   `grab_window` is `NULL`.
    f_grab_window: ?*gdk.Window,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a key press or key release event.
pub const EventKey = extern struct {
    /// the type of the event (`GDK_KEY_PRESS` or `GDK_KEY_RELEASE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,
    /// the key that was pressed or released. See the
    ///   `gdk/gdkkeysyms.h` header file for a
    ///   complete list of GDK key codes.
    f_keyval: c_uint,
    /// the length of `string`.
    f_length: c_int,
    /// a string containing an approximation of the text that
    ///   would result from this keypress. The only correct way to handle text
    ///   input of text is using input methods (see `GtkIMContext`), so this
    ///   field is deprecated and should never be used.
    ///   (`gdk.unicodeToKeyval` provides a non-deprecated way of getting
    ///   an approximate translation for a key.) The string is encoded in the
    ///   encoding of the current locale (Note: this for backwards compatibility:
    ///   strings in GTK+ and GDK are typically in UTF-8.) and NUL-terminated.
    ///   In some cases, the translation of the key code will be a single
    ///   NUL byte, in which case looking at `length` is necessary to distinguish
    ///   it from the an empty translation.
    f_string: ?[*:0]u8,
    /// the raw code of the key that was pressed or released.
    f_hardware_keycode: u16,
    /// the keyboard group.
    f_group: u8,
    bitfields0: packed struct(c_uint) {
        /// a flag that indicates if `hardware_keycode` is mapped to a
        ///   modifier. Since 2.10
        f_is_modifier: u1,
        _: u31,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when the pointer moves.
pub const EventMotion = extern struct {
    /// the type of the event.
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the window.
    f_x: f64,
    /// the y coordinate of the pointer relative to the window.
    f_y: f64,
    /// `x`, `y` translated to the axes of `device`, or `NULL` if `device` is
    ///   the mouse.
    f_axes: ?*f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,
    /// set to 1 if this event is just a hint, see the
    ///   `GDK_POINTER_MOTION_HINT_MASK` value of `gdk.EventMask`.
    f_is_hint: i16,
    /// the master device that the event originated from. Use
    /// `gdk.Event.getSourceDevice` to get the slave device.
    f_device: ?*gdk.Device,
    /// the x coordinate of the pointer relative to the root of the
    ///   screen.
    f_x_root: f64,
    /// the y coordinate of the pointer relative to the root of the
    ///   screen.
    f_y_root: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when the owner of a selection changes. On X11, this
/// information is only available if the X server supports the XFIXES
/// extension.
pub const EventOwnerChange = extern struct {
    /// the type of the event (`GDK_OWNER_CHANGE`).
    f_type: gdk.EventType,
    /// the window which received the event
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the new owner of the selection, or `NULL` if there is none
    f_owner: ?*gdk.Window,
    /// the reason for the ownership change as a `gdk.OwnerChange` value
    f_reason: gdk.OwnerChange,
    /// the atom identifying the selection
    f_selection: ?gdk.Atom,
    /// the timestamp of the event
    f_time: u32,
    /// the time at which the selection ownership was taken
    ///   over
    f_selection_time: u32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during `GDK_SOURCE_TABLET_PAD` interaction with tactile sensors.
pub const EventPadAxis = extern struct {
    /// the type of the event (`GDK_PAD_RING` or `GDK_PAD_STRIP`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the pad group the ring/strip belongs to. A `GDK_SOURCE_TABLET_PAD`
    ///   device may have one or more groups containing a set of buttons/rings/strips
    ///   each.
    f_group: c_uint,
    /// number of strip/ring that was interacted. This number is 0-indexed.
    f_index: c_uint,
    /// The current mode of `group`. Different groups in a `GDK_SOURCE_TABLET_PAD`
    ///   device may have different current modes.
    f_mode: c_uint,
    /// The current value for the given axis.
    f_value: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during `GDK_SOURCE_TABLET_PAD` button presses and releases.
pub const EventPadButton = extern struct {
    /// the type of the event (`GDK_PAD_BUTTON_PRESS` or `GDK_PAD_BUTTON_RELEASE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the pad group the button belongs to. A `GDK_SOURCE_TABLET_PAD` device
    ///   may have one or more groups containing a set of buttons/rings/strips each.
    f_group: c_uint,
    /// The pad button that was pressed.
    f_button: c_uint,
    /// The current mode of `group`. Different groups in a `GDK_SOURCE_TABLET_PAD`
    ///   device may have different current modes.
    f_mode: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during `GDK_SOURCE_TABLET_PAD` mode switches in a group.
pub const EventPadGroupMode = extern struct {
    /// the type of the event (`GDK_PAD_GROUP_MODE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the pad group that is switching mode. A `GDK_SOURCE_TABLET_PAD`
    ///   device may have one or more groups containing a set of buttons/rings/strips
    ///   each.
    f_group: c_uint,
    /// The new mode of `group`. Different groups in a `GDK_SOURCE_TABLET_PAD`
    ///   device may have different current modes.
    f_mode: c_uint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes a property change on a window.
pub const EventProperty = extern struct {
    /// the type of the event (`GDK_PROPERTY_NOTIFY`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the property that was changed.
    f_atom: ?gdk.Atom,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// whether the property was changed
    ///   (`GDK_PROPERTY_NEW_VALUE`) or deleted (`GDK_PROPERTY_DELETE`).
    f_state: gdk.PropertyState,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Proximity events are generated when using GDK’s wrapper for the
/// XInput extension. The XInput extension is an add-on for standard X
/// that allows you to use nonstandard devices such as graphics tablets.
/// A proximity event indicates that the stylus has moved in or out of
/// contact with the tablet, or perhaps that the user’s finger has moved
/// in or out of contact with a touch screen.
///
/// This event type will be used pretty rarely. It only is important for
/// XInput aware programs that are drawing their own cursor.
pub const EventProximity = extern struct {
    /// the type of the event (`GDK_PROXIMITY_IN` or `GDK_PROXIMITY_OUT`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the master device that the event originated from. Use
    /// `gdk.Event.getSourceDevice` to get the slave device.
    f_device: ?*gdk.Device,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated from button presses for the buttons 4 to 7. Wheel mice are
/// usually configured to generate button press events for buttons 4 and 5
/// when the wheel is turned.
///
/// Some GDK backends can also generate “smooth” scroll events, which
/// can be recognized by the `GDK_SCROLL_SMOOTH` scroll direction. For
/// these, the scroll deltas can be obtained with
/// `gdk.Event.getScrollDeltas`.
pub const EventScroll = extern struct {
    /// the type of the event (`GDK_SCROLL`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the window.
    f_x: f64,
    /// the y coordinate of the pointer relative to the window.
    f_y: f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,
    /// the direction to scroll to (one of `GDK_SCROLL_UP`,
    ///   `GDK_SCROLL_DOWN`, `GDK_SCROLL_LEFT`, `GDK_SCROLL_RIGHT` or
    ///   `GDK_SCROLL_SMOOTH`).
    f_direction: gdk.ScrollDirection,
    /// the master device that the event originated from. Use
    /// `gdk.Event.getSourceDevice` to get the slave device.
    f_device: ?*gdk.Device,
    /// the x coordinate of the pointer relative to the root of the
    ///   screen.
    f_x_root: f64,
    /// the y coordinate of the pointer relative to the root of the
    ///   screen.
    f_y_root: f64,
    /// the x coordinate of the scroll delta
    f_delta_x: f64,
    /// the y coordinate of the scroll delta
    f_delta_y: f64,
    bitfields0: packed struct(c_uint) {
        f_is_stop: u1,
        _: u31,
    },

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when a selection is requested or ownership of a selection
/// is taken over by another client application.
pub const EventSelection = extern struct {
    /// the type of the event (`GDK_SELECTION_CLEAR`,
    ///   `GDK_SELECTION_NOTIFY` or `GDK_SELECTION_REQUEST`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the selection.
    f_selection: ?gdk.Atom,
    /// the target to which the selection should be converted.
    f_target: ?gdk.Atom,
    /// the property in which to place the result of the conversion.
    f_property: ?gdk.Atom,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the window on which to place `property` or `NULL` if none.
    f_requestor: ?*gdk.Window,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EventSequence = opaque {
    extern fn gdk_event_sequence_get_type() usize;
    pub const getGObjectType = gdk_event_sequence_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when a setting is modified.
pub const EventSetting = extern struct {
    /// the type of the event (`GDK_SETTING`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// what happened to the setting (`GDK_SETTING_ACTION_NEW`,
    ///   `GDK_SETTING_ACTION_CHANGED` or `GDK_SETTING_ACTION_DELETED`).
    f_action: gdk.SettingAction,
    /// the name of the setting.
    f_name: ?[*:0]u8,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used for touch events.
/// `type` field will be one of `GDK_TOUCH_BEGIN`, `GDK_TOUCH_UPDATE`,
/// `GDK_TOUCH_END` or `GDK_TOUCH_CANCEL`.
///
/// Touch events are grouped into sequences by means of the `sequence`
/// field, which can also be obtained with `gdk.Event.getEventSequence`.
/// Each sequence begins with a `GDK_TOUCH_BEGIN` event, followed by
/// any number of `GDK_TOUCH_UPDATE` events, and ends with a `GDK_TOUCH_END`
/// (or `GDK_TOUCH_CANCEL`) event. With multitouch devices, there may be
/// several active sequences at the same time.
pub const EventTouch = extern struct {
    /// the type of the event (`GDK_TOUCH_BEGIN`, `GDK_TOUCH_UPDATE`,
    ///   `GDK_TOUCH_END`, `GDK_TOUCH_CANCEL`)
    f_type: gdk.EventType,
    /// the window which received the event
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the time of the event in milliseconds.
    f_time: u32,
    /// the x coordinate of the pointer relative to the window
    f_x: f64,
    /// the y coordinate of the pointer relative to the window
    f_y: f64,
    /// `x`, `y` translated to the axes of `device`, or `NULL` if `device` is
    ///   the mouse
    f_axes: ?*f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`
    f_state: gdk.ModifierType,
    /// the event sequence that the event belongs to
    f_sequence: ?*gdk.EventSequence,
    /// whether the event should be used for emulating
    ///   pointer event
    f_emulating_pointer: c_int,
    /// the master device that the event originated from. Use
    /// `gdk.Event.getSourceDevice` to get the slave device.
    f_device: ?*gdk.Device,
    /// the x coordinate of the pointer relative to the root of the
    ///   screen
    f_x_root: f64,
    /// the y coordinate of the pointer relative to the root of the
    ///   screen
    f_y_root: f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during touchpad swipe gestures.
pub const EventTouchpadPinch = extern struct {
    /// the type of the event (`GDK_TOUCHPAD_PINCH`)
    f_type: gdk.EventType,
    /// the window which received the event
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly
    f_send_event: i8,
    /// the current phase of the gesture
    f_phase: i8,
    /// The number of fingers triggering the pinch
    f_n_fingers: i8,
    /// the time of the event in milliseconds
    f_time: u32,
    /// The X coordinate of the pointer
    f_x: f64,
    /// The Y coordinate of the pointer
    f_y: f64,
    /// Movement delta in the X axis of the swipe focal point
    f_dx: f64,
    /// Movement delta in the Y axis of the swipe focal point
    f_dy: f64,
    /// The angle change in radians, negative angles
    ///   denote counter-clockwise movements
    f_angle_delta: f64,
    /// The current scale, relative to that at the time of
    ///   the corresponding `GDK_TOUCHPAD_GESTURE_PHASE_BEGIN` event
    f_scale: f64,
    /// The X coordinate of the pointer, relative to the
    ///   root of the screen.
    f_x_root: f64,
    /// The Y coordinate of the pointer, relative to the
    ///   root of the screen.
    f_y_root: f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated during touchpad swipe gestures.
pub const EventTouchpadSwipe = extern struct {
    /// the type of the event (`GDK_TOUCHPAD_SWIPE`)
    f_type: gdk.EventType,
    /// the window which received the event
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly
    f_send_event: i8,
    /// the current phase of the gesture
    f_phase: i8,
    /// The number of fingers triggering the swipe
    f_n_fingers: i8,
    /// the time of the event in milliseconds
    f_time: u32,
    /// The X coordinate of the pointer
    f_x: f64,
    /// The Y coordinate of the pointer
    f_y: f64,
    /// Movement delta in the X axis of the swipe focal point
    f_dx: f64,
    /// Movement delta in the Y axis of the swipe focal point
    f_dy: f64,
    /// The X coordinate of the pointer, relative to the
    ///   root of the screen.
    f_x_root: f64,
    /// The Y coordinate of the pointer, relative to the
    ///   root of the screen.
    f_y_root: f64,
    /// a bit-mask representing the state of
    ///   the modifier keys (e.g. Control, Shift and Alt) and the pointer
    ///   buttons. See `gdk.ModifierType`.
    f_state: gdk.ModifierType,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when the window visibility status has changed.
pub const EventVisibility = extern struct {
    /// the type of the event (`GDK_VISIBILITY_NOTIFY`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// the new visibility state (`GDK_VISIBILITY_FULLY_OBSCURED`,
    ///   `GDK_VISIBILITY_PARTIAL` or `GDK_VISIBILITY_UNOBSCURED`).
    f_state: gdk.VisibilityState,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Generated when the state of a toplevel window changes.
pub const EventWindowState = extern struct {
    /// the type of the event (`GDK_WINDOW_STATE`).
    f_type: gdk.EventType,
    /// the window which received the event.
    f_window: ?*gdk.Window,
    /// `TRUE` if the event was sent explicitly.
    f_send_event: i8,
    /// mask specifying what flags have changed.
    f_changed_mask: gdk.WindowState,
    /// the new window state, a combination of
    ///   `gdk.WindowState` bits.
    f_new_window_state: gdk.WindowState,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClockClass = opaque {
    pub const Instance = gdk.FrameClock;

    pub fn as(p_instance: *FrameClockClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClockPrivate = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.FrameTimings` object holds timing information for a single frame
/// of the application’s displays. To retrieve `gdk.FrameTimings` objects,
/// use `gdk.FrameClock.getTimings` or `gdk.FrameClock.getCurrentTimings`.
/// The information in `gdk.FrameTimings` is useful for precise synchronization
/// of video with the event or audio streams, and for measuring
/// quality metrics for the application’s display, such as latency and jitter.
pub const FrameTimings = opaque {
    /// The timing information in a `gdk.FrameTimings` is filled in
    /// incrementally as the frame as drawn and passed off to the
    /// window system for processing and display to the user. The
    /// accessor functions for `gdk.FrameTimings` can return 0 to
    /// indicate an unavailable value for two reasons: either because
    /// the information is not yet available, or because it isn't
    /// available at all. Once `gdk.FrameTimings.getComplete` returns
    /// `TRUE` for a frame, you can be certain that no further values
    /// will become available and be stored in the `gdk.FrameTimings`.
    extern fn gdk_frame_timings_get_complete(p_timings: *FrameTimings) c_int;
    pub const getComplete = gdk_frame_timings_get_complete;

    /// Gets the frame counter value of the `gdk.FrameClock` when this
    /// this frame was drawn.
    extern fn gdk_frame_timings_get_frame_counter(p_timings: *FrameTimings) i64;
    pub const getFrameCounter = gdk_frame_timings_get_frame_counter;

    /// Returns the frame time for the frame. This is the time value
    /// that is typically used to time animations for the frame. See
    /// `gdk.FrameClock.getFrameTime`.
    extern fn gdk_frame_timings_get_frame_time(p_timings: *FrameTimings) i64;
    pub const getFrameTime = gdk_frame_timings_get_frame_time;

    /// Gets the predicted time at which this frame will be displayed. Although
    /// no predicted time may be available, if one is available, it will
    /// be available while the frame is being generated, in contrast to
    /// `gdk.FrameTimings.getPresentationTime`, which is only available
    /// after the frame has been presented. In general, if you are simply
    /// animating, you should use `gdk.FrameClock.getFrameTime` rather
    /// than this function, but this function is useful for applications
    /// that want exact control over latency. For example, a movie player
    /// may want this information for Audio/Video synchronization.
    extern fn gdk_frame_timings_get_predicted_presentation_time(p_timings: *FrameTimings) i64;
    pub const getPredictedPresentationTime = gdk_frame_timings_get_predicted_presentation_time;

    /// Reurns the presentation time. This is the time at which the frame
    /// became visible to the user.
    extern fn gdk_frame_timings_get_presentation_time(p_timings: *FrameTimings) i64;
    pub const getPresentationTime = gdk_frame_timings_get_presentation_time;

    /// Gets the natural interval between presentation times for
    /// the display that this frame was displayed on. Frame presentation
    /// usually happens during the “vertical blanking interval”.
    extern fn gdk_frame_timings_get_refresh_interval(p_timings: *FrameTimings) i64;
    pub const getRefreshInterval = gdk_frame_timings_get_refresh_interval;

    /// Increases the reference count of `timings`.
    extern fn gdk_frame_timings_ref(p_timings: *FrameTimings) *gdk.FrameTimings;
    pub const ref = gdk_frame_timings_ref;

    /// Decreases the reference count of `timings`. If `timings`
    /// is no longer referenced, it will be freed.
    extern fn gdk_frame_timings_unref(p_timings: *FrameTimings) void;
    pub const unref = gdk_frame_timings_unref;

    extern fn gdk_frame_timings_get_type() usize;
    pub const getGObjectType = gdk_frame_timings_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `gdk.Geometry` struct gives the window manager information about
/// a window’s geometry constraints. Normally you would set these on
/// the GTK+ level using `gtk_window_set_geometry_hints`. `GtkWindow`
/// then sets the hints on the `gdk.Window` it creates.
///
/// `gdk.Window.setGeometryHints` expects the hints to be fully valid already
/// and simply passes them to the window manager; in contrast,
/// `gtk_window_set_geometry_hints` performs some interpretation. For example,
/// `GtkWindow` will apply the hints to the geometry widget instead of the
/// toplevel window, if you set a geometry widget. Also, the
/// `min_width`/`min_height`/`max_width`/`max_height` fields may be set to -1, and
/// `GtkWindow` will substitute the size request of the window or geometry widget.
/// If the minimum size hint is not provided, `GtkWindow` will use its requisition
/// as the minimum size. If the minimum size is provided and a geometry widget is
/// set, `GtkWindow` will take the minimum size as the minimum size of the
/// geometry widget rather than the entire window. The base size is treated
/// similarly.
///
/// The canonical use-case for `gtk_window_set_geometry_hints` is to get a
/// terminal widget to resize properly. Here, the terminal text area should be
/// the geometry widget; `GtkWindow` will then automatically set the base size to
/// the size of other widgets in the terminal window, such as the menubar and
/// scrollbar. Then, the `width_inc` and `height_inc` fields should be set to the
/// size of one character in the terminal. Finally, the base size should be set
/// to the size of one character. The net effect is that the minimum size of the
/// terminal will have a 1x1 character terminal area, and only terminal sizes on
/// the “character grid” will be allowed.
///
/// Here’s an example of how the terminal example would be implemented, assuming
/// a terminal area widget called “terminal” and a toplevel window “toplevel”:
///
/// ```
///     GdkGeometry hints;
///
///     hints.base_width = terminal->char_width;
///         hints.base_height = terminal->char_height;
///         hints.min_width = terminal->char_width;
///         hints.min_height = terminal->char_height;
///         hints.width_inc = terminal->char_width;
///         hints.height_inc = terminal->char_height;
///
///  gtk_window_set_geometry_hints (GTK_WINDOW (toplevel),
///                                 GTK_WIDGET (terminal),
///                                 &hints,
///                                 GDK_HINT_RESIZE_INC |
///                                 GDK_HINT_MIN_SIZE |
///                                 GDK_HINT_BASE_SIZE);
/// ```
///
/// The other useful fields are the `min_aspect` and `max_aspect` fields; these
/// contain a width/height ratio as a floating point number. If a geometry widget
/// is set, the aspect applies to the geometry widget rather than the entire
/// window. The most common use of these hints is probably to set `min_aspect` and
/// `max_aspect` to the same value, thus forcing the window to keep a constant
/// aspect ratio.
pub const Geometry = extern struct {
    /// minimum width of window (or -1 to use requisition, with
    ///  `GtkWindow` only)
    f_min_width: c_int,
    /// minimum height of window (or -1 to use requisition, with
    ///  `GtkWindow` only)
    f_min_height: c_int,
    /// maximum width of window (or -1 to use requisition, with
    ///  `GtkWindow` only)
    f_max_width: c_int,
    /// maximum height of window (or -1 to use requisition, with
    ///  `GtkWindow` only)
    f_max_height: c_int,
    /// allowed window widths are `base_width` + `width_inc` * N where N
    ///  is any integer (-1 allowed with `GtkWindow`)
    f_base_width: c_int,
    /// allowed window widths are `base_height` + `height_inc` * N where
    ///  N is any integer (-1 allowed with `GtkWindow`)
    f_base_height: c_int,
    /// width resize increment
    f_width_inc: c_int,
    /// height resize increment
    f_height_inc: c_int,
    /// minimum width/height ratio
    f_min_aspect: f64,
    /// maximum width/height ratio
    f_max_aspect: f64,
    /// window gravity, see `gtk_window_set_gravity`
    f_win_gravity: gdk.Gravity,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.KeymapKey` is a hardware key that can be mapped to a keyval.
pub const KeymapKey = extern struct {
    /// the hardware keycode. This is an identifying number for a
    ///   physical key.
    f_keycode: c_uint,
    /// indicates movement in a horizontal direction. Usually groups are used
    ///   for two different languages. In group 0, a key might have two English
    ///   characters, and in group 1 it might have two Hebrew characters. The Hebrew
    ///   characters will be printed on the key next to the English characters.
    f_group: c_int,
    /// indicates which symbol on the key will be used, in a vertical direction.
    ///   So on a standard US keyboard, the key with the number “1” on it also has the
    ///   exclamation point ("!") character on it. The level indicates whether to use
    ///   the “1” or the “!” symbol. The letter keys are considered to have a lowercase
    ///   letter at level 0, and an uppercase letter at level 1, though only the
    ///   uppercase letter is printed.
    f_level: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MonitorClass = opaque {
    pub const Instance = gdk.Monitor;

    pub fn as(p_instance: *MonitorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the x and y coordinates of a point.
pub const Point = extern struct {
    /// the x coordinate of the point.
    f_x: c_int,
    /// the y coordinate of the point.
    f_y: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.RGBA` is used to represent a (possibly translucent)
/// color, in a way that is compatible with cairo’s notion of color.
pub const RGBA = extern struct {
    /// The intensity of the red channel from 0.0 to 1.0 inclusive
    f_red: f64,
    /// The intensity of the green channel from 0.0 to 1.0 inclusive
    f_green: f64,
    /// The intensity of the blue channel from 0.0 to 1.0 inclusive
    f_blue: f64,
    /// The opacity of the color from 0.0 for completely translucent to
    ///   1.0 for opaque
    f_alpha: f64,

    /// Makes a copy of a `gdk.RGBA`.
    ///
    /// The result must be freed through `gdk.RGBA.free`.
    extern fn gdk_rgba_copy(p_rgba: *const RGBA) *gdk.RGBA;
    pub const copy = gdk_rgba_copy;

    /// Compares two RGBA colors.
    extern fn gdk_rgba_equal(p_p1: *const RGBA, p_p2: *const gdk.RGBA) c_int;
    pub const equal = gdk_rgba_equal;

    /// Frees a `gdk.RGBA` created with `gdk.RGBA.copy`
    extern fn gdk_rgba_free(p_rgba: *RGBA) void;
    pub const free = gdk_rgba_free;

    /// A hash function suitable for using for a hash
    /// table that stores `GdkRGBAs`.
    extern fn gdk_rgba_hash(p_p: *const RGBA) c_uint;
    pub const hash = gdk_rgba_hash;

    /// Parses a textual representation of a color, filling in
    /// the `red`, `green`, `blue` and `alpha` fields of the `rgba` `gdk.RGBA`.
    ///
    /// The string can be either one of:
    /// - A standard name (Taken from the X11 rgb.txt file).
    /// - A hexadecimal value in the form “\#rgb”, “\#rrggbb”,
    ///   “\#rrrgggbbb” or ”\#rrrrggggbbbb”
    /// - A RGB color in the form “rgb(r,g,b)” (In this case the color will
    ///   have full opacity)
    /// - A RGBA color in the form “rgba(r,g,b,a)”
    ///
    /// Where “r”, “g”, “b” and “a” are respectively the red, green, blue and
    /// alpha color values. In the last two cases, “r”, “g”, and “b” are either integers
    /// in the range 0 to 255 or percentage values in the range 0% to 100%, and
    /// a is a floating point value in the range 0 to 1.
    extern fn gdk_rgba_parse(p_rgba: *RGBA, p_spec: [*:0]const u8) c_int;
    pub const parse = gdk_rgba_parse;

    /// Returns a textual specification of `rgba` in the form
    /// `rgb(r,g,b)` or
    /// `rgba(r g,b,a)`,
    /// where “r”, “g”, “b” and “a” represent the red, green,
    /// blue and alpha values respectively. “r”, “g”, and “b” are
    /// represented as integers in the range 0 to 255, and “a”
    /// is represented as a floating point value in the range 0 to 1.
    ///
    /// These string forms are string forms that are supported by
    /// the CSS3 colors module, and can be parsed by `gdk.RGBA.parse`.
    ///
    /// Note that this string representation may lose some
    /// precision, since “r”, “g” and “b” are represented as 8-bit
    /// integers. If this is a concern, you should use a
    /// different representation.
    extern fn gdk_rgba_to_string(p_rgba: *const RGBA) [*:0]u8;
    pub const toString = gdk_rgba_to_string;

    extern fn gdk_rgba_get_type() usize;
    pub const getGObjectType = gdk_rgba_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the position and size of a rectangle. It is identical to
/// `cairo.RectangleInt`.
pub const Rectangle = extern struct {
    f_x: c_int,
    f_y: c_int,
    f_width: c_int,
    f_height: c_int,

    /// Checks if the two given rectangles are equal.
    extern fn gdk_rectangle_equal(p_rect1: *const Rectangle, p_rect2: *const gdk.Rectangle) c_int;
    pub const equal = gdk_rectangle_equal;

    /// Calculates the intersection of two rectangles. It is allowed for
    /// `dest` to be the same as either `src1` or `src2`. If the rectangles
    /// do not intersect, `dest`’s width and height is set to 0 and its x
    /// and y values are undefined. If you are only interested in whether
    /// the rectangles intersect, but not in the intersecting area itself,
    /// pass `NULL` for `dest`.
    extern fn gdk_rectangle_intersect(p_src1: *const Rectangle, p_src2: *const gdk.Rectangle, p_dest: ?*gdk.Rectangle) c_int;
    pub const intersect = gdk_rectangle_intersect;

    /// Calculates the union of two rectangles.
    /// The union of rectangles `src1` and `src2` is the smallest rectangle which
    /// includes both `src1` and `src2` within it.
    /// It is allowed for `dest` to be the same as either `src1` or `src2`.
    ///
    /// Note that this function does not ignore 'empty' rectangles (ie. with
    /// zero width or height).
    extern fn gdk_rectangle_union(p_src1: *const Rectangle, p_src2: *const gdk.Rectangle, p_dest: *gdk.Rectangle) void;
    pub const @"union" = gdk_rectangle_union;

    extern fn gdk_rectangle_get_type() usize;
    pub const getGObjectType = gdk_rectangle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.TimeCoord` stores a single event in a motion history.
pub const TimeCoord = extern struct {
    /// The timestamp for this event.
    f_time: u32,
    /// the values of the device’s axes.
    f_axes: [128]f64,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Attributes to use for a newly-created window.
pub const WindowAttr = extern struct {
    /// title of the window (for toplevel windows)
    f_title: ?[*:0]u8,
    /// event mask (see `gdk.Window.setEvents`)
    f_event_mask: c_int,
    /// X coordinate relative to parent window (see `gdk.Window.move`)
    f_x: c_int,
    /// Y coordinate relative to parent window (see `gdk.Window.move`)
    f_y: c_int,
    /// width of window
    f_width: c_int,
    /// height of window
    f_height: c_int,
    /// `GDK_INPUT_OUTPUT` (normal window) or `GDK_INPUT_ONLY` (invisible
    ///  window that receives events)
    f_wclass: gdk.WindowWindowClass,
    /// `gdk.Visual` for window
    f_visual: ?*gdk.Visual,
    /// type of window
    f_window_type: gdk.WindowType,
    /// cursor for the window (see `gdk.Window.setCursor`)
    f_cursor: ?*gdk.Cursor,
    /// don’t use (see `gtk_window_set_wmclass`)
    f_wmclass_name: ?[*:0]u8,
    /// don’t use (see `gtk_window_set_wmclass`)
    f_wmclass_class: ?[*:0]u8,
    /// `TRUE` to bypass the window manager
    f_override_redirect: c_int,
    /// a hint of the function of the window
    f_type_hint: gdk.WindowTypeHint,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowClass = extern struct {
    pub const Instance = gdk.Window;

    f_parent_class: gobject.ObjectClass,
    f_pick_embedded_child: ?*const fn (p_window: *gdk.Window, p_x: f64, p_y: f64) callconv(.c) *gdk.Window,
    f_to_embedder: ?*const fn (p_window: *gdk.Window, p_offscreen_x: f64, p_offscreen_y: f64, p_embedder_x: *f64, p_embedder_y: *f64) callconv(.c) void,
    f_from_embedder: ?*const fn (p_window: *gdk.Window, p_embedder_x: f64, p_embedder_y: f64, p_offscreen_x: *f64, p_offscreen_y: *f64) callconv(.c) void,
    f_create_surface: ?*const fn (p_window: *gdk.Window, p_width: c_int, p_height: c_int) callconv(.c) *cairo.Surface,
    f__gdk_reserved1: ?*const fn () callconv(.c) void,
    f__gdk_reserved2: ?*const fn () callconv(.c) void,
    f__gdk_reserved3: ?*const fn () callconv(.c) void,
    f__gdk_reserved4: ?*const fn () callconv(.c) void,
    f__gdk_reserved5: ?*const fn () callconv(.c) void,
    f__gdk_reserved6: ?*const fn () callconv(.c) void,
    f__gdk_reserved7: ?*const fn () callconv(.c) void,
    f__gdk_reserved8: ?*const fn () callconv(.c) void,

    pub fn as(p_instance: *WindowClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowRedirect = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gdk.Event` contains a union of all of the event types,
/// and allows access to the data fields in a number of ways.
///
/// The event type is always the first field in all of the event types, and
/// can always be accessed with the following code, no matter what type of
/// event it is:
/// ```
///   GdkEvent *event;
///   GdkEventType type;
///
///   type = event->type;
/// ```
///
/// To access other fields of the event, the pointer to the event
/// can be cast to the appropriate event type, or the union member
/// name can be used. For example if the event type is `GDK_BUTTON_PRESS`
/// then the x coordinate of the button press can be accessed with:
/// ```
///   GdkEvent *event;
///   gdouble x;
///
///   x = ((GdkEventButton*)event)->x;
/// ```
/// or:
/// ```
///   GdkEvent *event;
///   gdouble x;
///
///   x = event->button.x;
/// ```
pub const Event = extern union {
    /// the `gdk.EventType`
    f_type: gdk.EventType,
    /// a `gdk.EventAny`
    f_any: gdk.EventAny,
    /// a `gdk.EventExpose`
    f_expose: gdk.EventExpose,
    /// a `gdk.EventVisibility`
    f_visibility: gdk.EventVisibility,
    /// a `gdk.EventMotion`
    f_motion: gdk.EventMotion,
    /// a `gdk.EventButton`
    f_button: gdk.EventButton,
    /// a `gdk.EventTouch`
    f_touch: gdk.EventTouch,
    /// a `gdk.EventScroll`
    f_scroll: gdk.EventScroll,
    /// a `gdk.EventKey`
    f_key: gdk.EventKey,
    /// a `gdk.EventCrossing`
    f_crossing: gdk.EventCrossing,
    /// a `gdk.EventFocus`
    f_focus_change: gdk.EventFocus,
    /// a `gdk.EventConfigure`
    f_configure: gdk.EventConfigure,
    /// a `gdk.EventProperty`
    f_property: gdk.EventProperty,
    /// a `gdk.EventSelection`
    f_selection: gdk.EventSelection,
    /// a `gdk.EventOwnerChange`
    f_owner_change: gdk.EventOwnerChange,
    /// a `gdk.EventProximity`
    f_proximity: gdk.EventProximity,
    /// a `gdk.EventDND`
    f_dnd: gdk.EventDND,
    /// a `gdk.EventWindowState`
    f_window_state: gdk.EventWindowState,
    /// a `gdk.EventSetting`
    f_setting: gdk.EventSetting,
    /// a `gdk.EventGrabBroken`
    f_grab_broken: gdk.EventGrabBroken,
    /// a `gdk.EventTouchpadSwipe`
    f_touchpad_swipe: gdk.EventTouchpadSwipe,
    /// a `gdk.EventTouchpadPinch`
    f_touchpad_pinch: gdk.EventTouchpadPinch,
    /// a `gdk.EventPadButton`
    f_pad_button: gdk.EventPadButton,
    /// a `gdk.EventPadAxis`
    f_pad_axis: gdk.EventPadAxis,
    /// a `gdk.EventPadGroupMode`
    f_pad_group_mode: gdk.EventPadGroupMode,

    /// Checks all open displays for a `gdk.Event` to process,to be processed
    /// on, fetching events from the windowing system if necessary.
    /// See `gdk.Display.getEvent`.
    extern fn gdk_event_get() ?*gdk.Event;
    pub const get = gdk_event_get;

    /// Sets the function to call to handle all events from GDK.
    ///
    /// Note that GTK+ uses this to install its own event handler, so it is
    /// usually not useful for GTK+ applications. (Although an application
    /// can call this function then call `gtk_main_do_event` to pass
    /// events to GTK+.)
    extern fn gdk_event_handler_set(p_func: gdk.EventFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) void;
    pub const handlerSet = gdk_event_handler_set;

    /// If there is an event waiting in the event queue of some open
    /// display, returns a copy of it. See `gdk.Display.peekEvent`.
    extern fn gdk_event_peek() ?*gdk.Event;
    pub const peek = gdk_event_peek;

    /// Request more motion notifies if `event` is a motion notify hint event.
    ///
    /// This function should be used instead of `gdk.Window.getPointer` to
    /// request further motion notifies, because it also works for extension
    /// events where motion notifies are provided for devices other than the
    /// core pointer. Coordinate extraction, processing and requesting more
    /// motion events from a `GDK_MOTION_NOTIFY` event usually works like this:
    ///
    /// ```
    /// {
    ///   // motion_event handler
    ///   x = motion_event->x;
    ///   y = motion_event->y;
    ///   // handle (x,y) motion
    ///   gdk_event_request_motions (motion_event); // handles is_hint events
    /// }
    /// ```
    extern fn gdk_event_request_motions(p_event: *const gdk.EventMotion) void;
    pub const requestMotions = gdk_event_request_motions;

    /// Creates a new event of the given type. All fields are set to 0.
    extern fn gdk_event_new(p_type: gdk.EventType) *gdk.Event;
    pub const new = gdk_event_new;

    /// Copies a `gdk.Event`, copying or incrementing the reference count of the
    /// resources associated with it (e.g. `gdk.Window`’s and strings).
    extern fn gdk_event_copy(p_event: *const Event) *gdk.Event;
    pub const copy = gdk_event_copy;

    /// Frees a `gdk.Event`, freeing or decrementing any resources associated with it.
    /// Note that this function should only be called with events returned from
    /// functions such as `gdk.eventPeek`, `gdk.eventGet`, `gdk.Event.copy`
    /// and `gdk.Event.new`.
    extern fn gdk_event_free(p_event: *Event) void;
    pub const free = gdk_event_free;

    /// Extract the axis value for a particular axis use from
    /// an event structure.
    extern fn gdk_event_get_axis(p_event: *const Event, p_axis_use: gdk.AxisUse, p_value: *f64) c_int;
    pub const getAxis = gdk_event_get_axis;

    /// Extract the button number from an event.
    extern fn gdk_event_get_button(p_event: *const Event, p_button: *c_uint) c_int;
    pub const getButton = gdk_event_get_button;

    /// Extracts the click count from an event.
    extern fn gdk_event_get_click_count(p_event: *const Event, p_click_count: *c_uint) c_int;
    pub const getClickCount = gdk_event_get_click_count;

    /// Extract the event window relative x/y coordinates from an event.
    extern fn gdk_event_get_coords(p_event: *const Event, p_x_win: ?*f64, p_y_win: ?*f64) c_int;
    pub const getCoords = gdk_event_get_coords;

    /// If the event contains a “device” field, this function will return
    /// it, else it will return `NULL`.
    extern fn gdk_event_get_device(p_event: *const Event) ?*gdk.Device;
    pub const getDevice = gdk_event_get_device;

    /// If the event was generated by a device that supports
    /// different tools (eg. a tablet), this function will
    /// return a `gdk.DeviceTool` representing the tool that
    /// caused the event. Otherwise, `NULL` will be returned.
    ///
    /// Note: the `gdk.DeviceTool`<!-- -->s will be constant during
    /// the application lifetime, if settings must be stored
    /// persistently across runs, see `gdk.DeviceTool.getSerial`
    extern fn gdk_event_get_device_tool(p_event: *const Event) *gdk.DeviceTool;
    pub const getDeviceTool = gdk_event_get_device_tool;

    /// If `event` if of type `GDK_TOUCH_BEGIN`, `GDK_TOUCH_UPDATE`,
    /// `GDK_TOUCH_END` or `GDK_TOUCH_CANCEL`, returns the `gdk.EventSequence`
    /// to which the event belongs. Otherwise, return `NULL`.
    extern fn gdk_event_get_event_sequence(p_event: *const Event) *gdk.EventSequence;
    pub const getEventSequence = gdk_event_get_event_sequence;

    /// Retrieves the type of the event.
    extern fn gdk_event_get_event_type(p_event: *const Event) gdk.EventType;
    pub const getEventType = gdk_event_get_event_type;

    /// Extracts the hardware keycode from an event.
    ///
    /// Also see `gdk.Event.getScancode`.
    extern fn gdk_event_get_keycode(p_event: *const Event, p_keycode: *u16) c_int;
    pub const getKeycode = gdk_event_get_keycode;

    /// Extracts the keyval from an event.
    extern fn gdk_event_get_keyval(p_event: *const Event, p_keyval: *c_uint) c_int;
    pub const getKeyval = gdk_event_get_keyval;

    /// `event`: a `gdk.Event`
    /// Returns whether this event is an 'emulated' pointer event (typically
    /// from a touch event), as opposed to a real one.
    extern fn gdk_event_get_pointer_emulated(p_event: *Event) c_int;
    pub const getPointerEmulated = gdk_event_get_pointer_emulated;

    /// Extract the root window relative x/y coordinates from an event.
    extern fn gdk_event_get_root_coords(p_event: *const Event, p_x_root: ?*f64, p_y_root: ?*f64) c_int;
    pub const getRootCoords = gdk_event_get_root_coords;

    /// Gets the keyboard low-level scancode of a key event.
    ///
    /// This is usually hardware_keycode. On Windows this is the high
    /// word of WM_KEY{DOWN,UP} lParam which contains the scancode and
    /// some extended flags.
    extern fn gdk_event_get_scancode(p_event: *Event) c_int;
    pub const getScancode = gdk_event_get_scancode;

    /// Returns the screen for the event. The screen is
    /// typically the screen for `event->any.window`, but
    /// for events such as mouse events, it is the screen
    /// where the pointer was when the event occurs -
    /// that is, the screen which has the root window
    /// to which `event->motion.x_root` and
    /// `event->motion.y_root` are relative.
    extern fn gdk_event_get_screen(p_event: *const Event) *gdk.Screen;
    pub const getScreen = gdk_event_get_screen;

    /// Retrieves the scroll deltas from a `gdk.Event`
    ///
    /// See also: `gdk.Event.getScrollDirection`
    extern fn gdk_event_get_scroll_deltas(p_event: *const Event, p_delta_x: *f64, p_delta_y: *f64) c_int;
    pub const getScrollDeltas = gdk_event_get_scroll_deltas;

    /// Extracts the scroll direction from an event.
    ///
    /// If `event` is not of type `GDK_SCROLL`, the contents of `direction`
    /// are undefined.
    ///
    /// If you wish to handle both discrete and smooth scrolling, you
    /// should check the return value of this function, or of
    /// `gdk.Event.getScrollDeltas`; for instance:
    ///
    /// ```
    ///   GdkScrollDirection direction;
    ///   double vscroll_factor = 0.0;
    ///   double x_scroll, y_scroll;
    ///
    ///   if (gdk_event_get_scroll_direction (event, &direction))
    ///     {
    ///       // Handle discrete scrolling with a known constant delta;
    ///       const double delta = 12.0;
    ///
    ///       switch (direction)
    ///         {
    ///         case GDK_SCROLL_UP:
    ///           vscroll_factor = -delta;
    ///           break;
    ///         case GDK_SCROLL_DOWN:
    ///           vscroll_factor = delta;
    ///           break;
    ///         default:
    ///           // no scrolling
    ///           break;
    ///         }
    ///     }
    ///   else if (gdk_event_get_scroll_deltas (event, &x_scroll, &y_scroll))
    ///     {
    ///       // Handle smooth scrolling directly
    ///       vscroll_factor = y_scroll;
    ///     }
    /// ```
    extern fn gdk_event_get_scroll_direction(p_event: *const Event, p_direction: *gdk.ScrollDirection) c_int;
    pub const getScrollDirection = gdk_event_get_scroll_direction;

    /// Returns the `gdk.Seat` this event was generated for.
    extern fn gdk_event_get_seat(p_event: *const Event) *gdk.Seat;
    pub const getSeat = gdk_event_get_seat;

    /// This function returns the hardware (slave) `gdk.Device` that has
    /// triggered the event, falling back to the virtual (master) device
    /// (as in `gdk.Event.getDevice`) if the event wasn’t caused by
    /// interaction with a hardware device. This may happen for example
    /// in synthesized crossing events after a `gdk.Window` updates its
    /// geometry or a grab is acquired/released.
    ///
    /// If the event does not contain a device field, this function will
    /// return `NULL`.
    extern fn gdk_event_get_source_device(p_event: *const Event) ?*gdk.Device;
    pub const getSourceDevice = gdk_event_get_source_device;

    /// If the event contains a “state” field, puts that field in `state`. Otherwise
    /// stores an empty state (0). Returns `TRUE` if there was a state field
    /// in the event. `event` may be `NULL`, in which case it’s treated
    /// as if the event had no state field.
    extern fn gdk_event_get_state(p_event: ?*const Event, p_state: *gdk.ModifierType) c_int;
    pub const getState = gdk_event_get_state;

    /// Returns the time stamp from `event`, if there is one; otherwise
    /// returns `GDK_CURRENT_TIME`. If `event` is `NULL`, returns `GDK_CURRENT_TIME`.
    extern fn gdk_event_get_time(p_event: *const Event) u32;
    pub const getTime = gdk_event_get_time;

    /// Extracts the `gdk.Window` associated with an event.
    extern fn gdk_event_get_window(p_event: *const Event) *gdk.Window;
    pub const getWindow = gdk_event_get_window;

    /// Check whether a scroll event is a stop scroll event. Scroll sequences
    /// with smooth scroll information may provide a stop scroll event once the
    /// interaction with the device finishes, e.g. by lifting a finger. This
    /// stop scroll event is the signal that a widget may trigger kinetic
    /// scrolling based on the current velocity.
    ///
    /// Stop scroll events always have a a delta of 0/0.
    extern fn gdk_event_is_scroll_stop_event(p_event: *const Event) c_int;
    pub const isScrollStopEvent = gdk_event_is_scroll_stop_event;

    /// Appends a copy of the given event onto the front of the event
    /// queue for event->any.window’s display, or the default event
    /// queue if event->any.window is `NULL`. See `gdk.Display.putEvent`.
    extern fn gdk_event_put(p_event: *const Event) void;
    pub const put = gdk_event_put;

    /// Sets the device for `event` to `device`. The event must
    /// have been allocated by GTK+, for instance, by
    /// `gdk.Event.copy`.
    extern fn gdk_event_set_device(p_event: *Event, p_device: *gdk.Device) void;
    pub const setDevice = gdk_event_set_device;

    /// Sets the device tool for this event, should be rarely used.
    extern fn gdk_event_set_device_tool(p_event: *Event, p_tool: ?*gdk.DeviceTool) void;
    pub const setDeviceTool = gdk_event_set_device_tool;

    /// Sets the screen for `event` to `screen`. The event must
    /// have been allocated by GTK+, for instance, by
    /// `gdk.Event.copy`.
    extern fn gdk_event_set_screen(p_event: *Event, p_screen: *gdk.Screen) void;
    pub const setScreen = gdk_event_set_screen;

    /// Sets the slave device for `event` to `device`.
    ///
    /// The event must have been allocated by GTK+,
    /// for instance by `gdk.Event.copy`.
    extern fn gdk_event_set_source_device(p_event: *Event, p_device: *gdk.Device) void;
    pub const setSourceDevice = gdk_event_set_source_device;

    /// This function returns whether a `gdk.EventButton` should trigger a
    /// context menu, according to platform conventions. The right mouse
    /// button always triggers context menus. Additionally, if
    /// `gdk.Keymap.getModifierMask` returns a non-0 mask for
    /// `GDK_MODIFIER_INTENT_CONTEXT_MENU`, then the left mouse button will
    /// also trigger a context menu if this modifier is pressed.
    ///
    /// This function should always be used instead of simply checking for
    /// event->button == `GDK_BUTTON_SECONDARY`.
    extern fn gdk_event_triggers_context_menu(p_event: *const Event) c_int;
    pub const triggersContextMenu = gdk_event_triggers_context_menu;

    extern fn gdk_event_get_type() usize;
    pub const getGObjectType = gdk_event_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration describing the way in which a device
/// axis (valuator) maps onto the predefined valuator
/// types that GTK+ understands.
///
/// Note that the X and Y axes are not really needed; pointer devices
/// report their location via the x/y members of events regardless. Whether
/// X and Y are present as axes depends on the GDK backend.
pub const AxisUse = enum(c_int) {
    ignore = 0,
    x = 1,
    y = 2,
    pressure = 3,
    xtilt = 4,
    ytilt = 5,
    wheel = 6,
    distance = 7,
    rotation = 8,
    slider = 9,
    last = 10,
    _,

    extern fn gdk_axis_use_get_type() usize;
    pub const getGObjectType = gdk_axis_use_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of values describing the possible byte-orders
/// for storing pixel values in memory.
pub const ByteOrder = enum(c_int) {
    lsb_first = 0,
    msb_first = 1,
    _,

    extern fn gdk_byte_order_get_type() usize;
    pub const getGObjectType = gdk_byte_order_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the crossing mode for `gdk.EventCrossing`.
pub const CrossingMode = enum(c_int) {
    normal = 0,
    grab = 1,
    ungrab = 2,
    gtk_grab = 3,
    gtk_ungrab = 4,
    state_changed = 5,
    touch_begin = 6,
    touch_end = 7,
    device_switch = 8,
    _,

    extern fn gdk_crossing_mode_get_type() usize;
    pub const getGObjectType = gdk_crossing_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Predefined cursors.
///
/// Note that these IDs are directly taken from the X cursor font, and many
/// of these cursors are either not useful, or are not available on other platforms.
///
/// The recommended way to create cursors is to use `gdk.Cursor.newFromName`.
pub const CursorType = enum(c_int) {
    x_cursor = 0,
    arrow = 2,
    based_arrow_down = 4,
    based_arrow_up = 6,
    boat = 8,
    bogosity = 10,
    bottom_left_corner = 12,
    bottom_right_corner = 14,
    bottom_side = 16,
    bottom_tee = 18,
    box_spiral = 20,
    center_ptr = 22,
    circle = 24,
    clock = 26,
    coffee_mug = 28,
    cross = 30,
    cross_reverse = 32,
    crosshair = 34,
    diamond_cross = 36,
    dot = 38,
    dotbox = 40,
    double_arrow = 42,
    draft_large = 44,
    draft_small = 46,
    draped_box = 48,
    exchange = 50,
    fleur = 52,
    gobbler = 54,
    gumby = 56,
    hand1 = 58,
    hand2 = 60,
    heart = 62,
    icon = 64,
    iron_cross = 66,
    left_ptr = 68,
    left_side = 70,
    left_tee = 72,
    leftbutton = 74,
    ll_angle = 76,
    lr_angle = 78,
    man = 80,
    middlebutton = 82,
    mouse = 84,
    pencil = 86,
    pirate = 88,
    plus = 90,
    question_arrow = 92,
    right_ptr = 94,
    right_side = 96,
    right_tee = 98,
    rightbutton = 100,
    rtl_logo = 102,
    sailboat = 104,
    sb_down_arrow = 106,
    sb_h_double_arrow = 108,
    sb_left_arrow = 110,
    sb_right_arrow = 112,
    sb_up_arrow = 114,
    sb_v_double_arrow = 116,
    shuttle = 118,
    sizing = 120,
    spider = 122,
    spraycan = 124,
    star = 126,
    target = 128,
    tcross = 130,
    top_left_arrow = 132,
    top_left_corner = 134,
    top_right_corner = 136,
    top_side = 138,
    top_tee = 140,
    trek = 142,
    ul_angle = 144,
    umbrella = 146,
    ur_angle = 148,
    watch = 150,
    xterm = 152,
    last_cursor = 153,
    blank_cursor = -2,
    cursor_is_pixmap = -1,
    _,

    extern fn gdk_cursor_type_get_type() usize;
    pub const getGObjectType = gdk_cursor_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A pad feature.
pub const DevicePadFeature = enum(c_int) {
    button = 0,
    ring = 1,
    strip = 2,
    _,

    extern fn gdk_device_pad_feature_get_type() usize;
    pub const getGObjectType = gdk_device_pad_feature_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the specific type of tool being used being a tablet. Such as an
/// airbrush, pencil, etc.
pub const DeviceToolType = enum(c_int) {
    unknown = 0,
    pen = 1,
    eraser = 2,
    brush = 3,
    pencil = 4,
    airbrush = 5,
    mouse = 6,
    lens = 7,
    _,

    extern fn gdk_device_tool_type_get_type() usize;
    pub const getGObjectType = gdk_device_tool_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates the device type. See [above][GdkDeviceManager.description]
/// for more information about the meaning of these device types.
pub const DeviceType = enum(c_int) {
    master = 0,
    slave = 1,
    floating = 2,
    _,

    extern fn gdk_device_type_get_type() usize;
    pub const getGObjectType = gdk_device_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `gdk.DragContext` to the reason of a cancelled DND operation.
pub const DragCancelReason = enum(c_int) {
    no_target = 0,
    user_cancelled = 1,
    @"error" = 2,
    _,

    extern fn gdk_drag_cancel_reason_get_type() usize;
    pub const getGObjectType = gdk_drag_cancel_reason_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `gdk.DragContext` to indicate the protocol according to
/// which DND is done.
pub const DragProtocol = enum(c_int) {
    none = 0,
    motif = 1,
    xdnd = 2,
    rootwin = 3,
    win32_dropfiles = 4,
    ole2 = 5,
    local = 6,
    wayland = 7,
    _,

    extern fn gdk_drag_protocol_get_type() usize;
    pub const getGObjectType = gdk_drag_protocol_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the type of the event.
///
/// Do not confuse these events with the signals that GTK+ widgets emit.
/// Although many of these events result in corresponding signals being emitted,
/// the events are often transformed or filtered along the way.
///
/// In some language bindings, the values `GDK_2BUTTON_PRESS` and
/// `GDK_3BUTTON_PRESS` would translate into something syntactically
/// invalid (eg `Gdk.EventType.2ButtonPress`, where a
/// symbol is not allowed to start with a number). In that case, the
/// aliases `GDK_DOUBLE_BUTTON_PRESS` and `GDK_TRIPLE_BUTTON_PRESS` can
/// be used instead.
pub const EventType = enum(c_int) {
    nothing = -1,
    delete = 0,
    destroy = 1,
    expose = 2,
    motion_notify = 3,
    button_press = 4,
    @"2button_press" = 5,
    @"3button_press" = 6,
    button_release = 7,
    key_press = 8,
    key_release = 9,
    enter_notify = 10,
    leave_notify = 11,
    focus_change = 12,
    configure = 13,
    map = 14,
    unmap = 15,
    property_notify = 16,
    selection_clear = 17,
    selection_request = 18,
    selection_notify = 19,
    proximity_in = 20,
    proximity_out = 21,
    drag_enter = 22,
    drag_leave = 23,
    drag_motion = 24,
    drag_status = 25,
    drop_start = 26,
    drop_finished = 27,
    client_event = 28,
    visibility_notify = 29,
    scroll = 31,
    window_state = 32,
    setting = 33,
    owner_change = 34,
    grab_broken = 35,
    damage = 36,
    touch_begin = 37,
    touch_update = 38,
    touch_end = 39,
    touch_cancel = 40,
    touchpad_swipe = 41,
    touchpad_pinch = 42,
    pad_button_press = 43,
    pad_button_release = 44,
    pad_ring = 45,
    pad_strip = 46,
    pad_group_mode = 47,
    event_last = 48,
    _,

    pub const double_button_press = EventType.@"2button_press";
    pub const triple_button_press = EventType.@"3button_press";
    extern fn gdk_event_type_get_type() usize;
    pub const getGObjectType = gdk_event_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the result of applying a `gdk.FilterFunc` to a native event.
pub const FilterReturn = enum(c_int) {
    @"continue" = 0,
    translate = 1,
    remove = 2,
    _,

    extern fn gdk_filter_return_get_type() usize;
    pub const getGObjectType = gdk_filter_return_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Indicates which monitor (in a multi-head setup) a window should span over
/// when in fullscreen mode.
pub const FullscreenMode = enum(c_int) {
    current_monitor = 0,
    all_monitors = 1,
    _,

    extern fn gdk_fullscreen_mode_get_type() usize;
    pub const getGObjectType = gdk_fullscreen_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Error enumeration for `gdk.GLContext`.
pub const GLError = enum(c_int) {
    not_available = 0,
    unsupported_format = 1,
    unsupported_profile = 2,
    _,

    extern fn gdk_gl_error_quark() glib.Quark;
    pub const quark = gdk_gl_error_quark;

    extern fn gdk_gl_error_get_type() usize;
    pub const getGObjectType = gdk_gl_error_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines how device grabs interact with other devices.
pub const GrabOwnership = enum(c_int) {
    none = 0,
    window = 1,
    application = 2,
    _,

    extern fn gdk_grab_ownership_get_type() usize;
    pub const getGObjectType = gdk_grab_ownership_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Returned by `gdk.Device.grab`, `gdk.pointerGrab` and `gdk.keyboardGrab` to
/// indicate success or the reason for the failure of the grab attempt.
pub const GrabStatus = enum(c_int) {
    success = 0,
    already_grabbed = 1,
    invalid_time = 2,
    not_viewable = 3,
    frozen = 4,
    failed = 5,
    _,

    extern fn gdk_grab_status_get_type() usize;
    pub const getGObjectType = gdk_grab_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Defines the reference point of a window and the meaning of coordinates
/// passed to `gtk_window_move`. See `gtk_window_move` and the "implementation
/// notes" section of the
/// [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec)
/// specification for more details.
pub const Gravity = enum(c_int) {
    north_west = 1,
    north = 2,
    north_east = 3,
    west = 4,
    center = 5,
    east = 6,
    south_west = 7,
    south = 8,
    south_east = 9,
    static = 10,
    _,

    extern fn gdk_gravity_get_type() usize;
    pub const getGObjectType = gdk_gravity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration that describes the mode of an input device.
pub const InputMode = enum(c_int) {
    disabled = 0,
    screen = 1,
    window = 2,
    _,

    extern fn gdk_input_mode_get_type() usize;
    pub const getGObjectType = gdk_input_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enumeration describing the type of an input device in general terms.
pub const InputSource = enum(c_int) {
    mouse = 0,
    pen = 1,
    eraser = 2,
    cursor = 3,
    keyboard = 4,
    touchscreen = 5,
    touchpad = 6,
    trackpoint = 7,
    tablet_pad = 8,
    _,

    extern fn gdk_input_source_get_type() usize;
    pub const getGObjectType = gdk_input_source_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This enum is used with `gdk.Keymap.getModifierMask`
/// in order to determine what modifiers the
/// currently used windowing system backend uses for particular
/// purposes. For example, on X11/Windows, the Control key is used for
/// invoking menu shortcuts (accelerators), whereas on Apple computers
/// it’s the Command key (which correspond to `GDK_CONTROL_MASK` and
/// `GDK_MOD2_MASK`, respectively).
pub const ModifierIntent = enum(c_int) {
    primary_accelerator = 0,
    context_menu = 1,
    extend_selection = 2,
    modify_selection = 3,
    no_text_input = 4,
    shift_group = 5,
    default_mod_mask = 6,
    _,

    extern fn gdk_modifier_intent_get_type() usize;
    pub const getGObjectType = gdk_modifier_intent_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the kind of crossing for `gdk.EventCrossing`.
///
/// See the X11 protocol specification of LeaveNotify for
/// full details of crossing event generation.
pub const NotifyType = enum(c_int) {
    ancestor = 0,
    virtual = 1,
    inferior = 2,
    nonlinear = 3,
    nonlinear_virtual = 4,
    unknown = 5,
    _,

    extern fn gdk_notify_type_get_type() usize;
    pub const getGObjectType = gdk_notify_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies why a selection ownership was changed.
pub const OwnerChange = enum(c_int) {
    new_owner = 0,
    destroy = 1,
    close = 2,
    _,

    extern fn gdk_owner_change_get_type() usize;
    pub const getGObjectType = gdk_owner_change_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes how existing data is combined with new data when
/// using `gdk.propertyChange`.
pub const PropMode = enum(c_int) {
    replace = 0,
    prepend = 1,
    append = 2,
    _,

    extern fn gdk_prop_mode_get_type() usize;
    pub const getGObjectType = gdk_prop_mode_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the type of a property change for a `gdk.EventProperty`.
pub const PropertyState = enum(c_int) {
    new_value = 0,
    delete = 1,
    _,

    extern fn gdk_property_state_get_type() usize;
    pub const getGObjectType = gdk_property_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the direction for `gdk.EventScroll`.
pub const ScrollDirection = enum(c_int) {
    up = 0,
    down = 1,
    left = 2,
    right = 3,
    smooth = 4,
    _,

    extern fn gdk_scroll_direction_get_type() usize;
    pub const getGObjectType = gdk_scroll_direction_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the kind of modification applied to a setting in a
/// `gdk.EventSetting`.
pub const SettingAction = enum(c_int) {
    new = 0,
    changed = 1,
    deleted = 2,
    _,

    extern fn gdk_setting_action_get_type() usize;
    pub const getGObjectType = gdk_setting_action_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Status = enum(c_int) {
    ok = 0,
    @"error" = -1,
    error_param = -2,
    error_file = -3,
    error_mem = -4,
    _,

    extern fn gdk_status_get_type() usize;
    pub const getGObjectType = gdk_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This enumeration describes how the red, green and blue components
/// of physical pixels on an output device are laid out.
pub const SubpixelLayout = enum(c_int) {
    unknown = 0,
    none = 1,
    horizontal_rgb = 2,
    horizontal_bgr = 3,
    vertical_rgb = 4,
    vertical_bgr = 5,
    _,

    extern fn gdk_subpixel_layout_get_type() usize;
    pub const getGObjectType = gdk_subpixel_layout_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the current state of a touchpad gesture. All gestures are
/// guaranteed to begin with an event with phase `GDK_TOUCHPAD_GESTURE_PHASE_BEGIN`,
/// followed by 0 or several events with phase `GDK_TOUCHPAD_GESTURE_PHASE_UPDATE`.
///
/// A finished gesture may have 2 possible outcomes, an event with phase
/// `GDK_TOUCHPAD_GESTURE_PHASE_END` will be emitted when the gesture is
/// considered successful, this should be used as the hint to perform any
/// permanent changes.
///
/// Cancelled gestures may be so for a variety of reasons, due to hardware
/// or the compositor, or due to the gesture recognition layers hinting the
/// gesture did not finish resolutely (eg. a 3rd finger being added during
/// a pinch gesture). In these cases, the last event will report the phase
/// `GDK_TOUCHPAD_GESTURE_PHASE_CANCEL`, this should be used as a hint
/// to undo any visible/permanent changes that were done throughout the
/// progress of the gesture.
///
/// See also `gdk.EventTouchpadSwipe` and `gdk.EventTouchpadPinch`.
pub const TouchpadGesturePhase = enum(c_int) {
    begin = 0,
    update = 1,
    end = 2,
    cancel = 3,
    _,

    extern fn gdk_touchpad_gesture_phase_get_type() usize;
    pub const getGObjectType = gdk_touchpad_gesture_phase_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the visiblity status of a window for a `gdk.EventVisibility`.
pub const VisibilityState = enum(c_int) {
    unobscured = 0,
    partial = 1,
    fully_obscured = 2,
    _,

    extern fn gdk_visibility_state_get_type() usize;
    pub const getGObjectType = gdk_visibility_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of values that describe the manner in which the pixel values
/// for a visual are converted into RGB values for display.
pub const VisualType = enum(c_int) {
    static_gray = 0,
    grayscale = 1,
    static_color = 2,
    pseudo_color = 3,
    true_color = 4,
    direct_color = 5,
    _,

    extern fn gdk_visual_type_get_type() usize;
    pub const getGObjectType = gdk_visual_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Determines a window edge or corner.
pub const WindowEdge = enum(c_int) {
    north_west = 0,
    north = 1,
    north_east = 2,
    west = 3,
    east = 4,
    south_west = 5,
    south = 6,
    south_east = 7,
    _,

    extern fn gdk_window_edge_get_type() usize;
    pub const getGObjectType = gdk_window_edge_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the kind of window.
pub const WindowType = enum(c_int) {
    root = 0,
    toplevel = 1,
    child = 2,
    temp = 3,
    foreign = 4,
    offscreen = 5,
    subsurface = 6,
    _,

    extern fn gdk_window_type_get_type() usize;
    pub const getGObjectType = gdk_window_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These are hints for the window manager that indicate what type of function
/// the window has. The window manager can use this when determining decoration
/// and behaviour of the window. The hint must be set before mapping the window.
///
/// See the [Extended Window Manager Hints](http://www.freedesktop.org/Standards/wm-spec)
/// specification for more details about window types.
pub const WindowTypeHint = enum(c_int) {
    normal = 0,
    dialog = 1,
    menu = 2,
    toolbar = 3,
    splashscreen = 4,
    utility = 5,
    dock = 6,
    desktop = 7,
    dropdown_menu = 8,
    popup_menu = 9,
    tooltip = 10,
    notification = 11,
    combo = 12,
    dnd = 13,
    _,

    extern fn gdk_window_type_hint_get_type() usize;
    pub const getGObjectType = gdk_window_type_hint_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `GDK_INPUT_OUTPUT` windows are the standard kind of window you might expect.
/// Such windows receive events and are also displayed on screen.
/// `GDK_INPUT_ONLY` windows are invisible; they are usually placed above other
/// windows in order to trap or filter the events. You can’t draw on
/// `GDK_INPUT_ONLY` windows.
pub const WindowWindowClass = enum(c_int) {
    input_output = 0,
    input_only = 1,
    _,

    extern fn gdk_window_window_class_get_type() usize;
    pub const getGObjectType = gdk_window_window_class_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Positioning hints for aligning a window relative to a rectangle.
///
/// These hints determine how the window should be positioned in the case that
/// the window would fall off-screen if placed in its ideal position.
///
/// For example, `GDK_ANCHOR_FLIP_X` will replace `GDK_GRAVITY_NORTH_WEST` with
/// `GDK_GRAVITY_NORTH_EAST` and vice versa if the window extends beyond the left
/// or right edges of the monitor.
///
/// If `GDK_ANCHOR_SLIDE_X` is set, the window can be shifted horizontally to fit
/// on-screen. If `GDK_ANCHOR_RESIZE_X` is set, the window can be shrunken
/// horizontally to fit.
///
/// In general, when multiple flags are set, flipping should take precedence over
/// sliding, which should take precedence over resizing.
pub const AnchorHints = packed struct(c_uint) {
    flip_x: bool = false,
    flip_y: bool = false,
    slide_x: bool = false,
    slide_y: bool = false,
    resize_x: bool = false,
    resize_y: bool = false,
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

    pub const flags_flip_x: AnchorHints = @bitCast(@as(c_uint, 1));
    pub const flags_flip_y: AnchorHints = @bitCast(@as(c_uint, 2));
    pub const flags_slide_x: AnchorHints = @bitCast(@as(c_uint, 4));
    pub const flags_slide_y: AnchorHints = @bitCast(@as(c_uint, 8));
    pub const flags_resize_x: AnchorHints = @bitCast(@as(c_uint, 16));
    pub const flags_resize_y: AnchorHints = @bitCast(@as(c_uint, 32));
    pub const flags_flip: AnchorHints = @bitCast(@as(c_uint, 3));
    pub const flags_slide: AnchorHints = @bitCast(@as(c_uint, 12));
    pub const flags_resize: AnchorHints = @bitCast(@as(c_uint, 48));
    extern fn gdk_anchor_hints_get_type() usize;
    pub const getGObjectType = gdk_anchor_hints_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags describing the current capabilities of a device/tool.
pub const AxisFlags = packed struct(c_uint) {
    _padding0: bool = false,
    x: bool = false,
    y: bool = false,
    pressure: bool = false,
    xtilt: bool = false,
    ytilt: bool = false,
    wheel: bool = false,
    distance: bool = false,
    rotation: bool = false,
    slider: bool = false,
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

    pub const flags_x: AxisFlags = @bitCast(@as(c_uint, 2));
    pub const flags_y: AxisFlags = @bitCast(@as(c_uint, 4));
    pub const flags_pressure: AxisFlags = @bitCast(@as(c_uint, 8));
    pub const flags_xtilt: AxisFlags = @bitCast(@as(c_uint, 16));
    pub const flags_ytilt: AxisFlags = @bitCast(@as(c_uint, 32));
    pub const flags_wheel: AxisFlags = @bitCast(@as(c_uint, 64));
    pub const flags_distance: AxisFlags = @bitCast(@as(c_uint, 128));
    pub const flags_rotation: AxisFlags = @bitCast(@as(c_uint, 256));
    pub const flags_slider: AxisFlags = @bitCast(@as(c_uint, 512));
    extern fn gdk_axis_flags_get_type() usize;
    pub const getGObjectType = gdk_axis_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used in `gdk.DragContext` to indicate what the destination
/// should do with the dropped data.
pub const DragAction = packed struct(c_uint) {
    default: bool = false,
    copy: bool = false,
    move: bool = false,
    link: bool = false,
    private: bool = false,
    ask: bool = false,
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

    pub const flags_default: DragAction = @bitCast(@as(c_uint, 1));
    pub const flags_copy: DragAction = @bitCast(@as(c_uint, 2));
    pub const flags_move: DragAction = @bitCast(@as(c_uint, 4));
    pub const flags_link: DragAction = @bitCast(@as(c_uint, 8));
    pub const flags_private: DragAction = @bitCast(@as(c_uint, 16));
    pub const flags_ask: DragAction = @bitCast(@as(c_uint, 32));
    extern fn gdk_drag_action_get_type() usize;
    pub const getGObjectType = gdk_drag_action_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of bit-flags to indicate which events a window is to receive.
/// Most of these masks map onto one or more of the `gdk.EventType` event types
/// above.
///
/// See the [input handling overview][chap-input-handling] for details of
/// [event masks][event-masks] and [event propagation][event-propagation].
///
/// `GDK_POINTER_MOTION_HINT_MASK` is deprecated. It is a special mask
/// to reduce the number of `GDK_MOTION_NOTIFY` events received. When using
/// `GDK_POINTER_MOTION_HINT_MASK`, fewer `GDK_MOTION_NOTIFY` events will
/// be sent, some of which are marked as a hint (the is_hint member is
/// `TRUE`). To receive more motion events after a motion hint event,
/// the application needs to asks for more, by calling
/// `gdk.eventRequestMotions`.
///
/// Since GTK 3.8, motion events are already compressed by default, independent
/// of this mechanism. This compression can be disabled with
/// `gdk.Window.setEventCompression`. See the documentation of that function
/// for details.
///
/// If `GDK_TOUCH_MASK` is enabled, the window will receive touch events
/// from touch-enabled devices. Those will come as sequences of `gdk.EventTouch`
/// with type `GDK_TOUCH_UPDATE`, enclosed by two events with
/// type `GDK_TOUCH_BEGIN` and `GDK_TOUCH_END` (or `GDK_TOUCH_CANCEL`).
/// `gdk.Event.getEventSequence` returns the event sequence for these
/// events, so different sequences may be distinguished.
pub const EventMask = packed struct(c_uint) {
    _padding0: bool = false,
    exposure_mask: bool = false,
    pointer_motion_mask: bool = false,
    pointer_motion_hint_mask: bool = false,
    button_motion_mask: bool = false,
    button1_motion_mask: bool = false,
    button2_motion_mask: bool = false,
    button3_motion_mask: bool = false,
    button_press_mask: bool = false,
    button_release_mask: bool = false,
    key_press_mask: bool = false,
    key_release_mask: bool = false,
    enter_notify_mask: bool = false,
    leave_notify_mask: bool = false,
    focus_change_mask: bool = false,
    structure_mask: bool = false,
    property_change_mask: bool = false,
    visibility_notify_mask: bool = false,
    proximity_in_mask: bool = false,
    proximity_out_mask: bool = false,
    substructure_mask: bool = false,
    scroll_mask: bool = false,
    touch_mask: bool = false,
    smooth_scroll_mask: bool = false,
    touchpad_gesture_mask: bool = false,
    tablet_pad_mask: bool = false,
    _padding26: bool = false,
    _padding27: bool = false,
    _padding28: bool = false,
    _padding29: bool = false,
    _padding30: bool = false,
    _padding31: bool = false,

    pub const flags_exposure_mask: EventMask = @bitCast(@as(c_uint, 2));
    pub const flags_pointer_motion_mask: EventMask = @bitCast(@as(c_uint, 4));
    pub const flags_pointer_motion_hint_mask: EventMask = @bitCast(@as(c_uint, 8));
    pub const flags_button_motion_mask: EventMask = @bitCast(@as(c_uint, 16));
    pub const flags_button1_motion_mask: EventMask = @bitCast(@as(c_uint, 32));
    pub const flags_button2_motion_mask: EventMask = @bitCast(@as(c_uint, 64));
    pub const flags_button3_motion_mask: EventMask = @bitCast(@as(c_uint, 128));
    pub const flags_button_press_mask: EventMask = @bitCast(@as(c_uint, 256));
    pub const flags_button_release_mask: EventMask = @bitCast(@as(c_uint, 512));
    pub const flags_key_press_mask: EventMask = @bitCast(@as(c_uint, 1024));
    pub const flags_key_release_mask: EventMask = @bitCast(@as(c_uint, 2048));
    pub const flags_enter_notify_mask: EventMask = @bitCast(@as(c_uint, 4096));
    pub const flags_leave_notify_mask: EventMask = @bitCast(@as(c_uint, 8192));
    pub const flags_focus_change_mask: EventMask = @bitCast(@as(c_uint, 16384));
    pub const flags_structure_mask: EventMask = @bitCast(@as(c_uint, 32768));
    pub const flags_property_change_mask: EventMask = @bitCast(@as(c_uint, 65536));
    pub const flags_visibility_notify_mask: EventMask = @bitCast(@as(c_uint, 131072));
    pub const flags_proximity_in_mask: EventMask = @bitCast(@as(c_uint, 262144));
    pub const flags_proximity_out_mask: EventMask = @bitCast(@as(c_uint, 524288));
    pub const flags_substructure_mask: EventMask = @bitCast(@as(c_uint, 1048576));
    pub const flags_scroll_mask: EventMask = @bitCast(@as(c_uint, 2097152));
    pub const flags_touch_mask: EventMask = @bitCast(@as(c_uint, 4194304));
    pub const flags_smooth_scroll_mask: EventMask = @bitCast(@as(c_uint, 8388608));
    pub const flags_touchpad_gesture_mask: EventMask = @bitCast(@as(c_uint, 16777216));
    pub const flags_tablet_pad_mask: EventMask = @bitCast(@as(c_uint, 33554432));
    pub const flags_all_events_mask: EventMask = @bitCast(@as(c_uint, 67108862));
    extern fn gdk_event_mask_get_type() usize;
    pub const getGObjectType = gdk_event_mask_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gdk.FrameClockPhase` is used to represent the different paint clock
/// phases that can be requested. The elements of the enumeration
/// correspond to the signals of `gdk.FrameClock`.
pub const FrameClockPhase = packed struct(c_uint) {
    flush_events: bool = false,
    before_paint: bool = false,
    update: bool = false,
    layout: bool = false,
    paint: bool = false,
    resume_events: bool = false,
    after_paint: bool = false,
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

    pub const flags_none: FrameClockPhase = @bitCast(@as(c_uint, 0));
    pub const flags_flush_events: FrameClockPhase = @bitCast(@as(c_uint, 1));
    pub const flags_before_paint: FrameClockPhase = @bitCast(@as(c_uint, 2));
    pub const flags_update: FrameClockPhase = @bitCast(@as(c_uint, 4));
    pub const flags_layout: FrameClockPhase = @bitCast(@as(c_uint, 8));
    pub const flags_paint: FrameClockPhase = @bitCast(@as(c_uint, 16));
    pub const flags_resume_events: FrameClockPhase = @bitCast(@as(c_uint, 32));
    pub const flags_after_paint: FrameClockPhase = @bitCast(@as(c_uint, 64));
    extern fn gdk_frame_clock_phase_get_type() usize;
    pub const getGObjectType = gdk_frame_clock_phase_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of bit-flags to indicate the state of modifier keys and mouse buttons
/// in various event types. Typical modifier keys are Shift, Control, Meta,
/// Super, Hyper, Alt, Compose, Apple, CapsLock or ShiftLock.
///
/// Like the X Window System, GDK supports 8 modifier keys and 5 mouse buttons.
///
/// Since 2.10, GDK recognizes which of the Meta, Super or Hyper keys are mapped
/// to Mod2 - Mod5, and indicates this by setting `GDK_SUPER_MASK`,
/// `GDK_HYPER_MASK` or `GDK_META_MASK` in the state field of key events.
///
/// Note that GDK may add internal values to events which include
/// reserved values such as `GDK_MODIFIER_RESERVED_13_MASK`.  Your code
/// should preserve and ignore them.  You can use `GDK_MODIFIER_MASK` to
/// remove all reserved values.
///
/// Also note that the GDK X backend interprets button press events for button
/// 4-7 as scroll events, so `GDK_BUTTON4_MASK` and `GDK_BUTTON5_MASK` will never
/// be set.
pub const ModifierType = packed struct(c_uint) {
    shift_mask: bool = false,
    lock_mask: bool = false,
    control_mask: bool = false,
    mod1_mask: bool = false,
    mod2_mask: bool = false,
    mod3_mask: bool = false,
    mod4_mask: bool = false,
    mod5_mask: bool = false,
    button1_mask: bool = false,
    button2_mask: bool = false,
    button3_mask: bool = false,
    button4_mask: bool = false,
    button5_mask: bool = false,
    modifier_reserved_13_mask: bool = false,
    modifier_reserved_14_mask: bool = false,
    modifier_reserved_15_mask: bool = false,
    modifier_reserved_16_mask: bool = false,
    modifier_reserved_17_mask: bool = false,
    modifier_reserved_18_mask: bool = false,
    modifier_reserved_19_mask: bool = false,
    modifier_reserved_20_mask: bool = false,
    modifier_reserved_21_mask: bool = false,
    modifier_reserved_22_mask: bool = false,
    modifier_reserved_23_mask: bool = false,
    modifier_reserved_24_mask: bool = false,
    modifier_reserved_25_mask: bool = false,
    super_mask: bool = false,
    hyper_mask: bool = false,
    meta_mask: bool = false,
    modifier_reserved_29_mask: bool = false,
    release_mask: bool = false,
    _padding31: bool = false,

    pub const flags_shift_mask: ModifierType = @bitCast(@as(c_uint, 1));
    pub const flags_lock_mask: ModifierType = @bitCast(@as(c_uint, 2));
    pub const flags_control_mask: ModifierType = @bitCast(@as(c_uint, 4));
    pub const flags_mod1_mask: ModifierType = @bitCast(@as(c_uint, 8));
    pub const flags_mod2_mask: ModifierType = @bitCast(@as(c_uint, 16));
    pub const flags_mod3_mask: ModifierType = @bitCast(@as(c_uint, 32));
    pub const flags_mod4_mask: ModifierType = @bitCast(@as(c_uint, 64));
    pub const flags_mod5_mask: ModifierType = @bitCast(@as(c_uint, 128));
    pub const flags_button1_mask: ModifierType = @bitCast(@as(c_uint, 256));
    pub const flags_button2_mask: ModifierType = @bitCast(@as(c_uint, 512));
    pub const flags_button3_mask: ModifierType = @bitCast(@as(c_uint, 1024));
    pub const flags_button4_mask: ModifierType = @bitCast(@as(c_uint, 2048));
    pub const flags_button5_mask: ModifierType = @bitCast(@as(c_uint, 4096));
    pub const flags_modifier_reserved_13_mask: ModifierType = @bitCast(@as(c_uint, 8192));
    pub const flags_modifier_reserved_14_mask: ModifierType = @bitCast(@as(c_uint, 16384));
    pub const flags_modifier_reserved_15_mask: ModifierType = @bitCast(@as(c_uint, 32768));
    pub const flags_modifier_reserved_16_mask: ModifierType = @bitCast(@as(c_uint, 65536));
    pub const flags_modifier_reserved_17_mask: ModifierType = @bitCast(@as(c_uint, 131072));
    pub const flags_modifier_reserved_18_mask: ModifierType = @bitCast(@as(c_uint, 262144));
    pub const flags_modifier_reserved_19_mask: ModifierType = @bitCast(@as(c_uint, 524288));
    pub const flags_modifier_reserved_20_mask: ModifierType = @bitCast(@as(c_uint, 1048576));
    pub const flags_modifier_reserved_21_mask: ModifierType = @bitCast(@as(c_uint, 2097152));
    pub const flags_modifier_reserved_22_mask: ModifierType = @bitCast(@as(c_uint, 4194304));
    pub const flags_modifier_reserved_23_mask: ModifierType = @bitCast(@as(c_uint, 8388608));
    pub const flags_modifier_reserved_24_mask: ModifierType = @bitCast(@as(c_uint, 16777216));
    pub const flags_modifier_reserved_25_mask: ModifierType = @bitCast(@as(c_uint, 33554432));
    pub const flags_super_mask: ModifierType = @bitCast(@as(c_uint, 67108864));
    pub const flags_hyper_mask: ModifierType = @bitCast(@as(c_uint, 134217728));
    pub const flags_meta_mask: ModifierType = @bitCast(@as(c_uint, 268435456));
    pub const flags_modifier_reserved_29_mask: ModifierType = @bitCast(@as(c_uint, 536870912));
    pub const flags_release_mask: ModifierType = @bitCast(@as(c_uint, 1073741824));
    pub const flags_modifier_mask: ModifierType = @bitCast(@as(c_uint, 1543512063));
    extern fn gdk_modifier_type_get_type() usize;
    pub const getGObjectType = gdk_modifier_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Flags describing the seat capabilities.
pub const SeatCapabilities = packed struct(c_uint) {
    pointer: bool = false,
    touch: bool = false,
    tablet_stylus: bool = false,
    keyboard: bool = false,
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

    pub const flags_none: SeatCapabilities = @bitCast(@as(c_uint, 0));
    pub const flags_pointer: SeatCapabilities = @bitCast(@as(c_uint, 1));
    pub const flags_touch: SeatCapabilities = @bitCast(@as(c_uint, 2));
    pub const flags_tablet_stylus: SeatCapabilities = @bitCast(@as(c_uint, 4));
    pub const flags_keyboard: SeatCapabilities = @bitCast(@as(c_uint, 8));
    pub const flags_all_pointing: SeatCapabilities = @bitCast(@as(c_uint, 7));
    pub const flags_all: SeatCapabilities = @bitCast(@as(c_uint, 15));
    extern fn gdk_seat_capabilities_get_type() usize;
    pub const getGObjectType = gdk_seat_capabilities_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These are hints originally defined by the Motif toolkit.
/// The window manager can use them when determining how to decorate
/// the window. The hint must be set before mapping the window.
pub const WMDecoration = packed struct(c_uint) {
    all: bool = false,
    border: bool = false,
    resizeh: bool = false,
    title: bool = false,
    menu: bool = false,
    minimize: bool = false,
    maximize: bool = false,
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

    pub const flags_all: WMDecoration = @bitCast(@as(c_uint, 1));
    pub const flags_border: WMDecoration = @bitCast(@as(c_uint, 2));
    pub const flags_resizeh: WMDecoration = @bitCast(@as(c_uint, 4));
    pub const flags_title: WMDecoration = @bitCast(@as(c_uint, 8));
    pub const flags_menu: WMDecoration = @bitCast(@as(c_uint, 16));
    pub const flags_minimize: WMDecoration = @bitCast(@as(c_uint, 32));
    pub const flags_maximize: WMDecoration = @bitCast(@as(c_uint, 64));
    extern fn gdk_wm_decoration_get_type() usize;
    pub const getGObjectType = gdk_wm_decoration_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// These are hints originally defined by the Motif toolkit. The window manager
/// can use them when determining the functions to offer for the window. The
/// hint must be set before mapping the window.
pub const WMFunction = packed struct(c_uint) {
    all: bool = false,
    resize: bool = false,
    move: bool = false,
    minimize: bool = false,
    maximize: bool = false,
    close: bool = false,
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

    pub const flags_all: WMFunction = @bitCast(@as(c_uint, 1));
    pub const flags_resize: WMFunction = @bitCast(@as(c_uint, 2));
    pub const flags_move: WMFunction = @bitCast(@as(c_uint, 4));
    pub const flags_minimize: WMFunction = @bitCast(@as(c_uint, 8));
    pub const flags_maximize: WMFunction = @bitCast(@as(c_uint, 16));
    pub const flags_close: WMFunction = @bitCast(@as(c_uint, 32));
    extern fn gdk_wm_function_get_type() usize;
    pub const getGObjectType = gdk_wm_function_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to indicate which fields in the `gdk.WindowAttr` struct should be honored.
/// For example, if you filled in the “cursor” and “x” fields of `gdk.WindowAttr`,
/// pass “`GDK_WA_X` | `GDK_WA_CURSOR`” to `gdk.Window.new`. Fields in
/// `gdk.WindowAttr` not covered by a bit in this enum are required; for example,
/// the `width`/`height`, `wclass`, and `window_type` fields are required, they have
/// no corresponding flag in `gdk.WindowAttributesType`.
pub const WindowAttributesType = packed struct(c_uint) {
    _padding0: bool = false,
    title: bool = false,
    x: bool = false,
    y: bool = false,
    cursor: bool = false,
    visual: bool = false,
    wmclass: bool = false,
    noredir: bool = false,
    type_hint: bool = false,
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

    pub const flags_title: WindowAttributesType = @bitCast(@as(c_uint, 2));
    pub const flags_x: WindowAttributesType = @bitCast(@as(c_uint, 4));
    pub const flags_y: WindowAttributesType = @bitCast(@as(c_uint, 8));
    pub const flags_cursor: WindowAttributesType = @bitCast(@as(c_uint, 16));
    pub const flags_visual: WindowAttributesType = @bitCast(@as(c_uint, 32));
    pub const flags_wmclass: WindowAttributesType = @bitCast(@as(c_uint, 64));
    pub const flags_noredir: WindowAttributesType = @bitCast(@as(c_uint, 128));
    pub const flags_type_hint: WindowAttributesType = @bitCast(@as(c_uint, 256));
    extern fn gdk_window_attributes_type_get_type() usize;
    pub const getGObjectType = gdk_window_attributes_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Used to indicate which fields of a `gdk.Geometry` struct should be paid
/// attention to. Also, the presence/absence of `GDK_HINT_POS`,
/// `GDK_HINT_USER_POS`, and `GDK_HINT_USER_SIZE` is significant, though they don't
/// directly refer to `gdk.Geometry` fields. `GDK_HINT_USER_POS` will be set
/// automatically by `GtkWindow` if you call `gtk_window_move`.
/// `GDK_HINT_USER_POS` and `GDK_HINT_USER_SIZE` should be set if the user
/// specified a size/position using a --geometry command-line argument;
/// `gtk_window_parse_geometry` automatically sets these flags.
pub const WindowHints = packed struct(c_uint) {
    pos: bool = false,
    min_size: bool = false,
    max_size: bool = false,
    base_size: bool = false,
    aspect: bool = false,
    resize_inc: bool = false,
    win_gravity: bool = false,
    user_pos: bool = false,
    user_size: bool = false,
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

    pub const flags_pos: WindowHints = @bitCast(@as(c_uint, 1));
    pub const flags_min_size: WindowHints = @bitCast(@as(c_uint, 2));
    pub const flags_max_size: WindowHints = @bitCast(@as(c_uint, 4));
    pub const flags_base_size: WindowHints = @bitCast(@as(c_uint, 8));
    pub const flags_aspect: WindowHints = @bitCast(@as(c_uint, 16));
    pub const flags_resize_inc: WindowHints = @bitCast(@as(c_uint, 32));
    pub const flags_win_gravity: WindowHints = @bitCast(@as(c_uint, 64));
    pub const flags_user_pos: WindowHints = @bitCast(@as(c_uint, 128));
    pub const flags_user_size: WindowHints = @bitCast(@as(c_uint, 256));
    extern fn gdk_window_hints_get_type() usize;
    pub const getGObjectType = gdk_window_hints_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the state of a toplevel window.
pub const WindowState = packed struct(c_uint) {
    withdrawn: bool = false,
    iconified: bool = false,
    maximized: bool = false,
    sticky: bool = false,
    fullscreen: bool = false,
    above: bool = false,
    below: bool = false,
    focused: bool = false,
    tiled: bool = false,
    top_tiled: bool = false,
    top_resizable: bool = false,
    right_tiled: bool = false,
    right_resizable: bool = false,
    bottom_tiled: bool = false,
    bottom_resizable: bool = false,
    left_tiled: bool = false,
    left_resizable: bool = false,
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

    pub const flags_withdrawn: WindowState = @bitCast(@as(c_uint, 1));
    pub const flags_iconified: WindowState = @bitCast(@as(c_uint, 2));
    pub const flags_maximized: WindowState = @bitCast(@as(c_uint, 4));
    pub const flags_sticky: WindowState = @bitCast(@as(c_uint, 8));
    pub const flags_fullscreen: WindowState = @bitCast(@as(c_uint, 16));
    pub const flags_above: WindowState = @bitCast(@as(c_uint, 32));
    pub const flags_below: WindowState = @bitCast(@as(c_uint, 64));
    pub const flags_focused: WindowState = @bitCast(@as(c_uint, 128));
    pub const flags_tiled: WindowState = @bitCast(@as(c_uint, 256));
    pub const flags_top_tiled: WindowState = @bitCast(@as(c_uint, 512));
    pub const flags_top_resizable: WindowState = @bitCast(@as(c_uint, 1024));
    pub const flags_right_tiled: WindowState = @bitCast(@as(c_uint, 2048));
    pub const flags_right_resizable: WindowState = @bitCast(@as(c_uint, 4096));
    pub const flags_bottom_tiled: WindowState = @bitCast(@as(c_uint, 8192));
    pub const flags_bottom_resizable: WindowState = @bitCast(@as(c_uint, 16384));
    pub const flags_left_tiled: WindowState = @bitCast(@as(c_uint, 32768));
    pub const flags_left_resizable: WindowState = @bitCast(@as(c_uint, 65536));
    extern fn gdk_window_state_get_type() usize;
    pub const getGObjectType = gdk_window_state_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Appends gdk option entries to the passed in option group. This is
/// not public API and must not be used by applications.
extern fn gdk_add_option_entries_libgtk_only(p_group: *glib.OptionGroup) void;
pub const addOptionEntriesLibgtkOnly = gdk_add_option_entries_libgtk_only;

/// Emits a short beep on the default display.
extern fn gdk_beep() void;
pub const beep = gdk_beep;

/// Creates a Cairo context for drawing to `window`.
///
/// Note that calling `cairo_reset_clip` on the resulting `cairo.Context` will
/// produce undefined results, so avoid it at all costs.
///
/// Typically, this function is used to draw on a `gdk.Window` out of the paint
/// cycle of the toolkit; this should be avoided, as it breaks various assumptions
/// and optimizations.
///
/// If you are drawing on a native `gdk.Window` in response to a `GDK_EXPOSE` event
/// you should use `gdk.Window.beginDrawFrame` and `gdk.DrawingContext.getCairoContext`
/// instead. GTK will automatically do this for you when drawing a widget.
extern fn gdk_cairo_create(p_window: *gdk.Window) *cairo.Context;
pub const cairoCreate = gdk_cairo_create;

/// This is the main way to draw GL content in GTK+. It takes a render buffer ID
/// (`source_type` == `GL_RENDERBUFFER`) or a texture id (`source_type` == `GL_TEXTURE`)
/// and draws it onto `cr` with an OVER operation, respecting the current clip.
/// The top left corner of the rectangle specified by `x`, `y`, `width` and `height`
/// will be drawn at the current (0,0) position of the cairo_t.
///
/// This will work for *all* cairo_t, as long as `window` is realized, but the
/// fallback implementation that reads back the pixels from the buffer may be
/// used in the general case. In the case of direct drawing to a window with
/// no special effects applied to `cr` it will however use a more efficient
/// approach.
///
/// For `GL_RENDERBUFFER` the code will always fall back to software for buffers
/// with alpha components, so make sure you use `GL_TEXTURE` if using alpha.
///
/// Calling this may change the current GL context.
extern fn gdk_cairo_draw_from_gl(p_cr: *cairo.Context, p_window: *gdk.Window, p_source: c_int, p_source_type: c_int, p_buffer_scale: c_int, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int) void;
pub const cairoDrawFromGl = gdk_cairo_draw_from_gl;

/// This is a convenience function around `cairo_clip_extents`.
/// It rounds the clip extents to integer coordinates and returns
/// a boolean indicating if a clip area exists.
extern fn gdk_cairo_get_clip_rectangle(p_cr: *cairo.Context, p_rect: ?*gdk.Rectangle) c_int;
pub const cairoGetClipRectangle = gdk_cairo_get_clip_rectangle;

/// Retrieves the `gdk.DrawingContext` that created the Cairo
/// context `cr`.
extern fn gdk_cairo_get_drawing_context(p_cr: *cairo.Context) ?*gdk.DrawingContext;
pub const cairoGetDrawingContext = gdk_cairo_get_drawing_context;

/// Adds the given rectangle to the current path of `cr`.
extern fn gdk_cairo_rectangle(p_cr: *cairo.Context, p_rectangle: *const gdk.Rectangle) void;
pub const cairoRectangle = gdk_cairo_rectangle;

/// Adds the given region to the current path of `cr`.
extern fn gdk_cairo_region(p_cr: *cairo.Context, p_region: *const cairo.Region) void;
pub const cairoRegion = gdk_cairo_region;

/// Creates region that describes covers the area where the given
/// `surface` is more than 50% opaque.
///
/// This function takes into account device offsets that might be
/// set with `cairo_surface_set_device_offset`.
extern fn gdk_cairo_region_create_from_surface(p_surface: *cairo.Surface) *cairo.Region;
pub const cairoRegionCreateFromSurface = gdk_cairo_region_create_from_surface;

/// Sets the specified `gdk.Color` as the source color of `cr`.
extern fn gdk_cairo_set_source_color(p_cr: *cairo.Context, p_color: *const gdk.Color) void;
pub const cairoSetSourceColor = gdk_cairo_set_source_color;

/// Sets the given pixbuf as the source pattern for `cr`.
///
/// The pattern has an extend mode of `CAIRO_EXTEND_NONE` and is aligned
/// so that the origin of `pixbuf` is `pixbuf_x`, `pixbuf_y`.
extern fn gdk_cairo_set_source_pixbuf(p_cr: *cairo.Context, p_pixbuf: *const gdkpixbuf.Pixbuf, p_pixbuf_x: f64, p_pixbuf_y: f64) void;
pub const cairoSetSourcePixbuf = gdk_cairo_set_source_pixbuf;

/// Sets the specified `gdk.RGBA` as the source color of `cr`.
extern fn gdk_cairo_set_source_rgba(p_cr: *cairo.Context, p_rgba: *const gdk.RGBA) void;
pub const cairoSetSourceRgba = gdk_cairo_set_source_rgba;

/// Sets the given window as the source pattern for `cr`.
///
/// The pattern has an extend mode of `CAIRO_EXTEND_NONE` and is aligned
/// so that the origin of `window` is `x`, `y`. The window contains all its
/// subwindows when rendering.
///
/// Note that the contents of `window` are undefined outside of the
/// visible part of `window`, so use this function with care.
extern fn gdk_cairo_set_source_window(p_cr: *cairo.Context, p_window: *gdk.Window, p_x: f64, p_y: f64) void;
pub const cairoSetSourceWindow = gdk_cairo_set_source_window;

/// Creates an image surface with the same contents as
/// the pixbuf.
extern fn gdk_cairo_surface_create_from_pixbuf(p_pixbuf: *const gdkpixbuf.Pixbuf, p_scale: c_int, p_for_window: ?*gdk.Window) *cairo.Surface;
pub const cairoSurfaceCreateFromPixbuf = gdk_cairo_surface_create_from_pixbuf;

/// Disables multidevice support in GDK. This call must happen prior
/// to `gdk.Display.open`, `gtk_init`, `gtk_init_with_args` or
/// `gtk_init_check` in order to take effect.
///
/// Most common GTK+ applications won’t ever need to call this. Only
/// applications that do mixed GDK/Xlib calls could want to disable
/// multidevice support if such Xlib code deals with input devices in
/// any way and doesn’t observe the presence of XInput 2.
extern fn gdk_disable_multidevice() void;
pub const disableMultidevice = gdk_disable_multidevice;

/// Aborts a drag without dropping.
///
/// This function is called by the drag source.
///
/// This function does not need to be called in managed drag and drop
/// operations. See `gdk.DragContext.manageDnd` for more information.
extern fn gdk_drag_abort(p_context: *gdk.DragContext, p_time_: u32) void;
pub const dragAbort = gdk_drag_abort;

/// Starts a drag and creates a new drag context for it.
/// This function assumes that the drag is controlled by the
/// client pointer device, use `gdk.dragBeginForDevice` to
/// begin a drag with a different device.
///
/// This function is called by the drag source.
extern fn gdk_drag_begin(p_window: *gdk.Window, p_targets: *glib.List) *gdk.DragContext;
pub const dragBegin = gdk_drag_begin;

/// Starts a drag and creates a new drag context for it.
///
/// This function is called by the drag source.
extern fn gdk_drag_begin_for_device(p_window: *gdk.Window, p_device: *gdk.Device, p_targets: *glib.List) *gdk.DragContext;
pub const dragBeginForDevice = gdk_drag_begin_for_device;

/// Starts a drag and creates a new drag context for it.
///
/// This function is called by the drag source.
extern fn gdk_drag_begin_from_point(p_window: *gdk.Window, p_device: *gdk.Device, p_targets: *glib.List, p_x_root: c_int, p_y_root: c_int) *gdk.DragContext;
pub const dragBeginFromPoint = gdk_drag_begin_from_point;

/// Drops on the current destination.
///
/// This function is called by the drag source.
///
/// This function does not need to be called in managed drag and drop
/// operations. See `gdk.DragContext.manageDnd` for more information.
extern fn gdk_drag_drop(p_context: *gdk.DragContext, p_time_: u32) void;
pub const dragDrop = gdk_drag_drop;

/// Inform GDK if the drop ended successfully. Passing `FALSE`
/// for `success` may trigger a drag cancellation animation.
///
/// This function is called by the drag source, and should
/// be the last call before dropping the reference to the
/// `context`.
///
/// The `gdk.DragContext` will only take the first `gdk.dragDropDone`
/// call as effective, if this function is called multiple times,
/// all subsequent calls will be ignored.
extern fn gdk_drag_drop_done(p_context: *gdk.DragContext, p_success: c_int) void;
pub const dragDropDone = gdk_drag_drop_done;

/// Returns whether the dropped data has been successfully
/// transferred. This function is intended to be used while
/// handling a `GDK_DROP_FINISHED` event, its return value is
/// meaningless at other times.
extern fn gdk_drag_drop_succeeded(p_context: *gdk.DragContext) c_int;
pub const dragDropSucceeded = gdk_drag_drop_succeeded;

/// Finds the destination window and DND protocol to use at the
/// given pointer position.
///
/// This function is called by the drag source to obtain the
/// `dest_window` and `protocol` parameters for `gdk.dragMotion`.
extern fn gdk_drag_find_window_for_screen(p_context: *gdk.DragContext, p_drag_window: *gdk.Window, p_screen: *gdk.Screen, p_x_root: c_int, p_y_root: c_int, p_dest_window: **gdk.Window, p_protocol: *gdk.DragProtocol) void;
pub const dragFindWindowForScreen = gdk_drag_find_window_for_screen;

/// Returns the selection atom for the current source window.
extern fn gdk_drag_get_selection(p_context: *gdk.DragContext) gdk.Atom;
pub const dragGetSelection = gdk_drag_get_selection;

/// Updates the drag context when the pointer moves or the
/// set of actions changes.
///
/// This function is called by the drag source.
///
/// This function does not need to be called in managed drag and drop
/// operations. See `gdk.DragContext.manageDnd` for more information.
extern fn gdk_drag_motion(p_context: *gdk.DragContext, p_dest_window: *gdk.Window, p_protocol: gdk.DragProtocol, p_x_root: c_int, p_y_root: c_int, p_suggested_action: gdk.DragAction, p_possible_actions: gdk.DragAction, p_time_: u32) c_int;
pub const dragMotion = gdk_drag_motion;

/// Selects one of the actions offered by the drag source.
///
/// This function is called by the drag destination in response to
/// `gdk.dragMotion` called by the drag source.
extern fn gdk_drag_status(p_context: *gdk.DragContext, p_action: gdk.DragAction, p_time_: u32) void;
pub const dragStatus = gdk_drag_status;

/// Ends the drag operation after a drop.
///
/// This function is called by the drag destination.
extern fn gdk_drop_finish(p_context: *gdk.DragContext, p_success: c_int, p_time_: u32) void;
pub const dropFinish = gdk_drop_finish;

/// Accepts or rejects a drop.
///
/// This function is called by the drag destination in response
/// to a drop initiated by the drag source.
extern fn gdk_drop_reply(p_context: *gdk.DragContext, p_accepted: c_int, p_time_: u32) void;
pub const dropReply = gdk_drop_reply;

/// Removes an error trap pushed with `gdk.errorTrapPush`.
/// May block until an error has been definitively received
/// or not received from the X server. `gdk.errorTrapPopIgnored`
/// is preferred if you don’t need to know whether an error
/// occurred, because it never has to block. If you don't
/// need the return value of `gdk.errorTrapPop`, use
/// `gdk.errorTrapPopIgnored`.
///
/// Prior to GDK 3.0, this function would not automatically
/// sync for you, so you had to `gdk.flush` if your last
/// call to Xlib was not a blocking round trip.
extern fn gdk_error_trap_pop() c_int;
pub const errorTrapPop = gdk_error_trap_pop;

/// Removes an error trap pushed with `gdk.errorTrapPush`, but
/// without bothering to wait and see whether an error occurred.  If an
/// error arrives later asynchronously that was triggered while the
/// trap was pushed, that error will be ignored.
extern fn gdk_error_trap_pop_ignored() void;
pub const errorTrapPopIgnored = gdk_error_trap_pop_ignored;

/// This function allows X errors to be trapped instead of the normal
/// behavior of exiting the application. It should only be used if it
/// is not possible to avoid the X error in any other way. Errors are
/// ignored on all `gdk.Display` currently known to the
/// `gdk.DisplayManager`. If you don’t care which error happens and just
/// want to ignore everything, pop with `gdk.errorTrapPopIgnored`.
/// If you need the error code, use `gdk.errorTrapPop` which may have
/// to block and wait for the error to arrive from the X server.
///
/// This API exists on all platforms but only does anything on X.
///
/// You can use `gdk_x11_display_error_trap_push` to ignore errors
/// on only a single display.
///
/// ## Trapping an X error
///
/// ```
/// gdk_error_trap_push ();
///
///  // ... Call the X function which may cause an error here ...
///
///
/// if (gdk_error_trap_pop ())
///  {
///    // ... Handle the error here ...
///  }
/// ```
extern fn gdk_error_trap_push() void;
pub const errorTrapPush = gdk_error_trap_push;

/// If both events contain X/Y information, this function will return `TRUE`
/// and return in `angle` the relative angle from `event1` to `event2`. The rotation
/// direction for positive angles is from the positive X axis towards the positive
/// Y axis.
extern fn gdk_events_get_angle(p_event1: *gdk.Event, p_event2: *gdk.Event, p_angle: *f64) c_int;
pub const eventsGetAngle = gdk_events_get_angle;

/// If both events contain X/Y information, the center of both coordinates
/// will be returned in `x` and `y`.
extern fn gdk_events_get_center(p_event1: *gdk.Event, p_event2: *gdk.Event, p_x: *f64, p_y: *f64) c_int;
pub const eventsGetCenter = gdk_events_get_center;

/// If both events have X/Y information, the distance between both coordinates
/// (as in a straight line going from `event1` to `event2`) will be returned.
extern fn gdk_events_get_distance(p_event1: *gdk.Event, p_event2: *gdk.Event, p_distance: *f64) c_int;
pub const eventsGetDistance = gdk_events_get_distance;

/// Checks if any events are ready to be processed for any display.
extern fn gdk_events_pending() c_int;
pub const eventsPending = gdk_events_pending;

/// Flushes the output buffers of all display connections and waits
/// until all requests have been processed.
/// This is rarely needed by applications.
extern fn gdk_flush() void;
pub const flush = gdk_flush;

/// Obtains the root window (parent all other windows are inside)
/// for the default display and screen.
extern fn gdk_get_default_root_window() *gdk.Window;
pub const getDefaultRootWindow = gdk_get_default_root_window;

/// Gets the name of the display, which usually comes from the
/// `DISPLAY` environment variable or the
/// `--display` command line option.
extern fn gdk_get_display() [*:0]u8;
pub const getDisplay = gdk_get_display;

/// Gets the display name specified in the command line arguments passed
/// to `gdk.init` or `gdk.parseArgs`, if any.
extern fn gdk_get_display_arg_name() ?[*:0]const u8;
pub const getDisplayArgName = gdk_get_display_arg_name;

/// Gets the program class. Unless the program class has explicitly
/// been set with `gdk.setProgramClass` or with the `--class`
/// commandline option, the default value is the program name (determined
/// with `glib.getPrgname`) with the first character converted to uppercase.
extern fn gdk_get_program_class() [*:0]const u8;
pub const getProgramClass = gdk_get_program_class;

/// Gets whether event debugging output is enabled.
extern fn gdk_get_show_events() c_int;
pub const getShowEvents = gdk_get_show_events;

/// Initializes the GDK library and connects to the windowing system.
/// If initialization fails, a warning message is output and the application
/// terminates with a call to `exit(1)`.
///
/// Any arguments used by GDK are removed from the array and `argc` and `argv`
/// are updated accordingly.
///
/// GTK+ initializes GDK in `gtk_init` and so this function is not usually
/// needed by GTK+ applications.
extern fn gdk_init(p_argc: *c_int, p_argv: *[*][*:0]u8) void;
pub const init = gdk_init;

/// Initializes the GDK library and connects to the windowing system,
/// returning `TRUE` on success.
///
/// Any arguments used by GDK are removed from the array and `argc` and `argv`
/// are updated accordingly.
///
/// GTK+ initializes GDK in `gtk_init` and so this function is not usually
/// needed by GTK+ applications.
extern fn gdk_init_check(p_argc: *c_int, p_argv: *[*][*:0]u8) c_int;
pub const initCheck = gdk_init_check;

/// Grabs the keyboard so that all events are passed to this
/// application until the keyboard is ungrabbed with `gdk.keyboardUngrab`.
/// This overrides any previous keyboard grab by this client.
///
/// If you set up anything at the time you take the grab that needs to be cleaned
/// up when the grab ends, you should handle the `gdk.EventGrabBroken` events that
/// are emitted when the grab ends unvoluntarily.
extern fn gdk_keyboard_grab(p_window: *gdk.Window, p_owner_events: c_int, p_time_: u32) gdk.GrabStatus;
pub const keyboardGrab = gdk_keyboard_grab;

/// Ungrabs the keyboard on the default display, if it is grabbed by this
/// application.
extern fn gdk_keyboard_ungrab(p_time_: u32) void;
pub const keyboardUngrab = gdk_keyboard_ungrab;

/// Obtains the upper- and lower-case versions of the keyval `symbol`.
/// Examples of keyvals are `GDK_KEY_a`, `GDK_KEY_Enter`, `GDK_KEY_F1`, etc.
extern fn gdk_keyval_convert_case(p_symbol: c_uint, p_lower: *c_uint, p_upper: *c_uint) void;
pub const keyvalConvertCase = gdk_keyval_convert_case;

/// Converts a key name to a key value.
///
/// The names are the same as those in the
/// `gdk/gdkkeysyms.h` header file
/// but without the leading “GDK_KEY_”.
extern fn gdk_keyval_from_name(p_keyval_name: [*:0]const u8) c_uint;
pub const keyvalFromName = gdk_keyval_from_name;

/// Returns `TRUE` if the given key value is in lower case.
extern fn gdk_keyval_is_lower(p_keyval: c_uint) c_int;
pub const keyvalIsLower = gdk_keyval_is_lower;

/// Returns `TRUE` if the given key value is in upper case.
extern fn gdk_keyval_is_upper(p_keyval: c_uint) c_int;
pub const keyvalIsUpper = gdk_keyval_is_upper;

/// Converts a key value into a symbolic name.
///
/// The names are the same as those in the
/// `gdk/gdkkeysyms.h` header file
/// but without the leading “GDK_KEY_”.
extern fn gdk_keyval_name(p_keyval: c_uint) ?[*:0]u8;
pub const keyvalName = gdk_keyval_name;

/// Converts a key value to lower case, if applicable.
extern fn gdk_keyval_to_lower(p_keyval: c_uint) c_uint;
pub const keyvalToLower = gdk_keyval_to_lower;

/// Convert from a GDK key symbol to the corresponding ISO10646 (Unicode)
/// character.
extern fn gdk_keyval_to_unicode(p_keyval: c_uint) u32;
pub const keyvalToUnicode = gdk_keyval_to_unicode;

/// Converts a key value to upper case, if applicable.
extern fn gdk_keyval_to_upper(p_keyval: c_uint) c_uint;
pub const keyvalToUpper = gdk_keyval_to_upper;

/// Lists the available visuals for the default screen.
/// (See `gdk.Screen.listVisuals`)
/// A visual describes a hardware image data format.
/// For example, a visual might support 24-bit color, or 8-bit color,
/// and might expect pixels to be in a certain format.
///
/// Call `glib.List.free` on the return value when you’re finished with it.
extern fn gdk_list_visuals() *glib.List;
pub const listVisuals = gdk_list_visuals;

/// Indicates to the GUI environment that the application has finished
/// loading. If the applications opens windows, this function is
/// normally called after opening the application’s initial set of
/// windows.
///
/// GTK+ will call this function automatically after opening the first
/// `GtkWindow` unless `gtk_window_set_auto_startup_notification` is called
/// to disable that feature.
extern fn gdk_notify_startup_complete() void;
pub const notifyStartupComplete = gdk_notify_startup_complete;

/// Indicates to the GUI environment that the application has
/// finished loading, using a given identifier.
///
/// GTK+ will call this function automatically for `GtkWindow`
/// with custom startup-notification identifier unless
/// `gtk_window_set_auto_startup_notification` is called to
/// disable that feature.
extern fn gdk_notify_startup_complete_with_id(p_startup_id: [*:0]const u8) void;
pub const notifyStartupCompleteWithId = gdk_notify_startup_complete_with_id;

/// Gets the window that `window` is embedded in.
extern fn gdk_offscreen_window_get_embedder(p_window: *gdk.Window) ?*gdk.Window;
pub const offscreenWindowGetEmbedder = gdk_offscreen_window_get_embedder;

/// Gets the offscreen surface that an offscreen window renders into.
/// If you need to keep this around over window resizes, you need to
/// add a reference to it.
extern fn gdk_offscreen_window_get_surface(p_window: *gdk.Window) ?*cairo.Surface;
pub const offscreenWindowGetSurface = gdk_offscreen_window_get_surface;

/// Sets `window` to be embedded in `embedder`.
///
/// To fully embed an offscreen window, in addition to calling this
/// function, it is also necessary to handle the `gdk.Window.signals.pick`-embedded-child
/// signal on the `embedder` and the `gdk.Window.signals.to`-embedder and
/// `gdk.Window.signals.from`-embedder signals on `window`.
extern fn gdk_offscreen_window_set_embedder(p_window: *gdk.Window, p_embedder: *gdk.Window) void;
pub const offscreenWindowSetEmbedder = gdk_offscreen_window_set_embedder;

/// Creates a `pango.Context` for the default GDK screen.
///
/// The context must be freed when you’re finished with it.
///
/// When using GTK+, normally you should use `gtk_widget_get_pango_context`
/// instead of this function, to get the appropriate context for
/// the widget you intend to render text onto.
///
/// The newly created context will have the default font options (see
/// `cairo.FontOptions`) for the default screen; if these options
/// change it will not be updated. Using `gtk_widget_get_pango_context`
/// is more convenient if you want to keep a context around and track
/// changes to the screen’s font rendering settings.
extern fn gdk_pango_context_get() *pango.Context;
pub const pangoContextGet = gdk_pango_context_get;

/// Creates a `pango.Context` for `display`.
///
/// The context must be freed when you’re finished with it.
///
/// When using GTK+, normally you should use `gtk_widget_get_pango_context`
/// instead of this function, to get the appropriate context for
/// the widget you intend to render text onto.
///
/// The newly created context will have the default font options
/// (see `cairo.FontOptions`) for the display; if these options
/// change it will not be updated. Using `gtk_widget_get_pango_context`
/// is more convenient if you want to keep a context around and track
/// changes to the font rendering settings.
extern fn gdk_pango_context_get_for_display(p_display: *gdk.Display) *pango.Context;
pub const pangoContextGetForDisplay = gdk_pango_context_get_for_display;

/// Creates a `pango.Context` for `screen`.
///
/// The context must be freed when you’re finished with it.
///
/// When using GTK+, normally you should use `gtk_widget_get_pango_context`
/// instead of this function, to get the appropriate context for
/// the widget you intend to render text onto.
///
/// The newly created context will have the default font options
/// (see `cairo.FontOptions`) for the screen; if these options
/// change it will not be updated. Using `gtk_widget_get_pango_context`
/// is more convenient if you want to keep a context around and track
/// changes to the screen’s font rendering settings.
extern fn gdk_pango_context_get_for_screen(p_screen: *gdk.Screen) *pango.Context;
pub const pangoContextGetForScreen = gdk_pango_context_get_for_screen;

/// Obtains a clip region which contains the areas where the given ranges
/// of text would be drawn. `x_origin` and `y_origin` are the top left point
/// to center the layout. `index_ranges` should contain
/// ranges of bytes in the layout’s text.
///
/// Note that the regions returned correspond to logical extents of the text
/// ranges, not ink extents. So the drawn layout may in fact touch areas out of
/// the clip region.  The clip region is mainly useful for highlightling parts
/// of text, such as when text is selected.
extern fn gdk_pango_layout_get_clip_region(p_layout: *pango.Layout, p_x_origin: c_int, p_y_origin: c_int, p_index_ranges: *const c_int, p_n_ranges: c_int) *cairo.Region;
pub const pangoLayoutGetClipRegion = gdk_pango_layout_get_clip_region;

/// Obtains a clip region which contains the areas where the given
/// ranges of text would be drawn. `x_origin` and `y_origin` are the top left
/// position of the layout. `index_ranges`
/// should contain ranges of bytes in the layout’s text. The clip
/// region will include space to the left or right of the line (to the
/// layout bounding box) if you have indexes above or below the indexes
/// contained inside the line. This is to draw the selection all the way
/// to the side of the layout. However, the clip region is in line coordinates,
/// not layout coordinates.
///
/// Note that the regions returned correspond to logical extents of the text
/// ranges, not ink extents. So the drawn line may in fact touch areas out of
/// the clip region.  The clip region is mainly useful for highlightling parts
/// of text, such as when text is selected.
extern fn gdk_pango_layout_line_get_clip_region(p_line: *pango.LayoutLine, p_x_origin: c_int, p_y_origin: c_int, p_index_ranges: [*]const c_int, p_n_ranges: c_int) *cairo.Region;
pub const pangoLayoutLineGetClipRegion = gdk_pango_layout_line_get_clip_region;

/// Parse command line arguments, and store for future
/// use by calls to `gdk.Display.open`.
///
/// Any arguments used by GDK are removed from the array and `argc` and `argv` are
/// updated accordingly.
///
/// You shouldn’t call this function explicitly if you are using
/// `gtk_init`, `gtk_init_check`, `gdk.init`, or `gdk.initCheck`.
extern fn gdk_parse_args(p_argc: *c_int, p_argv: *[*][*:0]u8) void;
pub const parseArgs = gdk_parse_args;

/// Transfers image data from a `cairo.Surface` and converts it to an RGB(A)
/// representation inside a `gdkpixbuf.Pixbuf`. This allows you to efficiently read
/// individual pixels from cairo surfaces. For `GdkWindows`, use
/// `gdk.pixbufGetFromWindow` instead.
///
/// This function will create an RGB pixbuf with 8 bits per channel.
/// The pixbuf will contain an alpha channel if the `surface` contains one.
extern fn gdk_pixbuf_get_from_surface(p_surface: *cairo.Surface, p_src_x: c_int, p_src_y: c_int, p_width: c_int, p_height: c_int) ?*gdkpixbuf.Pixbuf;
pub const pixbufGetFromSurface = gdk_pixbuf_get_from_surface;

/// Transfers image data from a `gdk.Window` and converts it to an RGB(A)
/// representation inside a `gdkpixbuf.Pixbuf`.
///
/// In other words, copies image data from a server-side drawable to a
/// client-side RGB(A) buffer. This allows you to efficiently read
/// individual pixels on the client side.
///
/// This function will create an RGB pixbuf with 8 bits per channel with
/// the size specified by the `width` and `height` arguments scaled by the
/// scale factor of `window`. The pixbuf will contain an alpha channel if
/// the `window` contains one.
///
/// If the window is off the screen, then there is no image data in the
/// obscured/offscreen regions to be placed in the pixbuf. The contents of
/// portions of the pixbuf corresponding to the offscreen region are
/// undefined.
///
/// If the window you’re obtaining data from is partially obscured by
/// other windows, then the contents of the pixbuf areas corresponding
/// to the obscured regions are undefined.
///
/// If the window is not mapped (typically because it’s iconified/minimized
/// or not on the current workspace), then `NULL` will be returned.
///
/// If memory can’t be allocated for the return value, `NULL` will be returned
/// instead.
///
/// In short, there are several ways this function can fail, and if it fails
/// it returns `NULL`; so check the return value.
///
/// You should rarely, if ever, need to call this function.
extern fn gdk_pixbuf_get_from_window(p_window: *gdk.Window, p_src_x: c_int, p_src_y: c_int, p_width: c_int, p_height: c_int) ?*gdkpixbuf.Pixbuf;
pub const pixbufGetFromWindow = gdk_pixbuf_get_from_window;

/// Grabs the pointer (usually a mouse) so that all events are passed to this
/// application until the pointer is ungrabbed with `gdk.pointerUngrab`, or
/// the grab window becomes unviewable.
/// This overrides any previous pointer grab by this client.
///
/// Pointer grabs are used for operations which need complete control over mouse
/// events, even if the mouse leaves the application.
/// For example in GTK+ it is used for Drag and Drop, for dragging the handle in
/// the `GtkHPaned` and `GtkVPaned` widgets.
///
/// Note that if the event mask of an X window has selected both button press and
/// button release events, then a button press event will cause an automatic
/// pointer grab until the button is released.
/// X does this automatically since most applications expect to receive button
/// press and release events in pairs.
/// It is equivalent to a pointer grab on the window with `owner_events` set to
/// `TRUE`.
///
/// If you set up anything at the time you take the grab that needs to be cleaned
/// up when the grab ends, you should handle the `gdk.EventGrabBroken` events that
/// are emitted when the grab ends unvoluntarily.
extern fn gdk_pointer_grab(p_window: *gdk.Window, p_owner_events: c_int, p_event_mask: gdk.EventMask, p_confine_to: ?*gdk.Window, p_cursor: ?*gdk.Cursor, p_time_: u32) gdk.GrabStatus;
pub const pointerGrab = gdk_pointer_grab;

/// Returns `TRUE` if the pointer on the default display is currently
/// grabbed by this application.
///
/// Note that this does not take the inmplicit pointer grab on button
/// presses into account.
extern fn gdk_pointer_is_grabbed() c_int;
pub const pointerIsGrabbed = gdk_pointer_is_grabbed;

/// Ungrabs the pointer on the default display, if it is grabbed by this
/// application.
extern fn gdk_pointer_ungrab(p_time_: u32) void;
pub const pointerUngrab = gdk_pointer_ungrab;

/// Prepare for parsing command line arguments for GDK. This is not
/// public API and should not be used in application code.
extern fn gdk_pre_parse_libgtk_only() void;
pub const preParseLibgtkOnly = gdk_pre_parse_libgtk_only;

/// Changes the contents of a property on a window.
extern fn gdk_property_change(p_window: *gdk.Window, p_property: gdk.Atom, p_type: gdk.Atom, p_format: c_int, p_mode: gdk.PropMode, p_data: *const u8, p_nelements: c_int) void;
pub const propertyChange = gdk_property_change;

/// Deletes a property from a window.
extern fn gdk_property_delete(p_window: *gdk.Window, p_property: gdk.Atom) void;
pub const propertyDelete = gdk_property_delete;

/// Retrieves a portion of the contents of a property. If the
/// property does not exist, then the function returns `FALSE`,
/// and `GDK_NONE` will be stored in `actual_property_type`.
///
/// The `XGetWindowProperty` function that `gdk.propertyGet`
/// uses has a very confusing and complicated set of semantics.
/// Unfortunately, `gdk.propertyGet` makes the situation
/// worse instead of better (the semantics should be considered
/// undefined), and also prints warnings to stderr in cases where it
/// should return a useful error to the program. You are advised to use
/// `XGetWindowProperty` directly until a replacement function for
/// `gdk.propertyGet` is provided.
extern fn gdk_property_get(p_window: *gdk.Window, p_property: gdk.Atom, p_type: gdk.Atom, p_offset: c_ulong, p_length: c_ulong, p_pdelete: c_int, p_actual_property_type: *gdk.Atom, p_actual_format: *c_int, p_actual_length: *c_int, p_data: *[*]u8) c_int;
pub const propertyGet = gdk_property_get;

/// This function returns the available bit depths for the default
/// screen. It’s equivalent to listing the visuals
/// (`gdk.listVisuals`) and then looking at the depth field in each
/// visual, removing duplicates.
///
/// The array returned by this function should not be freed.
extern fn gdk_query_depths(p_depths: *[*]c_int, p_count: *c_int) void;
pub const queryDepths = gdk_query_depths;

/// This function returns the available visual types for the default
/// screen. It’s equivalent to listing the visuals
/// (`gdk.listVisuals`) and then looking at the type field in each
/// visual, removing duplicates.
///
/// The array returned by this function should not be freed.
extern fn gdk_query_visual_types(p_visual_types: *[*]gdk.VisualType, p_count: *c_int) void;
pub const queryVisualTypes = gdk_query_visual_types;

/// Retrieves the contents of a selection in a given
/// form.
extern fn gdk_selection_convert(p_requestor: *gdk.Window, p_selection: gdk.Atom, p_target: gdk.Atom, p_time_: u32) void;
pub const selectionConvert = gdk_selection_convert;

/// Determines the owner of the given selection.
extern fn gdk_selection_owner_get(p_selection: gdk.Atom) ?*gdk.Window;
pub const selectionOwnerGet = gdk_selection_owner_get;

/// Determine the owner of the given selection.
///
/// Note that the return value may be owned by a different
/// process if a foreign window was previously created for that
/// window, but a new foreign window will never be created by this call.
extern fn gdk_selection_owner_get_for_display(p_display: *gdk.Display, p_selection: gdk.Atom) ?*gdk.Window;
pub const selectionOwnerGetForDisplay = gdk_selection_owner_get_for_display;

/// Sets the owner of the given selection.
extern fn gdk_selection_owner_set(p_owner: ?*gdk.Window, p_selection: gdk.Atom, p_time_: u32, p_send_event: c_int) c_int;
pub const selectionOwnerSet = gdk_selection_owner_set;

/// Sets the `gdk.Window` `owner` as the current owner of the selection `selection`.
extern fn gdk_selection_owner_set_for_display(p_display: *gdk.Display, p_owner: ?*gdk.Window, p_selection: gdk.Atom, p_time_: u32, p_send_event: c_int) c_int;
pub const selectionOwnerSetForDisplay = gdk_selection_owner_set_for_display;

/// Retrieves selection data that was stored by the selection
/// data in response to a call to `gdk.selectionConvert`. This function
/// will not be used by applications, who should use the `GtkClipboard`
/// API instead.
extern fn gdk_selection_property_get(p_requestor: *gdk.Window, p_data: **u8, p_prop_type: *gdk.Atom, p_prop_format: *c_int) c_int;
pub const selectionPropertyGet = gdk_selection_property_get;

/// Sends a response to SelectionRequest event.
extern fn gdk_selection_send_notify(p_requestor: *gdk.Window, p_selection: gdk.Atom, p_target: gdk.Atom, p_property: gdk.Atom, p_time_: u32) void;
pub const selectionSendNotify = gdk_selection_send_notify;

/// Send a response to SelectionRequest event.
extern fn gdk_selection_send_notify_for_display(p_display: *gdk.Display, p_requestor: *gdk.Window, p_selection: gdk.Atom, p_target: gdk.Atom, p_property: gdk.Atom, p_time_: u32) void;
pub const selectionSendNotifyForDisplay = gdk_selection_send_notify_for_display;

/// Sets a list of backends that GDK should try to use.
///
/// This can be be useful if your application does not
/// work with certain GDK backends.
///
/// By default, GDK tries all included backends.
///
/// For example,
/// ```
/// gdk_set_allowed_backends ("wayland,quartz,*");
/// ```
/// instructs GDK to try the Wayland backend first,
/// followed by the Quartz backend, and then all
/// others.
///
/// If the `GDK_BACKEND` environment variable
/// is set, it determines what backends are tried in what
/// order, while still respecting the set of allowed backends
/// that are specified by this function.
///
/// The possible backend names are x11, win32, quartz,
/// broadway, wayland. You can also include a * in the
/// list to try all remaining backends.
///
/// This call must happen prior to `gdk.Display.open`,
/// `gtk_init`, `gtk_init_with_args` or `gtk_init_check`
/// in order to take effect.
extern fn gdk_set_allowed_backends(p_backends: [*:0]const u8) void;
pub const setAllowedBackends = gdk_set_allowed_backends;

/// Set the double click time for the default display. See
/// `gdk.Display.setDoubleClickTime`.
/// See also `gdk.Display.setDoubleClickDistance`.
/// Applications should not set this, it is a
/// global user-configured setting.
extern fn gdk_set_double_click_time(p_msec: c_uint) void;
pub const setDoubleClickTime = gdk_set_double_click_time;

/// Sets the program class. The X11 backend uses the program class to set
/// the class name part of the `WM_CLASS` property on
/// toplevel windows; see the ICCCM.
///
/// The program class can still be overridden with the --class command
/// line option.
extern fn gdk_set_program_class(p_program_class: [*:0]const u8) void;
pub const setProgramClass = gdk_set_program_class;

/// Sets whether a trace of received events is output.
/// Note that GTK+ must be compiled with debugging (that is,
/// configured using the `--enable-debug` option)
/// to use this option.
extern fn gdk_set_show_events(p_show_events: c_int) void;
pub const setShowEvents = gdk_set_show_events;

/// Obtains a desktop-wide setting, such as the double-click time,
/// for the default screen. See `gdk.Screen.getSetting`.
extern fn gdk_setting_get(p_name: [*:0]const u8, p_value: *gobject.Value) c_int;
pub const settingGet = gdk_setting_get;

extern fn gdk_synthesize_window_state(p_window: *gdk.Window, p_unset_flags: gdk.WindowState, p_set_flags: gdk.WindowState) void;
pub const synthesizeWindowState = gdk_synthesize_window_state;

/// Retrieves a pixel from `window` to force the windowing
/// system to carry out any pending rendering commands.
///
/// This function is intended to be used to synchronize with rendering
/// pipelines, to benchmark windowing system rendering operations.
extern fn gdk_test_render_sync(p_window: *gdk.Window) void;
pub const testRenderSync = gdk_test_render_sync;

/// This function is intended to be used in GTK+ test programs.
/// It will warp the mouse pointer to the given (`x`,`y`) coordinates
/// within `window` and simulate a button press or release event.
/// Because the mouse pointer needs to be warped to the target
/// location, use of this function outside of test programs that
/// run in their own virtual windowing system (e.g. Xvfb) is not
/// recommended.
///
/// Also, `gdk.testSimulateButton` is a fairly low level function,
/// for most testing purposes, `gtk_test_widget_click` is the right
/// function to call which will generate a button press event followed
/// by its accompanying button release event.
extern fn gdk_test_simulate_button(p_window: *gdk.Window, p_x: c_int, p_y: c_int, p_button: c_uint, p_modifiers: gdk.ModifierType, p_button_pressrelease: gdk.EventType) c_int;
pub const testSimulateButton = gdk_test_simulate_button;

/// This function is intended to be used in GTK+ test programs.
/// If (`x`,`y`) are > (-1,-1), it will warp the mouse pointer to
/// the given (`x`,`y`) coordinates within `window` and simulate a
/// key press or release event.
///
/// When the mouse pointer is warped to the target location, use
/// of this function outside of test programs that run in their
/// own virtual windowing system (e.g. Xvfb) is not recommended.
/// If (`x`,`y`) are passed as (-1,-1), the mouse pointer will not
/// be warped and `window` origin will be used as mouse pointer
/// location for the event.
///
/// Also, `gdk.testSimulateKey` is a fairly low level function,
/// for most testing purposes, `gtk_test_widget_send_key` is the
/// right function to call which will generate a key press event
/// followed by its accompanying key release event.
extern fn gdk_test_simulate_key(p_window: *gdk.Window, p_x: c_int, p_y: c_int, p_keyval: c_uint, p_modifiers: gdk.ModifierType, p_key_pressrelease: gdk.EventType) c_int;
pub const testSimulateKey = gdk_test_simulate_key;

/// Converts a text property in the given encoding to
/// a list of UTF-8 strings.
extern fn gdk_text_property_to_utf8_list_for_display(p_display: *gdk.Display, p_encoding: gdk.Atom, p_format: c_int, p_text: [*]const u8, p_length: c_int, p_list: *[*][*:0]u8) c_int;
pub const textPropertyToUtf8ListForDisplay = gdk_text_property_to_utf8_list_for_display;

/// A wrapper for the common usage of `gdk.threadsAddIdleFull`
/// assigning the default priority, `G_PRIORITY_DEFAULT_IDLE`.
///
/// See `gdk.threadsAddIdleFull`.
extern fn gdk_threads_add_idle(p_function: glib.SourceFunc, p_data: ?*anyopaque) c_uint;
pub const threadsAddIdle = gdk_threads_add_idle;

/// Adds a function to be called whenever there are no higher priority
/// events pending.  If the function returns `FALSE` it is automatically
/// removed from the list of event sources and will not be called again.
///
/// This variant of `glib.idleAddFull` calls `function` with the GDK lock
/// held. It can be thought of a MT-safe version for GTK+ widgets for the
/// following use case, where you have to worry about `idle_callback`
/// running in thread A and accessing `self` after it has been finalized
/// in thread B:
///
/// ```
/// static gboolean
/// idle_callback (gpointer data)
/// {
///    // `gdk.threadsEnter`; would be needed for `glib.idleAdd`
///
///    SomeWidget *self = data;
///    // do stuff with self
///
///    self->idle_id = 0;
///
///    // `gdk.threadsLeave`; would be needed for `glib.idleAdd`
///    return FALSE;
/// }
///
/// static void
/// some_widget_do_stuff_later (SomeWidget *self)
/// {
///    self->idle_id = gdk_threads_add_idle (idle_callback, self)
///    // using `glib.idleAdd` here would require thread protection in the callback
/// }
///
/// static void
/// some_widget_finalize (GObject *object)
/// {
///    SomeWidget *self = SOME_WIDGET (object);
///    if (self->idle_id)
///      g_source_remove (self->idle_id);
///    G_OBJECT_CLASS (parent_class)->finalize (object);
/// }
/// ```
extern fn gdk_threads_add_idle_full(p_priority: c_int, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const threadsAddIdleFull = gdk_threads_add_idle_full;

/// A wrapper for the common usage of `gdk.threadsAddTimeoutFull`
/// assigning the default priority, `G_PRIORITY_DEFAULT`.
///
/// See `gdk.threadsAddTimeoutFull`.
extern fn gdk_threads_add_timeout(p_interval: c_uint, p_function: glib.SourceFunc, p_data: ?*anyopaque) c_uint;
pub const threadsAddTimeout = gdk_threads_add_timeout;

/// Sets a function to be called at regular intervals holding the GDK lock,
/// with the given priority.  The function is called repeatedly until it
/// returns `FALSE`, at which point the timeout is automatically destroyed
/// and the function will not be called again.  The `notify` function is
/// called when the timeout is destroyed.  The first call to the
/// function will be at the end of the first `interval`.
///
/// Note that timeout functions may be delayed, due to the processing of other
/// event sources. Thus they should not be relied on for precise timing.
/// After each call to the timeout function, the time of the next
/// timeout is recalculated based on the current time and the given interval
/// (it does not try to “catch up” time lost in delays).
///
/// This variant of `glib.timeoutAddFull` can be thought of a MT-safe version
/// for GTK+ widgets for the following use case:
///
/// ```
/// static gboolean timeout_callback (gpointer data)
/// {
///    SomeWidget *self = data;
///
///    // do stuff with self
///
///    self->timeout_id = 0;
///
///    return G_SOURCE_REMOVE;
/// }
///
/// static void some_widget_do_stuff_later (SomeWidget *self)
/// {
///    self->timeout_id = g_timeout_add (timeout_callback, self)
/// }
///
/// static void some_widget_finalize (GObject *object)
/// {
///    SomeWidget *self = SOME_WIDGET (object);
///
///    if (self->timeout_id)
///      g_source_remove (self->timeout_id);
///
///    G_OBJECT_CLASS (parent_class)->finalize (object);
/// }
/// ```
extern fn gdk_threads_add_timeout_full(p_priority: c_int, p_interval: c_uint, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const threadsAddTimeoutFull = gdk_threads_add_timeout_full;

/// A wrapper for the common usage of `gdk.threadsAddTimeoutSecondsFull`
/// assigning the default priority, `G_PRIORITY_DEFAULT`.
///
/// For details, see `gdk.threadsAddTimeoutFull`.
extern fn gdk_threads_add_timeout_seconds(p_interval: c_uint, p_function: glib.SourceFunc, p_data: ?*anyopaque) c_uint;
pub const threadsAddTimeoutSeconds = gdk_threads_add_timeout_seconds;

/// A variant of `gdk.threadsAddTimeoutFull` with second-granularity.
/// See `glib.timeoutAddSecondsFull` for a discussion of why it is
/// a good idea to use this function if you don’t need finer granularity.
extern fn gdk_threads_add_timeout_seconds_full(p_priority: c_int, p_interval: c_uint, p_function: glib.SourceFunc, p_data: ?*anyopaque, p_notify: ?glib.DestroyNotify) c_uint;
pub const threadsAddTimeoutSecondsFull = gdk_threads_add_timeout_seconds_full;

/// This function marks the beginning of a critical section in which
/// GDK and GTK+ functions can be called safely and without causing race
/// conditions. Only one thread at a time can be in such a critial
/// section.
extern fn gdk_threads_enter() void;
pub const threadsEnter = gdk_threads_enter;

/// Initializes GDK so that it can be used from multiple threads
/// in conjunction with `gdk.threadsEnter` and `gdk.threadsLeave`.
///
/// This call must be made before any use of the main loop from
/// GTK+; to be safe, call it before `gtk_init`.
extern fn gdk_threads_init() void;
pub const threadsInit = gdk_threads_init;

/// Leaves a critical region begun with `gdk.threadsEnter`.
extern fn gdk_threads_leave() void;
pub const threadsLeave = gdk_threads_leave;

/// Allows the application to replace the standard method that
/// GDK uses to protect its data structures. Normally, GDK
/// creates a single `glib.Mutex` that is locked by `gdk.threadsEnter`,
/// and released by `gdk.threadsLeave`; using this function an
/// application provides, instead, a function `enter_fn` that is
/// called by `gdk.threadsEnter` and a function `leave_fn` that is
/// called by `gdk.threadsLeave`.
///
/// The functions must provide at least same locking functionality
/// as the default implementation, but can also do extra application
/// specific processing.
///
/// As an example, consider an application that has its own recursive
/// lock that when held, holds the GTK+ lock as well. When GTK+ unlocks
/// the GTK+ lock when entering a recursive main loop, the application
/// must temporarily release its lock as well.
///
/// Most threaded GTK+ apps won’t need to use this method.
///
/// This method must be called before `gdk.threadsInit`, and cannot
/// be called multiple times.
extern fn gdk_threads_set_lock_functions(p_enter_fn: gobject.Callback, p_leave_fn: gobject.Callback) void;
pub const threadsSetLockFunctions = gdk_threads_set_lock_functions;

/// Convert from a ISO10646 character to a key symbol.
extern fn gdk_unicode_to_keyval(p_wc: u32) c_uint;
pub const unicodeToKeyval = gdk_unicode_to_keyval;

/// Converts an UTF-8 string into the best possible representation
/// as a STRING. The representation of characters not in STRING
/// is not specified; it may be as pseudo-escape sequences
/// \x{ABCD}, or it may be in some other form of approximation.
extern fn gdk_utf8_to_string_target(p_str: [*:0]const u8) ?[*:0]u8;
pub const utf8ToStringTarget = gdk_utf8_to_string_target;

/// Specifies the type of function passed to `gdk.eventHandlerSet` to
/// handle all GDK events.
pub const EventFunc = *const fn (p_event: *gdk.Event, p_data: ?*anyopaque) callconv(.c) void;

/// Specifies the type of function used to filter native events before they are
/// converted to GDK events.
///
/// When a filter is called, `event` is unpopulated, except for
/// `event->window`. The filter may translate the native
/// event to a GDK event and store the result in `event`, or handle it without
/// translation. If the filter translates the event and processing should
/// continue, it should return `GDK_FILTER_TRANSLATE`.
pub const FilterFunc = *const fn (p_xevent: *gdk.XEvent, p_event: *gdk.Event, p_data: ?*anyopaque) callconv(.c) gdk.FilterReturn;

/// Type of the callback used to set up `window` so it can be
/// grabbed. A typical action would be ensuring the window is
/// visible, although there's room for other initialization
/// actions.
pub const SeatGrabPrepareFunc = *const fn (p_seat: *gdk.Seat, p_window: *gdk.Window, p_user_data: ?*anyopaque) callconv(.c) void;

/// A function of this type is passed to `gdk.Window.invalidateMaybeRecurse`.
/// It gets called for each child of the window to determine whether to
/// recursively invalidate it or now.
pub const WindowChildFunc = *const fn (p_window: *gdk.Window, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// Whenever some area of the window is invalidated (directly in the
/// window or in a child window) this gets called with `region` in
/// the coordinate space of `window`. You can use `region` to just
/// keep track of the dirty region, or you can actually change
/// `region` in case you are doing display tricks like showing
/// a child in multiple places.
pub const WindowInvalidateHandlerFunc = *const fn (p_window: *gdk.Window, p_region: *cairo.Region) callconv(.c) void;

/// The middle button.
pub const BUTTON_MIDDLE = 2;
/// The primary button. This is typically the left mouse button, or the
/// right button in a left-handed setup.
pub const BUTTON_PRIMARY = 1;
/// The secondary button. This is typically the right mouse button, or the
/// left button in a left-handed setup.
pub const BUTTON_SECONDARY = 3;
/// Represents the current time, and can be used anywhere a time is expected.
pub const CURRENT_TIME = 0;
/// Use this macro as the return value for continuing the propagation of
/// an event handler.
pub const EVENT_PROPAGATE = false;
/// Use this macro as the return value for stopping the propagation of
/// an event handler.
pub const EVENT_STOP = true;
pub const KEY_0 = 48;
pub const KEY_1 = 49;
pub const KEY_2 = 50;
pub const KEY_3 = 51;
pub const KEY_3270_AltCursor = 64784;
pub const KEY_3270_Attn = 64782;
pub const KEY_3270_BackTab = 64773;
pub const KEY_3270_ChangeScreen = 64793;
pub const KEY_3270_Copy = 64789;
pub const KEY_3270_CursorBlink = 64783;
pub const KEY_3270_CursorSelect = 64796;
pub const KEY_3270_DeleteWord = 64794;
pub const KEY_3270_Duplicate = 64769;
pub const KEY_3270_Enter = 64798;
pub const KEY_3270_EraseEOF = 64774;
pub const KEY_3270_EraseInput = 64775;
pub const KEY_3270_ExSelect = 64795;
pub const KEY_3270_FieldMark = 64770;
pub const KEY_3270_Ident = 64787;
pub const KEY_3270_Jump = 64786;
pub const KEY_3270_KeyClick = 64785;
pub const KEY_3270_Left2 = 64772;
pub const KEY_3270_PA1 = 64778;
pub const KEY_3270_PA2 = 64779;
pub const KEY_3270_PA3 = 64780;
pub const KEY_3270_Play = 64790;
pub const KEY_3270_PrintScreen = 64797;
pub const KEY_3270_Quit = 64777;
pub const KEY_3270_Record = 64792;
pub const KEY_3270_Reset = 64776;
pub const KEY_3270_Right2 = 64771;
pub const KEY_3270_Rule = 64788;
pub const KEY_3270_Setup = 64791;
pub const KEY_3270_Test = 64781;
pub const KEY_4 = 52;
pub const KEY_5 = 53;
pub const KEY_6 = 54;
pub const KEY_7 = 55;
pub const KEY_8 = 56;
pub const KEY_9 = 57;
pub const KEY_A = 65;
pub const KEY_AE = 198;
pub const KEY_Aacute = 193;
pub const KEY_Abelowdot = 16785056;
pub const KEY_Abreve = 451;
pub const KEY_Abreveacute = 16785070;
pub const KEY_Abrevebelowdot = 16785078;
pub const KEY_Abrevegrave = 16785072;
pub const KEY_Abrevehook = 16785074;
pub const KEY_Abrevetilde = 16785076;
pub const KEY_AccessX_Enable = 65136;
pub const KEY_AccessX_Feedback_Enable = 65137;
pub const KEY_Acircumflex = 194;
pub const KEY_Acircumflexacute = 16785060;
pub const KEY_Acircumflexbelowdot = 16785068;
pub const KEY_Acircumflexgrave = 16785062;
pub const KEY_Acircumflexhook = 16785064;
pub const KEY_Acircumflextilde = 16785066;
pub const KEY_AddFavorite = 269025081;
pub const KEY_Adiaeresis = 196;
pub const KEY_Agrave = 192;
pub const KEY_Ahook = 16785058;
pub const KEY_Alt_L = 65513;
pub const KEY_Alt_R = 65514;
pub const KEY_Amacron = 960;
pub const KEY_Aogonek = 417;
pub const KEY_ApplicationLeft = 269025104;
pub const KEY_ApplicationRight = 269025105;
pub const KEY_Arabic_0 = 16778848;
pub const KEY_Arabic_1 = 16778849;
pub const KEY_Arabic_2 = 16778850;
pub const KEY_Arabic_3 = 16778851;
pub const KEY_Arabic_4 = 16778852;
pub const KEY_Arabic_5 = 16778853;
pub const KEY_Arabic_6 = 16778854;
pub const KEY_Arabic_7 = 16778855;
pub const KEY_Arabic_8 = 16778856;
pub const KEY_Arabic_9 = 16778857;
pub const KEY_Arabic_ain = 1497;
pub const KEY_Arabic_alef = 1479;
pub const KEY_Arabic_alefmaksura = 1513;
pub const KEY_Arabic_beh = 1480;
pub const KEY_Arabic_comma = 1452;
pub const KEY_Arabic_dad = 1494;
pub const KEY_Arabic_dal = 1487;
pub const KEY_Arabic_damma = 1519;
pub const KEY_Arabic_dammatan = 1516;
pub const KEY_Arabic_ddal = 16778888;
pub const KEY_Arabic_farsi_yeh = 16778956;
pub const KEY_Arabic_fatha = 1518;
pub const KEY_Arabic_fathatan = 1515;
pub const KEY_Arabic_feh = 1505;
pub const KEY_Arabic_fullstop = 16778964;
pub const KEY_Arabic_gaf = 16778927;
pub const KEY_Arabic_ghain = 1498;
pub const KEY_Arabic_ha = 1511;
pub const KEY_Arabic_hah = 1485;
pub const KEY_Arabic_hamza = 1473;
pub const KEY_Arabic_hamza_above = 16778836;
pub const KEY_Arabic_hamza_below = 16778837;
pub const KEY_Arabic_hamzaonalef = 1475;
pub const KEY_Arabic_hamzaonwaw = 1476;
pub const KEY_Arabic_hamzaonyeh = 1478;
pub const KEY_Arabic_hamzaunderalef = 1477;
pub const KEY_Arabic_heh = 1511;
pub const KEY_Arabic_heh_doachashmee = 16778942;
pub const KEY_Arabic_heh_goal = 16778945;
pub const KEY_Arabic_jeem = 1484;
pub const KEY_Arabic_jeh = 16778904;
pub const KEY_Arabic_kaf = 1507;
pub const KEY_Arabic_kasra = 1520;
pub const KEY_Arabic_kasratan = 1517;
pub const KEY_Arabic_keheh = 16778921;
pub const KEY_Arabic_khah = 1486;
pub const KEY_Arabic_lam = 1508;
pub const KEY_Arabic_madda_above = 16778835;
pub const KEY_Arabic_maddaonalef = 1474;
pub const KEY_Arabic_meem = 1509;
pub const KEY_Arabic_noon = 1510;
pub const KEY_Arabic_noon_ghunna = 16778938;
pub const KEY_Arabic_peh = 16778878;
pub const KEY_Arabic_percent = 16778858;
pub const KEY_Arabic_qaf = 1506;
pub const KEY_Arabic_question_mark = 1471;
pub const KEY_Arabic_ra = 1489;
pub const KEY_Arabic_rreh = 16778897;
pub const KEY_Arabic_sad = 1493;
pub const KEY_Arabic_seen = 1491;
pub const KEY_Arabic_semicolon = 1467;
pub const KEY_Arabic_shadda = 1521;
pub const KEY_Arabic_sheen = 1492;
pub const KEY_Arabic_sukun = 1522;
pub const KEY_Arabic_superscript_alef = 16778864;
pub const KEY_Arabic_switch = 65406;
pub const KEY_Arabic_tah = 1495;
pub const KEY_Arabic_tatweel = 1504;
pub const KEY_Arabic_tcheh = 16778886;
pub const KEY_Arabic_teh = 1482;
pub const KEY_Arabic_tehmarbuta = 1481;
pub const KEY_Arabic_thal = 1488;
pub const KEY_Arabic_theh = 1483;
pub const KEY_Arabic_tteh = 16778873;
pub const KEY_Arabic_veh = 16778916;
pub const KEY_Arabic_waw = 1512;
pub const KEY_Arabic_yeh = 1514;
pub const KEY_Arabic_yeh_baree = 16778962;
pub const KEY_Arabic_zah = 1496;
pub const KEY_Arabic_zain = 1490;
pub const KEY_Aring = 197;
pub const KEY_Armenian_AT = 16778552;
pub const KEY_Armenian_AYB = 16778545;
pub const KEY_Armenian_BEN = 16778546;
pub const KEY_Armenian_CHA = 16778569;
pub const KEY_Armenian_DA = 16778548;
pub const KEY_Armenian_DZA = 16778561;
pub const KEY_Armenian_E = 16778551;
pub const KEY_Armenian_FE = 16778582;
pub const KEY_Armenian_GHAT = 16778562;
pub const KEY_Armenian_GIM = 16778547;
pub const KEY_Armenian_HI = 16778565;
pub const KEY_Armenian_HO = 16778560;
pub const KEY_Armenian_INI = 16778555;
pub const KEY_Armenian_JE = 16778571;
pub const KEY_Armenian_KE = 16778580;
pub const KEY_Armenian_KEN = 16778559;
pub const KEY_Armenian_KHE = 16778557;
pub const KEY_Armenian_LYUN = 16778556;
pub const KEY_Armenian_MEN = 16778564;
pub const KEY_Armenian_NU = 16778566;
pub const KEY_Armenian_O = 16778581;
pub const KEY_Armenian_PE = 16778570;
pub const KEY_Armenian_PYUR = 16778579;
pub const KEY_Armenian_RA = 16778572;
pub const KEY_Armenian_RE = 16778576;
pub const KEY_Armenian_SE = 16778573;
pub const KEY_Armenian_SHA = 16778567;
pub const KEY_Armenian_TCHE = 16778563;
pub const KEY_Armenian_TO = 16778553;
pub const KEY_Armenian_TSA = 16778558;
pub const KEY_Armenian_TSO = 16778577;
pub const KEY_Armenian_TYUN = 16778575;
pub const KEY_Armenian_VEV = 16778574;
pub const KEY_Armenian_VO = 16778568;
pub const KEY_Armenian_VYUN = 16778578;
pub const KEY_Armenian_YECH = 16778549;
pub const KEY_Armenian_ZA = 16778550;
pub const KEY_Armenian_ZHE = 16778554;
pub const KEY_Armenian_accent = 16778587;
pub const KEY_Armenian_amanak = 16778588;
pub const KEY_Armenian_apostrophe = 16778586;
pub const KEY_Armenian_at = 16778600;
pub const KEY_Armenian_ayb = 16778593;
pub const KEY_Armenian_ben = 16778594;
pub const KEY_Armenian_but = 16778589;
pub const KEY_Armenian_cha = 16778617;
pub const KEY_Armenian_da = 16778596;
pub const KEY_Armenian_dza = 16778609;
pub const KEY_Armenian_e = 16778599;
pub const KEY_Armenian_exclam = 16778588;
pub const KEY_Armenian_fe = 16778630;
pub const KEY_Armenian_full_stop = 16778633;
pub const KEY_Armenian_ghat = 16778610;
pub const KEY_Armenian_gim = 16778595;
pub const KEY_Armenian_hi = 16778613;
pub const KEY_Armenian_ho = 16778608;
pub const KEY_Armenian_hyphen = 16778634;
pub const KEY_Armenian_ini = 16778603;
pub const KEY_Armenian_je = 16778619;
pub const KEY_Armenian_ke = 16778628;
pub const KEY_Armenian_ken = 16778607;
pub const KEY_Armenian_khe = 16778605;
pub const KEY_Armenian_ligature_ew = 16778631;
pub const KEY_Armenian_lyun = 16778604;
pub const KEY_Armenian_men = 16778612;
pub const KEY_Armenian_nu = 16778614;
pub const KEY_Armenian_o = 16778629;
pub const KEY_Armenian_paruyk = 16778590;
pub const KEY_Armenian_pe = 16778618;
pub const KEY_Armenian_pyur = 16778627;
pub const KEY_Armenian_question = 16778590;
pub const KEY_Armenian_ra = 16778620;
pub const KEY_Armenian_re = 16778624;
pub const KEY_Armenian_se = 16778621;
pub const KEY_Armenian_separation_mark = 16778589;
pub const KEY_Armenian_sha = 16778615;
pub const KEY_Armenian_shesht = 16778587;
pub const KEY_Armenian_tche = 16778611;
pub const KEY_Armenian_to = 16778601;
pub const KEY_Armenian_tsa = 16778606;
pub const KEY_Armenian_tso = 16778625;
pub const KEY_Armenian_tyun = 16778623;
pub const KEY_Armenian_verjaket = 16778633;
pub const KEY_Armenian_vev = 16778622;
pub const KEY_Armenian_vo = 16778616;
pub const KEY_Armenian_vyun = 16778626;
pub const KEY_Armenian_yech = 16778597;
pub const KEY_Armenian_yentamna = 16778634;
pub const KEY_Armenian_za = 16778598;
pub const KEY_Armenian_zhe = 16778602;
pub const KEY_Atilde = 195;
pub const KEY_AudibleBell_Enable = 65146;
pub const KEY_AudioCycleTrack = 269025179;
pub const KEY_AudioForward = 269025175;
pub const KEY_AudioLowerVolume = 269025041;
pub const KEY_AudioMedia = 269025074;
pub const KEY_AudioMicMute = 269025202;
pub const KEY_AudioMute = 269025042;
pub const KEY_AudioNext = 269025047;
pub const KEY_AudioPause = 269025073;
pub const KEY_AudioPlay = 269025044;
pub const KEY_AudioPreset = 269025206;
pub const KEY_AudioPrev = 269025046;
pub const KEY_AudioRaiseVolume = 269025043;
pub const KEY_AudioRandomPlay = 269025177;
pub const KEY_AudioRecord = 269025052;
pub const KEY_AudioRepeat = 269025176;
pub const KEY_AudioRewind = 269025086;
pub const KEY_AudioStop = 269025045;
pub const KEY_Away = 269025165;
pub const KEY_B = 66;
pub const KEY_Babovedot = 16784898;
pub const KEY_Back = 269025062;
pub const KEY_BackForward = 269025087;
pub const KEY_BackSpace = 65288;
pub const KEY_Battery = 269025171;
pub const KEY_Begin = 65368;
pub const KEY_Blue = 269025190;
pub const KEY_Bluetooth = 269025172;
pub const KEY_Book = 269025106;
pub const KEY_BounceKeys_Enable = 65140;
pub const KEY_Break = 65387;
pub const KEY_BrightnessAdjust = 269025083;
pub const KEY_Byelorussian_SHORTU = 1726;
pub const KEY_Byelorussian_shortu = 1710;
pub const KEY_C = 67;
pub const KEY_CD = 269025107;
pub const KEY_CH = 65186;
pub const KEY_C_H = 65189;
pub const KEY_C_h = 65188;
pub const KEY_Cabovedot = 709;
pub const KEY_Cacute = 454;
pub const KEY_Calculator = 269025053;
pub const KEY_Calendar = 269025056;
pub const KEY_Cancel = 65385;
pub const KEY_Caps_Lock = 65509;
pub const KEY_Ccaron = 456;
pub const KEY_Ccedilla = 199;
pub const KEY_Ccircumflex = 710;
pub const KEY_Ch = 65185;
pub const KEY_Clear = 65291;
pub const KEY_ClearGrab = 269024801;
pub const KEY_Close = 269025110;
pub const KEY_Codeinput = 65335;
pub const KEY_ColonSign = 16785569;
pub const KEY_Community = 269025085;
pub const KEY_ContrastAdjust = 269025058;
pub const KEY_Control_L = 65507;
pub const KEY_Control_R = 65508;
pub const KEY_Copy = 269025111;
pub const KEY_CruzeiroSign = 16785570;
pub const KEY_Cut = 269025112;
pub const KEY_CycleAngle = 269025180;
pub const KEY_Cyrillic_A = 1761;
pub const KEY_Cyrillic_BE = 1762;
pub const KEY_Cyrillic_CHE = 1790;
pub const KEY_Cyrillic_CHE_descender = 16778422;
pub const KEY_Cyrillic_CHE_vertstroke = 16778424;
pub const KEY_Cyrillic_DE = 1764;
pub const KEY_Cyrillic_DZHE = 1727;
pub const KEY_Cyrillic_E = 1788;
pub const KEY_Cyrillic_EF = 1766;
pub const KEY_Cyrillic_EL = 1772;
pub const KEY_Cyrillic_EM = 1773;
pub const KEY_Cyrillic_EN = 1774;
pub const KEY_Cyrillic_EN_descender = 16778402;
pub const KEY_Cyrillic_ER = 1778;
pub const KEY_Cyrillic_ES = 1779;
pub const KEY_Cyrillic_GHE = 1767;
pub const KEY_Cyrillic_GHE_bar = 16778386;
pub const KEY_Cyrillic_HA = 1768;
pub const KEY_Cyrillic_HARDSIGN = 1791;
pub const KEY_Cyrillic_HA_descender = 16778418;
pub const KEY_Cyrillic_I = 1769;
pub const KEY_Cyrillic_IE = 1765;
pub const KEY_Cyrillic_IO = 1715;
pub const KEY_Cyrillic_I_macron = 16778466;
pub const KEY_Cyrillic_JE = 1720;
pub const KEY_Cyrillic_KA = 1771;
pub const KEY_Cyrillic_KA_descender = 16778394;
pub const KEY_Cyrillic_KA_vertstroke = 16778396;
pub const KEY_Cyrillic_LJE = 1721;
pub const KEY_Cyrillic_NJE = 1722;
pub const KEY_Cyrillic_O = 1775;
pub const KEY_Cyrillic_O_bar = 16778472;
pub const KEY_Cyrillic_PE = 1776;
pub const KEY_Cyrillic_SCHWA = 16778456;
pub const KEY_Cyrillic_SHA = 1787;
pub const KEY_Cyrillic_SHCHA = 1789;
pub const KEY_Cyrillic_SHHA = 16778426;
pub const KEY_Cyrillic_SHORTI = 1770;
pub const KEY_Cyrillic_SOFTSIGN = 1784;
pub const KEY_Cyrillic_TE = 1780;
pub const KEY_Cyrillic_TSE = 1763;
pub const KEY_Cyrillic_U = 1781;
pub const KEY_Cyrillic_U_macron = 16778478;
pub const KEY_Cyrillic_U_straight = 16778414;
pub const KEY_Cyrillic_U_straight_bar = 16778416;
pub const KEY_Cyrillic_VE = 1783;
pub const KEY_Cyrillic_YA = 1777;
pub const KEY_Cyrillic_YERU = 1785;
pub const KEY_Cyrillic_YU = 1760;
pub const KEY_Cyrillic_ZE = 1786;
pub const KEY_Cyrillic_ZHE = 1782;
pub const KEY_Cyrillic_ZHE_descender = 16778390;
pub const KEY_Cyrillic_a = 1729;
pub const KEY_Cyrillic_be = 1730;
pub const KEY_Cyrillic_che = 1758;
pub const KEY_Cyrillic_che_descender = 16778423;
pub const KEY_Cyrillic_che_vertstroke = 16778425;
pub const KEY_Cyrillic_de = 1732;
pub const KEY_Cyrillic_dzhe = 1711;
pub const KEY_Cyrillic_e = 1756;
pub const KEY_Cyrillic_ef = 1734;
pub const KEY_Cyrillic_el = 1740;
pub const KEY_Cyrillic_em = 1741;
pub const KEY_Cyrillic_en = 1742;
pub const KEY_Cyrillic_en_descender = 16778403;
pub const KEY_Cyrillic_er = 1746;
pub const KEY_Cyrillic_es = 1747;
pub const KEY_Cyrillic_ghe = 1735;
pub const KEY_Cyrillic_ghe_bar = 16778387;
pub const KEY_Cyrillic_ha = 1736;
pub const KEY_Cyrillic_ha_descender = 16778419;
pub const KEY_Cyrillic_hardsign = 1759;
pub const KEY_Cyrillic_i = 1737;
pub const KEY_Cyrillic_i_macron = 16778467;
pub const KEY_Cyrillic_ie = 1733;
pub const KEY_Cyrillic_io = 1699;
pub const KEY_Cyrillic_je = 1704;
pub const KEY_Cyrillic_ka = 1739;
pub const KEY_Cyrillic_ka_descender = 16778395;
pub const KEY_Cyrillic_ka_vertstroke = 16778397;
pub const KEY_Cyrillic_lje = 1705;
pub const KEY_Cyrillic_nje = 1706;
pub const KEY_Cyrillic_o = 1743;
pub const KEY_Cyrillic_o_bar = 16778473;
pub const KEY_Cyrillic_pe = 1744;
pub const KEY_Cyrillic_schwa = 16778457;
pub const KEY_Cyrillic_sha = 1755;
pub const KEY_Cyrillic_shcha = 1757;
pub const KEY_Cyrillic_shha = 16778427;
pub const KEY_Cyrillic_shorti = 1738;
pub const KEY_Cyrillic_softsign = 1752;
pub const KEY_Cyrillic_te = 1748;
pub const KEY_Cyrillic_tse = 1731;
pub const KEY_Cyrillic_u = 1749;
pub const KEY_Cyrillic_u_macron = 16778479;
pub const KEY_Cyrillic_u_straight = 16778415;
pub const KEY_Cyrillic_u_straight_bar = 16778417;
pub const KEY_Cyrillic_ve = 1751;
pub const KEY_Cyrillic_ya = 1745;
pub const KEY_Cyrillic_yeru = 1753;
pub const KEY_Cyrillic_yu = 1728;
pub const KEY_Cyrillic_ze = 1754;
pub const KEY_Cyrillic_zhe = 1750;
pub const KEY_Cyrillic_zhe_descender = 16778391;
pub const KEY_D = 68;
pub const KEY_DOS = 269025114;
pub const KEY_Dabovedot = 16784906;
pub const KEY_Dcaron = 463;
pub const KEY_Delete = 65535;
pub const KEY_Display = 269025113;
pub const KEY_Documents = 269025115;
pub const KEY_DongSign = 16785579;
pub const KEY_Down = 65364;
pub const KEY_Dstroke = 464;
pub const KEY_E = 69;
pub const KEY_ENG = 957;
pub const KEY_ETH = 208;
pub const KEY_EZH = 16777655;
pub const KEY_Eabovedot = 972;
pub const KEY_Eacute = 201;
pub const KEY_Ebelowdot = 16785080;
pub const KEY_Ecaron = 460;
pub const KEY_Ecircumflex = 202;
pub const KEY_Ecircumflexacute = 16785086;
pub const KEY_Ecircumflexbelowdot = 16785094;
pub const KEY_Ecircumflexgrave = 16785088;
pub const KEY_Ecircumflexhook = 16785090;
pub const KEY_Ecircumflextilde = 16785092;
pub const KEY_EcuSign = 16785568;
pub const KEY_Ediaeresis = 203;
pub const KEY_Egrave = 200;
pub const KEY_Ehook = 16785082;
pub const KEY_Eisu_Shift = 65327;
pub const KEY_Eisu_toggle = 65328;
pub const KEY_Eject = 269025068;
pub const KEY_Emacron = 938;
pub const KEY_End = 65367;
pub const KEY_Eogonek = 458;
pub const KEY_Escape = 65307;
pub const KEY_Eth = 208;
pub const KEY_Etilde = 16785084;
pub const KEY_EuroSign = 8364;
pub const KEY_Excel = 269025116;
pub const KEY_Execute = 65378;
pub const KEY_Explorer = 269025117;
pub const KEY_F = 70;
pub const KEY_F1 = 65470;
pub const KEY_F10 = 65479;
pub const KEY_F11 = 65480;
pub const KEY_F12 = 65481;
pub const KEY_F13 = 65482;
pub const KEY_F14 = 65483;
pub const KEY_F15 = 65484;
pub const KEY_F16 = 65485;
pub const KEY_F17 = 65486;
pub const KEY_F18 = 65487;
pub const KEY_F19 = 65488;
pub const KEY_F2 = 65471;
pub const KEY_F20 = 65489;
pub const KEY_F21 = 65490;
pub const KEY_F22 = 65491;
pub const KEY_F23 = 65492;
pub const KEY_F24 = 65493;
pub const KEY_F25 = 65494;
pub const KEY_F26 = 65495;
pub const KEY_F27 = 65496;
pub const KEY_F28 = 65497;
pub const KEY_F29 = 65498;
pub const KEY_F3 = 65472;
pub const KEY_F30 = 65499;
pub const KEY_F31 = 65500;
pub const KEY_F32 = 65501;
pub const KEY_F33 = 65502;
pub const KEY_F34 = 65503;
pub const KEY_F35 = 65504;
pub const KEY_F4 = 65473;
pub const KEY_F5 = 65474;
pub const KEY_F6 = 65475;
pub const KEY_F7 = 65476;
pub const KEY_F8 = 65477;
pub const KEY_F9 = 65478;
pub const KEY_FFrancSign = 16785571;
pub const KEY_Fabovedot = 16784926;
pub const KEY_Farsi_0 = 16778992;
pub const KEY_Farsi_1 = 16778993;
pub const KEY_Farsi_2 = 16778994;
pub const KEY_Farsi_3 = 16778995;
pub const KEY_Farsi_4 = 16778996;
pub const KEY_Farsi_5 = 16778997;
pub const KEY_Farsi_6 = 16778998;
pub const KEY_Farsi_7 = 16778999;
pub const KEY_Farsi_8 = 16779000;
pub const KEY_Farsi_9 = 16779001;
pub const KEY_Farsi_yeh = 16778956;
pub const KEY_Favorites = 269025072;
pub const KEY_Finance = 269025084;
pub const KEY_Find = 65384;
pub const KEY_First_Virtual_Screen = 65232;
pub const KEY_Forward = 269025063;
pub const KEY_FrameBack = 269025181;
pub const KEY_FrameForward = 269025182;
pub const KEY_G = 71;
pub const KEY_Gabovedot = 725;
pub const KEY_Game = 269025118;
pub const KEY_Gbreve = 683;
pub const KEY_Gcaron = 16777702;
pub const KEY_Gcedilla = 939;
pub const KEY_Gcircumflex = 728;
pub const KEY_Georgian_an = 16781520;
pub const KEY_Georgian_ban = 16781521;
pub const KEY_Georgian_can = 16781546;
pub const KEY_Georgian_char = 16781549;
pub const KEY_Georgian_chin = 16781545;
pub const KEY_Georgian_cil = 16781548;
pub const KEY_Georgian_don = 16781523;
pub const KEY_Georgian_en = 16781524;
pub const KEY_Georgian_fi = 16781558;
pub const KEY_Georgian_gan = 16781522;
pub const KEY_Georgian_ghan = 16781542;
pub const KEY_Georgian_hae = 16781552;
pub const KEY_Georgian_har = 16781556;
pub const KEY_Georgian_he = 16781553;
pub const KEY_Georgian_hie = 16781554;
pub const KEY_Georgian_hoe = 16781557;
pub const KEY_Georgian_in = 16781528;
pub const KEY_Georgian_jhan = 16781551;
pub const KEY_Georgian_jil = 16781547;
pub const KEY_Georgian_kan = 16781529;
pub const KEY_Georgian_khar = 16781541;
pub const KEY_Georgian_las = 16781530;
pub const KEY_Georgian_man = 16781531;
pub const KEY_Georgian_nar = 16781532;
pub const KEY_Georgian_on = 16781533;
pub const KEY_Georgian_par = 16781534;
pub const KEY_Georgian_phar = 16781540;
pub const KEY_Georgian_qar = 16781543;
pub const KEY_Georgian_rae = 16781536;
pub const KEY_Georgian_san = 16781537;
pub const KEY_Georgian_shin = 16781544;
pub const KEY_Georgian_tan = 16781527;
pub const KEY_Georgian_tar = 16781538;
pub const KEY_Georgian_un = 16781539;
pub const KEY_Georgian_vin = 16781525;
pub const KEY_Georgian_we = 16781555;
pub const KEY_Georgian_xan = 16781550;
pub const KEY_Georgian_zen = 16781526;
pub const KEY_Georgian_zhar = 16781535;
pub const KEY_Go = 269025119;
pub const KEY_Greek_ALPHA = 1985;
pub const KEY_Greek_ALPHAaccent = 1953;
pub const KEY_Greek_BETA = 1986;
pub const KEY_Greek_CHI = 2007;
pub const KEY_Greek_DELTA = 1988;
pub const KEY_Greek_EPSILON = 1989;
pub const KEY_Greek_EPSILONaccent = 1954;
pub const KEY_Greek_ETA = 1991;
pub const KEY_Greek_ETAaccent = 1955;
pub const KEY_Greek_GAMMA = 1987;
pub const KEY_Greek_IOTA = 1993;
pub const KEY_Greek_IOTAaccent = 1956;
pub const KEY_Greek_IOTAdiaeresis = 1957;
pub const KEY_Greek_IOTAdieresis = 1957;
pub const KEY_Greek_KAPPA = 1994;
pub const KEY_Greek_LAMBDA = 1995;
pub const KEY_Greek_LAMDA = 1995;
pub const KEY_Greek_MU = 1996;
pub const KEY_Greek_NU = 1997;
pub const KEY_Greek_OMEGA = 2009;
pub const KEY_Greek_OMEGAaccent = 1963;
pub const KEY_Greek_OMICRON = 1999;
pub const KEY_Greek_OMICRONaccent = 1959;
pub const KEY_Greek_PHI = 2006;
pub const KEY_Greek_PI = 2000;
pub const KEY_Greek_PSI = 2008;
pub const KEY_Greek_RHO = 2001;
pub const KEY_Greek_SIGMA = 2002;
pub const KEY_Greek_TAU = 2004;
pub const KEY_Greek_THETA = 1992;
pub const KEY_Greek_UPSILON = 2005;
pub const KEY_Greek_UPSILONaccent = 1960;
pub const KEY_Greek_UPSILONdieresis = 1961;
pub const KEY_Greek_XI = 1998;
pub const KEY_Greek_ZETA = 1990;
pub const KEY_Greek_accentdieresis = 1966;
pub const KEY_Greek_alpha = 2017;
pub const KEY_Greek_alphaaccent = 1969;
pub const KEY_Greek_beta = 2018;
pub const KEY_Greek_chi = 2039;
pub const KEY_Greek_delta = 2020;
pub const KEY_Greek_epsilon = 2021;
pub const KEY_Greek_epsilonaccent = 1970;
pub const KEY_Greek_eta = 2023;
pub const KEY_Greek_etaaccent = 1971;
pub const KEY_Greek_finalsmallsigma = 2035;
pub const KEY_Greek_gamma = 2019;
pub const KEY_Greek_horizbar = 1967;
pub const KEY_Greek_iota = 2025;
pub const KEY_Greek_iotaaccent = 1972;
pub const KEY_Greek_iotaaccentdieresis = 1974;
pub const KEY_Greek_iotadieresis = 1973;
pub const KEY_Greek_kappa = 2026;
pub const KEY_Greek_lambda = 2027;
pub const KEY_Greek_lamda = 2027;
pub const KEY_Greek_mu = 2028;
pub const KEY_Greek_nu = 2029;
pub const KEY_Greek_omega = 2041;
pub const KEY_Greek_omegaaccent = 1979;
pub const KEY_Greek_omicron = 2031;
pub const KEY_Greek_omicronaccent = 1975;
pub const KEY_Greek_phi = 2038;
pub const KEY_Greek_pi = 2032;
pub const KEY_Greek_psi = 2040;
pub const KEY_Greek_rho = 2033;
pub const KEY_Greek_sigma = 2034;
pub const KEY_Greek_switch = 65406;
pub const KEY_Greek_tau = 2036;
pub const KEY_Greek_theta = 2024;
pub const KEY_Greek_upsilon = 2037;
pub const KEY_Greek_upsilonaccent = 1976;
pub const KEY_Greek_upsilonaccentdieresis = 1978;
pub const KEY_Greek_upsilondieresis = 1977;
pub const KEY_Greek_xi = 2030;
pub const KEY_Greek_zeta = 2022;
pub const KEY_Green = 269025188;
pub const KEY_H = 72;
pub const KEY_Hangul = 65329;
pub const KEY_Hangul_A = 3775;
pub const KEY_Hangul_AE = 3776;
pub const KEY_Hangul_AraeA = 3830;
pub const KEY_Hangul_AraeAE = 3831;
pub const KEY_Hangul_Banja = 65337;
pub const KEY_Hangul_Cieuc = 3770;
pub const KEY_Hangul_Codeinput = 65335;
pub const KEY_Hangul_Dikeud = 3751;
pub const KEY_Hangul_E = 3780;
pub const KEY_Hangul_EO = 3779;
pub const KEY_Hangul_EU = 3793;
pub const KEY_Hangul_End = 65331;
pub const KEY_Hangul_Hanja = 65332;
pub const KEY_Hangul_Hieuh = 3774;
pub const KEY_Hangul_I = 3795;
pub const KEY_Hangul_Ieung = 3767;
pub const KEY_Hangul_J_Cieuc = 3818;
pub const KEY_Hangul_J_Dikeud = 3802;
pub const KEY_Hangul_J_Hieuh = 3822;
pub const KEY_Hangul_J_Ieung = 3816;
pub const KEY_Hangul_J_Jieuj = 3817;
pub const KEY_Hangul_J_Khieuq = 3819;
pub const KEY_Hangul_J_Kiyeog = 3796;
pub const KEY_Hangul_J_KiyeogSios = 3798;
pub const KEY_Hangul_J_KkogjiDalrinIeung = 3833;
pub const KEY_Hangul_J_Mieum = 3811;
pub const KEY_Hangul_J_Nieun = 3799;
pub const KEY_Hangul_J_NieunHieuh = 3801;
pub const KEY_Hangul_J_NieunJieuj = 3800;
pub const KEY_Hangul_J_PanSios = 3832;
pub const KEY_Hangul_J_Phieuf = 3821;
pub const KEY_Hangul_J_Pieub = 3812;
pub const KEY_Hangul_J_PieubSios = 3813;
pub const KEY_Hangul_J_Rieul = 3803;
pub const KEY_Hangul_J_RieulHieuh = 3810;
pub const KEY_Hangul_J_RieulKiyeog = 3804;
pub const KEY_Hangul_J_RieulMieum = 3805;
pub const KEY_Hangul_J_RieulPhieuf = 3809;
pub const KEY_Hangul_J_RieulPieub = 3806;
pub const KEY_Hangul_J_RieulSios = 3807;
pub const KEY_Hangul_J_RieulTieut = 3808;
pub const KEY_Hangul_J_Sios = 3814;
pub const KEY_Hangul_J_SsangKiyeog = 3797;
pub const KEY_Hangul_J_SsangSios = 3815;
pub const KEY_Hangul_J_Tieut = 3820;
pub const KEY_Hangul_J_YeorinHieuh = 3834;
pub const KEY_Hangul_Jamo = 65333;
pub const KEY_Hangul_Jeonja = 65336;
pub const KEY_Hangul_Jieuj = 3768;
pub const KEY_Hangul_Khieuq = 3771;
pub const KEY_Hangul_Kiyeog = 3745;
pub const KEY_Hangul_KiyeogSios = 3747;
pub const KEY_Hangul_KkogjiDalrinIeung = 3827;
pub const KEY_Hangul_Mieum = 3761;
pub const KEY_Hangul_MultipleCandidate = 65341;
pub const KEY_Hangul_Nieun = 3748;
pub const KEY_Hangul_NieunHieuh = 3750;
pub const KEY_Hangul_NieunJieuj = 3749;
pub const KEY_Hangul_O = 3783;
pub const KEY_Hangul_OE = 3786;
pub const KEY_Hangul_PanSios = 3826;
pub const KEY_Hangul_Phieuf = 3773;
pub const KEY_Hangul_Pieub = 3762;
pub const KEY_Hangul_PieubSios = 3764;
pub const KEY_Hangul_PostHanja = 65339;
pub const KEY_Hangul_PreHanja = 65338;
pub const KEY_Hangul_PreviousCandidate = 65342;
pub const KEY_Hangul_Rieul = 3753;
pub const KEY_Hangul_RieulHieuh = 3760;
pub const KEY_Hangul_RieulKiyeog = 3754;
pub const KEY_Hangul_RieulMieum = 3755;
pub const KEY_Hangul_RieulPhieuf = 3759;
pub const KEY_Hangul_RieulPieub = 3756;
pub const KEY_Hangul_RieulSios = 3757;
pub const KEY_Hangul_RieulTieut = 3758;
pub const KEY_Hangul_RieulYeorinHieuh = 3823;
pub const KEY_Hangul_Romaja = 65334;
pub const KEY_Hangul_SingleCandidate = 65340;
pub const KEY_Hangul_Sios = 3765;
pub const KEY_Hangul_Special = 65343;
pub const KEY_Hangul_SsangDikeud = 3752;
pub const KEY_Hangul_SsangJieuj = 3769;
pub const KEY_Hangul_SsangKiyeog = 3746;
pub const KEY_Hangul_SsangPieub = 3763;
pub const KEY_Hangul_SsangSios = 3766;
pub const KEY_Hangul_Start = 65330;
pub const KEY_Hangul_SunkyeongeumMieum = 3824;
pub const KEY_Hangul_SunkyeongeumPhieuf = 3828;
pub const KEY_Hangul_SunkyeongeumPieub = 3825;
pub const KEY_Hangul_Tieut = 3772;
pub const KEY_Hangul_U = 3788;
pub const KEY_Hangul_WA = 3784;
pub const KEY_Hangul_WAE = 3785;
pub const KEY_Hangul_WE = 3790;
pub const KEY_Hangul_WEO = 3789;
pub const KEY_Hangul_WI = 3791;
pub const KEY_Hangul_YA = 3777;
pub const KEY_Hangul_YAE = 3778;
pub const KEY_Hangul_YE = 3782;
pub const KEY_Hangul_YEO = 3781;
pub const KEY_Hangul_YI = 3794;
pub const KEY_Hangul_YO = 3787;
pub const KEY_Hangul_YU = 3792;
pub const KEY_Hangul_YeorinHieuh = 3829;
pub const KEY_Hangul_switch = 65406;
pub const KEY_Hankaku = 65321;
pub const KEY_Hcircumflex = 678;
pub const KEY_Hebrew_switch = 65406;
pub const KEY_Help = 65386;
pub const KEY_Henkan = 65315;
pub const KEY_Henkan_Mode = 65315;
pub const KEY_Hibernate = 269025192;
pub const KEY_Hiragana = 65317;
pub const KEY_Hiragana_Katakana = 65319;
pub const KEY_History = 269025079;
pub const KEY_Home = 65360;
pub const KEY_HomePage = 269025048;
pub const KEY_HotLinks = 269025082;
pub const KEY_Hstroke = 673;
pub const KEY_Hyper_L = 65517;
pub const KEY_Hyper_R = 65518;
pub const KEY_I = 73;
pub const KEY_ISO_Center_Object = 65075;
pub const KEY_ISO_Continuous_Underline = 65072;
pub const KEY_ISO_Discontinuous_Underline = 65073;
pub const KEY_ISO_Emphasize = 65074;
pub const KEY_ISO_Enter = 65076;
pub const KEY_ISO_Fast_Cursor_Down = 65071;
pub const KEY_ISO_Fast_Cursor_Left = 65068;
pub const KEY_ISO_Fast_Cursor_Right = 65069;
pub const KEY_ISO_Fast_Cursor_Up = 65070;
pub const KEY_ISO_First_Group = 65036;
pub const KEY_ISO_First_Group_Lock = 65037;
pub const KEY_ISO_Group_Latch = 65030;
pub const KEY_ISO_Group_Lock = 65031;
pub const KEY_ISO_Group_Shift = 65406;
pub const KEY_ISO_Last_Group = 65038;
pub const KEY_ISO_Last_Group_Lock = 65039;
pub const KEY_ISO_Left_Tab = 65056;
pub const KEY_ISO_Level2_Latch = 65026;
pub const KEY_ISO_Level3_Latch = 65028;
pub const KEY_ISO_Level3_Lock = 65029;
pub const KEY_ISO_Level3_Shift = 65027;
pub const KEY_ISO_Level5_Latch = 65042;
pub const KEY_ISO_Level5_Lock = 65043;
pub const KEY_ISO_Level5_Shift = 65041;
pub const KEY_ISO_Lock = 65025;
pub const KEY_ISO_Move_Line_Down = 65058;
pub const KEY_ISO_Move_Line_Up = 65057;
pub const KEY_ISO_Next_Group = 65032;
pub const KEY_ISO_Next_Group_Lock = 65033;
pub const KEY_ISO_Partial_Line_Down = 65060;
pub const KEY_ISO_Partial_Line_Up = 65059;
pub const KEY_ISO_Partial_Space_Left = 65061;
pub const KEY_ISO_Partial_Space_Right = 65062;
pub const KEY_ISO_Prev_Group = 65034;
pub const KEY_ISO_Prev_Group_Lock = 65035;
pub const KEY_ISO_Release_Both_Margins = 65067;
pub const KEY_ISO_Release_Margin_Left = 65065;
pub const KEY_ISO_Release_Margin_Right = 65066;
pub const KEY_ISO_Set_Margin_Left = 65063;
pub const KEY_ISO_Set_Margin_Right = 65064;
pub const KEY_Iabovedot = 681;
pub const KEY_Iacute = 205;
pub const KEY_Ibelowdot = 16785098;
pub const KEY_Ibreve = 16777516;
pub const KEY_Icircumflex = 206;
pub const KEY_Idiaeresis = 207;
pub const KEY_Igrave = 204;
pub const KEY_Ihook = 16785096;
pub const KEY_Imacron = 975;
pub const KEY_Insert = 65379;
pub const KEY_Iogonek = 967;
pub const KEY_Itilde = 933;
pub const KEY_J = 74;
pub const KEY_Jcircumflex = 684;
pub const KEY_K = 75;
pub const KEY_KP_0 = 65456;
pub const KEY_KP_1 = 65457;
pub const KEY_KP_2 = 65458;
pub const KEY_KP_3 = 65459;
pub const KEY_KP_4 = 65460;
pub const KEY_KP_5 = 65461;
pub const KEY_KP_6 = 65462;
pub const KEY_KP_7 = 65463;
pub const KEY_KP_8 = 65464;
pub const KEY_KP_9 = 65465;
pub const KEY_KP_Add = 65451;
pub const KEY_KP_Begin = 65437;
pub const KEY_KP_Decimal = 65454;
pub const KEY_KP_Delete = 65439;
pub const KEY_KP_Divide = 65455;
pub const KEY_KP_Down = 65433;
pub const KEY_KP_End = 65436;
pub const KEY_KP_Enter = 65421;
pub const KEY_KP_Equal = 65469;
pub const KEY_KP_F1 = 65425;
pub const KEY_KP_F2 = 65426;
pub const KEY_KP_F3 = 65427;
pub const KEY_KP_F4 = 65428;
pub const KEY_KP_Home = 65429;
pub const KEY_KP_Insert = 65438;
pub const KEY_KP_Left = 65430;
pub const KEY_KP_Multiply = 65450;
pub const KEY_KP_Next = 65435;
pub const KEY_KP_Page_Down = 65435;
pub const KEY_KP_Page_Up = 65434;
pub const KEY_KP_Prior = 65434;
pub const KEY_KP_Right = 65432;
pub const KEY_KP_Separator = 65452;
pub const KEY_KP_Space = 65408;
pub const KEY_KP_Subtract = 65453;
pub const KEY_KP_Tab = 65417;
pub const KEY_KP_Up = 65431;
pub const KEY_Kana_Lock = 65325;
pub const KEY_Kana_Shift = 65326;
pub const KEY_Kanji = 65313;
pub const KEY_Kanji_Bangou = 65335;
pub const KEY_Katakana = 65318;
pub const KEY_KbdBrightnessDown = 269025030;
pub const KEY_KbdBrightnessUp = 269025029;
pub const KEY_KbdLightOnOff = 269025028;
pub const KEY_Kcedilla = 979;
pub const KEY_Keyboard = 269025203;
pub const KEY_Korean_Won = 3839;
pub const KEY_L = 76;
pub const KEY_L1 = 65480;
pub const KEY_L10 = 65489;
pub const KEY_L2 = 65481;
pub const KEY_L3 = 65482;
pub const KEY_L4 = 65483;
pub const KEY_L5 = 65484;
pub const KEY_L6 = 65485;
pub const KEY_L7 = 65486;
pub const KEY_L8 = 65487;
pub const KEY_L9 = 65488;
pub const KEY_Lacute = 453;
pub const KEY_Last_Virtual_Screen = 65236;
pub const KEY_Launch0 = 269025088;
pub const KEY_Launch1 = 269025089;
pub const KEY_Launch2 = 269025090;
pub const KEY_Launch3 = 269025091;
pub const KEY_Launch4 = 269025092;
pub const KEY_Launch5 = 269025093;
pub const KEY_Launch6 = 269025094;
pub const KEY_Launch7 = 269025095;
pub const KEY_Launch8 = 269025096;
pub const KEY_Launch9 = 269025097;
pub const KEY_LaunchA = 269025098;
pub const KEY_LaunchB = 269025099;
pub const KEY_LaunchC = 269025100;
pub const KEY_LaunchD = 269025101;
pub const KEY_LaunchE = 269025102;
pub const KEY_LaunchF = 269025103;
pub const KEY_Lbelowdot = 16784950;
pub const KEY_Lcaron = 421;
pub const KEY_Lcedilla = 934;
pub const KEY_Left = 65361;
pub const KEY_LightBulb = 269025077;
pub const KEY_Linefeed = 65290;
pub const KEY_LiraSign = 16785572;
pub const KEY_LogGrabInfo = 269024805;
pub const KEY_LogOff = 269025121;
pub const KEY_LogWindowTree = 269024804;
pub const KEY_Lstroke = 419;
pub const KEY_M = 77;
pub const KEY_Mabovedot = 16784960;
pub const KEY_Macedonia_DSE = 1717;
pub const KEY_Macedonia_GJE = 1714;
pub const KEY_Macedonia_KJE = 1724;
pub const KEY_Macedonia_dse = 1701;
pub const KEY_Macedonia_gje = 1698;
pub const KEY_Macedonia_kje = 1708;
pub const KEY_Mae_Koho = 65342;
pub const KEY_Mail = 269025049;
pub const KEY_MailForward = 269025168;
pub const KEY_Market = 269025122;
pub const KEY_Massyo = 65324;
pub const KEY_Meeting = 269025123;
pub const KEY_Memo = 269025054;
pub const KEY_Menu = 65383;
pub const KEY_MenuKB = 269025125;
pub const KEY_MenuPB = 269025126;
pub const KEY_Messenger = 269025166;
pub const KEY_Meta_L = 65511;
pub const KEY_Meta_R = 65512;
pub const KEY_MillSign = 16785573;
pub const KEY_ModeLock = 269025025;
pub const KEY_Mode_switch = 65406;
pub const KEY_MonBrightnessDown = 269025027;
pub const KEY_MonBrightnessUp = 269025026;
pub const KEY_MouseKeys_Accel_Enable = 65143;
pub const KEY_MouseKeys_Enable = 65142;
pub const KEY_Muhenkan = 65314;
pub const KEY_Multi_key = 65312;
pub const KEY_MultipleCandidate = 65341;
pub const KEY_Music = 269025170;
pub const KEY_MyComputer = 269025075;
pub const KEY_MySites = 269025127;
pub const KEY_N = 78;
pub const KEY_Nacute = 465;
pub const KEY_NairaSign = 16785574;
pub const KEY_Ncaron = 466;
pub const KEY_Ncedilla = 977;
pub const KEY_New = 269025128;
pub const KEY_NewSheqelSign = 16785578;
pub const KEY_News = 269025129;
pub const KEY_Next = 65366;
pub const KEY_Next_VMode = 269024802;
pub const KEY_Next_Virtual_Screen = 65234;
pub const KEY_Ntilde = 209;
pub const KEY_Num_Lock = 65407;
pub const KEY_O = 79;
pub const KEY_OE = 5052;
pub const KEY_Oacute = 211;
pub const KEY_Obarred = 16777631;
pub const KEY_Obelowdot = 16785100;
pub const KEY_Ocaron = 16777681;
pub const KEY_Ocircumflex = 212;
pub const KEY_Ocircumflexacute = 16785104;
pub const KEY_Ocircumflexbelowdot = 16785112;
pub const KEY_Ocircumflexgrave = 16785106;
pub const KEY_Ocircumflexhook = 16785108;
pub const KEY_Ocircumflextilde = 16785110;
pub const KEY_Odiaeresis = 214;
pub const KEY_Odoubleacute = 469;
pub const KEY_OfficeHome = 269025130;
pub const KEY_Ograve = 210;
pub const KEY_Ohook = 16785102;
pub const KEY_Ohorn = 16777632;
pub const KEY_Ohornacute = 16785114;
pub const KEY_Ohornbelowdot = 16785122;
pub const KEY_Ohorngrave = 16785116;
pub const KEY_Ohornhook = 16785118;
pub const KEY_Ohorntilde = 16785120;
pub const KEY_Omacron = 978;
pub const KEY_Ooblique = 216;
pub const KEY_Open = 269025131;
pub const KEY_OpenURL = 269025080;
pub const KEY_Option = 269025132;
pub const KEY_Oslash = 216;
pub const KEY_Otilde = 213;
pub const KEY_Overlay1_Enable = 65144;
pub const KEY_Overlay2_Enable = 65145;
pub const KEY_P = 80;
pub const KEY_Pabovedot = 16784982;
pub const KEY_Page_Down = 65366;
pub const KEY_Page_Up = 65365;
pub const KEY_Paste = 269025133;
pub const KEY_Pause = 65299;
pub const KEY_PesetaSign = 16785575;
pub const KEY_Phone = 269025134;
pub const KEY_Pictures = 269025169;
pub const KEY_Pointer_Accelerate = 65274;
pub const KEY_Pointer_Button1 = 65257;
pub const KEY_Pointer_Button2 = 65258;
pub const KEY_Pointer_Button3 = 65259;
pub const KEY_Pointer_Button4 = 65260;
pub const KEY_Pointer_Button5 = 65261;
pub const KEY_Pointer_Button_Dflt = 65256;
pub const KEY_Pointer_DblClick1 = 65263;
pub const KEY_Pointer_DblClick2 = 65264;
pub const KEY_Pointer_DblClick3 = 65265;
pub const KEY_Pointer_DblClick4 = 65266;
pub const KEY_Pointer_DblClick5 = 65267;
pub const KEY_Pointer_DblClick_Dflt = 65262;
pub const KEY_Pointer_DfltBtnNext = 65275;
pub const KEY_Pointer_DfltBtnPrev = 65276;
pub const KEY_Pointer_Down = 65251;
pub const KEY_Pointer_DownLeft = 65254;
pub const KEY_Pointer_DownRight = 65255;
pub const KEY_Pointer_Drag1 = 65269;
pub const KEY_Pointer_Drag2 = 65270;
pub const KEY_Pointer_Drag3 = 65271;
pub const KEY_Pointer_Drag4 = 65272;
pub const KEY_Pointer_Drag5 = 65277;
pub const KEY_Pointer_Drag_Dflt = 65268;
pub const KEY_Pointer_EnableKeys = 65273;
pub const KEY_Pointer_Left = 65248;
pub const KEY_Pointer_Right = 65249;
pub const KEY_Pointer_Up = 65250;
pub const KEY_Pointer_UpLeft = 65252;
pub const KEY_Pointer_UpRight = 65253;
pub const KEY_PowerDown = 269025057;
pub const KEY_PowerOff = 269025066;
pub const KEY_Prev_VMode = 269024803;
pub const KEY_Prev_Virtual_Screen = 65233;
pub const KEY_PreviousCandidate = 65342;
pub const KEY_Print = 65377;
pub const KEY_Prior = 65365;
pub const KEY_Q = 81;
pub const KEY_R = 82;
pub const KEY_R1 = 65490;
pub const KEY_R10 = 65499;
pub const KEY_R11 = 65500;
pub const KEY_R12 = 65501;
pub const KEY_R13 = 65502;
pub const KEY_R14 = 65503;
pub const KEY_R15 = 65504;
pub const KEY_R2 = 65491;
pub const KEY_R3 = 65492;
pub const KEY_R4 = 65493;
pub const KEY_R5 = 65494;
pub const KEY_R6 = 65495;
pub const KEY_R7 = 65496;
pub const KEY_R8 = 65497;
pub const KEY_R9 = 65498;
pub const KEY_RFKill = 269025205;
pub const KEY_Racute = 448;
pub const KEY_Rcaron = 472;
pub const KEY_Rcedilla = 931;
pub const KEY_Red = 269025187;
pub const KEY_Redo = 65382;
pub const KEY_Refresh = 269025065;
pub const KEY_Reload = 269025139;
pub const KEY_RepeatKeys_Enable = 65138;
pub const KEY_Reply = 269025138;
pub const KEY_Return = 65293;
pub const KEY_Right = 65363;
pub const KEY_RockerDown = 269025060;
pub const KEY_RockerEnter = 269025061;
pub const KEY_RockerUp = 269025059;
pub const KEY_Romaji = 65316;
pub const KEY_RotateWindows = 269025140;
pub const KEY_RotationKB = 269025142;
pub const KEY_RotationPB = 269025141;
pub const KEY_RupeeSign = 16785576;
pub const KEY_S = 83;
pub const KEY_SCHWA = 16777615;
pub const KEY_Sabovedot = 16784992;
pub const KEY_Sacute = 422;
pub const KEY_Save = 269025143;
pub const KEY_Scaron = 425;
pub const KEY_Scedilla = 426;
pub const KEY_Scircumflex = 734;
pub const KEY_ScreenSaver = 269025069;
pub const KEY_ScrollClick = 269025146;
pub const KEY_ScrollDown = 269025145;
pub const KEY_ScrollUp = 269025144;
pub const KEY_Scroll_Lock = 65300;
pub const KEY_Search = 269025051;
pub const KEY_Select = 65376;
pub const KEY_SelectButton = 269025184;
pub const KEY_Send = 269025147;
pub const KEY_Serbian_DJE = 1713;
pub const KEY_Serbian_DZE = 1727;
pub const KEY_Serbian_JE = 1720;
pub const KEY_Serbian_LJE = 1721;
pub const KEY_Serbian_NJE = 1722;
pub const KEY_Serbian_TSHE = 1723;
pub const KEY_Serbian_dje = 1697;
pub const KEY_Serbian_dze = 1711;
pub const KEY_Serbian_je = 1704;
pub const KEY_Serbian_lje = 1705;
pub const KEY_Serbian_nje = 1706;
pub const KEY_Serbian_tshe = 1707;
pub const KEY_Shift_L = 65505;
pub const KEY_Shift_Lock = 65510;
pub const KEY_Shift_R = 65506;
pub const KEY_Shop = 269025078;
pub const KEY_SingleCandidate = 65340;
pub const KEY_Sinh_a = 16780677;
pub const KEY_Sinh_aa = 16780678;
pub const KEY_Sinh_aa2 = 16780751;
pub const KEY_Sinh_ae = 16780679;
pub const KEY_Sinh_ae2 = 16780752;
pub const KEY_Sinh_aee = 16780680;
pub const KEY_Sinh_aee2 = 16780753;
pub const KEY_Sinh_ai = 16780691;
pub const KEY_Sinh_ai2 = 16780763;
pub const KEY_Sinh_al = 16780746;
pub const KEY_Sinh_au = 16780694;
pub const KEY_Sinh_au2 = 16780766;
pub const KEY_Sinh_ba = 16780726;
pub const KEY_Sinh_bha = 16780727;
pub const KEY_Sinh_ca = 16780704;
pub const KEY_Sinh_cha = 16780705;
pub const KEY_Sinh_dda = 16780713;
pub const KEY_Sinh_ddha = 16780714;
pub const KEY_Sinh_dha = 16780719;
pub const KEY_Sinh_dhha = 16780720;
pub const KEY_Sinh_e = 16780689;
pub const KEY_Sinh_e2 = 16780761;
pub const KEY_Sinh_ee = 16780690;
pub const KEY_Sinh_ee2 = 16780762;
pub const KEY_Sinh_fa = 16780742;
pub const KEY_Sinh_ga = 16780700;
pub const KEY_Sinh_gha = 16780701;
pub const KEY_Sinh_h2 = 16780675;
pub const KEY_Sinh_ha = 16780740;
pub const KEY_Sinh_i = 16780681;
pub const KEY_Sinh_i2 = 16780754;
pub const KEY_Sinh_ii = 16780682;
pub const KEY_Sinh_ii2 = 16780755;
pub const KEY_Sinh_ja = 16780706;
pub const KEY_Sinh_jha = 16780707;
pub const KEY_Sinh_jnya = 16780709;
pub const KEY_Sinh_ka = 16780698;
pub const KEY_Sinh_kha = 16780699;
pub const KEY_Sinh_kunddaliya = 16780788;
pub const KEY_Sinh_la = 16780733;
pub const KEY_Sinh_lla = 16780741;
pub const KEY_Sinh_lu = 16780687;
pub const KEY_Sinh_lu2 = 16780767;
pub const KEY_Sinh_luu = 16780688;
pub const KEY_Sinh_luu2 = 16780787;
pub const KEY_Sinh_ma = 16780728;
pub const KEY_Sinh_mba = 16780729;
pub const KEY_Sinh_na = 16780721;
pub const KEY_Sinh_ndda = 16780716;
pub const KEY_Sinh_ndha = 16780723;
pub const KEY_Sinh_ng = 16780674;
pub const KEY_Sinh_ng2 = 16780702;
pub const KEY_Sinh_nga = 16780703;
pub const KEY_Sinh_nja = 16780710;
pub const KEY_Sinh_nna = 16780715;
pub const KEY_Sinh_nya = 16780708;
pub const KEY_Sinh_o = 16780692;
pub const KEY_Sinh_o2 = 16780764;
pub const KEY_Sinh_oo = 16780693;
pub const KEY_Sinh_oo2 = 16780765;
pub const KEY_Sinh_pa = 16780724;
pub const KEY_Sinh_pha = 16780725;
pub const KEY_Sinh_ra = 16780731;
pub const KEY_Sinh_ri = 16780685;
pub const KEY_Sinh_rii = 16780686;
pub const KEY_Sinh_ru2 = 16780760;
pub const KEY_Sinh_ruu2 = 16780786;
pub const KEY_Sinh_sa = 16780739;
pub const KEY_Sinh_sha = 16780737;
pub const KEY_Sinh_ssha = 16780738;
pub const KEY_Sinh_tha = 16780717;
pub const KEY_Sinh_thha = 16780718;
pub const KEY_Sinh_tta = 16780711;
pub const KEY_Sinh_ttha = 16780712;
pub const KEY_Sinh_u = 16780683;
pub const KEY_Sinh_u2 = 16780756;
pub const KEY_Sinh_uu = 16780684;
pub const KEY_Sinh_uu2 = 16780758;
pub const KEY_Sinh_va = 16780736;
pub const KEY_Sinh_ya = 16780730;
pub const KEY_Sleep = 269025071;
pub const KEY_SlowKeys_Enable = 65139;
pub const KEY_Spell = 269025148;
pub const KEY_SplitScreen = 269025149;
pub const KEY_Standby = 269025040;
pub const KEY_Start = 269025050;
pub const KEY_StickyKeys_Enable = 65141;
pub const KEY_Stop = 269025064;
pub const KEY_Subtitle = 269025178;
pub const KEY_Super_L = 65515;
pub const KEY_Super_R = 65516;
pub const KEY_Support = 269025150;
pub const KEY_Suspend = 269025191;
pub const KEY_Switch_VT_1 = 269024769;
pub const KEY_Switch_VT_10 = 269024778;
pub const KEY_Switch_VT_11 = 269024779;
pub const KEY_Switch_VT_12 = 269024780;
pub const KEY_Switch_VT_2 = 269024770;
pub const KEY_Switch_VT_3 = 269024771;
pub const KEY_Switch_VT_4 = 269024772;
pub const KEY_Switch_VT_5 = 269024773;
pub const KEY_Switch_VT_6 = 269024774;
pub const KEY_Switch_VT_7 = 269024775;
pub const KEY_Switch_VT_8 = 269024776;
pub const KEY_Switch_VT_9 = 269024777;
pub const KEY_Sys_Req = 65301;
pub const KEY_T = 84;
pub const KEY_THORN = 222;
pub const KEY_Tab = 65289;
pub const KEY_Tabovedot = 16785002;
pub const KEY_TaskPane = 269025151;
pub const KEY_Tcaron = 427;
pub const KEY_Tcedilla = 478;
pub const KEY_Terminal = 269025152;
pub const KEY_Terminate_Server = 65237;
pub const KEY_Thai_baht = 3551;
pub const KEY_Thai_bobaimai = 3514;
pub const KEY_Thai_chochan = 3496;
pub const KEY_Thai_chochang = 3498;
pub const KEY_Thai_choching = 3497;
pub const KEY_Thai_chochoe = 3500;
pub const KEY_Thai_dochada = 3502;
pub const KEY_Thai_dodek = 3508;
pub const KEY_Thai_fofa = 3517;
pub const KEY_Thai_fofan = 3519;
pub const KEY_Thai_hohip = 3531;
pub const KEY_Thai_honokhuk = 3534;
pub const KEY_Thai_khokhai = 3490;
pub const KEY_Thai_khokhon = 3493;
pub const KEY_Thai_khokhuat = 3491;
pub const KEY_Thai_khokhwai = 3492;
pub const KEY_Thai_khorakhang = 3494;
pub const KEY_Thai_kokai = 3489;
pub const KEY_Thai_lakkhangyao = 3557;
pub const KEY_Thai_lekchet = 3575;
pub const KEY_Thai_lekha = 3573;
pub const KEY_Thai_lekhok = 3574;
pub const KEY_Thai_lekkao = 3577;
pub const KEY_Thai_leknung = 3569;
pub const KEY_Thai_lekpaet = 3576;
pub const KEY_Thai_leksam = 3571;
pub const KEY_Thai_leksi = 3572;
pub const KEY_Thai_leksong = 3570;
pub const KEY_Thai_leksun = 3568;
pub const KEY_Thai_lochula = 3532;
pub const KEY_Thai_loling = 3525;
pub const KEY_Thai_lu = 3526;
pub const KEY_Thai_maichattawa = 3563;
pub const KEY_Thai_maiek = 3560;
pub const KEY_Thai_maihanakat = 3537;
pub const KEY_Thai_maihanakat_maitho = 3550;
pub const KEY_Thai_maitaikhu = 3559;
pub const KEY_Thai_maitho = 3561;
pub const KEY_Thai_maitri = 3562;
pub const KEY_Thai_maiyamok = 3558;
pub const KEY_Thai_moma = 3521;
pub const KEY_Thai_ngongu = 3495;
pub const KEY_Thai_nikhahit = 3565;
pub const KEY_Thai_nonen = 3507;
pub const KEY_Thai_nonu = 3513;
pub const KEY_Thai_oang = 3533;
pub const KEY_Thai_paiyannoi = 3535;
pub const KEY_Thai_phinthu = 3546;
pub const KEY_Thai_phophan = 3518;
pub const KEY_Thai_phophung = 3516;
pub const KEY_Thai_phosamphao = 3520;
pub const KEY_Thai_popla = 3515;
pub const KEY_Thai_rorua = 3523;
pub const KEY_Thai_ru = 3524;
pub const KEY_Thai_saraa = 3536;
pub const KEY_Thai_saraaa = 3538;
pub const KEY_Thai_saraae = 3553;
pub const KEY_Thai_saraaimaimalai = 3556;
pub const KEY_Thai_saraaimaimuan = 3555;
pub const KEY_Thai_saraam = 3539;
pub const KEY_Thai_sarae = 3552;
pub const KEY_Thai_sarai = 3540;
pub const KEY_Thai_saraii = 3541;
pub const KEY_Thai_sarao = 3554;
pub const KEY_Thai_sarau = 3544;
pub const KEY_Thai_saraue = 3542;
pub const KEY_Thai_sarauee = 3543;
pub const KEY_Thai_sarauu = 3545;
pub const KEY_Thai_sorusi = 3529;
pub const KEY_Thai_sosala = 3528;
pub const KEY_Thai_soso = 3499;
pub const KEY_Thai_sosua = 3530;
pub const KEY_Thai_thanthakhat = 3564;
pub const KEY_Thai_thonangmontho = 3505;
pub const KEY_Thai_thophuthao = 3506;
pub const KEY_Thai_thothahan = 3511;
pub const KEY_Thai_thothan = 3504;
pub const KEY_Thai_thothong = 3512;
pub const KEY_Thai_thothung = 3510;
pub const KEY_Thai_topatak = 3503;
pub const KEY_Thai_totao = 3509;
pub const KEY_Thai_wowaen = 3527;
pub const KEY_Thai_yoyak = 3522;
pub const KEY_Thai_yoying = 3501;
pub const KEY_Thorn = 222;
pub const KEY_Time = 269025183;
pub const KEY_ToDoList = 269025055;
pub const KEY_Tools = 269025153;
pub const KEY_TopMenu = 269025186;
pub const KEY_TouchpadOff = 269025201;
pub const KEY_TouchpadOn = 269025200;
pub const KEY_TouchpadToggle = 269025193;
pub const KEY_Touroku = 65323;
pub const KEY_Travel = 269025154;
pub const KEY_Tslash = 940;
pub const KEY_U = 85;
pub const KEY_UWB = 269025174;
pub const KEY_Uacute = 218;
pub const KEY_Ubelowdot = 16785124;
pub const KEY_Ubreve = 733;
pub const KEY_Ucircumflex = 219;
pub const KEY_Udiaeresis = 220;
pub const KEY_Udoubleacute = 475;
pub const KEY_Ugrave = 217;
pub const KEY_Uhook = 16785126;
pub const KEY_Uhorn = 16777647;
pub const KEY_Uhornacute = 16785128;
pub const KEY_Uhornbelowdot = 16785136;
pub const KEY_Uhorngrave = 16785130;
pub const KEY_Uhornhook = 16785132;
pub const KEY_Uhorntilde = 16785134;
pub const KEY_Ukrainian_GHE_WITH_UPTURN = 1725;
pub const KEY_Ukrainian_I = 1718;
pub const KEY_Ukrainian_IE = 1716;
pub const KEY_Ukrainian_YI = 1719;
pub const KEY_Ukrainian_ghe_with_upturn = 1709;
pub const KEY_Ukrainian_i = 1702;
pub const KEY_Ukrainian_ie = 1700;
pub const KEY_Ukrainian_yi = 1703;
pub const KEY_Ukranian_I = 1718;
pub const KEY_Ukranian_JE = 1716;
pub const KEY_Ukranian_YI = 1719;
pub const KEY_Ukranian_i = 1702;
pub const KEY_Ukranian_je = 1700;
pub const KEY_Ukranian_yi = 1703;
pub const KEY_Umacron = 990;
pub const KEY_Undo = 65381;
pub const KEY_Ungrab = 269024800;
pub const KEY_Uogonek = 985;
pub const KEY_Up = 65362;
pub const KEY_Uring = 473;
pub const KEY_User1KB = 269025157;
pub const KEY_User2KB = 269025158;
pub const KEY_UserPB = 269025156;
pub const KEY_Utilde = 989;
pub const KEY_V = 86;
pub const KEY_VendorHome = 269025076;
pub const KEY_Video = 269025159;
pub const KEY_View = 269025185;
pub const KEY_VoidSymbol = 16777215;
pub const KEY_W = 87;
pub const KEY_WLAN = 269025173;
pub const KEY_WWAN = 269025204;
pub const KEY_WWW = 269025070;
pub const KEY_Wacute = 16785026;
pub const KEY_WakeUp = 269025067;
pub const KEY_Wcircumflex = 16777588;
pub const KEY_Wdiaeresis = 16785028;
pub const KEY_WebCam = 269025167;
pub const KEY_Wgrave = 16785024;
pub const KEY_WheelButton = 269025160;
pub const KEY_WindowClear = 269025109;
pub const KEY_WonSign = 16785577;
pub const KEY_Word = 269025161;
pub const KEY_X = 88;
pub const KEY_Xabovedot = 16785034;
pub const KEY_Xfer = 269025162;
pub const KEY_Y = 89;
pub const KEY_Yacute = 221;
pub const KEY_Ybelowdot = 16785140;
pub const KEY_Ycircumflex = 16777590;
pub const KEY_Ydiaeresis = 5054;
pub const KEY_Yellow = 269025189;
pub const KEY_Ygrave = 16785138;
pub const KEY_Yhook = 16785142;
pub const KEY_Ytilde = 16785144;
pub const KEY_Z = 90;
pub const KEY_Zabovedot = 431;
pub const KEY_Zacute = 428;
pub const KEY_Zcaron = 430;
pub const KEY_Zen_Koho = 65341;
pub const KEY_Zenkaku = 65320;
pub const KEY_Zenkaku_Hankaku = 65322;
pub const KEY_ZoomIn = 269025163;
pub const KEY_ZoomOut = 269025164;
pub const KEY_Zstroke = 16777653;
pub const KEY_a = 97;
pub const KEY_aacute = 225;
pub const KEY_abelowdot = 16785057;
pub const KEY_abovedot = 511;
pub const KEY_abreve = 483;
pub const KEY_abreveacute = 16785071;
pub const KEY_abrevebelowdot = 16785079;
pub const KEY_abrevegrave = 16785073;
pub const KEY_abrevehook = 16785075;
pub const KEY_abrevetilde = 16785077;
pub const KEY_acircumflex = 226;
pub const KEY_acircumflexacute = 16785061;
pub const KEY_acircumflexbelowdot = 16785069;
pub const KEY_acircumflexgrave = 16785063;
pub const KEY_acircumflexhook = 16785065;
pub const KEY_acircumflextilde = 16785067;
pub const KEY_acute = 180;
pub const KEY_adiaeresis = 228;
pub const KEY_ae = 230;
pub const KEY_agrave = 224;
pub const KEY_ahook = 16785059;
pub const KEY_amacron = 992;
pub const KEY_ampersand = 38;
pub const KEY_aogonek = 433;
pub const KEY_apostrophe = 39;
pub const KEY_approxeq = 16785992;
pub const KEY_approximate = 2248;
pub const KEY_aring = 229;
pub const KEY_asciicircum = 94;
pub const KEY_asciitilde = 126;
pub const KEY_asterisk = 42;
pub const KEY_at = 64;
pub const KEY_atilde = 227;
pub const KEY_b = 98;
pub const KEY_babovedot = 16784899;
pub const KEY_backslash = 92;
pub const KEY_ballotcross = 2804;
pub const KEY_bar = 124;
pub const KEY_because = 16785973;
pub const KEY_blank = 2527;
pub const KEY_botintegral = 2213;
pub const KEY_botleftparens = 2220;
pub const KEY_botleftsqbracket = 2216;
pub const KEY_botleftsummation = 2226;
pub const KEY_botrightparens = 2222;
pub const KEY_botrightsqbracket = 2218;
pub const KEY_botrightsummation = 2230;
pub const KEY_bott = 2550;
pub const KEY_botvertsummationconnector = 2228;
pub const KEY_braceleft = 123;
pub const KEY_braceright = 125;
pub const KEY_bracketleft = 91;
pub const KEY_bracketright = 93;
pub const KEY_braille_blank = 16787456;
pub const KEY_braille_dot_1 = 65521;
pub const KEY_braille_dot_10 = 65530;
pub const KEY_braille_dot_2 = 65522;
pub const KEY_braille_dot_3 = 65523;
pub const KEY_braille_dot_4 = 65524;
pub const KEY_braille_dot_5 = 65525;
pub const KEY_braille_dot_6 = 65526;
pub const KEY_braille_dot_7 = 65527;
pub const KEY_braille_dot_8 = 65528;
pub const KEY_braille_dot_9 = 65529;
pub const KEY_braille_dots_1 = 16787457;
pub const KEY_braille_dots_12 = 16787459;
pub const KEY_braille_dots_123 = 16787463;
pub const KEY_braille_dots_1234 = 16787471;
pub const KEY_braille_dots_12345 = 16787487;
pub const KEY_braille_dots_123456 = 16787519;
pub const KEY_braille_dots_1234567 = 16787583;
pub const KEY_braille_dots_12345678 = 16787711;
pub const KEY_braille_dots_1234568 = 16787647;
pub const KEY_braille_dots_123457 = 16787551;
pub const KEY_braille_dots_1234578 = 16787679;
pub const KEY_braille_dots_123458 = 16787615;
pub const KEY_braille_dots_12346 = 16787503;
pub const KEY_braille_dots_123467 = 16787567;
pub const KEY_braille_dots_1234678 = 16787695;
pub const KEY_braille_dots_123468 = 16787631;
pub const KEY_braille_dots_12347 = 16787535;
pub const KEY_braille_dots_123478 = 16787663;
pub const KEY_braille_dots_12348 = 16787599;
pub const KEY_braille_dots_1235 = 16787479;
pub const KEY_braille_dots_12356 = 16787511;
pub const KEY_braille_dots_123567 = 16787575;
pub const KEY_braille_dots_1235678 = 16787703;
pub const KEY_braille_dots_123568 = 16787639;
pub const KEY_braille_dots_12357 = 16787543;
pub const KEY_braille_dots_123578 = 16787671;
pub const KEY_braille_dots_12358 = 16787607;
pub const KEY_braille_dots_1236 = 16787495;
pub const KEY_braille_dots_12367 = 16787559;
pub const KEY_braille_dots_123678 = 16787687;
pub const KEY_braille_dots_12368 = 16787623;
pub const KEY_braille_dots_1237 = 16787527;
pub const KEY_braille_dots_12378 = 16787655;
pub const KEY_braille_dots_1238 = 16787591;
pub const KEY_braille_dots_124 = 16787467;
pub const KEY_braille_dots_1245 = 16787483;
pub const KEY_braille_dots_12456 = 16787515;
pub const KEY_braille_dots_124567 = 16787579;
pub const KEY_braille_dots_1245678 = 16787707;
pub const KEY_braille_dots_124568 = 16787643;
pub const KEY_braille_dots_12457 = 16787547;
pub const KEY_braille_dots_124578 = 16787675;
pub const KEY_braille_dots_12458 = 16787611;
pub const KEY_braille_dots_1246 = 16787499;
pub const KEY_braille_dots_12467 = 16787563;
pub const KEY_braille_dots_124678 = 16787691;
pub const KEY_braille_dots_12468 = 16787627;
pub const KEY_braille_dots_1247 = 16787531;
pub const KEY_braille_dots_12478 = 16787659;
pub const KEY_braille_dots_1248 = 16787595;
pub const KEY_braille_dots_125 = 16787475;
pub const KEY_braille_dots_1256 = 16787507;
pub const KEY_braille_dots_12567 = 16787571;
pub const KEY_braille_dots_125678 = 16787699;
pub const KEY_braille_dots_12568 = 16787635;
pub const KEY_braille_dots_1257 = 16787539;
pub const KEY_braille_dots_12578 = 16787667;
pub const KEY_braille_dots_1258 = 16787603;
pub const KEY_braille_dots_126 = 16787491;
pub const KEY_braille_dots_1267 = 16787555;
pub const KEY_braille_dots_12678 = 16787683;
pub const KEY_braille_dots_1268 = 16787619;
pub const KEY_braille_dots_127 = 16787523;
pub const KEY_braille_dots_1278 = 16787651;
pub const KEY_braille_dots_128 = 16787587;
pub const KEY_braille_dots_13 = 16787461;
pub const KEY_braille_dots_134 = 16787469;
pub const KEY_braille_dots_1345 = 16787485;
pub const KEY_braille_dots_13456 = 16787517;
pub const KEY_braille_dots_134567 = 16787581;
pub const KEY_braille_dots_1345678 = 16787709;
pub const KEY_braille_dots_134568 = 16787645;
pub const KEY_braille_dots_13457 = 16787549;
pub const KEY_braille_dots_134578 = 16787677;
pub const KEY_braille_dots_13458 = 16787613;
pub const KEY_braille_dots_1346 = 16787501;
pub const KEY_braille_dots_13467 = 16787565;
pub const KEY_braille_dots_134678 = 16787693;
pub const KEY_braille_dots_13468 = 16787629;
pub const KEY_braille_dots_1347 = 16787533;
pub const KEY_braille_dots_13478 = 16787661;
pub const KEY_braille_dots_1348 = 16787597;
pub const KEY_braille_dots_135 = 16787477;
pub const KEY_braille_dots_1356 = 16787509;
pub const KEY_braille_dots_13567 = 16787573;
pub const KEY_braille_dots_135678 = 16787701;
pub const KEY_braille_dots_13568 = 16787637;
pub const KEY_braille_dots_1357 = 16787541;
pub const KEY_braille_dots_13578 = 16787669;
pub const KEY_braille_dots_1358 = 16787605;
pub const KEY_braille_dots_136 = 16787493;
pub const KEY_braille_dots_1367 = 16787557;
pub const KEY_braille_dots_13678 = 16787685;
pub const KEY_braille_dots_1368 = 16787621;
pub const KEY_braille_dots_137 = 16787525;
pub const KEY_braille_dots_1378 = 16787653;
pub const KEY_braille_dots_138 = 16787589;
pub const KEY_braille_dots_14 = 16787465;
pub const KEY_braille_dots_145 = 16787481;
pub const KEY_braille_dots_1456 = 16787513;
pub const KEY_braille_dots_14567 = 16787577;
pub const KEY_braille_dots_145678 = 16787705;
pub const KEY_braille_dots_14568 = 16787641;
pub const KEY_braille_dots_1457 = 16787545;
pub const KEY_braille_dots_14578 = 16787673;
pub const KEY_braille_dots_1458 = 16787609;
pub const KEY_braille_dots_146 = 16787497;
pub const KEY_braille_dots_1467 = 16787561;
pub const KEY_braille_dots_14678 = 16787689;
pub const KEY_braille_dots_1468 = 16787625;
pub const KEY_braille_dots_147 = 16787529;
pub const KEY_braille_dots_1478 = 16787657;
pub const KEY_braille_dots_148 = 16787593;
pub const KEY_braille_dots_15 = 16787473;
pub const KEY_braille_dots_156 = 16787505;
pub const KEY_braille_dots_1567 = 16787569;
pub const KEY_braille_dots_15678 = 16787697;
pub const KEY_braille_dots_1568 = 16787633;
pub const KEY_braille_dots_157 = 16787537;
pub const KEY_braille_dots_1578 = 16787665;
pub const KEY_braille_dots_158 = 16787601;
pub const KEY_braille_dots_16 = 16787489;
pub const KEY_braille_dots_167 = 16787553;
pub const KEY_braille_dots_1678 = 16787681;
pub const KEY_braille_dots_168 = 16787617;
pub const KEY_braille_dots_17 = 16787521;
pub const KEY_braille_dots_178 = 16787649;
pub const KEY_braille_dots_18 = 16787585;
pub const KEY_braille_dots_2 = 16787458;
pub const KEY_braille_dots_23 = 16787462;
pub const KEY_braille_dots_234 = 16787470;
pub const KEY_braille_dots_2345 = 16787486;
pub const KEY_braille_dots_23456 = 16787518;
pub const KEY_braille_dots_234567 = 16787582;
pub const KEY_braille_dots_2345678 = 16787710;
pub const KEY_braille_dots_234568 = 16787646;
pub const KEY_braille_dots_23457 = 16787550;
pub const KEY_braille_dots_234578 = 16787678;
pub const KEY_braille_dots_23458 = 16787614;
pub const KEY_braille_dots_2346 = 16787502;
pub const KEY_braille_dots_23467 = 16787566;
pub const KEY_braille_dots_234678 = 16787694;
pub const KEY_braille_dots_23468 = 16787630;
pub const KEY_braille_dots_2347 = 16787534;
pub const KEY_braille_dots_23478 = 16787662;
pub const KEY_braille_dots_2348 = 16787598;
pub const KEY_braille_dots_235 = 16787478;
pub const KEY_braille_dots_2356 = 16787510;
pub const KEY_braille_dots_23567 = 16787574;
pub const KEY_braille_dots_235678 = 16787702;
pub const KEY_braille_dots_23568 = 16787638;
pub const KEY_braille_dots_2357 = 16787542;
pub const KEY_braille_dots_23578 = 16787670;
pub const KEY_braille_dots_2358 = 16787606;
pub const KEY_braille_dots_236 = 16787494;
pub const KEY_braille_dots_2367 = 16787558;
pub const KEY_braille_dots_23678 = 16787686;
pub const KEY_braille_dots_2368 = 16787622;
pub const KEY_braille_dots_237 = 16787526;
pub const KEY_braille_dots_2378 = 16787654;
pub const KEY_braille_dots_238 = 16787590;
pub const KEY_braille_dots_24 = 16787466;
pub const KEY_braille_dots_245 = 16787482;
pub const KEY_braille_dots_2456 = 16787514;
pub const KEY_braille_dots_24567 = 16787578;
pub const KEY_braille_dots_245678 = 16787706;
pub const KEY_braille_dots_24568 = 16787642;
pub const KEY_braille_dots_2457 = 16787546;
pub const KEY_braille_dots_24578 = 16787674;
pub const KEY_braille_dots_2458 = 16787610;
pub const KEY_braille_dots_246 = 16787498;
pub const KEY_braille_dots_2467 = 16787562;
pub const KEY_braille_dots_24678 = 16787690;
pub const KEY_braille_dots_2468 = 16787626;
pub const KEY_braille_dots_247 = 16787530;
pub const KEY_braille_dots_2478 = 16787658;
pub const KEY_braille_dots_248 = 16787594;
pub const KEY_braille_dots_25 = 16787474;
pub const KEY_braille_dots_256 = 16787506;
pub const KEY_braille_dots_2567 = 16787570;
pub const KEY_braille_dots_25678 = 16787698;
pub const KEY_braille_dots_2568 = 16787634;
pub const KEY_braille_dots_257 = 16787538;
pub const KEY_braille_dots_2578 = 16787666;
pub const KEY_braille_dots_258 = 16787602;
pub const KEY_braille_dots_26 = 16787490;
pub const KEY_braille_dots_267 = 16787554;
pub const KEY_braille_dots_2678 = 16787682;
pub const KEY_braille_dots_268 = 16787618;
pub const KEY_braille_dots_27 = 16787522;
pub const KEY_braille_dots_278 = 16787650;
pub const KEY_braille_dots_28 = 16787586;
pub const KEY_braille_dots_3 = 16787460;
pub const KEY_braille_dots_34 = 16787468;
pub const KEY_braille_dots_345 = 16787484;
pub const KEY_braille_dots_3456 = 16787516;
pub const KEY_braille_dots_34567 = 16787580;
pub const KEY_braille_dots_345678 = 16787708;
pub const KEY_braille_dots_34568 = 16787644;
pub const KEY_braille_dots_3457 = 16787548;
pub const KEY_braille_dots_34578 = 16787676;
pub const KEY_braille_dots_3458 = 16787612;
pub const KEY_braille_dots_346 = 16787500;
pub const KEY_braille_dots_3467 = 16787564;
pub const KEY_braille_dots_34678 = 16787692;
pub const KEY_braille_dots_3468 = 16787628;
pub const KEY_braille_dots_347 = 16787532;
pub const KEY_braille_dots_3478 = 16787660;
pub const KEY_braille_dots_348 = 16787596;
pub const KEY_braille_dots_35 = 16787476;
pub const KEY_braille_dots_356 = 16787508;
pub const KEY_braille_dots_3567 = 16787572;
pub const KEY_braille_dots_35678 = 16787700;
pub const KEY_braille_dots_3568 = 16787636;
pub const KEY_braille_dots_357 = 16787540;
pub const KEY_braille_dots_3578 = 16787668;
pub const KEY_braille_dots_358 = 16787604;
pub const KEY_braille_dots_36 = 16787492;
pub const KEY_braille_dots_367 = 16787556;
pub const KEY_braille_dots_3678 = 16787684;
pub const KEY_braille_dots_368 = 16787620;
pub const KEY_braille_dots_37 = 16787524;
pub const KEY_braille_dots_378 = 16787652;
pub const KEY_braille_dots_38 = 16787588;
pub const KEY_braille_dots_4 = 16787464;
pub const KEY_braille_dots_45 = 16787480;
pub const KEY_braille_dots_456 = 16787512;
pub const KEY_braille_dots_4567 = 16787576;
pub const KEY_braille_dots_45678 = 16787704;
pub const KEY_braille_dots_4568 = 16787640;
pub const KEY_braille_dots_457 = 16787544;
pub const KEY_braille_dots_4578 = 16787672;
pub const KEY_braille_dots_458 = 16787608;
pub const KEY_braille_dots_46 = 16787496;
pub const KEY_braille_dots_467 = 16787560;
pub const KEY_braille_dots_4678 = 16787688;
pub const KEY_braille_dots_468 = 16787624;
pub const KEY_braille_dots_47 = 16787528;
pub const KEY_braille_dots_478 = 16787656;
pub const KEY_braille_dots_48 = 16787592;
pub const KEY_braille_dots_5 = 16787472;
pub const KEY_braille_dots_56 = 16787504;
pub const KEY_braille_dots_567 = 16787568;
pub const KEY_braille_dots_5678 = 16787696;
pub const KEY_braille_dots_568 = 16787632;
pub const KEY_braille_dots_57 = 16787536;
pub const KEY_braille_dots_578 = 16787664;
pub const KEY_braille_dots_58 = 16787600;
pub const KEY_braille_dots_6 = 16787488;
pub const KEY_braille_dots_67 = 16787552;
pub const KEY_braille_dots_678 = 16787680;
pub const KEY_braille_dots_68 = 16787616;
pub const KEY_braille_dots_7 = 16787520;
pub const KEY_braille_dots_78 = 16787648;
pub const KEY_braille_dots_8 = 16787584;
pub const KEY_breve = 418;
pub const KEY_brokenbar = 166;
pub const KEY_c = 99;
pub const KEY_c_h = 65187;
pub const KEY_cabovedot = 741;
pub const KEY_cacute = 486;
pub const KEY_careof = 2744;
pub const KEY_caret = 2812;
pub const KEY_caron = 439;
pub const KEY_ccaron = 488;
pub const KEY_ccedilla = 231;
pub const KEY_ccircumflex = 742;
pub const KEY_cedilla = 184;
pub const KEY_cent = 162;
pub const KEY_ch = 65184;
pub const KEY_checkerboard = 2529;
pub const KEY_checkmark = 2803;
pub const KEY_circle = 3023;
pub const KEY_club = 2796;
pub const KEY_colon = 58;
pub const KEY_comma = 44;
pub const KEY_containsas = 16785931;
pub const KEY_copyright = 169;
pub const KEY_cr = 2532;
pub const KEY_crossinglines = 2542;
pub const KEY_cuberoot = 16785947;
pub const KEY_currency = 164;
pub const KEY_cursor = 2815;
pub const KEY_d = 100;
pub const KEY_dabovedot = 16784907;
pub const KEY_dagger = 2801;
pub const KEY_dcaron = 495;
pub const KEY_dead_A = 65153;
pub const KEY_dead_E = 65155;
pub const KEY_dead_I = 65157;
pub const KEY_dead_O = 65159;
pub const KEY_dead_U = 65161;
pub const KEY_dead_a = 65152;
pub const KEY_dead_abovecomma = 65124;
pub const KEY_dead_abovedot = 65110;
pub const KEY_dead_abovereversedcomma = 65125;
pub const KEY_dead_abovering = 65112;
pub const KEY_dead_aboveverticalline = 65169;
pub const KEY_dead_acute = 65105;
pub const KEY_dead_belowbreve = 65131;
pub const KEY_dead_belowcircumflex = 65129;
pub const KEY_dead_belowcomma = 65134;
pub const KEY_dead_belowdiaeresis = 65132;
pub const KEY_dead_belowdot = 65120;
pub const KEY_dead_belowmacron = 65128;
pub const KEY_dead_belowring = 65127;
pub const KEY_dead_belowtilde = 65130;
pub const KEY_dead_belowverticalline = 65170;
pub const KEY_dead_breve = 65109;
pub const KEY_dead_capital_schwa = 65163;
pub const KEY_dead_caron = 65114;
pub const KEY_dead_cedilla = 65115;
pub const KEY_dead_circumflex = 65106;
pub const KEY_dead_currency = 65135;
pub const KEY_dead_dasia = 65125;
pub const KEY_dead_diaeresis = 65111;
pub const KEY_dead_doubleacute = 65113;
pub const KEY_dead_doublegrave = 65126;
pub const KEY_dead_e = 65154;
pub const KEY_dead_grave = 65104;
pub const KEY_dead_greek = 65164;
pub const KEY_dead_hook = 65121;
pub const KEY_dead_horn = 65122;
pub const KEY_dead_i = 65156;
pub const KEY_dead_invertedbreve = 65133;
pub const KEY_dead_iota = 65117;
pub const KEY_dead_longsolidusoverlay = 65171;
pub const KEY_dead_lowline = 65168;
pub const KEY_dead_macron = 65108;
pub const KEY_dead_o = 65158;
pub const KEY_dead_ogonek = 65116;
pub const KEY_dead_perispomeni = 65107;
pub const KEY_dead_psili = 65124;
pub const KEY_dead_semivoiced_sound = 65119;
pub const KEY_dead_small_schwa = 65162;
pub const KEY_dead_stroke = 65123;
pub const KEY_dead_tilde = 65107;
pub const KEY_dead_u = 65160;
pub const KEY_dead_voiced_sound = 65118;
pub const KEY_decimalpoint = 2749;
pub const KEY_degree = 176;
pub const KEY_diaeresis = 168;
pub const KEY_diamond = 2797;
pub const KEY_digitspace = 2725;
pub const KEY_dintegral = 16785964;
pub const KEY_division = 247;
pub const KEY_dollar = 36;
pub const KEY_doubbaselinedot = 2735;
pub const KEY_doubleacute = 445;
pub const KEY_doubledagger = 2802;
pub const KEY_doublelowquotemark = 2814;
pub const KEY_downarrow = 2302;
pub const KEY_downcaret = 2984;
pub const KEY_downshoe = 3030;
pub const KEY_downstile = 3012;
pub const KEY_downtack = 3010;
pub const KEY_dstroke = 496;
pub const KEY_e = 101;
pub const KEY_eabovedot = 1004;
pub const KEY_eacute = 233;
pub const KEY_ebelowdot = 16785081;
pub const KEY_ecaron = 492;
pub const KEY_ecircumflex = 234;
pub const KEY_ecircumflexacute = 16785087;
pub const KEY_ecircumflexbelowdot = 16785095;
pub const KEY_ecircumflexgrave = 16785089;
pub const KEY_ecircumflexhook = 16785091;
pub const KEY_ecircumflextilde = 16785093;
pub const KEY_ediaeresis = 235;
pub const KEY_egrave = 232;
pub const KEY_ehook = 16785083;
pub const KEY_eightsubscript = 16785544;
pub const KEY_eightsuperior = 16785528;
pub const KEY_elementof = 16785928;
pub const KEY_ellipsis = 2734;
pub const KEY_em3space = 2723;
pub const KEY_em4space = 2724;
pub const KEY_emacron = 954;
pub const KEY_emdash = 2729;
pub const KEY_emfilledcircle = 2782;
pub const KEY_emfilledrect = 2783;
pub const KEY_emopencircle = 2766;
pub const KEY_emopenrectangle = 2767;
pub const KEY_emptyset = 16785925;
pub const KEY_emspace = 2721;
pub const KEY_endash = 2730;
pub const KEY_enfilledcircbullet = 2790;
pub const KEY_enfilledsqbullet = 2791;
pub const KEY_eng = 959;
pub const KEY_enopencircbullet = 2784;
pub const KEY_enopensquarebullet = 2785;
pub const KEY_enspace = 2722;
pub const KEY_eogonek = 490;
pub const KEY_equal = 61;
pub const KEY_eth = 240;
pub const KEY_etilde = 16785085;
pub const KEY_exclam = 33;
pub const KEY_exclamdown = 161;
pub const KEY_ezh = 16777874;
pub const KEY_f = 102;
pub const KEY_fabovedot = 16784927;
pub const KEY_femalesymbol = 2808;
pub const KEY_ff = 2531;
pub const KEY_figdash = 2747;
pub const KEY_filledlefttribullet = 2780;
pub const KEY_filledrectbullet = 2779;
pub const KEY_filledrighttribullet = 2781;
pub const KEY_filledtribulletdown = 2793;
pub const KEY_filledtribulletup = 2792;
pub const KEY_fiveeighths = 2757;
pub const KEY_fivesixths = 2743;
pub const KEY_fivesubscript = 16785541;
pub const KEY_fivesuperior = 16785525;
pub const KEY_fourfifths = 2741;
pub const KEY_foursubscript = 16785540;
pub const KEY_foursuperior = 16785524;
pub const KEY_fourthroot = 16785948;
pub const KEY_function = 2294;
pub const KEY_g = 103;
pub const KEY_gabovedot = 757;
pub const KEY_gbreve = 699;
pub const KEY_gcaron = 16777703;
pub const KEY_gcedilla = 955;
pub const KEY_gcircumflex = 760;
pub const KEY_grave = 96;
pub const KEY_greater = 62;
pub const KEY_greaterthanequal = 2238;
pub const KEY_guillemotleft = 171;
pub const KEY_guillemotright = 187;
pub const KEY_h = 104;
pub const KEY_hairspace = 2728;
pub const KEY_hcircumflex = 694;
pub const KEY_heart = 2798;
pub const KEY_hebrew_aleph = 3296;
pub const KEY_hebrew_ayin = 3314;
pub const KEY_hebrew_bet = 3297;
pub const KEY_hebrew_beth = 3297;
pub const KEY_hebrew_chet = 3303;
pub const KEY_hebrew_dalet = 3299;
pub const KEY_hebrew_daleth = 3299;
pub const KEY_hebrew_doublelowline = 3295;
pub const KEY_hebrew_finalkaph = 3306;
pub const KEY_hebrew_finalmem = 3309;
pub const KEY_hebrew_finalnun = 3311;
pub const KEY_hebrew_finalpe = 3315;
pub const KEY_hebrew_finalzade = 3317;
pub const KEY_hebrew_finalzadi = 3317;
pub const KEY_hebrew_gimel = 3298;
pub const KEY_hebrew_gimmel = 3298;
pub const KEY_hebrew_he = 3300;
pub const KEY_hebrew_het = 3303;
pub const KEY_hebrew_kaph = 3307;
pub const KEY_hebrew_kuf = 3319;
pub const KEY_hebrew_lamed = 3308;
pub const KEY_hebrew_mem = 3310;
pub const KEY_hebrew_nun = 3312;
pub const KEY_hebrew_pe = 3316;
pub const KEY_hebrew_qoph = 3319;
pub const KEY_hebrew_resh = 3320;
pub const KEY_hebrew_samech = 3313;
pub const KEY_hebrew_samekh = 3313;
pub const KEY_hebrew_shin = 3321;
pub const KEY_hebrew_taf = 3322;
pub const KEY_hebrew_taw = 3322;
pub const KEY_hebrew_tet = 3304;
pub const KEY_hebrew_teth = 3304;
pub const KEY_hebrew_waw = 3301;
pub const KEY_hebrew_yod = 3305;
pub const KEY_hebrew_zade = 3318;
pub const KEY_hebrew_zadi = 3318;
pub const KEY_hebrew_zain = 3302;
pub const KEY_hebrew_zayin = 3302;
pub const KEY_hexagram = 2778;
pub const KEY_horizconnector = 2211;
pub const KEY_horizlinescan1 = 2543;
pub const KEY_horizlinescan3 = 2544;
pub const KEY_horizlinescan5 = 2545;
pub const KEY_horizlinescan7 = 2546;
pub const KEY_horizlinescan9 = 2547;
pub const KEY_hstroke = 689;
pub const KEY_ht = 2530;
pub const KEY_hyphen = 173;
pub const KEY_i = 105;
pub const KEY_iTouch = 269025120;
pub const KEY_iacute = 237;
pub const KEY_ibelowdot = 16785099;
pub const KEY_ibreve = 16777517;
pub const KEY_icircumflex = 238;
pub const KEY_identical = 2255;
pub const KEY_idiaeresis = 239;
pub const KEY_idotless = 697;
pub const KEY_ifonlyif = 2253;
pub const KEY_igrave = 236;
pub const KEY_ihook = 16785097;
pub const KEY_imacron = 1007;
pub const KEY_implies = 2254;
pub const KEY_includedin = 2266;
pub const KEY_includes = 2267;
pub const KEY_infinity = 2242;
pub const KEY_integral = 2239;
pub const KEY_intersection = 2268;
pub const KEY_iogonek = 999;
pub const KEY_itilde = 949;
pub const KEY_j = 106;
pub const KEY_jcircumflex = 700;
pub const KEY_jot = 3018;
pub const KEY_k = 107;
pub const KEY_kana_A = 1201;
pub const KEY_kana_CHI = 1217;
pub const KEY_kana_E = 1204;
pub const KEY_kana_FU = 1228;
pub const KEY_kana_HA = 1226;
pub const KEY_kana_HE = 1229;
pub const KEY_kana_HI = 1227;
pub const KEY_kana_HO = 1230;
pub const KEY_kana_HU = 1228;
pub const KEY_kana_I = 1202;
pub const KEY_kana_KA = 1206;
pub const KEY_kana_KE = 1209;
pub const KEY_kana_KI = 1207;
pub const KEY_kana_KO = 1210;
pub const KEY_kana_KU = 1208;
pub const KEY_kana_MA = 1231;
pub const KEY_kana_ME = 1234;
pub const KEY_kana_MI = 1232;
pub const KEY_kana_MO = 1235;
pub const KEY_kana_MU = 1233;
pub const KEY_kana_N = 1245;
pub const KEY_kana_NA = 1221;
pub const KEY_kana_NE = 1224;
pub const KEY_kana_NI = 1222;
pub const KEY_kana_NO = 1225;
pub const KEY_kana_NU = 1223;
pub const KEY_kana_O = 1205;
pub const KEY_kana_RA = 1239;
pub const KEY_kana_RE = 1242;
pub const KEY_kana_RI = 1240;
pub const KEY_kana_RO = 1243;
pub const KEY_kana_RU = 1241;
pub const KEY_kana_SA = 1211;
pub const KEY_kana_SE = 1214;
pub const KEY_kana_SHI = 1212;
pub const KEY_kana_SO = 1215;
pub const KEY_kana_SU = 1213;
pub const KEY_kana_TA = 1216;
pub const KEY_kana_TE = 1219;
pub const KEY_kana_TI = 1217;
pub const KEY_kana_TO = 1220;
pub const KEY_kana_TSU = 1218;
pub const KEY_kana_TU = 1218;
pub const KEY_kana_U = 1203;
pub const KEY_kana_WA = 1244;
pub const KEY_kana_WO = 1190;
pub const KEY_kana_YA = 1236;
pub const KEY_kana_YO = 1238;
pub const KEY_kana_YU = 1237;
pub const KEY_kana_a = 1191;
pub const KEY_kana_closingbracket = 1187;
pub const KEY_kana_comma = 1188;
pub const KEY_kana_conjunctive = 1189;
pub const KEY_kana_e = 1194;
pub const KEY_kana_fullstop = 1185;
pub const KEY_kana_i = 1192;
pub const KEY_kana_middledot = 1189;
pub const KEY_kana_o = 1195;
pub const KEY_kana_openingbracket = 1186;
pub const KEY_kana_switch = 65406;
pub const KEY_kana_tsu = 1199;
pub const KEY_kana_tu = 1199;
pub const KEY_kana_u = 1193;
pub const KEY_kana_ya = 1196;
pub const KEY_kana_yo = 1198;
pub const KEY_kana_yu = 1197;
pub const KEY_kappa = 930;
pub const KEY_kcedilla = 1011;
pub const KEY_kra = 930;
pub const KEY_l = 108;
pub const KEY_lacute = 485;
pub const KEY_latincross = 2777;
pub const KEY_lbelowdot = 16784951;
pub const KEY_lcaron = 437;
pub const KEY_lcedilla = 950;
pub const KEY_leftanglebracket = 2748;
pub const KEY_leftarrow = 2299;
pub const KEY_leftcaret = 2979;
pub const KEY_leftdoublequotemark = 2770;
pub const KEY_leftmiddlecurlybrace = 2223;
pub const KEY_leftopentriangle = 2764;
pub const KEY_leftpointer = 2794;
pub const KEY_leftradical = 2209;
pub const KEY_leftshoe = 3034;
pub const KEY_leftsinglequotemark = 2768;
pub const KEY_leftt = 2548;
pub const KEY_lefttack = 3036;
pub const KEY_less = 60;
pub const KEY_lessthanequal = 2236;
pub const KEY_lf = 2533;
pub const KEY_logicaland = 2270;
pub const KEY_logicalor = 2271;
pub const KEY_lowleftcorner = 2541;
pub const KEY_lowrightcorner = 2538;
pub const KEY_lstroke = 435;
pub const KEY_m = 109;
pub const KEY_mabovedot = 16784961;
pub const KEY_macron = 175;
pub const KEY_malesymbol = 2807;
pub const KEY_maltesecross = 2800;
pub const KEY_marker = 2751;
pub const KEY_masculine = 186;
pub const KEY_minus = 45;
pub const KEY_minutes = 2774;
pub const KEY_mu = 181;
pub const KEY_multiply = 215;
pub const KEY_musicalflat = 2806;
pub const KEY_musicalsharp = 2805;
pub const KEY_n = 110;
pub const KEY_nabla = 2245;
pub const KEY_nacute = 497;
pub const KEY_ncaron = 498;
pub const KEY_ncedilla = 1009;
pub const KEY_ninesubscript = 16785545;
pub const KEY_ninesuperior = 16785529;
pub const KEY_nl = 2536;
pub const KEY_nobreakspace = 160;
pub const KEY_notapproxeq = 16785991;
pub const KEY_notelementof = 16785929;
pub const KEY_notequal = 2237;
pub const KEY_notidentical = 16786018;
pub const KEY_notsign = 172;
pub const KEY_ntilde = 241;
pub const KEY_numbersign = 35;
pub const KEY_numerosign = 1712;
pub const KEY_o = 111;
pub const KEY_oacute = 243;
pub const KEY_obarred = 16777845;
pub const KEY_obelowdot = 16785101;
pub const KEY_ocaron = 16777682;
pub const KEY_ocircumflex = 244;
pub const KEY_ocircumflexacute = 16785105;
pub const KEY_ocircumflexbelowdot = 16785113;
pub const KEY_ocircumflexgrave = 16785107;
pub const KEY_ocircumflexhook = 16785109;
pub const KEY_ocircumflextilde = 16785111;
pub const KEY_odiaeresis = 246;
pub const KEY_odoubleacute = 501;
pub const KEY_oe = 5053;
pub const KEY_ogonek = 434;
pub const KEY_ograve = 242;
pub const KEY_ohook = 16785103;
pub const KEY_ohorn = 16777633;
pub const KEY_ohornacute = 16785115;
pub const KEY_ohornbelowdot = 16785123;
pub const KEY_ohorngrave = 16785117;
pub const KEY_ohornhook = 16785119;
pub const KEY_ohorntilde = 16785121;
pub const KEY_omacron = 1010;
pub const KEY_oneeighth = 2755;
pub const KEY_onefifth = 2738;
pub const KEY_onehalf = 189;
pub const KEY_onequarter = 188;
pub const KEY_onesixth = 2742;
pub const KEY_onesubscript = 16785537;
pub const KEY_onesuperior = 185;
pub const KEY_onethird = 2736;
pub const KEY_ooblique = 248;
pub const KEY_openrectbullet = 2786;
pub const KEY_openstar = 2789;
pub const KEY_opentribulletdown = 2788;
pub const KEY_opentribulletup = 2787;
pub const KEY_ordfeminine = 170;
pub const KEY_oslash = 248;
pub const KEY_otilde = 245;
pub const KEY_overbar = 3008;
pub const KEY_overline = 1150;
pub const KEY_p = 112;
pub const KEY_pabovedot = 16784983;
pub const KEY_paragraph = 182;
pub const KEY_parenleft = 40;
pub const KEY_parenright = 41;
pub const KEY_partdifferential = 16785922;
pub const KEY_partialderivative = 2287;
pub const KEY_percent = 37;
pub const KEY_period = 46;
pub const KEY_periodcentered = 183;
pub const KEY_permille = 2773;
pub const KEY_phonographcopyright = 2811;
pub const KEY_plus = 43;
pub const KEY_plusminus = 177;
pub const KEY_prescription = 2772;
pub const KEY_prolongedsound = 1200;
pub const KEY_punctspace = 2726;
pub const KEY_q = 113;
pub const KEY_quad = 3020;
pub const KEY_question = 63;
pub const KEY_questiondown = 191;
pub const KEY_quotedbl = 34;
pub const KEY_quoteleft = 96;
pub const KEY_quoteright = 39;
pub const KEY_r = 114;
pub const KEY_racute = 480;
pub const KEY_radical = 2262;
pub const KEY_rcaron = 504;
pub const KEY_rcedilla = 947;
pub const KEY_registered = 174;
pub const KEY_rightanglebracket = 2750;
pub const KEY_rightarrow = 2301;
pub const KEY_rightcaret = 2982;
pub const KEY_rightdoublequotemark = 2771;
pub const KEY_rightmiddlecurlybrace = 2224;
pub const KEY_rightmiddlesummation = 2231;
pub const KEY_rightopentriangle = 2765;
pub const KEY_rightpointer = 2795;
pub const KEY_rightshoe = 3032;
pub const KEY_rightsinglequotemark = 2769;
pub const KEY_rightt = 2549;
pub const KEY_righttack = 3068;
pub const KEY_s = 115;
pub const KEY_sabovedot = 16784993;
pub const KEY_sacute = 438;
pub const KEY_scaron = 441;
pub const KEY_scedilla = 442;
pub const KEY_schwa = 16777817;
pub const KEY_scircumflex = 766;
pub const KEY_script_switch = 65406;
pub const KEY_seconds = 2775;
pub const KEY_section = 167;
pub const KEY_semicolon = 59;
pub const KEY_semivoicedsound = 1247;
pub const KEY_seveneighths = 2758;
pub const KEY_sevensubscript = 16785543;
pub const KEY_sevensuperior = 16785527;
pub const KEY_signaturemark = 2762;
pub const KEY_signifblank = 2732;
pub const KEY_similarequal = 2249;
pub const KEY_singlelowquotemark = 2813;
pub const KEY_sixsubscript = 16785542;
pub const KEY_sixsuperior = 16785526;
pub const KEY_slash = 47;
pub const KEY_soliddiamond = 2528;
pub const KEY_space = 32;
pub const KEY_squareroot = 16785946;
pub const KEY_ssharp = 223;
pub const KEY_sterling = 163;
pub const KEY_stricteq = 16786019;
pub const KEY_t = 116;
pub const KEY_tabovedot = 16785003;
pub const KEY_tcaron = 443;
pub const KEY_tcedilla = 510;
pub const KEY_telephone = 2809;
pub const KEY_telephonerecorder = 2810;
pub const KEY_therefore = 2240;
pub const KEY_thinspace = 2727;
pub const KEY_thorn = 254;
pub const KEY_threeeighths = 2756;
pub const KEY_threefifths = 2740;
pub const KEY_threequarters = 190;
pub const KEY_threesubscript = 16785539;
pub const KEY_threesuperior = 179;
pub const KEY_tintegral = 16785965;
pub const KEY_topintegral = 2212;
pub const KEY_topleftparens = 2219;
pub const KEY_topleftradical = 2210;
pub const KEY_topleftsqbracket = 2215;
pub const KEY_topleftsummation = 2225;
pub const KEY_toprightparens = 2221;
pub const KEY_toprightsqbracket = 2217;
pub const KEY_toprightsummation = 2229;
pub const KEY_topt = 2551;
pub const KEY_topvertsummationconnector = 2227;
pub const KEY_trademark = 2761;
pub const KEY_trademarkincircle = 2763;
pub const KEY_tslash = 956;
pub const KEY_twofifths = 2739;
pub const KEY_twosubscript = 16785538;
pub const KEY_twosuperior = 178;
pub const KEY_twothirds = 2737;
pub const KEY_u = 117;
pub const KEY_uacute = 250;
pub const KEY_ubelowdot = 16785125;
pub const KEY_ubreve = 765;
pub const KEY_ucircumflex = 251;
pub const KEY_udiaeresis = 252;
pub const KEY_udoubleacute = 507;
pub const KEY_ugrave = 249;
pub const KEY_uhook = 16785127;
pub const KEY_uhorn = 16777648;
pub const KEY_uhornacute = 16785129;
pub const KEY_uhornbelowdot = 16785137;
pub const KEY_uhorngrave = 16785131;
pub const KEY_uhornhook = 16785133;
pub const KEY_uhorntilde = 16785135;
pub const KEY_umacron = 1022;
pub const KEY_underbar = 3014;
pub const KEY_underscore = 95;
pub const KEY_union = 2269;
pub const KEY_uogonek = 1017;
pub const KEY_uparrow = 2300;
pub const KEY_upcaret = 2985;
pub const KEY_upleftcorner = 2540;
pub const KEY_uprightcorner = 2539;
pub const KEY_upshoe = 3011;
pub const KEY_upstile = 3027;
pub const KEY_uptack = 3022;
pub const KEY_uring = 505;
pub const KEY_utilde = 1021;
pub const KEY_v = 118;
pub const KEY_variation = 2241;
pub const KEY_vertbar = 2552;
pub const KEY_vertconnector = 2214;
pub const KEY_voicedsound = 1246;
pub const KEY_vt = 2537;
pub const KEY_w = 119;
pub const KEY_wacute = 16785027;
pub const KEY_wcircumflex = 16777589;
pub const KEY_wdiaeresis = 16785029;
pub const KEY_wgrave = 16785025;
pub const KEY_x = 120;
pub const KEY_xabovedot = 16785035;
pub const KEY_y = 121;
pub const KEY_yacute = 253;
pub const KEY_ybelowdot = 16785141;
pub const KEY_ycircumflex = 16777591;
pub const KEY_ydiaeresis = 255;
pub const KEY_yen = 165;
pub const KEY_ygrave = 16785139;
pub const KEY_yhook = 16785143;
pub const KEY_ytilde = 16785145;
pub const KEY_z = 122;
pub const KEY_zabovedot = 447;
pub const KEY_zacute = 444;
pub const KEY_zcaron = 446;
pub const KEY_zerosubscript = 16785536;
pub const KEY_zerosuperior = 16785520;
pub const KEY_zstroke = 16777654;
pub const MAJOR_VERSION = 3;
pub const MAX_TIMECOORD_AXES = 128;
pub const MICRO_VERSION = 49;
pub const MINOR_VERSION = 24;
/// A special value, indicating that the background
/// for a window should be inherited from the parent window.
pub const PARENT_RELATIVE = 1;
/// This is the priority that the idle handler processing window updates
/// is given in the
/// [GLib Main Loop][glib-The-Main-Event-Loop].
pub const PRIORITY_REDRAW = 120;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
