local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local sessionizer = wezterm.plugin.require("https://github.com/ElCapitanSponge/sessionizer.wezterm")
local agent_deck = wezterm.plugin.require("https://github.com/Eric162/wezterm-agent-deck")
local config = wezterm.config_builder()

agent_deck.apply_to_config(config, {
	update_interval = 500, -- ms between status checks

	colors = {
		working = "#A6E22E", -- green: agent processing
		waiting = "#E6DB74", -- yellow: needs input
		idle = "#66D9EF", -- blue: ready
		inactive = "#888888", -- gray: no agent
	},

	icons = {
		style = "unicode", -- or 'nerd', 'emoji'
		unicode = { working = "●", waiting = "◔", idle = "○", inactive = "◌" },
	},

	notifications = { enabled = true, on_waiting = true },
	right_status = { enabled = false },

	agents = {
		-- claudecode.nvim runs `claude` as a direct child of nvim, so detection
		-- relies on the child-process walk matching these patterns. Mirrors the
		-- plugin's built-in defaults; declared explicitly to keep intent visible.
		claude = {
			patterns = { "claude", "claude%-code" },
			executable_patterns = {
				"@anthropic%-ai/claude%-code",
				"/claude%-code/",
				"%.claude/bin/claude",
				"linuxbrew/bin/claude",
				"/claude$",
				"^claude$",
			},
			argv_patterns = {
				"@anthropic%-ai/claude%-code",
				"claude%-code",
				"%.claude/bin/claude",
				"^claude%s",
				"^claude$",
			},
			title_patterns = {
				"claude code",
				"claude",
			},
		},
		agentic = {
			patterns = { "agentic" },
			title_patterns = {
				"agentic",
				"Agentic Chat",
				"AgenticInput",
				"Mode: Agent",
				"Mode: chat",
			},
			status_patterns = {
				working = {
					"thinking",
					"processing",
					"generating",
					"analyzing",
					"searching",
					"running tool",
					"esc to interrupt",
				},
				waiting = {
					"allow once",
					"allow always",
					"reject",
					"permission",
					"pending",
					"%(y/n%)",
					"%(Y/n%)",
					"approve",
					"confirm",
				},
				-- Leave idle empty: Prompt winbar stays visible during permission
				-- prompts, and split-pane rows false-match bare "Prompt" patterns.
				idle = {},
			},
		},
	},
})

config.status_update_interval = 1000

wezterm.on("update-status", function(window, pane)
	for _, tab in ipairs(window:mux_window():tabs()) do
		for _, p in ipairs(tab:panes()) do
			agent_deck.update_pane(p)
		end
	end

	local counts = agent_deck.count_agents_by_status()
	local cfg = agent_deck.get_config()
	local items = {}

	if counts.waiting > 0 then
		table.insert(items, { Foreground = { Color = cfg.colors.waiting } })
		table.insert(items, { Text = counts.waiting .. " waiting " })
		table.insert(items, { Text = " | " })
	end
	if counts.working > 0 then
		table.insert(items, { Foreground = { Color = cfg.colors.working } })
		table.insert(items, { Text = counts.working .. " working " })
		table.insert(items, { Text = " | " })
	end

	table.insert(items, { Foreground = { Color = "#a9b1d6" } })
	table.insert(items, { Text = wezterm.strftime("%a %b %-d  %H:%M") .. "  " })

	window:set_right_status(wezterm.format(items))
end)

config.default_prog = { "/bin/zsh", "-l" }
config.font = wezterm.font("{{ font_family }}")
config.font_size = 9
config.line_height = 1.0
config.color_scheme = "tokyonight_night"
config.window_background_opacity = 1
config.window_decorations = "TITLE | RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.animation_fps = 60
-- config.integrated_title_button_style = "Gnome"
-- config.integrated_title_buttons = { "Close" }
config.enable_wayland = true
config.front_end = "WebGpu"
-- config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_frame = {
	font = wezterm.font({ family = "{{ font_family }}" }),
	font_size = 9,
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

config.leader = { key = "m", mods = "CTRL", timeout_milliseconds = 1000 }
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

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

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
		-- META+h/j/k/l matches Neovim <A-h>/<A-j>/<A-k>/<A-l> resize maps
		resize = { "h", "j", "k", "l" },
	},
	modifiers = {
		move = "CTRL",
		resize = "META",
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

-- vim: ts=3 sts=2 sw=2 et
