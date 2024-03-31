local wezterm = require("wezterm")
local module = {}

function module.getColorByKey(window, key)
	local current_scheme = wezterm.color.get_builtin_schemes()[window:effective_config().color_scheme]

	local key_to_color = {
		black = current_scheme.ansi[1],
		red = current_scheme.ansi[2],
		green = current_scheme.ansi[3],
		yellow = current_scheme.ansi[4],
		blue = current_scheme.ansi[5],
		magenta = current_scheme.ansi[6],
		cyan = current_scheme.ansi[7],
		white = current_scheme.ansi[8],
		black_bright = current_scheme.brights[1],
		red_bright = current_scheme.brights[2],
		green_bright = current_scheme.brights[3],
		yellow_bright = current_scheme.brights[4],
		blue_bright = current_scheme.brights[5],
		magenta_bright = current_scheme.brights[6],
		cyan_bright = current_scheme.brights[7],
		white_bright = current_scheme.brights[8],
	}

	return key_to_color[key]
end

return module
