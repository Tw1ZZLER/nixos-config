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

	colors = {
		-- cursor_bg = "7aa2f7",
		-- cursor_border = "7aa2f7",
		-- background = "#1e1e2e",
	},

	enable_tab_bar = false,

	window_background_opacity = 0.95,
}

-- Finally, return the configuration to wezterm:
return config
