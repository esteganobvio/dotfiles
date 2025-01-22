return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			log_level = "DEBUG",
			display = {
				action_palette = {
					width = 95,
					height = 10,
					prompt = "Prompt ",
					provider = "telescope",
					opts = {
						show_default_action = true,
						show_default_prompt_library = true,
					},
				},
			},
			adapters = {
				coder = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "coder",
						schema = {
							model = {
								default = "{{ coder_model }}",
							},
							num_ctx = {
								default = 16384,
							},
							num_predict = {
								default = -1,
							},
						},
					})
				end,
				chater = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "chater",
						schema = {
							model = {
								default = "{{ chater_model }}",
							},
							num_ctx = {
								default = 16384,
							},
							num_predict = {
								default = -1,
							},
						},
					})
				end,
			},
			strategies = {
				inline = {
					adapter = "coder",
				},
				chat = {
					adapter = "chater",
				},
			},
		},
	},
}
