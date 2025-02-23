return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end
			--   פּ ﯟ   some other good icons
			local kind_icons = {
				Text = "",
				Method = "m",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}
			-- find more here: https://www.nerdfonts.com/cheat-sheet
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					--["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping(function(fallback)
						-- use the internal non-blocking call to check if cmp is visible
						if cmp.core.view:visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- Kind icons
						-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							nvim_lua = "[NVIM_LUA]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							rg = "[Rg]",
						})[entry.source.name]
						return vim_item
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{
						name = "rg",
						keyword_length = 3,
						option = {
							additional_arguments = "--max-depth 6 --one-file-system --ignore-file ~/.config/nvim/ignore.rg",
						},
					},
					{
						per_filetype = {
							codecompanion = { "codecompanion" },
						},
					},
				},
				performance = {
					fetching_timeout = 6000,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				-- documentation = {
				--   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				-- },
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-nvim-lua",
	},
	{
		"lukas-reineke/cmp-rg",
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip/loaders/from_vscode").load()
		end,
	},
	{
		"rafamadriz/friendly-snippets",
	},
	--{
	--	"milanglacier/minuet-ai.nvim",
	--	config = function()
	--		require("minuet").setup({
	--			-- Your configuration options here
	--			provider = "openai_fim_compatible",
	--			n_completions = 1, -- recommend for local model for resource saving
	--			-- I recommend beginning with a small context window size and incrementally
	--			-- expanding it, depending on your local computing power. A context window
	--			-- of 512, serves as an good starting point to estimate your computing
	--			-- power. Once you have a reliable estimate of your local computing power,
	--			-- you should adjust the context window to a larger value.
	--			-- context_window = 1024,
	--			context_window = 16384,
	--			provider_options = {
	--				openai_fim_compatible = {
	--					api_key = "TERM",
	--					name = "Ollama",
	--					stream = true,
	--					end_point = "http://localhost:11434/v1/completions",
	--					model = "qwen2.5-coder:1.5b",
	--					optional = {
	--						max_tokens = 256,
	--						top_p = 0.9,
	--					},
	--				},
	--			},
	--		})
	--	end,
	--},
	--{
	--	"tzachar/cmp-ai",
	--	dependencies = "nvim-lua/plenary.nvim",
	--	config = function()
	--		local cmp_ai = require("cmp_ai.config")

	--		cmp_ai:setup({
	--			max_lines = 100,
	--			provider = "Ollama",
	--			provider_options = {
	--				model = "qwen2.5-coder:7b",
	--				auto_unload = true, -- Set to true to automatically unload the model when
	--				-- exiting nvim.
	--				prompt = function(lines_before, lines_after)
	--					-- You may include filetype and/or other project-wise context in this string as well.
	--					-- Consult model documentation in case there are special tokens for this.
	--					return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
	--				end,
	--			},
	--			notify = true,
	--			notify_callback = function(msg)
	--				vim.notify(msg)
	--			end,
	--			run_on_every_keystroke = false,
	--			ignored_file_types = {
	--				-- default is not to ignore
	--				-- uncomment to ignore in lua:
	--				-- lua = true
	--			},
	--		})
	--	end,
	--},
}
