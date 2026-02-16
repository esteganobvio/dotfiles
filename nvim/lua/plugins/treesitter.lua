return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    treesitter.setup()
    treesitter.install { 'all' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'terraform', 'go', 'python', 'yaml', 'toml', 'markdown' },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
