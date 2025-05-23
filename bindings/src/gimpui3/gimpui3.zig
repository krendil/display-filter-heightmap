pub const ext = @import("ext.zig");
const gimpui = @This();

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
const gtk = @import("gtk3");
const xlib = @import("xlib2");
const gdk = @import("gdk3");
const gdkpixbuf = @import("gdkpixbuf2");
const atk = @import("atk1");
const gimp = @import("gimp3");
const gegl = @import("gegl0");
const babl = @import("babl0");
/// A widget providing a preview with fixed aspect ratio.
pub const AspectPreview = opaque {
    pub const Parent = gimpui.Preview;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.AspectPreviewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const drawable = struct {
            pub const name = "drawable";

            pub const Type = ?*gimp.Drawable;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.AspectPreview` widget for `drawable_`. See also
    /// `gimpui.DrawablePreview.newFromDrawable`.
    extern fn gimp_aspect_preview_new_from_drawable(p_drawable: *gimp.Drawable) *gimpui.AspectPreview;
    pub const newFromDrawable = gimp_aspect_preview_new_from_drawable;

    extern fn gimp_aspect_preview_get_type() usize;
    pub const getGObjectType = gimp_aspect_preview_get_type;

    extern fn g_object_ref(p_self: *gimpui.AspectPreview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.AspectPreview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *AspectPreview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A base class for a documentation browser.
pub const Browser = opaque {
    pub const Parent = gtk.Paned;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.BrowserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const search = struct {
            pub const name = "search";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Browser, p_instance))),
                    gobject.signalLookup("search", Browser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `gimpui.Browser` widget.
    extern fn gimp_browser_new() *gimpui.Browser;
    pub const new = gimp_browser_new;

    /// Populates the `gtk.ComboBox` with search types.
    extern fn gimp_browser_add_search_types(p_browser: *Browser, p_first_type_label: [*:0]const u8, p_first_type_id: c_int, ...) void;
    pub const addSearchTypes = gimp_browser_add_search_types;

    extern fn gimp_browser_get_left_vbox(p_browser: *Browser) *gtk.Box;
    pub const getLeftVbox = gimp_browser_get_left_vbox;

    extern fn gimp_browser_get_right_vbox(p_browser: *Browser) *gtk.Box;
    pub const getRightVbox = gimp_browser_get_right_vbox;

    /// Sets the search summary text.
    extern fn gimp_browser_set_search_summary(p_browser: *Browser, p_summary: [*:0]const u8) void;
    pub const setSearchSummary = gimp_browser_set_search_summary;

    /// Sets the widget to appear on the right side of the `browser`.
    extern fn gimp_browser_set_widget(p_browser: *Browser, p_widget: *gtk.Widget) void;
    pub const setWidget = gimp_browser_set_widget;

    /// Displays `message` in the right side of the `browser`. Unless the right
    /// side already contains a `gtk.Label`, the widget previously added with
    /// `gimpui.Browser.setWidget` is removed and replaced by a `gtk.Label`.
    extern fn gimp_browser_show_message(p_browser: *Browser, p_message: [*:0]const u8) void;
    pub const showMessage = gimp_browser_show_message;

    extern fn gimp_browser_get_type() usize;
    pub const getGObjectType = gimp_browser_get_type;

    extern fn g_object_ref(p_self: *gimpui.Browser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Browser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Browser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a brush selection dialog.
///
/// Note that this widget draws itself using `GEGL` code. You **must** call
/// `gegl.init` first to be able to use this chooser.
pub const BrushChooser = opaque {
    pub const Parent = gimpui.ResourceChooser;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.BrushChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a brush.
    /// You can put this widget in a plug-in dialog.
    ///
    /// When brush is NULL, initial choice is from context.
    extern fn gimp_brush_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_brush: ?*gimp.Brush) *gimpui.BrushChooser;
    pub const new = gimp_brush_chooser_new;

    extern fn gimp_brush_chooser_get_type() usize;
    pub const getGObjectType = gimp_brush_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.BrushChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.BrushChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BrushChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimpui.BusyBox` displays a styled message, providing indication of
/// an ongoing operation.
pub const BusyBox = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.BusyBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Specifies the displayed message.
        pub const message = struct {
            pub const name = "message";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.BusyBox` widget.
    extern fn gimp_busy_box_new(p_message: ?[*:0]const u8) *gimpui.BusyBox;
    pub const new = gimp_busy_box_new;

    /// Returns the displayed message of `box`.
    extern fn gimp_busy_box_get_message(p_box: *BusyBox) [*:0]const u8;
    pub const getMessage = gimp_busy_box_get_message;

    /// Sets the displayed message og `box` to `message`.
    extern fn gimp_busy_box_set_message(p_box: *BusyBox, p_message: [*:0]const u8) void;
    pub const setMessage = gimp_busy_box_set_message;

    extern fn gimp_busy_box_get_type() usize;
    pub const getGObjectType = gimp_busy_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.BusyBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.BusyBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *BusyBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimpui.Button` adds an extra signal to the `gtk.Button` widget that
/// allows the callback to distinguish a normal click from a click that
/// was performed with modifier keys pressed.
pub const Button = extern struct {
    pub const Parent = gtk.Button;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Actionable, gtk.Activatable, gtk.Buildable };
    pub const Class = gimpui.ButtonClass;
    f_parent_instance: gtk.Button,

    pub const virtual_methods = struct {
        /// Emits the button's "extended_clicked" signal.
        pub const extended_clicked = struct {
            pub fn call(p_class: anytype, p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_modifier_state: gdk.ModifierType) void {
                return gobject.ext.as(Button.Class, p_class).f_extended_clicked.?(gobject.ext.as(Button, p_button), p_modifier_state);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_modifier_state: gdk.ModifierType) callconv(.c) void) void {
                gobject.ext.as(Button.Class, p_class).f_extended_clicked = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal is emitted when the button is clicked with a modifier
        /// key pressed.
        pub const extended_clicked = struct {
            pub const name = "extended-clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: gdk.ModifierType, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Button, p_instance))),
                    gobject.signalLookup("extended-clicked", Button.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.Button` widget.
    extern fn gimp_button_new() *gimpui.Button;
    pub const new = gimp_button_new;

    /// Emits the button's "extended_clicked" signal.
    extern fn gimp_button_extended_clicked(p_button: *Button, p_modifier_state: gdk.ModifierType) void;
    pub const extendedClicked = gimp_button_extended_clicked;

    extern fn gimp_button_get_type() usize;
    pub const getGObjectType = gimp_button_get_type;

    extern fn g_object_ref(p_self: *gimpui.Button) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Button) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Button, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.CellRenderer` to display a `gegl.Color` color.
pub const CellRendererColor = opaque {
    pub const Parent = gtk.CellRenderer;
    pub const Implements = [_]type{};
    pub const Class = gimpui.CellRendererColorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const color = struct {
            pub const name = "color";

            pub const Type = ?*gegl.Color;
        };

        pub const icon_size = struct {
            pub const name = "icon-size";

            pub const Type = c_int;
        };

        pub const @"opaque" = struct {
            pub const name = "opaque";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a `gtk.CellRenderer` that displays a color.
    extern fn gimp_cell_renderer_color_new() *gimpui.CellRendererColor;
    pub const new = gimp_cell_renderer_color_new;

    extern fn gimp_cell_renderer_color_get_type() usize;
    pub const getGObjectType = gimp_cell_renderer_color_get_type;

    extern fn g_object_ref(p_self: *gimpui.CellRendererColor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.CellRendererColor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CellRendererColor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.CellRendererToggle` that displays icons instead of a checkbox.
pub const CellRendererToggle = opaque {
    pub const Parent = gtk.CellRendererToggle;
    pub const Implements = [_]type{};
    pub const Class = gimpui.CellRendererToggleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };

        pub const icon_size = struct {
            pub const name = "icon-size";

            pub const Type = c_int;
        };

        pub const override_background = struct {
            pub const name = "override-background";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const clicked = struct {
            pub const name = "clicked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: [*:0]u8, p_p0: gdk.ModifierType, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(CellRendererToggle, p_instance))),
                    gobject.signalLookup("clicked", CellRendererToggle.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a custom version of the `gtk.CellRendererToggle`. Instead of
    /// showing the standard toggle button, it shows a named icon if the
    /// cell is active and no icon otherwise. This cell renderer is for
    /// example used in the Layers treeview to indicate and control the
    /// layer's visibility by showing `GIMP_STOCK_VISIBLE`.
    extern fn gimp_cell_renderer_toggle_new(p_icon_name: [*:0]const u8) *gimpui.CellRendererToggle;
    pub const new = gimp_cell_renderer_toggle_new;

    /// Emits the "clicked" signal from a `gimpui.CellRendererToggle`.
    extern fn gimp_cell_renderer_toggle_clicked(p_cell: *CellRendererToggle, p_path: [*:0]const u8, p_state: gdk.ModifierType) void;
    pub const clicked = gimp_cell_renderer_toggle_clicked;

    extern fn gimp_cell_renderer_toggle_get_type() usize;
    pub const getGObjectType = gimp_cell_renderer_toggle_get_type;

    extern fn g_object_ref(p_self: *gimpui.CellRendererToggle) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.CellRendererToggle) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *CellRendererToggle, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget provides a button showing either a linked or a broken
/// chain that can be used to link two entries, spinbuttons, colors or
/// other GUI elements and show that they may be locked. Use it for
/// example to connect X and Y ratios to provide the possibility of a
/// constrained aspect ratio.
///
/// The `gimpui.ChainButton` only gives visual feedback, it does not really
/// connect widgets. You have to take care of locking the values
/// yourself by checking the state of the `gimpui.ChainButton` whenever a
/// value changes in one of the connected widgets and adjusting the
/// other value if necessary.
pub const ChainButton = opaque {
    pub const Parent = gtk.Grid;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ChainButtonClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The toggled state of the chain button.
        pub const active = struct {
            pub const name = "active";

            pub const Type = c_int;
        };

        /// The chain button icon size.
        pub const icon_size = struct {
            pub const name = "icon-size";

            pub const Type = gtk.IconSize;
        };

        /// The position in which the chain button will be used.
        pub const position = struct {
            pub const name = "position";

            pub const Type = gimpui.ChainPosition;
        };
    };

    pub const signals = struct {
        pub const toggled = struct {
            pub const name = "toggled";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ChainButton, p_instance))),
                    gobject.signalLookup("toggled", ChainButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.ChainButton` widget.
    ///
    /// This returns a button showing either a broken or a linked chain and
    /// small clamps attached to both sides that visually group the two
    /// widgets you want to connect. This widget looks best when attached
    /// to a grid taking up two columns (or rows respectively) next to the
    /// widgets that it is supposed to connect. It may work for more than
    /// two widgets, but the look is optimized for two.
    extern fn gimp_chain_button_new(p_position: gimpui.ChainPosition) *gimpui.ChainButton;
    pub const new = gimp_chain_button_new;

    /// Checks the state of the `gimpui.ChainButton`.
    extern fn gimp_chain_button_get_active(p_button: *ChainButton) c_int;
    pub const getActive = gimp_chain_button_get_active;

    extern fn gimp_chain_button_get_button(p_button: *ChainButton) *gtk.Button;
    pub const getButton = gimp_chain_button_get_button;

    /// Gets the icon size of the `gimpui.ChainButton`.
    extern fn gimp_chain_button_get_icon_size(p_button: *ChainButton) gtk.IconSize;
    pub const getIconSize = gimp_chain_button_get_icon_size;

    /// Sets the state of the `gimpui.ChainButton` to be either locked (`TRUE`) or
    /// unlocked (`FALSE`) and changes the showed pixmap to reflect the new state.
    extern fn gimp_chain_button_set_active(p_button: *ChainButton, p_active: c_int) void;
    pub const setActive = gimp_chain_button_set_active;

    /// Sets the icon size of the `gimpui.ChainButton`.
    extern fn gimp_chain_button_set_icon_size(p_button: *ChainButton, p_size: gtk.IconSize) void;
    pub const setIconSize = gimp_chain_button_set_icon_size;

    extern fn gimp_chain_button_get_type() usize;
    pub const getGObjectType = gimp_chain_button_get_type;

    extern fn g_object_ref(p_self: *gimpui.ChainButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ChainButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ChainButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChannelComboBox = opaque {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = opaque {
        pub const Instance = ChannelComboBox;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.IntComboBox` filled with all currently opened
    /// channels. See `gimpui.DrawableComboBox.new` for more information.
    extern fn gimp_channel_combo_box_new(p_constraint: ?gimpui.ItemConstraintFunc, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gimpui.ChannelComboBox;
    pub const new = gimp_channel_combo_box_new;

    extern fn gimp_channel_combo_box_get_type() usize;
    pub const getGObjectType = gimp_channel_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.ChannelComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ChannelComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ChannelComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Displays a `gegl.Color`, optionally with alpha-channel.
pub const ColorArea = opaque {
    pub const Parent = gtk.DrawingArea;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.ColorAreaClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The color displayed in the color area.
        pub const color = struct {
            pub const name = "color";

            pub const Type = ?*gegl.Color;
        };

        pub const drag_mask = struct {
            pub const name = "drag-mask";

            pub const Type = gdk.ModifierType;
        };

        /// Whether to draw a thin border in the foreground color around the area.
        pub const draw_border = struct {
            pub const name = "draw-border";

            pub const Type = c_int;
        };

        /// The type of the color area.
        pub const @"type" = struct {
            pub const name = "type";

            pub const Type = gimpui.ColorAreaType;
        };
    };

    pub const signals = struct {
        pub const color_changed = struct {
            pub const name = "color-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorArea, p_instance))),
                    gobject.signalLookup("color-changed", ColorArea.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.ColorArea` widget.
    ///
    /// This returns a preview area showing the color. It handles color
    /// DND. If the color changes, the "color_changed" signal is emitted.
    extern fn gimp_color_area_new(p_color: *gegl.Color, p_type: gimpui.ColorAreaType, p_drag_mask: gdk.ModifierType) *gimpui.ColorArea;
    pub const new = gimp_color_area_new;

    /// Allows dragging the color displayed with buttons identified by
    /// `drag_mask`. The drag supports targets of type "application/x-color".
    ///
    /// Note that setting a `drag_mask` of 0 disables the drag ability.
    extern fn gimp_color_area_enable_drag(p_area: *ColorArea, p_drag_mask: gdk.ModifierType) void;
    pub const enableDrag = gimp_color_area_enable_drag;

    /// Retrieves the current color of the `area`.
    extern fn gimp_color_area_get_color(p_area: *ColorArea) *gegl.Color;
    pub const getColor = gimp_color_area_get_color;

    /// Checks whether the `area` shows transparency information. This is determined
    /// via the `area`'s `gimpui.ColorAreaType`.
    extern fn gimp_color_area_has_alpha(p_area: *ColorArea) c_int;
    pub const hasAlpha = gimp_color_area_has_alpha;

    /// Sets `area` to a different `color`.
    extern fn gimp_color_area_set_color(p_area: *ColorArea, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_area_set_color;

    /// Sets the color management configuration to use with this color area.
    extern fn gimp_color_area_set_color_config(p_area: *ColorArea, p_config: *gimp.ColorConfig) void;
    pub const setColorConfig = gimp_color_area_set_color_config;

    /// The `area` can draw a thin border in the foreground color around
    /// itself.  This function toggles this behavior on and off. The
    /// default is not draw a border.
    extern fn gimp_color_area_set_draw_border(p_area: *ColorArea, p_draw_border: c_int) void;
    pub const setDrawBorder = gimp_color_area_set_draw_border;

    /// Sets the color area to render as an out-of-gamut color, i.e. with a
    /// small triangle on a corner using the color management out of gamut
    /// color (as per `gimpui.ColorArea.setColorConfig`).
    ///
    /// By default, `area` will render as out-of-gamut for any RGB color with
    /// a channel out of the [0; 1] range. This function allows to consider
    /// more colors out of gamut (for instance non-gray colors on a grayscale
    /// image, or colors absent of palettes in indexed images, etc.)
    extern fn gimp_color_area_set_out_of_gamut(p_area: *ColorArea, p_out_of_gamut: c_int) void;
    pub const setOutOfGamut = gimp_color_area_set_out_of_gamut;

    /// Changes the type of `area`. The `gimpui.ColorAreaType` determines
    /// whether the widget shows transparency information and chooses the
    /// size of the checkerboard used to do that.
    extern fn gimp_color_area_set_type(p_area: *ColorArea, p_type: gimpui.ColorAreaType) void;
    pub const setType = gimp_color_area_set_type;

    extern fn gimp_color_area_get_type() usize;
    pub const getGObjectType = gimp_color_area_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorArea) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorArea) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorArea, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget provides a simple button with a preview showing the
/// color.
///
/// On click a color selection dialog is opened. Additionally the
/// button supports Drag and Drop and has a right-click menu that
/// allows one to choose the color from the current FG or BG color. If
/// the user changes the color, the "color-changed" signal is emitted.
pub const ColorButton = extern struct {
    pub const Parent = gimpui.Button;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Actionable, gtk.Activatable, gtk.Buildable };
    pub const Class = gimpui.ColorButtonClass;
    f_parent_instance: gimpui.Button,

    pub const virtual_methods = struct {
        pub const color_changed = struct {
            pub fn call(p_class: anytype, p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorButton.Class, p_class).f_color_changed.?(gobject.ext.as(ColorButton, p_button));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorButton.Class, p_class).f_color_changed = @ptrCast(p_implementation);
            }
        };

        pub const get_action_type = struct {
            pub fn call(p_class: anytype, p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) usize {
                return gobject.ext.as(ColorButton.Class, p_class).f_get_action_type.?(gobject.ext.as(ColorButton, p_button));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) usize) void {
                gobject.ext.as(ColorButton.Class, p_class).f_get_action_type = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The minimum height of the button's `gimpui.ColorArea`.
        pub const area_height = struct {
            pub const name = "area-height";

            pub const Type = c_int;
        };

        /// The minimum width of the button's `gimpui.ColorArea`.
        pub const area_width = struct {
            pub const name = "area-width";

            pub const Type = c_int;
        };

        /// The color displayed in the button's color area.
        pub const color = struct {
            pub const name = "color";

            pub const Type = ?*gegl.Color;
        };

        /// The `gimp.ColorConfig` object used for the button's `gimpui.ColorArea`
        /// and `gimpui.ColorSelection`.
        pub const color_config = struct {
            pub const name = "color-config";

            pub const Type = ?*gimp.ColorConfig;
        };

        /// The update policy of the color button.
        pub const continuous_update = struct {
            pub const name = "continuous-update";

            pub const Type = c_int;
        };

        /// The title to be used for the color selection dialog.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// The type of the button's color area.
        pub const @"type" = struct {
            pub const name = "type";

            pub const Type = gimpui.ColorAreaType;
        };
    };

    pub const signals = struct {
        pub const color_changed = struct {
            pub const name = "color-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorButton, p_instance))),
                    gobject.signalLookup("color-changed", ColorButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.ColorButton` widget.
    ///
    /// This returns a button with a preview showing the color.
    /// When the button is clicked a GtkColorSelectionDialog is opened.
    /// If the user changes the color the new color is written into the
    /// array that was used to pass the initial color and the "color-changed"
    /// signal is emitted.
    extern fn gimp_color_button_new(p_title: [*:0]const u8, p_width: c_int, p_height: c_int, p_color: *gegl.Color, p_type: gimpui.ColorAreaType) *gimpui.ColorButton;
    pub const new = gimp_color_button_new;

    extern fn gimp_color_button_get_action_group(p_button: *ColorButton) *gio.SimpleActionGroup;
    pub const getActionGroup = gimp_color_button_get_action_group;

    /// Retrieves the currently set color from the `button`.
    extern fn gimp_color_button_get_color(p_button: *ColorButton) *gegl.Color;
    pub const getColor = gimp_color_button_get_color;

    extern fn gimp_color_button_get_title(p_button: *ColorButton) [*:0]const u8;
    pub const getTitle = gimp_color_button_get_title;

    /// Returns the color button's `continuous_update` property.
    extern fn gimp_color_button_get_update(p_button: *ColorButton) c_int;
    pub const getUpdate = gimp_color_button_get_update;

    /// Checks whether the `buttons` shows transparency information.
    extern fn gimp_color_button_has_alpha(p_button: *ColorButton) c_int;
    pub const hasAlpha = gimp_color_button_has_alpha;

    /// Sets the `button` to the given `color`.
    extern fn gimp_color_button_set_color(p_button: *ColorButton, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_button_set_color;

    /// Sets the color management configuration to use with this color button's
    /// `gimpui.ColorArea`.
    extern fn gimp_color_button_set_color_config(p_button: *ColorButton, p_config: *gimp.ColorConfig) void;
    pub const setColorConfig = gimp_color_button_set_color_config;

    /// Sets the `button` dialog's title.
    extern fn gimp_color_button_set_title(p_button: *ColorButton, p_title: [*:0]const u8) void;
    pub const setTitle = gimp_color_button_set_title;

    /// Sets the `button` to the given `type`. See also `gimpui.ColorArea.setType`.
    extern fn gimp_color_button_set_type(p_button: *ColorButton, p_type: gimpui.ColorAreaType) void;
    pub const setType = gimp_color_button_set_type;

    /// When set to `TRUE`, the `button` will emit the "color-changed"
    /// continuously while the color is changed in the color selection
    /// dialog.
    extern fn gimp_color_button_set_update(p_button: *ColorButton, p_continuous: c_int) void;
    pub const setUpdate = gimp_color_button_set_update;

    extern fn gimp_color_button_get_type() usize;
    pub const getGObjectType = gimp_color_button_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions and definitions for creating pluggable GIMP
/// display color correction modules.
pub const ColorDisplay = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gimp.ConfigInterface};
    pub const Class = gimpui.ColorDisplayClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {
        pub const changed = struct {
            pub fn call(p_class: anytype, p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ColorDisplay.Class, p_class).f_changed.?(gobject.ext.as(ColorDisplay, p_display));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ColorDisplay.Class, p_class).f_changed = @ptrCast(p_implementation);
            }
        };

        /// Creates a configuration widget for `display` which can be added to a
        /// container widget.
        pub const configure = struct {
            pub fn call(p_class: anytype, p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *gtk.Widget {
                return gobject.ext.as(ColorDisplay.Class, p_class).f_configure.?(gobject.ext.as(ColorDisplay, p_display));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *gtk.Widget) void {
                gobject.ext.as(ColorDisplay.Class, p_class).f_configure = @ptrCast(p_implementation);
            }
        };

        /// Converts all pixels in `area` of `buffer`.
        pub const convert_buffer = struct {
            pub fn call(p_class: anytype, p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: *gegl.Buffer, p_area: *gegl.Rectangle) void {
                return gobject.ext.as(ColorDisplay.Class, p_class).f_convert_buffer.?(gobject.ext.as(ColorDisplay, p_display), p_buffer, p_area);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_display: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: *gegl.Buffer, p_area: *gegl.Rectangle) callconv(.c) void) void {
                gobject.ext.as(ColorDisplay.Class, p_class).f_convert_buffer = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const color_config = struct {
            pub const name = "color-config";

            pub const Type = ?*gimp.ColorConfig;
        };

        pub const color_managed = struct {
            pub const name = "color-managed";

            pub const Type = ?*gimp.ColorManaged;
        };

        pub const enabled = struct {
            pub const name = "enabled";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorDisplay, p_instance))),
                    gobject.signalLookup("changed", ColorDisplay.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn gimp_color_display_changed(p_display: *ColorDisplay) void;
    pub const changed = gimp_color_display_changed;

    /// Creates a copy of `display`.
    extern fn gimp_color_display_clone(p_display: *ColorDisplay) *gimpui.ColorDisplay;
    pub const clone = gimp_color_display_clone;

    /// Creates a configuration widget for `display` which can be added to a
    /// container widget.
    extern fn gimp_color_display_configure(p_display: *ColorDisplay) *gtk.Widget;
    pub const configure = gimp_color_display_configure;

    extern fn gimp_color_display_configure_reset(p_display: *ColorDisplay) void;
    pub const configureReset = gimp_color_display_configure_reset;

    /// Converts all pixels in `area` of `buffer`.
    extern fn gimp_color_display_convert_buffer(p_display: *ColorDisplay, p_buffer: *gegl.Buffer, p_area: *gegl.Rectangle) void;
    pub const convertBuffer = gimp_color_display_convert_buffer;

    extern fn gimp_color_display_get_config(p_display: *ColorDisplay) *gimp.ColorConfig;
    pub const getConfig = gimp_color_display_get_config;

    extern fn gimp_color_display_get_enabled(p_display: *ColorDisplay) c_int;
    pub const getEnabled = gimp_color_display_get_enabled;

    extern fn gimp_color_display_get_managed(p_display: *ColorDisplay) *gimp.ColorManaged;
    pub const getManaged = gimp_color_display_get_managed;

    /// Configures `display` from the contents of the parasite `state`.
    /// `state` must be a properly serialized configuration for a
    /// `gimpui.ColorDisplay`, such as saved by `gimpui.ColorDisplay.saveState`.
    extern fn gimp_color_display_load_state(p_display: *ColorDisplay, p_state: *gimp.Parasite) void;
    pub const loadState = gimp_color_display_load_state;

    /// Saves the configuration state of `display` as a new parasite.
    extern fn gimp_color_display_save_state(p_display: *ColorDisplay) *gimp.Parasite;
    pub const saveState = gimp_color_display_save_state;

    extern fn gimp_color_display_set_enabled(p_display: *ColorDisplay, p_enabled: c_int) void;
    pub const setEnabled = gimp_color_display_set_enabled;

    extern fn gimp_color_display_get_type() usize;
    pub const getGObjectType = gimp_color_display_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorDisplay) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorDisplay) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorDisplay, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A stack of color correction modules.
pub const ColorDisplayStack = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimpui.ColorDisplayStackClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const added = struct {
            pub const name = "added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gimpui.ColorDisplay, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorDisplayStack, p_instance))),
                    gobject.signalLookup("added", ColorDisplayStack.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const changed = struct {
            pub const name = "changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorDisplayStack, p_instance))),
                    gobject.signalLookup("changed", ColorDisplayStack.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const removed = struct {
            pub const name = "removed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gimpui.ColorDisplay, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorDisplayStack, p_instance))),
                    gobject.signalLookup("removed", ColorDisplayStack.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const reordered = struct {
            pub const name = "reordered";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gimpui.ColorDisplay, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorDisplayStack, p_instance))),
                    gobject.signalLookup("reordered", ColorDisplayStack.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new stack of color correction modules.
    extern fn gimp_color_display_stack_new() *gimpui.ColorDisplayStack;
    pub const new = gimp_color_display_stack_new;

    /// Add the color module `display` to `stack`.
    extern fn gimp_color_display_stack_add(p_stack: *ColorDisplayStack, p_display: *gimpui.ColorDisplay) void;
    pub const add = gimp_color_display_stack_add;

    /// Emit the "changed" signal of `stack`.
    extern fn gimp_color_display_stack_changed(p_stack: *ColorDisplayStack) void;
    pub const changed = gimp_color_display_stack_changed;

    /// Creates a copy of `stack` with all its display color modules also
    /// duplicated.
    extern fn gimp_color_display_stack_clone(p_stack: *ColorDisplayStack) *gimpui.ColorDisplayStack;
    pub const clone = gimp_color_display_stack_clone;

    /// Runs all the stack's filters on all pixels in `area` of `buffer`.
    extern fn gimp_color_display_stack_convert_buffer(p_stack: *ColorDisplayStack, p_buffer: *gegl.Buffer, p_area: *gegl.Rectangle) void;
    pub const convertBuffer = gimp_color_display_stack_convert_buffer;

    /// Gets the list of added color modules.
    extern fn gimp_color_display_stack_get_filters(p_stack: *ColorDisplayStack) *glib.List;
    pub const getFilters = gimp_color_display_stack_get_filters;

    /// Remove the color module `display` from `stack`.
    extern fn gimp_color_display_stack_remove(p_stack: *ColorDisplayStack, p_display: *gimpui.ColorDisplay) void;
    pub const remove = gimp_color_display_stack_remove;

    /// Move the color module `display` down in the filter list of `stack`.
    extern fn gimp_color_display_stack_reorder_down(p_stack: *ColorDisplayStack, p_display: *gimpui.ColorDisplay) void;
    pub const reorderDown = gimp_color_display_stack_reorder_down;

    /// Move the color module `display` up in the filter list of `stack`.
    extern fn gimp_color_display_stack_reorder_up(p_stack: *ColorDisplayStack, p_display: *gimpui.ColorDisplay) void;
    pub const reorderUp = gimp_color_display_stack_reorder_up;

    extern fn gimp_color_display_stack_get_type() usize;
    pub const getGObjectType = gimp_color_display_stack_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorDisplayStack) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorDisplayStack) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorDisplayStack, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Widget for entering a color's hex triplet. The syntax follows CSS and
/// SVG specifications, which means that only sRGB colors are supported.
pub const ColorHexEntry = opaque {
    pub const Parent = gtk.Entry;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.Editable };
    pub const Class = gimpui.ColorHexEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const color_changed = struct {
            pub const name = "color-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorHexEntry, p_instance))),
                    gobject.signalLookup("color-changed", ColorHexEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn gimp_color_hex_entry_new() *gimpui.ColorHexEntry;
    pub const new = gimp_color_hex_entry_new;

    /// Retrieves the color value displayed by a `gimpui.ColorHexEntry`.
    extern fn gimp_color_hex_entry_get_color(p_entry: *ColorHexEntry) *gegl.Color;
    pub const getColor = gimp_color_hex_entry_get_color;

    /// Sets the color displayed by a `gimpui.ColorHexEntry`. If the new color
    /// is different to the previously set color, the "color-changed"
    /// signal is emitted.
    extern fn gimp_color_hex_entry_set_color(p_entry: *ColorHexEntry, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_hex_entry_set_color;

    extern fn gimp_color_hex_entry_get_type() usize;
    pub const getGObjectType = gimp_color_hex_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorHexEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorHexEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorHexEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `gimpui.ColorNotebook` widget is an implementation of a
/// `gimpui.ColorSelector`. It serves as a container for
/// `GimpColorSelectors`.
pub const ColorNotebook = opaque {
    pub const Parent = gimpui.ColorSelector;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ColorNotebookClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_color_notebook_enable_simulation(p_notebook: *ColorNotebook, p_enabled: c_int) void;
    pub const enableSimulation = gimp_color_notebook_enable_simulation;

    extern fn gimp_color_notebook_get_current_selector(p_notebook: *ColorNotebook) *gimpui.ColorSelector;
    pub const getCurrentSelector = gimp_color_notebook_get_current_selector;

    extern fn gimp_color_notebook_get_notebook(p_notebook: *ColorNotebook) *gtk.Notebook;
    pub const getNotebook = gimp_color_notebook_get_notebook;

    extern fn gimp_color_notebook_get_selectors(p_notebook: *ColorNotebook) *glib.List;
    pub const getSelectors = gimp_color_notebook_get_selectors;

    /// Updates all selectors with the current format.
    extern fn gimp_color_notebook_set_format(p_notebook: *ColorNotebook, p_format: *const babl.Object) void;
    pub const setFormat = gimp_color_notebook_set_format;

    /// This function adds and removed pages to / from a `gimpui.ColorNotebook`.
    /// The `page_type` passed must be a `gimpui.ColorSelector` subtype.
    extern fn gimp_color_notebook_set_has_page(p_notebook: *ColorNotebook, p_page_type: usize, p_has_page: c_int) *gtk.Widget;
    pub const setHasPage = gimp_color_notebook_set_has_page;

    /// Updates all selectors with the current simulation settings.
    extern fn gimp_color_notebook_set_simulation(p_notebook: *ColorNotebook, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) void;
    pub const setSimulation = gimp_color_notebook_set_simulation;

    extern fn gimp_color_notebook_get_type() usize;
    pub const getGObjectType = gimp_color_notebook_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorNotebook) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorNotebook) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorNotebook, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.FileChooser` subclass for selecting color profiles.
pub const ColorProfileChooserDialog = opaque {
    pub const Parent = gtk.FileChooserDialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.FileChooser };
    pub const Class = gimpui.ColorProfileChooserDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_color_profile_chooser_dialog_new(p_title: [*:0]const u8, p_parent: *gtk.Window, p_action: gtk.FileChooserAction) *gimpui.ColorProfileChooserDialog;
    pub const new = gimp_color_profile_chooser_dialog_new;

    extern fn gimp_color_profile_chooser_dialog_get_type() usize;
    pub const getGObjectType = gimp_color_profile_chooser_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorProfileChooserDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorProfileChooserDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorProfileChooserDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A combo box for selecting color profiles.
pub const ColorProfileComboBox = opaque {
    pub const Parent = gtk.ComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.ColorProfileComboBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `gtk.Dialog` to present when the user selects the
        /// "Select color profile from disk..." item.
        pub const dialog = struct {
            pub const name = "dialog";

            pub const Type = ?*gtk.Dialog;
        };

        /// Overrides the "model" property of the `gtk.ComboBox` class.
        /// `gimpui.ColorProfileComboBox` requires the model to be a
        /// `gimpui.ColorProfileStore`.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?*gimpui.ColorProfileStore;
        };
    };

    pub const signals = struct {};

    /// Create a combo-box widget for selecting color profiles. The combo-box
    /// is populated from the file specified as `history`. This filename is
    /// typically created using the following code snippet:
    /// <informalexample><programlisting>
    ///  gchar *history = gimp_personal_rc_file ("profilerc");
    /// </programlisting></informalexample>
    ///
    /// The recommended `dialog` type to use is a `gimpui.ColorProfileChooserDialog`.
    /// If a `gimpui.ColorProfileChooserDialog` is passed, `gimpui.ColorProfileComboBox`
    /// will take complete control over the dialog, which means connecting
    /// a GtkDialog::`response` callback by itself, and take care of destroying
    /// the dialog when the combo box is destroyed.
    ///
    /// If another type of `dialog` is passed, this has to be implemented
    /// separately.
    ///
    /// See also `gimpui.ColorProfileComboBox.newWithModel`.
    extern fn gimp_color_profile_combo_box_new(p_dialog: *gtk.Widget, p_history: *gio.File) *gimpui.ColorProfileComboBox;
    pub const new = gimp_color_profile_combo_box_new;

    /// This constructor is useful when you want to create several
    /// combo-boxes for profile selection that all share the same
    /// `gimpui.ColorProfileStore`. This is for example done in the
    /// GIMP Preferences dialog.
    ///
    /// See also `gimpui.ColorProfileComboBox.new`.
    extern fn gimp_color_profile_combo_box_new_with_model(p_dialog: *gtk.Widget, p_model: *gtk.TreeModel) *gimpui.ColorProfileComboBox;
    pub const newWithModel = gimp_color_profile_combo_box_new_with_model;

    /// This function delegates to the underlying
    /// `gimpui.ColorProfileStore`. Please refer to the documentation of
    /// `gimpui.ColorProfileStore.addFile` for details.
    extern fn gimp_color_profile_combo_box_add_file(p_combo: *ColorProfileComboBox, p_file: *gio.File, p_label: [*:0]const u8) void;
    pub const addFile = gimp_color_profile_combo_box_add_file;

    extern fn gimp_color_profile_combo_box_get_active_file(p_combo: *ColorProfileComboBox) *gio.File;
    pub const getActiveFile = gimp_color_profile_combo_box_get_active_file;

    /// Selects a color profile from the `combo` and makes it the active
    /// item.  If the profile is not listed in the `combo`, then it is added
    /// with the given `label` (or `file` in case that `label` is `NULL`).
    extern fn gimp_color_profile_combo_box_set_active_file(p_combo: *ColorProfileComboBox, p_file: *gio.File, p_label: [*:0]const u8) void;
    pub const setActiveFile = gimp_color_profile_combo_box_set_active_file;

    /// Selects a color profile from the `combo` and makes it the active
    /// item.
    extern fn gimp_color_profile_combo_box_set_active_profile(p_combo: *ColorProfileComboBox, p_profile: *gimp.ColorProfile) void;
    pub const setActiveProfile = gimp_color_profile_combo_box_set_active_profile;

    extern fn gimp_color_profile_combo_box_get_type() usize;
    pub const getGObjectType = gimp_color_profile_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorProfileComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorProfileComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorProfileComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ListStore` subclass that keep color profiles.
pub const ColorProfileStore = opaque {
    pub const Parent = gtk.ListStore;
    pub const Implements = [_]type{ gtk.Buildable, gtk.TreeDragDest, gtk.TreeDragSource, gtk.TreeModel, gtk.TreeSortable };
    pub const Class = gimpui.ColorProfileStoreClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// `gio.File` of the color history used to populate the profile store.
        pub const history = struct {
            pub const name = "history";

            pub const Type = ?*gio.File;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.ColorProfileStore` object and populates it with
    /// last used profiles read from the file `history`. The updated history
    /// is written back to disk when the store is disposed.
    ///
    /// The `gio.File` passed as `history` is typically created using the
    /// following code snippet:
    /// <informalexample><programlisting>
    ///  gchar *history = gimp_personal_rc_file ("profilerc");
    /// </programlisting></informalexample>
    extern fn gimp_color_profile_store_new(p_history: *gio.File) *gimpui.ColorProfileStore;
    pub const new = gimp_color_profile_store_new;

    /// Adds a color profile item to the `gimpui.ColorProfileStore`. Items
    /// added with this function will be kept at the top, separated from
    /// the history of last used color profiles.
    ///
    /// This function is often used to add a selectable item for the `NULL`
    /// file. If you pass `NULL` for both `file` and `label`, the `label` will
    /// be set to the string "None" for you (and translated for the user).
    extern fn gimp_color_profile_store_add_file(p_store: *ColorProfileStore, p_file: *gio.File, p_label: [*:0]const u8) void;
    pub const addFile = gimp_color_profile_store_add_file;

    extern fn gimp_color_profile_store_get_type() usize;
    pub const getGObjectType = gimp_color_profile_store_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorProfileStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorProfileStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorProfileStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget for viewing the properties of a `gimp.ColorProfile`.
pub const ColorProfileView = opaque {
    pub const Parent = gtk.TextView;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Scrollable };
    pub const Class = gimpui.ColorProfileViewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_color_profile_view_new() *gimpui.ColorProfileView;
    pub const new = gimp_color_profile_view_new;

    extern fn gimp_color_profile_view_set_error(p_view: *ColorProfileView, p_message: [*:0]const u8) void;
    pub const setError = gimp_color_profile_view_set_error;

    extern fn gimp_color_profile_view_set_profile(p_view: *ColorProfileView, p_profile: *gimp.ColorProfile) void;
    pub const setProfile = gimp_color_profile_view_set_profile;

    extern fn gimp_color_profile_view_get_type() usize;
    pub const getGObjectType = gimp_color_profile_view_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorProfileView) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorProfileView) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorProfileView, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Fancy colored sliders.
pub const ColorScale = opaque {
    pub const Parent = gtk.Scale;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ColorScaleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The channel which is edited by the color scale.
        pub const channel = struct {
            pub const name = "channel";

            pub const Type = gimpui.ColorSelectorChannel;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.ColorScale` widget.
    extern fn gimp_color_scale_new(p_orientation: gtk.Orientation, p_channel: gimpui.ColorSelectorChannel) *gimpui.ColorScale;
    pub const new = gimp_color_scale_new;

    /// Changes the color channel displayed by the `scale`.
    extern fn gimp_color_scale_set_channel(p_scale: *ColorScale, p_channel: gimpui.ColorSelectorChannel) void;
    pub const setChannel = gimp_color_scale_set_channel;

    /// Changes the color value of the `scale`.
    extern fn gimp_color_scale_set_color(p_scale: *ColorScale, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_scale_set_color;

    /// Sets the color management configuration to use with this color scale.
    extern fn gimp_color_scale_set_color_config(p_scale: *ColorScale, p_config: *gimp.ColorConfig) void;
    pub const setColorConfig = gimp_color_scale_set_color_config;

    /// Changes the color format displayed by the `scale`.
    extern fn gimp_color_scale_set_format(p_scale: *ColorScale, p_format: *const babl.Object) void;
    pub const setFormat = gimp_color_scale_set_format;

    extern fn gimp_color_scale_get_type() usize;
    pub const getGObjectType = gimp_color_scale_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorScale) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorScale) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorScale, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.ScaleEntry` showing a
/// `gimpui.ColorScale` instead of a `gtk.Scale`.
pub const ColorScaleEntry = opaque {
    pub const Parent = gimpui.ScaleEntry;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ColorScaleEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_color_scale_entry_new(p_text: [*:0]const u8, p_value: f64, p_lower: f64, p_upper: f64, p_digits: c_uint) *gimpui.ColorScaleEntry;
    pub const new = gimp_color_scale_entry_new;

    extern fn gimp_color_scale_entry_get_type() usize;
    pub const getGObjectType = gimp_color_scale_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorScaleEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorScaleEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorScaleEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Widget for doing a color selection.
pub const ColorSelection = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ColorSelectionClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const config = struct {
            pub const name = "config";

            pub const Type = ?*gimp.ColorConfig;
        };
    };

    pub const signals = struct {
        pub const color_changed = struct {
            pub const name = "color-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorSelection, p_instance))),
                    gobject.signalLookup("color-changed", ColorSelection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.ColorSelection` widget.
    extern fn gimp_color_selection_new() *gimpui.ColorSelection;
    pub const new = gimp_color_selection_new;

    /// Emits the "color-changed" signal.
    extern fn gimp_color_selection_color_changed(p_selection: *ColorSelection) void;
    pub const colorChanged = gimp_color_selection_color_changed;

    /// This function returns the `gimpui.ColorSelection`'s current color.
    extern fn gimp_color_selection_get_color(p_selection: *ColorSelection) *gegl.Color;
    pub const getColor = gimp_color_selection_get_color;

    extern fn gimp_color_selection_get_notebook(p_selection: *ColorSelection) *gtk.Widget;
    pub const getNotebook = gimp_color_selection_get_notebook;

    extern fn gimp_color_selection_get_old_color(p_selection: *ColorSelection) *gegl.Color;
    pub const getOldColor = gimp_color_selection_get_old_color;

    extern fn gimp_color_selection_get_right_vbox(p_selection: *ColorSelection) *gtk.Box;
    pub const getRightVbox = gimp_color_selection_get_right_vbox;

    /// Returns the `selection`'s `show_alpha` property.
    extern fn gimp_color_selection_get_show_alpha(p_selection: *ColorSelection) c_int;
    pub const getShowAlpha = gimp_color_selection_get_show_alpha;

    /// Sets the `gimpui.ColorSelection`'s current color to its old color.
    extern fn gimp_color_selection_reset(p_selection: *ColorSelection) void;
    pub const reset = gimp_color_selection_reset;

    /// Sets the `gimpui.ColorSelection`'s current color to the new `color`.
    extern fn gimp_color_selection_set_color(p_selection: *ColorSelection, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_selection_set_color;

    /// Sets the color management configuration to use with this color selection.
    extern fn gimp_color_selection_set_config(p_selection: *ColorSelection, p_config: *gimp.ColorConfig) void;
    pub const setConfig = gimp_color_selection_set_config;

    /// Updates all selectors with the current format.
    extern fn gimp_color_selection_set_format(p_selection: *ColorSelection, p_format: *const babl.Object) void;
    pub const setFormat = gimp_color_selection_set_format;

    /// Sets the `gimpui.ColorSelection`'s old color.
    extern fn gimp_color_selection_set_old_color(p_selection: *ColorSelection, p_color: *gegl.Color) void;
    pub const setOldColor = gimp_color_selection_set_old_color;

    /// Sets the `show_alpha` property of the `selection` widget.
    extern fn gimp_color_selection_set_show_alpha(p_selection: *ColorSelection, p_show_alpha: c_int) void;
    pub const setShowAlpha = gimp_color_selection_set_show_alpha;

    /// Sets the simulation options to use with this color selection.
    extern fn gimp_color_selection_set_simulation(p_selection: *ColorSelection, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) void;
    pub const setSimulation = gimp_color_selection_set_simulation;

    extern fn gimp_color_selection_get_type() usize;
    pub const getGObjectType = gimp_color_selection_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorSelection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorSelection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorSelection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Functions and definitions for creating pluggable GIMP color
/// selector modules.
pub const ColorSelector = extern struct {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ColorSelectorClass;
    f_parent_instance: gtk.Box,

    pub const virtual_methods = struct {
        pub const channel_changed = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_channel: gimpui.ColorSelectorChannel) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_channel_changed.?(gobject.ext.as(ColorSelector, p_selector), p_channel);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_channel: gimpui.ColorSelectorChannel) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_channel_changed = @ptrCast(p_implementation);
            }
        };

        pub const color_changed = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *gegl.Color) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_color_changed.?(gobject.ext.as(ColorSelector, p_selector), p_color);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *gegl.Color) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_color_changed = @ptrCast(p_implementation);
            }
        };

        pub const model_visible_changed = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_model: gimpui.ColorSelectorModel, p_visible: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_model_visible_changed.?(gobject.ext.as(ColorSelector, p_selector), p_model, p_visible);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_model: gimpui.ColorSelectorModel, p_visible: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_model_visible_changed = @ptrCast(p_implementation);
            }
        };

        /// Sets the `channel` property of the `selector` widget.
        ///
        /// Changes between displayed channels if this `selector` instance has
        /// the ability to show different channels.
        /// This will also update the color model if needed.
        pub const set_channel = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_channel: gimpui.ColorSelectorChannel) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_channel.?(gobject.ext.as(ColorSelector, p_selector), p_channel);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_channel: gimpui.ColorSelectorChannel) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_channel = @ptrCast(p_implementation);
            }
        };

        /// Sets the color shown in the `selector` widget.
        pub const set_color = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *gegl.Color) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_color.?(gobject.ext.as(ColorSelector, p_selector), p_color);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *gegl.Color) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_color = @ptrCast(p_implementation);
            }
        };

        /// Sets the color management configuration to use with this color selector.
        pub const set_config = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_config: *gimp.ColorConfig) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_config.?(gobject.ext.as(ColorSelector, p_selector), p_config);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_config: *gimp.ColorConfig) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_config = @ptrCast(p_implementation);
            }
        };

        /// Sets the babl format representing the color model and the space this
        /// `selector` is supposed to display values for. Depending on the type of color
        /// selector, it may trigger various UX changes, or none at all.
        pub const set_format = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_format: *const babl.Object) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_format.?(gobject.ext.as(ColorSelector, p_selector), p_format);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_format: *const babl.Object) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_format = @ptrCast(p_implementation);
            }
        };

        /// Sets the `model` visible/invisible on the `selector` widget.
        ///
        /// Toggles visibility of displayed models if this `selector` instance
        /// has the ability to show different color models.
        pub const set_model_visible = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_model: gimpui.ColorSelectorModel, p_visible: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_model_visible.?(gobject.ext.as(ColorSelector, p_selector), p_model, p_visible);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_model: gimpui.ColorSelectorModel, p_visible: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_model_visible = @ptrCast(p_implementation);
            }
        };

        /// Sets the `show_alpha` property of the `selector` widget.
        pub const set_show_alpha = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_show_alpha: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_show_alpha.?(gobject.ext.as(ColorSelector, p_selector), p_show_alpha);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_show_alpha: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_show_alpha = @ptrCast(p_implementation);
            }
        };

        /// Sets the simulation options to use with this color selector.
        pub const set_simulation = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_simulation.?(gobject.ext.as(ColorSelector, p_selector), p_profile, p_intent, p_bpc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_simulation = @ptrCast(p_implementation);
            }
        };

        /// Sets the `sensitive` property of the `selector`'s toggles.
        ///
        /// This function has no effect if this `selector` instance has no
        /// toggles to switch channels.
        pub const set_toggles_sensitive = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sensitive: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_toggles_sensitive.?(gobject.ext.as(ColorSelector, p_selector), p_sensitive);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_sensitive: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_toggles_sensitive = @ptrCast(p_implementation);
            }
        };

        /// Sets the `visible` property of the `selector`'s toggles.
        ///
        /// This function has no effect if this `selector` instance has no
        /// toggles to switch channels.
        pub const set_toggles_visible = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_visible: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_set_toggles_visible.?(gobject.ext.as(ColorSelector, p_selector), p_visible);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_visible: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_set_toggles_visible = @ptrCast(p_implementation);
            }
        };

        pub const simulation = struct {
            pub fn call(p_class: anytype, p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_enabled: c_int) void {
                return gobject.ext.as(ColorSelector.Class, p_class).f_simulation.?(gobject.ext.as(ColorSelector, p_selector), p_enabled);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selector: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_enabled: c_int) callconv(.c) void) void {
                gobject.ext.as(ColorSelector.Class, p_class).f_simulation = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        pub const channel_changed = struct {
            pub const name = "channel-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: gimpui.ColorSelectorChannel, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorSelector, p_instance))),
                    gobject.signalLookup("channel-changed", ColorSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const color_changed = struct {
            pub const name = "color-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gegl.Color, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorSelector, p_instance))),
                    gobject.signalLookup("color-changed", ColorSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const model_visible_changed = struct {
            pub const name = "model-visible-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: gimpui.ColorSelectorModel, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorSelector, p_instance))),
                    gobject.signalLookup("model-visible-changed", ColorSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const simulation = struct {
            pub const name = "simulation";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ColorSelector, p_instance))),
                    gobject.signalLookup("simulation", ColorSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.ColorSelector` widget of type `selector_type`.
    ///
    /// Note that this is mostly internal API to be used by other widgets.
    ///
    /// Please use `gimpui.ColorSelection.new` for the "GIMP-typical" color
    /// selection widget. Also see `gimpui.ColorButton.new`.
    extern fn gimp_color_selector_new(p_selector_type: usize, p_color: *gegl.Color, p_channel: gimpui.ColorSelectorChannel) *gimpui.ColorSelector;
    pub const new = gimp_color_selector_new;

    extern fn gimp_color_selector_enable_simulation(p_selector: *ColorSelector, p_enabled: c_int) c_int;
    pub const enableSimulation = gimp_color_selector_enable_simulation;

    /// Returns the `selector`'s current channel.
    extern fn gimp_color_selector_get_channel(p_selector: *ColorSelector) gimpui.ColorSelectorChannel;
    pub const getChannel = gimp_color_selector_get_channel;

    /// Retrieves the color shown in the `selector` widget.
    extern fn gimp_color_selector_get_color(p_selector: *ColorSelector) *gegl.Color;
    pub const getColor = gimp_color_selector_get_color;

    extern fn gimp_color_selector_get_model_visible(p_selector: *ColorSelector, p_model: gimpui.ColorSelectorModel) c_int;
    pub const getModelVisible = gimp_color_selector_get_model_visible;

    /// Returns the `selector`'s `show_alpha` property.
    extern fn gimp_color_selector_get_show_alpha(p_selector: *ColorSelector) c_int;
    pub const getShowAlpha = gimp_color_selector_get_show_alpha;

    extern fn gimp_color_selector_get_simulation(p_selector: *ColorSelector, p_profile: **gimp.ColorProfile, p_intent: *gimp.ColorRenderingIntent, p_bpc: *c_int) c_int;
    pub const getSimulation = gimp_color_selector_get_simulation;

    /// Returns the `sensitive` property of the `selector`'s toggles.
    extern fn gimp_color_selector_get_toggles_sensitive(p_selector: *ColorSelector) c_int;
    pub const getTogglesSensitive = gimp_color_selector_get_toggles_sensitive;

    /// Returns the `visible` property of the `selector`'s toggles.
    extern fn gimp_color_selector_get_toggles_visible(p_selector: *ColorSelector) c_int;
    pub const getTogglesVisible = gimp_color_selector_get_toggles_visible;

    /// Sets the `channel` property of the `selector` widget.
    ///
    /// Changes between displayed channels if this `selector` instance has
    /// the ability to show different channels.
    /// This will also update the color model if needed.
    extern fn gimp_color_selector_set_channel(p_selector: *ColorSelector, p_channel: gimpui.ColorSelectorChannel) void;
    pub const setChannel = gimp_color_selector_set_channel;

    /// Sets the color shown in the `selector` widget.
    extern fn gimp_color_selector_set_color(p_selector: *ColorSelector, p_color: *gegl.Color) void;
    pub const setColor = gimp_color_selector_set_color;

    /// Sets the color management configuration to use with this color selector.
    extern fn gimp_color_selector_set_config(p_selector: *ColorSelector, p_config: *gimp.ColorConfig) void;
    pub const setConfig = gimp_color_selector_set_config;

    /// Sets the babl format representing the color model and the space this
    /// `selector` is supposed to display values for. Depending on the type of color
    /// selector, it may trigger various UX changes, or none at all.
    extern fn gimp_color_selector_set_format(p_selector: *ColorSelector, p_format: *const babl.Object) void;
    pub const setFormat = gimp_color_selector_set_format;

    /// Sets the `model` visible/invisible on the `selector` widget.
    ///
    /// Toggles visibility of displayed models if this `selector` instance
    /// has the ability to show different color models.
    extern fn gimp_color_selector_set_model_visible(p_selector: *ColorSelector, p_model: gimpui.ColorSelectorModel, p_visible: c_int) void;
    pub const setModelVisible = gimp_color_selector_set_model_visible;

    /// Sets the `show_alpha` property of the `selector` widget.
    extern fn gimp_color_selector_set_show_alpha(p_selector: *ColorSelector, p_show_alpha: c_int) void;
    pub const setShowAlpha = gimp_color_selector_set_show_alpha;

    /// Sets the simulation options to use with this color selector.
    extern fn gimp_color_selector_set_simulation(p_selector: *ColorSelector, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) void;
    pub const setSimulation = gimp_color_selector_set_simulation;

    /// Sets the `sensitive` property of the `selector`'s toggles.
    ///
    /// This function has no effect if this `selector` instance has no
    /// toggles to switch channels.
    extern fn gimp_color_selector_set_toggles_sensitive(p_selector: *ColorSelector, p_sensitive: c_int) void;
    pub const setTogglesSensitive = gimp_color_selector_set_toggles_sensitive;

    /// Sets the `visible` property of the `selector`'s toggles.
    ///
    /// This function has no effect if this `selector` instance has no
    /// toggles to switch channels.
    extern fn gimp_color_selector_set_toggles_visible(p_selector: *ColorSelector, p_visible: c_int) void;
    pub const setTogglesVisible = gimp_color_selector_set_toggles_visible;

    extern fn gimp_color_selector_get_type() usize;
    pub const getGObjectType = gimp_color_selector_get_type;

    extern fn g_object_ref(p_self: *gimpui.ColorSelector) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ColorSelector) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ColorSelector, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Constructors for `gtk.Dialog`'s and action_areas as well as other
/// dialog-related stuff.
pub const Dialog = extern struct {
    pub const Parent = gtk.Dialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.DialogClass;
    f_parent_instance: gtk.Dialog,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const help_func = struct {
            pub const name = "help-func";

            pub const Type = ?*anyopaque;
        };

        pub const help_id = struct {
            pub const name = "help-id";

            pub const Type = ?[*:0]u8;
        };

        pub const parent = struct {
            pub const name = "parent";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {};

    /// Creates a new `GimpDialog` widget.
    ///
    /// This function simply packs the action_area arguments passed in "..."
    /// into a `va_list` variable and passes everything to `gimpui.Dialog.newValist`.
    ///
    /// For a description of the format of the `va_list` describing the
    /// action_area buttons see `gtk.Dialog.newWithButtons`.
    extern fn gimp_dialog_new(p_title: [*:0]const u8, p_role: [*:0]const u8, p_parent: ?*gtk.Widget, p_flags: gtk.DialogFlags, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, ...) *gimpui.Dialog;
    pub const new = gimp_dialog_new;

    /// Creates a new `GimpDialog` widget. If a GtkWindow is specified as
    /// `parent` then the dialog will be made transient for this window.
    ///
    /// For a description of the format of the `va_list` describing the
    /// action_area buttons see `gtk.Dialog.newWithButtons`.
    extern fn gimp_dialog_new_valist(p_title: [*:0]const u8, p_role: [*:0]const u8, p_parent: *gtk.Widget, p_flags: gtk.DialogFlags, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_args: std.builtin.VaList) *gimpui.Dialog;
    pub const newValist = gimp_dialog_new_valist;

    /// This function is essentially the same as `gtk.Dialog.addButton`
    /// except it ensures there is only one help button and automatically
    /// sets the RESPONSE_OK widget as the default response.
    extern fn gimp_dialog_add_button(p_dialog: *Dialog, p_button_text: [*:0]const u8, p_response_id: c_int) *gtk.Widget;
    pub const addButton = gimp_dialog_add_button;

    /// This function is essentially the same as `gtk.Dialog.addButtons`
    /// except it calls `gimpui.Dialog.addButton` instead of `gtk.Dialog.addButton`
    extern fn gimp_dialog_add_buttons(p_dialog: *Dialog, ...) void;
    pub const addButtons = gimp_dialog_add_buttons;

    /// This function is essentially the same as `gimpui.Dialog.addButtons`
    /// except it takes a va_list instead of '...'
    extern fn gimp_dialog_add_buttons_valist(p_dialog: *Dialog, p_args: std.builtin.VaList) void;
    pub const addButtonsValist = gimp_dialog_add_buttons_valist;

    /// Returns an opaque data handle representing the window in the currently
    /// running platform. You should not try to use this directly. Usually this is to
    /// be used in functions such as `gimp.brushesPopup` which will allow the
    /// core process to set this `Dialog` as parent to the newly created popup.
    extern fn gimp_dialog_get_native_handle(p_dialog: *Dialog) *glib.Bytes;
    pub const getNativeHandle = gimp_dialog_get_native_handle;

    /// This function does exactly the same as `gtk.Dialog.run` except it
    /// does not make the dialog modal while the `glib.MainLoop` is running.
    extern fn gimp_dialog_run(p_dialog: *Dialog) c_int;
    pub const run = gimp_dialog_run;

    /// Reorder `dialog`'s buttons if `gtk.Settings.properties.gtk_alternative_button_order`
    /// is set to TRUE. This is mostly a wrapper around the GTK function
    /// `gtk.Dialog.setAlternativeButtonOrder`, except it won't
    /// output a deprecation warning.
    extern fn gimp_dialog_set_alternative_button_order_from_array(p_dialog: *Dialog, p_n_buttons: c_int, p_order: [*]c_int) void;
    pub const setAlternativeButtonOrderFromArray = gimp_dialog_set_alternative_button_order_from_array;

    extern fn gimp_dialog_get_type() usize;
    pub const getGObjectType = gimp_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.Dialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Dialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Dialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The chooser contains an optional label and a button which queries the core
/// process to pop up a drawable selection dialog.
pub const DrawableChooser = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.DrawableChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently selected drawable.
        pub const drawable = struct {
            pub const name = "drawable";

            pub const Type = ?*gimp.Drawable;
        };

        /// Allowed drawable types, which must be either GIMP_TYPE_DRAWABLE or a
        /// subtype.
        pub const drawable_type = struct {
            pub const name = "drawable-type";

            pub const Type = usize;
        };

        /// Label text with mnemonic.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The title to be used for the drawable selection popup dialog.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a drawable which must be of
    /// type `drawable_type`. `drawable_type` of values `G_TYPE_NONE` and
    /// `GIMP_TYPE_DRAWABLE` are equivalent. Otherwise it must be a subtype of
    /// `GIMP_TYPE_DRAWABLE`.
    ///
    /// When `drawable` is `NULL`, initial choice is from context.
    extern fn gimp_drawable_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_drawable_type: usize, p_drawable: ?*gimp.Drawable) *gimpui.DrawableChooser;
    pub const new = gimp_drawable_chooser_new;

    /// Gets the currently selected drawable.
    extern fn gimp_drawable_chooser_get_drawable(p_chooser: *DrawableChooser) *gimp.Drawable;
    pub const getDrawable = gimp_drawable_chooser_get_drawable;

    /// Returns the label widget.
    extern fn gimp_drawable_chooser_get_label(p_widget: *DrawableChooser) *gtk.Widget;
    pub const getLabel = gimp_drawable_chooser_get_label;

    /// Sets the currently selected drawable.
    /// This will select the drawable in both the button and any chooser popup.
    extern fn gimp_drawable_chooser_set_drawable(p_chooser: *DrawableChooser, p_drawable: *gimp.Drawable) void;
    pub const setDrawable = gimp_drawable_chooser_set_drawable;

    extern fn gimp_drawable_chooser_get_type() usize;
    pub const getGObjectType = gimp_drawable_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.DrawableChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.DrawableChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawableChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawableComboBox = opaque {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = opaque {
        pub const Instance = DrawableComboBox;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.IntComboBox` filled with all currently opened
    /// drawables. If a `constraint` function is specified, it is called for
    /// each drawable and only if the function returns `TRUE`, the drawable
    /// is added to the combobox.
    ///
    /// You should use `gimpui.IntComboBox.connect` to initialize and connect
    /// the combo.  Use `gimpui.IntComboBox.setActive` to get the active
    /// drawable ID and `gimpui.IntComboBox.getActive` to retrieve the ID
    /// of the selected drawable.
    extern fn gimp_drawable_combo_box_new(p_constraint: ?gimpui.ItemConstraintFunc, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gimpui.DrawableComboBox;
    pub const new = gimp_drawable_combo_box_new;

    extern fn gimp_drawable_combo_box_get_type() usize;
    pub const getGObjectType = gimp_drawable_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.DrawableComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.DrawableComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawableComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a preview of a `gimp.Drawable`.
pub const DrawablePreview = opaque {
    pub const Parent = gimpui.ScrolledPreview;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.DrawablePreviewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const drawable = struct {
            pub const name = "drawable";

            pub const Type = ?*gimp.Drawable;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.DrawablePreview` widget for `drawable`.
    extern fn gimp_drawable_preview_new_from_drawable(p_drawable: *gimp.Drawable) *gimpui.DrawablePreview;
    pub const newFromDrawable = gimp_drawable_preview_new_from_drawable;

    extern fn gimp_drawable_preview_get_drawable(p_preview: *DrawablePreview) *gimp.Drawable;
    pub const getDrawable = gimp_drawable_preview_get_drawable;

    extern fn gimp_drawable_preview_get_type() usize;
    pub const getGObjectType = gimp_drawable_preview_get_type;

    extern fn g_object_ref(p_self: *gimpui.DrawablePreview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.DrawablePreview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *DrawablePreview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ComboBox` subclass for selecting an enum value.
pub const EnumComboBox = extern struct {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.EnumComboBoxClass;
    f_parent_instance: gimpui.IntComboBox,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?*gimpui.EnumStore;
        };
    };

    pub const signals = struct {};

    /// Creates a `gtk.ComboBox` readily filled with all enum values from a
    /// given `enum_type`. The enum needs to be registered to the type
    /// system. It should also have `gimp.EnumDesc` descriptions registered
    /// that contain translatable value names. This is the case for the
    /// enums used in the GIMP PDB functions.
    ///
    /// This is just a convenience function. If you need more control over
    /// the enum values that appear in the combo_box, you can create your
    /// own `gimpui.EnumStore` and use `gimpui.EnumComboBox.newWithModel`.
    extern fn gimp_enum_combo_box_new(p_enum_type: usize) *gimpui.EnumComboBox;
    pub const new = gimp_enum_combo_box_new;

    /// Creates a `gtk.ComboBox` for the given `enum_store`.
    extern fn gimp_enum_combo_box_new_with_model(p_enum_store: *gimpui.EnumStore) *gimpui.EnumComboBox;
    pub const newWithModel = gimp_enum_combo_box_new_with_model;

    /// Attempts to create icons for all items in the `combo_box`. See
    /// `gimpui.EnumStore.setIconPrefix` to find out what to use as
    /// `icon_prefix`.
    extern fn gimp_enum_combo_box_set_icon_prefix(p_combo_box: *EnumComboBox, p_icon_prefix: [*:0]const u8) void;
    pub const setIconPrefix = gimp_enum_combo_box_set_icon_prefix;

    extern fn gimp_enum_combo_box_get_type() usize;
    pub const getGObjectType = gimp_enum_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.EnumComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.EnumComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EnumComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.Label` subclass that displays an enum value.
pub const EnumLabel = opaque {
    pub const Parent = gtk.Label;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.EnumLabelClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `gobject.Type` of the enum.
        pub const enum_type = struct {
            pub const name = "enum-type";

            pub const Type = usize;
        };

        /// The value to display.
        pub const enum_value = struct {
            pub const name = "enum-value";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    extern fn gimp_enum_label_new(p_enum_type: usize, p_value: c_int) *gimpui.EnumLabel;
    pub const new = gimp_enum_label_new;

    extern fn gimp_enum_label_set_value(p_label: *EnumLabel, p_value: c_int) void;
    pub const setValue = gimp_enum_label_set_value;

    extern fn gimp_enum_label_get_type() usize;
    pub const getGObjectType = gimp_enum_label_get_type;

    extern fn g_object_ref(p_self: *gimpui.EnumLabel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.EnumLabel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EnumLabel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gimpui.IntStore` subclass that keeps enum values.
pub const EnumStore = opaque {
    pub const Parent = gimpui.IntStore;
    pub const Implements = [_]type{ gtk.Buildable, gtk.TreeDragDest, gtk.TreeDragSource, gtk.TreeModel, gtk.TreeSortable };
    pub const Class = gimpui.EnumStoreClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Sets the `gobject.Type` of the enum to be used in the store.
        pub const enum_type = struct {
            pub const name = "enum-type";

            pub const Type = usize;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.EnumStore`, derived from `gtk.ListStore` and fills
    /// it with enum values. The enum needs to be registered to the type
    /// system and should have translatable value names.
    extern fn gimp_enum_store_new(p_enum_type: usize) *gimpui.EnumStore;
    pub const new = gimp_enum_store_new;

    /// Creates a new `gimpui.EnumStore` like `gimpui.EnumStore.new` but allows
    /// to limit the enum values to a certain range. Values smaller than
    /// `minimum` or larger than `maximum` are not added to the store.
    extern fn gimp_enum_store_new_with_range(p_enum_type: usize, p_minimum: c_int, p_maximum: c_int) *gimpui.EnumStore;
    pub const newWithRange = gimp_enum_store_new_with_range;

    /// Creates a new `gimpui.EnumStore` like `gimpui.EnumStore.new` but allows
    /// to explicitly list the enum values that should be added to the
    /// store.
    extern fn gimp_enum_store_new_with_values(p_enum_type: usize, p_n_values: c_int, ...) *gimpui.EnumStore;
    pub const newWithValues = gimp_enum_store_new_with_values;

    /// See `gimpui.EnumStore.newWithValues`.
    extern fn gimp_enum_store_new_with_values_valist(p_enum_type: usize, p_n_values: c_int, p_args: std.builtin.VaList) *gimpui.EnumStore;
    pub const newWithValuesValist = gimp_enum_store_new_with_values_valist;

    /// Creates an icon name for each enum value in the `store` by appending
    /// the value's nick to the given `icon_prefix`, separated by a hyphen.
    ///
    /// See also: `gimpui.EnumComboBox.setIconPrefix`.
    extern fn gimp_enum_store_set_icon_prefix(p_store: *EnumStore, p_icon_prefix: [*:0]const u8) void;
    pub const setIconPrefix = gimp_enum_store_set_icon_prefix;

    extern fn gimp_enum_store_get_type() usize;
    pub const getGObjectType = gimp_enum_store_get_type;

    extern fn g_object_ref(p_self: *gimpui.EnumStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.EnumStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EnumStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExportProcedureDialog = opaque {
    pub const Parent = gimpui.ProcedureDialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.ExportProcedureDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_export_procedure_dialog_new(p_procedure: *gimp.ExportProcedure, p_config: *gimp.ProcedureConfig, p_image: *gimp.Image) *gimpui.ExportProcedureDialog;
    pub const new = gimp_export_procedure_dialog_new;

    extern fn gimp_export_procedure_dialog_add_metadata(p_dialog: *ExportProcedureDialog, p_property: [*:0]const u8) void;
    pub const addMetadata = gimp_export_procedure_dialog_add_metadata;

    extern fn gimp_export_procedure_dialog_get_type() usize;
    pub const getGObjectType = gimp_export_procedure_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.ExportProcedureDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ExportProcedureDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ExportProcedureDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The chooser contains an optional label and other interface allowing
/// to select files for different use cases.
pub const FileChooser = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.FileChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The action determining the chooser UI.
        pub const action = struct {
            pub const name = "action";

            pub const Type = gimp.FileChooserAction;
        };

        /// The currently selected file.
        pub const file = struct {
            pub const name = "file";

            pub const Type = ?*gio.File;
        };

        /// Label text with mnemonic.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The title to be used for the file selection popup dialog.
        /// If `NULL`, the "label" property is used instead.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a file according to
    /// `action`.
    ///
    /// `gimp.@"FileChooserAction.ANY"` is not a valid value for `action`.
    extern fn gimp_file_chooser_new(p_action: gimp.FileChooserAction, p_label: ?[*:0]const u8, p_title: ?[*:0]const u8, p_file: ?*gio.File) *gimpui.FileChooser;
    pub const new = gimp_file_chooser_new;

    /// Gets the current action.
    extern fn gimp_file_chooser_get_action(p_chooser: *FileChooser) gimp.FileChooserAction;
    pub const getAction = gimp_file_chooser_get_action;

    /// Gets the currently selected file.
    extern fn gimp_file_chooser_get_file(p_chooser: *FileChooser) *gio.File;
    pub const getFile = gimp_file_chooser_get_file;

    /// Gets the current label text. A `NULL` label means that the label
    /// widget is hidden.
    ///
    /// Note: the label text may contain a mnemonic.
    extern fn gimp_file_chooser_get_label(p_chooser: *FileChooser) ?[*:0]const u8;
    pub const getLabel = gimp_file_chooser_get_label;

    /// Returns the label widget. This can be useful for instance when
    /// aligning dialog's widgets with a `gtk.SizeGroup`.
    extern fn gimp_file_chooser_get_label_widget(p_chooser: *FileChooser) *gtk.Widget;
    pub const getLabelWidget = gimp_file_chooser_get_label_widget;

    /// Gets the text currently used for the file dialog's title and for
    /// entry's placeholder text.
    ///
    /// A `NULL` value means that the file dialog uses default title and the
    /// entry has no placeholder text.
    extern fn gimp_file_chooser_get_title(p_chooser: *FileChooser) ?[*:0]const u8;
    pub const getTitle = gimp_file_chooser_get_title;

    /// Changes how `chooser` is set to select a file. It may completely
    /// change the internal widget structure so you should not depend on a
    /// specific widget composition.
    ///
    /// Warning: with GTK deprecations, we may have soon to change the
    /// internal implementation. So this is all the more reason for you not
    /// to rely on specific child widgets being present (e.g.: we use
    /// currently `gtk.FileChooserButton` internally but it was removed
    /// in GTK4 so we will eventually replace it by custom code). We will
    /// also likely move to native file dialogs at some point.
    ///
    /// `gimp.@"FileChooserAction.ANY"` is not a valid value for `action`.
    extern fn gimp_file_chooser_set_action(p_chooser: *FileChooser, p_action: gimp.FileChooserAction) void;
    pub const setAction = gimp_file_chooser_set_action;

    /// Sets the currently selected file.
    extern fn gimp_file_chooser_set_file(p_chooser: *FileChooser, p_file: *gio.File) void;
    pub const setFile = gimp_file_chooser_set_file;

    /// Set the label text with mnemonic.
    ///
    /// Setting a `NULL` label text will hide the label widget.
    extern fn gimp_file_chooser_set_label(p_chooser: *FileChooser, p_text: ?[*:0]const u8) void;
    pub const setLabel = gimp_file_chooser_set_label;

    /// Set the text to be used for the file dialog's title and for entry's
    /// placeholder text.
    ///
    /// Setting a `NULL` title `text` will mean that the file dialog will use a
    /// generic title and there will be no placeholder text in the entry.
    extern fn gimp_file_chooser_set_title(p_chooser: *FileChooser, p_text: ?[*:0]const u8) void;
    pub const setTitle = gimp_file_chooser_set_title;

    extern fn gimp_file_chooser_get_type() usize;
    pub const getGObjectType = gimp_file_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.FileChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.FileChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FileChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a font selection dialog.
pub const FontChooser = opaque {
    pub const Parent = gimpui.ResourceChooser;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.FontChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a font.
    /// You can put this widget in a plug-in dialog.
    ///
    /// When font is NULL, initial choice is from context.
    extern fn gimp_font_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_font: ?*gimp.Font) *gimpui.FontChooser;
    pub const new = gimp_font_chooser_new;

    extern fn gimp_font_chooser_get_type() usize;
    pub const getGObjectType = gimp_font_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.FontChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.FontChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *FontChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a HIG-compliant subclass of `gtk.Frame`.
pub const Frame = extern struct {
    pub const Parent = gtk.Frame;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.FrameClass;
    f_parent_instance: gtk.Frame,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a `gimpui.Frame` widget. A `gimpui.Frame` is a HIG-compliant
    /// variant of `gtk.Frame`. It doesn't render a frame at all but
    /// otherwise behaves like a frame. The frame's title is rendered in
    /// bold and the frame content is indented four spaces as suggested by
    /// the GNOME HIG (see https://developer.gnome.org/hig/stable/).
    extern fn gimp_frame_new(p_label: ?[*:0]const u8) *gimpui.Frame;
    pub const new = gimp_frame_new;

    extern fn gimp_frame_get_type() usize;
    pub const getGObjectType = gimp_frame_get_type;

    extern fn g_object_ref(p_self: *gimpui.Frame) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Frame) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Frame, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a gradient select dialog.
pub const GradientChooser = opaque {
    pub const Parent = gimpui.ResourceChooser;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.GradientChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a gradient.
    /// You can use this widget in a table in a plug-in dialog.
    extern fn gimp_gradient_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_gradient: ?*gimp.Gradient) *gimpui.GradientChooser;
    pub const new = gimp_gradient_chooser_new;

    extern fn gimp_gradient_chooser_get_type() usize;
    pub const getGObjectType = gimp_gradient_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.GradientChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.GradientChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GradientChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Displays a wilber icon and a text.
pub const HintBox = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.HintBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const hint = struct {
            pub const name = "hint";

            pub const Type = ?[*:0]u8;
        };

        pub const icon_name = struct {
            pub const name = "icon-name";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Creates a new widget that shows a text label showing `hint`,
    /// decorated with a GIMP_ICON_INFO wilber icon.
    extern fn gimp_hint_box_new(p_hint: [*:0]const u8) *gimpui.HintBox;
    pub const new = gimp_hint_box_new;

    extern fn gimp_hint_box_get_type() usize;
    pub const getGObjectType = gimp_hint_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.HintBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.HintBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HintBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a popup menu of images.
pub const ImageComboBox = opaque {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.ImageComboBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.IntComboBox` filled with all currently opened
    /// images. If a `constraint` function is specified, it is called for
    /// each image and only if the function returns `TRUE`, the image is
    /// added to the combobox.
    ///
    /// You should use `gimpui.IntComboBox.connect` to initialize and
    /// connect the combo. Use `gimpui.IntComboBox.setActive` to get the
    /// active image ID and `gimpui.IntComboBox.getActive` to retrieve the
    /// ID of the selected image.
    extern fn gimp_image_combo_box_new(p_constraint: ?gimpui.ImageConstraintFunc, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gimpui.ImageComboBox;
    pub const new = gimp_image_combo_box_new;

    extern fn gimp_image_combo_box_get_type() usize;
    pub const getGObjectType = gimp_image_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.ImageComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ImageComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ImageComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a popup menu of integer values (e.g. enums).
pub const IntComboBox = extern struct {
    pub const Parent = gtk.ComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.IntComboBoxClass;
    f_parent_instance: gtk.ComboBox,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Specifies the preferred place to ellipsize text in the combo-box,
        /// if the cell renderer does not have enough room to display the
        /// entire string.
        pub const ellipsize = struct {
            pub const name = "ellipsize";

            pub const Type = pango.EllipsizeMode;
        };

        /// Sets a label on the combo-box, see `gimpui.IntComboBox.setLabel`.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// Specifies the combo box layout.
        pub const layout = struct {
            pub const name = "layout";

            pub const Type = gimpui.IntComboBoxLayout;
        };

        /// The active value (different from the "active" property of
        /// GtkComboBox which is the active index).
        pub const value = struct {
            pub const name = "value";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a GtkComboBox that has integer values associated with each
    /// item. The items to fill the combo box with are specified as a `NULL`
    /// terminated list of label/value pairs.
    ///
    /// If you need to construct an empty `gimpui.IntComboBox`, it's best to use
    /// g_object_new (GIMP_TYPE_INT_COMBO_BOX, NULL).
    extern fn gimp_int_combo_box_new(p_first_label: [*:0]const u8, p_first_value: c_int, ...) *gimpui.IntComboBox;
    pub const new = gimp_int_combo_box_new;

    /// A variant of `gimpui.IntComboBox.new` that takes an array of labels.
    /// The array indices are used as values.
    extern fn gimp_int_combo_box_new_array(p_n_values: c_int, p_labels: [*][*:0]const u8) *gimpui.IntComboBox;
    pub const newArray = gimp_int_combo_box_new_array;

    /// A variant of `gimpui.IntComboBox.new` that takes a va_list of
    /// label/value pairs.
    extern fn gimp_int_combo_box_new_valist(p_first_label: [*:0]const u8, p_first_value: c_int, p_values: std.builtin.VaList) *gimpui.IntComboBox;
    pub const newValist = gimp_int_combo_box_new_valist;

    /// This function provides a convenient way to append items to a
    /// `gimpui.IntComboBox`. It appends a row to the `combo_box`'s list store
    /// and calls `gtk.ListStore.set` for you.
    ///
    /// The column number must be taken from the enum `gimpui.IntStoreColumns`.
    extern fn gimp_int_combo_box_append(p_combo_box: *IntComboBox, ...) void;
    pub const append = gimp_int_combo_box_append;

    /// A convenience function that sets the initial `value` of a
    /// `gimpui.IntComboBox` and connects `callback` to the "changed"
    /// signal.
    ///
    /// This function also calls the `callback` once after setting the
    /// initial `value`. This is often convenient when working with combo
    /// boxes that select a default active item, like for example
    /// `gimpui.DrawableComboBox.new`. If you pass an invalid initial
    /// `value`, the `callback` will be called with the default item active.
    extern fn gimp_int_combo_box_connect(p_combo_box: *IntComboBox, p_value: c_int, p_callback: gobject.Callback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) c_ulong;
    pub const connect = gimp_int_combo_box_connect;

    /// Retrieves the value of the selected (active) item in the `combo_box`.
    extern fn gimp_int_combo_box_get_active(p_combo_box: *IntComboBox, p_value: *c_int) c_int;
    pub const getActive = gimp_int_combo_box_get_active;

    /// Retrieves the user-data of the selected (active) item in the `combo_box`.
    extern fn gimp_int_combo_box_get_active_user_data(p_combo_box: *IntComboBox, p_user_data: ?*anyopaque) c_int;
    pub const getActiveUserData = gimp_int_combo_box_get_active_user_data;

    /// Returns the label previously set with `gimpui.IntComboBox.setLabel`,
    /// or `NULL`,
    extern fn gimp_int_combo_box_get_label(p_combo_box: *IntComboBox) [*:0]const u8;
    pub const getLabel = gimp_int_combo_box_get_label;

    /// Returns the layout of `combo_box`
    extern fn gimp_int_combo_box_get_layout(p_combo_box: *IntComboBox) gimpui.IntComboBoxLayout;
    pub const getLayout = gimp_int_combo_box_get_layout;

    /// This function provides a convenient way to prepend items to a
    /// `gimpui.IntComboBox`. It prepends a row to the `combo_box`'s list store
    /// and calls `gtk.ListStore.set` for you.
    ///
    /// The column number must be taken from the enum `gimpui.IntStoreColumns`.
    extern fn gimp_int_combo_box_prepend(p_combo_box: *IntComboBox, ...) void;
    pub const prepend = gimp_int_combo_box_prepend;

    /// Looks up the item that belongs to the given `value` and makes it the
    /// selected item in the `combo_box`.
    extern fn gimp_int_combo_box_set_active(p_combo_box: *IntComboBox, p_value: c_int) c_int;
    pub const setActive = gimp_int_combo_box_set_active;

    /// Looks up the item that has the given `user_data` and makes it the
    /// selected item in the `combo_box`.
    extern fn gimp_int_combo_box_set_active_by_user_data(p_combo_box: *IntComboBox, p_user_data: ?*anyopaque) c_int;
    pub const setActiveByUserData = gimp_int_combo_box_set_active_by_user_data;

    /// Sets a caption on the `combo_box` that will be displayed
    /// left-aligned inside the box. When a label is set, the remaining
    /// contents of the box will be right-aligned. This is useful for
    /// places where screen estate is rare, like in tool options.
    extern fn gimp_int_combo_box_set_label(p_combo_box: *IntComboBox, p_label: [*:0]const u8) void;
    pub const setLabel = gimp_int_combo_box_set_label;

    /// Sets the layout of `combo_box` to `layout`.
    extern fn gimp_int_combo_box_set_layout(p_combo_box: *IntComboBox, p_layout: gimpui.IntComboBoxLayout) void;
    pub const setLayout = gimp_int_combo_box_set_layout;

    /// Sets a function that is used to decide about the sensitivity of
    /// rows in the `combo_box`. Use this if you want to set certain rows
    /// insensitive.
    ///
    /// Calling `gtk.Widget.queueDraw` on the `combo_box` will cause the
    /// sensitivity to be updated.
    extern fn gimp_int_combo_box_set_sensitivity(p_combo_box: *IntComboBox, p_func: gimpui.IntSensitivityFunc, p_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setSensitivity = gimp_int_combo_box_set_sensitivity;

    extern fn gimp_int_combo_box_get_type() usize;
    pub const getGObjectType = gimp_int_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.IntComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.IntComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IntComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a frame with title, containing grouped radio
/// buttons, each associated with an integer value and random user data.
pub const IntRadioFrame = opaque {
    pub const Parent = gimpui.Frame;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.IntRadioFrameClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The `gimpui.IntStore` from which the radio frame takes the values shown
        /// in the list.
        pub const store = struct {
            pub const name = "store";

            pub const Type = ?*gimpui.IntStore;
        };

        /// The active value
        pub const value = struct {
            pub const name = "value";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {};

    /// Creates a GtkComboBox that has integer values associated with each
    /// item. The items to fill the combo box with are specified as a `NULL`
    /// terminated list of label/value pairs.
    ///
    /// If you need to construct an empty `gimpui.IntRadioFrame`, it's best to use
    /// g_object_new (GIMP_TYPE_INT_RADIO_FRAME, NULL).
    extern fn gimp_int_radio_frame_new(p_first_label: [*:0]const u8, p_first_value: c_int, ...) *gimpui.IntRadioFrame;
    pub const new = gimp_int_radio_frame_new;

    /// A variant of `gimpui.IntRadioFrame.new` that takes an array of labels.
    /// The array indices are used as values.
    extern fn gimp_int_radio_frame_new_array(p_labels: [*][*:0]const u8) *gimpui.IntRadioFrame;
    pub const newArray = gimp_int_radio_frame_new_array;

    /// Creates a `gimpui.IntRadioFrame` containing radio buttons for each item
    /// in the `store`. The created widget takes ownership of `store`.
    ///
    /// If you need to construct an empty `gimpui.IntRadioFrame`, it's best to use
    /// g_object_new (GIMP_TYPE_INT_RADIO_FRAME, NULL).
    ///
    /// If you want to have a frame title with a mnemonic, set `title` to
    /// `NULL` instead and call `IntRadioFrame.setTitle` instead.
    extern fn gimp_int_radio_frame_new_from_store(p_title: [*:0]const u8, p_store: *gimpui.IntStore) *gimpui.IntRadioFrame;
    pub const newFromStore = gimp_int_radio_frame_new_from_store;

    /// A variant of `gimpui.IntRadioFrame.new` that takes a va_list of
    /// label/value pairs.
    extern fn gimp_int_radio_frame_new_valist(p_first_label: [*:0]const u8, p_first_value: c_int, p_values: std.builtin.VaList) *gimpui.IntRadioFrame;
    pub const newValist = gimp_int_radio_frame_new_valist;

    /// This function provides a convenient way to append items to a
    /// `gimpui.IntRadioFrame`. It appends a row to the `radio_frame`'s list store
    /// and calls `gtk.ListStore.set` for you.
    ///
    /// The column number must be taken from the enum `gimpui.IntStoreColumns`.
    extern fn gimp_int_radio_frame_append(p_radio_frame: *IntRadioFrame, ...) void;
    pub const append = gimp_int_radio_frame_append;

    extern fn gimp_int_radio_frame_get_active(p_radio_frame: *IntRadioFrame) c_int;
    pub const getActive = gimp_int_radio_frame_get_active;

    /// Retrieves the user-data of the selected (active) item in the `radio_frame`.
    extern fn gimp_int_radio_frame_get_active_user_data(p_radio_frame: *IntRadioFrame, p_user_data: ?*anyopaque) c_int;
    pub const getActiveUserData = gimp_int_radio_frame_get_active_user_data;

    /// This function provides a convenient way to prepend items to a
    /// `gimpui.IntRadioFrame`. It prepends a row to the `radio_frame`'s list store
    /// and calls `gtk.ListStore.set` for you.
    ///
    /// The column number must be taken from the enum `gimpui.IntStoreColumns`.
    extern fn gimp_int_radio_frame_prepend(p_radio_frame: *IntRadioFrame, ...) void;
    pub const prepend = gimp_int_radio_frame_prepend;

    /// Looks up the item that belongs to the given `value` and makes it the
    /// selected item in the `radio_frame`.
    extern fn gimp_int_radio_frame_set_active(p_radio_frame: *IntRadioFrame, p_value: c_int) c_int;
    pub const setActive = gimp_int_radio_frame_set_active;

    /// Looks up the item that has the given `user_data` and makes it the
    /// selected item in the `radio_frame`.
    extern fn gimp_int_radio_frame_set_active_by_user_data(p_radio_frame: *IntRadioFrame, p_user_data: ?*anyopaque) c_int;
    pub const setActiveByUserData = gimp_int_radio_frame_set_active_by_user_data;

    /// Sets a function that is used to decide about the sensitivity of radio
    /// buttons in the `radio_frame`. Use this if you want to set certain
    /// radio buttons insensitive.
    ///
    /// Calling `gtk.Widget.queueDraw` on the `radio_frame` will cause the
    /// sensitivity to be updated.
    extern fn gimp_int_radio_frame_set_sensitivity(p_radio_frame: *IntRadioFrame, p_func: gimpui.IntRadioFrameSensitivityFunc, p_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setSensitivity = gimp_int_radio_frame_set_sensitivity;

    /// Change the `frame`'s title, possibly with a mnemonic.
    extern fn gimp_int_radio_frame_set_title(p_frame: *IntRadioFrame, p_title: [*:0]const u8, p_with_mnemonic: c_int) void;
    pub const setTitle = gimp_int_radio_frame_set_title;

    extern fn gimp_int_radio_frame_get_type() usize;
    pub const getGObjectType = gimp_int_radio_frame_get_type;

    extern fn g_object_ref(p_self: *gimpui.IntRadioFrame) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.IntRadioFrame) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IntRadioFrame, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A model for integer based name-value pairs (e.g. enums)
pub const IntStore = extern struct {
    pub const Parent = gtk.ListStore;
    pub const Implements = [_]type{ gtk.Buildable, gtk.TreeDragDest, gtk.TreeDragSource, gtk.TreeModel, gtk.TreeSortable };
    pub const Class = gimpui.IntStoreClass;
    f_parent_instance: gtk.ListStore,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Sets the `gobject.Type` for the GIMP_INT_STORE_USER_DATA column.
        ///
        /// You need to set this property when constructing the store if you want
        /// to use the GIMP_INT_STORE_USER_DATA column and want to have the store
        /// handle ref-counting of your user data.
        pub const user_data_type = struct {
            pub const name = "user-data-type";

            pub const Type = usize;
        };
    };

    pub const signals = struct {};

    /// Iterate over the `model` looking for `user_data`.
    extern fn gimp_int_store_lookup_by_user_data(p_model: *gtk.TreeModel, p_user_data: ?*anyopaque, p_iter: *gtk.TreeIter) c_int;
    pub const lookupByUserData = gimp_int_store_lookup_by_user_data;

    /// Iterate over the `model` looking for `value`.
    extern fn gimp_int_store_lookup_by_value(p_model: *gtk.TreeModel, p_value: c_int, p_iter: *gtk.TreeIter) c_int;
    pub const lookupByValue = gimp_int_store_lookup_by_value;

    /// Creates a `gtk.ListStore` with a number of useful columns.
    /// `gimpui.IntStore` is especially useful if the items you want to store
    /// are identified using an integer value.
    ///
    /// If you need to construct an empty `gimpui.IntStore`, it's best to use
    /// g_object_new (GIMP_TYPE_INT_STORE, NULL).
    extern fn gimp_int_store_new(p_first_label: [*:0]const u8, p_first_value: c_int, ...) *gimpui.IntStore;
    pub const new = gimp_int_store_new;

    /// A variant of `gimpui.IntStore.new` that takes an array of labels.
    /// The array indices are used as values.
    extern fn gimp_int_store_new_array(p_n_values: c_int, p_labels: [*][*:0]const u8) *gimpui.IntStore;
    pub const newArray = gimp_int_store_new_array;

    /// A variant of `gimpui.IntStore.new` that takes a va_list of
    /// label/value pairs.
    extern fn gimp_int_store_new_valist(p_first_label: [*:0]const u8, p_first_value: c_int, p_values: std.builtin.VaList) *gimpui.IntStore;
    pub const newValist = gimp_int_store_new_valist;

    extern fn gimp_int_store_get_type() usize;
    pub const getGObjectType = gimp_int_store_get_type;

    extern fn g_object_ref(p_self: *gimpui.IntStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.IntStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *IntStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.Labeled` with a `GtkColor`.
pub const LabelColor = opaque {
    pub const Parent = gimpui.Labeled;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabelColorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Whether the color can be edited.
        pub const editable = struct {
            pub const name = "editable";

            pub const Type = c_int;
        };

        /// The currently set value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?*gegl.Color;
        };
    };

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LabelColor, p_instance))),
                    gobject.signalLookup("value-changed", LabelColor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a `gimpui.LabelColor` which contains a widget and displays a
    /// color area. By default, the color area is of type
    /// `GIMP_COLOR_AREA_SMALL_CHECKS`, which means transparency of `color`
    /// will be shown.
    ///
    /// Moreover in the non-editable case, the color is draggable to other
    /// widgets accepting color drops with buttons 1 and 2.
    /// In the editable case, the `label` is reused as the color chooser's
    /// dialog title.
    ///
    /// If you wish to customize any of these default behaviors, get the
    /// `gimpui.ColorArea` or `gimpui.ColorButton` with `gimpui.LabelColor.getColorWidget`.
    extern fn gimp_label_color_new(p_label: [*:0]const u8, p_color: *gegl.Color, p_editable: c_int) *gimpui.LabelColor;
    pub const new = gimp_label_color_new;

    /// This function returns the color widget packed in `color`, which can be
    /// either a `gimpui.ColorButton` (if the `color` is editable) or a
    /// `gimpui.ColorArea` otherwise.
    extern fn gimp_label_color_get_color_widget(p_color: *LabelColor) *gtk.Widget;
    pub const getColorWidget = gimp_label_color_get_color_widget;

    /// This function returns the value shown by `color`.
    extern fn gimp_label_color_get_value(p_color: *LabelColor) *gegl.Color;
    pub const getValue = gimp_label_color_get_value;

    /// This function tells whether the color widget allows to edit the
    /// color.
    extern fn gimp_label_color_is_editable(p_color: *LabelColor) c_int;
    pub const isEditable = gimp_label_color_is_editable;

    /// Changes the editability of the color.
    extern fn gimp_label_color_set_editable(p_color: *LabelColor, p_editable: c_int) void;
    pub const setEditable = gimp_label_color_set_editable;

    /// This function sets the value in the `GtkColor` inside `color`.
    extern fn gimp_label_color_set_value(p_color: *LabelColor, p_value: *gegl.Color) void;
    pub const setValue = gimp_label_color_set_value;

    extern fn gimp_label_color_get_type() usize;
    pub const getGObjectType = gimp_label_color_get_type;

    extern fn g_object_ref(p_self: *gimpui.LabelColor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LabelColor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LabelColor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.Labeled` with a `gtk.Entry`.
pub const LabelEntry = opaque {
    pub const Parent = gimpui.Labeled;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabelEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently set value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LabelEntry, p_instance))),
                    gobject.signalLookup("value-changed", LabelEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn gimp_label_entry_new(p_label: [*:0]const u8) *gimpui.LabelEntry;
    pub const new = gimp_label_entry_new;

    /// This function returns the `gtk.Entry` packed in `entry`.
    extern fn gimp_label_entry_get_entry(p_entry: *LabelEntry) *gtk.Widget;
    pub const getEntry = gimp_label_entry_get_entry;

    /// This function returns the value shown by `entry`.
    extern fn gimp_label_entry_get_value(p_entry: *LabelEntry) [*:0]const u8;
    pub const getValue = gimp_label_entry_get_value;

    /// This function sets the value in the `gtk.Entry` inside `entry`.
    extern fn gimp_label_entry_set_value(p_entry: *LabelEntry, p_value: [*:0]const u8) void;
    pub const setValue = gimp_label_entry_set_value;

    extern fn gimp_label_entry_get_type() usize;
    pub const getGObjectType = gimp_label_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.LabelEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LabelEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LabelEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.Labeled`.
pub const LabelIntWidget = opaque {
    pub const Parent = gimpui.Labeled;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabelIntWidgetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently set value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = c_int;
        };

        /// The widget holding an integer value.
        pub const widget = struct {
            pub const name = "widget";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LabelIntWidget, p_instance))),
                    gobject.signalLookup("value-changed", LabelIntWidget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.LabelIntWidget` whose "value" property is bound to
    /// that of `widget` (which must therefore have such an integer property).
    extern fn gimp_label_int_widget_new(p_text: [*:0]const u8, p_widget: *gtk.Widget) *gimpui.LabelIntWidget;
    pub const new = gimp_label_int_widget_new;

    extern fn gimp_label_int_widget_get_widget(p_widget: *LabelIntWidget) *gtk.Widget;
    pub const getWidget = gimp_label_int_widget_get_widget;

    extern fn gimp_label_int_widget_get_type() usize;
    pub const getGObjectType = gimp_label_int_widget_get_type;

    extern fn g_object_ref(p_self: *gimpui.LabelIntWidget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LabelIntWidget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LabelIntWidget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.Labeled` with a `gimpui.SpinButton`.
pub const LabelSpin = extern struct {
    pub const Parent = gimpui.Labeled;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabelSpinClass;
    f_parent_instance: gimpui.Labeled,

    pub const virtual_methods = struct {
        pub const value_changed = struct {
            pub fn call(p_class: anytype, p_spin: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(LabelSpin.Class, p_class).f_value_changed.?(gobject.ext.as(LabelSpin, p_spin));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_spin: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(LabelSpin.Class, p_class).f_value_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// The number of decimal places to display. If -1, then the number is
        /// estimated.
        pub const digits = struct {
            pub const name = "digits";

            pub const Type = c_int;
        };

        /// The lower bound of the spin button.
        pub const lower = struct {
            pub const name = "lower";

            pub const Type = f64;
        };

        /// The upper bound of the spin button.
        pub const upper = struct {
            pub const name = "upper";

            pub const Type = f64;
        };

        /// The currently set value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = f64;
        };
    };

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LabelSpin, p_instance))),
                    gobject.signalLookup("value-changed", LabelSpin.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Suitable increment values are estimated based on the [`lower`, `upper`]
    /// range.
    /// If `digits` is -1, then it will also be estimated based on the same
    /// range. Digits estimation will always be at least 1, so if you want to
    /// show integer values only, set 0 explicitly.
    extern fn gimp_label_spin_new(p_text: [*:0]const u8, p_value: f64, p_lower: f64, p_upper: f64, p_digits: c_int) *gimpui.LabelSpin;
    pub const new = gimp_label_spin_new;

    /// This function returns the `gimpui.SpinButton` packed in `spin`.
    extern fn gimp_label_spin_get_spin_button(p_spin: *LabelSpin) *gtk.Widget;
    pub const getSpinButton = gimp_label_spin_get_spin_button;

    /// This function returns the value shown by `spin`.
    extern fn gimp_label_spin_get_value(p_spin: *LabelSpin) f64;
    pub const getValue = gimp_label_spin_get_value;

    /// Set the number of decimal place to display in the `spin`'s entry.
    /// If `digits` is -1, then it will also be estimated based on `spin`'s
    /// range. Digits estimation will always be at least 1, so if you want to
    /// show integer values only, set 0 explicitly.
    extern fn gimp_label_spin_set_digits(p_spin: *LabelSpin, p_digits: c_int) void;
    pub const setDigits = gimp_label_spin_set_digits;

    /// Set the step and page increments of the spin button.
    /// By default, these increment values are automatically computed
    /// depending on the range based on common usage. So you will likely not
    /// need to run this for most case. Yet if you want specific increments
    /// (which the widget cannot guess), you can call this function.
    extern fn gimp_label_spin_set_increments(p_spin: *LabelSpin, p_step: f64, p_page: f64) void;
    pub const setIncrements = gimp_label_spin_set_increments;

    /// This function sets the value shown by `spin`.
    extern fn gimp_label_spin_set_value(p_spin: *LabelSpin, p_value: f64) void;
    pub const setValue = gimp_label_spin_set_value;

    extern fn gimp_label_spin_get_type() usize;
    pub const getGObjectType = gimp_label_spin_get_type;

    extern fn g_object_ref(p_self: *gimpui.LabelSpin) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LabelSpin) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LabelSpin, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a subclass of `gimpui.Labeled`.
pub const LabelStringWidget = opaque {
    pub const Parent = gimpui.Labeled;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabelStringWidgetClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The currently set value.
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?[*:0]u8;
        };

        /// The widget holding a string property named "value".
        pub const widget = struct {
            pub const name = "widget";

            pub const Type = ?*gtk.Widget;
        };
    };

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(LabelStringWidget, p_instance))),
                    gobject.signalLookup("value-changed", LabelStringWidget.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.LabelStringWidget` whose "value" property is bound to
    /// that of `widget` (which must therefore have such a string property).
    extern fn gimp_label_string_widget_new(p_text: [*:0]const u8, p_widget: *gtk.Widget) *gimpui.LabelStringWidget;
    pub const new = gimp_label_string_widget_new;

    extern fn gimp_label_string_widget_get_widget(p_widget: *LabelStringWidget) *gtk.Widget;
    pub const getWidget = gimp_label_string_widget_get_widget;

    extern fn gimp_label_string_widget_get_type() usize;
    pub const getGObjectType = gimp_label_string_widget_get_type;

    extern fn g_object_ref(p_self: *gimpui.LabelStringWidget) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LabelStringWidget) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LabelStringWidget, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a `gtk.Grid` showing a `gtk.Label` used as mnemonic on
/// another widget.
pub const Labeled = extern struct {
    pub const Parent = gtk.Grid;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.LabeledClass;
    f_parent_instance: gtk.Grid,

    pub const virtual_methods = struct {
        pub const mnemonic_widget_changed = struct {
            pub fn call(p_class: anytype, p_labeled: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *gtk.Widget) void {
                return gobject.ext.as(Labeled.Class, p_class).f_mnemonic_widget_changed.?(gobject.ext.as(Labeled, p_labeled), p_widget);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_labeled: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_widget: *gtk.Widget) callconv(.c) void) void {
                gobject.ext.as(Labeled.Class, p_class).f_mnemonic_widget_changed = @ptrCast(p_implementation);
            }
        };

        pub const populate = struct {
            pub fn call(p_class: anytype, p_labeled: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: *c_int, p_y: *c_int, p_width: *c_int, p_height: *c_int) *gtk.Widget {
                return gobject.ext.as(Labeled.Class, p_class).f_populate.?(gobject.ext.as(Labeled, p_labeled), p_x, p_y, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_labeled: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: *c_int, p_y: *c_int, p_width: *c_int, p_height: *c_int) callconv(.c) *gtk.Widget) void {
                gobject.ext.as(Labeled.Class, p_class).f_populate = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Label text with pango markup and mnemonic.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        pub const mnemonic_widget_changed = struct {
            pub const name = "mnemonic-widget-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: *gtk.Widget, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Labeled, p_instance))),
                    gobject.signalLookup("mnemonic-widget-changed", Labeled.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// This function returns the `gtk.Label` packed in `labeled`. This can be
    /// useful if you need to customize some aspects of the widget.
    extern fn gimp_labeled_get_label(p_labeled: *Labeled) *gtk.Label;
    pub const getLabel = gimp_labeled_get_label;

    /// This function will return exactly what you entered with
    /// `gimpui.Labeled.setText` or through the "label" property because this
    /// class expects labels to have mnemonics (and allows Pango formatting).
    /// To obtain instead the text as displayed with mnemonics and markup
    /// removed, call:
    /// ```
    /// gtk_label_get_text (GTK_LABEL (gimp_labeled_get_label (`labeled`)));
    /// ```
    extern fn gimp_labeled_get_text(p_labeled: *Labeled) [*:0]const u8;
    pub const getText = gimp_labeled_get_text;

    /// This is the equivalent of running
    /// `gtk.Label.setMarkupWithMnemonic` on the `gtk.Label` as a
    /// `gimpui.Labeled` expects a mnemonic. Pango markup are also allowed.
    extern fn gimp_labeled_set_text(p_labeled: *Labeled, p_text: [*:0]const u8) void;
    pub const setText = gimp_labeled_set_text;

    extern fn gimp_labeled_get_type() usize;
    pub const getGObjectType = gimp_labeled_get_type;

    extern fn g_object_ref(p_self: *gimpui.Labeled) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Labeled) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Labeled, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LayerComboBox = opaque {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = opaque {
        pub const Instance = LayerComboBox;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.IntComboBox` filled with all currently opened
    /// layers. See `gimpui.DrawableComboBox.new` for more information.
    extern fn gimp_layer_combo_box_new(p_constraint: ?gimpui.ItemConstraintFunc, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gimpui.LayerComboBox;
    pub const new = gimp_layer_combo_box_new;

    extern fn gimp_layer_combo_box_get_type() usize;
    pub const getGObjectType = gimp_layer_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.LayerComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.LayerComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *LayerComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Similar to a `gimpui.SizeEntry` but instead of lengths, this widget is
/// used to let the user enter memory sizes. A combo box allows one to
/// switch between Kilobytes, Megabytes and Gigabytes. Used in the GIMP
/// preferences dialog.
pub const MemsizeEntry = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.MemsizeEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(MemsizeEntry, p_instance))),
                    gobject.signalLookup("value-changed", MemsizeEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.MemsizeEntry` which is a `gtk.HBox` with a `gtk.SpinButton`
    /// and a `GtkOptionMenu` all setup to allow the user to enter memory sizes.
    extern fn gimp_memsize_entry_new(p_value: u64, p_lower: u64, p_upper: u64) *gimpui.MemsizeEntry;
    pub const new = gimp_memsize_entry_new;

    extern fn gimp_memsize_entry_get_spinbutton(p_entry: *MemsizeEntry) *gtk.SpinButton;
    pub const getSpinbutton = gimp_memsize_entry_get_spinbutton;

    /// Retrieves the current value from a `gimpui.MemsizeEntry`.
    extern fn gimp_memsize_entry_get_value(p_entry: *MemsizeEntry) u64;
    pub const getValue = gimp_memsize_entry_get_value;

    /// Sets the `entry`'s value. Please note that the `gimpui.MemsizeEntry` rounds
    /// the value to full Kilobytes.
    extern fn gimp_memsize_entry_set_value(p_entry: *MemsizeEntry, p_value: u64) void;
    pub const setValue = gimp_memsize_entry_set_value;

    extern fn gimp_memsize_entry_get_type() usize;
    pub const getGObjectType = gimp_memsize_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.MemsizeEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.MemsizeEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *MemsizeEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.Entry` subclass to enter ratios.
pub const NumberPairEntry = opaque {
    pub const Parent = gtk.Entry;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.Editable };
    pub const Class = gimpui.NumberPairEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const allow_simplification = struct {
            pub const name = "allow-simplification";

            pub const Type = c_int;
        };

        pub const aspect = struct {
            pub const name = "aspect";

            pub const Type = gimpui.AspectType;
        };

        pub const default_left_number = struct {
            pub const name = "default-left-number";

            pub const Type = f64;
        };

        pub const default_right_number = struct {
            pub const name = "default-right-number";

            pub const Type = f64;
        };

        pub const default_text = struct {
            pub const name = "default-text";

            pub const Type = ?[*:0]u8;
        };

        pub const left_number = struct {
            pub const name = "left-number";

            pub const Type = f64;
        };

        pub const max_valid_value = struct {
            pub const name = "max-valid-value";

            pub const Type = f64;
        };

        pub const min_valid_value = struct {
            pub const name = "min-valid-value";

            pub const Type = f64;
        };

        pub const ratio = struct {
            pub const name = "ratio";

            pub const Type = f64;
        };

        pub const right_number = struct {
            pub const name = "right-number";

            pub const Type = f64;
        };

        pub const separators = struct {
            pub const name = "separators";

            pub const Type = ?[*:0]u8;
        };

        pub const user_override = struct {
            pub const name = "user-override";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const numbers_changed = struct {
            pub const name = "numbers-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NumberPairEntry, p_instance))),
                    gobject.signalLookup("numbers-changed", NumberPairEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const ratio_changed = struct {
            pub const name = "ratio-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(NumberPairEntry, p_instance))),
                    gobject.signalLookup("ratio-changed", NumberPairEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.NumberPairEntry` widget, which is a GtkEntry that
    /// accepts two numbers separated by a separator. Typical input example
    /// with a 'x' separator: "377x233".
    ///
    /// The widget supports simplification of the entered ratio when the
    /// input ends in '=', if "allow-simplification" is TRUE.
    ///
    /// The "separators" property contains a string of characters valid as
    /// separators when parsing input. The first separator is used when
    /// displaying the current values.
    ///
    /// It is possible to specify what range of values that shall be
    /// considered as valid when parsing user input, by changing
    /// "min-valid-value" and "max-valid-value".
    ///
    /// The first separator of `separators` is used to display the current
    /// value.
    extern fn gimp_number_pair_entry_new(p_separators: [*:0]const u8, p_allow_simplification: c_int, p_min_valid_value: f64, p_max_valid_value: f64) *gimpui.NumberPairEntry;
    pub const new = gimp_number_pair_entry_new;

    /// Gets the aspect of the ratio displayed by a `gimpui.NumberPairEntry`.
    extern fn gimp_number_pair_entry_get_aspect(p_entry: *NumberPairEntry) gimpui.AspectType;
    pub const getAspect = gimp_number_pair_entry_get_aspect;

    extern fn gimp_number_pair_entry_get_default_text(p_entry: *NumberPairEntry) ?[*:0]const u8;
    pub const getDefaultText = gimp_number_pair_entry_get_default_text;

    extern fn gimp_number_pair_entry_get_default_values(p_entry: *NumberPairEntry, p_left: ?*f64, p_right: ?*f64) void;
    pub const getDefaultValues = gimp_number_pair_entry_get_default_values;

    /// Retrieves the ratio of the numbers displayed by a `gimpui.NumberPairEntry`.
    extern fn gimp_number_pair_entry_get_ratio(p_entry: *NumberPairEntry) f64;
    pub const getRatio = gimp_number_pair_entry_get_ratio;

    extern fn gimp_number_pair_entry_get_user_override(p_entry: *NumberPairEntry) c_int;
    pub const getUserOverride = gimp_number_pair_entry_get_user_override;

    /// Gets the numbers displayed by a `gimpui.NumberPairEntry`.
    extern fn gimp_number_pair_entry_get_values(p_entry: *NumberPairEntry, p_left: ?*f64, p_right: ?*f64) void;
    pub const getValues = gimp_number_pair_entry_get_values;

    /// Sets the aspect of the ratio by swapping the left_number and
    /// right_number if necessary (or setting them to 1.0 in case that
    /// `aspect` is `GIMP_ASPECT_SQUARE`).
    extern fn gimp_number_pair_entry_set_aspect(p_entry: *NumberPairEntry, p_aspect: gimpui.AspectType) void;
    pub const setAspect = gimp_number_pair_entry_set_aspect;

    /// Causes the entry to show a given string when in automatic mode,
    /// instead of the default numbers. The only thing this does is making
    /// the `gimpui.NumberPairEntry` showing this string, the internal state
    /// and API calls are not affected.
    ///
    /// Set the default string to `NULL` to display default values as
    /// normal.
    extern fn gimp_number_pair_entry_set_default_text(p_entry: *NumberPairEntry, p_string: [*:0]const u8) void;
    pub const setDefaultText = gimp_number_pair_entry_set_default_text;

    extern fn gimp_number_pair_entry_set_default_values(p_entry: *NumberPairEntry, p_left: f64, p_right: f64) void;
    pub const setDefaultValues = gimp_number_pair_entry_set_default_values;

    /// Sets the numbers of the `gimpui.NumberPairEntry` to have the desired
    /// ratio. If the new ratio is different than the previous ratio, the
    /// "ratio-changed" signal is emitted.
    ///
    /// An attempt is made to convert the decimal number into a fraction
    /// with left_number and right_number < 1000.
    extern fn gimp_number_pair_entry_set_ratio(p_entry: *NumberPairEntry, p_ratio: f64) void;
    pub const setRatio = gimp_number_pair_entry_set_ratio;

    /// When the entry is not in user overridden mode, the values will
    /// change when the default values are changed. When in user overridden
    /// mode, setting default values will not affect the active values.
    extern fn gimp_number_pair_entry_set_user_override(p_entry: *NumberPairEntry, p_user_override: c_int) void;
    pub const setUserOverride = gimp_number_pair_entry_set_user_override;

    /// Forces setting the numbers displayed by a `gimpui.NumberPairEntry`,
    /// ignoring if the user has set their own value. The state of
    /// user-override will not be changed.
    extern fn gimp_number_pair_entry_set_values(p_entry: *NumberPairEntry, p_left: f64, p_right: f64) void;
    pub const setValues = gimp_number_pair_entry_set_values;

    extern fn gimp_number_pair_entry_get_type() usize;
    pub const getGObjectType = gimp_number_pair_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.NumberPairEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.NumberPairEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NumberPairEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Widget to control image offsets.
pub const OffsetArea = opaque {
    pub const Parent = gtk.DrawingArea;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.OffsetAreaClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const offsets_changed = struct {
            pub const name = "offsets-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_object: c_int, p_p0: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(OffsetArea, p_instance))),
                    gobject.signalLookup("offsets-changed", OffsetArea.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.OffsetArea` widget. A `gimpui.OffsetArea` can be used
    /// when resizing an image or a drawable to allow the user to interactively
    /// specify the new offsets.
    extern fn gimp_offset_area_new(p_orig_width: c_int, p_orig_height: c_int) *gimpui.OffsetArea;
    pub const new = gimp_offset_area_new;

    /// Sets the offsets of the image/drawable displayed by the `gimpui.OffsetArea`.
    /// It does not emit the "offsets-changed" signal.
    extern fn gimp_offset_area_set_offsets(p_offset_area: *OffsetArea, p_offset_x: c_int, p_offset_y: c_int) void;
    pub const setOffsets = gimp_offset_area_set_offsets;

    /// Sets the pixbuf which represents the original image/drawable which
    /// is being offset.
    extern fn gimp_offset_area_set_pixbuf(p_offset_area: *OffsetArea, p_pixbuf: *gdkpixbuf.Pixbuf) void;
    pub const setPixbuf = gimp_offset_area_set_pixbuf;

    /// Sets the size of the image/drawable displayed by the `gimpui.OffsetArea`.
    /// If the offsets change as a result of this change, the "offsets-changed"
    /// signal is emitted.
    extern fn gimp_offset_area_set_size(p_offset_area: *OffsetArea, p_width: c_int, p_height: c_int) void;
    pub const setSize = gimp_offset_area_set_size;

    extern fn gimp_offset_area_get_type() usize;
    pub const getGObjectType = gimp_offset_area_get_type;

    extern fn g_object_ref(p_self: *gimpui.OffsetArea) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.OffsetArea) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *OffsetArea, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Use this for example for specifying what pages to import from
/// a PDF or PS document.
pub const PageSelector = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.PageSelectorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The number of pages of the document to open.
        pub const n_pages = struct {
            pub const name = "n-pages";

            pub const Type = c_int;
        };

        /// The target to open the document to.
        pub const target = struct {
            pub const name = "target";

            pub const Type = gimpui.PageSelectorTarget;
        };
    };

    pub const signals = struct {
        /// The "activate" signal on GimpPageSelector is an action signal. It
        /// is emitted when a user double-clicks an item in the page selection.
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PageSelector, p_instance))),
                    gobject.signalLookup("activate", PageSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted whenever the set of selected pages changes.
        pub const selection_changed = struct {
            pub const name = "selection-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PageSelector, p_instance))),
                    gobject.signalLookup("selection-changed", PageSelector.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.PageSelector` widget.
    extern fn gimp_page_selector_new() *gimpui.PageSelector;
    pub const new = gimp_page_selector_new;

    extern fn gimp_page_selector_get_n_pages(p_selector: *PageSelector) c_int;
    pub const getNPages = gimp_page_selector_get_n_pages;

    extern fn gimp_page_selector_get_page_label(p_selector: *PageSelector, p_page_no: c_int) ?[*:0]u8;
    pub const getPageLabel = gimp_page_selector_get_page_label;

    extern fn gimp_page_selector_get_page_thumbnail(p_selector: *PageSelector, p_page_no: c_int) ?*gdkpixbuf.Pixbuf;
    pub const getPageThumbnail = gimp_page_selector_get_page_thumbnail;

    extern fn gimp_page_selector_get_selected_pages(p_selector: *PageSelector, p_n_selected_pages: *c_int) [*]c_int;
    pub const getSelectedPages = gimp_page_selector_get_selected_pages;

    extern fn gimp_page_selector_get_selected_range(p_selector: *PageSelector) [*:0]u8;
    pub const getSelectedRange = gimp_page_selector_get_selected_range;

    extern fn gimp_page_selector_get_target(p_selector: *PageSelector) gimpui.PageSelectorTarget;
    pub const getTarget = gimp_page_selector_get_target;

    extern fn gimp_page_selector_page_is_selected(p_selector: *PageSelector, p_page_no: c_int) c_int;
    pub const pageIsSelected = gimp_page_selector_page_is_selected;

    /// Selects all pages.
    extern fn gimp_page_selector_select_all(p_selector: *PageSelector) void;
    pub const selectAll = gimp_page_selector_select_all;

    /// Adds a page to the selection.
    extern fn gimp_page_selector_select_page(p_selector: *PageSelector, p_page_no: c_int) void;
    pub const selectPage = gimp_page_selector_select_page;

    /// Selects the pages described by `range`. The range string is a
    /// user-editable list of pages and ranges, e.g. "1,3,5-7,9-12,14".
    /// Note that the page numbering in the range string starts with 1,
    /// not 0.
    ///
    /// Invalid pages and ranges will be silently ignored, duplicate and
    /// overlapping pages and ranges will be merged.
    extern fn gimp_page_selector_select_range(p_selector: *PageSelector, p_range: [*:0]const u8) void;
    pub const selectRange = gimp_page_selector_select_range;

    /// Sets the number of pages in the document to open.
    extern fn gimp_page_selector_set_n_pages(p_selector: *PageSelector, p_n_pages: c_int) void;
    pub const setNPages = gimp_page_selector_set_n_pages;

    /// Sets the label of the specified page.
    extern fn gimp_page_selector_set_page_label(p_selector: *PageSelector, p_page_no: c_int, p_label: [*:0]const u8) void;
    pub const setPageLabel = gimp_page_selector_set_page_label;

    /// Sets the thumbnail for given `page_no`. A default "page" icon will
    /// be used if no page thumbnail is set.
    extern fn gimp_page_selector_set_page_thumbnail(p_selector: *PageSelector, p_page_no: c_int, p_thumbnail: *gdkpixbuf.Pixbuf) void;
    pub const setPageThumbnail = gimp_page_selector_set_page_thumbnail;

    extern fn gimp_page_selector_set_target(p_selector: *PageSelector, p_target: gimpui.PageSelectorTarget) void;
    pub const setTarget = gimp_page_selector_set_target;

    /// Unselects all pages.
    extern fn gimp_page_selector_unselect_all(p_selector: *PageSelector) void;
    pub const unselectAll = gimp_page_selector_unselect_all;

    /// Removes a page from the selection.
    extern fn gimp_page_selector_unselect_page(p_selector: *PageSelector, p_page_no: c_int) void;
    pub const unselectPage = gimp_page_selector_unselect_page;

    extern fn gimp_page_selector_get_type() usize;
    pub const getGObjectType = gimp_page_selector_get_type;

    extern fn g_object_ref(p_self: *gimpui.PageSelector) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PageSelector) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PageSelector, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a palette selection dialog.
pub const PaletteChooser = opaque {
    pub const Parent = gimpui.ResourceChooser;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.PaletteChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a palette.
    /// You can put this widget in a table in a plug-in dialog.
    ///
    /// When palette is NULL, initial choice is from context.
    extern fn gimp_palette_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_palette: ?*gimp.Palette) *gimpui.PaletteChooser;
    pub const new = gimp_palette_chooser_new;

    extern fn gimp_palette_chooser_get_type() usize;
    pub const getGObjectType = gimp_palette_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.PaletteChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PaletteChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PaletteChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathComboBox = opaque {
    pub const Parent = gimpui.IntComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = opaque {
        pub const Instance = PathComboBox;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.IntComboBox` filled with all currently opened
    /// path objects. If a `constraint` function is specified, it is called for
    /// each path object and only if the function returns `TRUE`, the path
    /// object is added to the combobox.
    ///
    /// You should use `gimpui.IntComboBox.connect` to initialize and connect
    /// the combo.  Use `gimpui.IntComboBox.setActive` to set the active
    /// path ID and `gimpui.IntComboBox.getActive` to retrieve the ID
    /// of the selected path object.
    extern fn gimp_path_combo_box_new(p_constraint: ?gimpui.ItemConstraintFunc, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gimpui.PathComboBox;
    pub const new = gimp_path_combo_box_new;

    extern fn gimp_path_combo_box_get_type() usize;
    pub const getGObjectType = gimp_path_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.PathComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PathComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PathComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is used to edit file search paths.
///
/// It shows a list of all directories which are in the search
/// path. You can click a directory to select it. The widget provides a
/// `gimpui.FileEntry` to change the currently selected directory.
///
/// There are buttons to add or delete directories as well as "up" and
/// "down" buttons to change the order in which the directories will be
/// searched.
///
/// Whenever the user adds, deletes, changes or reorders a directory of
/// the search path, the "path_changed" signal will be emitted.
pub const PathEditor = opaque {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.PathEditorClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal is emitted whenever the user adds, deletes, modifies
        /// or reorders an element of the search path.
        pub const path_changed = struct {
            pub const name = "path-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PathEditor, p_instance))),
                    gobject.signalLookup("path-changed", PathEditor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// This signal is emitted whenever the "writable" column of a directory
        /// is changed, either by the user clicking on it or by calling
        /// `gimpui.PathEditor.setDirWritable`.
        pub const writable_changed = struct {
            pub const name = "writable-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PathEditor, p_instance))),
                    gobject.signalLookup("writable-changed", PathEditor.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.PathEditor` widget.
    ///
    /// The elements of the initial search path must be separated with the
    /// `G_SEARCHPATH_SEPARATOR` character.
    extern fn gimp_path_editor_new(p_title: [*:0]const u8, p_path: ?[*:0]const u8) *gimpui.PathEditor;
    pub const new = gimp_path_editor_new;

    extern fn gimp_path_editor_get_dir_writable(p_editor: *PathEditor, p_directory: [*:0]const u8) c_int;
    pub const getDirWritable = gimp_path_editor_get_dir_writable;

    /// The elements of the returned search path string are separated with the
    /// `G_SEARCHPATH_SEPARATOR` character.
    ///
    /// Note that you have to `glib.free` the returned string.
    extern fn gimp_path_editor_get_path(p_editor: *PathEditor) [*:0]u8;
    pub const getPath = gimp_path_editor_get_path;

    extern fn gimp_path_editor_get_writable_path(p_editor: *PathEditor) [*:0]u8;
    pub const getWritablePath = gimp_path_editor_get_writable_path;

    extern fn gimp_path_editor_set_dir_writable(p_editor: *PathEditor, p_directory: [*:0]const u8, p_writable: c_int) void;
    pub const setDirWritable = gimp_path_editor_set_dir_writable;

    /// The elements of the initial search path must be separated with the
    /// `G_SEARCHPATH_SEPARATOR` character.
    extern fn gimp_path_editor_set_path(p_editor: *PathEditor, p_path: [*:0]const u8) void;
    pub const setPath = gimp_path_editor_set_path;

    extern fn gimp_path_editor_set_writable_path(p_editor: *PathEditor, p_path: [*:0]const u8) void;
    pub const setWritablePath = gimp_path_editor_set_writable_path;

    extern fn gimp_path_editor_get_type() usize;
    pub const getGObjectType = gimp_path_editor_get_type;

    extern fn g_object_ref(p_self: *gimpui.PathEditor) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PathEditor) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PathEditor, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a pattern selection dialog.
///
/// Note that this widget draws itself using `GEGL` code. You **must** call
/// `gegl.init` first to be able to use this chooser.
pub const PatternChooser = opaque {
    pub const Parent = gimpui.ResourceChooser;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.PatternChooserClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gtk.Widget` that lets a user choose a pattern.
    /// You can put this widget in a table in a plug-in dialog.
    ///
    /// When pattern is NULL, initial choice is from context.
    extern fn gimp_pattern_chooser_new(p_title: ?[*:0]const u8, p_label: ?[*:0]const u8, p_pattern: ?*gimp.Pattern) *gimpui.PatternChooser;
    pub const new = gimp_pattern_chooser_new;

    extern fn gimp_pattern_chooser_get_type() usize;
    pub const getGObjectType = gimp_pattern_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.PatternChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PatternChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PatternChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimpui.PickButton` is a specialized button. When clicked, it changes
/// the cursor to a color-picker pipette and allows the user to pick a
/// color from any point on the screen.
pub const PickButton = extern struct {
    pub const Parent = gtk.Button;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Actionable, gtk.Activatable, gtk.Buildable };
    pub const Class = gimpui.PickButtonClass;
    f_parent_instance: gtk.Button,

    pub const virtual_methods = struct {
        pub const color_picked = struct {
            pub fn call(p_class: anytype, p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *const gegl.Color) void {
                return gobject.ext.as(PickButton.Class, p_class).f_color_picked.?(gobject.ext.as(PickButton, p_button), p_color);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_button: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_color: *const gegl.Color) callconv(.c) void) void {
                gobject.ext.as(PickButton.Class, p_class).f_color_picked = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// This signal is emitted when the user has picked a color.
        pub const color_picked = struct {
            pub const name = "color-picked";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_color: *gegl.Color, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(PickButton, p_instance))),
                    gobject.signalLookup("color-picked", PickButton.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.PickButton` widget.
    extern fn gimp_pick_button_new() *gimpui.PickButton;
    pub const new = gimp_pick_button_new;

    extern fn gimp_pick_button_get_type() usize;
    pub const getGObjectType = gimp_pick_button_get_type;

    extern fn g_object_ref(p_self: *gimpui.PickButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PickButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PickButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a `gimpui.PreviewArea` plus framework to update the
/// preview.
pub const Preview = extern struct {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.PreviewClass;
    f_parent_instance: gtk.Box,

    pub const virtual_methods = struct {
        /// Calls the GimpPreview::draw method. GimpPreview itself doesn't
        /// implement a default draw method so the behavior is determined by
        /// the derived class implementing this method.
        ///
        /// `gimpui.DrawablePreview` implements `gimpui.Preview.draw` by drawing the
        /// original, unmodified drawable to the `preview`.
        pub const draw = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Preview.Class, p_class).f_draw.?(gobject.ext.as(Preview, p_preview));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_draw = @ptrCast(p_implementation);
            }
        };

        /// Calls the GimpPreview::draw_buffer method. GimpPreview itself
        /// doesn't implement this method so the behavior is determined by the
        /// derived class implementing this method.
        pub const draw_buffer = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]const u8, p_rowstride: c_int) void {
                return gobject.ext.as(Preview.Class, p_class).f_draw_buffer.?(gobject.ext.as(Preview, p_preview), p_buffer, p_rowstride);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_buffer: [*]const u8, p_rowstride: c_int) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_draw_buffer = @ptrCast(p_implementation);
            }
        };

        pub const draw_thumb = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_area: *gimpui.PreviewArea, p_width: c_int, p_height: c_int) void {
                return gobject.ext.as(Preview.Class, p_class).f_draw_thumb.?(gobject.ext.as(Preview, p_preview), p_area, p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_area: *gimpui.PreviewArea, p_width: c_int, p_height: c_int) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_draw_thumb = @ptrCast(p_implementation);
            }
        };

        pub const invalidated = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Preview.Class, p_class).f_invalidated.?(gobject.ext.as(Preview, p_preview));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_invalidated = @ptrCast(p_implementation);
            }
        };

        pub const set_cursor = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Preview.Class, p_class).f_set_cursor.?(gobject.ext.as(Preview, p_preview));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_set_cursor = @ptrCast(p_implementation);
            }
        };

        /// Transforms from image to widget coordinates.
        pub const transform = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) void {
                return gobject.ext.as(Preview.Class, p_class).f_transform.?(gobject.ext.as(Preview, p_preview), p_src_x, p_src_y, p_dest_x, p_dest_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_transform = @ptrCast(p_implementation);
            }
        };

        /// Transforms from widget to image coordinates.
        pub const untransform = struct {
            pub fn call(p_class: anytype, p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) void {
                return gobject.ext.as(Preview.Class, p_class).f_untransform.?(gobject.ext.as(Preview, p_preview), p_src_x, p_src_y, p_dest_x, p_dest_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_preview: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) callconv(.c) void) void {
                gobject.ext.as(Preview.Class, p_class).f_untransform = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const update = struct {
            pub const name = "update";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        pub const invalidated = struct {
            pub const name = "invalidated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Preview, p_instance))),
                    gobject.signalLookup("invalidated", Preview.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Calls the GimpPreview::draw method. GimpPreview itself doesn't
    /// implement a default draw method so the behavior is determined by
    /// the derived class implementing this method.
    ///
    /// `gimpui.DrawablePreview` implements `gimpui.Preview.draw` by drawing the
    /// original, unmodified drawable to the `preview`.
    extern fn gimp_preview_draw(p_preview: *Preview) void;
    pub const draw = gimp_preview_draw;

    /// Calls the GimpPreview::draw_buffer method. GimpPreview itself
    /// doesn't implement this method so the behavior is determined by the
    /// derived class implementing this method.
    extern fn gimp_preview_draw_buffer(p_preview: *Preview, p_buffer: [*]const u8, p_rowstride: c_int) void;
    pub const drawBuffer = gimp_preview_draw_buffer;

    /// In most cases, you shouldn't need to access the `gimpui.PreviewArea`
    /// that is being used in the `preview`. Sometimes however, you need to.
    /// For example if you want to receive mouse events from the area. In
    /// such cases, use `gimpui.Preview.getArea`.
    extern fn gimp_preview_get_area(p_preview: *Preview) *gimpui.PreviewArea;
    pub const getArea = gimp_preview_get_area;

    extern fn gimp_preview_get_bounds(p_preview: *Preview, p_xmin: ?*c_int, p_ymin: ?*c_int, p_xmax: ?*c_int, p_ymax: ?*c_int) void;
    pub const getBounds = gimp_preview_get_bounds;

    /// Gives access to the horizontal `gtk.Box` at the bottom of the preview
    /// that contains the update toggle. Derived widgets can use this function
    /// if they need to add controls to this area.
    extern fn gimp_preview_get_controls(p_preview: *Preview) *gtk.Box;
    pub const getControls = gimp_preview_get_controls;

    /// See `gimpui.Preview.setDefaultCursor`:
    extern fn gimp_preview_get_default_cursor(p_preview: *Preview) *gdk.Cursor;
    pub const getDefaultCursor = gimp_preview_get_default_cursor;

    extern fn gimp_preview_get_frame(p_preview: *Preview) *gtk.AspectFrame;
    pub const getFrame = gimp_preview_get_frame;

    extern fn gimp_preview_get_grid(p_preview: *Preview) *gtk.Grid;
    pub const getGrid = gimp_preview_get_grid;

    extern fn gimp_preview_get_offsets(p_preview: *Preview, p_xoff: ?*c_int, p_yoff: ?*c_int) void;
    pub const getOffsets = gimp_preview_get_offsets;

    extern fn gimp_preview_get_position(p_preview: *Preview, p_x: ?*c_int, p_y: ?*c_int) void;
    pub const getPosition = gimp_preview_get_position;

    extern fn gimp_preview_get_size(p_preview: *Preview, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getSize = gimp_preview_get_size;

    extern fn gimp_preview_get_update(p_preview: *Preview) c_int;
    pub const getUpdate = gimp_preview_get_update;

    /// This function starts or renews a short low-priority timeout. When
    /// the timeout expires, the GimpPreview::invalidated signal is emitted
    /// which will usually cause the `preview` to be updated.
    ///
    /// This function does nothing unless the "Preview" button is checked.
    ///
    /// During the emission of the signal a busy cursor is set on the
    /// toplevel window containing the `preview` and on the preview area
    /// itself.
    extern fn gimp_preview_invalidate(p_preview: *Preview) void;
    pub const invalidate = gimp_preview_invalidate;

    /// Sets the lower and upper limits for the previewed area. The
    /// difference between the upper and lower value is used to set the
    /// maximum size of the `gimpui.PreviewArea` used in the `preview`.
    extern fn gimp_preview_set_bounds(p_preview: *Preview, p_xmin: c_int, p_ymin: c_int, p_xmax: c_int, p_ymax: c_int) void;
    pub const setBounds = gimp_preview_set_bounds;

    /// Sets the default mouse cursor for the preview.  Note that this will
    /// be overridden by a `GDK_FLEUR` if the preview has scrollbars, or by a
    /// `GDK_WATCH` when the preview is invalidated.
    extern fn gimp_preview_set_default_cursor(p_preview: *Preview, p_cursor: *gdk.Cursor) void;
    pub const setDefaultCursor = gimp_preview_set_default_cursor;

    extern fn gimp_preview_set_offsets(p_preview: *Preview, p_xoff: c_int, p_yoff: c_int) void;
    pub const setOffsets = gimp_preview_set_offsets;

    extern fn gimp_preview_set_size(p_preview: *Preview, p_width: c_int, p_height: c_int) void;
    pub const setSize = gimp_preview_set_size;

    /// Sets the state of the "Preview" check button.
    extern fn gimp_preview_set_update(p_preview: *Preview, p_update: c_int) void;
    pub const setUpdate = gimp_preview_set_update;

    /// Transforms from image to widget coordinates.
    extern fn gimp_preview_transform(p_preview: *Preview, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) void;
    pub const transform = gimp_preview_transform;

    /// Transforms from widget to image coordinates.
    extern fn gimp_preview_untransform(p_preview: *Preview, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) void;
    pub const untransform = gimp_preview_untransform;

    extern fn gimp_preview_get_type() usize;
    pub const getGObjectType = gimp_preview_get_type;

    extern fn g_object_ref(p_self: *gimpui.Preview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Preview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Preview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A general purpose preview widget which caches its pixel data.
pub const PreviewArea = opaque {
    pub const Parent = gtk.DrawingArea;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.PreviewAreaClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const check_custom_color1 = struct {
            pub const name = "check-custom-color1";

            pub const Type = ?*gegl.Color;
        };

        pub const check_custom_color2 = struct {
            pub const name = "check-custom-color2";

            pub const Type = ?*gegl.Color;
        };

        pub const check_size = struct {
            pub const name = "check-size";

            pub const Type = gimp.CheckSize;
        };

        pub const check_type = struct {
            pub const name = "check-type";

            pub const Type = gimp.CheckType;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.PreviewArea` widget.
    ///
    /// If the preview area is used to draw an image with transparency, you
    /// might want to default the checkboard size and colors to user-set
    /// Preferences. To do this, you may set the following properties on the
    /// newly created `gimpui.PreviewArea`:
    ///
    /// ```
    /// g_object_set (area,
    ///               "check-size",          gimp_check_size (),
    ///               "check-type",          gimp_check_type (),
    ///               "check-custom-color1", gimp_check_custom_color1 (),
    ///               "check-custom-color2", gimp_check_custom_color2 (),
    ///               NULL);
    /// ```
    extern fn gimp_preview_area_new() *gimpui.PreviewArea;
    pub const new = gimp_preview_area_new;

    /// Composites `buf1` on `buf2` with the given `opacity`, draws the result
    /// to `area` and queues a redraw on the given rectangle.
    ///
    /// Since GIMP 2.2
    extern fn gimp_preview_area_blend(p_area: *PreviewArea, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_type: gimp.ImageType, p_buf1: [*]const u8, p_rowstride1: c_int, p_buf2: [*]const u8, p_rowstride2: c_int, p_opacity: u8) void;
    pub const blend = gimp_preview_area_blend;

    /// Draws `buf` on `area` and queues a redraw on the given rectangle.
    ///
    /// Since GIMP 2.2
    extern fn gimp_preview_area_draw(p_area: *PreviewArea, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_type: gimp.ImageType, p_buf: [*]const u8, p_rowstride: c_int) void;
    pub const draw = gimp_preview_area_draw;

    /// Fills the given rectangle of `area` in the given color and queues a
    /// redraw.
    ///
    /// Since GIMP 2.2
    extern fn gimp_preview_area_fill(p_area: *PreviewArea, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_red: u8, p_green: u8, p_blue: u8) void;
    pub const fill = gimp_preview_area_fill;

    /// Gets the preview area size
    extern fn gimp_preview_area_get_size(p_area: *PreviewArea, p_width: *c_int, p_height: *c_int) void;
    pub const getSize = gimp_preview_area_get_size;

    /// Composites `buf1` on `buf2` with the given `mask`, draws the result on
    /// `area` and queues a redraw on the given rectangle.
    ///
    /// Since GIMP 2.2
    extern fn gimp_preview_area_mask(p_area: *PreviewArea, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_type: gimp.ImageType, p_buf1: [*]const u8, p_rowstride1: c_int, p_buf2: [*]const u8, p_rowstride2: c_int, p_mask: [*]const u8, p_rowstride_mask: c_int) void;
    pub const mask = gimp_preview_area_mask;

    /// Creates a popup menu that allows one to configure the size and type of
    /// the checkerboard pattern that the `area` uses to visualize transparency.
    extern fn gimp_preview_area_menu_popup(p_area: *PreviewArea, p_event: ?*gdk.EventButton) void;
    pub const menuPopup = gimp_preview_area_menu_popup;

    /// Reset any previous drawing done through `gimpui.PreviewArea` functions.
    extern fn gimp_preview_area_reset(p_area: *PreviewArea) void;
    pub const reset = gimp_preview_area_reset;

    /// Sets the color management configuration to use with this preview area.
    extern fn gimp_preview_area_set_color_config(p_area: *PreviewArea, p_config: *gimp.ColorConfig) void;
    pub const setColorConfig = gimp_preview_area_set_color_config;

    /// Sets the colormap for the `gimpui.PreviewArea` widget. You need to
    /// call this function before you use `gimpui.PreviewArea.draw` with
    /// an image type of `GIMP_INDEXED_IMAGE` or `GIMP_INDEXEDA_IMAGE`.
    ///
    /// Since GIMP 2.2
    extern fn gimp_preview_area_set_colormap(p_area: *PreviewArea, p_colormap: [*]const u8, p_num_colors: c_int) void;
    pub const setColormap = gimp_preview_area_set_colormap;

    /// Usually a `gimpui.PreviewArea` fills the size that it is
    /// allocated. This function allows you to limit the preview area to a
    /// maximum size. If a larger size is allocated for the widget, the
    /// preview will draw itself centered into the allocated area.
    extern fn gimp_preview_area_set_max_size(p_area: *PreviewArea, p_width: c_int, p_height: c_int) void;
    pub const setMaxSize = gimp_preview_area_set_max_size;

    /// Sets the offsets of the previewed area. This information is used
    /// when drawing the checkerboard and to determine the dither offsets.
    extern fn gimp_preview_area_set_offsets(p_area: *PreviewArea, p_x: c_int, p_y: c_int) void;
    pub const setOffsets = gimp_preview_area_set_offsets;

    extern fn gimp_preview_area_get_type() usize;
    pub const getGObjectType = gimp_preview_area_get_type;

    extern fn g_object_ref(p_self: *gimpui.PreviewArea) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.PreviewArea) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *PreviewArea, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The dialog for the procedure and plugin browsers.
pub const ProcBrowserDialog = opaque {
    pub const Parent = gimpui.Dialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.ProcBrowserDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// Emitted when one of the rows in the contained `gtk.TreeView` is activated.
        pub const row_activated = struct {
            pub const name = "row-activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ProcBrowserDialog, p_instance))),
                    gobject.signalLookup("row-activated", ProcBrowserDialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when the selection in the contained `gtk.TreeView` changes.
        pub const selection_changed = struct {
            pub const name = "selection-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ProcBrowserDialog, p_instance))),
                    gobject.signalLookup("selection-changed", ProcBrowserDialog.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Create a new `gimpui.ProcBrowserDialog`.
    extern fn gimp_proc_browser_dialog_new(p_title: [*:0]const u8, p_role: [*:0]const u8, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, ...) *gimpui.ProcBrowserDialog;
    pub const new = gimp_proc_browser_dialog_new;

    /// Retrieves the name of the currently selected procedure.
    extern fn gimp_proc_browser_dialog_get_selected(p_dialog: *ProcBrowserDialog) ?[*:0]u8;
    pub const getSelected = gimp_proc_browser_dialog_get_selected;

    extern fn gimp_proc_browser_dialog_get_type() usize;
    pub const getGObjectType = gimp_proc_browser_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.ProcBrowserDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ProcBrowserDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ProcBrowserDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcedureDialog = extern struct {
    pub const Parent = gimpui.Dialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.ProcedureDialogClass;
    f_parent_instance: gimpui.Dialog,

    pub const virtual_methods = struct {
        pub const fill_end = struct {
            pub fn call(p_class: anytype, p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) void {
                return gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_end.?(gobject.ext.as(ProcedureDialog, p_dialog), p_procedure, p_config);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) callconv(.c) void) void {
                gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_end = @ptrCast(p_implementation);
            }
        };

        pub const fill_list = struct {
            pub fn call(p_class: anytype, p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_properties: *glib.List) void {
                return gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_list.?(gobject.ext.as(ProcedureDialog, p_dialog), p_procedure, p_config, p_properties);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_properties: *glib.List) callconv(.c) void) void {
                gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_list = @ptrCast(p_implementation);
            }
        };

        pub const fill_start = struct {
            pub fn call(p_class: anytype, p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) void {
                return gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_start.?(gobject.ext.as(ProcedureDialog, p_dialog), p_procedure, p_config);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_dialog: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) callconv(.c) void) void {
                gobject.ext.as(ProcedureDialog.Class, p_class).f_fill_start = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const config = struct {
            pub const name = "config";

            pub const Type = ?*gimp.ProcedureConfig;
        };

        pub const procedure = struct {
            pub const name = "procedure";

            pub const Type = ?*gimp.Procedure;
        };
    };

    pub const signals = struct {};

    /// Creates a new dialog for `procedure` using widgets generated from
    /// properties of `config`.
    /// A `NULL` title will only be accepted if a menu label was set with
    /// `gimp.Procedure.setMenuLabel` (this menu label will then be used as
    /// dialog title instead). If neither an explicit label nor a `procedure`
    /// menu label was set, the call will fail.
    ///
    /// As for all `gtk.Window`, the returned `gimpui.ProcedureDialog` object is
    /// owned by GTK and its initial reference is stored in an internal list
    /// of top-level windows. To delete the dialog, call
    /// `gtk.Widget.destroy`.
    extern fn gimp_procedure_dialog_new(p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_title: ?[*:0]const u8) *gimpui.ProcedureDialog;
    pub const new = gimp_procedure_dialog_new;

    /// Populate `dialog` with the widgets corresponding to every listed
    /// properties. If the list is empty, `dialog` will be filled by the whole
    /// list of properties of the associated `gimp.Procedure`, in the defined
    /// order:
    /// ```
    /// gimp_procedure_dialog_fill (dialog, NULL);
    /// ```
    /// Nevertheless if you only wish to display a partial list of
    /// properties, or if you wish to change the display order, then you have
    /// to give an explicit list:
    /// ```
    /// gimp_procedure_dialog_fill (dialog, "property-1", "property-2", NULL);
    /// ```
    ///
    /// Note: you do not have to call `gimpui.ProcedureDialog.getWidget` on
    /// every property before calling this function unless you want a given
    /// property to be represented by an alternative widget type. By default,
    /// each property will get a default representation according to its
    /// type.
    extern fn gimp_procedure_dialog_fill(p_dialog: *ProcedureDialog, ...) void;
    pub const fill = gimp_procedure_dialog_fill;

    /// Creates and populates a new `gtk.Box` with widgets corresponding to
    /// every listed properties. If the list is empty, the created box will
    /// be filled by the whole list of properties of the associated
    /// `gimp.Procedure`, in the defined order. This is similar of how
    /// `gimpui.ProcedureDialog.fill` works except that it creates a new
    /// widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_box(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_first_property: [*:0]const u8, ...) *gtk.Widget;
    pub const fillBox = gimp_procedure_dialog_fill_box;

    /// Creates and populates a new `gtk.Box` with widgets corresponding to
    /// every listed `properties`. If the list is empty, the created box will
    /// be filled by the whole list of properties of the associated
    /// `gimp.Procedure`, in the defined order. This is similar of how
    /// `gimpui.ProcedureDialog.fill` works except that it creates a new
    /// widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_box_list(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_properties: ?*glib.List) *gtk.Widget;
    pub const fillBoxList = gimp_procedure_dialog_fill_box_list;

    /// Creates a new `gtk.Expander` and packs `title_id` as its title
    /// and `contents_id` as content.
    /// If `title_id` represents a boolean property, its value will be used to
    /// expand the `gtk.Expander`. If `invert_title` is TRUE, then expand binding is
    /// inverted.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_expander(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_title_id: ?[*:0]const u8, p_invert_title: c_int, p_contents_id: ?[*:0]const u8) *gtk.Widget;
    pub const fillExpander = gimp_procedure_dialog_fill_expander;

    /// Creates and populates a new `gtk.FlowBox` with widgets corresponding to
    /// every listed properties. If the list is empty, the created flowbox
    /// will be filled by the whole list of properties of the associated
    /// `gimp.Procedure`, in the defined order. This is similar of how
    /// `gimpui.ProcedureDialog.fill` works except that it creates a new
    /// widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_flowbox(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_first_property: [*:0]const u8, ...) *gtk.Widget;
    pub const fillFlowbox = gimp_procedure_dialog_fill_flowbox;

    /// Creates and populates a new `gtk.FlowBox` with widgets corresponding to
    /// every listed `properties`. If the list is empty, the created flowbox
    /// will be filled by the whole list of properties of the associated
    /// `gimp.Procedure`, in the defined order. This is similar of how
    /// `gimpui.ProcedureDialog.fill` works except that it creates a new
    /// widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_flowbox_list(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_properties: ?*glib.List) *gtk.Widget;
    pub const fillFlowboxList = gimp_procedure_dialog_fill_flowbox_list;

    /// Creates a new `gtk.Frame` and packs `title_id` as its title and
    /// `contents_id` as its child.
    /// If `title_id` represents a boolean property, its value will be used to
    /// renders `contents_id` sensitive or not. If `invert_title` is TRUE, then
    /// sensitivity binding is inverted.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_frame(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_title_id: ?[*:0]const u8, p_invert_title: c_int, p_contents_id: ?[*:0]const u8) *gtk.Widget;
    pub const fillFrame = gimp_procedure_dialog_fill_frame;

    /// Populate `dialog` with the widgets corresponding to every listed
    /// properties. If the list is `NULL`, `dialog` will be filled by the whole
    /// list of properties of the associated `gimp.Procedure`, in the defined
    /// order:
    /// ```
    /// gimp_procedure_dialog_fill_list (dialog, NULL);
    /// ```
    /// Nevertheless if you only wish to display a partial list of
    /// properties, or if you wish to change the display order, then you have
    /// to give an explicit list:
    /// ```
    /// gimp_procedure_dialog_fill (dialog, "property-1", "property-2", NULL);
    /// ```
    ///
    /// Note: you do not have to call `gimpui.ProcedureDialog.getWidget` on
    /// every property before calling this function unless you want a given
    /// property to be represented by an alternative widget type. By default,
    /// each property will get a default representation according to its
    /// type.
    extern fn gimp_procedure_dialog_fill_list(p_dialog: *ProcedureDialog, p_properties: ?*glib.List) void;
    pub const fillList = gimp_procedure_dialog_fill_list;

    /// Creates and populates a new `gtk.Notebook` with widgets corresponding to every
    /// listed properties.
    /// This is similar of how `gimpui.ProcedureDialog.fill` works except that it
    /// creates a new widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_notebook(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_label_id: [*:0]const u8, p_page_id: [*:0]const u8, ...) *gtk.Widget;
    pub const fillNotebook = gimp_procedure_dialog_fill_notebook;

    /// Creates and populates a new `gtk.Notebook` with widgets corresponding to every
    /// listed properties.
    /// This is similar of how `gimpui.ProcedureDialog.fillList` works except that it
    /// creates a new widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_notebook_list(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_label_list: *glib.List, p_page_list: *glib.List) *gtk.Widget;
    pub const fillNotebookList = gimp_procedure_dialog_fill_notebook_list;

    /// Creates and populates a new `gtk.Paned` containing widgets corresponding to
    /// `child1_id` and `child2_id`.
    /// This is similar of how `gimpui.ProcedureDialog.fill` works except that it
    /// creates a new widget which is not inside `dialog` itself.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_paned(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_orientation: gtk.Orientation, p_child1_id: ?[*:0]const u8, p_child2_id: ?[*:0]const u8) *gtk.Widget;
    pub const fillPaned = gimp_procedure_dialog_fill_paned;

    /// Creates and populates a new `gtk.ScrolledWindow` with a widget corresponding
    /// to the declared content id.
    ///
    /// The `container_id` must be a unique ID which is neither the name of a
    /// property of the `gimp.ProcedureConfig` associated to `dialog`, nor is it
    /// the ID of any previously created container. This ID can later be used
    /// together with property names to be packed in other containers or
    /// inside `dialog` itself.
    extern fn gimp_procedure_dialog_fill_scrolled_window(p_dialog: *ProcedureDialog, p_container_id: [*:0]const u8, p_contents_id: [*:0]const u8) *gtk.Widget;
    pub const fillScrolledWindow = gimp_procedure_dialog_fill_scrolled_window;

    /// Creates a new widget for `property` which must necessarily be a
    /// `gegl.Color` property.
    /// This must be used instead of `gimpui.ProcedureDialog.getWidget` when
    /// you want a `gimpui.LabelColor` which is not customizable for a color
    /// property, or when to set a specific `type`.
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_color_widget(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_editable: c_int, p_type: gimpui.ColorAreaType) *gtk.Widget;
    pub const getColorWidget = gimp_procedure_dialog_get_color_widget;

    /// Gets or creates a new `gimpui.DrawablePreview` for `drawable`.
    /// If a widget with the `preview_id` has already been created for
    /// this procedure, it will be returned instead.
    ///
    /// The `preview_id` ID can later be used together with property names
    /// to be packed in other containers or inside `dialog` itself.
    extern fn gimp_procedure_dialog_get_drawable_preview(p_dialog: *ProcedureDialog, p_preview_id: [*:0]const u8, p_drawable: *gimp.Drawable) *gtk.Widget;
    pub const getDrawablePreview = gimp_procedure_dialog_get_drawable_preview;

    /// Creates a new `gimpui.LabelIntWidget` for `property` which must
    /// necessarily be an integer or boolean property.
    /// This must be used instead of `gimpui.ProcedureDialog.getWidget` when
    /// you want to create a combo box from an integer property.
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_int_combo(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_store: *gimpui.IntStore) *gtk.Widget;
    pub const getIntCombo = gimp_procedure_dialog_get_int_combo;

    /// Creates a new `GimpLabelIntRadioFrame` for `property` which must
    /// necessarily be an integer, enum or boolean property.
    /// This must be used instead of `gimpui.ProcedureDialog.getWidget` when
    /// you want to create a group of `gtk.RadioButton`-s from an integer
    /// property.
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_int_radio(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_store: *gimpui.IntStore) *gtk.Widget;
    pub const getIntRadio = gimp_procedure_dialog_get_int_radio;

    /// Creates a new `gtk.Label` with `text`. It can be useful for packing
    /// textual information in between property settings.
    ///
    /// If `label_id` is an existing string property of the `gimp.ProcedureConfig`
    /// associated to `dialog`, then it will sync to the property value. In this case,
    /// `text` should be `NULL`.
    ///
    /// If `label_id` is a unique ID which is neither the name of a property of the
    /// `gimp.ProcedureConfig` associated to `dialog`, nor is it the ID of any
    /// previously created label or container, it will be initialized to `text`. This
    /// ID can later be used together with property names to be packed in other
    /// containers or inside `dialog` itself.
    extern fn gimp_procedure_dialog_get_label(p_dialog: *ProcedureDialog, p_label_id: [*:0]const u8, p_text: [*:0]const u8, p_is_markup: c_int, p_with_mnemonic: c_int) *gtk.Widget;
    pub const getLabel = gimp_procedure_dialog_get_label;

    /// Creates a new `gimpui.ScaleEntry` for `property` which must necessarily be
    /// an integer or double property.
    /// This can be used instead of `gimpui.ProcedureDialog.getWidget` in
    /// particular if you want to tweak the display factor. A typical example
    /// is showing a [0.0, 1.0] range as [0.0, 100.0] instead (`factor` = 100.0).
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_scale_entry(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_factor: f64) *gtk.Widget;
    pub const getScaleEntry = gimp_procedure_dialog_get_scale_entry;

    /// Creates a new `gimpui.SizeEntry` for `property` which must necessarily be
    /// an integer or double property. The associated `unit_property` must be
    /// a GimpUnit or integer property.
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_size_entry(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_property_is_pixel: c_int, p_unit_property: [*:0]const u8, p_unit_format: [*:0]const u8, p_update_policy: gimpui.SizeEntryUpdatePolicy, p_resolution: f64) *gtk.Widget;
    pub const getSizeEntry = gimp_procedure_dialog_get_size_entry;

    /// Creates a new `gimpui.SpinScale` for `property` which must necessarily be
    /// an integer or double property.
    /// This can be used instead of `gimpui.ProcedureDialog.getWidget` in
    /// particular if you want to tweak the display factor. A typical example
    /// is showing a [0.0, 1.0] range as [0.0, 100.0] instead (`factor` = 100.0).
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (whatever its actual widget type).
    extern fn gimp_procedure_dialog_get_spin_scale(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_factor: f64) *gtk.Widget;
    pub const getSpinScale = gimp_procedure_dialog_get_spin_scale;

    /// Creates a new `gtk.Widget` for `property` according to the property
    /// type. The following types are possible:
    ///
    /// - `G_TYPE_PARAM_BOOLEAN`:
    ///     * `GTK_TYPE_CHECK_BUTTON` (default)
    ///     * `GTK_TYPE_SWITCH`
    /// - `G_TYPE_PARAM_INT` or `G_TYPE_PARAM_DOUBLE`:
    ///     * `GIMP_TYPE_LABEL_SPIN` (default): a spin button with a label.
    ///     * `GIMP_TYPE_SCALE_ENTRY`: a scale entry with label.
    ///     * `GIMP_TYPE_SPIN_SCALE`: a spin scale with label embedded.
    ///     * `GIMP_TYPE_SPIN_BUTTON`: a spin button with no label.
    /// - `G_TYPE_PARAM_STRING`:
    ///     * `GIMP_TYPE_LABEL_ENTRY` (default): an entry with a label.
    ///     * `GTK_TYPE_ENTRY`: an entry with no label.
    ///     * `GTK_TYPE_TEXT_VIEW`: a text view with no label.
    /// - `GIMP_TYPE_CHOICE`:
    ///     * `GTK_TYPE_COMBO_BOX` (default): a combo box displaying every
    ///       choice.
    ///     * `GIMP_TYPE_INT_RADIO_FRAME`: a frame with radio buttons.
    /// - `GEGL_TYPE_COLOR`:
    ///     * `GIMP_TYPE_LABEL_COLOR` (default): a color button with a label.
    ///         Please use `gimpui.ProcedureDialog.getColorWidget` for a
    ///         non-editable color area with a label.
    ///     * `GIMP_TYPE_COLOR_BUTTON`: a color button with no label.
    ///     * `GIMP_TYPE_COLOR_AREA`: a color area with no label.
    /// - `GIMP_TYPE_PARAM_FILE`:
    ///     * `GTK_FILE_CHOOSER_BUTTON` (default): generic file chooser widget
    ///       using the action mode of the param spec.
    ///       Note that it won't work with a `gimp.@"FileChooserAction.ANY"`
    ///       action. If you intend to display a widget for a file param
    ///       spec, you should always set it to a more specific action.
    ///       See `gimp.Procedure.addFileArgument`.
    /// - `G_TYPE_PARAM_UNIT`:
    ///     * `GIMP_TYPE_UNIT_COMBO_BOX`
    ///
    /// If the `widget_type` is not supported for the actual type of
    /// `property`, the function will fail. To keep the default, set to
    /// `G_TYPE_NONE`.
    ///
    /// If a widget has already been created for this procedure, it will be
    /// returned instead (even if with a different `widget_type`).
    extern fn gimp_procedure_dialog_get_widget(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_widget_type: usize) *gtk.Widget;
    pub const getWidget = gimp_procedure_dialog_get_widget;

    /// Show `dialog` and only returns when the user finished interacting with
    /// it (either validating choices or canceling).
    extern fn gimp_procedure_dialog_run(p_dialog: *ProcedureDialog) c_int;
    pub const run = gimp_procedure_dialog_run;

    /// Changes the "OK" button's label of `dialog` to `ok_label`.
    extern fn gimp_procedure_dialog_set_ok_label(p_dialog: *ProcedureDialog, p_ok_label: [*:0]const u8) void;
    pub const setOkLabel = gimp_procedure_dialog_set_ok_label;

    /// Sets sensitivity of the widget associated to `property` in `dialog`. If
    /// `config` is `NULL`, then it is set to the value of `sensitive`.
    /// Otherwise `sensitive` is ignored and sensitivity is bound to the value
    /// of `config_property` of `config` (or the negation of this value
    /// if `config_reverse` is `TRUE`).
    extern fn gimp_procedure_dialog_set_sensitive(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_sensitive: c_int, p_config: ?*gobject.Object, p_config_property: ?[*:0]const u8, p_config_invert: c_int) void;
    pub const setSensitive = gimp_procedure_dialog_set_sensitive;

    /// Sets sensitivity of the widget associated to `property` in `dialog` if the
    /// value of `config_property` in `config` is equal to one of `values`.
    ///
    /// If `config` is `NULL`, then the configuration object of `dialog` is used.
    ///
    /// If `in_values` is FALSE, then the widget is set sensitive if the value of
    /// `config_property` is **not** in `values`.
    extern fn gimp_procedure_dialog_set_sensitive_if_in(p_dialog: *ProcedureDialog, p_property: [*:0]const u8, p_config: ?*gobject.Object, p_config_property: [*:0]const u8, p_values: *gimp.ValueArray, p_in_values: c_int) void;
    pub const setSensitiveIfIn = gimp_procedure_dialog_set_sensitive_if_in;

    extern fn gimp_procedure_dialog_get_type() usize;
    pub const getGObjectType = gimp_procedure_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.ProcedureDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ProcedureDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ProcedureDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a progress bar that automatically redirects any
/// progress calls to itself.
pub const ProgressBar = opaque {
    pub const Parent = gtk.ProgressBar;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ProgressBarClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.ProgressBar` widget.
    extern fn gimp_progress_bar_new() *gimpui.ProgressBar;
    pub const new = gimp_progress_bar_new;

    extern fn gimp_progress_bar_get_type() usize;
    pub const getGObjectType = gimp_progress_bar_get_type;

    extern fn g_object_ref(p_self: *gimpui.ProgressBar) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ProgressBar) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ProgressBar, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A button which pops up a resource selection dialog.
///
/// Responsibilities:
///
///     - implementing outer container widget,
///     - managing clicks and popping up a remote chooser,
///     - having a resource property,
///     - signaling when user selects resource
///     - receiving drag,
///     - triggering draws of the button interior (by subclass) and draws of remote popup chooser.
///
/// Collaborations:
///
///     - owned by GimpProcedureDialog via GimpPropWidget
///     - resource property usually bound to a GimpConfig for a GimpPluginProcedure.
///     - communicates using GimpResourceSelect with remote GimpPDBDialog,
///       to choose an installed GimpResource owned by core.
///
/// Subclass responsibilities:
///
///     - creating interior widgets
///     - drawing the interior (a preview of the chosen resource)
///     - declaring which interior widgets are drag destinations
///     - declaring which interior widgets are clickable (generate "clicked" signal)
///     - generate "clicked" (delegating to GtkButton or implementing from mouse events)
pub const ResourceChooser = extern struct {
    pub const Parent = gtk.Box;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ResourceChooserClass;
    f_parent_instance: gtk.Box,

    pub const virtual_methods = struct {
        pub const draw_interior = struct {
            pub fn call(p_class: anytype, p_chooser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ResourceChooser.Class, p_class).f_draw_interior.?(gobject.ext.as(ResourceChooser, p_chooser));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_chooser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ResourceChooser.Class, p_class).f_draw_interior = @ptrCast(p_implementation);
            }
        };

        pub const resource_set = struct {
            pub fn call(p_class: anytype, p_chooser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_resource: *gimp.Resource, p_dialog_closing: c_int) void {
                return gobject.ext.as(ResourceChooser.Class, p_class).f_resource_set.?(gobject.ext.as(ResourceChooser, p_chooser), p_resource, p_dialog_closing);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_chooser: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_resource: *gimp.Resource, p_dialog_closing: c_int) callconv(.c) void) void {
                gobject.ext.as(ResourceChooser.Class, p_class).f_resource_set = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        /// Label text with mnemonic.
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };

        /// The currently selected resource.
        pub const resource = struct {
            pub const name = "resource";

            pub const Type = ?*gimp.Resource;
        };

        /// The title to be used for the resource selection popup dialog.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {
        /// The ::resource-set signal is emitted when the user selects a resource.
        pub const resource_set = struct {
            pub const name = "resource-set";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_resource: *gobject.Object, p_dialog_closing: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ResourceChooser, p_instance))),
                    gobject.signalLookup("resource-set", ResourceChooser.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Returns the label widget.
    extern fn gimp_resource_chooser_get_label(p_widget: *ResourceChooser) *gtk.Widget;
    pub const getLabel = gimp_resource_chooser_get_label;

    /// Gets the currently selected resource.
    extern fn gimp_resource_chooser_get_resource(p_chooser: *ResourceChooser) *gimp.Resource;
    pub const getResource = gimp_resource_chooser_get_resource;

    /// Sets the currently selected resource.
    /// This will select the resource in both the button and any chooser popup.
    extern fn gimp_resource_chooser_set_resource(p_chooser: *ResourceChooser, p_resource: *gimp.Resource) void;
    pub const setResource = gimp_resource_chooser_set_resource;

    extern fn gimp_resource_chooser_get_type() usize;
    pub const getGObjectType = gimp_resource_chooser_get_type;

    extern fn g_object_ref(p_self: *gimpui.ResourceChooser) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ResourceChooser) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ResourceChooser, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A ruler widget with configurable unit and orientation.
pub const Ruler = opaque {
    pub const Parent = gtk.Widget;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.RulerClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const lower = struct {
            pub const name = "lower";

            pub const Type = f64;
        };

        pub const max_size = struct {
            pub const name = "max-size";

            pub const Type = f64;
        };

        pub const orientation = struct {
            pub const name = "orientation";

            pub const Type = gtk.Orientation;
        };

        pub const position = struct {
            pub const name = "position";

            pub const Type = f64;
        };

        pub const unit = struct {
            pub const name = "unit";

            pub const Type = ?*gimp.Unit;
        };

        pub const upper = struct {
            pub const name = "upper";

            pub const Type = f64;
        };
    };

    pub const signals = struct {};

    /// Creates a new ruler.
    extern fn gimp_ruler_new(p_orientation: gtk.Orientation) *gimpui.Ruler;
    pub const new = gimp_ruler_new;

    /// Adds a "track widget" to the ruler. The ruler will connect to
    /// GtkWidget:motion-notify-event: on the track widget and update its
    /// position marker accordingly. The marker is correctly updated also
    /// for the track widget's children, regardless of whether they are
    /// ordinary children of off-screen children.
    extern fn gimp_ruler_add_track_widget(p_ruler: *Ruler, p_widget: *gtk.Widget) void;
    pub const addTrackWidget = gimp_ruler_add_track_widget;

    extern fn gimp_ruler_get_position(p_ruler: *Ruler) f64;
    pub const getPosition = gimp_ruler_get_position;

    /// Retrieves values indicating the range and current position of a `gimpui.Ruler`.
    /// See `gimpui.Ruler.setRange`.
    extern fn gimp_ruler_get_range(p_ruler: *Ruler, p_lower: ?*f64, p_upper: ?*f64, p_max_size: ?*f64) void;
    pub const getRange = gimp_ruler_get_range;

    extern fn gimp_ruler_get_unit(p_ruler: *Ruler) *gimp.Unit;
    pub const getUnit = gimp_ruler_get_unit;

    /// Removes a previously added track widget from the ruler. See
    /// `gimpui.Ruler.addTrackWidget`.
    extern fn gimp_ruler_remove_track_widget(p_ruler: *Ruler, p_widget: *gtk.Widget) void;
    pub const removeTrackWidget = gimp_ruler_remove_track_widget;

    /// This sets the position of the ruler.
    extern fn gimp_ruler_set_position(p_ruler: *Ruler, p_position: f64) void;
    pub const setPosition = gimp_ruler_set_position;

    /// This sets the range of the ruler.
    extern fn gimp_ruler_set_range(p_ruler: *Ruler, p_lower: f64, p_upper: f64, p_max_size: f64) void;
    pub const setRange = gimp_ruler_set_range;

    /// This sets the unit of the ruler.
    extern fn gimp_ruler_set_unit(p_ruler: *Ruler, p_unit: *gimp.Unit) void;
    pub const setUnit = gimp_ruler_set_unit;

    extern fn gimp_ruler_get_type() usize;
    pub const getGObjectType = gimp_ruler_get_type;

    extern fn g_object_ref(p_self: *gimpui.Ruler) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.Ruler) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Ruler, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is a `gtk.Grid` showing a `gtk.SpinButton` and a `gtk.Scale`
/// bound together. It also displays a `gtk.Label` which is used as
/// mnemonic on the `gtk.SpinButton`.
pub const ScaleEntry = extern struct {
    pub const Parent = gimpui.LabelSpin;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ScaleEntryClass;
    f_parent_instance: gimpui.LabelSpin,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// This function creates a `gtk.Label`, a `gtk.HScale` and a `gtk.SpinButton` and
    /// attaches them to a 3-column `gtk.Grid`.
    extern fn gimp_scale_entry_new(p_text: [*:0]const u8, p_value: f64, p_lower: f64, p_upper: f64, p_digits: c_uint) *gimpui.ScaleEntry;
    pub const new = gimp_scale_entry_new;

    extern fn gimp_scale_entry_get_logarithmic(p_entry: *ScaleEntry) c_int;
    pub const getLogarithmic = gimp_scale_entry_get_logarithmic;

    /// This function returns the `gtk.Range` packed in `entry`. This can be
    /// useful if you need to customize some aspects of the widget
    ///
    /// By default, it is a `gtk.Scale`, but it can be any other type of
    /// `gtk.Range` if a subclass overrode the `new_range_widget` protected
    /// method.
    extern fn gimp_scale_entry_get_range(p_entry: *ScaleEntry) *gtk.Range;
    pub const getRange = gimp_scale_entry_get_range;

    /// By default the `gtk.SpinButton` and `gtk.Scale` will have the same range.
    /// In some case, you want to set a different range. In particular when
    /// the finale range is huge, the `gtk.Scale` might become nearly useless
    /// as every tiny slider move would dramatically update the value. In
    /// this case, it is common to set the `gtk.Scale` to a smaller common
    /// range, while the `gtk.SpinButton` would allow for the full allowed
    /// range.
    /// This function allows this. Obviously the `gtk.Adjustment` of both
    /// widgets would be synced but if the set value is out of the `gtk.Scale`
    /// range, the slider would simply show at one extreme.
    ///
    /// If `limit_scale` is `FALSE` though, it would sync back both widgets
    /// range to the new values.
    ///
    /// Note that the step and page increments are updated when the range is
    /// updated according to some common usage algorithm which should work if
    /// you don't have very specific needs. If you want to customize the step
    /// increments yourself, you may call `gimpui.LabelSpin.setIncrements`
    extern fn gimp_scale_entry_set_bounds(p_entry: *ScaleEntry, p_lower: f64, p_upper: f64, p_limit_scale: c_int) void;
    pub const setBounds = gimp_scale_entry_set_bounds;

    /// Sets whether `entry`'s scale widget will behave in a linear
    /// or logarithmic fashion. Useful when an entry has to attend large
    /// ranges, but smaller selections on that range require a finer
    /// adjustment.
    extern fn gimp_scale_entry_set_logarithmic(p_entry: *ScaleEntry, p_logarithmic: c_int) void;
    pub const setLogarithmic = gimp_scale_entry_set_logarithmic;

    extern fn gimp_scale_entry_get_type() usize;
    pub const getGObjectType = gimp_scale_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.ScaleEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ScaleEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ScaleEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A widget providing a `gimpui.Preview` enhanced by scrolling capabilities.
pub const ScrolledPreview = extern struct {
    pub const Parent = gimpui.Preview;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ScrolledPreviewClass;
    f_parent_instance: gimpui.Preview,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// While the `preview` is frozen, it is not going to redraw itself in
    /// response to scroll events.
    ///
    /// This function should only be used to implement widgets derived from
    /// `gimpui.ScrolledPreview`. There is no point in calling this from a plug-in.
    extern fn gimp_scrolled_preview_freeze(p_preview: *ScrolledPreview) void;
    pub const freeze = gimp_scrolled_preview_freeze;

    extern fn gimp_scrolled_preview_get_adjustments(p_preview: *ScrolledPreview, p_hadj: **gtk.Adjustment, p_vadj: **gtk.Adjustment) void;
    pub const getAdjustments = gimp_scrolled_preview_get_adjustments;

    extern fn gimp_scrolled_preview_set_policy(p_preview: *ScrolledPreview, p_hscrollbar_policy: gtk.PolicyType, p_vscrollbar_policy: gtk.PolicyType) void;
    pub const setPolicy = gimp_scrolled_preview_set_policy;

    extern fn gimp_scrolled_preview_set_position(p_preview: *ScrolledPreview, p_x: c_int, p_y: c_int) void;
    pub const setPosition = gimp_scrolled_preview_set_position;

    /// While the `preview` is frozen, it is not going to redraw itself in
    /// response to scroll events.
    ///
    /// This function should only be used to implement widgets derived from
    /// `gimpui.ScrolledPreview`. There is no point in calling this from a plug-in.
    extern fn gimp_scrolled_preview_thaw(p_preview: *ScrolledPreview) void;
    pub const thaw = gimp_scrolled_preview_thaw;

    extern fn gimp_scrolled_preview_get_type() usize;
    pub const getGObjectType = gimp_scrolled_preview_get_type;

    extern fn g_object_ref(p_self: *gimpui.ScrolledPreview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ScrolledPreview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ScrolledPreview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This widget is used to enter pixel distances/sizes and resolutions.
///
/// You can specify the number of fields the widget should provide. For
/// each field automatic mappings are performed between the field's
/// "reference value" and its "value".
///
/// There is a `gimpui.UnitComboBox` right of the entry fields which lets
/// you specify the `gimp.Unit` of the displayed values.
///
/// For each field, there can be one or two `gtk.SpinButton`'s to enter
/// "value" and "reference value". If you specify `show_refval` as
/// `FALSE` in `gimpui.SizeEntry.new` there will be only one
/// `gtk.SpinButton` and the `gimpui.UnitComboBox` will contain an item for
/// selecting GIMP_UNIT_PIXEL.
///
/// The "reference value" is either of GIMP_UNIT_PIXEL or dpi,
/// depending on which `gimpui.SizeEntryUpdatePolicy` you specify in
/// `gimpui.SizeEntry.new`.  The "value" is either the size in pixels
/// mapped to the size in a real-world-unit (see `gimp.Unit`) or the dpi
/// value mapped to pixels per real-world-unit.
pub const SizeEntry = opaque {
    pub const Parent = gtk.Grid;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.SizeEntryClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        pub const refval_changed = struct {
            pub const name = "refval-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SizeEntry, p_instance))),
                    gobject.signalLookup("refval-changed", SizeEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const unit_changed = struct {
            pub const name = "unit-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SizeEntry, p_instance))),
                    gobject.signalLookup("unit-changed", SizeEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(SizeEntry, p_instance))),
                    gobject.signalLookup("value-changed", SizeEntry.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Creates a new `gimpui.SizeEntry` widget.
    ///
    /// To have all automatic calculations performed correctly, set up the
    /// widget in the following order:
    ///
    /// 1. `gimpui.SizeEntry.new`
    ///
    /// 2. (for each additional input field) `gimpui.SizeEntry.addField`
    ///
    /// 3. `gimpui.SizeEntry.setUnit`
    ///
    /// For each input field:
    ///
    /// 4. `gimpui.SizeEntry.setResolution`
    ///
    /// 5. `gimpui.SizeEntry.setRefvalBoundaries`
    ///    (or `gimpui.SizeEntry.setValueBoundaries`)
    ///
    /// 6. `gimpui.SizeEntry.setSize`
    ///
    /// 7. `gimpui.SizeEntry.setRefval` (or `gimpui.SizeEntry.setValue`)
    ///
    /// The `gimpui.SizeEntry` is derived from `gtk.Grid` and will have
    /// an empty border of one cell width on each side plus an empty column left
    /// of the `gimpui.UnitComboBox` to allow the caller to add labels or a
    /// `gimpui.ChainButton`.
    extern fn gimp_size_entry_new(p_number_of_fields: c_int, p_unit: *gimp.Unit, p_unit_format: [*:0]const u8, p_menu_show_pixels: c_int, p_menu_show_percent: c_int, p_show_refval: c_int, p_spinbutton_width: c_int, p_update_policy: gimpui.SizeEntryUpdatePolicy) *gimpui.SizeEntry;
    pub const new = gimp_size_entry_new;

    /// Adds an input field to the `gimpui.SizeEntry`.
    ///
    /// The new input field will have the index 0. If you specified `show_refval`
    /// as `TRUE` in `gimpui.SizeEntry.new` you have to pass an additional
    /// `gtk.SpinButton` to hold the reference value. If `show_refval` was `FALSE`,
    /// `refval_spinbutton` will be ignored.
    extern fn gimp_size_entry_add_field(p_gse: *SizeEntry, p_value_spinbutton: *gtk.SpinButton, p_refval_spinbutton: ?*gtk.SpinButton) void;
    pub const addField = gimp_size_entry_add_field;

    /// Attaches a `gtk.Label` to the `gimpui.SizeEntry` (which is a `gtk.Grid`).
    extern fn gimp_size_entry_attach_label(p_gse: *SizeEntry, p_text: [*:0]const u8, p_row: c_int, p_column: c_int, p_alignment: f32) *gtk.Widget;
    pub const attachLabel = gimp_size_entry_attach_label;

    /// You shouldn't fiddle with the internals of a `gimpui.SizeEntry` but
    /// if you want to set tooltips using `gimpui.helpSetHelpData` you
    /// can use this function to get a pointer to the spinbuttons.
    extern fn gimp_size_entry_get_help_widget(p_gse: *SizeEntry, p_field: c_int) *gtk.Widget;
    pub const getHelpWidget = gimp_size_entry_get_help_widget;

    extern fn gimp_size_entry_get_n_fields(p_gse: *SizeEntry) c_int;
    pub const getNFields = gimp_size_entry_get_n_fields;

    /// Returns the reference value for field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The reference value is either a distance in pixels or a resolution
    /// in dpi, depending on which `gimpui.SizeEntryUpdatePolicy` you chose in
    /// `gimpui.SizeEntry.new`.
    extern fn gimp_size_entry_get_refval(p_gse: *SizeEntry, p_field: c_int) f64;
    pub const getRefval = gimp_size_entry_get_refval;

    /// Returns the `gimp.Unit` the user has selected in the `gimpui.SizeEntry`'s
    /// `gimpui.UnitComboBox`.
    extern fn gimp_size_entry_get_unit(p_gse: *SizeEntry) *gimp.Unit;
    pub const getUnit = gimp_size_entry_get_unit;

    extern fn gimp_size_entry_get_unit_combo(p_gse: *SizeEntry) *gimpui.UnitComboBox;
    pub const getUnitCombo = gimp_size_entry_get_unit_combo;

    extern fn gimp_size_entry_get_update_policy(p_gse: *SizeEntry) gimpui.SizeEntryUpdatePolicy;
    pub const getUpdatePolicy = gimp_size_entry_get_update_policy;

    /// Returns the value of field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The `value` returned is a distance or resolution
    /// in the `gimp.Unit` the user has selected in the `gimpui.SizeEntry`'s
    /// `gimpui.UnitComboBox`.
    ///
    /// NOTE: In most cases you won't be interested in this value because the
    ///       `gimpui.SizeEntry`'s purpose is to shield the programmer from unit
    ///       calculations. Use `gimpui.SizeEntry.getRefval` instead.
    extern fn gimp_size_entry_get_value(p_gse: *SizeEntry, p_field: c_int) f64;
    pub const getValue = gimp_size_entry_get_value;

    /// This function is rather ugly and just a workaround for the fact that
    /// it's impossible to implement `gtk.Widget.grabFocus` for a `gtk.Grid` (is this actually true after the Table->Grid conversion?).
    extern fn gimp_size_entry_grab_focus(p_gse: *SizeEntry) void;
    pub const grabFocus = gimp_size_entry_grab_focus;

    /// Iterates over all entries in the `gimpui.SizeEntry` and calls
    /// `gtk.Entry.setActivatesDefault` on them.
    extern fn gimp_size_entry_set_activates_default(p_gse: *SizeEntry, p_setting: c_int) void;
    pub const setActivatesDefault = gimp_size_entry_set_activates_default;

    /// This function allows you set up a `gimpui.SizeEntry` so that sub-pixel
    /// sizes can be entered.
    extern fn gimp_size_entry_set_pixel_digits(p_gse: *SizeEntry, p_digits: c_int) void;
    pub const setPixelDigits = gimp_size_entry_set_pixel_digits;

    /// Sets the reference value for field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The `refval` passed is either a distance in pixels or a resolution in dpi,
    /// depending on which `gimpui.SizeEntryUpdatePolicy` you chose in
    /// `gimpui.SizeEntry.new`.
    extern fn gimp_size_entry_set_refval(p_gse: *SizeEntry, p_field: c_int, p_refval: f64) void;
    pub const setRefval = gimp_size_entry_set_refval;

    /// Limits the range of possible reference values which can be entered in
    /// field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The current reference value of the `field` will be clamped to fit in the
    /// `field`'s new boundaries.
    extern fn gimp_size_entry_set_refval_boundaries(p_gse: *SizeEntry, p_field: c_int, p_lower: f64, p_upper: f64) void;
    pub const setRefvalBoundaries = gimp_size_entry_set_refval_boundaries;

    /// Sets the decimal digits of field # `field` of the `gimpui.SizeEntry` to
    /// `digits`.
    ///
    /// If you don't specify this value explicitly, the reference value's number
    /// of digits will equal to 0 for `GIMP_SIZE_ENTRY_UPDATE_SIZE` and to 2 for
    /// `GIMP_SIZE_ENTRY_UPDATE_RESOLUTION`.
    extern fn gimp_size_entry_set_refval_digits(p_gse: *SizeEntry, p_field: c_int, p_digits: c_int) void;
    pub const setRefvalDigits = gimp_size_entry_set_refval_digits;

    /// Sets the resolution (in dpi) for field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The `resolution` passed will be clamped to fit in
    /// [`GIMP_MIN_RESOLUTION`..`GIMP_MAX_RESOLUTION`].
    ///
    /// This function does nothing if the `gimpui.SizeEntryUpdatePolicy` specified in
    /// `gimpui.SizeEntry.new` doesn't equal to `GIMP_SIZE_ENTRY_UPDATE_SIZE`.
    extern fn gimp_size_entry_set_resolution(p_gse: *SizeEntry, p_field: c_int, p_resolution: f64, p_keep_size: c_int) void;
    pub const setResolution = gimp_size_entry_set_resolution;

    /// Sets the pixel values for field # `field` of the `gimpui.SizeEntry`
    /// which will be treated as 0% and 100%.
    ///
    /// These values will be used if you specified `menu_show_percent` as `TRUE`
    /// in `gimpui.SizeEntry.new` and the user has selected GIMP_UNIT_PERCENT in
    /// the `gimpui.SizeEntry`'s `gimpui.UnitComboBox`.
    ///
    /// This function does nothing if the `gimpui.SizeEntryUpdatePolicy` specified in
    /// `gimpui.SizeEntry.new` doesn't equal to GIMP_SIZE_ENTRY_UPDATE_SIZE.
    extern fn gimp_size_entry_set_size(p_gse: *SizeEntry, p_field: c_int, p_lower: f64, p_upper: f64) void;
    pub const setSize = gimp_size_entry_set_size;

    /// Sets the `gimpui.SizeEntry`'s unit. The reference value for all fields will
    /// stay the same but the value in units or pixels per unit will change
    /// according to which `gimpui.SizeEntryUpdatePolicy` you chose in
    /// `gimpui.SizeEntry.new`.
    extern fn gimp_size_entry_set_unit(p_gse: *SizeEntry, p_unit: *gimp.Unit) void;
    pub const setUnit = gimp_size_entry_set_unit;

    /// Sets the value for field # `field` of the `gimpui.SizeEntry`.
    ///
    /// The `value` passed is treated to be a distance or resolution
    /// in the `gimp.Unit` the user has selected in the `gimpui.SizeEntry`'s
    /// `gimpui.UnitComboBox`.
    ///
    /// NOTE: In most cases you won't be interested in this value because the
    ///       `gimpui.SizeEntry`'s purpose is to shield the programmer from unit
    ///       calculations. Use `gimpui.SizeEntry.setRefval` instead.
    extern fn gimp_size_entry_set_value(p_gse: *SizeEntry, p_field: c_int, p_value: f64) void;
    pub const setValue = gimp_size_entry_set_value;

    /// Limits the range of possible values which can be entered in field # `field`
    /// of the `gimpui.SizeEntry`.
    ///
    /// The current value of the `field` will be clamped to fit in the `field`'s
    /// new boundaries.
    ///
    /// NOTE: In most cases you won't be interested in this function because the
    ///       `gimpui.SizeEntry`'s purpose is to shield the programmer from unit
    ///       calculations. Use `gimpui.SizeEntry.setRefvalBoundaries` instead.
    ///       Whatever you do, don't mix these calls. A size entry should either
    ///       be clamped by the value or the reference value.
    extern fn gimp_size_entry_set_value_boundaries(p_gse: *SizeEntry, p_field: c_int, p_lower: f64, p_upper: f64) void;
    pub const setValueBoundaries = gimp_size_entry_set_value_boundaries;

    /// Controls whether a unit menu is shown in the size entry.  If
    /// `show` is `TRUE`, the menu is shown; otherwise it is hidden.
    extern fn gimp_size_entry_show_unit_menu(p_gse: *SizeEntry, p_show: c_int) void;
    pub const showUnitMenu = gimp_size_entry_show_unit_menu;

    extern fn gimp_size_entry_get_type() usize;
    pub const getGObjectType = gimp_size_entry_get_type;

    extern fn g_object_ref(p_self: *gimpui.SizeEntry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.SizeEntry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SizeEntry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimpui.SpinButton` is a drop-in replacement for `gtk.SpinButton`, with the
/// following changes:
///
///   - When the spin-button loses focus, its adjustment value is only
///     updated if the entry text has been changed.
///
///   - When the spin-button's "wrap" property is TRUE, values input through the
///     entry are wrapped around.
///
///   - Modifiers can be used during scrolling for smaller/bigger increments.
pub const SpinButton = extern struct {
    pub const Parent = gtk.SpinButton;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.Editable, gtk.Orientable };
    pub const Class = gimpui.SpinButtonClass;
    f_parent_instance: gtk.SpinButton,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `gimpui.SpinButton`.
    extern fn gimp_spin_button_new(p_adjustment: ?*gtk.Adjustment, p_climb_rate: f64, p_digits: c_uint) *gimpui.SpinButton;
    pub const new = gimp_spin_button_new;

    /// This is a convenience constructor that allows creation of a numeric
    /// `gimpui.SpinButton` without manually creating an adjustment.  The value is
    /// initially set to the minimum value and a page increment of 10 * `step`
    /// is the default.  The precision of the spin button is equivalent to the
    /// precision of `step`.
    ///
    /// Note that the way in which the precision is derived works best if `step`
    /// is a power of ten. If the resulting precision is not suitable for your
    /// needs, use `gtk.SpinButton.setDigits` to correct it.
    extern fn gimp_spin_button_new_with_range(p_min: f64, p_max: f64, p_step: f64) *gimpui.SpinButton;
    pub const newWithRange = gimp_spin_button_new_with_range;

    extern fn gimp_spin_button_get_type() usize;
    pub const getGObjectType = gimp_spin_button_get_type;

    extern fn g_object_ref(p_self: *gimpui.SpinButton) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.SpinButton) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SpinButton, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinScale = opaque {
    pub const Parent = gimpui.SpinButton;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.Editable, gtk.Orientable };
    pub const Class = gimpui.SpinScaleClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const label = struct {
            pub const name = "label";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn gimp_spin_scale_new(p_adjustment: *gtk.Adjustment, p_label: [*:0]const u8, p_digits: c_int) *gimpui.SpinScale;
    pub const new = gimp_spin_scale_new;

    extern fn gimp_spin_scale_get_constrain_drag(p_scale: *SpinScale) c_int;
    pub const getConstrainDrag = gimp_spin_scale_get_constrain_drag;

    extern fn gimp_spin_scale_get_gamma(p_scale: *SpinScale) f64;
    pub const getGamma = gimp_spin_scale_get_gamma;

    extern fn gimp_spin_scale_get_label(p_scale: *SpinScale) [*:0]const u8;
    pub const getLabel = gimp_spin_scale_get_label;

    /// If `scale` has been set with a mnemonic key in its label text, this function
    /// returns the keyval used for the mnemonic accelerator.
    extern fn gimp_spin_scale_get_mnemonic_keyval(p_scale: *SpinScale) c_uint;
    pub const getMnemonicKeyval = gimp_spin_scale_get_mnemonic_keyval;

    extern fn gimp_spin_scale_get_scale_limits(p_scale: *SpinScale, p_lower: *f64, p_upper: *f64) c_int;
    pub const getScaleLimits = gimp_spin_scale_get_scale_limits;

    /// If `constrain_drag` is TRUE, dragging the scale with the pointer will
    /// only result into integer values. It will still possible to set the
    /// scale to fractional values (if the spin scale "digits" is above 0)
    /// for instance with keyboard edit.
    extern fn gimp_spin_scale_set_constrain_drag(p_scale: *SpinScale, p_constrain: c_int) void;
    pub const setConstrainDrag = gimp_spin_scale_set_constrain_drag;

    extern fn gimp_spin_scale_set_gamma(p_scale: *SpinScale, p_gamma: f64) void;
    pub const setGamma = gimp_spin_scale_set_gamma;

    extern fn gimp_spin_scale_set_label(p_scale: *SpinScale, p_label: [*:0]const u8) void;
    pub const setLabel = gimp_spin_scale_set_label;

    extern fn gimp_spin_scale_set_scale_limits(p_scale: *SpinScale, p_lower: f64, p_upper: f64) void;
    pub const setScaleLimits = gimp_spin_scale_set_scale_limits;

    extern fn gimp_spin_scale_unset_scale_limits(p_scale: *SpinScale) void;
    pub const unsetScaleLimits = gimp_spin_scale_unset_scale_limits;

    extern fn gimp_spin_scale_get_type() usize;
    pub const getGObjectType = gimp_spin_scale_get_type;

    extern fn g_object_ref(p_self: *gimpui.SpinScale) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.SpinScale) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *SpinScale, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A `gtk.ComboBox` subclass to select strings.
pub const StringComboBox = extern struct {
    pub const Parent = gtk.ComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.StringComboBoxClass;
    f_parent_instance: gtk.ComboBox,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Specifies the preferred place to ellipsize text in the combo-box,
        /// if the cell renderer does not have enough room to display the
        /// entire string.
        pub const ellipsize = struct {
            pub const name = "ellipsize";

            pub const Type = pango.EllipsizeMode;
        };

        /// The column in the associated GtkTreeModel that holds unique
        /// string IDs.
        pub const id_column = struct {
            pub const name = "id-column";

            pub const Type = c_int;
        };

        /// The column in the associated GtkTreeModel that holds strings to
        /// be used as labels in the combo-box.
        pub const label_column = struct {
            pub const name = "label-column";

            pub const Type = c_int;
        };

        /// The active value (different from the "active" property of
        /// GtkComboBox which is the active index).
        pub const value = struct {
            pub const name = "value";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn gimp_string_combo_box_new(p_model: *gtk.TreeModel, p_id_column: c_int, p_label_column: c_int) *gimpui.StringComboBox;
    pub const new = gimp_string_combo_box_new;

    /// Retrieves the value of the selected (active) item in the `combo_box`.
    extern fn gimp_string_combo_box_get_active(p_combo_box: *StringComboBox) [*:0]u8;
    pub const getActive = gimp_string_combo_box_get_active;

    /// Looks up the item that belongs to the given `id` and makes it the
    /// selected item in the `combo_box`.
    extern fn gimp_string_combo_box_set_active(p_combo_box: *StringComboBox, p_id: [*:0]const u8) c_int;
    pub const setActive = gimp_string_combo_box_set_active;

    /// Sets a function that is used to decide about the sensitivity of
    /// rows in the `combo_box`. Use this if you want to set certain rows
    /// insensitive.
    ///
    /// Calling `gtk.Widget.queueDraw` on the `combo_box` will cause the
    /// sensitivity to be updated.
    extern fn gimp_string_combo_box_set_sensitivity(p_combo_box: *StringComboBox, p_func: gimpui.StringSensitivityFunc, p_data: ?*anyopaque, p_destroy: ?glib.DestroyNotify) void;
    pub const setSensitivity = gimp_string_combo_box_set_sensitivity;

    extern fn gimp_string_combo_box_get_type() usize;
    pub const getGObjectType = gimp_string_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.StringComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.StringComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StringComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// `gimpui.UnitComboBox` selects units stored in a `gimpui.UnitStore`.
pub const UnitComboBox = opaque {
    pub const Parent = gtk.ComboBox;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.CellEditable, gtk.CellLayout };
    pub const Class = gimpui.UnitComboBoxClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn gimp_unit_combo_box_new() *gimpui.UnitComboBox;
    pub const new = gimp_unit_combo_box_new;

    extern fn gimp_unit_combo_box_new_with_model(p_model: *gimpui.UnitStore) *gimpui.UnitComboBox;
    pub const newWithModel = gimp_unit_combo_box_new_with_model;

    /// Returns the `gimp.Unit` currently selected in the combo box.
    extern fn gimp_unit_combo_box_get_active(p_combo: *UnitComboBox) *gimp.Unit;
    pub const getActive = gimp_unit_combo_box_get_active;

    /// Sets `unit` as the currently selected `gimp.Unit` on `combo`.
    extern fn gimp_unit_combo_box_set_active(p_combo: *UnitComboBox, p_unit: *gimp.Unit) void;
    pub const setActive = gimp_unit_combo_box_set_active;

    extern fn gimp_unit_combo_box_get_type() usize;
    pub const getGObjectType = gimp_unit_combo_box_get_type;

    extern fn g_object_ref(p_self: *gimpui.UnitComboBox) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.UnitComboBox) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UnitComboBox, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A model for `gimp.Unit` views
pub const UnitStore = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gtk.TreeModel};
    pub const Class = gimpui.UnitStoreClass;
    f_parent_instance: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const has_percent = struct {
            pub const name = "has-percent";

            pub const Type = c_int;
        };

        pub const has_pixels = struct {
            pub const name = "has-pixels";

            pub const Type = c_int;
        };

        pub const long_format = struct {
            pub const name = "long-format";

            pub const Type = ?[*:0]u8;
        };

        pub const num_values = struct {
            pub const name = "num-values";

            pub const Type = c_int;
        };

        pub const short_format = struct {
            pub const name = "short-format";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    extern fn gimp_unit_store_new(p_num_values: c_int) *gimpui.UnitStore;
    pub const new = gimp_unit_store_new;

    extern fn gimp_unit_store_get_has_percent(p_store: *UnitStore) c_int;
    pub const getHasPercent = gimp_unit_store_get_has_percent;

    extern fn gimp_unit_store_get_has_pixels(p_store: *UnitStore) c_int;
    pub const getHasPixels = gimp_unit_store_get_has_pixels;

    extern fn gimp_unit_store_get_nth_value(p_store: *UnitStore, p_unit: *gimp.Unit, p_index: c_int) f64;
    pub const getNthValue = gimp_unit_store_get_nth_value;

    extern fn gimp_unit_store_get_values(p_store: *UnitStore, p_unit: *gimp.Unit, p_first_value: *f64, ...) void;
    pub const getValues = gimp_unit_store_get_values;

    extern fn gimp_unit_store_set_has_percent(p_store: *UnitStore, p_has_percent: c_int) void;
    pub const setHasPercent = gimp_unit_store_set_has_percent;

    extern fn gimp_unit_store_set_has_pixels(p_store: *UnitStore, p_has_pixels: c_int) void;
    pub const setHasPixels = gimp_unit_store_set_has_pixels;

    extern fn gimp_unit_store_set_pixel_value(p_store: *UnitStore, p_index: c_int, p_value: f64) void;
    pub const setPixelValue = gimp_unit_store_set_pixel_value;

    extern fn gimp_unit_store_set_pixel_values(p_store: *UnitStore, p_first_value: f64, ...) void;
    pub const setPixelValues = gimp_unit_store_set_pixel_values;

    extern fn gimp_unit_store_set_resolution(p_store: *UnitStore, p_index: c_int, p_resolution: f64) void;
    pub const setResolution = gimp_unit_store_set_resolution;

    extern fn gimp_unit_store_set_resolutions(p_store: *UnitStore, p_first_resolution: f64, ...) void;
    pub const setResolutions = gimp_unit_store_set_resolutions;

    extern fn gimp_unit_store_get_type() usize;
    pub const getGObjectType = gimp_unit_store_get_type;

    extern fn g_object_ref(p_self: *gimpui.UnitStore) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.UnitStore) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *UnitStore, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VectorLoadProcedureDialog = opaque {
    pub const Parent = gimpui.ProcedureDialog;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable };
    pub const Class = gimpui.VectorLoadProcedureDialogClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new dialog for `procedure` using widgets generated from
    /// properties of `config`.
    ///
    /// `file` must be the same vector file which was passed to the
    /// `gimp.RunVectorLoadFunc` implementation for your plug-in. If you pass any
    /// other file, then the preview may be wrong or not showing at all. And it is
    /// considered a programming error.
    ///
    /// As for all `gtk.Window`, the returned `gimpui.ProcedureDialog` object is
    /// owned by GTK and its initial reference is stored in an internal list
    /// of top-level windows. To delete the dialog, call
    /// `gtk.Widget.destroy`.
    extern fn gimp_vector_load_procedure_dialog_new(p_procedure: *gimp.VectorLoadProcedure, p_config: *gimp.ProcedureConfig, p_extracted_data: ?*gimp.VectorLoadData, p_file: ?*gio.File) *gimpui.VectorLoadProcedureDialog;
    pub const new = gimp_vector_load_procedure_dialog_new;

    extern fn gimp_vector_load_procedure_dialog_get_type() usize;
    pub const getGObjectType = gimp_vector_load_procedure_dialog_get_type;

    extern fn g_object_ref(p_self: *gimpui.VectorLoadProcedureDialog) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.VectorLoadProcedureDialog) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *VectorLoadProcedureDialog, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A model for zoom values.
pub const ZoomModel = opaque {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = gimpui.ZoomModelClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// The zoom factor expressed as a fraction.
        pub const fraction = struct {
            pub const name = "fraction";

            pub const Type = ?[*:0]u8;
        };

        /// The maximum zoom factor.
        pub const maximum = struct {
            pub const name = "maximum";

            pub const Type = f64;
        };

        /// The minimum zoom factor.
        pub const minimum = struct {
            pub const name = "minimum";

            pub const Type = f64;
        };

        /// The zoom factor expressed as percentage.
        pub const percentage = struct {
            pub const name = "percentage";

            pub const Type = ?[*:0]u8;
        };

        /// The zoom factor.
        pub const value = struct {
            pub const name = "value";

            pub const Type = f64;
        };
    };

    pub const signals = struct {
        /// Emitted when the zoom factor of the zoom model changes.
        pub const zoomed = struct {
            pub const name = "zoomed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_old_factor: f64, p_new_factor: f64, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(ZoomModel, p_instance))),
                    gobject.signalLookup("zoomed", ZoomModel.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Utility function to calculate a new scale factor.
    extern fn gimp_zoom_model_zoom_step(p_zoom_type: gimpui.ZoomType, p_scale: f64, p_delta: f64) f64;
    pub const zoomStep = gimp_zoom_model_zoom_step;

    /// Creates a new `gimpui.ZoomModel`.
    extern fn gimp_zoom_model_new() *gimpui.ZoomModel;
    pub const new = gimp_zoom_model_new;

    /// Retrieves the current zoom factor of `model`.
    extern fn gimp_zoom_model_get_factor(p_model: *ZoomModel) f64;
    pub const getFactor = gimp_zoom_model_get_factor;

    /// Retrieves the current zoom factor of `model` as a fraction.
    ///
    /// Since GIMP 2.4
    extern fn gimp_zoom_model_get_fraction(p_model: *ZoomModel, p_numerator: *c_int, p_denominator: *c_int) void;
    pub const getFraction = gimp_zoom_model_get_fraction;

    /// Sets the allowed range of the `model`.
    ///
    /// Since GIMP 2.4
    extern fn gimp_zoom_model_set_range(p_model: *ZoomModel, p_min: f64, p_max: f64) void;
    pub const setRange = gimp_zoom_model_set_range;

    /// Since GIMP 2.4
    extern fn gimp_zoom_model_zoom(p_model: *ZoomModel, p_zoom_type: gimpui.ZoomType, p_scale: f64) void;
    pub const zoom = gimp_zoom_model_zoom;

    extern fn gimp_zoom_model_get_type() usize;
    pub const getGObjectType = gimp_zoom_model_get_type;

    extern fn g_object_ref(p_self: *gimpui.ZoomModel) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ZoomModel) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ZoomModel, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A drawable preview with zooming capabilities.
pub const ZoomPreview = opaque {
    pub const Parent = gimpui.ScrolledPreview;
    pub const Implements = [_]type{ atk.ImplementorIface, gtk.Buildable, gtk.Orientable };
    pub const Class = gimpui.ZoomPreviewClass;
    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const drawable = struct {
            pub const name = "drawable";

            pub const Type = ?*gimp.Drawable;
        };

        /// The `gimpui.ZoomModel` used by this `gimpui.ZoomPreview`.
        pub const model = struct {
            pub const name = "model";

            pub const Type = ?*gimpui.ZoomModel;
        };
    };

    pub const signals = struct {};

    /// Creates a new `gimpui.ZoomPreview` widget for `drawable`.
    extern fn gimp_zoom_preview_new_from_drawable(p_drawable: *gimp.Drawable) *gimpui.ZoomPreview;
    pub const newFromDrawable = gimp_zoom_preview_new_from_drawable;

    /// Creates a new `gimpui.ZoomPreview` widget for `drawable` using the
    /// given `model`.
    ///
    /// This variant of `gimpui.ZoomPreview.newFromDrawable` allows you
    /// to create a preview using an existing zoom model. This may be
    /// useful if for example you want to have two zoom previews that keep
    /// their zoom factor in sync.
    extern fn gimp_zoom_preview_new_with_model_from_drawable(p_drawable: *gimp.Drawable, p_model: *gimpui.ZoomModel) *gimpui.ZoomPreview;
    pub const newWithModelFromDrawable = gimp_zoom_preview_new_with_model_from_drawable;

    /// Returns the drawable the `gimpui.ZoomPreview` is attached to.
    extern fn gimp_zoom_preview_get_drawable(p_preview: *ZoomPreview) *gimp.Drawable;
    pub const getDrawable = gimp_zoom_preview_get_drawable;

    /// Returns the zoom factor the preview is currently using.
    extern fn gimp_zoom_preview_get_factor(p_preview: *ZoomPreview) f64;
    pub const getFactor = gimp_zoom_preview_get_factor;

    /// Returns the `gimpui.ZoomModel` the preview is using.
    extern fn gimp_zoom_preview_get_model(p_preview: *ZoomPreview) *gimpui.ZoomModel;
    pub const getModel = gimp_zoom_preview_get_model;

    /// Returns the scaled image data of the part of the drawable the
    /// `gimpui.ZoomPreview` is currently showing, as a newly allocated array of guchar.
    /// This function also allow to get the current width, height and bpp of the
    /// `gimpui.ZoomPreview`.
    extern fn gimp_zoom_preview_get_source(p_preview: *ZoomPreview, p_width: *c_int, p_height: *c_int, p_bpp: *c_int) [*]u8;
    pub const getSource = gimp_zoom_preview_get_source;

    extern fn gimp_zoom_preview_get_type() usize;
    pub const getGObjectType = gimp_zoom_preview_get_type;

    extern fn g_object_ref(p_self: *gimpui.ZoomPreview) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *gimpui.ZoomPreview) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ZoomPreview, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const AspectPreviewClass = extern struct {
    pub const Instance = gimpui.AspectPreview;

    f_parent_class: gimpui.PreviewClass,

    pub fn as(p_instance: *AspectPreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BrowserClass = extern struct {
    pub const Instance = gimpui.Browser;

    f_parent_class: gtk.PanedClass,

    pub fn as(p_instance: *BrowserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BrushChooserClass = extern struct {
    pub const Instance = gimpui.BrushChooser;

    f_parent_class: gimpui.ResourceChooserClass,

    pub fn as(p_instance: *BrushChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const BusyBoxClass = extern struct {
    pub const Instance = gimpui.BusyBox;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *BusyBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ButtonClass = extern struct {
    pub const Instance = gimpui.Button;

    f_parent_class: gtk.ButtonClass,
    f_extended_clicked: ?*const fn (p_button: *gimpui.Button, p_modifier_state: gdk.ModifierType) callconv(.c) void,
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

    pub fn as(p_instance: *ButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CellRendererColorClass = extern struct {
    pub const Instance = gimpui.CellRendererColor;

    f_parent_class: gtk.CellRendererClass,

    pub fn as(p_instance: *CellRendererColorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const CellRendererToggleClass = extern struct {
    pub const Instance = gimpui.CellRendererToggle;

    f_parent_class: gtk.CellRendererToggleClass,

    pub fn as(p_instance: *CellRendererToggleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ChainButtonClass = extern struct {
    pub const Instance = gimpui.ChainButton;

    f_parent_class: gtk.GridClass,

    pub fn as(p_instance: *ChainButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorAreaClass = extern struct {
    pub const Instance = gimpui.ColorArea;

    f_parent_class: gtk.DrawingAreaClass,

    pub fn as(p_instance: *ColorAreaClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorButtonClass = extern struct {
    pub const Instance = gimpui.ColorButton;

    f_parent_class: gimpui.ButtonClass,
    f_color_changed: ?*const fn (p_button: *gimpui.ColorButton) callconv(.c) void,
    f_get_action_type: ?*const fn (p_button: *gimpui.ColorButton) callconv(.c) usize,
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

    pub fn as(p_instance: *ColorButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorDisplayClass = extern struct {
    pub const Instance = gimpui.ColorDisplay;

    f_parent_class: gobject.ObjectClass,
    f_name: ?[*:0]const u8,
    f_help_id: ?[*:0]const u8,
    f_icon_name: ?[*:0]const u8,
    f_convert_buffer: ?*const fn (p_display: *gimpui.ColorDisplay, p_buffer: *gegl.Buffer, p_area: *gegl.Rectangle) callconv(.c) void,
    f_configure: ?*const fn (p_display: *gimpui.ColorDisplay) callconv(.c) *gtk.Widget,
    f_changed: ?*const fn (p_display: *gimpui.ColorDisplay) callconv(.c) void,
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

    pub fn as(p_instance: *ColorDisplayClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorDisplayStackClass = extern struct {
    pub const Instance = gimpui.ColorDisplayStack;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ColorDisplayStackClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorHexEntryClass = extern struct {
    pub const Instance = gimpui.ColorHexEntry;

    f_parent_class: gtk.EntryClass,

    pub fn as(p_instance: *ColorHexEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorNotebookClass = extern struct {
    pub const Instance = gimpui.ColorNotebook;

    f_parent_class: gimpui.ColorSelectorClass,

    pub fn as(p_instance: *ColorNotebookClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorProfileChooserDialogClass = extern struct {
    pub const Instance = gimpui.ColorProfileChooserDialog;

    f_parent_class: gtk.FileChooserDialogClass,

    pub fn as(p_instance: *ColorProfileChooserDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorProfileComboBoxClass = extern struct {
    pub const Instance = gimpui.ColorProfileComboBox;

    f_parent_class: gtk.ComboBoxClass,

    pub fn as(p_instance: *ColorProfileComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorProfileStoreClass = extern struct {
    pub const Instance = gimpui.ColorProfileStore;

    f_parent_class: gtk.ListStoreClass,

    pub fn as(p_instance: *ColorProfileStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorProfileViewClass = extern struct {
    pub const Instance = gimpui.ColorProfileView;

    f_parent_class: gtk.TextViewClass,

    pub fn as(p_instance: *ColorProfileViewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorScaleClass = extern struct {
    pub const Instance = gimpui.ColorScale;

    f_parent_class: gtk.ScaleClass,

    pub fn as(p_instance: *ColorScaleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorScaleEntryClass = extern struct {
    pub const Instance = gimpui.ColorScaleEntry;

    f_parent_class: gimpui.ScaleEntryClass,

    pub fn as(p_instance: *ColorScaleEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorScales = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorSelect = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorSelectionClass = extern struct {
    pub const Instance = gimpui.ColorSelection;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *ColorSelectionClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ColorSelectorClass = extern struct {
    pub const Instance = gimpui.ColorSelector;

    f_parent_class: gtk.BoxClass,
    f_name: ?[*:0]const u8,
    f_help_id: ?[*:0]const u8,
    f_icon_name: ?[*:0]const u8,
    f_set_toggles_visible: ?*const fn (p_selector: *gimpui.ColorSelector, p_visible: c_int) callconv(.c) void,
    f_set_toggles_sensitive: ?*const fn (p_selector: *gimpui.ColorSelector, p_sensitive: c_int) callconv(.c) void,
    f_set_show_alpha: ?*const fn (p_selector: *gimpui.ColorSelector, p_show_alpha: c_int) callconv(.c) void,
    f_set_color: ?*const fn (p_selector: *gimpui.ColorSelector, p_color: *gegl.Color) callconv(.c) void,
    f_set_channel: ?*const fn (p_selector: *gimpui.ColorSelector, p_channel: gimpui.ColorSelectorChannel) callconv(.c) void,
    f_set_model_visible: ?*const fn (p_selector: *gimpui.ColorSelector, p_model: gimpui.ColorSelectorModel, p_visible: c_int) callconv(.c) void,
    f_set_config: ?*const fn (p_selector: *gimpui.ColorSelector, p_config: *gimp.ColorConfig) callconv(.c) void,
    f_set_format: ?*const fn (p_selector: *gimpui.ColorSelector, p_format: *const babl.Object) callconv(.c) void,
    f_set_simulation: ?*const fn (p_selector: *gimpui.ColorSelector, p_profile: *gimp.ColorProfile, p_intent: gimp.ColorRenderingIntent, p_bpc: c_int) callconv(.c) void,
    f_color_changed: ?*const fn (p_selector: *gimpui.ColorSelector, p_color: *gegl.Color) callconv(.c) void,
    f_channel_changed: ?*const fn (p_selector: *gimpui.ColorSelector, p_channel: gimpui.ColorSelectorChannel) callconv(.c) void,
    f_model_visible_changed: ?*const fn (p_selector: *gimpui.ColorSelector, p_model: gimpui.ColorSelectorModel, p_visible: c_int) callconv(.c) void,
    f_simulation: ?*const fn (p_selector: *gimpui.ColorSelector, p_enabled: c_int) callconv(.c) void,
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

    pub fn as(p_instance: *ColorSelectorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Controller = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DialogClass = extern struct {
    pub const Instance = gimpui.Dialog;

    f_parent_class: gtk.DialogClass,
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

    pub fn as(p_instance: *DialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawableChooserClass = extern struct {
    pub const Instance = gimpui.DrawableChooser;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *DrawableChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DrawablePreviewClass = extern struct {
    pub const Instance = gimpui.DrawablePreview;

    f_parent_class: gimpui.ScrolledPreviewClass,

    pub fn as(p_instance: *DrawablePreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EnumComboBoxClass = extern struct {
    pub const Instance = gimpui.EnumComboBox;

    f_parent_class: gimpui.IntComboBoxClass,
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

    pub fn as(p_instance: *EnumComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EnumLabelClass = extern struct {
    pub const Instance = gimpui.EnumLabel;

    f_parent_class: gtk.ScaleClass,

    pub fn as(p_instance: *EnumLabelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EnumStoreClass = extern struct {
    pub const Instance = gimpui.EnumStore;

    f_parent_class: gimpui.IntStoreClass,

    pub fn as(p_instance: *EnumStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ExportProcedureDialogClass = extern struct {
    pub const Instance = gimpui.ExportProcedureDialog;

    f_parent_class: gimpui.ProcedureDialogClass,

    pub fn as(p_instance: *ExportProcedureDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileChooserClass = extern struct {
    pub const Instance = gimpui.FileChooser;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *FileChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FileEntry = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FontChooserClass = extern struct {
    pub const Instance = gimpui.FontChooser;

    f_parent_class: gimpui.ResourceChooserClass,

    pub fn as(p_instance: *FontChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const FrameClass = extern struct {
    pub const Instance = gimpui.Frame;

    f_parent_class: gtk.FrameClass,
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

    pub fn as(p_instance: *FrameClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GradientChooserClass = extern struct {
    pub const Instance = gimpui.GradientChooser;

    f_parent_class: gimpui.ResourceChooserClass,

    pub fn as(p_instance: *GradientChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HintBoxClass = extern struct {
    pub const Instance = gimpui.HintBox;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *HintBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ImageComboBoxClass = extern struct {
    pub const Instance = gimpui.ImageComboBox;

    f_parent_class: gimpui.IntComboBoxClass,

    pub fn as(p_instance: *ImageComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IntComboBoxClass = extern struct {
    pub const Instance = gimpui.IntComboBox;

    f_parent_class: gtk.ComboBoxClass,
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

    pub fn as(p_instance: *IntComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IntRadioFrameClass = extern struct {
    pub const Instance = gimpui.IntRadioFrame;

    f_parent_class: gimpui.FrameClass,

    pub fn as(p_instance: *IntRadioFrameClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const IntStoreClass = extern struct {
    pub const Instance = gimpui.IntStore;

    f_parent_class: gtk.ListStoreClass,
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

    pub fn as(p_instance: *IntStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabelColorClass = extern struct {
    pub const Instance = gimpui.LabelColor;

    f_parent_class: gimpui.LabeledClass,

    pub fn as(p_instance: *LabelColorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabelEntryClass = extern struct {
    pub const Instance = gimpui.LabelEntry;

    f_parent_class: gimpui.LabeledClass,

    pub fn as(p_instance: *LabelEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabelIntWidgetClass = extern struct {
    pub const Instance = gimpui.LabelIntWidget;

    f_parent_class: gimpui.LabeledClass,

    pub fn as(p_instance: *LabelIntWidgetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabelSpinClass = extern struct {
    pub const Instance = gimpui.LabelSpin;

    f_parent_class: gimpui.LabeledClass,
    f_value_changed: ?*const fn (p_spin: *gimpui.LabelSpin) callconv(.c) void,
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

    pub fn as(p_instance: *LabelSpinClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabelStringWidgetClass = extern struct {
    pub const Instance = gimpui.LabelStringWidget;

    f_parent_class: gimpui.LabeledClass,

    pub fn as(p_instance: *LabelStringWidgetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const LabeledClass = extern struct {
    pub const Instance = gimpui.Labeled;

    f_parent_class: gtk.GridClass,
    f_mnemonic_widget_changed: ?*const fn (p_labeled: *gimpui.Labeled, p_widget: *gtk.Widget) callconv(.c) void,
    f_populate: ?*const fn (p_labeled: *gimpui.Labeled, p_x: *c_int, p_y: *c_int, p_width: *c_int, p_height: *c_int) callconv(.c) *gtk.Widget,
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

    pub fn as(p_instance: *LabeledClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MemsizeEntryClass = extern struct {
    pub const Instance = gimpui.MemsizeEntry;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *MemsizeEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NumberPairEntryClass = extern struct {
    pub const Instance = gimpui.NumberPairEntry;

    f_parent_class: gtk.EntryClass,

    pub fn as(p_instance: *NumberPairEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const OffsetAreaClass = extern struct {
    pub const Instance = gimpui.OffsetArea;

    f_parent_class: gtk.DrawingAreaClass,

    pub fn as(p_instance: *OffsetAreaClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PageSelectorClass = extern struct {
    pub const Instance = gimpui.PageSelector;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *PageSelectorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PaletteChooserClass = extern struct {
    pub const Instance = gimpui.PaletteChooser;

    f_parent_class: gimpui.ResourceChooserClass,

    pub fn as(p_instance: *PaletteChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PathEditorClass = extern struct {
    pub const Instance = gimpui.PathEditor;

    f_parent_class: gtk.BoxClass,

    pub fn as(p_instance: *PathEditorClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PatternChooserClass = extern struct {
    pub const Instance = gimpui.PatternChooser;

    f_parent_class: gimpui.ResourceChooserClass,

    pub fn as(p_instance: *PatternChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PickButtonClass = extern struct {
    pub const Instance = gimpui.PickButton;

    f_parent_class: gtk.ButtonClass,
    f_color_picked: ?*const fn (p_button: *gimpui.PickButton, p_color: *const gegl.Color) callconv(.c) void,
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

    pub fn as(p_instance: *PickButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewAreaClass = extern struct {
    pub const Instance = gimpui.PreviewArea;

    f_parent_class: gtk.DrawingAreaClass,

    pub fn as(p_instance: *PreviewAreaClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PreviewClass = extern struct {
    pub const Instance = gimpui.Preview;

    f_parent_class: gtk.BoxClass,
    f_draw: ?*const fn (p_preview: *gimpui.Preview) callconv(.c) void,
    f_draw_thumb: ?*const fn (p_preview: *gimpui.Preview, p_area: *gimpui.PreviewArea, p_width: c_int, p_height: c_int) callconv(.c) void,
    f_draw_buffer: ?*const fn (p_preview: *gimpui.Preview, p_buffer: [*]const u8, p_rowstride: c_int) callconv(.c) void,
    f_set_cursor: ?*const fn (p_preview: *gimpui.Preview) callconv(.c) void,
    f_transform: ?*const fn (p_preview: *gimpui.Preview, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) callconv(.c) void,
    f_untransform: ?*const fn (p_preview: *gimpui.Preview, p_src_x: c_int, p_src_y: c_int, p_dest_x: *c_int, p_dest_y: *c_int) callconv(.c) void,
    f_invalidated: ?*const fn (p_preview: *gimpui.Preview) callconv(.c) void,
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

    pub fn as(p_instance: *PreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcBrowserDialogClass = extern struct {
    pub const Instance = gimpui.ProcBrowserDialog;

    f_parent_class: gimpui.DialogClass,

    pub fn as(p_instance: *ProcBrowserDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProcedureDialogClass = extern struct {
    pub const Instance = gimpui.ProcedureDialog;

    f_parent_class: gimpui.DialogClass,
    f_fill_start: ?*const fn (p_dialog: *gimpui.ProcedureDialog, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) callconv(.c) void,
    f_fill_end: ?*const fn (p_dialog: *gimpui.ProcedureDialog, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig) callconv(.c) void,
    f_fill_list: ?*const fn (p_dialog: *gimpui.ProcedureDialog, p_procedure: *gimp.Procedure, p_config: *gimp.ProcedureConfig, p_properties: *glib.List) callconv(.c) void,
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

    pub fn as(p_instance: *ProcedureDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ProgressBarClass = extern struct {
    pub const Instance = gimpui.ProgressBar;

    f_parent_class: gtk.ProgressBarClass,

    pub fn as(p_instance: *ProgressBarClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ResourceChooserClass = extern struct {
    pub const Instance = gimpui.ResourceChooser;

    f_parent_class: gtk.BoxClass,
    f_resource_set: ?*const fn (p_chooser: *gimpui.ResourceChooser, p_resource: *gimp.Resource, p_dialog_closing: c_int) callconv(.c) void,
    f_draw_interior: ?*const fn (p_chooser: *gimpui.ResourceChooser) callconv(.c) void,
    f_resource_type: usize,
    f_padding: [8]*anyopaque,

    pub fn as(p_instance: *ResourceChooserClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RulerClass = extern struct {
    pub const Instance = gimpui.Ruler;

    f_parent_class: gtk.WidgetClass,

    pub fn as(p_instance: *RulerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ScaleEntryClass = extern struct {
    pub const Instance = gimpui.ScaleEntry;

    f_parent_class: gimpui.LabelSpinClass,
    f_new_range_widget: ?*const fn (p_adjustment: *gtk.Adjustment) callconv(.c) *gtk.Widget,
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

    pub fn as(p_instance: *ScaleEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ScrolledPreviewClass = extern struct {
    pub const Instance = gimpui.ScrolledPreview;

    f_parent_class: gimpui.PreviewClass,
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

    pub fn as(p_instance: *ScrolledPreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SizeEntryClass = extern struct {
    pub const Instance = gimpui.SizeEntry;

    f_parent_class: gtk.GridClass,

    pub fn as(p_instance: *SizeEntryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinButtonClass = extern struct {
    pub const Instance = gimpui.SpinButton;

    f_parent_class: gtk.SpinButtonClass,
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

    pub fn as(p_instance: *SpinButtonClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SpinScaleClass = extern struct {
    pub const Instance = gimpui.SpinScale;

    f_parent_class: gimpui.SpinButtonClass,

    pub fn as(p_instance: *SpinScaleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StringComboBoxClass = extern struct {
    pub const Instance = gimpui.StringComboBox;

    f_parent_class: gtk.ComboBoxClass,
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

    pub fn as(p_instance: *StringComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UnitComboBoxClass = extern struct {
    pub const Instance = gimpui.UnitComboBox;

    f_parent_class: gtk.ComboBoxClass,

    pub fn as(p_instance: *UnitComboBoxClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UnitStoreClass = extern struct {
    pub const Instance = gimpui.UnitStore;

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

    pub fn as(p_instance: *UnitStoreClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const VectorLoadProcedureDialogClass = extern struct {
    pub const Instance = gimpui.VectorLoadProcedureDialog;

    f_parent_class: gimpui.ProcedureDialogClass,

    pub fn as(p_instance: *VectorLoadProcedureDialogClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ZoomModelClass = extern struct {
    pub const Instance = gimpui.ZoomModel;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *ZoomModelClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ZoomPreviewClass = extern struct {
    pub const Instance = gimpui.ZoomPreview;

    f_parent_class: gimpui.ScrolledPreviewClass,

    pub fn as(p_instance: *ZoomPreviewClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Aspect ratios.
pub const AspectType = enum(c_int) {
    square = 0,
    portrait = 1,
    landscape = 2,
    _,

    extern fn gimp_aspect_type_get_type() usize;
    pub const getGObjectType = gimp_aspect_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible chain positions for `gimpui.ChainButton`.
pub const ChainPosition = enum(c_int) {
    top = 0,
    left = 1,
    bottom = 2,
    right = 3,
    _,

    extern fn gimp_chain_position_get_type() usize;
    pub const getGObjectType = gimp_chain_position_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The types of transparency display for `gimpui.ColorArea`.
pub const ColorAreaType = enum(c_int) {
    flat = 0,
    small_checks = 1,
    large_checks = 2,
    _,

    extern fn gimp_color_area_type_get_type() usize;
    pub const getGObjectType = gimp_color_area_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enum to specify the types of color channels edited in
/// `gimpui.ColorSelector` widgets.
pub const ColorSelectorChannel = enum(c_int) {
    hue = 0,
    saturation = 1,
    value = 2,
    red = 3,
    green = 4,
    blue = 5,
    alpha = 6,
    lch_lightness = 7,
    lch_chroma = 8,
    lch_hue = 9,
    _,

    extern fn gimp_color_selector_channel_get_type() usize;
    pub const getGObjectType = gimp_color_selector_channel_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An enum to specify the types of color spaces edited in
/// `gimpui.ColorSelector` widgets.
pub const ColorSelectorModel = enum(c_int) {
    rgb = 0,
    lch = 1,
    hsv = 2,
    _,

    extern fn gimp_color_selector_model_get_type() usize;
    pub const getGObjectType = gimp_color_selector_model_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Possible layouts for `gimpui.IntComboBox`.
pub const IntComboBoxLayout = enum(c_int) {
    icon_only = 0,
    abbreviated = 1,
    full = 2,
    _,

    extern fn gimp_int_combo_box_layout_get_type() usize;
    pub const getGObjectType = gimp_int_combo_box_layout_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The column types of `gimpui.IntStore`.
pub const IntStoreColumns = enum(c_int) {
    value = 0,
    label = 1,
    abbrev = 2,
    icon_name = 3,
    pixbuf = 4,
    user_data = 5,
    num_columns = 6,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Import targets for `gimpui.PageSelector`.
pub const PageSelectorTarget = enum(c_int) {
    layers = 0,
    images = 1,
    _,

    extern fn gimp_page_selector_target_get_type() usize;
    pub const getGObjectType = gimp_page_selector_target_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Update policies for `gimpui.SizeEntry`.
pub const SizeEntryUpdatePolicy = enum(c_int) {
    none = 0,
    size = 1,
    resolution = 2,
    _,

    extern fn gimp_size_entry_update_policy_get_type() usize;
    pub const getGObjectType = gimp_size_entry_update_policy_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Types of errors returned by libgimpwidgets functions
pub const WidgetsError = enum(c_int) {
    widgets_parse_error = 0,
    _,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// the zoom types for `gimpui.ZoomModel`.
pub const ZoomType = enum(c_int) {
    in = 0,
    out = 1,
    _,

    extern fn gimp_zoom_type_get_type() usize;
    pub const getGObjectType = gimp_zoom_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Sets color and dash pattern for stroking a focus line on the given
/// `cr`. The line pattern is taken from `widget`.
extern fn gimp_cairo_set_focus_line_pattern(p_cr: *cairo.Context, p_widget: *gtk.Widget) c_int;
pub const cairoSetFocusLinePattern = gimp_cairo_set_focus_line_pattern;

/// Sets `color` as the source pattern within `cr`, taking into account the profile
/// of the `gdk.Monitor` which `widget` is displayed on.
///
/// If `config` is set, the color configuration as set by the user will be used,
/// in particular using any custom monitor profile set in preferences (overriding
/// system-set profile). If no such custom profile is set, it will use the
/// profile of the monitor `widget` is displayed on and will default to sRGB if
/// `widget` is `NULL`.
///
/// Use `gimp.getColorConfiguration` to retrieve the user
/// `gimp.ColorConfig`.
///
/// TODO: `softproof` is currently unused.
extern fn gimp_cairo_set_source_color(p_cr: *cairo.Context, p_color: *gegl.Color, p_config: *gimp.ColorConfig, p_softproof: c_int, p_widget: ?*gtk.Widget) void;
pub const cairoSetSourceColor = gimp_cairo_set_source_color;

/// Create a Cairo image surface from a GdkPixbuf.
///
/// You should avoid calling this function as there are probably more
/// efficient ways of achieving the result you are looking for.
extern fn gimp_cairo_surface_create_from_pixbuf(p_pixbuf: *gdkpixbuf.Pixbuf) *cairo.Surface;
pub const cairoSurfaceCreateFromPixbuf = gimp_cairo_surface_create_from_pixbuf;

/// This function invokes the context help inspector.
///
/// The mouse cursor will turn turn into a question mark and the user can
/// click on any widget of the application which started the inspector.
///
/// If the widget the user clicked on has a `help_id` string attached
/// (see `gimpui.helpSetHelpData`), the corresponding help page will
/// be displayed. Otherwise the help system will ascend the widget hierarchy
/// until it finds an attached `help_id` string (which should be the
/// case at least for every window/dialog).
extern fn gimp_context_help(p_widget: *gtk.Widget) void;
pub const contextHelp = gimp_context_help;

/// Convenience function that creates a `gimpui.SizeEntry` with two fields for x/y
/// coordinates/sizes with a `gimpui.ChainButton` attached to constrain either the
/// two fields' values or the ratio between them.
extern fn gimp_coordinates_new(p_unit: *gimp.Unit, p_unit_format: [*:0]const u8, p_menu_show_pixels: c_int, p_menu_show_percent: c_int, p_spinbutton_width: c_int, p_update_policy: gimpui.SizeEntryUpdatePolicy, p_chainbutton_active: c_int, p_chain_constrains_ratio: c_int, p_xlabel: [*:0]const u8, p_x: f64, p_xres: f64, p_lower_boundary_x: f64, p_upper_boundary_x: f64, p_xsize_0: f64, p_xsize_100: f64, p_ylabel: [*:0]const u8, p_y: f64, p_yres: f64, p_lower_boundary_y: f64, p_upper_boundary_y: f64, p_ysize_0: f64, p_ysize_100: f64) *gtk.Widget;
pub const coordinatesNew = gimp_coordinates_new;

/// This function is for internal use only.
extern fn gimp_dialogs_show_help_button(p_show: c_int) void;
pub const dialogsShowHelpButton = gimp_dialogs_show_help_button;

extern fn gimp_double_adjustment_update(p_adjustment: *gtk.Adjustment, p_data: *f64) void;
pub const doubleAdjustmentUpdate = gimp_double_adjustment_update;

/// Creates a horizontal box of radio buttons with named icons. The
/// icon name for each icon is created by appending the enum_value's
/// nick to the given `icon_prefix`.
extern fn gimp_enum_icon_box_new(p_enum_type: usize, p_icon_prefix: [*:0]const u8, p_icon_size: gtk.IconSize, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumIconBoxNew = gimp_enum_icon_box_new;

/// Just like `gimpui.enumIconBoxNew`, this function creates a group
/// of radio buttons, but additionally it supports limiting the range
/// of available enum values.
extern fn gimp_enum_icon_box_new_with_range(p_enum_type: usize, p_minimum: c_int, p_maximum: c_int, p_icon_prefix: [*:0]const u8, p_icon_size: gtk.IconSize, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumIconBoxNewWithRange = gimp_enum_icon_box_new_with_range;

/// Sets the padding of all buttons in a box created by
/// `gimpui.enumIconBoxNew`.
extern fn gimp_enum_icon_box_set_child_padding(p_icon_box: *gtk.Widget, p_xpad: c_int, p_ypad: c_int) void;
pub const enumIconBoxSetChildPadding = gimp_enum_icon_box_set_child_padding;

/// Sets the icon size of all buttons in a box created by
/// `gimpui.enumIconBoxNew`.
extern fn gimp_enum_icon_box_set_icon_size(p_icon_box: *gtk.Widget, p_icon_size: gtk.IconSize) void;
pub const enumIconBoxSetIconSize = gimp_enum_icon_box_set_icon_size;

/// Creates a new group of `GtkRadioButtons` representing the enum
/// values.  A group of radiobuttons is a good way to represent enums
/// with up to three or four values. Often it is better to use a
/// `gimpui.EnumComboBox` instead.
extern fn gimp_enum_radio_box_new(p_enum_type: usize, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumRadioBoxNew = gimp_enum_radio_box_new;

/// Just like `gimpui.enumRadioBoxNew`, this function creates a group
/// of radio buttons, but additionally it supports limiting the range
/// of available enum values.
extern fn gimp_enum_radio_box_new_with_range(p_enum_type: usize, p_minimum: c_int, p_maximum: c_int, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumRadioBoxNewWithRange = gimp_enum_radio_box_new_with_range;

/// Calls `gimpui.enumRadioBoxNew` and puts the resulting vbox into a
/// `gtk.Frame`.
extern fn gimp_enum_radio_frame_new(p_enum_type: usize, p_label_widget: ?*gtk.Widget, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumRadioFrameNew = gimp_enum_radio_frame_new;

/// Calls `gimpui.enumRadioBoxNewWithRange` and puts the resulting
/// vertical box into a `gtk.Frame`.
extern fn gimp_enum_radio_frame_new_with_range(p_enum_type: usize, p_minimum: c_int, p_maximum: c_int, p_label_widget: ?*gtk.Widget, p_callback: ?gobject.Callback, p_callback_data: ?*anyopaque, p_callback_data_destroy: ?glib.DestroyNotify, p_first_button: ?**gtk.Widget) *gtk.Widget;
pub const enumRadioFrameNewWithRange = gimp_enum_radio_frame_new_with_range;

/// Alternative of `gdk.Event.triggersContextMenu` with the additional
/// feature of allowing a menu triggering to happen on a button release
/// event. All the other rules on whether `event` should trigger a
/// contextual menu are exactly the same. Only the swapping to release
/// state as additional feature is different.
extern fn gimp_event_triggers_context_menu(p_event: *const gdk.Event, p_on_release: c_int) c_int;
pub const eventTriggersContextMenu = gimp_event_triggers_context_menu;

extern fn gimp_float_adjustment_update(p_adjustment: *gtk.Adjustment, p_data: *f32) void;
pub const floatAdjustmentUpdate = gimp_float_adjustment_update;

extern fn gimp_get_monitor_at_pointer() *gdk.Monitor;
pub const getMonitorAtPointer = gimp_get_monitor_at_pointer;

/// Note that the `label_text` can be `NULL` and that the widget will be
/// attached starting at (`column` + 1) in this case, too.
extern fn gimp_grid_attach_aligned(p_grid: *gtk.Grid, p_left: c_int, p_top: c_int, p_label_text: [*:0]const u8, p_label_xalign: f32, p_label_yalign: f32, p_widget: *gtk.Widget, p_widget_columns: c_int) *gtk.Widget;
pub const gridAttachAligned = gimp_grid_attach_aligned;

/// Note that this function is automatically called by all libgimp dialog
/// constructors. You only have to call it for windows/dialogs you created
/// "manually".
///
/// Most of the time, what you want to call for non-windows widgets is
/// simply `gimpui.helpSetHelpData`. Yet if you need to set up an
/// `help_func`, call `gimp_help_connect` instead. Note that `gimp_help_set_help_data`
/// is implied, so you don't have to call it too.
extern fn gimp_help_connect(p_widget: *gtk.Widget, p_tooltip: ?[*:0]const u8, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_help_data: ?*anyopaque, p_help_data_destroy: ?glib.DestroyNotify) void;
pub const helpConnect = gimp_help_connect;

/// This function returns the `glib.Quark` which should be used as key when
/// attaching help IDs to widgets and objects.
extern fn gimp_help_id_quark() glib.Quark;
pub const helpIdQuark = gimp_help_id_quark;

/// The reason why we don't use `gtk.Widget.setTooltipText` is that
/// elements in the GIMP user interface should, if possible, also have
/// a `help_id` set for context-sensitive help.
///
/// This function can be called with `NULL` for `tooltip`. Use this feature
/// if you want to set a help link for a widget which shouldn't have
/// a visible tooltip.
extern fn gimp_help_set_help_data(p_widget: *gtk.Widget, p_tooltip: ?[*:0]const u8, p_help_id: [*:0]const u8) void;
pub const helpSetHelpData = gimp_help_set_help_data;

/// Just like `gimpui.helpSetHelpData`, but supports to pass text
/// which is marked up with <link linkend="PangoMarkupFormat">Pango
/// text markup language</link>.
extern fn gimp_help_set_help_data_with_markup(p_widget: *gtk.Widget, p_tooltip: [*:0]const u8, p_help_id: [*:0]const u8) void;
pub const helpSetHelpDataWithMarkup = gimp_help_set_help_data_with_markup;

/// Initializes the GIMP stock icon factory.
///
/// You don't need to call this function as `gimpui.init` already does
/// this for you.
extern fn gimp_icons_init() void;
pub const iconsInit = gimp_icons_init;

extern fn gimp_icons_set_icon_theme(p_path: *gio.File) c_int;
pub const iconsSetIconTheme = gimp_icons_set_icon_theme;

/// This function initializes GTK+ with `gtk.init`.
/// It also initializes Gegl and Babl.
///
/// It also sets up various other things so that the plug-in user looks
/// and behaves like the GIMP core. This includes selecting the GTK+
/// theme and setting up the help system as chosen in the GIMP
/// preferences. Any plug-in that provides a user interface should call
/// this function.
///
/// It can safely be called more than once.
/// Calls after the first return quickly with no effect.
extern fn gimp_ui_init(p_prog_name: [*:0]const u8) void;
pub const init = gimp_ui_init;

/// Note that the `gtk.Adjustment`'s value (which is a `gdouble`) will be
/// rounded with `RINT`.
extern fn gimp_int_adjustment_update(p_adjustment: *gtk.Adjustment, p_data: *c_int) void;
pub const intAdjustmentUpdate = gimp_int_adjustment_update;

/// Convenience function to create a group of radio buttons embedded into
/// a `gtk.Frame` or `gtk.Box`. This function does the same thing as
/// `gimp_radio_group_new2`, but it takes integers as `item_data` instead of
/// pointers, since that is a very common case (mapping an enum to a radio
/// group).
extern fn gimp_int_radio_group_new(p_in_frame: c_int, p_frame_title: ?[*:0]const u8, p_radio_button_callback: gobject.Callback, p_radio_button_callback_data: ?*anyopaque, p_radio_button_callback_destroy: ?glib.DestroyNotify, p_initial: c_int, ...) *gtk.Widget;
pub const intRadioGroupNew = gimp_int_radio_group_new;

/// Calls `gtk.ToggleButton.setActive` with the radio button that was created
/// with a matching `item_data`. This function does the same thing as
/// `gimp_radio_group_set_active`, but takes integers as `item_data` instead
/// of pointers.
extern fn gimp_int_radio_group_set_active(p_radio_button: *gtk.RadioButton, p_item_data: c_int) void;
pub const intRadioGroupSetActive = gimp_int_radio_group_set_active;

/// Sets Pango attributes on a `gtk.Label` in a more convenient way than
/// `gtk.Label.setAttributes`.
///
/// This function is useful if you want to change the font attributes
/// of a `gtk.Label`. This is an alternative to using PangoMarkup which
/// is slow to parse and awkward to handle in an i18n-friendly way.
///
/// The attributes are set on the complete label, from start to end. If
/// you need to set attributes on part of the label, you will have to
/// use the PangoAttributes API directly.
extern fn gimp_label_set_attributes(p_label: *gtk.Label, ...) void;
pub const labelSetAttributes = gimp_label_set_attributes;

/// This function returns the `gimp.ColorProfile` of `monitor`
/// or `NULL` if there is no profile configured.
extern fn gimp_monitor_get_color_profile(p_monitor: *gdk.Monitor) ?*gimp.ColorProfile;
pub const monitorGetColorProfile = gimp_monitor_get_color_profile;

extern fn gimp_proc_view_new(p_procedure_name: [*:0]const u8) *gtk.Widget;
pub const procViewNew = gimp_proc_view_new;

/// Creates a `gtk.ComboBox` widget to display and set the specified
/// boolean property.  The combo box will have two entries, one
/// displaying the `true_text` label, the other displaying the
/// `false_text` label.
extern fn gimp_prop_boolean_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_true_text: [*:0]const u8, p_false_text: [*:0]const u8) *gtk.Widget;
pub const propBooleanComboBoxNew = gimp_prop_boolean_combo_box_new;

/// Creates a pair of radio buttons which function to set and display
/// the specified boolean property.
/// If `title` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned frame.
extern fn gimp_prop_boolean_radio_frame_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_title: ?[*:0]const u8, p_true_text: [*:0]const u8, p_false_text: [*:0]const u8) *gtk.Widget;
pub const propBooleanRadioFrameNew = gimp_prop_boolean_radio_frame_new;

/// Creates a `gimpui.BrushChooser` controlled by the specified property.
extern fn gimp_prop_brush_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propBrushChooserNew = gimp_prop_brush_chooser_new;

/// Creates a `gtk.CheckButton` that displays and sets the specified
/// boolean property.
/// If `label` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned button.
extern fn gimp_prop_check_button_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: ?[*:0]const u8) *gtk.Widget;
pub const propCheckButtonNew = gimp_prop_check_button_new;

/// Creates a `gimpui.StringComboBox` widget to display and set the
/// specified property.
extern fn gimp_prop_choice_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propChoiceComboBoxNew = gimp_prop_choice_combo_box_new;

/// Creates a `gimpui.IntRadioFrame` widget to display and set the
/// specified `gimp.Choice` property.
extern fn gimp_prop_choice_radio_frame_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propChoiceRadioFrameNew = gimp_prop_choice_radio_frame_new;

/// Creates a `gimpui.ColorArea` to set and display the value of an RGB
/// property.
extern fn gimp_prop_color_area_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_width: c_int, p_height: c_int, p_type: gimpui.ColorAreaType) *gtk.Widget;
pub const propColorAreaNew = gimp_prop_color_area_new;

/// Creates a `gimpui.ColorButton` to set and display the value of a color
/// property.
extern fn gimp_prop_color_select_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_width: c_int, p_height: c_int, p_type: gimpui.ColorAreaType) *gtk.Widget;
pub const propColorSelectNew = gimp_prop_color_select_new;

extern fn gimp_prop_coordinates_connect(p_config: *gobject.Object, p_x_property_name: [*:0]const u8, p_y_property_name: [*:0]const u8, p_unit_property_name: [*:0]const u8, p_sizeentry: *gtk.Widget, p_chainbutton: *gtk.Widget, p_xresolution: f64, p_yresolution: f64) c_int;
pub const propCoordinatesConnect = gimp_prop_coordinates_connect;

/// Creates a `gimpui.SizeEntry` to set and display two double or int
/// properties, which will usually represent X and Y coordinates, and
/// their associated unit property.
extern fn gimp_prop_coordinates_new(p_config: *gobject.Object, p_x_property_name: [*:0]const u8, p_y_property_name: [*:0]const u8, p_unit_property_name: [*:0]const u8, p_unit_format: [*:0]const u8, p_update_policy: gimpui.SizeEntryUpdatePolicy, p_xresolution: f64, p_yresolution: f64, p_has_chainbutton: c_int) *gtk.Widget;
pub const propCoordinatesNew = gimp_prop_coordinates_new;

/// Creates a `gimpui.DrawableChooser` controlled by the specified property.
extern fn gimp_prop_drawable_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propDrawableChooserNew = gimp_prop_drawable_chooser_new;

/// Creates a `gtk.Entry` to set and display the value of the specified
/// string property.
extern fn gimp_prop_entry_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_max_len: c_int) *gtk.Widget;
pub const propEntryNew = gimp_prop_entry_new;

/// Creates a `gtk.CheckButton` that displays and sets the specified
/// property of type Enum.  Note that this widget only allows two values
/// for the enum, one corresponding to the "checked" state and the
/// other to the "unchecked" state.
/// If `label` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned button.
extern fn gimp_prop_enum_check_button_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: ?[*:0]const u8, p_false_value: c_int, p_true_value: c_int) *gtk.Widget;
pub const propEnumCheckButtonNew = gimp_prop_enum_check_button_new;

/// Creates a `gimpui.IntComboBox` widget to display and set the specified
/// enum property.  The `mimimum_value` and `maximum_value` give the
/// possibility of restricting the allowed range to a subset of the
/// enum.  If the two values are equal (e.g., 0, 0), then the full
/// range of the Enum is used.
extern fn gimp_prop_enum_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_minimum: c_int, p_maximum: c_int) *gtk.Widget;
pub const propEnumComboBoxNew = gimp_prop_enum_combo_box_new;

/// Creates a horizontal box of radio buttons with named icons, which
/// function to set and display the value of the specified Enum
/// property.  The icon name for each icon is created by appending the
/// enum_value's nick to the given `icon_prefix`.  See
/// `gimpui.enumIconBoxNew` for more information.
extern fn gimp_prop_enum_icon_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_icon_prefix: [*:0]const u8, p_minimum: c_int, p_maximum: c_int) *gtk.Widget;
pub const propEnumIconBoxNew = gimp_prop_enum_icon_box_new;

extern fn gimp_prop_enum_label_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propEnumLabelNew = gimp_prop_enum_label_new;

/// Creates a group of radio buttons which function to set and display
/// the specified enum property.  The `minimum` and `maximum` arguments
/// allow only a subset of the enum to be used.  If the two arguments
/// are equal (e.g., 0, 0), then the full range of the enum will be used.
/// If you want to assign a label to the group of radio buttons, use
/// `gimpui.propEnumRadioFrameNew` instead of this function.
extern fn gimp_prop_enum_radio_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_minimum: c_int, p_maximum: c_int) *gtk.Widget;
pub const propEnumRadioBoxNew = gimp_prop_enum_radio_box_new;

/// Creates a group of radio buttons which function to set and display
/// the specified enum property.  The `minimum` and `maximum` arguments
/// allow only a subset of the enum to be used.  If the two arguments
/// are equal (e.g., 0, 0), then the full range of the enum will be used.
/// If `title` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned frame.
extern fn gimp_prop_enum_radio_frame_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_title: ?[*:0]const u8, p_minimum: c_int, p_maximum: c_int) *gtk.Widget;
pub const propEnumRadioFrameNew = gimp_prop_enum_radio_frame_new;

/// Creates a `gtk.Expander` controlled by the specified boolean property.
/// A value of `TRUE` for the property corresponds to the expanded state
/// for the widget.
/// If `label` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned widget.
extern fn gimp_prop_expander_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: ?[*:0]const u8) *gtk.Widget;
pub const propExpanderNew = gimp_prop_expander_new;

/// Creates a `gtk.FileChooserButton` to edit the specified path property.
/// `property_name` must represent either a GIMP_PARAM_SPEC_CONFIG_PATH or
/// a G_PARAM_SPEC_OBJECT where `value_type == G_TYPE_FILE`.
///
/// Note that `gtk.FileChooserButton` implements the `gtk.FileChooser`
/// interface; you can use the `gtk.FileChooser` API with it.
extern fn gimp_prop_file_chooser_button_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_title: ?[*:0]const u8, p_action: gtk.FileChooserAction) *gtk.Widget;
pub const propFileChooserButtonNew = gimp_prop_file_chooser_button_new;

/// Creates a `gtk.FileChooserButton` to edit the specified path property.
///
/// The button uses `dialog` as it's file-picking window. Note that `dialog`
/// must be a `gtk.FileChooserDialog` (or subclass) and must not have
/// `GTK_DIALOG_DESTROY_WITH_PARENT` set.
///
/// Note that `gtk.FileChooserButton` implements the `gtk.FileChooser`
/// interface; you can use the `gtk.FileChooser` API with it.
extern fn gimp_prop_file_chooser_button_new_with_dialog(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_dialog: *gtk.Widget) *gtk.Widget;
pub const propFileChooserButtonNewWithDialog = gimp_prop_file_chooser_button_new_with_dialog;

/// Creates a `gimpui.FileChooser` to edit the specified file
/// property. `property_name` must be a `GimpParamSpecFile` with an action
/// other than `gimp.@"FileChooserAction.ANY"`.
///
/// If `label` is `NULL`, `property_name`'s `nick` text will be used
/// instead.
extern fn gimp_prop_file_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: ?[*:0]const u8, p_title: ?[*:0]const u8) *gtk.Widget;
pub const propFileChooserNew = gimp_prop_file_chooser_new;

/// Creates a `gimpui.FontChooser` controlled by the specified property.
extern fn gimp_prop_font_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propFontChooserNew = gimp_prop_font_chooser_new;

/// Creates a `gimpui.GradientChooser` controlled by the specified property.
extern fn gimp_prop_gradient_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propGradientChooserNew = gimp_prop_gradient_chooser_new;

/// Creates a horizontal scale to control the value of the specified
/// integer or double property.
extern fn gimp_prop_hscale_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_step_increment: f64, p_page_increment: f64, p_digits: c_int) *gtk.Widget;
pub const propHscaleNew = gimp_prop_hscale_new;

/// Creates a widget to display a icon image representing the value of the
/// specified string property, which should encode an icon name.
/// See `gtk.Image.newFromIconName` for more information.
extern fn gimp_prop_icon_image_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_icon_size: gtk.IconSize) *gtk.Widget;
pub const propIconImageNew = gimp_prop_icon_image_new;

/// Creates a `gimpui.IntComboBox` widget to display and set the specified
/// property.  The contents of the widget are determined by `store`,
/// which should be created using `gimpui.IntStore.new`.
extern fn gimp_prop_int_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_store: *gimpui.IntStore) *gtk.Widget;
pub const propIntComboBoxNew = gimp_prop_int_combo_box_new;

/// Creates a group of radio buttons which function to set and display
/// the specified int property. If `title` is `NULL`, the
/// `property_name`'s nick will be used as label of the returned frame.
extern fn gimp_prop_int_radio_frame_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_title: ?[*:0]const u8, p_store: *gimpui.IntStore) *gtk.Widget;
pub const propIntRadioFrameNew = gimp_prop_int_radio_frame_new;

/// Creates a `gimpui.LabelColor` to set and display the value of an RGB
/// property.
extern fn gimp_prop_label_color_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_editable: c_int) *gtk.Widget;
pub const propLabelColorNew = gimp_prop_label_color_new;

/// Creates a `gimpui.LabelEntry` to set and display the value of the
/// specified string property.
extern fn gimp_prop_label_entry_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_max_len: c_int) *gtk.Widget;
pub const propLabelEntryNew = gimp_prop_label_entry_new;

/// Creates a `gtk.Label` to display the value of the specified property.
/// The property should be a string property or at least transformable
/// to a string.  If the user should be able to edit the string, use
/// `gimpui.propEntryNew` instead.
extern fn gimp_prop_label_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propLabelNew = gimp_prop_label_new;

/// Creates a `gimpui.LabelSpin` to set and display the value of the
/// specified double property.
extern fn gimp_prop_label_spin_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_digits: c_int) *gtk.Widget;
pub const propLabelSpinNew = gimp_prop_label_spin_new;

/// Creates a `gimpui.MemsizeEntry` (spin button and option menu) to set
/// and display the value of the specified memsize property.  See
/// `gimpui.MemsizeEntry.new` for more information.
extern fn gimp_prop_memsize_entry_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propMemsizeEntryNew = gimp_prop_memsize_entry_new;

/// Creates a `gimpui.PaletteChooser` controlled by the specified property.
extern fn gimp_prop_palette_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propPaletteChooserNew = gimp_prop_palette_chooser_new;

/// Creates a `gimpui.PathEditor` to edit the specified path and writable
/// path properties.
extern fn gimp_prop_path_editor_new(p_config: *gobject.Object, p_path_property_name: [*:0]const u8, p_writable_property_name: [*:0]const u8, p_filechooser_title: [*:0]const u8) *gtk.Widget;
pub const propPathEditorNew = gimp_prop_path_editor_new;

/// Creates a `gimpui.PatternChooser` controlled by the specified property.
extern fn gimp_prop_pattern_chooser_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_chooser_title: ?[*:0]const u8) *gtk.Widget;
pub const propPatternChooserNew = gimp_prop_pattern_chooser_new;

/// Creates a `gimpui.IntComboBox` widget to display and set the specified
/// property.  The contents of the widget are determined by `store`,
/// which should be created using `gimpui.IntStore.new`.
/// Values are GType/gpointer data, and therefore must be stored in the
/// "user-data" column, instead of the usual "value" column.
extern fn gimp_prop_pointer_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_store: *gimpui.IntStore) *gtk.Widget;
pub const propPointerComboBoxNew = gimp_prop_pointer_combo_box_new;

/// Creates a `gimpui.ScaleEntry` (slider and spin button) to set and display
/// the value of a specified int or double property with sensible default
/// settings depending on the range (decimal places, increments, etc.).
/// These settings can be overridden by the relevant widget methods.
///
/// If `label` is `NULL`, the `property_name`'s nick will be used as label
/// of the returned object.
///
/// If `factor` is not 1.0, the widget's range will be computed based of
/// `property_name`'s range multiplied by `factor`. A typical usage would
/// be to display a [0.0, 1.0] range as [0.0, 100.0] by setting 100.0 as
/// `factor`.
///
/// See `gimpui.ScaleEntry.setBounds` for more information on
/// `limit_scale`, `lower_limit` and `upper_limit`.
extern fn gimp_prop_scale_entry_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: ?[*:0]const u8, p_factor: f64, p_limit_scale: c_int, p_lower_limit: f64, p_upper_limit: f64) *gtk.Widget;
pub const propScaleEntryNew = gimp_prop_scale_entry_new;

/// Creates a `gimpui.SizeEntry` to set and display the specified double or
/// int property, and its associated unit property.  Note that this
/// function is only suitable for creating a size entry holding a
/// single value.  Use `gimpui.propCoordinatesNew` to create a size
/// entry holding two values.
extern fn gimp_prop_size_entry_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_property_is_pixel: c_int, p_unit_property_name: [*:0]const u8, p_unit_format: [*:0]const u8, p_update_policy: gimpui.SizeEntryUpdatePolicy, p_resolution: f64) *gtk.Widget;
pub const propSizeEntryNew = gimp_prop_size_entry_new;

/// Creates a spin button to set and display the value of the
/// specified double property.
///
/// If you wish to change the widget's range relatively to the
/// `property_name`'s range, use `gimpui.propWidgetSetFactor`.
extern fn gimp_prop_spin_button_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_step_increment: f64, p_page_increment: f64, p_digits: c_int) *gtk.Widget;
pub const propSpinButtonNew = gimp_prop_spin_button_new;

/// Creates a spin scale to set and display the value of the specified
/// int or double property.
///
/// By default, the `property_name`'s nick will be used as label of the
/// returned widget. Use `gimpui.SpinScale.setLabel` to change this.
///
/// If you wish to change the widget's range relatively to the
/// `property_name`'s range, use `gimpui.propWidgetSetFactor`.
extern fn gimp_prop_spin_scale_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_step_increment: f64, p_page_increment: f64, p_digits: c_int) *gtk.Widget;
pub const propSpinScaleNew = gimp_prop_spin_scale_new;

/// Creates a `gimpui.StringComboBox` widget to display and set the
/// specified property.  The contents of the widget are determined by
/// `store`.
extern fn gimp_prop_string_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_model: *gtk.TreeModel, p_id_column: c_int, p_label_column: c_int) *gtk.Widget;
pub const propStringComboBoxNew = gimp_prop_string_combo_box_new;

/// Creates a `gtk.Box` with a switch and a label that displays and sets the
/// specified boolean property.
/// If `label` is `NULL`, the `property_name`'s nick will be used as label.
extern fn gimp_prop_switch_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_label: [*:0]const u8, p_label_out: ?**gtk.Widget, p_switch_out: ?**gtk.Widget) *gtk.Widget;
pub const propSwitchNew = gimp_prop_switch_new;

/// Creates a `gtk.TextBuffer` to set and display the value of the
/// specified string property.  Unless the string is expected to
/// contain multiple lines or a large amount of text, use
/// `gimpui.propEntryNew` instead.  See `gtk.TextView` for information on
/// how to insert a text buffer into a visible widget.
///
/// If `max_len` is 0 or negative, the text buffer allows an unlimited
/// number of characters to be entered.
extern fn gimp_prop_text_buffer_new(p_config: *gobject.Object, p_property_name: [*:0]const u8, p_max_len: c_int) *gtk.TextBuffer;
pub const propTextBufferNew = gimp_prop_text_buffer_new;

/// Creates a `gimpui.UnitComboBox` to set and display the value of a Unit
/// property.  See `gimpui.UnitComboBox.new` for more information.
extern fn gimp_prop_unit_combo_box_new(p_config: *gobject.Object, p_property_name: [*:0]const u8) *gtk.Widget;
pub const propUnitComboBoxNew = gimp_prop_unit_combo_box_new;

/// Change the display factor of the property `widget` relatively to the
/// property it was bound to. Currently the only types of widget accepted
/// as input are those created by `gimpui.propSpinScaleNew` and
/// `gimpui.propSpinButtonNew`.
///
/// If `factor` is 1.0, then the config property and the widget display
/// map exactly.
///
/// If `factor` is not 1.0, the widget's range will be computed based of
/// `property_name`'s range multiplied by `factor`. A typical usage would
/// be to display a [0.0, 1.0] range as [0.0, 100.0] by setting 100.0 as
/// `factor`. This function can only be used with double properties.
///
/// The `step_increment` and `page_increment` can be set to new increments
/// you want to get for this new range. If you set them to 0.0 or
/// negative values, new increments will be computed based on the new
/// `factor` and previous factor.
extern fn gimp_prop_widget_set_factor(p_widget: *gtk.Widget, p_factor: f64, p_step_increment: f64, p_page_increment: f64, p_digits: c_int) void;
pub const propWidgetSetFactor = gimp_prop_widget_set_factor;

/// Creates a new `gtk.Dialog` that asks the user to do a boolean decision.
extern fn gimp_query_boolean_box(p_title: [*:0]const u8, p_parent: *gtk.Widget, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_icon_name: [*:0]const u8, p_message: [*:0]const u8, p_true_button: [*:0]const u8, p_false_button: [*:0]const u8, p_object: *gobject.Object, p_signal: [*:0]const u8, p_callback: gimpui.QueryBooleanCallback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gtk.Widget;
pub const queryBooleanBox = gimp_query_boolean_box;

/// Creates a new `gtk.Dialog` that queries the user for a double value.
extern fn gimp_query_double_box(p_title: [*:0]const u8, p_parent: *gtk.Widget, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_message: [*:0]const u8, p_initial: f64, p_lower: f64, p_upper: f64, p_digits: c_int, p_object: *gobject.Object, p_signal: [*:0]const u8, p_callback: gimpui.QueryDoubleCallback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gtk.Widget;
pub const queryDoubleBox = gimp_query_double_box;

/// Creates a new `gtk.Dialog` that queries the user for an integer value.
extern fn gimp_query_int_box(p_title: [*:0]const u8, p_parent: *gtk.Widget, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_message: [*:0]const u8, p_initial: c_int, p_lower: c_int, p_upper: c_int, p_object: *gobject.Object, p_signal: [*:0]const u8, p_callback: gimpui.QueryIntCallback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gtk.Widget;
pub const queryIntBox = gimp_query_int_box;

/// Creates a new `gtk.Dialog` that queries the user for a size using a
/// `gimpui.SizeEntry`.
extern fn gimp_query_size_box(p_title: [*:0]const u8, p_parent: *gtk.Widget, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_message: [*:0]const u8, p_initial: f64, p_lower: f64, p_upper: f64, p_digits: c_int, p_unit: *gimp.Unit, p_resolution: f64, p_dot_for_dot: c_int, p_object: *gobject.Object, p_signal: [*:0]const u8, p_callback: gimpui.QuerySizeCallback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gtk.Widget;
pub const querySizeBox = gimp_query_size_box;

/// Creates a new `gtk.Dialog` that queries the user for a string value.
extern fn gimp_query_string_box(p_title: [*:0]const u8, p_parent: *gtk.Widget, p_help_func: gimpui.HelpFunc, p_help_id: [*:0]const u8, p_message: [*:0]const u8, p_initial: [*:0]const u8, p_object: *gobject.Object, p_signal: [*:0]const u8, p_callback: gimpui.QueryStringCallback, p_data: ?*anyopaque, p_data_destroy: ?glib.DestroyNotify) *gtk.Widget;
pub const queryStringBox = gimp_query_string_box;

extern fn gimp_radio_button_update(p_widget: *gtk.Widget, p_data: *c_int) void;
pub const radioButtonUpdate = gimp_radio_button_update;

/// Creates a widget that allows the user to control how the random number
/// generator is initialized.
extern fn gimp_random_seed_new(p_seed: *u32, p_random_seed: *c_int) *gtk.Widget;
pub const randomSeedNew = gimp_random_seed_new;

extern fn gimp_scroll_adjustment_values(p_sevent: *gdk.EventScroll, p_hadj: ?*gtk.Adjustment, p_vadj: ?*gtk.Adjustment, p_hvalue: ?*f64, p_vvalue: ?*f64) void;
pub const scrollAdjustmentValues = gimp_scroll_adjustment_values;

/// This is the standard GIMP help function which does nothing but calling
/// `gimp.help`. It is the right function to use in almost all cases.
extern fn gimp_standard_help_func(p_help_id: [*:0]const u8, p_help_data: ?*anyopaque) void;
pub const standardHelpFunc = gimp_standard_help_func;

extern fn gimp_toggle_button_update(p_widget: *gtk.Widget, p_data: *c_int) void;
pub const toggleButtonUpdate = gimp_toggle_button_update;

/// Note that the `gtk.Adjustment`'s value (which is a `gdouble`) will be rounded
/// with (`guint`) (value + 0.5).
extern fn gimp_uint_adjustment_update(p_adjustment: *gtk.Adjustment, p_data: *c_uint) void;
pub const uintAdjustmentUpdate = gimp_uint_adjustment_update;

/// This function attempts to read the user's system preference for
/// showing animation. It can be used to turn off or hide unnecessary
/// animations such as the scrolling credits or Easter Egg animations.
extern fn gimp_widget_animation_enabled() c_int;
pub const widgetAnimationEnabled = gimp_widget_animation_enabled;

/// Disposes a widget's native window handle created asynchronously after
/// a previous call to gimp_widget_set_native_handle.
/// This disposes what the pointer points to, a *GBytes, if any.
/// Call this when the widget and the window handle it owns is being disposed.
///
/// This should be called at least once, paired with set_native_handle.
/// This knows how to free `window_handle`, especially that on some platforms,
/// an asynchronous callback must be canceled else it might call back
/// with the pointer, after the widget and its private is freed.
///
/// This is safe to call when deferenced `window_handle` is NULL,
/// when the window handle was never actually set,
/// on Wayland where actual setting is asynchronous.
///
/// !!! The word "handle" has two meanings.
/// A "window handle" is an ID of a window.
/// A "handle" also commonly means a pointer to a pointer, in this case **GBytes.
/// `window_handle` is both kinds of handle.
extern fn gimp_widget_free_native_handle(p_widget: *gtk.Widget, p_window_handle: **glib.Bytes) void;
pub const widgetFreeNativeHandle = gimp_widget_free_native_handle;

/// This function returns the `gimp.ColorProfile` of the monitor `widget` is
/// currently displayed on, or `NULL` if there is no profile configured.
extern fn gimp_widget_get_color_profile(p_widget: *gtk.Widget) ?*gimp.ColorProfile;
pub const widgetGetColorProfile = gimp_widget_get_color_profile;

/// This function returns the `gimp.ColorTransform` that transforms pixels
/// from `src_profile` to the profile of the `gdk.Monitor` the `widget` is
/// displayed on.
extern fn gimp_widget_get_color_transform(p_widget: *gtk.Widget, p_config: *gimp.ColorConfig, p_src_profile: *gimp.ColorProfile, p_src_format: *const babl.Object, p_dest_format: *const babl.Object, p_softproof_profile: *gimp.ColorProfile, p_proof_intent: gimp.ColorRenderingIntent, p_proof_bpc: c_int) ?*gimp.ColorTransform;
pub const widgetGetColorTransform = gimp_widget_get_color_transform;

extern fn gimp_widget_get_monitor(p_widget: *gtk.Widget) *gdk.Monitor;
pub const widgetGetMonitor = gimp_widget_get_monitor;

extern fn gimp_widget_get_render_space(p_widget: *gtk.Widget, p_config: *gimp.ColorConfig) *const babl.Object;
pub const widgetGetRenderSpace = gimp_widget_get_render_space;

/// This function is used to store the handle representing `window` into
/// `handle` so that it can later be reused to set other windows as
/// transient to this one (even in other processes, such as plug-ins).
///
/// Depending on the platform, the actual content of `handle` can be
/// various types. Moreover it may be filled asynchronously in a
/// callback, so you should not assume that `handle` is set after running
/// this function.
///
/// This convenience function is safe to use even before `widget` is
/// visible as it will set the handle once it is mapped.
extern fn gimp_widget_set_native_handle(p_widget: *gtk.Widget, p_handle: **glib.Bytes) void;
pub const widgetSetNativeHandle = gimp_widget_set_native_handle;

/// This function behaves as if `gtk.Widget` had a signal
///
/// GtkWidget::monitor_changed(GtkWidget *widget, gpointer user_data)
///
/// That is emitted whenever `widget`'s toplevel window is moved from
/// one monitor to another. This function automatically connects to
/// the right toplevel `gtk.Window`, even across moving `widget` between
/// toplevel windows.
///
/// Note that this function tracks the toplevel, not `widget` itself, so
/// all a window's widgets are always considered to be on the same
/// monitor. This is because this function is mainly used for fetching
/// the new monitor's color profile, and it makes little sense to use
/// different profiles for the widgets of one window.
extern fn gimp_widget_track_monitor(p_widget: *gtk.Widget, p_monitor_changed_callback: gobject.Callback, p_user_data: ?*anyopaque, p_user_data_destroy: ?glib.DestroyNotify) void;
pub const widgetTrackMonitor = gimp_widget_track_monitor;

/// This function is never called directly. Use `GIMP_WIDGETS_ERROR` instead.
extern fn gimp_widgets_error_quark() glib.Quark;
pub const widgetsErrorQuark = gimp_widgets_error_quark;

/// Indicates to the window manager that `window` is a transient dialog
/// associated with the GIMP window that the plug-in has been
/// started from. See also `gimpui.windowSetTransientForDisplay`.
extern fn gimp_window_set_transient(p_window: *gtk.Window) void;
pub const windowSetTransient = gimp_window_set_transient;

/// Indicates to the window manager that `window` is a transient dialog
/// to the window identified by `handle`.
///
/// Note that `handle` is an opaque data, which you should not try to
/// construct yourself or make sense of. It may be different things
/// depending on the OS or even the display server. You should only use
/// a handle returned by `gimp.progressGetWindowHandle`,
/// `gimp.Display.getWindowHandle` or
/// `gimpui.Dialog.getNativeHandle`.
///
/// Most of the time you will want to use the convenience function
/// `gimpui.windowSetTransient`.
extern fn gimp_window_set_transient_for(p_window: *gtk.Window, p_handle: *glib.Bytes) void;
pub const windowSetTransientFor = gimp_window_set_transient_for;

/// Indicates to the window manager that `window` is a transient dialog
/// associated with the GIMP image window that is identified by its
/// display. See `gdk.Window.setTransientFor` for more information.
///
/// Most of the time you will want to use the convenience function
/// `gimpui.windowSetTransient`.
extern fn gimp_window_set_transient_for_display(p_window: *gtk.Window, p_display: *gimp.Display) void;
pub const windowSetTransientForDisplay = gimp_window_set_transient_for_display;

extern fn gimp_zoom_button_new(p_model: *gimpui.ZoomModel, p_zoom_type: gimpui.ZoomType, p_icon_size: gtk.IconSize) *gtk.Widget;
pub const zoomButtonNew = gimp_zoom_button_new;

/// This is the prototype for all functions you pass as `help_func` to
/// the various GIMP dialog constructors like `gimpui.Dialog.new`,
/// `gimpui.queryIntBox` etc.
///
/// Help IDs are textual identifiers the help system uses to figure
/// which page to display.
///
/// All these dialog constructors functions call `gimpui.helpConnect`.
///
/// In most cases it will be ok to use `gimpui.standardHelpFunc` which
/// does nothing but passing the `help_id` string to `gimp.help`. If
/// your plug-in needs some more sophisticated help handling you can
/// provide your own `help_func` which has to call `gimp.help` to
/// actually display the help.
pub const HelpFunc = *const fn (p_help_id: [*:0]const u8, p_help_data: ?*anyopaque) callconv(.c) void;

pub const ImageConstraintFunc = *const fn (p_image: *gimp.Image, p_data: ?*anyopaque) callconv(.c) c_int;

/// Signature for a function called on each radio button value and data,
/// each time the `gimpui.IntRadioFrame` is drawn, to make some radio button
/// insensitive.
/// If the function returns `FALSE`, it usually means that the value is
/// not a valid choice in current situation. In this case, you might want
/// to toggle instead another value automatically. Set `new_value` to the
/// value to toggle. If you leave this untouched, the radio button will
/// stay toggled despite being insensitive. This is up to you to decide
/// whether this is meaningful.
pub const IntRadioFrameSensitivityFunc = *const fn (p_value: c_int, p_user_data: ?*anyopaque, p_new_value: *c_int, p_data: ?*anyopaque) callconv(.c) c_int;

pub const IntSensitivityFunc = *const fn (p_value: c_int, p_data: ?*anyopaque) callconv(.c) c_int;

pub const ItemConstraintFunc = *const fn (p_image: *gimp.Image, p_item: *gimp.Item, p_data: ?*anyopaque) callconv(.c) c_int;

/// The callback for a boolean query box.
pub const QueryBooleanCallback = *const fn (p_query_box: *gtk.Widget, p_value: c_int, p_data: ?*anyopaque) callconv(.c) void;

/// The callback for a double query box.
pub const QueryDoubleCallback = *const fn (p_query_box: *gtk.Widget, p_value: f64, p_data: ?*anyopaque) callconv(.c) void;

/// The callback for an int query box.
pub const QueryIntCallback = *const fn (p_query_box: *gtk.Widget, p_value: c_int, p_data: ?*anyopaque) callconv(.c) void;

/// The callback for a size query box.
pub const QuerySizeCallback = *const fn (p_query_box: *gtk.Widget, p_size: f64, p_unit: *gimp.Unit, p_data: ?*anyopaque) callconv(.c) void;

/// Note that you must not `glib.free` the passed string.
pub const QueryStringCallback = *const fn (p_query_box: *gtk.Widget, p_string: [*:0]const u8, p_data: ?*anyopaque) callconv(.c) void;

pub const StringSensitivityFunc = *const fn (p_id: [*:0]const u8, p_data: ?*anyopaque) callconv(.c) c_int;

/// The suggested width for a color bar in a `gimpui.ColorSelector`
/// implementation.
pub const COLOR_SELECTOR_BAR_SIZE = 15;
/// The suggested size for a color area in a `gimpui.ColorSelector`
/// implementation.
pub const COLOR_SELECTOR_SIZE = 150;
pub const ICON_APPLICATION_EXIT = "application-exit";
pub const ICON_ASPECT_LANDSCAPE = "gimp-landscape";
pub const ICON_ASPECT_PORTRAIT = "gimp-portrait";
pub const ICON_ATTACH = "gimp-attach";
pub const ICON_BUSINESS_CARD = "gimp-business-card";
pub const ICON_CAP_BUTT = "gimp-cap-butt";
pub const ICON_CAP_ROUND = "gimp-cap-round";
pub const ICON_CAP_SQUARE = "gimp-cap-square";
pub const ICON_CENTER = "gimp-center";
pub const ICON_CENTER_HORIZONTAL = "gimp-hcenter";
pub const ICON_CENTER_VERTICAL = "gimp-vcenter";
pub const ICON_CHAIN_HORIZONTAL = "gimp-hchain";
pub const ICON_CHAIN_HORIZONTAL_BROKEN = "gimp-hchain-broken";
pub const ICON_CHAIN_VERTICAL = "gimp-vchain";
pub const ICON_CHAIN_VERTICAL_BROKEN = "gimp-vchain-broken";
pub const ICON_CHANNEL = "gimp-channel";
pub const ICON_CHANNEL_ALPHA = "gimp-channel-alpha";
pub const ICON_CHANNEL_BLUE = "gimp-channel-blue";
pub const ICON_CHANNEL_GRAY = "gimp-channel-gray";
pub const ICON_CHANNEL_GREEN = "gimp-channel-green";
pub const ICON_CHANNEL_INDEXED = "gimp-channel-indexed";
pub const ICON_CHANNEL_RED = "gimp-channel-red";
pub const ICON_CHAR_PICKER = "gimp-char-picker";
pub const ICON_CLOSE = "gimp-close";
pub const ICON_CLOSE_ALL = "gimp-close-all";
pub const ICON_COLORMAP = "gimp-colormap";
pub const ICON_COLORS_DEFAULT = "gimp-default-colors";
pub const ICON_COLORS_SWAP = "gimp-swap-colors";
pub const ICON_COLOR_PICKER_BLACK = "gimp-color-picker-black";
pub const ICON_COLOR_PICKER_GRAY = "gimp-color-picker-gray";
pub const ICON_COLOR_PICKER_WHITE = "gimp-color-picker-white";
pub const ICON_COLOR_PICK_FROM_SCREEN = "gimp-color-pick-from-screen";
pub const ICON_COLOR_SELECTOR_CMYK = "gimp-color-cmyk";
pub const ICON_COLOR_SELECTOR_TRIANGLE = "gimp-color-triangle";
pub const ICON_COLOR_SELECTOR_WATER = "gimp-color-water";
pub const ICON_COLOR_SPACE_LINEAR = "gimp-color-space-linear";
pub const ICON_COLOR_SPACE_NON_LINEAR = "gimp-color-space-non-linear";
pub const ICON_COLOR_SPACE_PERCEPTUAL = "gimp-color-space-perceptual";
pub const ICON_CONTROLLER = "gimp-controller";
pub const ICON_CONTROLLER_KEYBOARD = "gimp-controller-keyboard";
pub const ICON_CONTROLLER_LINUX_INPUT = "gimp-controller-linux-input";
pub const ICON_CONTROLLER_MIDI = "gimp-controller-midi";
pub const ICON_CONTROLLER_WHEEL = "gimp-controller-wheel";
pub const ICON_CONVERT_GRAYSCALE = "gimp-convert-grayscale";
pub const ICON_CONVERT_INDEXED = "gimp-convert-indexed";
pub const ICON_CONVERT_RGB = "gimp-convert-rgb";
pub const ICON_CURSOR = "gimp-cursor";
pub const ICON_CURVE_FREE = "gimp-curve-free";
pub const ICON_CURVE_SMOOTH = "gimp-curve-smooth";
pub const ICON_DETACH = "gimp-detach";
pub const ICON_DIALOG_CHANNELS = "gimp-channels";
pub const ICON_DIALOG_DASHBOARD = "gimp-dashboard";
pub const ICON_DIALOG_DEVICE_STATUS = "gimp-device-status";
pub const ICON_DIALOG_ERROR = "dialog-error";
pub const ICON_DIALOG_IMAGES = "gimp-images";
pub const ICON_DIALOG_INFORMATION = "dialog-information";
pub const ICON_DIALOG_LAYERS = "gimp-layers";
pub const ICON_DIALOG_NAVIGATION = "gimp-navigation";
pub const ICON_DIALOG_PATHS = "gimp-paths";
pub const ICON_DIALOG_QUESTION = "dialog-question";
pub const ICON_DIALOG_RESHOW_FILTER = "gimp-reshow-filter";
pub const ICON_DIALOG_TOOLS = "gimp-tools";
pub const ICON_DIALOG_TOOL_OPTIONS = "gimp-tool-options";
pub const ICON_DIALOG_UNDO_HISTORY = "gimp-undo-history";
pub const ICON_DIALOG_WARNING = "dialog-warning";
pub const ICON_DISPLAY = "gimp-display";
pub const ICON_DISPLAY_FILTER = "gimp-display-filter";
pub const ICON_DISPLAY_FILTER_CLIP_WARNING = "gimp-display-filter-clip-warning";
pub const ICON_DISPLAY_FILTER_COLORBLIND = "gimp-display-filter-colorblind";
pub const ICON_DISPLAY_FILTER_CONTRAST = "gimp-display-filter-contrast";
pub const ICON_DISPLAY_FILTER_GAMMA = "gimp-display-filter-gamma";
pub const ICON_DISPLAY_FILTER_LCMS = "gimp-display-filter-lcms";
pub const ICON_DISPLAY_FILTER_PROOF = "gimp-display-filter-proof";
pub const ICON_DOCUMENT_NEW = "document-new";
pub const ICON_DOCUMENT_OPEN = "document-open";
pub const ICON_DOCUMENT_OPEN_RECENT = "document-open-recent";
pub const ICON_DOCUMENT_PAGE_SETUP = "document-page-setup";
pub const ICON_DOCUMENT_PRINT = "document-print";
pub const ICON_DOCUMENT_PRINT_RESOLUTION = "document-print";
pub const ICON_DOCUMENT_PROPERTIES = "document-properties";
pub const ICON_DOCUMENT_REVERT = "document-revert";
pub const ICON_DOCUMENT_SAVE = "document-save";
pub const ICON_DOCUMENT_SAVE_AS = "document-save-as";
pub const ICON_DYNAMICS = "gimp-dynamics";
pub const ICON_EDIT = "gtk-edit";
pub const ICON_EDIT_CLEAR = "edit-clear";
pub const ICON_EDIT_COPY = "edit-copy";
pub const ICON_EDIT_CUT = "edit-cut";
pub const ICON_EDIT_DELETE = "edit-delete";
pub const ICON_EDIT_FIND = "edit-find";
pub const ICON_EDIT_PASTE = "edit-paste";
pub const ICON_EDIT_PASTE_AS_NEW = "gimp-paste-as-new";
pub const ICON_EDIT_PASTE_INTO = "gimp-paste-into";
pub const ICON_EDIT_REDO = "edit-redo";
pub const ICON_EDIT_UNDO = "edit-undo";
pub const ICON_EFFECT = "gimp-effects";
pub const ICON_EVEN_HORIZONTAL_GAP = "gimp-even-horizontal-gap";
pub const ICON_EVEN_VERTICAL_GAP = "gimp-even-vertical-gap";
pub const ICON_FILE_MANAGER = "gimp-file-manager";
pub const ICON_FILL_HORIZONTAL = "gimp-hfill";
pub const ICON_FILL_VERTICAL = "gimp-vfill";
pub const ICON_FOLDER_NEW = "folder-new";
pub const ICON_FONT = "gtk-select-font";
pub const ICON_FORMAT_INDENT_LESS = "format-indent-less";
pub const ICON_FORMAT_INDENT_MORE = "format-indent-more";
pub const ICON_FORMAT_JUSTIFY_CENTER = "format-justify-center";
pub const ICON_FORMAT_JUSTIFY_FILL = "format-justify-fill";
pub const ICON_FORMAT_JUSTIFY_LEFT = "format-justify-left";
pub const ICON_FORMAT_JUSTIFY_RIGHT = "format-justify-right";
pub const ICON_FORMAT_TEXT_BOLD = "format-text-bold";
pub const ICON_FORMAT_TEXT_DIRECTION_LTR = "format-text-direction-ltr";
pub const ICON_FORMAT_TEXT_DIRECTION_RTL = "format-text-direction-rtl";
pub const ICON_FORMAT_TEXT_DIRECTION_TTB_LTR = "gimp-text-dir-ttb-ltr";
pub const ICON_FORMAT_TEXT_DIRECTION_TTB_LTR_UPRIGHT = "gimp-text-dir-ttb-ltr-upright";
pub const ICON_FORMAT_TEXT_DIRECTION_TTB_RTL = "gimp-text-dir-ttb-rtl";
pub const ICON_FORMAT_TEXT_DIRECTION_TTB_RTL_UPRIGHT = "gimp-text-dir-ttb-rtl-upright";
pub const ICON_FORMAT_TEXT_ITALIC = "format-text-italic";
pub const ICON_FORMAT_TEXT_SPACING_LETTER = "gimp-letter-spacing";
pub const ICON_FORMAT_TEXT_SPACING_LINE = "gimp-line-spacing";
pub const ICON_FORMAT_TEXT_STRIKETHROUGH = "format-text-strikethrough";
pub const ICON_FORMAT_TEXT_UNDERLINE = "format-text-underline";
pub const ICON_FRAME = "gimp-frame";
pub const ICON_GEGL = "gimp-gegl";
pub const ICON_GO_BOTTOM = "go-bottom";
pub const ICON_GO_DOWN = "go-down";
pub const ICON_GO_FIRST = "go-first";
pub const ICON_GO_HOME = "go-home";
pub const ICON_GO_LAST = "go-last";
pub const ICON_GO_NEXT = "go-next";
pub const ICON_GO_PREVIOUS = "go-previous";
pub const ICON_GO_TOP = "go-top";
pub const ICON_GO_UP = "go-up";
pub const ICON_GRADIENT_BILINEAR = "gimp-gradient-bilinear";
pub const ICON_GRADIENT_CONICAL_ASYMMETRIC = "gimp-gradient-conical-asymmetric";
pub const ICON_GRADIENT_CONICAL_SYMMETRIC = "gimp-gradient-conical-symmetric";
pub const ICON_GRADIENT_LINEAR = "gimp-gradient-linear";
pub const ICON_GRADIENT_RADIAL = "gimp-gradient-radial";
pub const ICON_GRADIENT_SHAPEBURST_ANGULAR = "gimp-gradient-shapeburst-angular";
pub const ICON_GRADIENT_SHAPEBURST_DIMPLED = "gimp-gradient-shapeburst-dimpled";
pub const ICON_GRADIENT_SHAPEBURST_SPHERICAL = "gimp-gradient-shapeburst-spherical";
pub const ICON_GRADIENT_SPIRAL_ANTICLOCKWISE = "gimp-gradient-spiral-anticlockwise";
pub const ICON_GRADIENT_SPIRAL_CLOCKWISE = "gimp-gradient-spiral-clockwise";
pub const ICON_GRADIENT_SQUARE = "gimp-gradient-square";
pub const ICON_GRAVITY_EAST = "gimp-gravity-east";
pub const ICON_GRAVITY_NORTH = "gimp-gravity-north";
pub const ICON_GRAVITY_NORTH_EAST = "gimp-gravity-north-east";
pub const ICON_GRAVITY_NORTH_WEST = "gimp-gravity-north-west";
pub const ICON_GRAVITY_SOUTH = "gimp-gravity-south";
pub const ICON_GRAVITY_SOUTH_EAST = "gimp-gravity-south-east";
pub const ICON_GRAVITY_SOUTH_WEST = "gimp-gravity-south-west";
pub const ICON_GRAVITY_WEST = "gimp-gravity-west";
pub const ICON_GRID = "gimp-grid";
pub const ICON_HELP = "system-help";
pub const ICON_HELP_ABOUT = "help-about";
pub const ICON_HELP_USER_MANUAL = "gimp-user-manual";
pub const ICON_HISTOGRAM = "gimp-histogram";
pub const ICON_HISTOGRAM_LINEAR = "gimp-histogram-linear";
pub const ICON_HISTOGRAM_LOGARITHMIC = "gimp-histogram-logarithmic";
pub const ICON_IMAGE = "gimp-image";
pub const ICON_IMAGE_OPEN = "gimp-image-open";
pub const ICON_IMAGE_RELOAD = "gimp-image-reload";
pub const ICON_INPUT_DEVICE = "gimp-input-device";
pub const ICON_INVERT = "gimp-invert";
pub const ICON_JOIN_BEVEL = "gimp-join-bevel";
pub const ICON_JOIN_MITER = "gimp-join-miter";
pub const ICON_JOIN_ROUND = "gimp-join-round";
pub const ICON_LAYER = "gimp-layer";
pub const ICON_LAYER_ANCHOR = "gimp-anchor";
pub const ICON_LAYER_FLOATING_SELECTION = "gimp-floating-selection";
pub const ICON_LAYER_MASK = "gimp-layer-mask";
pub const ICON_LAYER_MERGE_DOWN = "gimp-merge-down";
pub const ICON_LAYER_TEXT_LAYER = "gimp-text-layer";
pub const ICON_LAYER_TO_IMAGESIZE = "gimp-layer-to-imagesize";
pub const ICON_LINKED = "gimp-linked";
pub const ICON_LIST = "gimp-list";
pub const ICON_LIST_ADD = "list-add";
pub const ICON_LIST_REMOVE = "list-remove";
pub const ICON_LOCK = "gimp-lock";
pub const ICON_LOCK_ALPHA = "gimp-lock-alpha";
pub const ICON_LOCK_CONTENT = "gimp-lock-content";
pub const ICON_LOCK_MULTI = "gimp-lock-multi";
pub const ICON_LOCK_PATH = "gimp-lock-path";
pub const ICON_LOCK_POSITION = "gimp-lock-position";
pub const ICON_LOCK_VISIBILITY = "gimp-lock-visibility";
pub const ICON_MARKER = "gimp-marker";
pub const ICON_MENU_LEFT = "gimp-menu-left";
pub const ICON_MENU_RIGHT = "gimp-menu-right";
pub const ICON_OBJECT_DUPLICATE = "gimp-duplicate";
pub const ICON_OBJECT_FLIP_HORIZONTAL = "object-flip-horizontal";
pub const ICON_OBJECT_FLIP_VERTICAL = "object-flip-vertical";
pub const ICON_OBJECT_RESIZE = "gimp-resize";
pub const ICON_OBJECT_ROTATE_180 = "gimp-rotate-180";
pub const ICON_OBJECT_ROTATE_270 = "object-rotate-left";
pub const ICON_OBJECT_ROTATE_90 = "object-rotate-right";
pub const ICON_OBJECT_SCALE = "gimp-scale";
pub const ICON_PALETTE = "gtk-select-color";
pub const ICON_PATH = "gimp-path";
pub const ICON_PATH_STROKE = "gimp-path-stroke";
pub const ICON_PATTERN = "gimp-pattern";
pub const ICON_PIVOT_CENTER = "gimp-pivot-center";
pub const ICON_PIVOT_EAST = "gimp-pivot-east";
pub const ICON_PIVOT_NORTH = "gimp-pivot-north";
pub const ICON_PIVOT_NORTH_EAST = "gimp-pivot-north-east";
pub const ICON_PIVOT_NORTH_WEST = "gimp-pivot-north-west";
pub const ICON_PIVOT_SOUTH = "gimp-pivot-south";
pub const ICON_PIVOT_SOUTH_EAST = "gimp-pivot-south-east";
pub const ICON_PIVOT_SOUTH_WEST = "gimp-pivot-south-west";
pub const ICON_PIVOT_WEST = "gimp-pivot-west";
pub const ICON_PLUGIN = "gimp-plugin";
pub const ICON_PREFERENCES_SYSTEM = "preferences-system";
pub const ICON_PROCESS_STOP = "process-stop";
pub const ICON_QUICK_MASK_OFF = "gimp-quick-mask-off";
pub const ICON_QUICK_MASK_ON = "gimp-quick-mask-on";
pub const ICON_RECORD = "media-record";
pub const ICON_RESET = "gimp-reset";
pub const ICON_SAMPLE_POINT = "gimp-sample-point";
pub const ICON_SELECTION = "gimp-selection";
pub const ICON_SELECTION_ADD = "gimp-selection-add";
pub const ICON_SELECTION_ALL = "gimp-selection-all";
pub const ICON_SELECTION_BORDER = "gimp-selection-border";
pub const ICON_SELECTION_GROW = "gimp-selection-grow";
pub const ICON_SELECTION_INTERSECT = "gimp-selection-intersect";
pub const ICON_SELECTION_NONE = "gimp-selection-none";
pub const ICON_SELECTION_REPLACE = "gimp-selection-replace";
pub const ICON_SELECTION_SHRINK = "gimp-selection-shrink";
pub const ICON_SELECTION_STROKE = "gimp-selection-stroke";
pub const ICON_SELECTION_SUBTRACT = "gimp-selection-subtract";
pub const ICON_SELECTION_TO_CHANNEL = "gimp-selection-to-channel";
pub const ICON_SELECTION_TO_PATH = "gimp-selection-to-path";
pub const ICON_SHAPE_CIRCLE = "gimp-shape-circle";
pub const ICON_SHAPE_DIAMOND = "gimp-shape-diamond";
pub const ICON_SHAPE_SQUARE = "gimp-shape-square";
pub const ICON_SHRED = "gimp-shred";
pub const ICON_SMARTPHONE = "gimp-smartphone";
pub const ICON_SYMMETRY = "gimp-symmetry";
pub const ICON_SYSTEM_RUN = "system-run";
pub const ICON_TEMPLATE = "gimp-template";
pub const ICON_TEXTURE = "gimp-texture";
pub const ICON_TOOL_AIRBRUSH = "gimp-tool-airbrush";
pub const ICON_TOOL_ALIGN = "gimp-tool-align";
pub const ICON_TOOL_BLUR = "gimp-tool-blur";
pub const ICON_TOOL_BRIGHTNESS_CONTRAST = "gimp-tool-brightness-contrast";
pub const ICON_TOOL_BUCKET_FILL = "gimp-tool-bucket-fill";
pub const ICON_TOOL_BY_COLOR_SELECT = "gimp-tool-by-color-select";
pub const ICON_TOOL_CAGE = "gimp-tool-cage";
pub const ICON_TOOL_CLONE = "gimp-tool-clone";
pub const ICON_TOOL_COLORIZE = "gimp-tool-colorize";
pub const ICON_TOOL_COLOR_BALANCE = "gimp-tool-color-balance";
pub const ICON_TOOL_COLOR_PICKER = "gimp-tool-color-picker";
pub const ICON_TOOL_COLOR_TEMPERATURE = "gimp-tool-color-temperature";
pub const ICON_TOOL_CROP = "gimp-tool-crop";
pub const ICON_TOOL_CURVES = "gimp-tool-curves";
pub const ICON_TOOL_DESATURATE = "gimp-tool-desaturate";
pub const ICON_TOOL_DODGE = "gimp-tool-dodge";
pub const ICON_TOOL_ELLIPSE_SELECT = "gimp-tool-ellipse-select";
pub const ICON_TOOL_ERASER = "gimp-tool-eraser";
pub const ICON_TOOL_EXPOSURE = "gimp-tool-exposure";
pub const ICON_TOOL_FLIP = "gimp-tool-flip";
pub const ICON_TOOL_FOREGROUND_SELECT = "gimp-tool-foreground-select";
pub const ICON_TOOL_FREE_SELECT = "gimp-tool-free-select";
pub const ICON_TOOL_FUZZY_SELECT = "gimp-tool-fuzzy-select";
pub const ICON_TOOL_GRADIENT = "gimp-tool-gradient";
pub const ICON_TOOL_HANDLE_TRANSFORM = "gimp-tool-handle-transform";
pub const ICON_TOOL_HEAL = "gimp-tool-heal";
pub const ICON_TOOL_HUE_SATURATION = "gimp-tool-hue-saturation";
pub const ICON_TOOL_INK = "gimp-tool-ink";
pub const ICON_TOOL_ISCISSORS = "gimp-tool-iscissors";
pub const ICON_TOOL_LEVELS = "gimp-tool-levels";
pub const ICON_TOOL_MEASURE = "gimp-tool-measure";
pub const ICON_TOOL_MOVE = "gimp-tool-move";
pub const ICON_TOOL_MYPAINT_BRUSH = "gimp-tool-mypaint-brush";
pub const ICON_TOOL_N_POINT_DEFORMATION = "gimp-tool-n-point-deformation";
pub const ICON_TOOL_OFFSET = "gimp-tool-offset";
pub const ICON_TOOL_PAINTBRUSH = "gimp-tool-paintbrush";
pub const ICON_TOOL_PAINT_SELECT = "gimp-tool-paint-select";
pub const ICON_TOOL_PATH = "gimp-tool-path";
pub const ICON_TOOL_PENCIL = "gimp-tool-pencil";
pub const ICON_TOOL_PERSPECTIVE = "gimp-tool-perspective";
pub const ICON_TOOL_PERSPECTIVE_CLONE = "gimp-tool-perspective-clone";
pub const ICON_TOOL_POSTERIZE = "gimp-tool-posterize";
pub const ICON_TOOL_PRESET = "gimp-tool-preset";
pub const ICON_TOOL_RECT_SELECT = "gimp-tool-rect-select";
pub const ICON_TOOL_ROTATE = "gimp-tool-rotate";
pub const ICON_TOOL_SCALE = "gimp-tool-scale";
pub const ICON_TOOL_SEAMLESS_CLONE = "gimp-tool-seamless-clone";
pub const ICON_TOOL_SHADOWS_HIGHLIGHTS = "gimp-tool-shadows-highlights";
pub const ICON_TOOL_SHEAR = "gimp-tool-shear";
pub const ICON_TOOL_SMUDGE = "gimp-tool-smudge";
pub const ICON_TOOL_TEXT = "gimp-tool-text";
pub const ICON_TOOL_THRESHOLD = "gimp-tool-threshold";
pub const ICON_TOOL_TRANSFORM_3D = "gimp-tool-transform-3d";
pub const ICON_TOOL_UNIFIED_TRANSFORM = "gimp-tool-unified-transform";
pub const ICON_TOOL_WARP = "gimp-tool-warp";
pub const ICON_TOOL_ZOOM = "gimp-tool-zoom";
pub const ICON_TRANSFORM_3D_CAMERA = "gimp-transform-3d-camera";
pub const ICON_TRANSFORM_3D_MOVE = "gimp-transform-3d-move";
pub const ICON_TRANSFORM_3D_ROTATE = "gimp-transform-3d-rotate";
pub const ICON_TRANSPARENCY = "gimp-transparency";
pub const ICON_VIDEO = "gimp-video";
pub const ICON_VIEW_FULLSCREEN = "view-fullscreen";
pub const ICON_VIEW_REFRESH = "view-refresh";
pub const ICON_VIEW_SHRINK_WRAP = "view-shrink-wrap";
pub const ICON_VIEW_ZOOM_FILL = "view-zoom-fill";
pub const ICON_VISIBLE = "gimp-visible";
pub const ICON_WEB = "gimp-web";
pub const ICON_WILBER = "gimp-wilber";
pub const ICON_WILBER_EEK = "gimp-wilber-eek";
pub const ICON_WINDOW_CLOSE = "window-close";
pub const ICON_WINDOW_MOVE_TO_SCREEN = "gimp-move-to-screen";
pub const ICON_WINDOW_NEW = "window-new";
pub const ICON_ZOOM_FIT_BEST = "zoom-fit-best";
pub const ICON_ZOOM_FOLLOW_WINDOW = "gimp-zoom-follow-window";
pub const ICON_ZOOM_IN = "zoom-in";
pub const ICON_ZOOM_ORIGINAL = "zoom-original";
pub const ICON_ZOOM_OUT = "zoom-out";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
