return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
      },
      extensions = {
        "toggleterm",
        "nvim-tree",
        "trouble",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          {
            "copilot",
            symbols = {
              status = {
                icons = {
                  enabled = "",
                  disabled = "",
                  sleep = "",
                  warning = "",
                  unknown = "",
                },
                hl = {
                  enabled = "#50FA7B", -- green
                  disabled = "#6272A4", -- blue
                  sleep = "#AEB7D0", -- grey
                  warning = "#FFB86C", -- yellow
                  unknown = "#FF5555", -- red
                }
              },
              spinners = require("copilot-lualine.spinners").dots,
              spinner_color = "#6272A4", -- blue
            },

            show_colors = true,
            show_loading = true,
          },
          "encoding",
          "fileformat",
          "filetype",
        }, -- I added copilot here
      },
    })
  end,
}
