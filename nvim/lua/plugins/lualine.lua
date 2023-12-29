return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
      },
      extensions = {
        'toggleterm',
        'nvim-tree',
        'trouble'
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = {
          'copilot', 'encoding', 'fileformat', 'filetype'
        }, -- I added copilot here
      },
    })
  end
}
