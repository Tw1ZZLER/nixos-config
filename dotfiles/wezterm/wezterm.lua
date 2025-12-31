-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	-- Fish
	default_prog = { "fish", "-l" },

	font = wezterm.font("VictorMono Nerd Font"),
	font_size = 12,
	color_scheme = "catppuccin-frappe",

	enable_tab_bar = false,
	window_background_opacity = 0.85,
}

-- Finally, return the configuration to wezterm:
return config
