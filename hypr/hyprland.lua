-- Hyprland Configuration for Arch/EndeavourOS
-- ~/.config/hypr/hyprland.lua

local home = os.getenv("HOME") or "~"

--------------------------------------------------------------------------------
-- MONITORS
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------------------------------------------------------------------------
-- AUTOSTART
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i " .. home .. "/.config/hypr/wallpaper.jpg -m fit")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

--------------------------------------------------------------------------------
-- ENVIRONMENT VARIABLES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

--------------------------------------------------------------------------------
-- CORE CONFIGURATION (INPUT, APPEARANCE, LAYOUTS)
--------------------------------------------------------------------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    input = {
        kb_layout   = "gb",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(89b4faee)", "rgba(cba6f7ee)" }, angle = 45 },
            inactive_border = "rgba(45475aaa)",
        },
        layout        = "dwindle",
        allow_tearing = false,
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
        },
        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = "rgba(1a1a2eee)",
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

--------------------------------------------------------------------------------
-- ANIMATIONS & CURVES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

--------------------------------------------------------------------------------
-- WINDOW RULES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Always float these apps
hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "^pavucontrol$" },
    float = true,
})

hl.window_rule({
    name  = "float-nm-connection-editor",
    match = { class = "^nm-connection-editor$" },
    float = true,
})

hl.window_rule({
    name  = "float-pip",
    match = { title = "^Picture-in-Picture$" },
    float = true,
})

-- Dialog detection tagging
hl.window_rule({
    name  = "tag-dialog-fileops",
    match = { title = "(?i)(open file|open folder|save as|save file|select folder|select file|choose file|choose folder|export|import)" },
    tag   = "+dialog",
})

hl.window_rule({
    name  = "tag-dialog-settings",
    match = { title = "(?i)(preferences|settings|options|properties|configuration|config)" },
    tag   = "+dialog",
})

hl.window_rule({
    name  = "tag-dialog-info",
    match = { title = "(?i)(about|confirm|warning|error|alert|info|information|notice|message)" },
    tag   = "+dialog",
})

hl.window_rule({
    name  = "tag-dialog-auth",
    match = { title = "(?i)(authentication|password|login|sign in|credentials|unlock)" },
    tag   = "+dialog",
})

hl.window_rule({
    name  = "tag-dialog-class",
    match = { class = "(?i)(dialog|popup|preferences|settings)" },
    tag   = "+dialog",
})

-- Apply consistent behavior to all tagged dialogs
hl.window_rule({
    name   = "dialog-float",
    match  = { tag = "dialog" },
    float  = true,
    center = true,
    size   = "800 600",
})

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod  = "SUPER"
local terminal = "ghostty"
local menu     = "rofi -show drun"

-- Application launchers
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + X",      hl.dsp.exec_cmd("wlogout -l " .. home .. "/.config/wlogout/layout -s " .. home .. "/.config/wlogout/style.css"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces (1-4)
for i = 1, 4 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (minimize/scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse bindings (move/resize windows)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind("Print",         hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
