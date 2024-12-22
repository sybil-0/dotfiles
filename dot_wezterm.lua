local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.window_close_confirmation = "NeverPrompt"
config.warn_about_missing_glyphs = false

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "carbonfox"
-- config.color_scheme = "Oxocarbon Dark (Gogh)"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 13

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Spawn powershell on windows
if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "nu" }
end

config.keys = {
	{
		key = "w",
		mods = "SHIFT | CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "H",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "K", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "L",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
}

return config
