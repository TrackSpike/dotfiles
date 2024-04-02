local wezterm = require("wezterm")
local workspace = require("workspace_utils")
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
	config.keys = {
		-- natural editing
		{ mods = "OPT", key = "LeftArrow", action = act.SendKey({ mods = "ALT", key = "b" }) },
		{ mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
		{ mods = "CMD", key = "LeftArrow", action = act.SendKey({ mods = "CTRL", key = "a" }) },
		{ mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
		{ mods = "CMD", key = "Backspace", action = act.SendKey({ mods = "CTRL", key = "u" }) },
		{
			mods = "CMD",
			key = "w",
			action = act.CloseCurrentPane({ confirm = true }),
		},

		-- move to panes
		{ mods = "CTRL", key = "h", action = act.ActivatePaneDirection("Left") },
		{ mods = "CTRL", key = "l", action = act.ActivatePaneDirection("Right") },
		{ mods = "CTRL", key = "j", action = act.ActivatePaneDirection("Down") },
		{ mods = "CTRL", key = "k", action = act.ActivatePaneDirection("Up") },

		-- workspaces
		{
			mods = "CMD",
			key = "l",
			action = workspace.switch_workspace(),
		},
		{
			mods = "CMD",
			key = "x",
			action = workspace.rename_workspace(),
		},
		{
			mods = "CMD",
			key = "o",
			action = workspace.createWorkspace(),
		},
	}
end

return module
