local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.color_scheme = "nord"
	config.window_decorations = "RESIZE"
	config.enable_tab_bar = false
	config.font = wezterm.font("FiraCode Nerd Font")
	config.font_size = 15.0
end

return module
