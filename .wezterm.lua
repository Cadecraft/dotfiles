-- Wezterm config
-- R: v0.3.0; E: 2026/08/16

-- Setup
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Shell
if is_windows then
	config.default_prog = { 'powershell.exe' }
end

-- Window
config.initial_cols = 110;
config.initial_rows = 30;

-- For Linux/Hyprland
config.enable_wayland = false;

-- Appearance: misc.
config.color_scheme = 'iceberg-dark'
config.font = wezterm.font('Inconsolata Nerd Font')
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = '1cell',
	right = '1cell',
	top = '0.5cell',
	bottom = '0.5cell'
}

-- Appearance
config.window_background_opacity = 0.95
if is_windows then
	config.win32_system_backdrop = 'Acrylic' -- Windows 11
end

-- Misc
config.warn_about_missing_glyphs = false

-- Keys
config.keys = {
	{
		key = 'F11',
		action = wezterm.action.ToggleFullScreen
	}
}

return config
