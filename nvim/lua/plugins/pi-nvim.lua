-- Bridge to a running pi coding agent session (carderne/pi-nvim). Pi runs in
-- its own terminal pane; this plugin sends selections, buffers, files, and
-- prompts into the active pi session over the socket opened by the pi
-- extension (installed machine-locally with `pi install npm:pi-nvim`).
return {
  'carderne/pi-nvim',
  config = function()
    require('pi-nvim').setup({
      -- Default keymaps bind <leader>p, which is the Plugins/Lazy group
      -- in this config; register our own under the <leader>a (Agents)
      -- group instead (group line lives in whichkey.lua).
      set_default_keymaps = false,
    })

    vim.keymap.set({ 'n', 'x' }, '<leader>ap', '<cmd>Pi<cr>', { desc = 'Send to Pi' })
    vim.keymap.set('n', '<leader>as', '<cmd>PiSend<cr>', { desc = 'Send prompt to Pi' })
    vim.keymap.set('n', '<leader>af', '<cmd>PiSendFile<cr>', { desc = 'Send file to Pi' })
    vim.keymap.set('x', '<leader>av', '<cmd>PiSendSelection<cr>', { desc = 'Send selection to Pi' })
    vim.keymap.set('n', '<leader>ab', '<cmd>PiSendBuffer<cr>', { desc = 'Send buffer to Pi' })
    vim.keymap.set('n', '<leader>ag', '<cmd>PiSessions<cr>', { desc = 'Pi sessions' })
    vim.keymap.set('n', '<leader>ay', '<cmd>PiPing<cr>', { desc = 'Ping Pi' })
  end,
}
