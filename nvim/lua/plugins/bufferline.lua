return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Files",
          }
        }
      }
    })
  end
}
