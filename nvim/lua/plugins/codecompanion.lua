return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Davidyz/VectorCode",
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
      extensions = {
        vectorcode = {
          opts = {
            add_tool = true,
          }
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true,       -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          }
        }
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
