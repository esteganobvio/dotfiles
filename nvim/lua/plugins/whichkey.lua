return {
  'folke/which-key.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.nvim',
  },
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    defaults = {},
    spec = {
      -- stylua: ignore
      { "<leader>T", group = "Treesitter", nowait = true, remap = false },
      { '<leader>Ti', ':TSConfigInfo<cr>', desc = 'Info', nowait = true, remap = false },
      { '<leader>b', group = 'Buffers', nowait = true, remap = false },
      { '<leader>bb', ':b#<cr>', desc = 'Previous', nowait = true, remap = false },
      { '<leader>bd', ':bd<cr>', desc = 'Delete', nowait = true, remap = false },
      { '<leader>bf', ':Telescope buffers <cr>', desc = 'Find', nowait = true, remap = false },
      { '<leader>bl', ':Telescope buffers<CR>', desc = 'List Buffers', nowait = true, remap = false },
      { '<leader>bn', ':bn<cr>', desc = 'Next', nowait = true, remap = false },
      { '<leader>bp', ':bp<cr>', desc = 'Previous', nowait = true, remap = false },
      { '<leader>c', ':BufferClose!<CR>', desc = 'Close Buffer', nowait = true, remap = false },
      { '<leader>g', group = 'Git', nowait = true, remap = false },
      { '<leader>gc', '<cmd>G commit<cr>', desc = 'Commit', nowait = true, remap = false },
      { '<leader>gs', '<cmd>G<cr>', desc = 'Status', nowait = true, remap = false },
      { '<leader>gw', group = 'Worktrees', nowait = true, remap = false },
      { '<leader>gwc', ":lua require('telescope).extensions.git_worktree.create_git_worktree()<cr>", desc = 'Create Worktree', nowait = true, remap = false },
      { '<leader>gwl', ":lua require('telescope).extensions.git_worktree.git_worktrees()<cr>", desc = 'List Worktrees', nowait = true, remap = false },
      { '<leader>l', group = 'LSP', nowait = true, remap = false },
      { '<leader>lI', ':Mason<cr>', desc = 'Installer Info', nowait = true, remap = false },
      { '<leader>la', ':Telescope lsp_code_actions<cr>', desc = 'Code Action', nowait = true, remap = false },
      { '<leader>ld', ':Telescope lsp_document_diagnostics<cr>', desc = 'Document Diagnostics', nowait = true, remap = false },
      { '<leader>lf', ':lua vim.lsp.buf.format{async=true}<cr>', desc = 'Format', nowait = true, remap = false },
      { '<leader>li', ':LspInfo<cr>', desc = 'Info', nowait = true, remap = false },
      { '<leader>lr', ':lua vim.lsp.buf.rename()<cr>', desc = 'Rename', nowait = true, remap = false },
      { '<leader>lw', ':Telescope diagnostics<cr>', desc = 'Workspace Diagnostics', nowait = true, remap = false },
      { '<leader>n', group = 'NvimTree', nowait = true, remap = false },
      { '<leader>nf', ':NvimTreeFindFile<CR>', desc = 'Find File', nowait = true, remap = false },
      { '<leader>nn', ':NvimTreeToggle<CR>', desc = 'Toggle', nowait = true, remap = false },
      { '<leader>nr', ':NvimTreeRefresh<CR>', desc = 'Refresh', nowait = true, remap = false },
      { '<leader>p', group = 'Plugins', nowait = true, remap = false },
      { '<leader>pS', ':Lazy show<cr>', desc = 'Show', nowait = true, remap = false },
      { '<leader>pi', ':Lazy install<cr>', desc = 'Install', nowait = true, remap = false },
      { '<leader>ps', ':Lazy sync<cr>', desc = 'Sync', nowait = true, remap = false },
      { '<leader>pu', ':Lazy update<cr>', desc = 'Update', nowait = true, remap = false },
      { '<leader>s', group = 'Search', nowait = true, remap = false },
      { '<leader>sC', ':Telescope commands <cr>', desc = 'Commands', nowait = true, remap = false },
      { '<leader>sM', ':Telescope man_pages <cr>', desc = 'Man Pages', nowait = true, remap = false },
      { '<leader>sR', ':Telescope registers <cr>', desc = 'Registers', nowait = true, remap = false },
      { '<leader>sb', ':Telescope git_branches <cr>', desc = 'Checkout branch', nowait = true, remap = false },
      { '<leader>sc', ':Telescope colorscheme <cr>', desc = 'Colorscheme', nowait = true, remap = false },
      { '<leader>sf', ':Telescope find_files <cr>', desc = 'Find File', nowait = true, remap = false },
      { '<leader>sg', ':Telescope git_files <cr>', desc = 'Find Git File', nowait = true, remap = false },
      { '<leader>sh', ':Telescope help_tags <cr>', desc = 'Find Help', nowait = true, remap = false },
      { '<leader>sj', ':Telescope jumplist <cr>', desc = 'Jumplist', nowait = true, remap = false },
      { '<leader>sk', ':Telescope keymaps <cr>', desc = 'Keymaps', nowait = true, remap = false },
      { '<leader>sn', ":Telescope live_grep search_dirs={os.getenv('NOTES')} <cr>", desc = 'Notes', nowait = true, remap = false },
      {
        '<leader>sp',
        ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        desc = 'Colorscheme with Preview',
        nowait = true,
        remap = false,
      },
      { '<leader>sr', ':Telescope oldfiles <cr>', desc = 'Open Recent File', nowait = true, remap = false },
      { '<leader>st', ':Telescope live_grep <cr>', desc = 'Text', nowait = true, remap = false },
      { '<leader>t', group = 'Diagnostics', nowait = true, remap = false },
      { '<leader>td', ':Trouble diagnostics toggle filter.buf=0 <cr>', desc = 'document', nowait = true, remap = false },
      { '<leader>tl', ':Trouble loclist toggle <cr>', desc = 'loclist', nowait = true, remap = false },
      { '<leader>tq', ':Trouble qflist toggle <cr>', desc = 'quickfix', nowait = true, remap = false },
      { '<leader>tr', ':Trouble lsp toggle focus=false win.position=right <cr>', desc = 'references', nowait = true, remap = false },
      { '<leader>tt', ':Trouble diagnostics toggle <cr>', desc = 'trouble', nowait = true, remap = false },
    },
  },
  config = function(_, ops)
    local wk = require 'which-key'
    function Map_key(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = vim.tbl_extend('force', options, opts)
      end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    Map_key('n', 'H', ':bp<CR>')
    Map_key('n', 'L', ':bn<CR>')

    Map_key('n', '<tab>', ':tabnext<CR>')
    Map_key('n', '<S-tab>', ':tabprevious<CR>')

    Map_key('n', '<C-h>', ':SmartCursorMoveLeft<CR>')
    Map_key('n', '<C-j>', ':SmartCursorMoveDown<CR>')
    Map_key('n', '<C-k>', ':SmartCursorMoveUp<CR>')
    Map_key('n', '<C-l>', ':SmartCursorMoveRight<CR>')
    Map_key('n', '<A-h>', ':SmartResizeLeft<CR>')
    Map_key('n', '<A-j>', ':SmartResizeDown<CR>')
    Map_key('n', '<A-k>', ':SmartResizeUp<CR>')
    Map_key('n', '<A-l>', ':SmartResizeRight<CR>')
    Map_key('n', '<leader><leader>h', ':SmartSwapLeft<CR>')
    Map_key('n', '<leader><leader>j', ':SmartSwapDown<CR>')
    Map_key('n', '<leader><leader>k', ':SmartSwapUp<CR>')
    Map_key('n', '<leader><leader>l', ':SmartSwapRight<CR>')

    Map_key('c', 'W!', 'w !sudo tee % >/dev/null')

    wk.setup(ops)
  end,
}
