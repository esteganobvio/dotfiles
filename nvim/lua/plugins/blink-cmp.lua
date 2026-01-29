return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        {
          'L3MON4D3/LuaSnip',
          version = '2.*',
          build = (function()
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
          opts = {},
        },
        {
          'mikavilpas/blink-ripgrep.nvim',
          version = '*', -- use the latest stable version
        },
        {
          'mgalliou/blink-cmp-tmux',
        },
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer', 'ripgrep', 'tmux' },
        per_filetype = { 'codecompanion' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            -- see the full configuration below for all available options
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {},
          },
          tmux = {
            module = 'blink-cmp-tmux',
            name = 'tmux',
            -- default options
            opts = {
              all_panes = false,
              capture_history = false,
              -- only suggest completions from `tmux` if the `trigger_chars` are
              -- used
              triggered_only = false,
              trigger_chars = { '.' },
            },
          },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
    },
  },
}
