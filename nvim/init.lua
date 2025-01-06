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
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.9
  vim.g.neovide_cursor_animation_lenght = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_scroll_animation_lenght = 0

  vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', {noremap = true})
  vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', {noremap = true})
  vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', {noremap = true})
  vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', {noremap = true})
  vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', {noremap = true})
  vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true})
  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap('', '<sc-v>', '+p<CR>', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('!', 's<c-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', '<sc-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<sc-v>', '<C-R>+', { noremap = true, silent = true})
end
