local wezterm = require("wezterm")
local keybindings = require("keybindings")
local appearance = require("appearance")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local config = wezterm.config_builder()

appearance.apply_to_config(config)
keybindings.apply_to_config(config)

smart_splits.apply_to_config(config)

return config
