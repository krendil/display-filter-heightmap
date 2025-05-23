pub const ext = @import("ext.zig");
const atk = @This();

const std = @import("std");
const compat = @import("compat");
const gobject = @import("gobject2");
const glib = @import("glib2");
/// This is a singly-linked list (a `glib.SList`) of `atk.Attribute`. It is
/// used by `atk.Text.getRunAttributes`,
/// `atk.Text.getDefaultAttributes`,
/// `atk.EditableText.setRunAttributes`,
/// `atk.Document.getAttributes` and `atk.Object.getAttributes`
pub const AttributeSet = glib.SList;

/// An AtkState describes a single state of an object.
///
/// An AtkState describes a single state of an object. The full set of states
/// that apply to an object at a given time are contained in its `atk.StateSet`.
///
/// See `atk.Object.refStateSet` and `atk.Object.notifyStateChange`
pub const State = u64;

/// This object class is derived from AtkObject and can be used as a basis implementing accessible objects.
///
/// This object class is derived from AtkObject. It can be used as a
/// basis for implementing accessible objects for GObjects which are
/// not derived from GtkWidget. One example of its use is in providing
/// an accessible object for GnomeCanvasItem in the GAIL library.
pub const GObjectAccessible = extern struct {
    pub const Parent = atk.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.GObjectAccessibleClass;
    f_parent: atk.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the accessible object for the specified `obj`.
    extern fn atk_gobject_accessible_for_object(p_obj: *gobject.Object) *atk.Object;
    pub const forObject = atk_gobject_accessible_for_object;

    /// Gets the GObject for which `obj` is the accessible object.
    extern fn atk_gobject_accessible_get_object(p_obj: *GObjectAccessible) *gobject.Object;
    pub const getObject = atk_gobject_accessible_get_object;

    extern fn atk_gobject_accessible_get_type() usize;
    pub const getGObjectType = atk_gobject_accessible_get_type;

    extern fn g_object_ref(p_self: *atk.GObjectAccessible) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.GObjectAccessible) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *GObjectAccessible, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An ATK object which encapsulates a link or set of links in a hypertext document.
///
/// An ATK object which encapsulates a link or set of links (for
/// instance in the case of client-side image maps) in a hypertext
/// document.  It may implement the AtkAction interface.  AtkHyperlink
/// may also be used to refer to inline embedded content, since it
/// allows specification of a start and end offset within the host
/// AtkHypertext object.
pub const Hyperlink = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{atk.Action};
    pub const Class = atk.HyperlinkClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {
        /// Gets the index with the hypertext document at which this link ends.
        pub const get_end_index = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hyperlink.Class, p_class).f_get_end_index.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_get_end_index = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of anchors associated with this hyperlink.
        pub const get_n_anchors = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hyperlink.Class, p_class).f_get_n_anchors.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_get_n_anchors = @ptrCast(p_implementation);
            }
        };

        /// Returns the item associated with this hyperlinks nth anchor.
        /// For instance, the returned `atk.Object` will implement `atk.Text`
        /// if `link_` is a text hyperlink, `atk.Image` if `link_` is an image
        /// hyperlink etc.
        ///
        /// Multiple anchors are primarily used by client-side image maps.
        pub const get_object = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) *atk.Object {
                return gobject.ext.as(Hyperlink.Class, p_class).f_get_object.?(gobject.ext.as(Hyperlink, p_link_), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) *atk.Object) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_get_object = @ptrCast(p_implementation);
            }
        };

        /// Gets the index with the hypertext document at which this link begins.
        pub const get_start_index = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hyperlink.Class, p_class).f_get_start_index.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_get_start_index = @ptrCast(p_implementation);
            }
        };

        /// Get a the URI associated with the anchor specified
        /// by `i` of `link_`.
        ///
        /// Multiple anchors are primarily used by client-side image maps.
        pub const get_uri = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) [*:0]u8 {
                return gobject.ext.as(Hyperlink.Class, p_class).f_get_uri.?(gobject.ext.as(Hyperlink, p_link_), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_get_uri = @ptrCast(p_implementation);
            }
        };

        /// Determines whether this AtkHyperlink is selected
        pub const is_selected_link = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hyperlink.Class, p_class).f_is_selected_link.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_is_selected_link = @ptrCast(p_implementation);
            }
        };

        /// Since the document that a link is associated with may have changed
        /// this method returns `TRUE` if the link is still valid (with
        /// respect to the document it references) and `FALSE` otherwise.
        pub const is_valid = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hyperlink.Class, p_class).f_is_valid.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_is_valid = @ptrCast(p_implementation);
            }
        };

        pub const link_activated = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Hyperlink.Class, p_class).f_link_activated.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_link_activated = @ptrCast(p_implementation);
            }
        };

        pub const link_state = struct {
            pub fn call(p_class: anytype, p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_uint {
                return gobject.ext.as(Hyperlink.Class, p_class).f_link_state.?(gobject.ext.as(Hyperlink, p_link_));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_link_: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_uint) void {
                gobject.ext.as(Hyperlink.Class, p_class).f_link_state = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const end_index = struct {
            pub const name = "end-index";

            pub const Type = c_int;
        };

        pub const number_of_anchors = struct {
            pub const name = "number-of-anchors";

            pub const Type = c_int;
        };

        /// Selected link
        pub const selected_link = struct {
            pub const name = "selected-link";

            pub const Type = c_int;
        };

        pub const start_index = struct {
            pub const name = "start-index";

            pub const Type = c_int;
        };
    };

    pub const signals = struct {
        /// The signal link-activated is emitted when a link is activated.
        pub const link_activated = struct {
            pub const name = "link-activated";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hyperlink, p_instance))),
                    gobject.signalLookup("link-activated", Hyperlink.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the index with the hypertext document at which this link ends.
    extern fn atk_hyperlink_get_end_index(p_link_: *Hyperlink) c_int;
    pub const getEndIndex = atk_hyperlink_get_end_index;

    /// Gets the number of anchors associated with this hyperlink.
    extern fn atk_hyperlink_get_n_anchors(p_link_: *Hyperlink) c_int;
    pub const getNAnchors = atk_hyperlink_get_n_anchors;

    /// Returns the item associated with this hyperlinks nth anchor.
    /// For instance, the returned `atk.Object` will implement `atk.Text`
    /// if `link_` is a text hyperlink, `atk.Image` if `link_` is an image
    /// hyperlink etc.
    ///
    /// Multiple anchors are primarily used by client-side image maps.
    extern fn atk_hyperlink_get_object(p_link_: *Hyperlink, p_i: c_int) *atk.Object;
    pub const getObject = atk_hyperlink_get_object;

    /// Gets the index with the hypertext document at which this link begins.
    extern fn atk_hyperlink_get_start_index(p_link_: *Hyperlink) c_int;
    pub const getStartIndex = atk_hyperlink_get_start_index;

    /// Get a the URI associated with the anchor specified
    /// by `i` of `link_`.
    ///
    /// Multiple anchors are primarily used by client-side image maps.
    extern fn atk_hyperlink_get_uri(p_link_: *Hyperlink, p_i: c_int) [*:0]u8;
    pub const getUri = atk_hyperlink_get_uri;

    /// Indicates whether the link currently displays some or all of its
    ///           content inline.  Ordinary HTML links will usually return
    ///           `FALSE`, but an inline &lt;src&gt; HTML element will return
    ///           `TRUE`.
    extern fn atk_hyperlink_is_inline(p_link_: *Hyperlink) c_int;
    pub const isInline = atk_hyperlink_is_inline;

    /// Determines whether this AtkHyperlink is selected
    extern fn atk_hyperlink_is_selected_link(p_link_: *Hyperlink) c_int;
    pub const isSelectedLink = atk_hyperlink_is_selected_link;

    /// Since the document that a link is associated with may have changed
    /// this method returns `TRUE` if the link is still valid (with
    /// respect to the document it references) and `FALSE` otherwise.
    extern fn atk_hyperlink_is_valid(p_link_: *Hyperlink) c_int;
    pub const isValid = atk_hyperlink_is_valid;

    extern fn atk_hyperlink_get_type() usize;
    pub const getGObjectType = atk_hyperlink_get_type;

    extern fn g_object_ref(p_self: *atk.Hyperlink) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Hyperlink) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Hyperlink, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of ATK utility functions for thread locking
///
/// A set of utility functions for thread locking. This interface and
/// all his related methods are deprecated since 2.12.
pub const Misc = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.MiscClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {
        /// Take the thread mutex for the GUI toolkit,
        /// if one exists.
        /// (This method is implemented by the toolkit ATK implementation layer;
        ///  for instance, for GTK+, GAIL implements this via GDK_THREADS_ENTER).
        pub const threads_enter = struct {
            pub fn call(p_class: anytype, p_misc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Misc.Class, p_class).f_threads_enter.?(gobject.ext.as(Misc, p_misc));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_misc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Misc.Class, p_class).f_threads_enter = @ptrCast(p_implementation);
            }
        };

        /// Release the thread mutex for the GUI toolkit,
        /// if one exists. This method, and atk_misc_threads_enter,
        /// are needed in some situations by threaded application code which
        /// services ATK requests, since fulfilling ATK requests often
        /// requires calling into the GUI toolkit.  If a long-running or
        /// potentially blocking call takes place inside such a block, it should
        /// be bracketed by atk_misc_threads_leave/atk_misc_threads_enter calls.
        /// (This method is implemented by the toolkit ATK implementation layer;
        ///  for instance, for GTK+, GAIL implements this via GDK_THREADS_LEAVE).
        pub const threads_leave = struct {
            pub fn call(p_class: anytype, p_misc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Misc.Class, p_class).f_threads_leave.?(gobject.ext.as(Misc, p_misc));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_misc: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Misc.Class, p_class).f_threads_leave = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Obtain the singleton instance of AtkMisc for this application.
    extern fn atk_misc_get_instance() *const atk.Misc;
    pub const getInstance = atk_misc_get_instance;

    /// Take the thread mutex for the GUI toolkit,
    /// if one exists.
    /// (This method is implemented by the toolkit ATK implementation layer;
    ///  for instance, for GTK+, GAIL implements this via GDK_THREADS_ENTER).
    extern fn atk_misc_threads_enter(p_misc: *Misc) void;
    pub const threadsEnter = atk_misc_threads_enter;

    /// Release the thread mutex for the GUI toolkit,
    /// if one exists. This method, and atk_misc_threads_enter,
    /// are needed in some situations by threaded application code which
    /// services ATK requests, since fulfilling ATK requests often
    /// requires calling into the GUI toolkit.  If a long-running or
    /// potentially blocking call takes place inside such a block, it should
    /// be bracketed by atk_misc_threads_leave/atk_misc_threads_enter calls.
    /// (This method is implemented by the toolkit ATK implementation layer;
    ///  for instance, for GTK+, GAIL implements this via GDK_THREADS_LEAVE).
    extern fn atk_misc_threads_leave(p_misc: *Misc) void;
    pub const threadsLeave = atk_misc_threads_leave;

    extern fn atk_misc_get_type() usize;
    pub const getGObjectType = atk_misc_get_type;

    extern fn g_object_ref(p_self: *atk.Misc) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Misc) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Misc, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An AtkObject which purports to implement all ATK interfaces.
///
/// An AtkNoOpObject is an AtkObject which purports to implement all
/// ATK interfaces. It is the type of AtkObject which is created if an
/// accessible object is requested for an object type for which no
/// factory type is specified.
pub const NoOpObject = extern struct {
    pub const Parent = atk.Object;
    pub const Implements = [_]type{ atk.Action, atk.Component, atk.Document, atk.EditableText, atk.Hypertext, atk.Image, atk.Selection, atk.Table, atk.TableCell, atk.Text, atk.Value, atk.Window };
    pub const Class = atk.NoOpObjectClass;
    f_parent: atk.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Provides a default (non-functioning stub) `atk.Object`.
    /// Application maintainers should not use this method.
    extern fn atk_no_op_object_new(p_obj: *gobject.Object) *atk.NoOpObject;
    pub const new = atk_no_op_object_new;

    extern fn atk_no_op_object_get_type() usize;
    pub const getGObjectType = atk_no_op_object_get_type;

    extern fn g_object_ref(p_self: *atk.NoOpObject) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.NoOpObject) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NoOpObject, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The AtkObjectFactory which creates an AtkNoOpObject.
