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
	hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, key, function()
		hs.application.launchOrFocus(app)
	end)
end
