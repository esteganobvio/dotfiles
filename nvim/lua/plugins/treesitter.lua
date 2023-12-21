return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local config = require('nvim-treesitter.configs')
    config.setup({
      ensure_installed = 'all',
      highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
        disable = { "yaml" },
      },
    })
  end
}
