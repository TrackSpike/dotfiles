local wezterm = require("wezterm")
local util = require("util")
local act = wezterm.action

local module = {}

local function count_unnamed_workspaces()
	local count = 0
	local prefix = "Unnamed Workspace"
	for _, name in ipairs(wezterm.mux.get_workspace_names()) do
		if string.sub(name, 1, string.len(prefix)) == prefix then
			count = count + 1
		end
	end
	return count
end

function module.rename_workspace()
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			act.PromptInputLine({
				description = "Enter new name for Workspace",
				action = wezterm.action_callback(function(inner_window, inner_pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
			pane
		)
	end)
end

function module.switch_workspace()
	return wezterm.action_callback(function(window, pane)
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

function module.createWorkspace()
	return wezterm.action_callback(function(window, pane)
		-- get_workspace_names
		local result = ""
		local handle = io.popen("/opt/homebrew/bin/zoxide query -l")
		if handle ~= nil then
			result = handle:read("*a")
			handle:close()
		end

		local dirs = {}
		table.insert(dirs, {
			id = nil,
			label = "Create New",
		})

		for dir in result:gmatch("[^\r\n]+") do
			local lastDir = dir:match("([^/]+)$")
			local label = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = util.getColorByKey(window, "blue") } },
				{ Text = lastDir .. " " },
				"ResetAttributes",
				{ Attribute = { Intensity = "Half" } },
				{ Foreground = { Color = util.getColorByKey(window, "white") } },
				{ Text = "(" .. dir .. ")" },
			})
			table.insert(dirs, { id = dir, label = label })
		end

		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("cancelled")
					elseif id == nil then
						inner_window:perform_action(
							act.SwitchToWorkspace({
								name = "Unnamed Workspace " .. count_unnamed_workspaces(),
								spawn = {
									cwd = wezterm.home_dir,
								},
							}),
							inner_pane
						)
					else
						inner_window:perform_action(
							act.SwitchToWorkspace({
								name = id:match("([^/]+)$"),
								spawn = {
									cwd = id,
								},
							}),
							inner_pane
						)
					end

					-- add to directory score
					os.execute("zoxide add " .. id)
				end),
				title = "Choose Workspace",
				choices = dirs,
				fuzzy = true,
				fuzzy_description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { Color = util.getColorByKey(window, "white") } },
					{ Text = "Workspace: " },
				}),
			}),
			pane
		)
	end)
end

return module
