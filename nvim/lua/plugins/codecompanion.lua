return {
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
    },
    config = function()
      require('codecompanion').setup {
        display = {
          action_palette = {
            width = 95,
            height = 10,
            prompt = 'Prompt ', -- Prompt used for interactive LLM calls
            provider = 'default', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
              title = 'CodeCompanion actions', -- The title of the action palette
            },
          },
        },
        adapters = {
          acp = {
            gemini_cli = function()
              return require('codecompanion.adapters').extend('gemini_cli', {
                defaults = {
                  auth_method = 'gemini-api-key', -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                },
                env = {
                  GEMINI_API_KEY = 'GEMINI_API_KEY',
                },
              })
            end,
          },
        },
      }
    end,
  },
}