///
/// The AtkObjectFactory which creates an AtkNoOpObject. An instance of
/// this is created by an AtkRegistry if no factory type has not been
/// specified to create an accessible object of a particular type.
pub const NoOpObjectFactory = extern struct {
    pub const Parent = atk.ObjectFactory;
    pub const Implements = [_]type{};
    pub const Class = atk.NoOpObjectFactoryClass;
    f_parent: atk.ObjectFactory,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates an instance of an `atk.ObjectFactory` which generates primitive
    /// (non-functioning) `AtkObjects`.
    extern fn atk_no_op_object_factory_new() *atk.NoOpObjectFactory;
    pub const new = atk_no_op_object_factory_new;

    extern fn atk_no_op_object_factory_get_type() usize;
    pub const getGObjectType = atk_no_op_object_factory_get_type;

    extern fn g_object_ref(p_self: *atk.NoOpObjectFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.NoOpObjectFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *NoOpObjectFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The base object class for the Accessibility Toolkit API.
///
/// This class is the primary class for accessibility support via the
/// Accessibility ToolKit (ATK).  Objects which are instances of
/// `atk.Object` (or instances of AtkObject-derived types) are queried
/// for properties which relate basic (and generic) properties of a UI
/// component such as name and description.  Instances of `atk.Object`
/// may also be queried as to whether they implement other ATK
/// interfaces (e.g. `atk.Action`, `atk.Component`, etc.), as appropriate
/// to the role which a given UI component plays in a user interface.
///
/// All UI components in an application which provide useful
/// information or services to the user must provide corresponding
/// `atk.Object` instances on request (in GTK+, for instance, usually on
/// a call to `gtk_widget_get_accessible` ()), either via ATK support
/// built into the toolkit for the widget class or ancestor class, or
/// in the case of custom widgets, if the inherited `atk.Object`
/// implementation is insufficient, via instances of a new `atk.Object`
/// subclass.
///
/// See `AtkObjectFactory`, `AtkRegistry`.  (GTK+ users see also
/// `GtkAccessible`).
pub const Object = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.ObjectClass;
    f_parent: gobject.Object,
    f_description: ?[*:0]u8,
    f_name: ?[*:0]u8,
    f_accessible_parent: ?*atk.Object,
    f_role: atk.Role,
    f_relation_set: ?*atk.RelationSet,
    f_layer: atk.Layer,

    pub const virtual_methods = struct {
        pub const active_descendant_changed = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child: ?*anyopaque) void {
                return gobject.ext.as(Object.Class, p_class).f_active_descendant_changed.?(gobject.ext.as(Object, p_accessible), p_child);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_child: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_active_descendant_changed = @ptrCast(p_implementation);
            }
        };

        pub const children_changed = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_change_index: c_uint, p_changed_child: ?*anyopaque) void {
                return gobject.ext.as(Object.Class, p_class).f_children_changed.?(gobject.ext.as(Object, p_accessible), p_change_index, p_changed_child);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_change_index: c_uint, p_changed_child: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_children_changed = @ptrCast(p_implementation);
            }
        };

        /// Calls `handler` on property changes.
        pub const connect_property_change_handler = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler: *atk.PropertyChangeHandler) c_uint {
                return gobject.ext.as(Object.Class, p_class).f_connect_property_change_handler.?(gobject.ext.as(Object, p_accessible), p_handler);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler: *atk.PropertyChangeHandler) callconv(.c) c_uint) void {
                gobject.ext.as(Object.Class, p_class).f_connect_property_change_handler = @ptrCast(p_implementation);
            }
        };

        /// The signal handler which is executed when there is a
        ///   focus event for an object. This virtual function is deprecated
        ///   since 2.9.4 and it should not be overriden. Use
        ///   the `atk.Object.signals.state`-change "focused" signal instead.
        pub const focus_event = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_focus_in: c_int) void {
                return gobject.ext.as(Object.Class, p_class).f_focus_event.?(gobject.ext.as(Object, p_accessible), p_focus_in);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_focus_in: c_int) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_focus_event = @ptrCast(p_implementation);
            }
        };

        /// Get a list of properties applied to this object as a whole, as an `atk.AttributeSet` consisting of
        /// name-value pairs. As such these attributes may be considered weakly-typed properties or annotations,
        /// as distinct from strongly-typed object data available via other get/set methods.
        /// Not all objects have explicit "name-value pair" `atk.AttributeSet` properties.
        pub const get_attributes = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.AttributeSet {
                return gobject.ext.as(Object.Class, p_class).f_get_attributes.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.AttributeSet) void {
                gobject.ext.as(Object.Class, p_class).f_get_attributes = @ptrCast(p_implementation);
            }
        };

        /// Gets the accessible description of the accessible.
        pub const get_description = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Object.Class, p_class).f_get_description.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Object.Class, p_class).f_get_description = @ptrCast(p_implementation);
            }
        };

        /// Gets the 0-based index of this accessible in its parent; returns -1 if the
        /// accessible does not have an accessible parent.
        pub const get_index_in_parent = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Object.Class, p_class).f_get_index_in_parent.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Object.Class, p_class).f_get_index_in_parent = @ptrCast(p_implementation);
            }
        };

        /// Gets the layer of the accessible.
        pub const get_layer = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) atk.Layer {
                return gobject.ext.as(Object.Class, p_class).f_get_layer.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) atk.Layer) void {
                gobject.ext.as(Object.Class, p_class).f_get_layer = @ptrCast(p_implementation);
            }
        };

        /// Gets the zorder of the accessible. The value G_MININT will be returned
        /// if the layer of the accessible is not ATK_LAYER_MDI.
        pub const get_mdi_zorder = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Object.Class, p_class).f_get_mdi_zorder.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Object.Class, p_class).f_get_mdi_zorder = @ptrCast(p_implementation);
            }
        };

        pub const get_n_children = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Object.Class, p_class).f_get_n_children.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Object.Class, p_class).f_get_n_children = @ptrCast(p_implementation);
            }
        };

        /// Gets the accessible name of the accessible.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Object.Class, p_class).f_get_name.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Object.Class, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// Gets a UTF-8 string indicating the POSIX-style LC_MESSAGES locale
        /// of `accessible`.
        pub const get_object_locale = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Object.Class, p_class).f_get_object_locale.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Object.Class, p_class).f_get_object_locale = @ptrCast(p_implementation);
            }
        };

        /// Gets the accessible parent of the accessible. By default this is
        /// the one assigned with `atk.Object.setParent`, but it is assumed
        /// that ATK implementors have ways to get the parent of the object
        /// without the need of assigning it manually with
        /// `atk.Object.setParent`, and will return it with this method.
        ///
        /// If you are only interested on the parent assigned with
        /// `atk.Object.setParent`, use `atk.Object.peekParent`.
        pub const get_parent = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.Object {
                return gobject.ext.as(Object.Class, p_class).f_get_parent.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.Object) void {
                gobject.ext.as(Object.Class, p_class).f_get_parent = @ptrCast(p_implementation);
            }
        };

        /// Gets the role of the accessible.
        pub const get_role = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) atk.Role {
                return gobject.ext.as(Object.Class, p_class).f_get_role.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) atk.Role) void {
                gobject.ext.as(Object.Class, p_class).f_get_role = @ptrCast(p_implementation);
            }
        };

        /// This function is called when implementing subclasses of `atk.Object`.
        /// It does initialization required for the new object. It is intended
        /// that this function should called only in the ...`_new` functions used
        /// to create an instance of a subclass of `atk.Object`
        pub const initialize = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_data: ?*anyopaque) void {
                return gobject.ext.as(Object.Class, p_class).f_initialize.?(gobject.ext.as(Object, p_accessible), p_data);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_data: ?*anyopaque) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_initialize = @ptrCast(p_implementation);
            }
        };

        pub const property_change = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_values: *atk.PropertyValues) void {
                return gobject.ext.as(Object.Class, p_class).f_property_change.?(gobject.ext.as(Object, p_accessible), p_values);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_values: *atk.PropertyValues) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_property_change = @ptrCast(p_implementation);
            }
        };

        pub const ref_child = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) *atk.Object {
                return gobject.ext.as(Object.Class, p_class).f_ref_child.?(gobject.ext.as(Object, p_accessible), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) *atk.Object) void {
                gobject.ext.as(Object.Class, p_class).f_ref_child = @ptrCast(p_implementation);
            }
        };

        /// Gets the `atk.RelationSet` associated with the object.
        pub const ref_relation_set = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.RelationSet {
                return gobject.ext.as(Object.Class, p_class).f_ref_relation_set.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.RelationSet) void {
                gobject.ext.as(Object.Class, p_class).f_ref_relation_set = @ptrCast(p_implementation);
            }
        };

        /// Gets a reference to the state set of the accessible; the caller must
        /// unreference it when it is no longer needed.
        pub const ref_state_set = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.StateSet {
                return gobject.ext.as(Object.Class, p_class).f_ref_state_set.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.StateSet) void {
                gobject.ext.as(Object.Class, p_class).f_ref_state_set = @ptrCast(p_implementation);
            }
        };

        /// Removes a property change handler.
        pub const remove_property_change_handler = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler_id: c_uint) void {
                return gobject.ext.as(Object.Class, p_class).f_remove_property_change_handler.?(gobject.ext.as(Object, p_accessible), p_handler_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler_id: c_uint) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_remove_property_change_handler = @ptrCast(p_implementation);
            }
        };

        /// Sets the accessible description of the accessible. You can't set
        /// the description to NULL. This is reserved for the initial value. In
        /// this aspect NULL is similar to ATK_ROLE_UNKNOWN. If you want to set
        /// the name to a empty value you can use "".
        pub const set_description = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_description: [*:0]const u8) void {
                return gobject.ext.as(Object.Class, p_class).f_set_description.?(gobject.ext.as(Object, p_accessible), p_description);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_description: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_set_description = @ptrCast(p_implementation);
            }
        };

        /// Sets the accessible name of the accessible. You can't set the name
        /// to NULL. This is reserved for the initial value. In this aspect
        /// NULL is similar to ATK_ROLE_UNKNOWN. If you want to set the name to
        /// a empty value you can use "".
        pub const set_name = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) void {
                return gobject.ext.as(Object.Class, p_class).f_set_name.?(gobject.ext.as(Object, p_accessible), p_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_set_name = @ptrCast(p_implementation);
            }
        };

        /// Sets the accessible parent of the accessible. `parent` can be NULL.
        pub const set_parent = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parent: *atk.Object) void {
                return gobject.ext.as(Object.Class, p_class).f_set_parent.?(gobject.ext.as(Object, p_accessible), p_parent);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_parent: *atk.Object) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_set_parent = @ptrCast(p_implementation);
            }
        };

        /// Sets the role of the accessible.
        pub const set_role = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_role: atk.Role) void {
                return gobject.ext.as(Object.Class, p_class).f_set_role.?(gobject.ext.as(Object, p_accessible), p_role);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_role: atk.Role) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_set_role = @ptrCast(p_implementation);
            }
        };

        pub const state_change = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_state_set: c_int) void {
                return gobject.ext.as(Object.Class, p_class).f_state_change.?(gobject.ext.as(Object, p_accessible), p_name, p_state_set);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_name: [*:0]const u8, p_state_set: c_int) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_state_change = @ptrCast(p_implementation);
            }
        };

        pub const visible_data_changed = struct {
            pub fn call(p_class: anytype, p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Object.Class, p_class).f_visible_data_changed.?(gobject.ext.as(Object, p_accessible));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_accessible: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Object.Class, p_class).f_visible_data_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {
        pub const accessible_component_layer = struct {
            pub const name = "accessible-component-layer";

            pub const Type = c_int;
        };

        pub const accessible_component_mdi_zorder = struct {
            pub const name = "accessible-component-mdi-zorder";

            pub const Type = c_int;
        };

        pub const accessible_description = struct {
            pub const name = "accessible-description";

            pub const Type = ?[*:0]u8;
        };

        pub const accessible_help_text = struct {
            pub const name = "accessible-help-text";

            pub const Type = ?[*:0]u8;
        };

        pub const accessible_hypertext_nlinks = struct {
            pub const name = "accessible-hypertext-nlinks";

            pub const Type = c_int;
        };

        pub const accessible_id = struct {
            pub const name = "accessible-id";

            pub const Type = ?[*:0]u8;
        };

        pub const accessible_name = struct {
            pub const name = "accessible-name";

            pub const Type = ?[*:0]u8;
        };

        pub const accessible_parent = struct {
            pub const name = "accessible-parent";

            pub const Type = ?*atk.Object;
        };

        pub const accessible_role = struct {
            pub const name = "accessible-role";

            pub const Type = atk.Role;
        };

        /// Table caption.
        pub const accessible_table_caption = struct {
            pub const name = "accessible-table-caption";

            pub const Type = ?[*:0]u8;
        };

        pub const accessible_table_caption_object = struct {
            pub const name = "accessible-table-caption-object";

            pub const Type = ?*atk.Object;
        };

        /// Accessible table column description.
        pub const accessible_table_column_description = struct {
            pub const name = "accessible-table-column-description";

            pub const Type = ?[*:0]u8;
        };

        /// Accessible table column header.
        pub const accessible_table_column_header = struct {
            pub const name = "accessible-table-column-header";

            pub const Type = ?*atk.Object;
        };

        /// Accessible table row description.
        pub const accessible_table_row_description = struct {
            pub const name = "accessible-table-row-description";

            pub const Type = ?[*:0]u8;
        };

        /// Accessible table row header.
        pub const accessible_table_row_header = struct {
            pub const name = "accessible-table-row-header";

            pub const Type = ?*atk.Object;
        };

        pub const accessible_table_summary = struct {
            pub const name = "accessible-table-summary";

            pub const Type = ?*atk.Object;
        };

        /// Numeric value of this object, in case being and AtkValue.
        pub const accessible_value = struct {
            pub const name = "accessible-value";

            pub const Type = f64;
        };
    };

    pub const signals = struct {
        /// The "active-descendant-changed" signal is emitted by an object
        /// which has the state ATK_STATE_MANAGES_DESCENDANTS when the focus
        /// object in the object changes. For instance, a table will emit the
        /// signal when the cell in the table which has focus changes.
        pub const active_descendant_changed = struct {
            pub const name = "active-descendant-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: **atk.Object, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("active-descendant-changed", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "announcement" signal can be emitted to pass an announcement on to
        /// be read by a screen reader.
        ///
        /// Depcrecated (2.50): Use AtkObject::notification instead.
        pub const announcement = struct {
            pub const name = "announcement";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("announcement", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "attribute-changed" signal should be emitted when one of an object's
        /// attributes changes.
        pub const attribute_changed = struct {
            pub const name = "attribute-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: [*:0]u8, p_arg2: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("attribute-changed", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal "children-changed" is emitted when a child is added or
        /// removed from an object. It supports two details: "add" and
        /// "remove"
        pub const children_changed = struct {
            pub const name = "children-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_uint, p_arg2: **atk.Object, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("children-changed", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal "focus-event" is emitted when an object gained or lost
        /// focus.
        pub const focus_event = struct {
            pub const name = "focus-event";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("focus-event", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "notification" signal can be emitted to pass an announcement on to
        /// be read by a screen reader.
        pub const notification = struct {
            pub const name = "notification";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: [*:0]u8, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("notification", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal "property-change" is emitted when an object's property
        /// value changes. `arg1` contains an `atk.PropertyValues` with the name
        /// and the new value of the property whose value has changed. Note
        /// that, as with GObject notify, getting this signal does not
        /// guarantee that the value of the property has actually changed; it
        /// may also be emitted when the setter of the property is called to
        /// reinstate the previous value.
        ///
        /// Toolkit implementor note: ATK implementors should use
        /// `gobject.Object.notify` to emit property-changed
        /// notifications. `atk.Object.signals.property`-changed is needed by the
        /// implementation of `atk.addGlobalEventListener` because GObject
        /// notify doesn't support emission hooks.
        pub const property_change = struct {
            pub const name = "property-change";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: **atk.PropertyValues, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("property-change", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "state-change" signal is emitted when an object's state
        /// changes.  The detail value identifies the state type which has
        /// changed.
        pub const state_change = struct {
            pub const name = "state-change";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: [*:0]u8, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("state-change", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "visible-data-changed" signal is emitted when the visual
        /// appearance of the object changed.
        pub const visible_data_changed = struct {
            pub const name = "visible-data-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Object, p_instance))),
                    gobject.signalLookup("visible-data-changed", Object.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Adds a relationship of the specified type with the specified target.
    extern fn atk_object_add_relationship(p_object: *Object, p_relationship: atk.RelationType, p_target: *atk.Object) c_int;
    pub const addRelationship = atk_object_add_relationship;

    /// Calls `handler` on property changes.
    extern fn atk_object_connect_property_change_handler(p_accessible: *Object, p_handler: *atk.PropertyChangeHandler) c_uint;
    pub const connectPropertyChangeHandler = atk_object_connect_property_change_handler;

    /// Gets the accessible id of the accessible.
    extern fn atk_object_get_accessible_id(p_accessible: *Object) [*:0]const u8;
    pub const getAccessibleId = atk_object_get_accessible_id;

    /// Get a list of properties applied to this object as a whole, as an `atk.AttributeSet` consisting of
    /// name-value pairs. As such these attributes may be considered weakly-typed properties or annotations,
    /// as distinct from strongly-typed object data available via other get/set methods.
    /// Not all objects have explicit "name-value pair" `atk.AttributeSet` properties.
    extern fn atk_object_get_attributes(p_accessible: *Object) *atk.AttributeSet;
    pub const getAttributes = atk_object_get_attributes;

    /// Gets the accessible description of the accessible.
    extern fn atk_object_get_description(p_accessible: *Object) [*:0]const u8;
    pub const getDescription = atk_object_get_description;

    /// Gets the help text associated with the accessible.
    extern fn atk_object_get_help_text(p_accessible: *Object) [*:0]const u8;
    pub const getHelpText = atk_object_get_help_text;

    /// Gets the 0-based index of this accessible in its parent; returns -1 if the
    /// accessible does not have an accessible parent.
    extern fn atk_object_get_index_in_parent(p_accessible: *Object) c_int;
    pub const getIndexInParent = atk_object_get_index_in_parent;

    /// Gets the layer of the accessible.
    extern fn atk_object_get_layer(p_accessible: *Object) atk.Layer;
    pub const getLayer = atk_object_get_layer;

    /// Gets the zorder of the accessible. The value G_MININT will be returned
    /// if the layer of the accessible is not ATK_LAYER_MDI.
    extern fn atk_object_get_mdi_zorder(p_accessible: *Object) c_int;
    pub const getMdiZorder = atk_object_get_mdi_zorder;

    /// Gets the number of accessible children of the accessible.
    extern fn atk_object_get_n_accessible_children(p_accessible: *Object) c_int;
    pub const getNAccessibleChildren = atk_object_get_n_accessible_children;

    /// Gets the accessible name of the accessible.
    extern fn atk_object_get_name(p_accessible: *Object) [*:0]const u8;
    pub const getName = atk_object_get_name;

    /// Gets a UTF-8 string indicating the POSIX-style LC_MESSAGES locale
    /// of `accessible`.
    extern fn atk_object_get_object_locale(p_accessible: *Object) [*:0]const u8;
    pub const getObjectLocale = atk_object_get_object_locale;

    /// Gets the accessible parent of the accessible. By default this is
    /// the one assigned with `atk.Object.setParent`, but it is assumed
    /// that ATK implementors have ways to get the parent of the object
    /// without the need of assigning it manually with
    /// `atk.Object.setParent`, and will return it with this method.
    ///
    /// If you are only interested on the parent assigned with
    /// `atk.Object.setParent`, use `atk.Object.peekParent`.
    extern fn atk_object_get_parent(p_accessible: *Object) *atk.Object;
    pub const getParent = atk_object_get_parent;

    /// Gets the role of the accessible.
    extern fn atk_object_get_role(p_accessible: *Object) atk.Role;
    pub const getRole = atk_object_get_role;

    /// This function is called when implementing subclasses of `atk.Object`.
    /// It does initialization required for the new object. It is intended
    /// that this function should called only in the ...`_new` functions used
    /// to create an instance of a subclass of `atk.Object`
    extern fn atk_object_initialize(p_accessible: *Object, p_data: ?*anyopaque) void;
    pub const initialize = atk_object_initialize;

    /// Emits a state-change signal for the specified state.
    ///
    /// Note that as a general rule when the state of an existing object changes,
    /// emitting a notification is expected.
    extern fn atk_object_notify_state_change(p_accessible: *Object, p_state: atk.State, p_value: c_int) void;
    pub const notifyStateChange = atk_object_notify_state_change;

    /// Gets the accessible parent of the accessible, if it has been
    /// manually assigned with atk_object_set_parent. Otherwise, this
    /// function returns `NULL`.
    ///
    /// This method is intended as an utility for ATK implementors, and not
    /// to be exposed to accessible tools. See `atk.Object.getParent` for
    /// further reference.
    extern fn atk_object_peek_parent(p_accessible: *Object) *atk.Object;
    pub const peekParent = atk_object_peek_parent;

    /// Gets a reference to the specified accessible child of the object.
    /// The accessible children are 0-based so the first accessible child is
    /// at index 0, the second at index 1 and so on.
    extern fn atk_object_ref_accessible_child(p_accessible: *Object, p_i: c_int) *atk.Object;
    pub const refAccessibleChild = atk_object_ref_accessible_child;

    /// Gets the `atk.RelationSet` associated with the object.
    extern fn atk_object_ref_relation_set(p_accessible: *Object) *atk.RelationSet;
    pub const refRelationSet = atk_object_ref_relation_set;

    /// Gets a reference to the state set of the accessible; the caller must
    /// unreference it when it is no longer needed.
    extern fn atk_object_ref_state_set(p_accessible: *Object) *atk.StateSet;
    pub const refStateSet = atk_object_ref_state_set;

    /// Removes a property change handler.
    extern fn atk_object_remove_property_change_handler(p_accessible: *Object, p_handler_id: c_uint) void;
    pub const removePropertyChangeHandler = atk_object_remove_property_change_handler;

    /// Removes a relationship of the specified type with the specified target.
    extern fn atk_object_remove_relationship(p_object: *Object, p_relationship: atk.RelationType, p_target: *atk.Object) c_int;
    pub const removeRelationship = atk_object_remove_relationship;

    /// Sets the accessible ID of the accessible.  This is not meant to be presented
    /// to the user, but to be an ID which is stable over application development.
    /// Typically, this is the gtkbuilder ID. Such an ID will be available for
    /// instance to identify a given well-known accessible object for tailored screen
    /// reading, or for automatic regression testing.
    extern fn atk_object_set_accessible_id(p_accessible: *Object, p_id: [*:0]const u8) void;
    pub const setAccessibleId = atk_object_set_accessible_id;

    /// Sets the accessible description of the accessible. You can't set
    /// the description to NULL. This is reserved for the initial value. In
    /// this aspect NULL is similar to ATK_ROLE_UNKNOWN. If you want to set
    /// the name to a empty value you can use "".
    extern fn atk_object_set_description(p_accessible: *Object, p_description: [*:0]const u8) void;
    pub const setDescription = atk_object_set_description;

    /// Sets the help text associated with the accessible. This can be used to
    /// expose context-sensitive information to help a user understand how to
    /// interact with the object. You can't set the help text to NULL.
    /// This is reserved for the initial value. If you want to set the name to
    /// an empty value, you can use "".
    extern fn atk_object_set_help_text(p_accessible: *Object, p_help_text: [*:0]const u8) void;
    pub const setHelpText = atk_object_set_help_text;

    /// Sets the accessible name of the accessible. You can't set the name
    /// to NULL. This is reserved for the initial value. In this aspect
    /// NULL is similar to ATK_ROLE_UNKNOWN. If you want to set the name to
    /// a empty value you can use "".
    extern fn atk_object_set_name(p_accessible: *Object, p_name: [*:0]const u8) void;
    pub const setName = atk_object_set_name;

    /// Sets the accessible parent of the accessible. `parent` can be NULL.
    extern fn atk_object_set_parent(p_accessible: *Object, p_parent: *atk.Object) void;
    pub const setParent = atk_object_set_parent;

    /// Sets the role of the accessible.
    extern fn atk_object_set_role(p_accessible: *Object, p_role: atk.Role) void;
    pub const setRole = atk_object_set_role;

    extern fn atk_object_get_type() usize;
    pub const getGObjectType = atk_object_get_type;

    extern fn g_object_ref(p_self: *atk.Object) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Object) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Object, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The base object class for a factory used to
///  create accessible objects for objects of a specific GType.
///
/// This class is the base object class for a factory used to create an
/// accessible object for a specific GType. The function
/// `atk.Registry.setFactoryType` is normally called to store in the
/// registry the factory type to be used to create an accessible of a
/// particular GType.
pub const ObjectFactory = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.ObjectFactoryClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {
        /// Inform `factory` that it is no longer being used to create
        /// accessibles. When called, `factory` may need to inform
        /// `AtkObjects` which it has created that they need to be re-instantiated.
        /// Note: primarily used for runtime replacement of `AtkObjectFactorys`
        /// in object registries.
        pub const invalidate = struct {
            pub fn call(p_class: anytype, p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(ObjectFactory.Class, p_class).f_invalidate.?(gobject.ext.as(ObjectFactory, p_factory));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_factory: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(ObjectFactory.Class, p_class).f_invalidate = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Provides an `atk.Object` that implements an accessibility interface
    /// on behalf of `obj`
    extern fn atk_object_factory_create_accessible(p_factory: *ObjectFactory, p_obj: *gobject.Object) *atk.Object;
    pub const createAccessible = atk_object_factory_create_accessible;

    /// Gets the GType of the accessible which is created by the factory.
    extern fn atk_object_factory_get_accessible_type(p_factory: *ObjectFactory) usize;
    pub const getAccessibleType = atk_object_factory_get_accessible_type;

    /// Inform `factory` that it is no longer being used to create
    /// accessibles. When called, `factory` may need to inform
    /// `AtkObjects` which it has created that they need to be re-instantiated.
    /// Note: primarily used for runtime replacement of `AtkObjectFactorys`
    /// in object registries.
    extern fn atk_object_factory_invalidate(p_factory: *ObjectFactory) void;
    pub const invalidate = atk_object_factory_invalidate;

    extern fn atk_object_factory_get_type() usize;
    pub const getGObjectType = atk_object_factory_get_type;

    extern fn g_object_ref(p_self: *atk.ObjectFactory) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.ObjectFactory) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ObjectFactory, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Toplevel for embedding into other processes
///
/// See `AtkSocket`
pub const Plug = extern struct {
    pub const Parent = atk.Object;
    pub const Implements = [_]type{atk.Component};
    pub const Class = atk.PlugClass;
    f_parent: atk.Object,

    pub const virtual_methods = struct {
        pub const get_object_id = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]u8 {
                return gobject.ext.as(Plug.Class, p_class).f_get_object_id.?(gobject.ext.as(Plug, p_obj));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Plug.Class, p_class).f_get_object_id = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atk.Plug` instance.
    extern fn atk_plug_new() *atk.Plug;
    pub const new = atk_plug_new;

    /// Gets the unique ID of an `atk.Plug` object, which can be used to
    /// embed inside of an `atk.Socket` using `atk.Socket.embed`.
    ///
    /// Internally, this calls a class function that should be registered
    /// by the IPC layer (usually at-spi2-atk). The implementor of an
    /// `atk.Plug` object should call this function (after atk-bridge is
    /// loaded) and pass the value to the process implementing the
    /// `atk.Socket`, so it could embed the plug.
    extern fn atk_plug_get_id(p_plug: *Plug) [*:0]u8;
    pub const getId = atk_plug_get_id;

    /// Sets `child` as accessible child of `plug` and `plug` as accessible parent of
    /// `child`. `child` can be NULL.
    ///
    /// In some cases, one can not use the AtkPlug type directly as accessible
    /// object for the toplevel widget of the application. For instance in the gtk
    /// case, GtkPlugAccessible can not inherit both from GtkWindowAccessible and
    /// from AtkPlug. In such a case, one can create, in addition to the standard
    /// accessible object for the toplevel widget, an AtkPlug object, and make the
    /// former the child of the latter by calling `atk.Plug.setChild`.
    extern fn atk_plug_set_child(p_plug: *Plug, p_child: *atk.Object) void;
    pub const setChild = atk_plug_set_child;

    extern fn atk_plug_get_type() usize;
    pub const getGObjectType = atk_plug_get_type;

    extern fn g_object_ref(p_self: *atk.Plug) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Plug) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Plug, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An object used to store the GType of the
/// factories used to create an accessible object for an object of a
/// particular GType.
///
/// The AtkRegistry is normally used to create appropriate ATK "peers"
/// for user interface components.  Application developers usually need
/// only interact with the AtkRegistry by associating appropriate ATK
/// implementation classes with GObject classes via the
/// atk_registry_set_factory_type call, passing the appropriate GType
/// for application custom widget classes.
pub const Registry = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.RegistryClass;
    f_parent: gobject.Object,
    f_factory_type_registry: ?*glib.HashTable,
    f_factory_singleton_cache: ?*glib.HashTable,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets an `atk.ObjectFactory` appropriate for creating `AtkObjects`
    /// appropriate for `type`.
    extern fn atk_registry_get_factory(p_registry: *Registry, p_type: usize) *atk.ObjectFactory;
    pub const getFactory = atk_registry_get_factory;

    /// Provides a `gobject.Type` indicating the `atk.ObjectFactory` subclass
    /// associated with `type`.
    extern fn atk_registry_get_factory_type(p_registry: *Registry, p_type: usize) usize;
    pub const getFactoryType = atk_registry_get_factory_type;

    /// Associate an `atk.ObjectFactory` subclass with a `gobject.Type`. Note:
    /// The associated `factory_type` will thereafter be responsible for
    /// the creation of new `atk.Object` implementations for instances
    /// appropriate for `type`.
    extern fn atk_registry_set_factory_type(p_registry: *Registry, p_type: usize, p_factory_type: usize) void;
    pub const setFactoryType = atk_registry_set_factory_type;

    extern fn atk_registry_get_type() usize;
    pub const getGObjectType = atk_registry_get_type;

    extern fn g_object_ref(p_self: *atk.Registry) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Registry) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Registry, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An object used to describe a relation between a
///  object and one or more other objects.
///
/// An AtkRelation describes a relation between an object and one or
/// more other objects. The actual relations that an object has with
/// other objects are defined as an AtkRelationSet, which is a set of
/// AtkRelations.
pub const Relation = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.RelationClass;
    f_parent: gobject.Object,
    f_target: ?*glib.PtrArray,
    f_relationship: atk.RelationType,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        pub const relation_type = struct {
            pub const name = "relation-type";

            pub const Type = atk.RelationType;
        };

        pub const target = struct {
            pub const name = "target";

            pub const Type = ?*gobject.ValueArray;
        };
    };

    pub const signals = struct {};

    /// Create a new relation for the specified key and the specified list
    /// of targets.  See also `atk.Object.addRelationship`.
    extern fn atk_relation_new(p_targets: [*]*atk.Object, p_n_targets: c_int, p_relationship: atk.RelationType) *atk.Relation;
    pub const new = atk_relation_new;

    /// Adds the specified AtkObject to the target for the relation, if it is
    /// not already present.  See also `atk.Object.addRelationship`.
    extern fn atk_relation_add_target(p_relation: *Relation, p_target: *atk.Object) void;
    pub const addTarget = atk_relation_add_target;

    /// Gets the type of `relation`
    extern fn atk_relation_get_relation_type(p_relation: *Relation) atk.RelationType;
    pub const getRelationType = atk_relation_get_relation_type;

    /// Gets the target list of `relation`
    extern fn atk_relation_get_target(p_relation: *Relation) *glib.PtrArray;
    pub const getTarget = atk_relation_get_target;

    /// Remove the specified AtkObject from the target for the relation.
    extern fn atk_relation_remove_target(p_relation: *Relation, p_target: *atk.Object) c_int;
    pub const removeTarget = atk_relation_remove_target;

    extern fn atk_relation_get_type() usize;
    pub const getGObjectType = atk_relation_get_type;

    extern fn g_object_ref(p_self: *atk.Relation) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Relation) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Relation, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of AtkRelations, normally the set of
///  AtkRelations which an AtkObject has.
///
/// The AtkRelationSet held by an object establishes its relationships
/// with objects beyond the normal "parent/child" hierarchical
/// relationships that all user interface objects have.
/// AtkRelationSets establish whether objects are labelled or
/// controlled by other components, share group membership with other
/// components (for instance within a radio-button group), or share
/// content which "flows" between them, among other types of possible
/// relationships.
pub const RelationSet = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.RelationSetClass;
    f_parent: gobject.Object,
    f_relations: ?*glib.PtrArray,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new empty relation set.
    extern fn atk_relation_set_new() *atk.RelationSet;
    pub const new = atk_relation_set_new;

    /// Add a new relation to the current relation set if it is not already
    /// present.
    /// This function ref's the AtkRelation so the caller of this function
    /// should unref it to ensure that it will be destroyed when the AtkRelationSet
    /// is destroyed.
    extern fn atk_relation_set_add(p_set: *RelationSet, p_relation: *atk.Relation) void;
    pub const add = atk_relation_set_add;

    /// Add a new relation of the specified type with the specified target to
    /// the current relation set if the relation set does not contain a relation
    /// of that type. If it is does contain a relation of that typea the target
    /// is added to the relation.
    extern fn atk_relation_set_add_relation_by_type(p_set: *RelationSet, p_relationship: atk.RelationType, p_target: *atk.Object) void;
    pub const addRelationByType = atk_relation_set_add_relation_by_type;

    /// Determines whether the relation set contains a relation that matches the
    /// specified type.
    extern fn atk_relation_set_contains(p_set: *RelationSet, p_relationship: atk.RelationType) c_int;
    pub const contains = atk_relation_set_contains;

    /// Determines whether the relation set contains a relation that
    /// matches the specified pair formed by type `relationship` and object
    /// `target`.
    extern fn atk_relation_set_contains_target(p_set: *RelationSet, p_relationship: atk.RelationType, p_target: *atk.Object) c_int;
    pub const containsTarget = atk_relation_set_contains_target;

    /// Determines the number of relations in a relation set.
    extern fn atk_relation_set_get_n_relations(p_set: *RelationSet) c_int;
    pub const getNRelations = atk_relation_set_get_n_relations;

    /// Determines the relation at the specified position in the relation set.
    extern fn atk_relation_set_get_relation(p_set: *RelationSet, p_i: c_int) *atk.Relation;
    pub const getRelation = atk_relation_set_get_relation;

    /// Finds a relation that matches the specified type.
    extern fn atk_relation_set_get_relation_by_type(p_set: *RelationSet, p_relationship: atk.RelationType) *atk.Relation;
    pub const getRelationByType = atk_relation_set_get_relation_by_type;

    /// Removes a relation from the relation set.
    /// This function unref's the `atk.Relation` so it will be deleted unless there
    /// is another reference to it.
    extern fn atk_relation_set_remove(p_set: *RelationSet, p_relation: *atk.Relation) void;
    pub const remove = atk_relation_set_remove;

    extern fn atk_relation_set_get_type() usize;
    pub const getGObjectType = atk_relation_set_get_type;

    extern fn g_object_ref(p_self: *atk.RelationSet) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.RelationSet) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *RelationSet, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Container for AtkPlug objects from other processes
///
/// Together with `atk.Plug`, `atk.Socket` provides the ability to embed
/// accessibles from one process into another in a fashion that is
/// transparent to assistive technologies. `atk.Socket` works as the
/// container of `atk.Plug`, embedding it using the method
/// `atk.Socket.embed`. Any accessible contained in the `atk.Plug` will
/// appear to the assistive technologies as being inside the
/// application that created the `atk.Socket`.
///
/// The communication between a `atk.Socket` and a `atk.Plug` is done by
/// the IPC layer of the accessibility framework, normally implemented
/// by the D-Bus based implementation of AT-SPI (at-spi2). If that is
/// the case, at-spi-atk2 is the responsible to implement the abstract
/// methods `atk.Plug.getId` and `atk.Socket.embed`, so an ATK
/// implementor shouldn't reimplement them. The process that contains
/// the `atk.Plug` is responsible to send the ID returned by
/// `atk_plug_id` to the process that contains the `atk.Socket`, so it
/// could call the method `atk.Socket.embed` in order to embed it.
///
/// For the same reasons, an implementor doesn't need to implement
/// `atk.Object.getNAccessibleChildren` and
/// `atk.Object.refAccessibleChild`. All the logic related to those
/// functions will be implemented by the IPC layer.
///
/// See `AtkPlug`
pub const Socket = extern struct {
    pub const Parent = atk.Object;
    pub const Implements = [_]type{atk.Component};
    pub const Class = atk.SocketClass;
    f_parent: atk.Object,
    f_embedded_plug_id: ?[*:0]u8,

    pub const virtual_methods = struct {
        /// Embeds the children of an `atk.Plug` as the children of the
        /// `atk.Socket`. The plug may be in the same process or in a different
        /// process.
        ///
        /// The class item used by this function should be filled in by the IPC
        /// layer (usually at-spi2-atk). The implementor of the AtkSocket
        /// should call this function and pass the id for the plug as returned
        /// by `atk.Plug.getId`.  It is the responsibility of the application
        /// to pass the plug id on to the process implementing the `atk.Socket`
        /// as needed.
        pub const embed = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_plug_id: [*:0]const u8) void {
                return gobject.ext.as(Socket.Class, p_class).f_embed.?(gobject.ext.as(Socket, p_obj), p_plug_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_plug_id: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Socket.Class, p_class).f_embed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new `atk.Socket`.
    extern fn atk_socket_new() *atk.Socket;
    pub const new = atk_socket_new;

    /// Embeds the children of an `atk.Plug` as the children of the
    /// `atk.Socket`. The plug may be in the same process or in a different
    /// process.
    ///
    /// The class item used by this function should be filled in by the IPC
    /// layer (usually at-spi2-atk). The implementor of the AtkSocket
    /// should call this function and pass the id for the plug as returned
    /// by `atk.Plug.getId`.  It is the responsibility of the application
    /// to pass the plug id on to the process implementing the `atk.Socket`
    /// as needed.
    extern fn atk_socket_embed(p_obj: *Socket, p_plug_id: [*:0]const u8) void;
    pub const embed = atk_socket_embed;

    /// Determines whether or not the socket has an embedded plug.
    extern fn atk_socket_is_occupied(p_obj: *Socket) c_int;
    pub const isOccupied = atk_socket_is_occupied;

    extern fn atk_socket_get_type() usize;
    pub const getGObjectType = atk_socket_get_type;

    extern fn g_object_ref(p_self: *atk.Socket) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Socket) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Socket, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// An AtkStateSet contains the states of an object.
///
/// An AtkStateSet is a read-only representation of the full set of `AtkStates`
/// that apply to an object at a given time. This set is not meant to be
/// modified, but rather created when `atk.Object.refStateSet``atk.Object.refStateSet` is called.
pub const StateSet = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.StateSetClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    /// Creates a new empty state set.
    extern fn atk_state_set_new() *atk.StateSet;
    pub const new = atk_state_set_new;

    /// Adds the state of the specified type to the state set if it is not already
    /// present.
    ///
    /// Note that because an `atk.StateSet` is a read-only object, this method should
    /// be used to add a state to a newly-created set which will then be returned by
    /// `atk.Object.refStateSet`. It should not be used to modify the existing state
    /// of an object. See also `atk.Object.notifyStateChange`.
    extern fn atk_state_set_add_state(p_set: *StateSet, p_type: atk.StateType) c_int;
    pub const addState = atk_state_set_add_state;

    /// Adds the states of the specified types to the state set.
    ///
    /// Note that because an `atk.StateSet` is a read-only object, this method should
    /// be used to add states to a newly-created set which will then be returned by
    /// `atk.Object.refStateSet`. It should not be used to modify the existing state
    /// of an object. See also `atk.Object.notifyStateChange`.
    extern fn atk_state_set_add_states(p_set: *StateSet, p_types: [*]atk.StateType, p_n_types: c_int) void;
    pub const addStates = atk_state_set_add_states;

    /// Constructs the intersection of the two sets, returning `NULL` if the
    /// intersection is empty.
    extern fn atk_state_set_and_sets(p_set: *StateSet, p_compare_set: *atk.StateSet) *atk.StateSet;
    pub const andSets = atk_state_set_and_sets;

    /// Removes all states from the state set.
    extern fn atk_state_set_clear_states(p_set: *StateSet) void;
    pub const clearStates = atk_state_set_clear_states;

    /// Checks whether the state for the specified type is in the specified set.
    extern fn atk_state_set_contains_state(p_set: *StateSet, p_type: atk.StateType) c_int;
    pub const containsState = atk_state_set_contains_state;

    /// Checks whether the states for all the specified types are in the
    /// specified set.
    extern fn atk_state_set_contains_states(p_set: *StateSet, p_types: [*]atk.StateType, p_n_types: c_int) c_int;
    pub const containsStates = atk_state_set_contains_states;

    /// Checks whether the state set is empty, i.e. has no states set.
    extern fn atk_state_set_is_empty(p_set: *StateSet) c_int;
    pub const isEmpty = atk_state_set_is_empty;

    /// Constructs the union of the two sets.
    extern fn atk_state_set_or_sets(p_set: *StateSet, p_compare_set: *atk.StateSet) ?*atk.StateSet;
    pub const orSets = atk_state_set_or_sets;

    /// Removes the state for the specified type from the state set.
    ///
    /// Note that because an `atk.StateSet` is a read-only object, this method should
    /// be used to remove a state to a newly-created set which will then be returned
    /// by `atk.Object.refStateSet`. It should not be used to modify the existing
    /// state of an object. See also `atk.Object.notifyStateChange`.
    extern fn atk_state_set_remove_state(p_set: *StateSet, p_type: atk.StateType) c_int;
    pub const removeState = atk_state_set_remove_state;

    /// Constructs the exclusive-or of the two sets, returning `NULL` is empty.
    /// The set returned by this operation contains the states in exactly
    /// one of the two sets.
    extern fn atk_state_set_xor_sets(p_set: *StateSet, p_compare_set: *atk.StateSet) *atk.StateSet;
    pub const xorSets = atk_state_set_xor_sets;

    extern fn atk_state_set_get_type() usize;
    pub const getGObjectType = atk_state_set_get_type;

    extern fn g_object_ref(p_self: *atk.StateSet) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.StateSet) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StateSet, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A set of ATK utility functions for event and toolkit support.
///
/// A set of ATK utility functions which are used to support event
/// registration of various types, and obtaining the 'root' accessible
/// of a process and information about the current ATK implementation
/// and toolkit version.
pub const Util = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = atk.UtilClass;
    f_parent: gobject.Object,

    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn atk_util_get_type() usize;
    pub const getGObjectType = atk_util_get_type;

    extern fn g_object_ref(p_self: *atk.Util) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Util) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Util, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface provided by UI components
/// which the user can activate/interact with.
///
/// `atk.Action` should be implemented by instances of `atk.Object` classes
/// with which the user can interact directly, i.e. buttons,
/// checkboxes, scrollbars, e.g. components which are not "passive"
/// providers of UI information.
///
/// Exceptions: when the user interaction is already covered by another
/// appropriate interface such as `atk.EditableText` (insert/delete text,
/// etc.) or `atk.Value` (set value) then these actions should not be
/// exposed by `atk.Action` as well.
///
/// Though most UI interactions on components should be invocable via
/// keyboard as well as mouse, there will generally be a close mapping
/// between "mouse actions" that are possible on a component and the
/// AtkActions.  Where mouse and keyboard actions are redundant in
/// effect, `atk.Action` should expose only one action rather than
/// exposing redundant actions if possible.  By convention we have been
/// using "mouse centric" terminology for `atk.Action` names.
pub const Action = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.ActionIface;
    pub const virtual_methods = struct {
        /// Perform the specified action on the object.
        pub const do_action = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) c_int {
                return gobject.ext.as(Action.Iface, p_class).f_do_action.?(gobject.ext.as(Action, p_action), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Action.Iface, p_class).f_do_action = @ptrCast(p_implementation);
            }
        };

        /// Returns a description of the specified action of the object.
        pub const get_description = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) ?[*:0]const u8 {
                return gobject.ext.as(Action.Iface, p_class).f_get_description.?(gobject.ext.as(Action, p_action), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Action.Iface, p_class).f_get_description = @ptrCast(p_implementation);
            }
        };

        /// Gets the keybinding which can be used to activate this action, if one
        /// exists. The string returned should contain localized, human-readable,
        /// key sequences as they would appear when displayed on screen. It must
        /// be in the format "mnemonic;sequence;shortcut".
        ///
        /// - The mnemonic key activates the object if it is presently enabled onscreen.
        ///   This typically corresponds to the underlined letter within the widget.
        ///   Example: "n" in a traditional "New..." menu item or the "a" in "Apply" for
        ///   a button.
        /// - The sequence is the full list of keys which invoke the action even if the
        ///   relevant element is not currently shown on screen. For instance, for a menu
        ///   item the sequence is the keybindings used to open the parent menus before
        ///   invoking. The sequence string is colon-delimited. Example: "Alt+F:N" in a
        ///   traditional "New..." menu item.
        /// - The shortcut, if it exists, will invoke the same action without showing
        ///   the component or its enclosing menus or dialogs. Example: "Ctrl+N" in a
        ///   traditional "New..." menu item.
        ///
        /// Example: For a traditional "New..." menu item, the expected return value
        /// would be: "N;Alt+F:N;Ctrl+N" for the English locale and "N;Alt+D:N;Strg+N"
        /// for the German locale. If, hypothetically, this menu item lacked a mnemonic,
        /// it would be represented by ";;Ctrl+N" and ";;Strg+N" respectively.
        pub const get_keybinding = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) ?[*:0]const u8 {
                return gobject.ext.as(Action.Iface, p_class).f_get_keybinding.?(gobject.ext.as(Action, p_action), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Action.Iface, p_class).f_get_keybinding = @ptrCast(p_implementation);
            }
        };

        /// Returns the localized name of the specified action of the object.
        pub const get_localized_name = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) ?[*:0]const u8 {
                return gobject.ext.as(Action.Iface, p_class).f_get_localized_name.?(gobject.ext.as(Action, p_action), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Action.Iface, p_class).f_get_localized_name = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of accessible actions available on the object.
        /// If there are more than one, the first one is considered the
        /// "default" action of the object.
        pub const get_n_actions = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Action.Iface, p_class).f_get_n_actions.?(gobject.ext.as(Action, p_action));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Action.Iface, p_class).f_get_n_actions = @ptrCast(p_implementation);
            }
        };

        /// Returns a non-localized string naming the specified action of the
        /// object. This name is generally not descriptive of the end result
        /// of the action, but instead names the 'interaction type' which the
        /// object supports. By convention, the above strings should be used to
        /// represent the actions which correspond to the common point-and-click
        /// interaction techniques of the same name: i.e.
        /// "click", "press", "release", "drag", "drop", "popup", etc.
        /// The "popup" action should be used to pop up a context menu for the
        /// object, if one exists.
        ///
        /// For technical reasons, some toolkits cannot guarantee that the
        /// reported action is actually 'bound' to a nontrivial user event;
        /// i.e. the result of some actions via `atk.Action.doAction` may be
        /// NIL.
        pub const get_name = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) ?[*:0]const u8 {
                return gobject.ext.as(Action.Iface, p_class).f_get_name.?(gobject.ext.as(Action, p_action), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Action.Iface, p_class).f_get_name = @ptrCast(p_implementation);
            }
        };

        /// Sets a description of the specified action of the object.
        pub const set_description = struct {
            pub fn call(p_class: anytype, p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int, p_desc: [*:0]const u8) c_int {
                return gobject.ext.as(Action.Iface, p_class).f_set_description.?(gobject.ext.as(Action, p_action), p_i, p_desc);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_action: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int, p_desc: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Action.Iface, p_class).f_set_description = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Perform the specified action on the object.
    extern fn atk_action_do_action(p_action: *Action, p_i: c_int) c_int;
    pub const doAction = atk_action_do_action;

    /// Returns a description of the specified action of the object.
    extern fn atk_action_get_description(p_action: *Action, p_i: c_int) ?[*:0]const u8;
    pub const getDescription = atk_action_get_description;

    /// Gets the keybinding which can be used to activate this action, if one
    /// exists. The string returned should contain localized, human-readable,
    /// key sequences as they would appear when displayed on screen. It must
    /// be in the format "mnemonic;sequence;shortcut".
    ///
    /// - The mnemonic key activates the object if it is presently enabled onscreen.
    ///   This typically corresponds to the underlined letter within the widget.
    ///   Example: "n" in a traditional "New..." menu item or the "a" in "Apply" for
    ///   a button.
    /// - The sequence is the full list of keys which invoke the action even if the
    ///   relevant element is not currently shown on screen. For instance, for a menu
    ///   item the sequence is the keybindings used to open the parent menus before
    ///   invoking. The sequence string is colon-delimited. Example: "Alt+F:N" in a
    ///   traditional "New..." menu item.
    /// - The shortcut, if it exists, will invoke the same action without showing
    ///   the component or its enclosing menus or dialogs. Example: "Ctrl+N" in a
    ///   traditional "New..." menu item.
    ///
    /// Example: For a traditional "New..." menu item, the expected return value
    /// would be: "N;Alt+F:N;Ctrl+N" for the English locale and "N;Alt+D:N;Strg+N"
    /// for the German locale. If, hypothetically, this menu item lacked a mnemonic,
    /// it would be represented by ";;Ctrl+N" and ";;Strg+N" respectively.
    extern fn atk_action_get_keybinding(p_action: *Action, p_i: c_int) ?[*:0]const u8;
    pub const getKeybinding = atk_action_get_keybinding;

    /// Returns the localized name of the specified action of the object.
    extern fn atk_action_get_localized_name(p_action: *Action, p_i: c_int) ?[*:0]const u8;
    pub const getLocalizedName = atk_action_get_localized_name;

    /// Gets the number of accessible actions available on the object.
    /// If there are more than one, the first one is considered the
    /// "default" action of the object.
    extern fn atk_action_get_n_actions(p_action: *Action) c_int;
    pub const getNActions = atk_action_get_n_actions;

    /// Returns a non-localized string naming the specified action of the
    /// object. This name is generally not descriptive of the end result
    /// of the action, but instead names the 'interaction type' which the
    /// object supports. By convention, the above strings should be used to
    /// represent the actions which correspond to the common point-and-click
    /// interaction techniques of the same name: i.e.
    /// "click", "press", "release", "drag", "drop", "popup", etc.
    /// The "popup" action should be used to pop up a context menu for the
    /// object, if one exists.
    ///
    /// For technical reasons, some toolkits cannot guarantee that the
    /// reported action is actually 'bound' to a nontrivial user event;
    /// i.e. the result of some actions via `atk.Action.doAction` may be
    /// NIL.
    extern fn atk_action_get_name(p_action: *Action, p_i: c_int) ?[*:0]const u8;
    pub const getName = atk_action_get_name;

    /// Sets a description of the specified action of the object.
    extern fn atk_action_set_description(p_action: *Action, p_i: c_int, p_desc: [*:0]const u8) c_int;
    pub const setDescription = atk_action_set_description;

    extern fn atk_action_get_type() usize;
    pub const getGObjectType = atk_action_get_type;

    extern fn g_object_ref(p_self: *atk.Action) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Action) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Action, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface provided by UI components
/// which occupy a physical area on the screen.
/// which the user can activate/interact with.
///
/// `atk.Component` should be implemented by most if not all UI elements
/// with an actual on-screen presence, i.e. components which can be
/// said to have a screen-coordinate bounding box.  Virtually all
/// widgets will need to have `atk.Component` implementations provided
/// for their corresponding `atk.Object` class.  In short, only UI
/// elements which are *not* GUI elements will omit this ATK interface.
///
/// A possible exception might be textual information with a
/// transparent background, in which case text glyph bounding box
/// information is provided by `atk.Text`.
pub const Component = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.ComponentIface;
    pub const virtual_methods = struct {
        /// Add the specified handler to the set of functions to be called
        /// when this object receives focus events (in or out). If the handler is
        /// already added it is not added again
        pub const add_focus_handler = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler: atk.FocusHandler) c_uint {
                return gobject.ext.as(Component.Iface, p_class).f_add_focus_handler.?(gobject.ext.as(Component, p_component), p_handler);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler: atk.FocusHandler) callconv(.c) c_uint) void {
                gobject.ext.as(Component.Iface, p_class).f_add_focus_handler = @ptrCast(p_implementation);
            }
        };

        pub const bounds_changed = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_bounds: *atk.Rectangle) void {
                return gobject.ext.as(Component.Iface, p_class).f_bounds_changed.?(gobject.ext.as(Component, p_component), p_bounds);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_bounds: *atk.Rectangle) callconv(.c) void) void {
                gobject.ext.as(Component.Iface, p_class).f_bounds_changed = @ptrCast(p_implementation);
            }
        };

        /// Checks whether the specified point is within the extent of the `component`.
        ///
        /// Toolkit implementor note: ATK provides a default implementation for
        /// this virtual method. In general there are little reason to
        /// re-implement it.
        pub const contains = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_contains.?(gobject.ext.as(Component, p_component), p_x, p_y, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_contains = @ptrCast(p_implementation);
            }
        };

        /// Returns the alpha value (i.e. the opacity) for this
        /// `component`, on a scale from 0 (fully transparent) to 1.0
        /// (fully opaque).
        pub const get_alpha = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Component.Iface, p_class).f_get_alpha.?(gobject.ext.as(Component, p_component));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Component.Iface, p_class).f_get_alpha = @ptrCast(p_implementation);
            }
        };

        /// Gets the rectangle which gives the extent of the `component`.
        ///
        /// If the extent can not be obtained (e.g. a non-embedded plug or missing
        /// support), all of x, y, width, height are set to -1.
        pub const get_extents = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coord_type: atk.CoordType) void {
                return gobject.ext.as(Component.Iface, p_class).f_get_extents.?(gobject.ext.as(Component, p_component), p_x, p_y, p_width, p_height, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void) void {
                gobject.ext.as(Component.Iface, p_class).f_get_extents = @ptrCast(p_implementation);
            }
        };

        /// Gets the layer of the component.
        pub const get_layer = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) atk.Layer {
                return gobject.ext.as(Component.Iface, p_class).f_get_layer.?(gobject.ext.as(Component, p_component));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) atk.Layer) void {
                gobject.ext.as(Component.Iface, p_class).f_get_layer = @ptrCast(p_implementation);
            }
        };

        /// Gets the zorder of the component. The value G_MININT will be returned
        /// if the layer of the component is not ATK_LAYER_MDI or ATK_LAYER_WINDOW.
        pub const get_mdi_zorder = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_get_mdi_zorder.?(gobject.ext.as(Component, p_component));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_get_mdi_zorder = @ptrCast(p_implementation);
            }
        };

        /// Gets the position of `component` in the form of
        /// a point specifying `component`'s top-left corner.
        ///
        /// If the position can not be obtained (e.g. a non-embedded plug or missing
        /// support), x and y are set to -1.
        pub const get_position = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) void {
                return gobject.ext.as(Component.Iface, p_class).f_get_position.?(gobject.ext.as(Component, p_component), p_x, p_y, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void) void {
                gobject.ext.as(Component.Iface, p_class).f_get_position = @ptrCast(p_implementation);
            }
        };

        /// Gets the size of the `component` in terms of width and height.
        ///
        /// If the size can not be obtained (e.g. a non-embedded plug or missing
        /// support), width and height are set to -1.
        pub const get_size = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: ?*c_int, p_height: ?*c_int) void {
                return gobject.ext.as(Component.Iface, p_class).f_get_size.?(gobject.ext.as(Component, p_component), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: ?*c_int, p_height: ?*c_int) callconv(.c) void) void {
                gobject.ext.as(Component.Iface, p_class).f_get_size = @ptrCast(p_implementation);
            }
        };

        /// Grabs focus for this `component`.
        pub const grab_focus = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_grab_focus.?(gobject.ext.as(Component, p_component));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_grab_focus = @ptrCast(p_implementation);
            }
        };

        /// Gets a reference to the accessible child, if one exists, at the
        /// coordinate point specified by `x` and `y`.
        pub const ref_accessible_at_point = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) ?*atk.Object {
                return gobject.ext.as(Component.Iface, p_class).f_ref_accessible_at_point.?(gobject.ext.as(Component, p_component), p_x, p_y, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) ?*atk.Object) void {
                gobject.ext.as(Component.Iface, p_class).f_ref_accessible_at_point = @ptrCast(p_implementation);
            }
        };

        /// Remove the handler specified by `handler_id` from the list of
        /// functions to be executed when this object receives focus events
        /// (in or out).
        pub const remove_focus_handler = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler_id: c_uint) void {
                return gobject.ext.as(Component.Iface, p_class).f_remove_focus_handler.?(gobject.ext.as(Component, p_component), p_handler_id);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_handler_id: c_uint) callconv(.c) void) void {
                gobject.ext.as(Component.Iface, p_class).f_remove_focus_handler = @ptrCast(p_implementation);
            }
        };

        /// Makes `component` visible on the screen by scrolling all necessary parents.
        ///
        /// Contrary to atk_component_set_position, this does not actually move
        /// `component` in its parent, this only makes the parents scroll so that the
        /// object shows up on the screen, given its current position within the parents.
        pub const scroll_to = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_type: atk.ScrollType) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_scroll_to.?(gobject.ext.as(Component, p_component), p_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_type: atk.ScrollType) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_scroll_to = @ptrCast(p_implementation);
            }
        };

        /// Move the top-left of `component` to a given position of the screen by
        /// scrolling all necessary parents.
        pub const scroll_to_point = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_scroll_to_point.?(gobject.ext.as(Component, p_component), p_coords, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_scroll_to_point = @ptrCast(p_implementation);
            }
        };

        /// Sets the extents of `component`.
        pub const set_extents = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_coord_type: atk.CoordType) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_set_extents.?(gobject.ext.as(Component, p_component), p_x, p_y, p_width, p_height, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_set_extents = @ptrCast(p_implementation);
            }
        };

        /// Sets the position of `component`.
        ///
        /// Contrary to atk_component_scroll_to, this does not trigger any scrolling,
        /// this just moves `component` in its parent.
        pub const set_position = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_set_position.?(gobject.ext.as(Component, p_component), p_x, p_y, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_set_position = @ptrCast(p_implementation);
            }
        };

        /// Set the size of the `component` in terms of width and height.
        pub const set_size = struct {
            pub fn call(p_class: anytype, p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) c_int {
                return gobject.ext.as(Component.Iface, p_class).f_set_size.?(gobject.ext.as(Component, p_component), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_component: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: c_int, p_height: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Component.Iface, p_class).f_set_size = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The 'bounds-changed" signal is emitted when the position or
        /// size of the component changes.
        pub const bounds_changed = struct {
            pub const name = "bounds-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: *atk.Rectangle, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Component, p_instance))),
                    gobject.signalLookup("bounds-changed", Component.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Add the specified handler to the set of functions to be called
    /// when this object receives focus events (in or out). If the handler is
    /// already added it is not added again
    extern fn atk_component_add_focus_handler(p_component: *Component, p_handler: atk.FocusHandler) c_uint;
    pub const addFocusHandler = atk_component_add_focus_handler;

    /// Checks whether the specified point is within the extent of the `component`.
    ///
    /// Toolkit implementor note: ATK provides a default implementation for
    /// this virtual method. In general there are little reason to
    /// re-implement it.
    extern fn atk_component_contains(p_component: *Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) c_int;
    pub const contains = atk_component_contains;

    /// Returns the alpha value (i.e. the opacity) for this
    /// `component`, on a scale from 0 (fully transparent) to 1.0
    /// (fully opaque).
    extern fn atk_component_get_alpha(p_component: *Component) f64;
    pub const getAlpha = atk_component_get_alpha;

    /// Gets the rectangle which gives the extent of the `component`.
    ///
    /// If the extent can not be obtained (e.g. a non-embedded plug or missing
    /// support), all of x, y, width, height are set to -1.
    extern fn atk_component_get_extents(p_component: *Component, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coord_type: atk.CoordType) void;
    pub const getExtents = atk_component_get_extents;

    /// Gets the layer of the component.
    extern fn atk_component_get_layer(p_component: *Component) atk.Layer;
    pub const getLayer = atk_component_get_layer;

    /// Gets the zorder of the component. The value G_MININT will be returned
    /// if the layer of the component is not ATK_LAYER_MDI or ATK_LAYER_WINDOW.
    extern fn atk_component_get_mdi_zorder(p_component: *Component) c_int;
    pub const getMdiZorder = atk_component_get_mdi_zorder;

    /// Gets the position of `component` in the form of
    /// a point specifying `component`'s top-left corner.
    ///
    /// If the position can not be obtained (e.g. a non-embedded plug or missing
    /// support), x and y are set to -1.
    extern fn atk_component_get_position(p_component: *Component, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) void;
    pub const getPosition = atk_component_get_position;

    /// Gets the size of the `component` in terms of width and height.
    ///
    /// If the size can not be obtained (e.g. a non-embedded plug or missing
    /// support), width and height are set to -1.
    extern fn atk_component_get_size(p_component: *Component, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getSize = atk_component_get_size;

    /// Grabs focus for this `component`.
    extern fn atk_component_grab_focus(p_component: *Component) c_int;
    pub const grabFocus = atk_component_grab_focus;

    /// Gets a reference to the accessible child, if one exists, at the
    /// coordinate point specified by `x` and `y`.
    extern fn atk_component_ref_accessible_at_point(p_component: *Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) ?*atk.Object;
    pub const refAccessibleAtPoint = atk_component_ref_accessible_at_point;

    /// Remove the handler specified by `handler_id` from the list of
    /// functions to be executed when this object receives focus events
    /// (in or out).
    extern fn atk_component_remove_focus_handler(p_component: *Component, p_handler_id: c_uint) void;
    pub const removeFocusHandler = atk_component_remove_focus_handler;

    /// Makes `component` visible on the screen by scrolling all necessary parents.
    ///
    /// Contrary to atk_component_set_position, this does not actually move
    /// `component` in its parent, this only makes the parents scroll so that the
    /// object shows up on the screen, given its current position within the parents.
    extern fn atk_component_scroll_to(p_component: *Component, p_type: atk.ScrollType) c_int;
    pub const scrollTo = atk_component_scroll_to;

    /// Move the top-left of `component` to a given position of the screen by
    /// scrolling all necessary parents.
    extern fn atk_component_scroll_to_point(p_component: *Component, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) c_int;
    pub const scrollToPoint = atk_component_scroll_to_point;

    /// Sets the extents of `component`.
    extern fn atk_component_set_extents(p_component: *Component, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_coord_type: atk.CoordType) c_int;
    pub const setExtents = atk_component_set_extents;

    /// Sets the position of `component`.
    ///
    /// Contrary to atk_component_scroll_to, this does not trigger any scrolling,
    /// this just moves `component` in its parent.
    extern fn atk_component_set_position(p_component: *Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) c_int;
    pub const setPosition = atk_component_set_position;

    /// Set the size of the `component` in terms of width and height.
    extern fn atk_component_set_size(p_component: *Component, p_width: c_int, p_height: c_int) c_int;
    pub const setSize = atk_component_set_size;

    extern fn atk_component_get_type() usize;
    pub const getGObjectType = atk_component_get_type;

    extern fn g_object_ref(p_self: *atk.Component) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Component) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Component, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface which represents the toplevel
///  container for document content.
///
/// The AtkDocument interface should be supported by any object whose
/// content is a representation or view of a document.  The AtkDocument
/// interface should appear on the toplevel container for the document
/// content; however AtkDocument instances may be nested (i.e. an
/// AtkDocument may be a descendant of another AtkDocument) in those
/// cases where one document contains "embedded content" which can
/// reasonably be considered a document in its own right.
pub const Document = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.DocumentIface;
    pub const virtual_methods = struct {
        /// Retrieves the current page number inside `document`.
        pub const get_current_page_number = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Document.Iface, p_class).f_get_current_page_number.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Document.Iface, p_class).f_get_current_page_number = @ptrCast(p_implementation);
            }
        };

        /// Gets a `gpointer` that points to an instance of the DOM.  It is
        /// up to the caller to check atk_document_get_type to determine
        /// how to cast this pointer.
        pub const get_document = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*anyopaque {
                return gobject.ext.as(Document.Iface, p_class).f_get_document.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*anyopaque) void {
                gobject.ext.as(Document.Iface, p_class).f_get_document = @ptrCast(p_implementation);
            }
        };

        /// Retrieves the value of the given `attribute_name` inside `document`.
        pub const get_document_attribute_value = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8) ?[*:0]const u8 {
                return gobject.ext.as(Document.Iface, p_class).f_get_document_attribute_value.?(gobject.ext.as(Document, p_document), p_attribute_name);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Document.Iface, p_class).f_get_document_attribute_value = @ptrCast(p_implementation);
            }
        };

        /// Gets an AtkAttributeSet which describes document-wide
        ///          attributes as name-value pairs.
        pub const get_document_attributes = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.AttributeSet {
                return gobject.ext.as(Document.Iface, p_class).f_get_document_attributes.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.AttributeSet) void {
                gobject.ext.as(Document.Iface, p_class).f_get_document_attributes = @ptrCast(p_implementation);
            }
        };

        /// Gets a UTF-8 string indicating the POSIX-style LC_MESSAGES locale
        ///          of the content of this document instance.  Individual
        ///          text substrings or images within this document may have
        ///          a different locale, see atk_text_get_attributes and
        ///          atk_image_get_image_locale.
        pub const get_document_locale = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Document.Iface, p_class).f_get_document_locale.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Document.Iface, p_class).f_get_document_locale = @ptrCast(p_implementation);
            }
        };

        /// Gets a string indicating the document type.
        pub const get_document_type = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Document.Iface, p_class).f_get_document_type.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Document.Iface, p_class).f_get_document_type = @ptrCast(p_implementation);
            }
        };

        /// Retrieves the total number of pages inside `document`.
        pub const get_page_count = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Document.Iface, p_class).f_get_page_count.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Document.Iface, p_class).f_get_page_count = @ptrCast(p_implementation);
            }
        };

        /// Returns an array of AtkTextSelections within this document.
        pub const get_text_selections = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.Array {
                return gobject.ext.as(Document.Iface, p_class).f_get_text_selections.?(gobject.ext.as(Document, p_document));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.Array) void {
                gobject.ext.as(Document.Iface, p_class).f_get_text_selections = @ptrCast(p_implementation);
            }
        };

        /// Sets the value for the given `attribute_name` inside `document`.
        pub const set_document_attribute = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8, p_attribute_value: [*:0]const u8) c_int {
                return gobject.ext.as(Document.Iface, p_class).f_set_document_attribute.?(gobject.ext.as(Document, p_document), p_attribute_name, p_attribute_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attribute_name: [*:0]const u8, p_attribute_value: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Document.Iface, p_class).f_set_document_attribute = @ptrCast(p_implementation);
            }
        };

        /// Makes 1 or more selections within this document denoted by the given
        /// array of AtkTextSelections. Any existing physical selection (inside or
        /// outside this document) is replaced by the new selections. All objects within
        /// the given selection ranges must be descendants of this document. Otherwise
        /// FALSE will be returned.
        pub const set_text_selections = struct {
            pub fn call(p_class: anytype, p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selections: *glib.Array) c_int {
                return gobject.ext.as(Document.Iface, p_class).f_set_text_selections.?(gobject.ext.as(Document, p_document), p_selections);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_document: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selections: *glib.Array) callconv(.c) c_int) void {
                gobject.ext.as(Document.Iface, p_class).f_set_text_selections = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "document-attribute-changed" signal should be emitted when there is a
        /// change to one of the document attributes returned by
        /// atk_document_get_attributes.
        pub const document_attribute_changed = struct {
            pub const name = "document-attribute-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: [*:0]u8, p_arg2: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Document, p_instance))),
                    gobject.signalLookup("document-attribute-changed", Document.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The 'load-complete' signal is emitted when a pending load of
        /// a static document has completed.  This signal is to be
        /// expected by ATK clients if and when AtkDocument implementors
        /// expose ATK_STATE_BUSY.  If the state of an AtkObject which
        /// implements AtkDocument does not include ATK_STATE_BUSY, it
        /// should be safe for clients to assume that the AtkDocument's
        /// static contents are fully loaded into the container.
        /// (Dynamic document contents should be exposed via other
        /// signals.)
        pub const load_complete = struct {
            pub const name = "load-complete";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Document, p_instance))),
                    gobject.signalLookup("load-complete", Document.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The 'load-stopped' signal is emitted when a pending load of
        /// document contents is cancelled, paused, or otherwise
        /// interrupted by the user or application logic.  It should not
        /// however be emitted while waiting for a resource (for instance
        /// while blocking on a file or network read) unless a
        /// user-significant timeout has occurred.
        pub const load_stopped = struct {
            pub const name = "load-stopped";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Document, p_instance))),
                    gobject.signalLookup("load-stopped", Document.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The 'page-changed' signal is emitted when the current page of
        /// a document changes, e.g. pressing page up/down in a document
        /// viewer.
        pub const page_changed = struct {
            pub const name = "page-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_page_number: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Document, p_instance))),
                    gobject.signalLookup("page-changed", Document.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The 'reload' signal is emitted when the contents of a
        /// document is refreshed from its source.  Once 'reload' has
        /// been emitted, a matching 'load-complete' or 'load-stopped'
        /// signal should follow, which clients may await before
        /// interrogating ATK for the latest document content.
        pub const reload = struct {
            pub const name = "reload";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Document, p_instance))),
                    gobject.signalLookup("reload", Document.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Retrieves the value of the given `attribute_name` inside `document`.
    extern fn atk_document_get_attribute_value(p_document: *Document, p_attribute_name: [*:0]const u8) ?[*:0]const u8;
    pub const getAttributeValue = atk_document_get_attribute_value;

    /// Gets an AtkAttributeSet which describes document-wide
    ///          attributes as name-value pairs.
    extern fn atk_document_get_attributes(p_document: *Document) *atk.AttributeSet;
    pub const getAttributes = atk_document_get_attributes;

    /// Retrieves the current page number inside `document`.
    extern fn atk_document_get_current_page_number(p_document: *Document) c_int;
    pub const getCurrentPageNumber = atk_document_get_current_page_number;

    /// Gets a `gpointer` that points to an instance of the DOM.  It is
    /// up to the caller to check atk_document_get_type to determine
    /// how to cast this pointer.
    extern fn atk_document_get_document(p_document: *Document) ?*anyopaque;
    pub const getDocument = atk_document_get_document;

    /// Gets a string indicating the document type.
    extern fn atk_document_get_document_type(p_document: *Document) [*:0]const u8;
    pub const getDocumentType = atk_document_get_document_type;

    /// Gets a UTF-8 string indicating the POSIX-style LC_MESSAGES locale
    ///          of the content of this document instance.  Individual
    ///          text substrings or images within this document may have
    ///          a different locale, see atk_text_get_attributes and
    ///          atk_image_get_image_locale.
    extern fn atk_document_get_locale(p_document: *Document) [*:0]const u8;
    pub const getLocale = atk_document_get_locale;

    /// Retrieves the total number of pages inside `document`.
    extern fn atk_document_get_page_count(p_document: *Document) c_int;
    pub const getPageCount = atk_document_get_page_count;

    /// Returns an array of AtkTextSelections within this document.
    extern fn atk_document_get_text_selections(p_document: *Document) *glib.Array;
    pub const getTextSelections = atk_document_get_text_selections;

    /// Sets the value for the given `attribute_name` inside `document`.
    extern fn atk_document_set_attribute_value(p_document: *Document, p_attribute_name: [*:0]const u8, p_attribute_value: [*:0]const u8) c_int;
    pub const setAttributeValue = atk_document_set_attribute_value;

    /// Makes 1 or more selections within this document denoted by the given
    /// array of AtkTextSelections. Any existing physical selection (inside or
    /// outside this document) is replaced by the new selections. All objects within
    /// the given selection ranges must be descendants of this document. Otherwise
    /// FALSE will be returned.
    extern fn atk_document_set_text_selections(p_document: *Document, p_selections: *glib.Array) c_int;
    pub const setTextSelections = atk_document_set_text_selections;

    extern fn atk_document_get_type() usize;
    pub const getGObjectType = atk_document_get_type;

    extern fn g_object_ref(p_self: *atk.Document) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Document) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Document, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented by components containing user-editable text content.
///
/// `atk.EditableText` should be implemented by UI components which
/// contain text which the user can edit, via the `atk.Object`
/// corresponding to that component (see `atk.Object`).
///
/// `atk.EditableText` is a subclass of `atk.Text`, and as such, an object
/// which implements `atk.EditableText` is by definition an `atk.Text`
/// implementor as well.
///
/// See `AtkText`
pub const EditableText = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.EditableTextIface;
    pub const virtual_methods = struct {
        /// Copy text from `start_pos` up to, but not including `end_pos`
        /// to the clipboard.
        pub const copy_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_copy_text.?(gobject.ext.as(EditableText, p_text), p_start_pos, p_end_pos);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_copy_text = @ptrCast(p_implementation);
            }
        };

        /// Copy text from `start_pos` up to, but not including `end_pos`
        /// to the clipboard and then delete from the widget.
        pub const cut_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_cut_text.?(gobject.ext.as(EditableText, p_text), p_start_pos, p_end_pos);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_cut_text = @ptrCast(p_implementation);
            }
        };

        /// Delete text `start_pos` up to, but not including `end_pos`.
        pub const delete_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_delete_text.?(gobject.ext.as(EditableText, p_text), p_start_pos, p_end_pos);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_delete_text = @ptrCast(p_implementation);
            }
        };

        /// Insert text at a given position.
        pub const insert_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_string: [*:0]const u8, p_length: c_int, p_position: *c_int) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_insert_text.?(gobject.ext.as(EditableText, p_text), p_string, p_length, p_position);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_string: [*:0]const u8, p_length: c_int, p_position: *c_int) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_insert_text = @ptrCast(p_implementation);
            }
        };

        /// Paste text from clipboard to specified `position`.
        pub const paste_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: c_int) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_paste_text.?(gobject.ext.as(EditableText, p_text), p_position);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: c_int) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_paste_text = @ptrCast(p_implementation);
            }
        };

        /// Sets the attributes for a specified range. See the ATK_ATTRIBUTE
        /// macros (such as `ATK_ATTRIBUTE_LEFT_MARGIN`) for examples of attributes
        /// that can be set. Note that other attributes that do not have corresponding
        /// ATK_ATTRIBUTE macros may also be set for certain text widgets.
        pub const set_run_attributes = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attrib_set: *atk.AttributeSet, p_start_offset: c_int, p_end_offset: c_int) c_int {
                return gobject.ext.as(EditableText.Iface, p_class).f_set_run_attributes.?(gobject.ext.as(EditableText, p_text), p_attrib_set, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_attrib_set: *atk.AttributeSet, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int) void {
                gobject.ext.as(EditableText.Iface, p_class).f_set_run_attributes = @ptrCast(p_implementation);
            }
        };

        /// Set text contents of `text`.
        pub const set_text_contents = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_string: [*:0]const u8) void {
                return gobject.ext.as(EditableText.Iface, p_class).f_set_text_contents.?(gobject.ext.as(EditableText, p_text), p_string);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_string: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(EditableText.Iface, p_class).f_set_text_contents = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Copy text from `start_pos` up to, but not including `end_pos`
    /// to the clipboard.
    extern fn atk_editable_text_copy_text(p_text: *EditableText, p_start_pos: c_int, p_end_pos: c_int) void;
    pub const copyText = atk_editable_text_copy_text;

    /// Copy text from `start_pos` up to, but not including `end_pos`
    /// to the clipboard and then delete from the widget.
    extern fn atk_editable_text_cut_text(p_text: *EditableText, p_start_pos: c_int, p_end_pos: c_int) void;
    pub const cutText = atk_editable_text_cut_text;

    /// Delete text `start_pos` up to, but not including `end_pos`.
    extern fn atk_editable_text_delete_text(p_text: *EditableText, p_start_pos: c_int, p_end_pos: c_int) void;
    pub const deleteText = atk_editable_text_delete_text;

    /// Insert text at a given position.
    extern fn atk_editable_text_insert_text(p_text: *EditableText, p_string: [*:0]const u8, p_length: c_int, p_position: *c_int) void;
    pub const insertText = atk_editable_text_insert_text;

    /// Paste text from clipboard to specified `position`.
    extern fn atk_editable_text_paste_text(p_text: *EditableText, p_position: c_int) void;
    pub const pasteText = atk_editable_text_paste_text;

    /// Sets the attributes for a specified range. See the ATK_ATTRIBUTE
    /// macros (such as `ATK_ATTRIBUTE_LEFT_MARGIN`) for examples of attributes
    /// that can be set. Note that other attributes that do not have corresponding
    /// ATK_ATTRIBUTE macros may also be set for certain text widgets.
    extern fn atk_editable_text_set_run_attributes(p_text: *EditableText, p_attrib_set: *atk.AttributeSet, p_start_offset: c_int, p_end_offset: c_int) c_int;
    pub const setRunAttributes = atk_editable_text_set_run_attributes;

    /// Set text contents of `text`.
    extern fn atk_editable_text_set_text_contents(p_text: *EditableText, p_string: [*:0]const u8) void;
    pub const setTextContents = atk_editable_text_set_text_contents;

    extern fn atk_editable_text_get_type() usize;
    pub const getGObjectType = atk_editable_text_get_type;

    extern fn g_object_ref(p_self: *atk.EditableText) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.EditableText) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *EditableText, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A queryable interface which allows AtkHyperlink instances
/// associated with an AtkObject to be obtained.  AtkHyperlinkImpl
/// corresponds to AT-SPI's Hyperlink interface, and differs from
/// AtkHyperlink in that AtkHyperlink is an object type, rather than an
/// interface, and thus cannot be directly queried. FTW
pub const HyperlinkImpl = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.HyperlinkImplIface;
    pub const virtual_methods = struct {
        /// Gets the hyperlink associated with this object.
        pub const get_hyperlink = struct {
            pub fn call(p_class: anytype, p_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.Hyperlink {
                return gobject.ext.as(HyperlinkImpl.Iface, p_class).f_get_hyperlink.?(gobject.ext.as(HyperlinkImpl, p_impl));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_impl: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.Hyperlink) void {
                gobject.ext.as(HyperlinkImpl.Iface, p_class).f_get_hyperlink = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the hyperlink associated with this object.
    extern fn atk_hyperlink_impl_get_hyperlink(p_impl: *HyperlinkImpl) *atk.Hyperlink;
    pub const getHyperlink = atk_hyperlink_impl_get_hyperlink;

    extern fn atk_hyperlink_impl_get_type() usize;
    pub const getGObjectType = atk_hyperlink_impl_get_type;

    extern fn g_object_ref(p_self: *atk.HyperlinkImpl) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.HyperlinkImpl) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *HyperlinkImpl, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface which provides standard mechanism for manipulating hyperlinks.
///
/// An interface used for objects which implement linking between
/// multiple resource or content locations, or multiple 'markers'
/// within a single document.  A Hypertext instance is associated with
/// one or more Hyperlinks, which are associated with particular
/// offsets within the Hypertext's included content.  While this
/// interface is derived from Text, there is no requirement that
/// Hypertext instances have textual content; they may implement Image
/// as well, and Hyperlinks need not have non-zero text offsets.
pub const Hypertext = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.HypertextIface;
    pub const virtual_methods = struct {
        /// Gets the link in this hypertext document at index
        /// `link_index`
        pub const get_link = struct {
            pub fn call(p_class: anytype, p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_link_index: c_int) *atk.Hyperlink {
                return gobject.ext.as(Hypertext.Iface, p_class).f_get_link.?(gobject.ext.as(Hypertext, p_hypertext), p_link_index);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_link_index: c_int) callconv(.c) *atk.Hyperlink) void {
                gobject.ext.as(Hypertext.Iface, p_class).f_get_link = @ptrCast(p_implementation);
            }
        };

        /// Gets the index into the array of hyperlinks that is associated with
        /// the character specified by `char_index`.
        pub const get_link_index = struct {
            pub fn call(p_class: anytype, p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_char_index: c_int) c_int {
                return gobject.ext.as(Hypertext.Iface, p_class).f_get_link_index.?(gobject.ext.as(Hypertext, p_hypertext), p_char_index);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_char_index: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Hypertext.Iface, p_class).f_get_link_index = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of links within this hypertext document.
        pub const get_n_links = struct {
            pub fn call(p_class: anytype, p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Hypertext.Iface, p_class).f_get_n_links.?(gobject.ext.as(Hypertext, p_hypertext));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Hypertext.Iface, p_class).f_get_n_links = @ptrCast(p_implementation);
            }
        };

        pub const link_selected = struct {
            pub fn call(p_class: anytype, p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_link_index: c_int) void {
                return gobject.ext.as(Hypertext.Iface, p_class).f_link_selected.?(gobject.ext.as(Hypertext, p_hypertext), p_link_index);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_hypertext: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_link_index: c_int) callconv(.c) void) void {
                gobject.ext.as(Hypertext.Iface, p_class).f_link_selected = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "link-selected" signal is emitted by an AtkHyperText
        /// object when one of the hyperlinks associated with the object
        /// is selected.
        pub const link_selected = struct {
            pub const name = "link-selected";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Hypertext, p_instance))),
                    gobject.signalLookup("link-selected", Hypertext.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the link in this hypertext document at index
    /// `link_index`
    extern fn atk_hypertext_get_link(p_hypertext: *Hypertext, p_link_index: c_int) *atk.Hyperlink;
    pub const getLink = atk_hypertext_get_link;

    /// Gets the index into the array of hyperlinks that is associated with
    /// the character specified by `char_index`.
    extern fn atk_hypertext_get_link_index(p_hypertext: *Hypertext, p_char_index: c_int) c_int;
    pub const getLinkIndex = atk_hypertext_get_link_index;

    /// Gets the number of links within this hypertext document.
    extern fn atk_hypertext_get_n_links(p_hypertext: *Hypertext) c_int;
    pub const getNLinks = atk_hypertext_get_n_links;

    extern fn atk_hypertext_get_type() usize;
    pub const getGObjectType = atk_hypertext_get_type;

    extern fn g_object_ref(p_self: *atk.Hypertext) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Hypertext) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Hypertext, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK Interface implemented by components
///  which expose image or pixmap content on-screen.
///
/// `atk.Image` should be implemented by `atk.Object` subtypes on behalf of
/// components which display image/pixmap information onscreen, and
/// which provide information (other than just widget borders, etc.)
/// via that image content.  For instance, icons, buttons with icons,
/// toolbar elements, and image viewing panes typically should
/// implement `atk.Image`.
///
/// `atk.Image` primarily provides two types of information: coordinate
/// information (useful for screen review mode of screenreaders, and
/// for use by onscreen magnifiers), and descriptive information.  The
/// descriptive information is provided for alternative, text-only
/// presentation of the most significant information present in the
/// image.
pub const Image = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.ImageIface;
    pub const virtual_methods = struct {
        /// Get a textual description of this image.
        pub const get_image_description = struct {
            pub fn call(p_class: anytype, p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) [*:0]const u8 {
                return gobject.ext.as(Image.Iface, p_class).f_get_image_description.?(gobject.ext.as(Image, p_image));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Image.Iface, p_class).f_get_image_description = @ptrCast(p_implementation);
            }
        };

        /// Retrieves the locale identifier associated to the `atk.Image`.
        pub const get_image_locale = struct {
            pub fn call(p_class: anytype, p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?[*:0]const u8 {
                return gobject.ext.as(Image.Iface, p_class).f_get_image_locale.?(gobject.ext.as(Image, p_image));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Image.Iface, p_class).f_get_image_locale = @ptrCast(p_implementation);
            }
        };

        /// Gets the position of the image in the form of a point specifying the
        /// images top-left corner.
        ///
        /// If the position can not be obtained (e.g. missing support), x and y are set
        /// to -1.
        pub const get_image_position = struct {
            pub fn call(p_class: anytype, p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) void {
                return gobject.ext.as(Image.Iface, p_class).f_get_image_position.?(gobject.ext.as(Image, p_image), p_x, p_y, p_coord_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void) void {
                gobject.ext.as(Image.Iface, p_class).f_get_image_position = @ptrCast(p_implementation);
            }
        };

        /// Get the width and height in pixels for the specified image.
        /// The values of `width` and `height` are returned as -1 if the
        /// values cannot be obtained (for instance, if the object is not onscreen).
        ///
        /// If the size can not be obtained (e.g. missing support), x and y are set
        /// to -1.
        pub const get_image_size = struct {
            pub fn call(p_class: anytype, p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: ?*c_int, p_height: ?*c_int) void {
                return gobject.ext.as(Image.Iface, p_class).f_get_image_size.?(gobject.ext.as(Image, p_image), p_width, p_height);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_width: ?*c_int, p_height: ?*c_int) callconv(.c) void) void {
                gobject.ext.as(Image.Iface, p_class).f_get_image_size = @ptrCast(p_implementation);
            }
        };

        /// Sets the textual description for this image.
        pub const set_image_description = struct {
            pub fn call(p_class: anytype, p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_description: [*:0]const u8) c_int {
                return gobject.ext.as(Image.Iface, p_class).f_set_image_description.?(gobject.ext.as(Image, p_image), p_description);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_image: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_description: [*:0]const u8) callconv(.c) c_int) void {
                gobject.ext.as(Image.Iface, p_class).f_set_image_description = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Get a textual description of this image.
    extern fn atk_image_get_image_description(p_image: *Image) [*:0]const u8;
    pub const getImageDescription = atk_image_get_image_description;

    /// Retrieves the locale identifier associated to the `atk.Image`.
    extern fn atk_image_get_image_locale(p_image: *Image) ?[*:0]const u8;
    pub const getImageLocale = atk_image_get_image_locale;

    /// Gets the position of the image in the form of a point specifying the
    /// images top-left corner.
    ///
    /// If the position can not be obtained (e.g. missing support), x and y are set
    /// to -1.
    extern fn atk_image_get_image_position(p_image: *Image, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) void;
    pub const getImagePosition = atk_image_get_image_position;

    /// Get the width and height in pixels for the specified image.
    /// The values of `width` and `height` are returned as -1 if the
    /// values cannot be obtained (for instance, if the object is not onscreen).
    ///
    /// If the size can not be obtained (e.g. missing support), x and y are set
    /// to -1.
    extern fn atk_image_get_image_size(p_image: *Image, p_width: ?*c_int, p_height: ?*c_int) void;
    pub const getImageSize = atk_image_get_image_size;

    /// Sets the textual description for this image.
    extern fn atk_image_set_image_description(p_image: *Image, p_description: [*:0]const u8) c_int;
    pub const setImageDescription = atk_image_set_image_description;

    extern fn atk_image_get_type() usize;
    pub const getGObjectType = atk_image_get_type;

    extern fn g_object_ref(p_self: *atk.Image) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Image) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Image, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The AtkImplementor interface is implemented by objects for which
/// AtkObject peers may be obtained via calls to
/// iface->(ref_accessible)(implementor);
pub const ImplementorIface = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = opaque {
        pub const Instance = ImplementorIface;
    };
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {};

    extern fn atk_implementor_get_type() usize;
    pub const getGObjectType = atk_implementor_get_type;

    extern fn g_object_ref(p_self: *atk.ImplementorIface) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.ImplementorIface) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *ImplementorIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented by container objects whose `atk.Object` children can be selected.
///
/// `atk.Selection` should be implemented by UI components with children
/// which are exposed by `atk_object_ref_child` and
/// `atk_object_get_n_children`, if the use of the parent UI component
/// ordinarily involves selection of one or more of the objects
/// corresponding to those `atk.Object` children - for example,
/// selectable lists.
///
/// Note that other types of "selection" (for instance text selection)
/// are accomplished a other ATK interfaces - `atk.Selection` is limited
/// to the selection/deselection of children.
pub const Selection = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.SelectionIface;
    pub const virtual_methods = struct {
        /// Adds the specified accessible child of the object to the
        /// object's selection.
        pub const add_selection = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_add_selection.?(gobject.ext.as(Selection, p_selection), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_add_selection = @ptrCast(p_implementation);
            }
        };

        /// Clears the selection in the object so that no children in the object
        /// are selected.
        pub const clear_selection = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_clear_selection.?(gobject.ext.as(Selection, p_selection));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_clear_selection = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of accessible children currently selected.
        /// Note: callers should not rely on `NULL` or on a zero value for
        /// indication of whether AtkSelectionIface is implemented, they should
        /// use type checking/interface checking macros or the
        /// `atk_get_accessible_value` convenience method.
        pub const get_selection_count = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_get_selection_count.?(gobject.ext.as(Selection, p_selection));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_get_selection_count = @ptrCast(p_implementation);
            }
        };

        /// Determines if the current child of this object is selected
        /// Note: callers should not rely on `NULL` or on a zero value for
        /// indication of whether AtkSelectionIface is implemented, they should
        /// use type checking/interface checking macros or the
        /// `atk_get_accessible_value` convenience method.
        pub const is_child_selected = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_is_child_selected.?(gobject.ext.as(Selection, p_selection), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_is_child_selected = @ptrCast(p_implementation);
            }
        };

        /// Gets a reference to the accessible object representing the specified
        /// selected child of the object.
        /// Note: callers should not rely on `NULL` or on a zero value for
        /// indication of whether AtkSelectionIface is implemented, they should
        /// use type checking/interface checking macros or the
        /// `atk_get_accessible_value` convenience method.
        pub const ref_selection = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) ?*atk.Object {
                return gobject.ext.as(Selection.Iface, p_class).f_ref_selection.?(gobject.ext.as(Selection, p_selection), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) ?*atk.Object) void {
                gobject.ext.as(Selection.Iface, p_class).f_ref_selection = @ptrCast(p_implementation);
            }
        };

        /// Removes the specified child of the object from the object's selection.
        pub const remove_selection = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_remove_selection.?(gobject.ext.as(Selection, p_selection), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_remove_selection = @ptrCast(p_implementation);
            }
        };

        /// Causes every child of the object to be selected if the object
        /// supports multiple selections.
        pub const select_all_selection = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Selection.Iface, p_class).f_select_all_selection.?(gobject.ext.as(Selection, p_selection));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Selection.Iface, p_class).f_select_all_selection = @ptrCast(p_implementation);
            }
        };

        pub const selection_changed = struct {
            pub fn call(p_class: anytype, p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Selection.Iface, p_class).f_selection_changed.?(gobject.ext.as(Selection, p_selection));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_selection: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Selection.Iface, p_class).f_selection_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "selection-changed" signal is emitted by an object which
        /// implements AtkSelection interface when the selection changes.
        pub const selection_changed = struct {
            pub const name = "selection-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Selection, p_instance))),
                    gobject.signalLookup("selection-changed", Selection.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Adds the specified accessible child of the object to the
    /// object's selection.
    extern fn atk_selection_add_selection(p_selection: *Selection, p_i: c_int) c_int;
    pub const addSelection = atk_selection_add_selection;

    /// Clears the selection in the object so that no children in the object
    /// are selected.
    extern fn atk_selection_clear_selection(p_selection: *Selection) c_int;
    pub const clearSelection = atk_selection_clear_selection;

    /// Gets the number of accessible children currently selected.
    /// Note: callers should not rely on `NULL` or on a zero value for
    /// indication of whether AtkSelectionIface is implemented, they should
    /// use type checking/interface checking macros or the
    /// `atk_get_accessible_value` convenience method.
    extern fn atk_selection_get_selection_count(p_selection: *Selection) c_int;
    pub const getSelectionCount = atk_selection_get_selection_count;

    /// Determines if the current child of this object is selected
    /// Note: callers should not rely on `NULL` or on a zero value for
    /// indication of whether AtkSelectionIface is implemented, they should
    /// use type checking/interface checking macros or the
    /// `atk_get_accessible_value` convenience method.
    extern fn atk_selection_is_child_selected(p_selection: *Selection, p_i: c_int) c_int;
    pub const isChildSelected = atk_selection_is_child_selected;

    /// Gets a reference to the accessible object representing the specified
    /// selected child of the object.
    /// Note: callers should not rely on `NULL` or on a zero value for
    /// indication of whether AtkSelectionIface is implemented, they should
    /// use type checking/interface checking macros or the
    /// `atk_get_accessible_value` convenience method.
    extern fn atk_selection_ref_selection(p_selection: *Selection, p_i: c_int) ?*atk.Object;
    pub const refSelection = atk_selection_ref_selection;

    /// Removes the specified child of the object from the object's selection.
    extern fn atk_selection_remove_selection(p_selection: *Selection, p_i: c_int) c_int;
    pub const removeSelection = atk_selection_remove_selection;

    /// Causes every child of the object to be selected if the object
    /// supports multiple selections.
    extern fn atk_selection_select_all_selection(p_selection: *Selection) c_int;
    pub const selectAllSelection = atk_selection_select_all_selection;

    extern fn atk_selection_get_type() usize;
    pub const getGObjectType = atk_selection_get_type;

    extern fn g_object_ref(p_self: *atk.Selection) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Selection) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Selection, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface which provides access to streamable content.
///
/// An interface whereby an object allows its backing content to be
/// streamed to clients.  Typical implementors would be images or
/// icons, HTML content, or multimedia display/rendering widgets.
///
/// Negotiation of content type is allowed. Clients may examine the
/// backing data and transform, convert, or parse the content in order
/// to present it in an alternate form to end-users.
///
/// The AtkStreamableContent interface is particularly useful for
/// saving, printing, or post-processing entire documents, or for
/// persisting alternate views of a document. If document content
/// itself is being serialized, stored, or converted, then use of the
/// AtkStreamableContent interface can help address performance
/// issues. Unlike most ATK interfaces, this interface is not strongly
/// tied to the current user-agent view of the a particular document,
/// but may in some cases give access to the underlying model data.
pub const StreamableContent = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.StreamableContentIface;
    pub const virtual_methods = struct {
        /// Gets the character string of the specified mime type. The first mime
        /// type is at position 0, the second at position 1, and so on.
        pub const get_mime_type = struct {
            pub fn call(p_class: anytype, p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) [*:0]const u8 {
                return gobject.ext.as(StreamableContent.Iface, p_class).f_get_mime_type.?(gobject.ext.as(StreamableContent, p_streamable), p_i);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_i: c_int) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(StreamableContent.Iface, p_class).f_get_mime_type = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of mime types supported by this object.
        pub const get_n_mime_types = struct {
            pub fn call(p_class: anytype, p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(StreamableContent.Iface, p_class).f_get_n_mime_types.?(gobject.ext.as(StreamableContent, p_streamable));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(StreamableContent.Iface, p_class).f_get_n_mime_types = @ptrCast(p_implementation);
            }
        };

        /// Gets the content in the specified mime type.
        pub const get_stream = struct {
            pub fn call(p_class: anytype, p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) *glib.IOChannel {
                return gobject.ext.as(StreamableContent.Iface, p_class).f_get_stream.?(gobject.ext.as(StreamableContent, p_streamable), p_mime_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) callconv(.c) *glib.IOChannel) void {
                gobject.ext.as(StreamableContent.Iface, p_class).f_get_stream = @ptrCast(p_implementation);
            }
        };

        /// Get a string representing a URI in IETF standard format
        /// (see http://www.ietf.org/rfc/rfc2396.txt) from which the object's content
        /// may be streamed in the specified mime-type, if one is available.
        /// If mime_type is NULL, the URI for the default (and possibly only) mime-type is
        /// returned.
        ///
        /// Note that it is possible for get_uri to return NULL but for
        /// get_stream to work nonetheless, since not all GIOChannels connect to URIs.
        pub const get_uri = struct {
            pub fn call(p_class: anytype, p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) ?[*:0]const u8 {
                return gobject.ext.as(StreamableContent.Iface, p_class).f_get_uri.?(gobject.ext.as(StreamableContent, p_streamable), p_mime_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_streamable: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_mime_type: [*:0]const u8) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(StreamableContent.Iface, p_class).f_get_uri = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Gets the character string of the specified mime type. The first mime
    /// type is at position 0, the second at position 1, and so on.
    extern fn atk_streamable_content_get_mime_type(p_streamable: *StreamableContent, p_i: c_int) [*:0]const u8;
    pub const getMimeType = atk_streamable_content_get_mime_type;

    /// Gets the number of mime types supported by this object.
    extern fn atk_streamable_content_get_n_mime_types(p_streamable: *StreamableContent) c_int;
    pub const getNMimeTypes = atk_streamable_content_get_n_mime_types;

    /// Gets the content in the specified mime type.
    extern fn atk_streamable_content_get_stream(p_streamable: *StreamableContent, p_mime_type: [*:0]const u8) *glib.IOChannel;
    pub const getStream = atk_streamable_content_get_stream;

    /// Get a string representing a URI in IETF standard format
    /// (see http://www.ietf.org/rfc/rfc2396.txt) from which the object's content
    /// may be streamed in the specified mime-type, if one is available.
    /// If mime_type is NULL, the URI for the default (and possibly only) mime-type is
    /// returned.
    ///
    /// Note that it is possible for get_uri to return NULL but for
    /// get_stream to work nonetheless, since not all GIOChannels connect to URIs.
    extern fn atk_streamable_content_get_uri(p_streamable: *StreamableContent, p_mime_type: [*:0]const u8) ?[*:0]const u8;
    pub const getUri = atk_streamable_content_get_uri;

    extern fn atk_streamable_content_get_type() usize;
    pub const getGObjectType = atk_streamable_content_get_type;

    extern fn g_object_ref(p_self: *atk.StreamableContent) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.StreamableContent) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *StreamableContent, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented for UI components which contain tabular or row/column information.
///
/// `atk.Table` should be implemented by components which present
/// elements ordered via rows and columns.  It may also be used to
/// present tree-structured information if the nodes of the trees can
/// be said to contain multiple "columns".  Individual elements of an
/// `atk.Table` are typically referred to as "cells". Those cells should
/// implement the interface `atk.TableCell`, but `Atk` doesn't require
/// them to be direct children of the current `atk.Table`. They can be
/// grand-children, grand-grand-children etc. `atk.Table` provides the
/// API needed to get a individual cell based on the row and column
/// numbers.
///
/// Children of `atk.Table` are frequently "lightweight" objects, that
/// is, they may not have backing widgets in the host UI toolkit.  They
/// are therefore often transient.
///
/// Since tables are often very complex, `atk.Table` includes provision
/// for offering simplified summary information, as well as row and
/// column headers and captions.  Headers and captions are `AtkObjects`
/// which may implement other interfaces (`atk.Text`, `atk.Image`, etc.) as
/// appropriate.  `atk.Table` summaries may themselves be (simplified)
/// `AtkTables`, etc.
///
/// Note for implementors: in the past, `atk.Table` required that all the
/// cells should be direct children of `atk.Table`, and provided some
/// index based methods to request the cells. The practice showed that
/// that forcing made `atk.Table` implementation complex, and hard to
/// expose other kind of children, like rows or captions. Right now,
/// index-based methods are deprecated.
pub const Table = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.TableIface;
    pub const virtual_methods = struct {
        /// Adds the specified `column` to the selection.
        pub const add_column_selection = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_add_column_selection.?(gobject.ext.as(Table, p_table), p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_add_column_selection = @ptrCast(p_implementation);
            }
        };

        /// Adds the specified `row` to the selection.
        pub const add_row_selection = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_add_row_selection.?(gobject.ext.as(Table, p_table), p_row);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_add_row_selection = @ptrCast(p_implementation);
            }
        };

        pub const column_deleted = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_num_deleted: c_int) void {
                return gobject.ext.as(Table.Iface, p_class).f_column_deleted.?(gobject.ext.as(Table, p_table), p_column, p_num_deleted);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_num_deleted: c_int) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_column_deleted = @ptrCast(p_implementation);
            }
        };

        pub const column_inserted = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_num_inserted: c_int) void {
                return gobject.ext.as(Table.Iface, p_class).f_column_inserted.?(gobject.ext.as(Table, p_table), p_column, p_num_inserted);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_num_inserted: c_int) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_column_inserted = @ptrCast(p_implementation);
            }
        };

        pub const column_reordered = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Table.Iface, p_class).f_column_reordered.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_column_reordered = @ptrCast(p_implementation);
            }
        };

        /// Gets the caption for the `table`.
        pub const get_caption = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*atk.Object {
                return gobject.ext.as(Table.Iface, p_class).f_get_caption.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*atk.Object) void {
                gobject.ext.as(Table.Iface, p_class).f_get_caption = @ptrCast(p_implementation);
            }
        };

        /// Gets a `gint` representing the column at the specified `index_`.
        pub const get_column_at_index = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index_: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_column_at_index.?(gobject.ext.as(Table, p_table), p_index_);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index_: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_column_at_index = @ptrCast(p_implementation);
            }
        };

        /// Gets the description text of the specified `column` in the table
        pub const get_column_description = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) [*:0]const u8 {
                return gobject.ext.as(Table.Iface, p_class).f_get_column_description.?(gobject.ext.as(Table, p_table), p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) callconv(.c) [*:0]const u8) void {
                gobject.ext.as(Table.Iface, p_class).f_get_column_description = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of columns occupied by the accessible object
        /// at the specified `row` and `column` in the `table`.
        pub const get_column_extent_at = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_column_extent_at.?(gobject.ext.as(Table, p_table), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_column_extent_at = @ptrCast(p_implementation);
            }
        };

        /// Gets the column header of a specified column in an accessible table.
        pub const get_column_header = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) ?*atk.Object {
                return gobject.ext.as(Table.Iface, p_class).f_get_column_header.?(gobject.ext.as(Table, p_table), p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) callconv(.c) ?*atk.Object) void {
                gobject.ext.as(Table.Iface, p_class).f_get_column_header = @ptrCast(p_implementation);
            }
        };

        /// Gets a `gint` representing the index at the specified `row` and
        /// `column`.
        pub const get_index_at = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_index_at.?(gobject.ext.as(Table, p_table), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_index_at = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of columns in the table.
        pub const get_n_columns = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_n_columns.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_n_columns = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of rows in the table.
        pub const get_n_rows = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_n_rows.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_n_rows = @ptrCast(p_implementation);
            }
        };

        /// Gets a `gint` representing the row at the specified `index_`.
        pub const get_row_at_index = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index_: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_row_at_index.?(gobject.ext.as(Table, p_table), p_index_);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_index_: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_row_at_index = @ptrCast(p_implementation);
            }
        };

        /// Gets the description text of the specified row in the table
        pub const get_row_description = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) ?[*:0]const u8 {
                return gobject.ext.as(Table.Iface, p_class).f_get_row_description.?(gobject.ext.as(Table, p_table), p_row);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) callconv(.c) ?[*:0]const u8) void {
                gobject.ext.as(Table.Iface, p_class).f_get_row_description = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of rows occupied by the accessible object
        /// at a specified `row` and `column` in the `table`.
        pub const get_row_extent_at = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_row_extent_at.?(gobject.ext.as(Table, p_table), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_row_extent_at = @ptrCast(p_implementation);
            }
        };

        /// Gets the row header of a specified row in an accessible table.
        pub const get_row_header = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) ?*atk.Object {
                return gobject.ext.as(Table.Iface, p_class).f_get_row_header.?(gobject.ext.as(Table, p_table), p_row);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) callconv(.c) ?*atk.Object) void {
                gobject.ext.as(Table.Iface, p_class).f_get_row_header = @ptrCast(p_implementation);
            }
        };

        /// Gets the selected columns of the table by initializing **selected with
        /// the selected column numbers. This array should be freed by the caller.
        pub const get_selected_columns = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selected: **c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_selected_columns.?(gobject.ext.as(Table, p_table), p_selected);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selected: **c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_selected_columns = @ptrCast(p_implementation);
            }
        };

        /// Gets the selected rows of the table by initializing **selected with
        /// the selected row numbers. This array should be freed by the caller.
        pub const get_selected_rows = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selected: **c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_get_selected_rows.?(gobject.ext.as(Table, p_table), p_selected);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selected: **c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_get_selected_rows = @ptrCast(p_implementation);
            }
        };

        /// Gets the summary description of the table.
        pub const get_summary = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.Object {
                return gobject.ext.as(Table.Iface, p_class).f_get_summary.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.Object) void {
                gobject.ext.as(Table.Iface, p_class).f_get_summary = @ptrCast(p_implementation);
            }
        };

        /// Gets a boolean value indicating whether the specified `column`
        /// is selected
        pub const is_column_selected = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_is_column_selected.?(gobject.ext.as(Table, p_table), p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_is_column_selected = @ptrCast(p_implementation);
            }
        };

        /// Gets a boolean value indicating whether the specified `row`
        /// is selected
        pub const is_row_selected = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_is_row_selected.?(gobject.ext.as(Table, p_table), p_row);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_is_row_selected = @ptrCast(p_implementation);
            }
        };

        /// Gets a boolean value indicating whether the accessible object
        /// at the specified `row` and `column` is selected
        pub const is_selected = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_is_selected.?(gobject.ext.as(Table, p_table), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_is_selected = @ptrCast(p_implementation);
            }
        };

        pub const model_changed = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Table.Iface, p_class).f_model_changed.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_model_changed = @ptrCast(p_implementation);
            }
        };

        /// Get a reference to the table cell at `row`, `column`. This cell
        /// should implement the interface `atk.TableCell`
        pub const ref_at = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) *atk.Object {
                return gobject.ext.as(Table.Iface, p_class).f_ref_at.?(gobject.ext.as(Table, p_table), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_column: c_int) callconv(.c) *atk.Object) void {
                gobject.ext.as(Table.Iface, p_class).f_ref_at = @ptrCast(p_implementation);
            }
        };

        /// Adds the specified `column` to the selection.
        pub const remove_column_selection = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_remove_column_selection.?(gobject.ext.as(Table, p_table), p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_remove_column_selection = @ptrCast(p_implementation);
            }
        };

        /// Removes the specified `row` from the selection.
        pub const remove_row_selection = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) c_int {
                return gobject.ext.as(Table.Iface, p_class).f_remove_row_selection.?(gobject.ext.as(Table, p_table), p_row);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Table.Iface, p_class).f_remove_row_selection = @ptrCast(p_implementation);
            }
        };

        pub const row_deleted = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_num_deleted: c_int) void {
                return gobject.ext.as(Table.Iface, p_class).f_row_deleted.?(gobject.ext.as(Table, p_table), p_row, p_num_deleted);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_num_deleted: c_int) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_row_deleted = @ptrCast(p_implementation);
            }
        };

        pub const row_inserted = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_num_inserted: c_int) void {
                return gobject.ext.as(Table.Iface, p_class).f_row_inserted.?(gobject.ext.as(Table, p_table), p_row, p_num_inserted);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_num_inserted: c_int) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_row_inserted = @ptrCast(p_implementation);
            }
        };

        pub const row_reordered = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Table.Iface, p_class).f_row_reordered.?(gobject.ext.as(Table, p_table));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_row_reordered = @ptrCast(p_implementation);
            }
        };

        /// Sets the caption for the table.
        pub const set_caption = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_caption: *atk.Object) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_caption.?(gobject.ext.as(Table, p_table), p_caption);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_caption: *atk.Object) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_caption = @ptrCast(p_implementation);
            }
        };

        /// Sets the description text for the specified `column` of the `table`.
        pub const set_column_description = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_description: [*:0]const u8) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_column_description.?(gobject.ext.as(Table, p_table), p_column, p_description);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_description: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_column_description = @ptrCast(p_implementation);
            }
        };

        /// Sets the specified column header to `header`.
        pub const set_column_header = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_header: *atk.Object) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_column_header.?(gobject.ext.as(Table, p_table), p_column, p_header);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_column: c_int, p_header: *atk.Object) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_column_header = @ptrCast(p_implementation);
            }
        };

        /// Sets the description text for the specified `row` of `table`.
        pub const set_row_description = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_description: [*:0]const u8) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_row_description.?(gobject.ext.as(Table, p_table), p_row, p_description);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_description: [*:0]const u8) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_row_description = @ptrCast(p_implementation);
            }
        };

        /// Sets the specified row header to `header`.
        pub const set_row_header = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_header: *atk.Object) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_row_header.?(gobject.ext.as(Table, p_table), p_row, p_header);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: c_int, p_header: *atk.Object) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_row_header = @ptrCast(p_implementation);
            }
        };

        /// Sets the summary description of the table.
        pub const set_summary = struct {
            pub fn call(p_class: anytype, p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_accessible: *atk.Object) void {
                return gobject.ext.as(Table.Iface, p_class).f_set_summary.?(gobject.ext.as(Table, p_table), p_accessible);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_table: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_accessible: *atk.Object) callconv(.c) void) void {
                gobject.ext.as(Table.Iface, p_class).f_set_summary = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "column-deleted" signal is emitted by an object which
        /// implements the AtkTable interface when a column is deleted.
        pub const column_deleted = struct {
            pub const name = "column-deleted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("column-deleted", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "column-inserted" signal is emitted by an object which
        /// implements the AtkTable interface when a column is inserted.
        pub const column_inserted = struct {
            pub const name = "column-inserted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("column-inserted", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "column-reordered" signal is emitted by an object which
        /// implements the AtkTable interface when the columns are
        /// reordered.
        pub const column_reordered = struct {
            pub const name = "column-reordered";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("column-reordered", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "model-changed" signal is emitted by an object which
        /// implements the AtkTable interface when the model displayed by
        /// the table changes.
        pub const model_changed = struct {
            pub const name = "model-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("model-changed", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "row-deleted" signal is emitted by an object which
        /// implements the AtkTable interface when a row is deleted.
        pub const row_deleted = struct {
            pub const name = "row-deleted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("row-deleted", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "row-inserted" signal is emitted by an object which
        /// implements the AtkTable interface when a row is inserted.
        pub const row_inserted = struct {
            pub const name = "row-inserted";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("row-inserted", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "row-reordered" signal is emitted by an object which
        /// implements the AtkTable interface when the rows are
        /// reordered.
        pub const row_reordered = struct {
            pub const name = "row-reordered";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Table, p_instance))),
                    gobject.signalLookup("row-reordered", Table.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Adds the specified `column` to the selection.
    extern fn atk_table_add_column_selection(p_table: *Table, p_column: c_int) c_int;
    pub const addColumnSelection = atk_table_add_column_selection;

    /// Adds the specified `row` to the selection.
    extern fn atk_table_add_row_selection(p_table: *Table, p_row: c_int) c_int;
    pub const addRowSelection = atk_table_add_row_selection;

    /// Gets the caption for the `table`.
    extern fn atk_table_get_caption(p_table: *Table) ?*atk.Object;
    pub const getCaption = atk_table_get_caption;

    /// Gets a `gint` representing the column at the specified `index_`.
    extern fn atk_table_get_column_at_index(p_table: *Table, p_index_: c_int) c_int;
    pub const getColumnAtIndex = atk_table_get_column_at_index;

    /// Gets the description text of the specified `column` in the table
    extern fn atk_table_get_column_description(p_table: *Table, p_column: c_int) [*:0]const u8;
    pub const getColumnDescription = atk_table_get_column_description;

    /// Gets the number of columns occupied by the accessible object
    /// at the specified `row` and `column` in the `table`.
    extern fn atk_table_get_column_extent_at(p_table: *Table, p_row: c_int, p_column: c_int) c_int;
    pub const getColumnExtentAt = atk_table_get_column_extent_at;

    /// Gets the column header of a specified column in an accessible table.
    extern fn atk_table_get_column_header(p_table: *Table, p_column: c_int) ?*atk.Object;
    pub const getColumnHeader = atk_table_get_column_header;

    /// Gets a `gint` representing the index at the specified `row` and
    /// `column`.
    extern fn atk_table_get_index_at(p_table: *Table, p_row: c_int, p_column: c_int) c_int;
    pub const getIndexAt = atk_table_get_index_at;

    /// Gets the number of columns in the table.
    extern fn atk_table_get_n_columns(p_table: *Table) c_int;
    pub const getNColumns = atk_table_get_n_columns;

    /// Gets the number of rows in the table.
    extern fn atk_table_get_n_rows(p_table: *Table) c_int;
    pub const getNRows = atk_table_get_n_rows;

    /// Gets a `gint` representing the row at the specified `index_`.
    extern fn atk_table_get_row_at_index(p_table: *Table, p_index_: c_int) c_int;
    pub const getRowAtIndex = atk_table_get_row_at_index;

    /// Gets the description text of the specified row in the table
    extern fn atk_table_get_row_description(p_table: *Table, p_row: c_int) ?[*:0]const u8;
    pub const getRowDescription = atk_table_get_row_description;

    /// Gets the number of rows occupied by the accessible object
    /// at a specified `row` and `column` in the `table`.
    extern fn atk_table_get_row_extent_at(p_table: *Table, p_row: c_int, p_column: c_int) c_int;
    pub const getRowExtentAt = atk_table_get_row_extent_at;

    /// Gets the row header of a specified row in an accessible table.
    extern fn atk_table_get_row_header(p_table: *Table, p_row: c_int) ?*atk.Object;
    pub const getRowHeader = atk_table_get_row_header;

    /// Gets the selected columns of the table by initializing **selected with
    /// the selected column numbers. This array should be freed by the caller.
    extern fn atk_table_get_selected_columns(p_table: *Table, p_selected: **c_int) c_int;
    pub const getSelectedColumns = atk_table_get_selected_columns;

    /// Gets the selected rows of the table by initializing **selected with
    /// the selected row numbers. This array should be freed by the caller.
    extern fn atk_table_get_selected_rows(p_table: *Table, p_selected: **c_int) c_int;
    pub const getSelectedRows = atk_table_get_selected_rows;

    /// Gets the summary description of the table.
    extern fn atk_table_get_summary(p_table: *Table) *atk.Object;
    pub const getSummary = atk_table_get_summary;

    /// Gets a boolean value indicating whether the specified `column`
    /// is selected
    extern fn atk_table_is_column_selected(p_table: *Table, p_column: c_int) c_int;
    pub const isColumnSelected = atk_table_is_column_selected;

    /// Gets a boolean value indicating whether the specified `row`
    /// is selected
    extern fn atk_table_is_row_selected(p_table: *Table, p_row: c_int) c_int;
    pub const isRowSelected = atk_table_is_row_selected;

    /// Gets a boolean value indicating whether the accessible object
    /// at the specified `row` and `column` is selected
    extern fn atk_table_is_selected(p_table: *Table, p_row: c_int, p_column: c_int) c_int;
    pub const isSelected = atk_table_is_selected;

    /// Get a reference to the table cell at `row`, `column`. This cell
    /// should implement the interface `atk.TableCell`
    extern fn atk_table_ref_at(p_table: *Table, p_row: c_int, p_column: c_int) *atk.Object;
    pub const refAt = atk_table_ref_at;

    /// Adds the specified `column` to the selection.
    extern fn atk_table_remove_column_selection(p_table: *Table, p_column: c_int) c_int;
    pub const removeColumnSelection = atk_table_remove_column_selection;

    /// Removes the specified `row` from the selection.
    extern fn atk_table_remove_row_selection(p_table: *Table, p_row: c_int) c_int;
    pub const removeRowSelection = atk_table_remove_row_selection;

    /// Sets the caption for the table.
    extern fn atk_table_set_caption(p_table: *Table, p_caption: *atk.Object) void;
    pub const setCaption = atk_table_set_caption;

    /// Sets the description text for the specified `column` of the `table`.
    extern fn atk_table_set_column_description(p_table: *Table, p_column: c_int, p_description: [*:0]const u8) void;
    pub const setColumnDescription = atk_table_set_column_description;

    /// Sets the specified column header to `header`.
    extern fn atk_table_set_column_header(p_table: *Table, p_column: c_int, p_header: *atk.Object) void;
    pub const setColumnHeader = atk_table_set_column_header;

    /// Sets the description text for the specified `row` of `table`.
    extern fn atk_table_set_row_description(p_table: *Table, p_row: c_int, p_description: [*:0]const u8) void;
    pub const setRowDescription = atk_table_set_row_description;

    /// Sets the specified row header to `header`.
    extern fn atk_table_set_row_header(p_table: *Table, p_row: c_int, p_header: *atk.Object) void;
    pub const setRowHeader = atk_table_set_row_header;

    /// Sets the summary description of the table.
    extern fn atk_table_set_summary(p_table: *Table, p_accessible: *atk.Object) void;
    pub const setSummary = atk_table_set_summary;

    extern fn atk_table_get_type() usize;
    pub const getGObjectType = atk_table_get_type;

    extern fn g_object_ref(p_self: *atk.Table) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Table) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Table, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented for a cell inside a two-dimentional `atk.Table`
///
/// Being `atk.Table` a component which present elements ordered via rows
/// and columns, an `atk.TableCell` is the interface which each of those
/// elements, so "cells" should implement.
///
/// See `AtkTable`
pub const TableCell = opaque {
    pub const Prerequisites = [_]type{atk.Object};
    pub const Iface = atk.TableCellIface;
    pub const virtual_methods = struct {
        /// Returns the column headers as an array of cell accessibles.
        pub const get_column_header_cells = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.PtrArray {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_column_header_cells.?(gobject.ext.as(TableCell, p_cell));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_column_header_cells = @ptrCast(p_implementation);
            }
        };

        /// Returns the number of columns occupied by this cell accessible.
        pub const get_column_span = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_column_span.?(gobject.ext.as(TableCell, p_cell));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_column_span = @ptrCast(p_implementation);
            }
        };

        /// Retrieves the tabular position of this cell.
        pub const get_position = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: *c_int, p_column: *c_int) c_int {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_position.?(gobject.ext.as(TableCell, p_cell), p_row, p_column);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: *c_int, p_column: *c_int) callconv(.c) c_int) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_position = @ptrCast(p_implementation);
            }
        };

        /// Gets the row and column indexes and span of this cell accessible.
        ///
        /// Note: If the object does not implement this function, then, by default, atk
        /// will implement this function by calling get_row_span and get_column_span
        /// on the object.
        pub const get_row_column_span = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: *c_int, p_column: *c_int, p_row_span: *c_int, p_column_span: *c_int) c_int {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_row_column_span.?(gobject.ext.as(TableCell, p_cell), p_row, p_column, p_row_span, p_column_span);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_row: *c_int, p_column: *c_int, p_row_span: *c_int, p_column_span: *c_int) callconv(.c) c_int) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_row_column_span = @ptrCast(p_implementation);
            }
        };

        /// Returns the row headers as an array of cell accessibles.
        pub const get_row_header_cells = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.PtrArray {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_row_header_cells.?(gobject.ext.as(TableCell, p_cell));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.PtrArray) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_row_header_cells = @ptrCast(p_implementation);
            }
        };

        /// Returns the number of rows occupied by this cell accessible.
        pub const get_row_span = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_row_span.?(gobject.ext.as(TableCell, p_cell));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_row_span = @ptrCast(p_implementation);
            }
        };

        /// Returns a reference to the accessible of the containing table.
        pub const get_table = struct {
            pub fn call(p_class: anytype, p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.Object {
                return gobject.ext.as(TableCell.Iface, p_class).f_get_table.?(gobject.ext.as(TableCell, p_cell));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_cell: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.Object) void {
                gobject.ext.as(TableCell.Iface, p_class).f_get_table = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {};

    /// Returns the column headers as an array of cell accessibles.
    extern fn atk_table_cell_get_column_header_cells(p_cell: *TableCell) *glib.PtrArray;
    pub const getColumnHeaderCells = atk_table_cell_get_column_header_cells;

    /// Returns the number of columns occupied by this cell accessible.
    extern fn atk_table_cell_get_column_span(p_cell: *TableCell) c_int;
    pub const getColumnSpan = atk_table_cell_get_column_span;

    /// Retrieves the tabular position of this cell.
    extern fn atk_table_cell_get_position(p_cell: *TableCell, p_row: *c_int, p_column: *c_int) c_int;
    pub const getPosition = atk_table_cell_get_position;

    /// Gets the row and column indexes and span of this cell accessible.
    ///
    /// Note: If the object does not implement this function, then, by default, atk
    /// will implement this function by calling get_row_span and get_column_span
    /// on the object.
    extern fn atk_table_cell_get_row_column_span(p_cell: *TableCell, p_row: *c_int, p_column: *c_int, p_row_span: *c_int, p_column_span: *c_int) c_int;
    pub const getRowColumnSpan = atk_table_cell_get_row_column_span;

    /// Returns the row headers as an array of cell accessibles.
    extern fn atk_table_cell_get_row_header_cells(p_cell: *TableCell) *glib.PtrArray;
    pub const getRowHeaderCells = atk_table_cell_get_row_header_cells;

    /// Returns the number of rows occupied by this cell accessible.
    extern fn atk_table_cell_get_row_span(p_cell: *TableCell) c_int;
    pub const getRowSpan = atk_table_cell_get_row_span;

    /// Returns a reference to the accessible of the containing table.
    extern fn atk_table_cell_get_table(p_cell: *TableCell) *atk.Object;
    pub const getTable = atk_table_cell_get_table;

    extern fn atk_table_cell_get_type() usize;
    pub const getGObjectType = atk_table_cell_get_type;

    extern fn g_object_ref(p_self: *atk.TableCell) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.TableCell) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *TableCell, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented by components with text content.
///
/// `atk.Text` should be implemented by `AtkObjects` on behalf of widgets
/// that have text content which is either attributed or otherwise
/// non-trivial.  `AtkObjects` whose text content is simple,
/// unattributed, and very brief may expose that content via
/// `atk.Object.getName` instead; however if the text is editable,
/// multi-line, typically longer than three or four words, attributed,
/// selectable, or if the object already uses the 'name' ATK property
/// for other information, the `atk.Text` interface should be used to
/// expose the text content.  In the case of editable text content,
/// `atk.EditableText` (a subtype of the `atk.Text` interface) should be
/// implemented instead.
///
///  `atk.Text` provides not only traversal facilities and change
/// notification for text content, but also caret tracking and glyph
/// bounding box calculations.  Note that the text strings are exposed
/// as UTF-8, and are therefore potentially multi-byte, and
/// caret-to-byte offset mapping makes no assumptions about the
/// character length; also bounding box glyph-to-offset mapping may be
/// complex for languages which use ligatures.
pub const Text = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.TextIface;
    pub const virtual_methods = struct {
        /// Adds a selection bounded by the specified offsets.
        pub const add_selection = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_add_selection.?(gobject.ext.as(Text, p_text), p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_add_selection = @ptrCast(p_implementation);
            }
        };

        /// Get the ranges of text in the specified bounding box.
        pub const get_bounded_ranges = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rect: *atk.TextRectangle, p_coord_type: atk.CoordType, p_x_clip_type: atk.TextClipType, p_y_clip_type: atk.TextClipType) [*]*atk.TextRange {
                return gobject.ext.as(Text.Iface, p_class).f_get_bounded_ranges.?(gobject.ext.as(Text, p_text), p_rect, p_coord_type, p_x_clip_type, p_y_clip_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_rect: *atk.TextRectangle, p_coord_type: atk.CoordType, p_x_clip_type: atk.TextClipType, p_y_clip_type: atk.TextClipType) callconv(.c) [*]*atk.TextRange) void {
                gobject.ext.as(Text.Iface, p_class).f_get_bounded_ranges = @ptrCast(p_implementation);
            }
        };

        /// Gets the offset of the position of the caret (cursor).
        pub const get_caret_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_get_caret_offset.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_get_caret_offset = @ptrCast(p_implementation);
            }
        };

        /// Gets the specified text.
        pub const get_character_at_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int) u32 {
                return gobject.ext.as(Text.Iface, p_class).f_get_character_at_offset.?(gobject.ext.as(Text, p_text), p_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int) callconv(.c) u32) void {
                gobject.ext.as(Text.Iface, p_class).f_get_character_at_offset = @ptrCast(p_implementation);
            }
        };

        /// Gets the character count.
        pub const get_character_count = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_get_character_count.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_get_character_count = @ptrCast(p_implementation);
            }
        };

        /// If the extent can not be obtained (e.g. missing support), all of x, y, width,
        /// height are set to -1.
        ///
        /// Get the bounding box containing the glyph representing the character at
        ///     a particular text offset.
        pub const get_character_extents = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coords: atk.CoordType) void {
                return gobject.ext.as(Text.Iface, p_class).f_get_character_extents.?(gobject.ext.as(Text, p_text), p_offset, p_x, p_y, p_width, p_height, p_coords);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coords: atk.CoordType) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_get_character_extents = @ptrCast(p_implementation);
            }
        };

        /// Creates an `atk.AttributeSet` which consists of the default values of
        /// attributes for the text. See the enum AtkTextAttribute for types of text
        /// attributes that can be returned. Note that other attributes may also be
        /// returned.
        pub const get_default_attributes = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *atk.AttributeSet {
                return gobject.ext.as(Text.Iface, p_class).f_get_default_attributes.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *atk.AttributeSet) void {
                gobject.ext.as(Text.Iface, p_class).f_get_default_attributes = @ptrCast(p_implementation);
            }
        };

        /// Gets the number of selected regions.
        pub const get_n_selections = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_get_n_selections.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_get_n_selections = @ptrCast(p_implementation);
            }
        };

        /// Gets the offset of the character located at coordinates `x` and `y`. `x` and `y`
        /// are interpreted as being relative to the screen or this widget's window
        /// depending on `coords`.
        pub const get_offset_at_point = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coords: atk.CoordType) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_get_offset_at_point.?(gobject.ext.as(Text, p_text), p_x, p_y, p_coords);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_x: c_int, p_y: c_int, p_coords: atk.CoordType) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_get_offset_at_point = @ptrCast(p_implementation);
            }
        };

        /// Get the bounding box for text within the specified range.
        ///
        /// If the extents can not be obtained (e.g. or missing support), the rectangle
        /// fields are set to -1.
        pub const get_range_extents = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_coord_type: atk.CoordType, p_rect: *atk.TextRectangle) void {
                return gobject.ext.as(Text.Iface, p_class).f_get_range_extents.?(gobject.ext.as(Text, p_text), p_start_offset, p_end_offset, p_coord_type, p_rect);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_coord_type: atk.CoordType, p_rect: *atk.TextRectangle) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_get_range_extents = @ptrCast(p_implementation);
            }
        };

        /// Creates an `atk.AttributeSet` which consists of the attributes explicitly
        /// set at the position `offset` in the text. `start_offset` and `end_offset` are
        /// set to the start and end of the range around `offset` where the attributes are
        /// invariant. Note that `end_offset` is the offset of the first character
        /// after the range.  See the enum AtkTextAttribute for types of text
        /// attributes that can be returned. Note that other attributes may also be
        /// returned.
        pub const get_run_attributes = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int) *atk.AttributeSet {
                return gobject.ext.as(Text.Iface, p_class).f_get_run_attributes.?(gobject.ext.as(Text, p_text), p_offset, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) *atk.AttributeSet) void {
                gobject.ext.as(Text.Iface, p_class).f_get_run_attributes = @ptrCast(p_implementation);
            }
        };

        /// Gets the text from the specified selection.
        pub const get_selection = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_selection.?(gobject.ext.as(Text, p_text), p_selection_num, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_selection = @ptrCast(p_implementation);
            }
        };

        /// Gets a portion of the text exposed through an `atk.Text` according to a given `offset`
        /// and a specific `granularity`, along with the start and end offsets defining the
        /// boundaries of such a portion of text.
        ///
        /// If `granularity` is ATK_TEXT_GRANULARITY_CHAR the character at the
        /// offset is returned.
        ///
        /// If `granularity` is ATK_TEXT_GRANULARITY_WORD the returned string
        /// is from the word start at or before the offset to the word start after
        /// the offset.
        ///
        /// The returned string will contain the word at the offset if the offset
        /// is inside a word and will contain the word before the offset if the
        /// offset is not inside a word.
        ///
        /// If `granularity` is ATK_TEXT_GRANULARITY_SENTENCE the returned string
        /// is from the sentence start at or before the offset to the sentence
        /// start after the offset.
        ///
        /// The returned string will contain the sentence at the offset if the offset
        /// is inside a sentence and will contain the sentence before the offset
        /// if the offset is not inside a sentence.
        ///
        /// If `granularity` is ATK_TEXT_GRANULARITY_LINE the returned string
        /// is from the line start at or before the offset to the line
        /// start after the offset.
        ///
        /// If `granularity` is ATK_TEXT_GRANULARITY_PARAGRAPH the returned string
        /// is from the start of the paragraph at or before the offset to the start
        /// of the following paragraph after the offset.
        pub const get_string_at_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_granularity: atk.TextGranularity, p_start_offset: *c_int, p_end_offset: *c_int) ?[*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_string_at_offset.?(gobject.ext.as(Text, p_text), p_offset, p_granularity, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_granularity: atk.TextGranularity, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) ?[*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_string_at_offset = @ptrCast(p_implementation);
            }
        };

        /// Gets the specified text.
        pub const get_text = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int) [*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_text.?(gobject.ext.as(Text, p_text), p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_text = @ptrCast(p_implementation);
            }
        };

        /// Gets the specified text.
        pub const get_text_after_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_text_after_offset.?(gobject.ext.as(Text, p_text), p_offset, p_boundary_type, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_text_after_offset = @ptrCast(p_implementation);
            }
        };

        /// Gets the specified text.
        ///
        /// If the boundary_type if ATK_TEXT_BOUNDARY_CHAR the character at the
        /// offset is returned.
        ///
        /// If the boundary_type is ATK_TEXT_BOUNDARY_WORD_START the returned string
        /// is from the word start at or before the offset to the word start after
        /// the offset.
        ///
        /// The returned string will contain the word at the offset if the offset
        /// is inside a word and will contain the word before the offset if the
        /// offset is not inside a word.
        ///
        /// If the boundary type is ATK_TEXT_BOUNDARY_SENTENCE_START the returned
        /// string is from the sentence start at or before the offset to the sentence
        /// start after the offset.
        ///
        /// The returned string will contain the sentence at the offset if the offset
        /// is inside a sentence and will contain the sentence before the offset
        /// if the offset is not inside a sentence.
        ///
        /// If the boundary type is ATK_TEXT_BOUNDARY_LINE_START the returned
        /// string is from the line start at or before the offset to the line
        /// start after the offset.
        pub const get_text_at_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_text_at_offset.?(gobject.ext.as(Text, p_text), p_offset, p_boundary_type, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_text_at_offset = @ptrCast(p_implementation);
            }
        };

        /// Gets the specified text.
        pub const get_text_before_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8 {
                return gobject.ext.as(Text.Iface, p_class).f_get_text_before_offset.?(gobject.ext.as(Text, p_text), p_offset, p_boundary_type, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8) void {
                gobject.ext.as(Text.Iface, p_class).f_get_text_before_offset = @ptrCast(p_implementation);
            }
        };

        /// Removes the specified selection.
        pub const remove_selection = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_remove_selection.?(gobject.ext.as(Text, p_text), p_selection_num);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_remove_selection = @ptrCast(p_implementation);
            }
        };

        /// Makes a substring of `text` visible on the screen by scrolling all necessary parents.
        pub const scroll_substring_to = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_type: atk.ScrollType) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_scroll_substring_to.?(gobject.ext.as(Text, p_text), p_start_offset, p_end_offset, p_type);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_type: atk.ScrollType) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_scroll_substring_to = @ptrCast(p_implementation);
            }
        };

        /// Move the top-left of a substring of `text` to a given position of the screen
        /// by scrolling all necessary parents.
        pub const scroll_substring_to_point = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_scroll_substring_to_point.?(gobject.ext.as(Text, p_text), p_start_offset, p_end_offset, p_coords, p_x, p_y);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_start_offset: c_int, p_end_offset: c_int, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_scroll_substring_to_point = @ptrCast(p_implementation);
            }
        };

        /// Sets the caret (cursor) position to the specified `offset`.
        ///
        /// In the case of rich-text content, this method should either grab focus
        /// or move the sequential focus navigation starting point (if the application
        /// supports this concept) as if the user had clicked on the new caret position.
        /// Typically, this means that the target of this operation is the node containing
        /// the new caret position or one of its ancestors. In other words, after this
        /// method is called, if the user advances focus, it should move to the first
        /// focusable node following the new caret position.
        ///
        /// Calling this method should also scroll the application viewport in a way
        /// that matches the behavior of the application's typical caret motion or tab
        /// navigation as closely as possible. This also means that if the application's
        /// caret motion or focus navigation does not trigger a scroll operation, this
        /// method should not trigger one either. If the application does not have a caret
        /// motion or focus navigation operation, this method should try to scroll the new
        /// caret position into view while minimizing unnecessary scroll motion.
        pub const set_caret_offset = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_set_caret_offset.?(gobject.ext.as(Text, p_text), p_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_offset: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_set_caret_offset = @ptrCast(p_implementation);
            }
        };

        /// Changes the start and end offset of the specified selection.
        pub const set_selection = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int, p_start_offset: c_int, p_end_offset: c_int) c_int {
                return gobject.ext.as(Text.Iface, p_class).f_set_selection.?(gobject.ext.as(Text, p_text), p_selection_num, p_start_offset, p_end_offset);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_selection_num: c_int, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int) void {
                gobject.ext.as(Text.Iface, p_class).f_set_selection = @ptrCast(p_implementation);
            }
        };

        pub const text_attributes_changed = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Text.Iface, p_class).f_text_attributes_changed.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_text_attributes_changed = @ptrCast(p_implementation);
            }
        };

        pub const text_caret_moved = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_location: c_int) void {
                return gobject.ext.as(Text.Iface, p_class).f_text_caret_moved.?(gobject.ext.as(Text, p_text), p_location);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_location: c_int) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_text_caret_moved = @ptrCast(p_implementation);
            }
        };

        /// the signal handler which is executed when there is a
        ///   text change. This virtual function is deprecated sice 2.9.4 and
        ///   it should not be overriden.
        pub const text_changed = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: c_int, p_length: c_int) void {
                return gobject.ext.as(Text.Iface, p_class).f_text_changed.?(gobject.ext.as(Text, p_text), p_position, p_length);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_position: c_int, p_length: c_int) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_text_changed = @ptrCast(p_implementation);
            }
        };

        pub const text_selection_changed = struct {
            pub fn call(p_class: anytype, p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) void {
                return gobject.ext.as(Text.Iface, p_class).f_text_selection_changed.?(gobject.ext.as(Text, p_text));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_text: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) void) void {
                gobject.ext.as(Text.Iface, p_class).f_text_selection_changed = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The "text-attributes-changed" signal is emitted when the text
        /// attributes of the text of an object which implements AtkText
        /// changes.
        pub const text_attributes_changed = struct {
            pub const name = "text-attributes-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-attributes-changed", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "text-caret-moved" signal is emitted when the caret
        /// position of the text of an object which implements AtkText
        /// changes.
        pub const text_caret_moved = struct {
            pub const name = "text-caret-moved";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-caret-moved", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "text-changed" signal is emitted when the text of the
        /// object which implements the AtkText interface changes, This
        /// signal will have a detail which is either "insert" or
        /// "delete" which identifies whether the text change was an
        /// insertion or a deletion.
        pub const text_changed = struct {
            pub const name = "text-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-changed", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "text-insert" signal is emitted when a new text is
        /// inserted. If the signal was not triggered by the user
        /// (e.g. typing or pasting text), the "system" detail should be
        /// included.
        pub const text_insert = struct {
            pub const name = "text-insert";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, p_arg3: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-insert", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "text-remove" signal is emitted when a new text is
        /// removed. If the signal was not triggered by the user
        /// (e.g. typing or pasting text), the "system" detail should be
        /// included.
        pub const text_remove = struct {
            pub const name = "text-remove";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_arg1: c_int, p_arg2: c_int, p_arg3: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-remove", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The "text-selection-changed" signal is emitted when the
        /// selected text of an object which implements AtkText changes.
        pub const text_selection_changed = struct {
            pub const name = "text-selection-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Text, p_instance))),
                    gobject.signalLookup("text-selection-changed", Text.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Frees the memory associated with an array of AtkTextRange. It is assumed
    /// that the array was returned by the function atk_text_get_bounded_ranges
    /// and is NULL terminated.
    extern fn atk_text_free_ranges(p_ranges: [*]*atk.TextRange) void;
    pub const freeRanges = atk_text_free_ranges;

    /// Adds a selection bounded by the specified offsets.
    extern fn atk_text_add_selection(p_text: *Text, p_start_offset: c_int, p_end_offset: c_int) c_int;
    pub const addSelection = atk_text_add_selection;

    /// Get the ranges of text in the specified bounding box.
    extern fn atk_text_get_bounded_ranges(p_text: *Text, p_rect: *atk.TextRectangle, p_coord_type: atk.CoordType, p_x_clip_type: atk.TextClipType, p_y_clip_type: atk.TextClipType) [*]*atk.TextRange;
    pub const getBoundedRanges = atk_text_get_bounded_ranges;

    /// Gets the offset of the position of the caret (cursor).
    extern fn atk_text_get_caret_offset(p_text: *Text) c_int;
    pub const getCaretOffset = atk_text_get_caret_offset;

    /// Gets the specified text.
    extern fn atk_text_get_character_at_offset(p_text: *Text, p_offset: c_int) u32;
    pub const getCharacterAtOffset = atk_text_get_character_at_offset;

    /// Gets the character count.
    extern fn atk_text_get_character_count(p_text: *Text) c_int;
    pub const getCharacterCount = atk_text_get_character_count;

    /// If the extent can not be obtained (e.g. missing support), all of x, y, width,
    /// height are set to -1.
    ///
    /// Get the bounding box containing the glyph representing the character at
    ///     a particular text offset.
    extern fn atk_text_get_character_extents(p_text: *Text, p_offset: c_int, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coords: atk.CoordType) void;
    pub const getCharacterExtents = atk_text_get_character_extents;

    /// Creates an `atk.AttributeSet` which consists of the default values of
    /// attributes for the text. See the enum AtkTextAttribute for types of text
    /// attributes that can be returned. Note that other attributes may also be
    /// returned.
    extern fn atk_text_get_default_attributes(p_text: *Text) *atk.AttributeSet;
    pub const getDefaultAttributes = atk_text_get_default_attributes;

    /// Gets the number of selected regions.
    extern fn atk_text_get_n_selections(p_text: *Text) c_int;
    pub const getNSelections = atk_text_get_n_selections;

    /// Gets the offset of the character located at coordinates `x` and `y`. `x` and `y`
    /// are interpreted as being relative to the screen or this widget's window
    /// depending on `coords`.
    extern fn atk_text_get_offset_at_point(p_text: *Text, p_x: c_int, p_y: c_int, p_coords: atk.CoordType) c_int;
    pub const getOffsetAtPoint = atk_text_get_offset_at_point;

    /// Get the bounding box for text within the specified range.
    ///
    /// If the extents can not be obtained (e.g. or missing support), the rectangle
    /// fields are set to -1.
    extern fn atk_text_get_range_extents(p_text: *Text, p_start_offset: c_int, p_end_offset: c_int, p_coord_type: atk.CoordType, p_rect: *atk.TextRectangle) void;
    pub const getRangeExtents = atk_text_get_range_extents;

    /// Creates an `atk.AttributeSet` which consists of the attributes explicitly
    /// set at the position `offset` in the text. `start_offset` and `end_offset` are
    /// set to the start and end of the range around `offset` where the attributes are
    /// invariant. Note that `end_offset` is the offset of the first character
    /// after the range.  See the enum AtkTextAttribute for types of text
    /// attributes that can be returned. Note that other attributes may also be
    /// returned.
    extern fn atk_text_get_run_attributes(p_text: *Text, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int) *atk.AttributeSet;
    pub const getRunAttributes = atk_text_get_run_attributes;

    /// Gets the text from the specified selection.
    extern fn atk_text_get_selection(p_text: *Text, p_selection_num: c_int, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8;
    pub const getSelection = atk_text_get_selection;

    /// Gets a portion of the text exposed through an `atk.Text` according to a given `offset`
    /// and a specific `granularity`, along with the start and end offsets defining the
    /// boundaries of such a portion of text.
    ///
    /// If `granularity` is ATK_TEXT_GRANULARITY_CHAR the character at the
    /// offset is returned.
    ///
    /// If `granularity` is ATK_TEXT_GRANULARITY_WORD the returned string
    /// is from the word start at or before the offset to the word start after
    /// the offset.
    ///
    /// The returned string will contain the word at the offset if the offset
    /// is inside a word and will contain the word before the offset if the
    /// offset is not inside a word.
    ///
    /// If `granularity` is ATK_TEXT_GRANULARITY_SENTENCE the returned string
    /// is from the sentence start at or before the offset to the sentence
    /// start after the offset.
    ///
    /// The returned string will contain the sentence at the offset if the offset
    /// is inside a sentence and will contain the sentence before the offset
    /// if the offset is not inside a sentence.
    ///
    /// If `granularity` is ATK_TEXT_GRANULARITY_LINE the returned string
    /// is from the line start at or before the offset to the line
    /// start after the offset.
    ///
    /// If `granularity` is ATK_TEXT_GRANULARITY_PARAGRAPH the returned string
    /// is from the start of the paragraph at or before the offset to the start
    /// of the following paragraph after the offset.
    extern fn atk_text_get_string_at_offset(p_text: *Text, p_offset: c_int, p_granularity: atk.TextGranularity, p_start_offset: *c_int, p_end_offset: *c_int) ?[*:0]u8;
    pub const getStringAtOffset = atk_text_get_string_at_offset;

    /// Gets the specified text.
    extern fn atk_text_get_text(p_text: *Text, p_start_offset: c_int, p_end_offset: c_int) [*:0]u8;
    pub const getText = atk_text_get_text;

    /// Gets the specified text.
    extern fn atk_text_get_text_after_offset(p_text: *Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8;
    pub const getTextAfterOffset = atk_text_get_text_after_offset;

    /// Gets the specified text.
    ///
    /// If the boundary_type if ATK_TEXT_BOUNDARY_CHAR the character at the
    /// offset is returned.
    ///
    /// If the boundary_type is ATK_TEXT_BOUNDARY_WORD_START the returned string
    /// is from the word start at or before the offset to the word start after
    /// the offset.
    ///
    /// The returned string will contain the word at the offset if the offset
    /// is inside a word and will contain the word before the offset if the
    /// offset is not inside a word.
    ///
    /// If the boundary type is ATK_TEXT_BOUNDARY_SENTENCE_START the returned
    /// string is from the sentence start at or before the offset to the sentence
    /// start after the offset.
    ///
    /// The returned string will contain the sentence at the offset if the offset
    /// is inside a sentence and will contain the sentence before the offset
    /// if the offset is not inside a sentence.
    ///
    /// If the boundary type is ATK_TEXT_BOUNDARY_LINE_START the returned
    /// string is from the line start at or before the offset to the line
    /// start after the offset.
    extern fn atk_text_get_text_at_offset(p_text: *Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8;
    pub const getTextAtOffset = atk_text_get_text_at_offset;

    /// Gets the specified text.
    extern fn atk_text_get_text_before_offset(p_text: *Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) [*:0]u8;
    pub const getTextBeforeOffset = atk_text_get_text_before_offset;

    /// Removes the specified selection.
    extern fn atk_text_remove_selection(p_text: *Text, p_selection_num: c_int) c_int;
    pub const removeSelection = atk_text_remove_selection;

    /// Makes a substring of `text` visible on the screen by scrolling all necessary parents.
    extern fn atk_text_scroll_substring_to(p_text: *Text, p_start_offset: c_int, p_end_offset: c_int, p_type: atk.ScrollType) c_int;
    pub const scrollSubstringTo = atk_text_scroll_substring_to;

    /// Move the top-left of a substring of `text` to a given position of the screen
    /// by scrolling all necessary parents.
    extern fn atk_text_scroll_substring_to_point(p_text: *Text, p_start_offset: c_int, p_end_offset: c_int, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) c_int;
    pub const scrollSubstringToPoint = atk_text_scroll_substring_to_point;

    /// Sets the caret (cursor) position to the specified `offset`.
    ///
    /// In the case of rich-text content, this method should either grab focus
    /// or move the sequential focus navigation starting point (if the application
    /// supports this concept) as if the user had clicked on the new caret position.
    /// Typically, this means that the target of this operation is the node containing
    /// the new caret position or one of its ancestors. In other words, after this
    /// method is called, if the user advances focus, it should move to the first
    /// focusable node following the new caret position.
    ///
    /// Calling this method should also scroll the application viewport in a way
    /// that matches the behavior of the application's typical caret motion or tab
    /// navigation as closely as possible. This also means that if the application's
    /// caret motion or focus navigation does not trigger a scroll operation, this
    /// method should not trigger one either. If the application does not have a caret
    /// motion or focus navigation operation, this method should try to scroll the new
    /// caret position into view while minimizing unnecessary scroll motion.
    extern fn atk_text_set_caret_offset(p_text: *Text, p_offset: c_int) c_int;
    pub const setCaretOffset = atk_text_set_caret_offset;

    /// Changes the start and end offset of the specified selection.
    extern fn atk_text_set_selection(p_text: *Text, p_selection_num: c_int, p_start_offset: c_int, p_end_offset: c_int) c_int;
    pub const setSelection = atk_text_set_selection;

    extern fn atk_text_get_type() usize;
    pub const getGObjectType = atk_text_get_type;

    extern fn g_object_ref(p_self: *atk.Text) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Text) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Text, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK interface implemented by valuators and components which display or select a value from a bounded range of values.
///
/// `atk.Value` should be implemented for components which either display
/// a value from a bounded range, or which allow the user to specify a
/// value from a bounded range, or both. For instance, most sliders and
/// range controls, as well as dials, should have `atk.Object`
/// representations which implement `atk.Value` on the component's
/// behalf. `AtKValues` may be read-only, in which case attempts to
/// alter the value return would fail.
///
/// <refsect1 id="current-value-text">
/// <title>On the subject of current value text</title>
/// <para>
/// In addition to providing the current value, implementors can
/// optionally provide an end-user-consumable textual description
/// associated with this value. This description should be included
/// when the numeric value fails to convey the full, on-screen
/// representation seen by users.
/// </para>
///
/// <example>
/// <title>Password strength</title>
/// A password strength meter whose value changes as the user types
/// their new password. Red is used for values less than 4.0, yellow
/// for values between 4.0 and 7.0, and green for values greater than
/// 7.0. In this instance, value text should be provided by the
/// implementor. Appropriate value text would be "weak", "acceptable,"
/// and "strong" respectively.
/// </example>
///
/// A level bar whose value changes to reflect the battery charge. The
/// color remains the same regardless of the charge and there is no
/// on-screen text reflecting the fullness of the battery. In this
/// case, because the position within the bar is the only indication
/// the user has of the current charge, value text should not be
/// provided by the implementor.
///
/// <refsect2 id="implementor-notes">
/// <title>Implementor Notes</title>
/// <para>
/// Implementors should bear in mind that assistive technologies will
/// likely prefer the value text provided over the numeric value when
/// presenting a widget's value. As a result, strings not intended for
/// end users should not be exposed in the value text, and strings
/// which are exposed should be localized. In the case of widgets which
/// display value text on screen, for instance through a separate label
/// in close proximity to the value-displaying widget, it is still
/// expected that implementors will expose the value text using the
/// above API.
/// </para>
///
/// <para>
/// `atk.Value` should NOT be implemented for widgets whose displayed
/// value is not reflective of a meaningful amount. For instance, a
/// progress pulse indicator whose value alternates between 0.0 and 1.0
/// to indicate that some process is still taking place should not
/// implement `atk.Value` because the current value does not reflect
/// progress towards completion.
/// </para>
/// </refsect2>
/// </refsect1>
///
/// <refsect1 id="ranges">
/// <title>On the subject of ranges</title>
/// <para>
/// In addition to providing the minimum and maximum values,
/// implementors can optionally provide details about subranges
/// associated with the widget. These details should be provided by the
/// implementor when both of the following are communicated visually to
/// the end user:
/// </para>
/// <itemizedlist>
///   <listitem>The existence of distinct ranges such as "weak",
///   "acceptable", and "strong" indicated by color, bar tick marks,
///   and/or on-screen text.</listitem>
///   <listitem>Where the current value stands within a given subrange,
///   for instance illustrating progression from very "weak" towards
///   nearly "acceptable" through changes in shade and/or position on
///   the bar within the "weak" subrange.</listitem>
/// </itemizedlist>
/// <para>
/// If both of the above do not apply to the widget, it should be
/// sufficient to expose the numeric value, along with the value text
/// if appropriate, to make the widget accessible.
/// </para>
///
/// <refsect2 id="ranges-implementor-notes">
/// <title>Implementor Notes</title>
/// <para>
/// If providing subrange details is deemed necessary, all possible
/// values of the widget are expected to fall within one of the
/// subranges defined by the implementor.
/// </para>
/// </refsect2>
/// </refsect1>
///
/// <refsect1 id="localization">
/// <title>On the subject of localization of end-user-consumable text
/// values</title>
/// <para>
/// Because value text and subrange descriptors are human-consumable,
/// implementors are expected to provide localized strings which can be
/// directly presented to end users via their assistive technology. In
/// order to simplify this for implementors, implementors can use
/// `atk.valueTypeGetLocalizedName` with the following
/// already-localized constants for commonly-needed values can be used:
/// </para>
///
/// <itemizedlist>
///   <listitem>ATK_VALUE_VERY_WEAK</listitem>
///   <listitem>ATK_VALUE_WEAK</listitem>
///   <listitem>ATK_VALUE_ACCEPTABLE</listitem>
///   <listitem>ATK_VALUE_STRONG</listitem>
///   <listitem>ATK_VALUE_VERY_STRONG</listitem>
///   <listitem>ATK_VALUE_VERY_LOW</listitem>
///   <listitem>ATK_VALUE_LOW</listitem>
///   <listitem>ATK_VALUE_MEDIUM</listitem>
///   <listitem>ATK_VALUE_HIGH</listitem>
///   <listitem>ATK_VALUE_VERY_HIGH</listitem>
///   <listitem>ATK_VALUE_VERY_BAD</listitem>
///   <listitem>ATK_VALUE_BAD</listitem>
///   <listitem>ATK_VALUE_GOOD</listitem>
///   <listitem>ATK_VALUE_VERY_GOOD</listitem>
///   <listitem>ATK_VALUE_BEST</listitem>
///   <listitem>ATK_VALUE_SUBSUBOPTIMAL</listitem>
///   <listitem>ATK_VALUE_SUBOPTIMAL</listitem>
///   <listitem>ATK_VALUE_OPTIMAL</listitem>
/// </itemizedlist>
/// <para>
/// Proposals for additional constants, along with their use cases,
/// should be submitted to the GNOME Accessibility Team.
/// </para>
/// </refsect1>
///
/// <refsect1 id="changes">
/// <title>On the subject of changes</title>
/// <para>
/// Note that if there is a textual description associated with the new
/// numeric value, that description should be included regardless of
/// whether or not it has also changed.
/// </para>
/// </refsect1>
pub const Value = opaque {
    pub const Prerequisites = [_]type{gobject.Object};
    pub const Iface = atk.ValueIface;
    pub const virtual_methods = struct {
        /// Gets the value of this object.
        pub const get_current_value = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) void {
                return gobject.ext.as(Value.Iface, p_class).f_get_current_value.?(gobject.ext.as(Value, p_obj), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_get_current_value = @ptrCast(p_implementation);
            }
        };

        /// Gets the minimum increment by which the value of this object may be
        /// changed.  If zero, the minimum increment is undefined, which may
        /// mean that it is limited only by the floating point precision of the
        /// platform.
        pub const get_increment = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) f64 {
                return gobject.ext.as(Value.Iface, p_class).f_get_increment.?(gobject.ext.as(Value, p_obj));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) f64) void {
                gobject.ext.as(Value.Iface, p_class).f_get_increment = @ptrCast(p_implementation);
            }
        };

        /// Gets the maximum value of this object.
        pub const get_maximum_value = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) void {
                return gobject.ext.as(Value.Iface, p_class).f_get_maximum_value.?(gobject.ext.as(Value, p_obj), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_get_maximum_value = @ptrCast(p_implementation);
            }
        };

        /// Gets the minimum increment by which the value of this object may be changed.  If zero,
        /// the minimum increment is undefined, which may mean that it is limited only by the
        /// floating point precision of the platform.
        pub const get_minimum_increment = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) void {
                return gobject.ext.as(Value.Iface, p_class).f_get_minimum_increment.?(gobject.ext.as(Value, p_obj), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_get_minimum_increment = @ptrCast(p_implementation);
            }
        };

        /// Gets the minimum value of this object.
        pub const get_minimum_value = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) void {
                return gobject.ext.as(Value.Iface, p_class).f_get_minimum_value.?(gobject.ext.as(Value, p_obj), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *gobject.Value) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_get_minimum_value = @ptrCast(p_implementation);
            }
        };

        /// Gets the range of this object.
        pub const get_range = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) ?*atk.Range {
                return gobject.ext.as(Value.Iface, p_class).f_get_range.?(gobject.ext.as(Value, p_obj));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) ?*atk.Range) void {
                gobject.ext.as(Value.Iface, p_class).f_get_range = @ptrCast(p_implementation);
            }
        };

        /// Gets the list of subranges defined for this object. See `atk.Value`
        /// introduction for examples of subranges and when to expose them.
        pub const get_sub_ranges = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) *glib.SList {
                return gobject.ext.as(Value.Iface, p_class).f_get_sub_ranges.?(gobject.ext.as(Value, p_obj));
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance) callconv(.c) *glib.SList) void {
                gobject.ext.as(Value.Iface, p_class).f_get_sub_ranges = @ptrCast(p_implementation);
            }
        };

        /// Gets the current value and the human readable text alternative of
        /// `obj`. `text` is a newly created string, that must be freed by the
        /// caller. Can be NULL if no descriptor is available.
        pub const get_value_and_text = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *f64, p_text: ?*[*:0]u8) void {
                return gobject.ext.as(Value.Iface, p_class).f_get_value_and_text.?(gobject.ext.as(Value, p_obj), p_value, p_text);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *f64, p_text: ?*[*:0]u8) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_get_value_and_text = @ptrCast(p_implementation);
            }
        };

        /// Sets the value of this object.
        pub const set_current_value = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *const gobject.Value) c_int {
                return gobject.ext.as(Value.Iface, p_class).f_set_current_value.?(gobject.ext.as(Value, p_obj), p_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_value: *const gobject.Value) callconv(.c) c_int) void {
                gobject.ext.as(Value.Iface, p_class).f_set_current_value = @ptrCast(p_implementation);
            }
        };

        /// Sets the value of this object.
        ///
        /// This method is intended to provide a way to change the value of the
        /// object. In any case, it is possible that the value can't be
        /// modified (ie: a read-only component). If the value changes due this
        /// call, it is possible that the text could change, and will trigger
        /// an `atk.Value.signals.value`-changed signal emission.
        ///
        /// Note for implementors: the deprecated `atk.Value.setCurrentValue`
        /// method returned TRUE or FALSE depending if the value was assigned
        /// or not. In the practice several implementors were not able to
        /// decide it, and returned TRUE in any case. For that reason it is not
        /// required anymore to return if the value was properly assigned or
        /// not.
        pub const set_value = struct {
            pub fn call(p_class: anytype, p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_new_value: f64) void {
                return gobject.ext.as(Value.Iface, p_class).f_set_value.?(gobject.ext.as(Value, p_obj), p_new_value);
            }

            pub fn implement(p_class: anytype, p_implementation: *const fn (p_obj: *@typeInfo(@TypeOf(p_class)).pointer.child.Instance, p_new_value: f64) callconv(.c) void) void {
                gobject.ext.as(Value.Iface, p_class).f_set_value = @ptrCast(p_implementation);
            }
        };
    };

    pub const properties = struct {};

    pub const signals = struct {
        /// The 'value-changed' signal is emitted when the current value
        /// that represent the object changes. `value` is the numerical
        /// representation of this new value.  `text` is the human
        /// readable text alternative of `value`, and can be NULL if it is
        /// not available. Note that if there is a textual description
        /// associated with the new numeric value, that description
        /// should be included regardless of whether or not it has also
        /// changed.
        ///
        /// Example: a password meter whose value changes as the user
        /// types their new password. Appropiate value text would be
        /// "weak", "acceptable" and "strong".
        pub const value_changed = struct {
            pub const name = "value-changed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_value: f64, p_text: [*:0]u8, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Value, p_instance))),
                    gobject.signalLookup("value-changed", Value.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the value of this object.
    extern fn atk_value_get_current_value(p_obj: *Value, p_value: *gobject.Value) void;
    pub const getCurrentValue = atk_value_get_current_value;

    /// Gets the minimum increment by which the value of this object may be
    /// changed.  If zero, the minimum increment is undefined, which may
    /// mean that it is limited only by the floating point precision of the
    /// platform.
    extern fn atk_value_get_increment(p_obj: *Value) f64;
    pub const getIncrement = atk_value_get_increment;

    /// Gets the maximum value of this object.
    extern fn atk_value_get_maximum_value(p_obj: *Value, p_value: *gobject.Value) void;
    pub const getMaximumValue = atk_value_get_maximum_value;

    /// Gets the minimum increment by which the value of this object may be changed.  If zero,
    /// the minimum increment is undefined, which may mean that it is limited only by the
    /// floating point precision of the platform.
    extern fn atk_value_get_minimum_increment(p_obj: *Value, p_value: *gobject.Value) void;
    pub const getMinimumIncrement = atk_value_get_minimum_increment;

    /// Gets the minimum value of this object.
    extern fn atk_value_get_minimum_value(p_obj: *Value, p_value: *gobject.Value) void;
    pub const getMinimumValue = atk_value_get_minimum_value;

    /// Gets the range of this object.
    extern fn atk_value_get_range(p_obj: *Value) ?*atk.Range;
    pub const getRange = atk_value_get_range;

    /// Gets the list of subranges defined for this object. See `atk.Value`
    /// introduction for examples of subranges and when to expose them.
    extern fn atk_value_get_sub_ranges(p_obj: *Value) *glib.SList;
    pub const getSubRanges = atk_value_get_sub_ranges;

    /// Gets the current value and the human readable text alternative of
    /// `obj`. `text` is a newly created string, that must be freed by the
    /// caller. Can be NULL if no descriptor is available.
    extern fn atk_value_get_value_and_text(p_obj: *Value, p_value: *f64, p_text: ?*[*:0]u8) void;
    pub const getValueAndText = atk_value_get_value_and_text;

    /// Sets the value of this object.
    extern fn atk_value_set_current_value(p_obj: *Value, p_value: *const gobject.Value) c_int;
    pub const setCurrentValue = atk_value_set_current_value;

    /// Sets the value of this object.
    ///
    /// This method is intended to provide a way to change the value of the
    /// object. In any case, it is possible that the value can't be
    /// modified (ie: a read-only component). If the value changes due this
    /// call, it is possible that the text could change, and will trigger
    /// an `atk.Value.signals.value`-changed signal emission.
    ///
    /// Note for implementors: the deprecated `atk.Value.setCurrentValue`
    /// method returned TRUE or FALSE depending if the value was assigned
    /// or not. In the practice several implementors were not able to
    /// decide it, and returned TRUE in any case. For that reason it is not
    /// required anymore to return if the value was properly assigned or
    /// not.
    extern fn atk_value_set_value(p_obj: *Value, p_new_value: f64) void;
    pub const setValue = atk_value_set_value;

    extern fn atk_value_get_type() usize;
    pub const getGObjectType = atk_value_get_type;

    extern fn g_object_ref(p_self: *atk.Value) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Value) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Value, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The ATK Interface provided by UI components that represent a top-level window.
///
/// `atk.Window` should be implemented by the UI elements that represent
/// a top-level window, such as the main window of an application or
/// dialog.
///
/// See `AtkObject`
pub const Window = opaque {
    pub const Prerequisites = [_]type{atk.Object};
    pub const Iface = atk.WindowIface;
    pub const virtual_methods = struct {};

    pub const properties = struct {};

    pub const signals = struct {
        /// The signal `atk.Window.signals.activate` is emitted when a window
        /// becomes the active window of the application or session.
        pub const activate = struct {
            pub const name = "activate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("activate", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.create` is emitted when a new window
        /// is created.
        pub const create = struct {
            pub const name = "create";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("create", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.deactivate` is emitted when a window is
        /// no longer the active window of the application or session.
        pub const deactivate = struct {
            pub const name = "deactivate";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("deactivate", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.destroy` is emitted when a window is
        /// destroyed.
        pub const destroy = struct {
            pub const name = "destroy";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("destroy", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.maximize` is emitted when a window
        /// is maximized.
        pub const maximize = struct {
            pub const name = "maximize";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("maximize", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.minimize` is emitted when a window
        /// is minimized.
        pub const minimize = struct {
            pub const name = "minimize";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("minimize", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.move` is emitted when a window
        /// is moved.
        pub const move = struct {
            pub const name = "move";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("move", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.resize` is emitted when a window
        /// is resized.
        pub const resize = struct {
            pub const name = "resize";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("resize", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// The signal `atk.Window.signals.restore` is emitted when a window
        /// is restored.
        pub const restore = struct {
            pub const name = "restore";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Window, p_instance))),
                    gobject.signalLookup("restore", Window.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    extern fn atk_window_get_type() usize;
    pub const getGObjectType = atk_window_get_type;

    extern fn g_object_ref(p_self: *atk.Window) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *atk.Window) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Window, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The `atk.Action` interface should be supported by any object that can
/// perform one or more actions. The interface provides the standard
/// mechanism for an assistive technology to determine what those actions
/// are as well as tell the object to perform them. Any object that can
/// be manipulated should support this interface.
pub const ActionIface = extern struct {
    pub const Instance = atk.Action;

    f_parent: gobject.TypeInterface,
    f_do_action: ?*const fn (p_action: *atk.Action, p_i: c_int) callconv(.c) c_int,
    f_get_n_actions: ?*const fn (p_action: *atk.Action) callconv(.c) c_int,
    f_get_description: ?*const fn (p_action: *atk.Action, p_i: c_int) callconv(.c) ?[*:0]const u8,
    f_get_name: ?*const fn (p_action: *atk.Action, p_i: c_int) callconv(.c) ?[*:0]const u8,
    f_get_keybinding: ?*const fn (p_action: *atk.Action, p_i: c_int) callconv(.c) ?[*:0]const u8,
    f_set_description: ?*const fn (p_action: *atk.Action, p_i: c_int, p_desc: [*:0]const u8) callconv(.c) c_int,
    f_get_localized_name: ?*const fn (p_action: *atk.Action, p_i: c_int) callconv(.c) ?[*:0]const u8,

    pub fn as(p_instance: *ActionIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// AtkAttribute is a string name/value pair representing a generic
/// attribute. This can be used to expose additional information from
/// an accessible object as a whole (see `atk.Object.getAttributes`)
/// or an document (see `atk.Document.getAttributes`). In the case of
/// text attributes (see `atk.Text.getDefaultAttributes`),
/// `atk.TextAttribute` enum defines all the possible text attribute
/// names. You can use `atk.textAttributeGetName` to get the string
/// name from the enum value. See also `atk.textAttributeForName`
/// and `atk.textAttributeGetValue` for more information.
///
/// A string name/value pair representing a generic attribute.
pub const Attribute = extern struct {
    /// The attribute name.
    f_name: ?[*:0]u8,
    /// the value of the attribute, represented as a string.
    f_value: ?[*:0]u8,

    /// Frees the memory used by an `atk.AttributeSet`, including all its
    /// `AtkAttributes`.
    extern fn atk_attribute_set_free(p_attrib_set: *atk.AttributeSet) void;
    pub const setFree = atk_attribute_set_free;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The AtkComponent interface should be supported by any object that is
/// rendered on the screen. The interface provides the standard mechanism
/// for an assistive technology to determine and set the graphical
/// representation of an object.
pub const ComponentIface = extern struct {
    pub const Instance = atk.Component;

    f_parent: gobject.TypeInterface,
    /// This virtual function is deprecated since 2.9.4
    ///   and it should not be overriden. See `atk.Component.addFocusHandler`
    ///   for more information.
    f_add_focus_handler: ?*const fn (p_component: *atk.Component, p_handler: atk.FocusHandler) callconv(.c) c_uint,
    f_contains: ?*const fn (p_component: *atk.Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int,
    f_ref_accessible_at_point: ?*const fn (p_component: *atk.Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) ?*atk.Object,
    f_get_extents: ?*const fn (p_component: *atk.Component, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void,
    /// This virtual function is deprecated since 2.12 and
    ///   it should not be overriden. Use `AtkComponentIface`.get_extents instead.
    f_get_position: ?*const fn (p_component: *atk.Component, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void,
    /// This virtual function is deprecated since 2.12 and it
    ///   should not be overriden. Use `AtkComponentIface`.get_extents instead.
    f_get_size: ?*const fn (p_component: *atk.Component, p_width: ?*c_int, p_height: ?*c_int) callconv(.c) void,
    f_grab_focus: ?*const fn (p_component: *atk.Component) callconv(.c) c_int,
    /// This virtual function is deprecated since
    ///   2.9.4 and it should not be overriden. See `atk.Component.removeFocusHandler`
    ///   for more information.
    f_remove_focus_handler: ?*const fn (p_component: *atk.Component, p_handler_id: c_uint) callconv(.c) void,
    f_set_extents: ?*const fn (p_component: *atk.Component, p_x: c_int, p_y: c_int, p_width: c_int, p_height: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int,
    f_set_position: ?*const fn (p_component: *atk.Component, p_x: c_int, p_y: c_int, p_coord_type: atk.CoordType) callconv(.c) c_int,
    f_set_size: ?*const fn (p_component: *atk.Component, p_width: c_int, p_height: c_int) callconv(.c) c_int,
    f_get_layer: ?*const fn (p_component: *atk.Component) callconv(.c) atk.Layer,
    f_get_mdi_zorder: ?*const fn (p_component: *atk.Component) callconv(.c) c_int,
    f_bounds_changed: ?*const fn (p_component: *atk.Component, p_bounds: *atk.Rectangle) callconv(.c) void,
    f_get_alpha: ?*const fn (p_component: *atk.Component) callconv(.c) f64,
    f_scroll_to: ?*const fn (p_component: *atk.Component, p_type: atk.ScrollType) callconv(.c) c_int,
    f_scroll_to_point: ?*const fn (p_component: *atk.Component, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) callconv(.c) c_int,

    pub fn as(p_instance: *ComponentIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const DocumentIface = extern struct {
    pub const Instance = atk.Document;

    f_parent: gobject.TypeInterface,
    /// gets a string indicating the document
    ///   type. This virtual function is deprecated since 2.12 and it
    ///   should not be overriden.
    f_get_document_type: ?*const fn (p_document: *atk.Document) callconv(.c) [*:0]const u8,
    /// a `gobject.Object` instance that implements
    ///   AtkDocumentIface. This virtual method is deprecated since 2.12
    ///   and it should not be overriden.
    f_get_document: ?*const fn (p_document: *atk.Document) callconv(.c) ?*anyopaque,
    /// gets locale. This virtual function is
    ///   deprecated since 2.7.90 and it should not be overriden.
    f_get_document_locale: ?*const fn (p_document: *atk.Document) callconv(.c) [*:0]const u8,
    /// gets an AtkAttributeSet which describes
    ///   document-wide attributes as name-value pairs.
    f_get_document_attributes: ?*const fn (p_document: *atk.Document) callconv(.c) *atk.AttributeSet,
    /// returns a string value assocciated
    ///   with the named attribute for this document, or NULL
    f_get_document_attribute_value: ?*const fn (p_document: *atk.Document, p_attribute_name: [*:0]const u8) callconv(.c) ?[*:0]const u8,
    /// sets the value of an attribute. Returns
    ///   TRUE on success, FALSE otherwise
    f_set_document_attribute: ?*const fn (p_document: *atk.Document, p_attribute_name: [*:0]const u8, p_attribute_value: [*:0]const u8) callconv(.c) c_int,
    /// gets the current page number. Since 2.12
    f_get_current_page_number: ?*const fn (p_document: *atk.Document) callconv(.c) c_int,
    /// gets the page count of the document. Since 2.12
    f_get_page_count: ?*const fn (p_document: *atk.Document) callconv(.c) c_int,
    f_get_text_selections: ?*const fn (p_document: *atk.Document) callconv(.c) *glib.Array,
    f_set_text_selections: ?*const fn (p_document: *atk.Document, p_selections: *glib.Array) callconv(.c) c_int,

    pub fn as(p_instance: *DocumentIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const EditableTextIface = extern struct {
    pub const Instance = atk.EditableText;

    f_parent_interface: gobject.TypeInterface,
    f_set_run_attributes: ?*const fn (p_text: *atk.EditableText, p_attrib_set: *atk.AttributeSet, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int,
    f_set_text_contents: ?*const fn (p_text: *atk.EditableText, p_string: [*:0]const u8) callconv(.c) void,
    f_insert_text: ?*const fn (p_text: *atk.EditableText, p_string: [*:0]const u8, p_length: c_int, p_position: *c_int) callconv(.c) void,
    f_copy_text: ?*const fn (p_text: *atk.EditableText, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void,
    f_cut_text: ?*const fn (p_text: *atk.EditableText, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void,
    f_delete_text: ?*const fn (p_text: *atk.EditableText, p_start_pos: c_int, p_end_pos: c_int) callconv(.c) void,
    f_paste_text: ?*const fn (p_text: *atk.EditableText, p_position: c_int) callconv(.c) void,

    pub fn as(p_instance: *EditableTextIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const GObjectAccessibleClass = extern struct {
    pub const Instance = atk.GObjectAccessible;

    f_parent_class: atk.ObjectClass,
    f_pad1: ?atk.Function,
    f_pad2: ?atk.Function,

    pub fn as(p_instance: *GObjectAccessibleClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HyperlinkClass = extern struct {
    pub const Instance = atk.Hyperlink;

    f_parent: gobject.ObjectClass,
    f_get_uri: ?*const fn (p_link_: *atk.Hyperlink, p_i: c_int) callconv(.c) [*:0]u8,
    f_get_object: ?*const fn (p_link_: *atk.Hyperlink, p_i: c_int) callconv(.c) *atk.Object,
    f_get_end_index: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_int,
    f_get_start_index: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_int,
    f_is_valid: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_int,
    f_get_n_anchors: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_int,
    f_link_state: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_uint,
    f_is_selected_link: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) c_int,
    f_link_activated: ?*const fn (p_link_: *atk.Hyperlink) callconv(.c) void,
    f_pad1: ?atk.Function,

    pub fn as(p_instance: *HyperlinkClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HyperlinkImplIface = extern struct {
    pub const Instance = atk.HyperlinkImpl;

    f_parent: gobject.TypeInterface,
    f_get_hyperlink: ?*const fn (p_impl: *atk.HyperlinkImpl) callconv(.c) *atk.Hyperlink,

    pub fn as(p_instance: *HyperlinkImplIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const HypertextIface = extern struct {
    pub const Instance = atk.Hypertext;

    f_parent: gobject.TypeInterface,
    f_get_link: ?*const fn (p_hypertext: *atk.Hypertext, p_link_index: c_int) callconv(.c) *atk.Hyperlink,
    f_get_n_links: ?*const fn (p_hypertext: *atk.Hypertext) callconv(.c) c_int,
    f_get_link_index: ?*const fn (p_hypertext: *atk.Hypertext, p_char_index: c_int) callconv(.c) c_int,
    f_link_selected: ?*const fn (p_hypertext: *atk.Hypertext, p_link_index: c_int) callconv(.c) void,

    pub fn as(p_instance: *HypertextIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ImageIface = extern struct {
    pub const Instance = atk.Image;

    f_parent: gobject.TypeInterface,
    f_get_image_position: ?*const fn (p_image: *atk.Image, p_x: ?*c_int, p_y: ?*c_int, p_coord_type: atk.CoordType) callconv(.c) void,
    f_get_image_description: ?*const fn (p_image: *atk.Image) callconv(.c) [*:0]const u8,
    f_get_image_size: ?*const fn (p_image: *atk.Image, p_width: ?*c_int, p_height: ?*c_int) callconv(.c) void,
    f_set_image_description: ?*const fn (p_image: *atk.Image, p_description: [*:0]const u8) callconv(.c) c_int,
    f_get_image_locale: ?*const fn (p_image: *atk.Image) callconv(.c) ?[*:0]const u8,

    pub fn as(p_instance: *ImageIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Implementor = opaque {
    /// Gets a reference to an object's `atk.Object` implementation, if
    /// the object implements `AtkObjectIface`
    extern fn atk_implementor_ref_accessible(p_implementor: *Implementor) *atk.Object;
    pub const refAccessible = atk_implementor_ref_accessible;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Encapsulates information about a key event.
pub const KeyEventStruct = extern struct {
    /// An AtkKeyEventType, generally one of ATK_KEY_EVENT_PRESS or ATK_KEY_EVENT_RELEASE
    f_type: c_int,
    /// A bitmask representing the state of the modifier keys immediately after the event takes place.
    /// The meaning of the bits is currently defined to match the bitmask used by GDK in
    /// GdkEventType.state, see
    /// http://developer.gnome.org/doc/API/2.0/gdk/gdk-Event-Structures.html`GdkEventKey`
    f_state: c_uint,
    /// A guint representing a keysym value corresponding to those used by GDK and X11: see
    /// /usr/X11/include/keysymdef.h.
    f_keyval: c_uint,
    /// The length of member `string`.
    f_length: c_int,
    /// A string containing one of the following: either a string approximating the text that would
    /// result from this keypress, if the key is a control or graphic character, or a symbolic name for this keypress.
    /// Alphanumeric and printable keys will have the symbolic key name in this string member, for instance "A". "0",
    /// "semicolon", "aacute".  Keypad keys have the prefix "KP".
    f_string: ?[*:0]u8,
    /// The raw hardware code that generated the key event.  This field is raraly useful.
    f_keycode: u16,
    /// A timestamp in milliseconds indicating when the event occurred.
    /// These timestamps are relative to a starting point which should be considered arbitrary,
    /// and only used to compare the dispatch times of events to one another.
    f_timestamp: u32,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Usage of AtkMisc is deprecated since 2.12 and heavily discouraged.
pub const MiscClass = extern struct {
    pub const Instance = atk.Misc;

    f_parent: gobject.ObjectClass,
    /// This virtual function is deprecated since 2.12 and
    ///   it should not be overriden.
    f_threads_enter: ?*const fn (p_misc: *atk.Misc) callconv(.c) void,
    /// This virtual function is deprecated sice 2.12 and
    ///   it should not be overriden.
    f_threads_leave: ?*const fn (p_misc: *atk.Misc) callconv(.c) void,
    f_vfuncs: [32]*anyopaque,

    pub fn as(p_instance: *MiscClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NoOpObjectClass = extern struct {
    pub const Instance = atk.NoOpObject;

    f_parent_class: atk.ObjectClass,

    pub fn as(p_instance: *NoOpObjectClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const NoOpObjectFactoryClass = extern struct {
    pub const Instance = atk.NoOpObjectFactory;

    f_parent_class: atk.ObjectFactoryClass,

    pub fn as(p_instance: *NoOpObjectFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectClass = extern struct {
    pub const Instance = atk.Object;

    f_parent: gobject.ObjectClass,
    f_get_name: ?*const fn (p_accessible: *atk.Object) callconv(.c) [*:0]const u8,
    f_get_description: ?*const fn (p_accessible: *atk.Object) callconv(.c) [*:0]const u8,
    f_get_parent: ?*const fn (p_accessible: *atk.Object) callconv(.c) *atk.Object,
    f_get_n_children: ?*const fn (p_accessible: *atk.Object) callconv(.c) c_int,
    f_ref_child: ?*const fn (p_accessible: *atk.Object, p_i: c_int) callconv(.c) *atk.Object,
    f_get_index_in_parent: ?*const fn (p_accessible: *atk.Object) callconv(.c) c_int,
    f_ref_relation_set: ?*const fn (p_accessible: *atk.Object) callconv(.c) *atk.RelationSet,
    f_get_role: ?*const fn (p_accessible: *atk.Object) callconv(.c) atk.Role,
    f_get_layer: ?*const fn (p_accessible: *atk.Object) callconv(.c) atk.Layer,
    f_get_mdi_zorder: ?*const fn (p_accessible: *atk.Object) callconv(.c) c_int,
    f_ref_state_set: ?*const fn (p_accessible: *atk.Object) callconv(.c) *atk.StateSet,
    f_set_name: ?*const fn (p_accessible: *atk.Object, p_name: [*:0]const u8) callconv(.c) void,
    f_set_description: ?*const fn (p_accessible: *atk.Object, p_description: [*:0]const u8) callconv(.c) void,
    f_set_parent: ?*const fn (p_accessible: *atk.Object, p_parent: *atk.Object) callconv(.c) void,
    f_set_role: ?*const fn (p_accessible: *atk.Object, p_role: atk.Role) callconv(.c) void,
    /// specifies a function to be called
    ///   when a property changes value. This virtual function is
    ///   deprecated since 2.12 and it should not be overriden. Connect
    ///   directly to property-change or notify signal instead.
    f_connect_property_change_handler: ?*const fn (p_accessible: *atk.Object, p_handler: *atk.PropertyChangeHandler) callconv(.c) c_uint,
    /// removes a property changed handler
    ///   as returned by `connect_property_change_handler`. This virtual
    ///   function is deprecated sice 2.12 and it should not be overriden.
    f_remove_property_change_handler: ?*const fn (p_accessible: *atk.Object, p_handler_id: c_uint) callconv(.c) void,
    f_initialize: ?*const fn (p_accessible: *atk.Object, p_data: ?*anyopaque) callconv(.c) void,
    f_children_changed: ?*const fn (p_accessible: *atk.Object, p_change_index: c_uint, p_changed_child: ?*anyopaque) callconv(.c) void,
    /// The signal handler which is executed when there is a
    ///   focus event for an object. This virtual function is deprecated
    ///   since 2.9.4 and it should not be overriden. Use
    ///   the `atk.Object.signals.state`-change "focused" signal instead.
    f_focus_event: ?*const fn (p_accessible: *atk.Object, p_focus_in: c_int) callconv(.c) void,
    f_property_change: ?*const fn (p_accessible: *atk.Object, p_values: *atk.PropertyValues) callconv(.c) void,
    f_state_change: ?*const fn (p_accessible: *atk.Object, p_name: [*:0]const u8, p_state_set: c_int) callconv(.c) void,
    f_visible_data_changed: ?*const fn (p_accessible: *atk.Object) callconv(.c) void,
    f_active_descendant_changed: ?*const fn (p_accessible: *atk.Object, p_child: ?*anyopaque) callconv(.c) void,
    f_get_attributes: ?*const fn (p_accessible: *atk.Object) callconv(.c) *atk.AttributeSet,
    f_get_object_locale: ?*const fn (p_accessible: *atk.Object) callconv(.c) [*:0]const u8,
    f_pad1: ?atk.Function,

    pub fn as(p_instance: *ObjectClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ObjectFactoryClass = extern struct {
    pub const Instance = atk.ObjectFactory;

    f_parent_class: gobject.ObjectClass,
    f_create_accessible: ?*const fn (p_obj: *gobject.Object) callconv(.c) *atk.Object,
    f_invalidate: ?*const fn (p_factory: *atk.ObjectFactory) callconv(.c) void,
    f_get_accessible_type: ?*const fn () callconv(.c) usize,
    f_pad1: ?atk.Function,
    f_pad2: ?atk.Function,

    pub fn as(p_instance: *ObjectFactoryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PlugClass = extern struct {
    pub const Instance = atk.Plug;

    f_parent_class: atk.ObjectClass,
    f_get_object_id: ?*const fn (p_obj: *atk.Plug) callconv(.c) [*:0]u8,

    pub fn as(p_instance: *PlugClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Note: `old_value` field of `atk.PropertyValues` will not contain a
/// valid value. This is a field defined with the purpose of contain
/// the previous value of the property, but is not used anymore.
pub const PropertyValues = extern struct {
    /// The name of the ATK property which has changed.
    f_property_name: ?[*:0]const u8,
    /// NULL. This field is not used anymore.
    f_old_value: gobject.Value,
    /// The new value of the named property.
    f_new_value: gobject.Value,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A given range or subrange, to be used with `atk.Value`
///
/// `atk.Range` are used on `atk.Value`, in order to represent the full
/// range of a given component (for example an slider or a range
/// control), or to define each individual subrange this full range is
/// splitted if available. See `atk.Value` documentation for further
/// details.
pub const Range = opaque {
    /// Creates a new `atk.Range`.
    extern fn atk_range_new(p_lower_limit: f64, p_upper_limit: f64, p_description: [*:0]const u8) *atk.Range;
    pub const new = atk_range_new;

    /// Returns a new `atk.Range` that is a exact copy of `src`
    extern fn atk_range_copy(p_src: *Range) *atk.Range;
    pub const copy = atk_range_copy;

    /// Free `range`
    extern fn atk_range_free(p_range: *Range) void;
    pub const free = atk_range_free;

    /// Returns the human readable description of `range`
    extern fn atk_range_get_description(p_range: *Range) [*:0]const u8;
    pub const getDescription = atk_range_get_description;

    /// Returns the lower limit of `range`
    extern fn atk_range_get_lower_limit(p_range: *Range) f64;
    pub const getLowerLimit = atk_range_get_lower_limit;

    /// Returns the upper limit of `range`
    extern fn atk_range_get_upper_limit(p_range: *Range) f64;
    pub const getUpperLimit = atk_range_get_upper_limit;

    extern fn atk_range_get_type() usize;
    pub const getGObjectType = atk_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A data structure for holding a rectangle. Those coordinates are
/// relative to the component top-level parent.
pub const Rectangle = extern struct {
    /// X coordinate of the left side of the rectangle.
    f_x: c_int,
    /// Y coordinate of the top side of the rectangle.
    f_y: c_int,
    /// width of the rectangle.
    f_width: c_int,
    /// height of the rectangle.
    f_height: c_int,

    extern fn atk_rectangle_get_type() usize;
    pub const getGObjectType = atk_rectangle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RegistryClass = extern struct {
    pub const Instance = atk.Registry;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *RegistryClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RelationClass = extern struct {
    pub const Instance = atk.Relation;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *RelationClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const RelationSetClass = extern struct {
    pub const Instance = atk.RelationSet;

    f_parent: gobject.ObjectClass,
    f_pad1: ?atk.Function,
    f_pad2: ?atk.Function,

    pub fn as(p_instance: *RelationSetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SelectionIface = extern struct {
    pub const Instance = atk.Selection;

    f_parent: gobject.TypeInterface,
    f_add_selection: ?*const fn (p_selection: *atk.Selection, p_i: c_int) callconv(.c) c_int,
    f_clear_selection: ?*const fn (p_selection: *atk.Selection) callconv(.c) c_int,
    f_ref_selection: ?*const fn (p_selection: *atk.Selection, p_i: c_int) callconv(.c) ?*atk.Object,
    f_get_selection_count: ?*const fn (p_selection: *atk.Selection) callconv(.c) c_int,
    f_is_child_selected: ?*const fn (p_selection: *atk.Selection, p_i: c_int) callconv(.c) c_int,
    f_remove_selection: ?*const fn (p_selection: *atk.Selection, p_i: c_int) callconv(.c) c_int,
    f_select_all_selection: ?*const fn (p_selection: *atk.Selection) callconv(.c) c_int,
    f_selection_changed: ?*const fn (p_selection: *atk.Selection) callconv(.c) void,

    pub fn as(p_instance: *SelectionIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const SocketClass = extern struct {
    pub const Instance = atk.Socket;

    f_parent_class: atk.ObjectClass,
    f_embed: ?*const fn (p_obj: *atk.Socket, p_plug_id: [*:0]const u8) callconv(.c) void,

    pub fn as(p_instance: *SocketClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StateSetClass = extern struct {
    pub const Instance = atk.StateSet;

    f_parent: gobject.ObjectClass,

    pub fn as(p_instance: *StateSetClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const StreamableContentIface = extern struct {
    pub const Instance = atk.StreamableContent;

    f_parent: gobject.TypeInterface,
    f_get_n_mime_types: ?*const fn (p_streamable: *atk.StreamableContent) callconv(.c) c_int,
    f_get_mime_type: ?*const fn (p_streamable: *atk.StreamableContent, p_i: c_int) callconv(.c) [*:0]const u8,
    f_get_stream: ?*const fn (p_streamable: *atk.StreamableContent, p_mime_type: [*:0]const u8) callconv(.c) *glib.IOChannel,
    f_get_uri: ?*const fn (p_streamable: *atk.StreamableContent, p_mime_type: [*:0]const u8) callconv(.c) ?[*:0]const u8,
    f_pad1: ?atk.Function,
    f_pad2: ?atk.Function,
    f_pad3: ?atk.Function,

    pub fn as(p_instance: *StreamableContentIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// AtkTableCell is an interface for cells inside an `atk.Table`.
pub const TableCellIface = extern struct {
    pub const Instance = atk.TableCell;

    f_parent: gobject.TypeInterface,
    /// virtual function that returns the number of
    ///   columns occupied by this cell accessible
    f_get_column_span: ?*const fn (p_cell: *atk.TableCell) callconv(.c) c_int,
    /// virtual function that returns the column
    ///   headers as an array of cell accessibles
    f_get_column_header_cells: ?*const fn (p_cell: *atk.TableCell) callconv(.c) *glib.PtrArray,
    /// virtual function that retrieves the tabular position
    ///   of this cell
    f_get_position: ?*const fn (p_cell: *atk.TableCell, p_row: *c_int, p_column: *c_int) callconv(.c) c_int,
    /// virtual function that returns the number of rows
    ///   occupied by this cell
    f_get_row_span: ?*const fn (p_cell: *atk.TableCell) callconv(.c) c_int,
    /// virtual function that returns the row
    ///   headers as an array of cell accessibles
    f_get_row_header_cells: ?*const fn (p_cell: *atk.TableCell) callconv(.c) *glib.PtrArray,
    /// virtual function that get the row an column
    ///   indexes and span of this cell
    f_get_row_column_span: ?*const fn (p_cell: *atk.TableCell, p_row: *c_int, p_column: *c_int, p_row_span: *c_int, p_column_span: *c_int) callconv(.c) c_int,
    /// virtual function that returns a reference to the
    ///   accessible of the containing table
    f_get_table: ?*const fn (p_cell: *atk.TableCell) callconv(.c) *atk.Object,

    pub fn as(p_instance: *TableCellIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TableIface = extern struct {
    pub const Instance = atk.Table;

    f_parent: gobject.TypeInterface,
    f_ref_at: ?*const fn (p_table: *atk.Table, p_row: c_int, p_column: c_int) callconv(.c) *atk.Object,
    f_get_index_at: ?*const fn (p_table: *atk.Table, p_row: c_int, p_column: c_int) callconv(.c) c_int,
    f_get_column_at_index: ?*const fn (p_table: *atk.Table, p_index_: c_int) callconv(.c) c_int,
    f_get_row_at_index: ?*const fn (p_table: *atk.Table, p_index_: c_int) callconv(.c) c_int,
    f_get_n_columns: ?*const fn (p_table: *atk.Table) callconv(.c) c_int,
    f_get_n_rows: ?*const fn (p_table: *atk.Table) callconv(.c) c_int,
    f_get_column_extent_at: ?*const fn (p_table: *atk.Table, p_row: c_int, p_column: c_int) callconv(.c) c_int,
    f_get_row_extent_at: ?*const fn (p_table: *atk.Table, p_row: c_int, p_column: c_int) callconv(.c) c_int,
    f_get_caption: ?*const fn (p_table: *atk.Table) callconv(.c) ?*atk.Object,
    f_get_column_description: ?*const fn (p_table: *atk.Table, p_column: c_int) callconv(.c) [*:0]const u8,
    f_get_column_header: ?*const fn (p_table: *atk.Table, p_column: c_int) callconv(.c) ?*atk.Object,
    f_get_row_description: ?*const fn (p_table: *atk.Table, p_row: c_int) callconv(.c) ?[*:0]const u8,
    f_get_row_header: ?*const fn (p_table: *atk.Table, p_row: c_int) callconv(.c) ?*atk.Object,
    f_get_summary: ?*const fn (p_table: *atk.Table) callconv(.c) *atk.Object,
    f_set_caption: ?*const fn (p_table: *atk.Table, p_caption: *atk.Object) callconv(.c) void,
    f_set_column_description: ?*const fn (p_table: *atk.Table, p_column: c_int, p_description: [*:0]const u8) callconv(.c) void,
    f_set_column_header: ?*const fn (p_table: *atk.Table, p_column: c_int, p_header: *atk.Object) callconv(.c) void,
    f_set_row_description: ?*const fn (p_table: *atk.Table, p_row: c_int, p_description: [*:0]const u8) callconv(.c) void,
    f_set_row_header: ?*const fn (p_table: *atk.Table, p_row: c_int, p_header: *atk.Object) callconv(.c) void,
    f_set_summary: ?*const fn (p_table: *atk.Table, p_accessible: *atk.Object) callconv(.c) void,
    f_get_selected_columns: ?*const fn (p_table: *atk.Table, p_selected: **c_int) callconv(.c) c_int,
    f_get_selected_rows: ?*const fn (p_table: *atk.Table, p_selected: **c_int) callconv(.c) c_int,
    f_is_column_selected: ?*const fn (p_table: *atk.Table, p_column: c_int) callconv(.c) c_int,
    f_is_row_selected: ?*const fn (p_table: *atk.Table, p_row: c_int) callconv(.c) c_int,
    f_is_selected: ?*const fn (p_table: *atk.Table, p_row: c_int, p_column: c_int) callconv(.c) c_int,
    f_add_row_selection: ?*const fn (p_table: *atk.Table, p_row: c_int) callconv(.c) c_int,
    f_remove_row_selection: ?*const fn (p_table: *atk.Table, p_row: c_int) callconv(.c) c_int,
    f_add_column_selection: ?*const fn (p_table: *atk.Table, p_column: c_int) callconv(.c) c_int,
    f_remove_column_selection: ?*const fn (p_table: *atk.Table, p_column: c_int) callconv(.c) c_int,
    f_row_inserted: ?*const fn (p_table: *atk.Table, p_row: c_int, p_num_inserted: c_int) callconv(.c) void,
    f_column_inserted: ?*const fn (p_table: *atk.Table, p_column: c_int, p_num_inserted: c_int) callconv(.c) void,
    f_row_deleted: ?*const fn (p_table: *atk.Table, p_row: c_int, p_num_deleted: c_int) callconv(.c) void,
    f_column_deleted: ?*const fn (p_table: *atk.Table, p_column: c_int, p_num_deleted: c_int) callconv(.c) void,
    f_row_reordered: ?*const fn (p_table: *atk.Table) callconv(.c) void,
    f_column_reordered: ?*const fn (p_table: *atk.Table) callconv(.c) void,
    f_model_changed: ?*const fn (p_table: *atk.Table) callconv(.c) void,

    pub fn as(p_instance: *TableIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const TextIface = extern struct {
    pub const Instance = atk.Text;

    f_parent: gobject.TypeInterface,
    f_get_text: ?*const fn (p_text: *atk.Text, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) [*:0]u8,
    /// Gets specified text. This virtual function
    ///   is deprecated and it should not be overridden.
    f_get_text_after_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8,
    /// Gets specified text. This virtual function
    ///   is deprecated and it should not be overridden.
    f_get_text_at_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8,
    f_get_character_at_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int) callconv(.c) u32,
    /// Gets specified text. This virtual function
    ///   is deprecated and it should not be overridden.
    f_get_text_before_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_boundary_type: atk.TextBoundary, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8,
    f_get_caret_offset: ?*const fn (p_text: *atk.Text) callconv(.c) c_int,
    f_get_run_attributes: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) *atk.AttributeSet,
    f_get_default_attributes: ?*const fn (p_text: *atk.Text) callconv(.c) *atk.AttributeSet,
    f_get_character_extents: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_x: ?*c_int, p_y: ?*c_int, p_width: ?*c_int, p_height: ?*c_int, p_coords: atk.CoordType) callconv(.c) void,
    f_get_character_count: ?*const fn (p_text: *atk.Text) callconv(.c) c_int,
    f_get_offset_at_point: ?*const fn (p_text: *atk.Text, p_x: c_int, p_y: c_int, p_coords: atk.CoordType) callconv(.c) c_int,
    f_get_n_selections: ?*const fn (p_text: *atk.Text) callconv(.c) c_int,
    f_get_selection: ?*const fn (p_text: *atk.Text, p_selection_num: c_int, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) [*:0]u8,
    f_add_selection: ?*const fn (p_text: *atk.Text, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int,
    f_remove_selection: ?*const fn (p_text: *atk.Text, p_selection_num: c_int) callconv(.c) c_int,
    f_set_selection: ?*const fn (p_text: *atk.Text, p_selection_num: c_int, p_start_offset: c_int, p_end_offset: c_int) callconv(.c) c_int,
    f_set_caret_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int) callconv(.c) c_int,
    /// the signal handler which is executed when there is a
    ///   text change. This virtual function is deprecated sice 2.9.4 and
    ///   it should not be overriden.
    f_text_changed: ?*const fn (p_text: *atk.Text, p_position: c_int, p_length: c_int) callconv(.c) void,
    f_text_caret_moved: ?*const fn (p_text: *atk.Text, p_location: c_int) callconv(.c) void,
    f_text_selection_changed: ?*const fn (p_text: *atk.Text) callconv(.c) void,
    f_text_attributes_changed: ?*const fn (p_text: *atk.Text) callconv(.c) void,
    f_get_range_extents: ?*const fn (p_text: *atk.Text, p_start_offset: c_int, p_end_offset: c_int, p_coord_type: atk.CoordType, p_rect: *atk.TextRectangle) callconv(.c) void,
    f_get_bounded_ranges: ?*const fn (p_text: *atk.Text, p_rect: *atk.TextRectangle, p_coord_type: atk.CoordType, p_x_clip_type: atk.TextClipType, p_y_clip_type: atk.TextClipType) callconv(.c) [*]*atk.TextRange,
    /// Gets a portion of the text exposed through
    ///   an AtkText according to a given offset and a specific
    ///   granularity, along with the start and end offsets defining the
    ///   boundaries of such a portion of text.
    f_get_string_at_offset: ?*const fn (p_text: *atk.Text, p_offset: c_int, p_granularity: atk.TextGranularity, p_start_offset: *c_int, p_end_offset: *c_int) callconv(.c) ?[*:0]u8,
    f_scroll_substring_to: ?*const fn (p_text: *atk.Text, p_start_offset: c_int, p_end_offset: c_int, p_type: atk.ScrollType) callconv(.c) c_int,
    f_scroll_substring_to_point: ?*const fn (p_text: *atk.Text, p_start_offset: c_int, p_end_offset: c_int, p_coords: atk.CoordType, p_x: c_int, p_y: c_int) callconv(.c) c_int,

    pub fn as(p_instance: *TextIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure used to describe a text range.
pub const TextRange = extern struct {
    /// A rectangle giving the bounds of the text range
    f_bounds: atk.TextRectangle,
    /// The start offset of a AtkTextRange
    f_start_offset: c_int,
    /// The end offset of a AtkTextRange
    f_end_offset: c_int,
    /// The text in the text range
    f_content: ?[*:0]u8,

    extern fn atk_text_range_get_type() usize;
    pub const getGObjectType = atk_text_range_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// A structure used to store a rectangle used by AtkText.
pub const TextRectangle = extern struct {
    /// The horizontal coordinate of a rectangle
    f_x: c_int,
    /// The vertical coordinate of a rectangle
    f_y: c_int,
    /// The width of a rectangle
    f_width: c_int,
    /// The height of a rectangle
    f_height: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// This structure represents a single  text selection within a document. This
/// selection is defined by two points in the content, where each one is defined
/// by an AtkObject supporting the AtkText interface and a character offset
/// relative to it.
///
/// The end object must appear after the start object in the accessibility tree,
/// i.e. the end object must be reachable from the start object by navigating
/// forward (next, first child etc).
///
/// This struct also contains a `start_is_active` boolean, to communicate if the
/// start of the selection is the active point or not.
///
/// The active point corresponds to the user's focus or point of interest. The
/// user moves the active point to expand or collapse the range. The anchor
/// point is the other point of the range and typically remains constant. In
/// most cases, anchor is the start of the range and active is the end. However,
/// when selecting backwards (e.g. pressing shift+left arrow in a text field),
/// the start of the range is the active point, as the user moves this to
/// manipulate the selection.
pub const TextSelection = extern struct {
    /// the AtkText containing the start of the selection.
    f_start_object: ?*atk.Object,
    /// the text offset of the beginning of the selection within
    ///                `start_object`.
    f_start_offset: c_int,
    /// the AtkText containing the end of the selection.
    f_end_object: ?*atk.Object,
    /// the text offset of the end of the selection within `end_object`.
    f_end_offset: c_int,
    /// a gboolean indicating whether the start of the selection
    ///                  is the active point.
    f_start_is_active: c_int,

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const UtilClass = extern struct {
    pub const Instance = atk.Util;

    f_parent: gobject.ObjectClass,
    /// adds the specified function to the list
    ///  of functions to be called when an ATK event occurs. ATK
    ///  implementors are discouraged from reimplementing this method.
    f_add_global_event_listener: ?*const fn (p_listener: gobject.SignalEmissionHook, p_event_type: [*:0]const u8) callconv(.c) c_uint,
    /// removes the specified function to
    ///  the list of functions to be called when an ATK event occurs. ATK
    ///  implementors are discouraged from reimplementing this method.
    f_remove_global_event_listener: ?*const fn (p_listener_id: c_uint) callconv(.c) void,
    /// adds the specified function to the list of
    ///  functions to be called when a key event occurs.
    f_add_key_event_listener: ?*const fn (p_listener: atk.KeySnoopFunc, p_data: ?*anyopaque) callconv(.c) c_uint,
    /// remove the specified function to the
    ///  list of functions to be called when a key event occurs.
    f_remove_key_event_listener: ?*const fn (p_listener_id: c_uint) callconv(.c) void,
    /// gets the root accessible container for the current
    ///  application.
    f_get_root: ?*const fn () callconv(.c) *atk.Object,
    /// gets name string for the GUI toolkit
    ///  implementing ATK for this application.
    f_get_toolkit_name: ?*const fn () callconv(.c) [*:0]const u8,
    /// gets version string for the GUI toolkit
    ///  implementing ATK for this application.
    f_get_toolkit_version: ?*const fn () callconv(.c) [*:0]const u8,

    pub fn as(p_instance: *UtilClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const ValueIface = extern struct {
    pub const Instance = atk.Value;

    f_parent: gobject.TypeInterface,
    /// This virtual function is deprecated since 2.12
    ///  and it should not be overriden.
    f_get_current_value: ?*const fn (p_obj: *atk.Value, p_value: *gobject.Value) callconv(.c) void,
    /// This virtual function is deprecated since 2.12
    ///  and it should not be overriden.
    f_get_maximum_value: ?*const fn (p_obj: *atk.Value, p_value: *gobject.Value) callconv(.c) void,
    /// This virtual function is deprecated since 2.12
    ///  and it should not be overriden.
    f_get_minimum_value: ?*const fn (p_obj: *atk.Value, p_value: *gobject.Value) callconv(.c) void,
    /// This virtual function is deprecated since 2.12
    ///  and it should not be overriden.
    f_set_current_value: ?*const fn (p_obj: *atk.Value, p_value: *const gobject.Value) callconv(.c) c_int,
    /// This virtual function is deprecated since
    ///  2.12 and it should not be overriden.
    f_get_minimum_increment: ?*const fn (p_obj: *atk.Value, p_value: *gobject.Value) callconv(.c) void,
    /// gets the current value and the human readable
    /// text alternative (if available) of this object. Since 2.12.
    f_get_value_and_text: ?*const fn (p_obj: *atk.Value, p_value: *f64, p_text: ?*[*:0]u8) callconv(.c) void,
    /// gets the range that defines the minimum and maximum
    ///  value of this object. Returns NULL if there is no range
    ///  defined. Since 2.12.
    f_get_range: ?*const fn (p_obj: *atk.Value) callconv(.c) ?*atk.Range,
    /// gets the minimum increment by which the value of
    ///  this object may be changed. If zero it is undefined. Since 2.12.
    f_get_increment: ?*const fn (p_obj: *atk.Value) callconv(.c) f64,
    /// returns a list of different subranges, and their
    ///  description (if available) of this object. Returns NULL if there
    ///  is not subranges defined. Since 2.12.
    f_get_sub_ranges: ?*const fn (p_obj: *atk.Value) callconv(.c) *glib.SList,
    /// sets the value of this object. Since 2.12.
    f_set_value: ?*const fn (p_obj: *atk.Value, p_new_value: f64) callconv(.c) void,

    pub fn as(p_instance: *ValueIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const WindowIface = extern struct {
    pub const Instance = atk.Window;

    f_parent: gobject.TypeInterface,

    pub fn as(p_instance: *WindowIface, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies how xy coordinates are to be interpreted. Used by functions such
/// as `atk.Component.getPosition` and `atk.Text.getCharacterExtents`
pub const CoordType = enum(c_int) {
    screen = 0,
    window = 1,
    parent = 2,
    _,

    extern fn atk_coord_type_get_type() usize;
    pub const getGObjectType = atk_coord_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies the type of a keyboard evemt.
pub const KeyEventType = enum(c_int) {
    press = 0,
    release = 1,
    last_defined = 2,
    _,

    extern fn atk_key_event_type_get_type() usize;
    pub const getGObjectType = atk_key_event_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the layer of a component
///
/// These enumerated "layer values" are used when determining which UI
/// rendering layer a component is drawn into, which can help in making
/// determinations of when components occlude one another.
pub const Layer = enum(c_int) {
    invalid = 0,
    background = 1,
    canvas = 2,
    widget = 3,
    mdi = 4,
    popup = 5,
    overlay = 6,
    window = 7,
    _,

    extern fn atk_layer_get_type() usize;
    pub const getGObjectType = atk_layer_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Enumeration used to indicate a type of live region and how assertive it
/// should be in terms of speaking notifications. Currently, this is only used
/// for "notification" events, but it may be used for additional purposes
/// in the future.
pub const Live = enum(c_int) {
    none = 0,
    polite = 1,
    assertive = 2,
    _,

    extern fn atk_live_get_type() usize;
    pub const getGObjectType = atk_live_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the type of the relation
pub const RelationType = enum(c_int) {
    null = 0,
    controlled_by = 1,
    controller_for = 2,
    label_for = 3,
    labelled_by = 4,
    member_of = 5,
    node_child_of = 6,
    flows_to = 7,
    flows_from = 8,
    subwindow_of = 9,
    embeds = 10,
    embedded_by = 11,
    popup_for = 12,
    parent_window_of = 13,
    described_by = 14,
    description_for = 15,
    node_parent_of = 16,
    details = 17,
    details_for = 18,
    error_message = 19,
    error_for = 20,
    last_defined = 21,
    _,

    /// Get the `atk.RelationType` type corresponding to a relation name.
    extern fn atk_relation_type_for_name(p_name: [*:0]const u8) atk.RelationType;
    pub const forName = atk_relation_type_for_name;

    /// Gets the description string describing the `atk.RelationType` `type`.
    extern fn atk_relation_type_get_name(p_type: atk.RelationType) [*:0]const u8;
    pub const getName = atk_relation_type_get_name;

    /// Associate `name` with a new `atk.RelationType`
    extern fn atk_relation_type_register(p_name: [*:0]const u8) atk.RelationType;
    pub const register = atk_relation_type_register;

    extern fn atk_relation_type_get_type() usize;
    pub const getGObjectType = atk_relation_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the role of an object
///
/// These are the built-in enumerated roles that UI components can have
/// in ATK.  Other roles may be added at runtime, so an AtkRole >=
/// `ATK_ROLE_LAST_DEFINED` is not necessarily an error.
pub const Role = enum(c_int) {
    invalid = 0,
    accelerator_label = 1,
    alert = 2,
    animation = 3,
    arrow = 4,
    calendar = 5,
    canvas = 6,
    check_box = 7,
    check_menu_item = 8,
    color_chooser = 9,
    column_header = 10,
    combo_box = 11,
    date_editor = 12,
    desktop_icon = 13,
    desktop_frame = 14,
    dial = 15,
    dialog = 16,
    directory_pane = 17,
    drawing_area = 18,
    file_chooser = 19,
    filler = 20,
    font_chooser = 21,
    frame = 22,
    glass_pane = 23,
    html_container = 24,
    icon = 25,
    image = 26,
    internal_frame = 27,
    label = 28,
    layered_pane = 29,
    list = 30,
    list_item = 31,
    menu = 32,
    menu_bar = 33,
    menu_item = 34,
    option_pane = 35,
    page_tab = 36,
    page_tab_list = 37,
    panel = 38,
    password_text = 39,
    popup_menu = 40,
    progress_bar = 41,
    button = 42,
    radio_button = 43,
    radio_menu_item = 44,
    root_pane = 45,
    row_header = 46,
    scroll_bar = 47,
    scroll_pane = 48,
    separator = 49,
    slider = 50,
    split_pane = 51,
    spin_button = 52,
    statusbar = 53,
    table = 54,
    table_cell = 55,
    table_column_header = 56,
    table_row_header = 57,
    tear_off_menu_item = 58,
    terminal = 59,
    text = 60,
    toggle_button = 61,
    tool_bar = 62,
    tool_tip = 63,
    tree = 64,
    tree_table = 65,
    unknown = 66,
    viewport = 67,
    window = 68,
    header = 69,
    footer = 70,
    paragraph = 71,
    ruler = 72,
    application = 73,
    autocomplete = 74,
    edit_bar = 75,
    embedded = 76,
    entry = 77,
    chart = 78,
    caption = 79,
    document_frame = 80,
    heading = 81,
    page = 82,
    section = 83,
    redundant_object = 84,
    form = 85,
    link = 86,
    input_method_window = 87,
    table_row = 88,
    tree_item = 89,
    document_spreadsheet = 90,
    document_presentation = 91,
    document_text = 92,
    document_web = 93,
    document_email = 94,
    comment = 95,
    list_box = 96,
    grouping = 97,
    image_map = 98,
    notification = 99,
    info_bar = 100,
    level_bar = 101,
    title_bar = 102,
    block_quote = 103,
    audio = 104,
    video = 105,
    definition = 106,
    article = 107,
    landmark = 108,
    log = 109,
    marquee = 110,
    math = 111,
    rating = 112,
    timer = 113,
    description_list = 114,
    description_term = 115,
    description_value = 116,
    static = 117,
    math_fraction = 118,
    math_root = 119,
    subscript = 120,
    superscript = 121,
    footnote = 122,
    content_deletion = 123,
    content_insertion = 124,
    mark = 125,
    suggestion = 126,
    push_button_menu = 127,
    @"switch" = 128,
    last_defined = 129,
    _,

    pub const push_button = Role.button;
    /// Get the `atk.Role` type corresponding to a rolew name.
    extern fn atk_role_for_name(p_name: [*:0]const u8) atk.Role;
    pub const forName = atk_role_for_name;

    /// Gets the localized description string describing the `atk.Role` `role`.
    extern fn atk_role_get_localized_name(p_role: atk.Role) [*:0]const u8;
    pub const getLocalizedName = atk_role_get_localized_name;

    /// Gets the description string describing the `atk.Role` `role`.
    extern fn atk_role_get_name(p_role: atk.Role) [*:0]const u8;
    pub const getName = atk_role_get_name;

    /// Registers the role specified by `name`. `name` must be a meaningful
    /// name. So it should not be empty, or consisting on whitespaces.
    extern fn atk_role_register(p_name: [*:0]const u8) atk.Role;
    pub const register = atk_role_register;

    extern fn atk_role_get_type() usize;
    pub const getGObjectType = atk_role_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Specifies where an object should be placed on the screen when using scroll_to.
pub const ScrollType = enum(c_int) {
    top_left = 0,
    bottom_right = 1,
    top_edge = 2,
    bottom_edge = 3,
    left_edge = 4,
    right_edge = 5,
    anywhere = 6,
    _,

    extern fn atk_scroll_type_get_type() usize;
    pub const getGObjectType = atk_scroll_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// The possible types of states of an object
pub const StateType = enum(c_int) {
    invalid = 0,
    active = 1,
    armed = 2,
    busy = 3,
    checked = 4,
    defunct = 5,
    editable = 6,
    enabled = 7,
    expandable = 8,
    expanded = 9,
    focusable = 10,
    focused = 11,
    horizontal = 12,
    iconified = 13,
    modal = 14,
    multi_line = 15,
    multiselectable = 16,
    @"opaque" = 17,
    pressed = 18,
    resizable = 19,
    selectable = 20,
    selected = 21,
    sensitive = 22,
    showing = 23,
    single_line = 24,
    stale = 25,
    transient = 26,
    vertical = 27,
    visible = 28,
    manages_descendants = 29,
    indeterminate = 30,
    truncated = 31,
    required = 32,
    invalid_entry = 33,
    supports_autocompletion = 34,
    selectable_text = 35,
    default = 36,
    animated = 37,
    visited = 38,
    checkable = 39,
    has_popup = 40,
    has_tooltip = 41,
    read_only = 42,
    collapsed = 43,
    last_defined = 44,
    _,

    /// Gets the `atk.StateType` corresponding to the description string `name`.
    extern fn atk_state_type_for_name(p_name: [*:0]const u8) atk.StateType;
    pub const forName = atk_state_type_for_name;

    /// Gets the description string describing the `atk.StateType` `type`.
    extern fn atk_state_type_get_name(p_type: atk.StateType) [*:0]const u8;
    pub const getName = atk_state_type_get_name;

    /// Register a new object state.
    extern fn atk_state_type_register(p_name: [*:0]const u8) atk.StateType;
    pub const register = atk_state_type_register;

    extern fn atk_state_type_get_type() usize;
    pub const getGObjectType = atk_state_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the text attributes supported
pub const TextAttribute = enum(c_int) {
    invalid = 0,
    left_margin = 1,
    right_margin = 2,
    indent = 3,
    invisible = 4,
    editable = 5,
    pixels_above_lines = 6,
    pixels_below_lines = 7,
    pixels_inside_wrap = 8,
    bg_full_height = 9,
    rise = 10,
    underline = 11,
    strikethrough = 12,
    size = 13,
    scale = 14,
    weight = 15,
    language = 16,
    family_name = 17,
    bg_color = 18,
    fg_color = 19,
    bg_stipple = 20,
    fg_stipple = 21,
    wrap_mode = 22,
    direction = 23,
    justification = 24,
    stretch = 25,
    variant = 26,
    style = 27,
    text_position = 28,
    last_defined = 29,
    _,

    /// Get the `atk.TextAttribute` type corresponding to a text attribute name.
    extern fn atk_text_attribute_for_name(p_name: [*:0]const u8) atk.TextAttribute;
    pub const forName = atk_text_attribute_for_name;

    /// Gets the name corresponding to the `atk.TextAttribute`
    extern fn atk_text_attribute_get_name(p_attr: atk.TextAttribute) [*:0]const u8;
    pub const getName = atk_text_attribute_get_name;

    /// Gets the value for the index of the `atk.TextAttribute`
    extern fn atk_text_attribute_get_value(p_attr: atk.TextAttribute, p_index_: c_int) ?[*:0]const u8;
    pub const getValue = atk_text_attribute_get_value;

    /// Associate `name` with a new `atk.TextAttribute`
    extern fn atk_text_attribute_register(p_name: [*:0]const u8) atk.TextAttribute;
    pub const register = atk_text_attribute_register;

    extern fn atk_text_attribute_get_type() usize;
    pub const getGObjectType = atk_text_attribute_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text boundary types used for specifying boundaries for regions of text.
/// This enumeration is deprecated since 2.9.4 and should not be used. Use
/// AtkTextGranularity with `atk.Text.getStringAtOffset` instead.
pub const TextBoundary = enum(c_int) {
    char = 0,
    word_start = 1,
    word_end = 2,
    sentence_start = 3,
    sentence_end = 4,
    line_start = 5,
    line_end = 6,
    _,

    extern fn atk_text_boundary_get_type() usize;
    pub const getGObjectType = atk_text_boundary_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the type of clipping required.
pub const TextClipType = enum(c_int) {
    none = 0,
    min = 1,
    max = 2,
    both = 3,
    _,

    extern fn atk_text_clip_type_get_type() usize;
    pub const getGObjectType = atk_text_clip_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Text granularity types used for specifying the granularity of the region of
/// text we are interested in.
pub const TextGranularity = enum(c_int) {
    char = 0,
    word = 1,
    sentence = 2,
    line = 3,
    paragraph = 4,
    _,

    extern fn atk_text_granularity_get_type() usize;
    pub const getGObjectType = atk_text_granularity_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Default types for a given value. Those are defined in order to
/// easily get localized strings to describe a given value or a given
/// subrange, using `atk.valueTypeGetLocalizedName`.
pub const ValueType = enum(c_int) {
    very_weak = 0,
    weak = 1,
    acceptable = 2,
    strong = 3,
    very_strong = 4,
    very_low = 5,
    low = 6,
    medium = 7,
    high = 8,
    very_high = 9,
    very_bad = 10,
    bad = 11,
    good = 12,
    very_good = 13,
    best = 14,
    last_defined = 15,
    _,

    /// Gets the localized description string describing the `atk.ValueType` `value_type`.
    extern fn atk_value_type_get_localized_name(p_value_type: atk.ValueType) [*:0]const u8;
    pub const getLocalizedName = atk_value_type_get_localized_name;

    /// Gets the description string describing the `atk.ValueType` `value_type`.
    extern fn atk_value_type_get_name(p_value_type: atk.ValueType) [*:0]const u8;
    pub const getName = atk_value_type_get_name;

    extern fn atk_value_type_get_type() usize;
    pub const getGObjectType = atk_value_type_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Describes the type of link
pub const HyperlinkStateFlags = packed struct(c_uint) {
    @"inline": bool = false,
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

    pub const flags_inline: HyperlinkStateFlags = @bitCast(@as(c_uint, 1));
    extern fn atk_hyperlink_state_flags_get_type() usize;
    pub const getGObjectType = atk_hyperlink_state_flags_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Adds the specified function to the list of functions to be called
/// when an object receives focus.
extern fn atk_add_focus_tracker(p_focus_tracker: atk.EventListener) c_uint;
pub const addFocusTracker = atk_add_focus_tracker;

/// Adds the specified function to the list of functions to be called
/// when an ATK event of type event_type occurs.
///
/// The format of event_type is the following:
///  "ATK:&lt;atk_type&gt;:&lt;atk_event&gt;:&lt;atk_event_detail&gt;
///
/// Where "ATK" works as the namespace, &lt;atk_interface&gt; is the name of
/// the ATK type (interface or object), &lt;atk_event&gt; is the name of the
/// signal defined on that interface and &lt;atk_event_detail&gt; is the
/// gsignal detail of that signal. You can find more info about gsignal
/// details here:
/// http://developer.gnome.org/gobject/stable/gobject-Signals.html
///
/// The first three parameters are mandatory. The last one is optional.
///
/// For example:
///   ATK:AtkObject:state-change
///   ATK:AtkText:text-selection-changed
///   ATK:AtkText:text-insert:system
///
/// Toolkit implementor note: ATK provides a default implementation for
/// this virtual method. ATK implementors are discouraged from
/// reimplementing this method.
///
/// Toolkit implementor note: this method is not intended to be used by
/// ATK implementors but by ATK consumers.
///
/// ATK consumers note: as this method adds a listener for a given ATK
/// type, that type should be already registered on the GType system
/// before calling this method. A simple way to do that is creating an
/// instance of `atk.NoOpObject`. This class implements all ATK
/// interfaces, so creating the instance will register all ATK types as
/// a collateral effect.
extern fn atk_add_global_event_listener(p_listener: gobject.SignalEmissionHook, p_event_type: [*:0]const u8) c_uint;
pub const addGlobalEventListener = atk_add_global_event_listener;

/// Adds the specified function to the list of functions to be called
///        when a key event occurs.  The `data` element will be passed to the
///        `atk.KeySnoopFunc` (`listener`) as the `func_data` param, on notification.
extern fn atk_add_key_event_listener(p_listener: atk.KeySnoopFunc, p_data: ?*anyopaque) c_uint;
pub const addKeyEventListener = atk_add_key_event_listener;

/// Specifies the function to be called for focus tracker initialization.
/// This function should be called by an implementation of the
/// ATK interface if any specific work needs to be done to enable
/// focus tracking.
extern fn atk_focus_tracker_init(p_init: atk.EventListenerInit) void;
pub const focusTrackerInit = atk_focus_tracker_init;

/// Cause the focus tracker functions which have been specified to be
/// executed for the object.
extern fn atk_focus_tracker_notify(p_object: *atk.Object) void;
pub const focusTrackerNotify = atk_focus_tracker_notify;

/// Returns the binary age as passed to libtool when building the ATK
/// library the process is running against.
extern fn atk_get_binary_age() c_uint;
pub const getBinaryAge = atk_get_binary_age;

/// Gets a default implementation of the `atk.ObjectFactory`/type
/// registry.
/// Note: For most toolkit maintainers, this will be the correct
/// registry for registering new `atk.Object` factories. Following
/// a call to this function, maintainers may call `atk.Registry.setFactoryType`
/// to associate an `atk.ObjectFactory` subclass with the GType of objects
/// for whom accessibility information will be provided.
extern fn atk_get_default_registry() *atk.Registry;
pub const getDefaultRegistry = atk_get_default_registry;

/// Gets the currently focused object.
extern fn atk_get_focus_object() *atk.Object;
pub const getFocusObject = atk_get_focus_object;

/// Returns the interface age as passed to libtool when building the
/// ATK library the process is running against.
extern fn atk_get_interface_age() c_uint;
pub const getInterfaceAge = atk_get_interface_age;

/// Returns the major version number of the ATK library.  (e.g. in ATK
/// version 2.7.4 this is 2.)
///
/// This function is in the library, so it represents the ATK library
/// your code is running against. In contrast, the `ATK_MAJOR_VERSION`
/// macro represents the major version of the ATK headers you have
/// included when compiling your code.
extern fn atk_get_major_version() c_uint;
pub const getMajorVersion = atk_get_major_version;

/// Returns the micro version number of the ATK library.  (e.g. in ATK
/// version 2.7.4 this is 4.)
///
/// This function is in the library, so it represents the ATK library
/// your code is are running against. In contrast, the
/// `ATK_MICRO_VERSION` macro represents the micro version of the ATK
/// headers you have included when compiling your code.
extern fn atk_get_micro_version() c_uint;
pub const getMicroVersion = atk_get_micro_version;

/// Returns the minor version number of the ATK library.  (e.g. in ATK
/// version 2.7.4 this is 7.)
///
/// This function is in the library, so it represents the ATK library
/// your code is are running against. In contrast, the
/// `ATK_MINOR_VERSION` macro represents the minor version of the ATK
/// headers you have included when compiling your code.
extern fn atk_get_minor_version() c_uint;
pub const getMinorVersion = atk_get_minor_version;

/// Gets the root accessible container for the current application.
extern fn atk_get_root() *atk.Object;
pub const getRoot = atk_get_root;

/// Gets name string for the GUI toolkit implementing ATK for this application.
extern fn atk_get_toolkit_name() [*:0]const u8;
pub const getToolkitName = atk_get_toolkit_name;

/// Gets version string for the GUI toolkit implementing ATK for this application.
extern fn atk_get_toolkit_version() [*:0]const u8;
pub const getToolkitVersion = atk_get_toolkit_version;

/// Gets the current version for ATK.
extern fn atk_get_version() [*:0]const u8;
pub const getVersion = atk_get_version;

/// Removes the specified focus tracker from the list of functions
/// to be called when any object receives focus.
extern fn atk_remove_focus_tracker(p_tracker_id: c_uint) void;
pub const removeFocusTracker = atk_remove_focus_tracker;

/// `listener_id` is the value returned by `atk.addGlobalEventListener`
/// when you registered that event listener.
///
/// Toolkit implementor note: ATK provides a default implementation for
/// this virtual method. ATK implementors are discouraged from
/// reimplementing this method.
///
/// Toolkit implementor note: this method is not intended to be used by
/// ATK implementors but by ATK consumers.
///
/// Removes the specified event listener
extern fn atk_remove_global_event_listener(p_listener_id: c_uint) void;
pub const removeGlobalEventListener = atk_remove_global_event_listener;

/// `listener_id` is the value returned by `atk.addKeyEventListener`
/// when you registered that event listener.
///
/// Removes the specified event listener.
extern fn atk_remove_key_event_listener(p_listener_id: c_uint) void;
pub const removeKeyEventListener = atk_remove_key_event_listener;

/// A function which is called when an object emits a matching event,
/// as used in `atk.addFocusTracker`.
/// Currently the only events for which object-specific handlers are
/// supported are events of type "focus:".  Most clients of ATK will prefer to
/// attach signal handlers for the various ATK signals instead.
///
/// see `atk.addFocusTracker`
pub const EventListener = *const fn (p_obj: *atk.Object) callconv(.c) void;

/// An `atk.EventListenerInit` function is a special function that is
/// called in order to initialize the per-object event registration system
/// used by `atk.EventListener`, if any preparation is required.
///
/// see `atk.focusTrackerInit`
pub const EventListenerInit = *const fn () callconv(.c) void;

/// The type of callback function used for
/// `atk.Component.addFocusHandler` and
/// `atk.Component.removeFocusHandler`
pub const FocusHandler = *const fn (p_object: *atk.Object, p_focus_in: c_int) callconv(.c) void;

/// An AtkFunction is a function definition used for padding which has
/// been added to class and interface structures to allow for expansion
/// in the future.
pub const Function = *const fn (p_user_data: ?*anyopaque) callconv(.c) c_int;

/// An `atk.KeySnoopFunc` is a type of callback which is called whenever a key event occurs,
/// if registered via atk_add_key_event_listener.  It allows for pre-emptive
/// interception of key events via the return code as described below.
pub const KeySnoopFunc = *const fn (p_event: *atk.KeyEventStruct, p_user_data: ?*anyopaque) callconv(.c) c_int;

/// An AtkPropertyChangeHandler is a function which is executed when an
/// AtkObject's property changes value. It is specified in a call to
/// `atk.Object.connectPropertyChangeHandler`.
pub const PropertyChangeHandler = *const fn (p_obj: *atk.Object, p_vals: *atk.PropertyValues) callconv(.c) void;

/// Like `atk.getBinaryAge`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const BINARY_AGE = 25610;
/// Like `atk.getInterfaceAge`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const INTERFACE_AGE = 1;
/// Like `atk.getMajorVersion`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const MAJOR_VERSION = 2;
/// Like `atk.getMicroVersion`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const MICRO_VERSION = 0;
/// Like `atk.getMinorVersion`, but from the headers used at
/// application compile time, rather than from the library linked
/// against at application run time.
pub const MINOR_VERSION = 56;
/// A macro that should be defined by the user prior to including
/// the atk/atk.h header.
/// The definition should be one of the predefined ATK version
/// macros: `ATK_VERSION_2_12`, `ATK_VERSION_2_14`,...
///
/// This macro defines the earliest version of ATK that the package is
/// required to be able to compile against.
///
/// If the compiler is configured to warn about the use of deprecated
/// functions, then using functions that were deprecated in version
/// `ATK_VERSION_MIN_REQUIRED` or earlier will cause warnings (but
/// using functions deprecated in later releases will not).
pub const VERSION_MIN_REQUIRED = 2;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
