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
          {
            'copilot',
            symbols = {
                status = {
                    icons = {
                        enabled = "",
                        disabled = "",
                        warning = "",
                        unknown = ""
                    },
                    hl = {
                        enabled = "#50FA7B",
                        disabled = "#6272A4",
                        warning = "#FFB86C",
                        unknown = "#FF5555"
                    }
                },
                spinners = require("copilot-lualine.spinners").dots,
                spinner_color = "#6272A4"
            },

            show_colors = true,
            show_loading = true
          },
          'encoding',
          'fileformat',
          'filetype',
        }, -- I added copilot here
      },
    })
  end
}
