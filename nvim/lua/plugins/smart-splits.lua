return {
  'smart-splits-nvim/smart-splits.nvim',
  -- lazy = false: the tmux backend must run at startup to set @pane-is-vim
  -- and register its tmux key bindings; a lazy load makes tmux swallow
  -- <C-hjkl> before Neovim ever sees them.
  lazy = false,
  version = '^3.0.0',
  -- v3 core ships no multiplexer support and has no auto-detection:
  -- each mux is a separate backend plugin, named explicitly below.
  dependencies = {
    { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
    {
      'smart-splits-nvim/backend-wezterm',
      main = 'smart-splits-backend-wezterm',
      opts = { cli_path = 'wezterm' },
    },
  },
  opts = {
    mux = {
      -- priority order; tmux is the inner multiplexer, so it goes first
      backend = { 'smart-splits-backend-tmux', 'smart-splits-backend-wezterm' },
    },
  },
}
