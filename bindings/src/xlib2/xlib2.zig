pub const ext = @import("ext.zig");
const xlib = @This();

const std = @import("std");
const compat = @import("compat");
pub const Atom = c_ulong;

pub const Colormap = c_ulong;

pub const Cursor = c_ulong;

pub const Drawable = c_ulong;

pub const GC = *anyopaque;

pub const KeyCode = u8;

pub const KeySym = c_ulong;

pub const Picture = c_ulong;

pub const Time = c_ulong;

pub const VisualID = c_ulong;

pub const Window = c_ulong;

pub const XID = c_ulong;

pub const Pixmap = c_ulong;

pub const Display = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Screen = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Visual = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XConfigureEvent = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XImage = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XFontStruct = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XTrapezoid = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XVisualInfo = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XWindowAttributes = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const XEvent = opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

extern fn XOpenDisplay() void;
pub const openDisplay = XOpenDisplay;

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}
