-- map with `noremap` option set to `true` by default
local function map(mode, lhs, rhs, opts)
  opts = opts or {noremap = true}
  if opts.noremap == nil then
    opts.noremap = true
  end
  if opts.buffer then
    local bufnr = opts.buffer
    opts.buffer = nil
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  else
    opts.buffer = nil
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>')
map('c', 'W!', 'w !sudo tee % >/dev/null')
map('n', '<C-p>', '<cmd>Telescope find_files<CR>')
map('n', '<C-b>', '<cmd>Telescope buffers<CR>')
map('n', '<C-s>', '<cmd>Telescope live_grep<CR>')


