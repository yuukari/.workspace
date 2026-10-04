package.path = package.path .. ";" .. os.getenv("HOME") .. "/.local/share/hypr/plugins/split-monitor-workspaces/lua/?.lua"

local ok_smw, smw = pcall(require, "split-monitor-workspaces")
if not ok_smw then
	error(
		"split-monitor-workspaces is not installed. "
			.. "Run setup.sh (or the plugin part of setup/3-post-install.sh) first, "
			.. "then start Hyprland. Error: "
			.. tostring(smw)
	)
end
hl.monitor({ output = "DP-1", mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "1920x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "3840x0", scale = 1 })

local terminal = "kitty"
local menu = "walker"
local tuiFileManager = "~/.config/hypr/scripts/apps/file-manager.sh"
local fileManager = "nautilus"
local taskManager = "~/.config/hypr/scripts/apps/task-manager.sh"
local scriptUtilsMenu = "kitty --class floating-terminal-utils-menu -o confirm_os_window_close=0 zsh -c ~/.config/hypr/scripts/utils/utils-menu.sh"
local scriptDevMenu = "kitty --class floating-terminal-dev-menu -o confirm_os_window_close=0 zsh -c ~/.config/hypr/scripts/dev/dev-menu.sh"
local scriptSessionMenu = "kitty -o confirm_os_window_close=0 zsh -c ~/.config/hypr/scripts/session-menu.sh"
local scriptLogout = "kitty -o confirm_os_window_close=0 zsh -c ~/.config/hypr/scripts/logout.sh"

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("elephant")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd("Telegram -startintray")
    hl.exec_cmd("~/.config/hypr/scripts/weather.sh init")
    hl.exec_cmd("~/.config/hypr/scripts/weather.sh &")
    hl.exec_cmd("~/.config/hypr/scripts/vdirsyncer.sh &")
end)

hl.env("XCURSOR_SIZE", "13")
hl.env("HYPRCURSOR_SIZE", "13")

-- Permission examples remain disabled during this migration.
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(ff6cbfff)", "rgba(9d055cff)" },
                angle = 45,
            },
            inactive_border = "rgba(662b4cff)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 2,
        active_opacity = 0.96,
        inactive_opacity = 0.96,
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 4,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    dwindle = {
        preserve_split = true,
        force_split = 2,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",
        accel_profile = "flat",
        force_no_accel = 0,
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

smw.setup({
    workspace_count = 10,
    keep_focused = false,
    enable_notifications = false,
    enable_persistent_workspaces = true,
    enable_wrapping = true,
})

hl.config({ animations = { enabled = true } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.device({ name = "logitech-usb-optical-mouse", sensitivity = -0.65 })
hl.device({ name = "elan0524:00-04f3:3215-touchpad", scroll_factor = 0.3, sensitivity = 0.22 })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(tuiFileManager))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(taskManager))
hl.bind("PRINT", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("[float; pin; stayfocused; size 500 230] " .. scriptLogout))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("[float; pin; stayfocused; size 410 285] " .. scriptSessionMenu))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(scriptUtilsMenu))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scriptDevMenu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + W", hl.dsp.window.close())

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

for i = 1, smw.get_amount_of_workspaces() do
    local key = tostring(i)
    if key == "10" then key = "0" end
    hl.bind(mainMod .. " + " .. key, smw.workspace(key))
    hl.bind(mainMod .. " + SHIFT + " .. key, smw.move_to_workspace(key))
end

hl.bind(mainMod .. " + ALT + right", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + ALT + left", smw.cycle_workspaces("prev"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +5"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -5"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +10"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"), { repeating = true, locked = true })

hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "fix-xwayland-drags", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })
hl.window_rule({ name = "jetbrains-popup-focus", match = { class = "^(jetbrains-.*)$", float = true }, stay_focused = true })
hl.window_rule({ name = "floating-terminals", match = { class = "^(floating-terminal.*)$" }, float = true, center = true })
hl.window_rule({ name = "floating-terminals_stayfocused", match = { class = "^floating-terminal-(utils-menu|dev-menu|pritunl-vpn|bt-wifi|sound)$" }, stay_focused = true })
hl.window_rule({ name = "floating-termunals_menus-size", match = { class = "^floating-terminal-(utils-menu|dev-menu|session-menu)$" }, size = { 410, 285 } })
hl.window_rule({ name = "floating-terminals_pritunl-vpn", match = { class = "^(floating-terminal-pritunl-vpn)$" }, size = { 648, 492 } })
hl.window_rule({ name = "floating-terminals_settings", match = { class = "^floating-terminal-(bt-wifi|sound)$" }, size = { 616, 798 } })
hl.window_rule({ name = "floating-terminals_packages", match = { class = "^(floating-terminal-packages)$" }, size = { 828, 602 } })
hl.window_rule({ name = "floating-terminals_weather", match = { class = "^(floating-terminal-weather)$" }, size = { 1186, 800 } })
hl.window_rule({ name = "floating-terminals_calendar", match = { class = "^(floating-terminal-calendar)$" }, size = { 768, 687 } })
hl.window_rule({ name = "floating-terminals_task-manager", match = { class = "^(floating-terminal-task-manager)$" }, size = { 1186, 890 } })
