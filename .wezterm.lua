-- Wezterm config
-- R: v0.1.2; E: 2024/09/20

-- Setup
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Shell
config.default_prog = { 'powershell.exe' }

-- Window
config.initial_cols = 110;
config.initial_rows = 30;

-- Appearance: misc.
config.color_scheme = 'iceberg-dark'
config.font = wezterm.font('Consolas 7NF')
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = '0cell',
	right = '0cell',
	top = '0cell',
	bottom = '0cell'
}

-- Appearance: OS specific
config.window_background_opacity = 0.8
config.win32_system_backdrop = 'Acrylic' -- For Windows 11

-- Keys
config.keys = {
	{
		key = 'F11',
		action = wezterm.action.ToggleFullScreen
	}
}

-- Return config
return config
