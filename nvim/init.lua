local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("user.options")
require("lazy").setup("plugins")

if vim.g.neovide then
  vim.o.guifont = "{{ font_family }}:h{{ font_size }}"
  vim.g.neovide_transparency = 1
  vim.g.transparency = 1
  vim.g.neovide_cursor_animation_lenght = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_scroll_animation_lenght = 0
end
