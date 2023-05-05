local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
	},
	extensions = { "toggleterm", "nvim-tree", "trouble" },
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1,
			},
		},
	},
})
