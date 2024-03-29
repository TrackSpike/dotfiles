local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

local function switchWorkspaces()
	wezterm.action_callback(function(window, pane)
		local workspaces = {}
		for _, name in ipairs(wezterm.mux.get_workspace_names()) do
			table.insert(workspaces, { id = name, label = name })
		end
		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("cancelled")
					else
						inner_window:perform_action(
							act.SwitchToWorkspace({
								name = label,
							}),
							inner_pane
						)
					end
				end),
				title = "Choose Workspace",
				choices = workspaces,
				fuzzy = true,
				fuzzy_description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Text = "Workspace: " },
				}),
			}),
			pane
		)
	end)
end

local function createWorkspace()
	act.PromptInputLine({
		description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = "Enter name for new workspace" },
		}),
		action = wezterm.action_callback(function(window, pane, line)
			-- line will be `nil` if they hit escape without entering anything
			-- An empty string if they just hit enter
			-- Or the actual line of text they wrote
			if line then
				window:perform_action(
					act.SwitchToWorkspace({
						name = line,
					}),
					pane
				)
			end
		end),
	})
end

function module.apply_to_config(config)
	config.keys = {
		-- natural editing
		{ mods = "OPT", key = "LeftArrow", action = act.SendKey({ mods = "ALT", key = "b" }) },
		{ mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
		{ mods = "CMD", key = "LeftArrow", action = act.SendKey({ mods = "CTRL", key = "a" }) },
		{ mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
		{ mods = "CMD", key = "Backspace", action = act.SendKey({ mods = "CTRL", key = "u" }) },

		-- move to panes
		{ mods = "CTRL", key = "h", action = act.ActivatePaneDirection("Left") },
		{ mods = "CTRL", key = "l", action = act.ActivatePaneDirection("Right") },
		{ mods = "CTRL", key = "j", action = act.ActivatePaneDirection("Down") },
		{ mods = "CTRL", key = "k", action = act.ActivatePaneDirection("Up") },

		-- workspaces
		{
			mods = "CMD",
			key = "x",
			action = switchWorkspaces(),
		},
		{
			mods = "CMD|SHIFT",
			key = "N",
			action = createWorkspace(),
		},
	}
end

return module
