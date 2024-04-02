local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.color_scheme = "nord"
	config.window_decorations = "RESIZE"
	config.hide_tab_bar_if_only_one_tab = true
	config.font = wezterm.font({ family = "FiraCode Nerd Font", harfbuzz_features = { "calt=1", "clig=0", "liga=0" } })

	config.font_size = 15.0
	config.background = {
		{
			source = {
				File = wezterm.home_dir .. "/.config/wezterm/nord-mountain-2.jpeg",
			},
			hsb = { brightness = 0.5 },
		},
	}
end

return module
