local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = false;
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.automatically_reload_config = true
config.window_background_opacity = 1
-- config.window_background_image = "/home/leon/Pictures/leavesbg.jpg"
config.window_background_image_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 0.25,
}
config.font = wezterm.font("Hack Nerd Font")

return config
