-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.term = "xterm-256color"

config.front_end = "OpenGL"

config.initial_cols = 255
config.initial_rows = 78

config.quit_when_all_windows_are_closed = true
config.window_close_confirmation = 'NeverPrompt'

config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 120
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = 'EaseIn'
config.cursor_blink_ease_out = 'EaseOut'

config.keys = {
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentTab { confirm = false },
    },
}

--config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Apple Color Emoji" })
config.font_size = 18

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.window_decorations = "TITLE | RESIZE"
config.enable_scroll_bar = false
config.window_padding = {
    left = '10px',
    right = '10px',
    top = '10px',
    bottom = '0px',
}

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 5000

-- Tabs Config
config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font { family = 'SF Mono', weight = 'Bold' },

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 12.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#333333',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#333333',
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757',
    },
}

-- my coolnight colorscheme:
config.colors = {
    foreground = "#FFFFFF",
    background = "#1e1e1e",
    cursor_bg = "#FFFFFF",
    cursor_border = "#000000",
    cursor_fg = "#FFFFFF",
    selection_bg = "#7f7f7f",
    --selection_fg = "#CBE0F0",
    ansi = { "#181818", "#c55555", "#aac474", "#f4bf75", "#82b8c8", "#c28cb8", "#93d3c3", "#f8f8f8" },
    brights = { "#181818", "#c55555", "#aac474", "#f4bf75", "#82b8c8", "#c28cb8", "#93d3c3", "#f8f8f8" },
}
-- and finally, return the configuration to wezterm
return config
