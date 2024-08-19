-- WezTerm config
-- R: v0.1.1; E: 2024/08/19

-- Setup
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Shell
config.default_prog = { 'powershell.exe' }

-- Appearance: misc.
config.color_scheme = 'iceberg-dark'
config.font = wezterm.font('Consolas 7NF')
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true

-- Appearance: OS specific
--config.window_background_opacity = 0
--config.win32_system_backdrop = 'Acrylic' -- TODO: test on win 11

-- Keys
config.keys = {
	{
		key = 'F11',
		action = wezterm.action.ToggleFullScreen
	}
}

-- Return config
return config
