return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local tokyonight = require("tokyonight")
    tokyonight.setup({
      style = "night",
      -- style = "storm",
      -- style = "day",
      -- style = "night",
      -- style = "storm,
      transparent = true,
    })
    vim.cmd [[colorscheme tokyonight-night]]
  end
}
