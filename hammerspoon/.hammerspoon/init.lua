local super = { "cmd", "alt", "ctrl", "shift" }
hs.loadSpoon("hs_select_window")

-- customize bindings to your preference
local SWbindings = {
	app_windows = { super, "t" },
}
spoon.hs_select_window:bindHotkeys(SWbindings)

local mapping = {
	a = "Messages",
	s = "WezTerm",
	d = "Visual Studio Code",
	f = "Brave Browser",
	g = "Obsidian",
	w = "Postman",
	r = "Mail",
	v = "Finder",
	x = "1Password",
}

for key, app in pairs(mapping) do
	hs.hotkey.bind(super, key, function()
		hs.application.launchOrFocus(app)
	end)
end
