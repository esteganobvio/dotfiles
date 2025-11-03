local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local sessionizer = wezterm.plugin.require("https://github.com/ElCapitanSponge/sessionizer.wezterm")
local config = wezterm.config_builder()
-- =>
config.default_prog = { "/bin/zsh", "-l" }
config.font = wezterm.font("{{ font_family }}")
config.font_size = 10
config.line_height = 1.0
config.color_scheme = "tokyonight"
config.window_background_opacity = 1
config.window_decorations = "TITLE|RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.animation_fps = 60
config.integrated_title_button_style = "Gnome"
config.integrated_title_buttons = { "Close" }
config.enable_wayland = true
-- config.front_end = "WebGpu"
-- config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	font = wezterm.font({ family = "{{ font_family }}" }),
	font_size = 10,
	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#1a1b26",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#1a1b26",
}

config.colors = {
	tab_bar = {
		background = "#1a1b26",
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#7aa2f7",
			-- The color of the text for the tab
			fg_color = "#16161e",
		},
		inactive_tab = {
			bg_color = "#292e42",
			fg_color = "#545c7e",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},
		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#292e42",
			fg_color = "#7aa2f7",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},
		new_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},
		new_tab_hover = {
			bg_color = "#1a1b26",
			fg_color = "#7aa2f7",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#16161e",
	},
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
}

smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	-- direction_keys = { "h", "j", "k", "l" },
	-- if you want to use separate direction keys for move vs. resize, you
	-- can also do this:
	direction_keys = {
		move = { "h", "j", "k", "l" },
		resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	},
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
})

local projects = {
	"~/evolve",
	"~/work",
	"~/proyectos",
}

sessionizer.set_projects(projects)
sessionizer.configure(config)

return config

-- vim: ts=2 sts=2 sw=2 et
