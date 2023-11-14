local wezterm = require("wezterm")

local config = {}

-- Colorscheme
config.color_scheme = "Catppuccin Mocha"

-- Font size
config.font_size = 16

-- Tab bar stye
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- Window decorations
config.window_decorations = "RESIZE"

-- No confirmation on quit
config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font('JetBrains Mono', { weight = 'Regular', italic = false })

-- Padding
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- config.window_background_opacity = 0.85

return config
