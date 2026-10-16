-- Runs the claude agent in a pane of the surrounding multiplexer (tmux or
-- wezterm) instead of an nvim terminal split. The pane id is captured at
-- open time (both muxes print it on success) so close/focus can target it
-- exactly.
local claude_pane = nil -- { mux = 'tmux'|'wezterm', id = string }

local function detect_mux()
  if vim.env.TMUX then
    return 'tmux'
  elseif vim.env.WEZTERM_PANE then
    -- WEZTERM_PANE (not WEZTERM_SESSION_ID) is what WezTerm sets in every
    -- pane's environment; it is also the variable `wezterm cli` uses to
    -- find the current pane.
    return 'wezterm'
  end
  return nil
end

local function focus_pane()
  if not claude_pane then
    return
  end
  if claude_pane.mux == 'tmux' then
    vim.fn.system({ 'tmux', 'select-pane', '-t', claude_pane.id })
  else
    vim.fn.system({ 'wezterm', 'cli', 'activate-pane', '--pane-id', claude_pane.id })
  end
end

local function pane_alive()
  if not claude_pane then
    return false
  end
  if claude_pane.mux == 'tmux' then
    vim.fn.system({ 'tmux', 'display-message', '-p', '-t', claude_pane.id })
  else
    -- activate-pane exits non-zero if the pane no longer exists
    vim.fn.system({ 'wezterm', 'cli', 'activate-pane', '--pane-id', claude_pane.id })
  end
  return vim.v.shellerr == 0
end

local function open_pane(cmd)
  local mux = detect_mux()
  if not mux then
    return
  end
  -- Split cmd into args so flags like --resume survive direct exec
  -- (tables are executed without a shell).
  local cmd_args = vim.fn.split(cmd, '%s+', 1)
  local args = mux == 'tmux'
    and {
      'tmux', 'split-window', '-h', '-p', '30',
      '-P', '#{pane_id}', '-c', vim.fn.getcwd(),
    }
    or {
      'wezterm', 'cli', 'split-pane',
      '--right', '--percent', '30',
      '--cwd', vim.fn.getcwd(),
      '--',
    }
  for _, a in ipairs(cmd_args) do
    table.insert(args, a)
  end
  local out = vim.fn.system(args)
  if vim.v.shellerr == 0 then
    local id = out:match('^%s*(%S+)')
    if id then
      claude_pane = { mux = mux, id = id }
    end
  end
end

-- Custom terminal provider for claudecode.nvim: opens/focuses/kills the
-- claude pane in the surrounding multiplexer. Falls back to the native
-- in-editor provider when nvim is not running inside tmux or wezterm.
local mux_provider = {
  setup = function(_config)
  end,
  is_available = function()
    return detect_mux() ~= nil
  end,
  open = function(cmd, _env, _config, _focus)
    open_pane(cmd)
  end,
  close = function()
    if claude_pane then
      local args = claude_pane.mux == 'tmux'
        and { 'tmux', 'kill-pane', '-k', claude_pane.id }
        or { 'wezterm', 'cli', 'kill-pane', '--pane-id', claude_pane.id }
      vim.fn.system(args)
      claude_pane = nil
    end
  end,
  simple_toggle = function(cmd)
    if pane_alive() then
      mux_provider.close()
    else
      claude_pane = nil
      open_pane(cmd)
    end
  end,
  focus_toggle = function(cmd)
    if not pane_alive() then
      claude_pane = nil
      open_pane(cmd)
      return
    end
    focus_pane()
  end,
  get_active_bufnr = function()
    return nil
  end,
}

return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  opts = {
    terminal_cmd = '/home/linuxbrew/.linuxbrew/bin/claude', -- Point to local installation
    -- focus_after_send only works with in-editor providers (native/snacks);
    -- with this external mux provider there is no in-editor terminal to
    -- focus, so the ClaudeCodeSendComplete autocmd below focuses the
    -- mux pane running claude instead.
    focus_after_send = false,
    terminal = {
      provider = mux_provider,
    },
    diff_opts = {
      open_in_new_tab = true,
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)

    -- Focus the mux pane running claude after a successful send
    -- (replacement for focus_after_send, which is a no-op with
    -- external/custom providers).
    vim.api.nvim_create_autocmd('User', {
      pattern = 'ClaudeCodeSendComplete',
      callback = focus_pane,
    })
  end,
  keys = {
    { '<leader>c', nil, desc = 'Claude Code' },
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>cC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
    { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>cs',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
    },
    -- Diff management
    { '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
  },
}
