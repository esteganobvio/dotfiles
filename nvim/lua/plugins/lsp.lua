local servers = {
	"dockerls",
	"gopls",
	"helm_ls",
  "bashls",
	"jsonls",
	"lua_ls",
	"pyright",
	"terraformls",
	"tflint",
	"yamlls",
}

local tools = {
	"black",
	"prettier",
	"ruff",
	"shellcheck",
	"stylua",
	"tfsec",
	"yamlfix",
	"yamllint",
  "flake8",
}

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					border = "none",
					icons = {
						package_installed = "◍",
						package_pending = "◍",
						package_uninstalled = "◍",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_instalation = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = tools,
				automatic_instalation = true,
				handlers = {},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.tilt_ls.setup({})
      lspconfig.kcl.setup({})
			local opts = {}
			for _, server in pairs(servers) do
				opts = {
					on_attach = require("user.lsp.handlers").on_attach,
					capabilities = require("user.lsp.handlers").capabilities,
				}

				server = vim.split(server, "@")[1]

				local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
				if require_ok then
					opts = vim.tbl_deep_extend("force", conf_opts, opts)
				end

				lspconfig[server].setup(opts)
			end
		end,
	},
}
