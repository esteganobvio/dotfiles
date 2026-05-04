return {
  'gnikdroy/projections.nvim',
  config = function()
    require('projections').setup {
      workspaces = { -- Default workspaces to search for
        -- { "~/Documents/dev", { ".git" } },        Documents/dev is a workspace. patterns = { ".git" }
        '~/evolve',
        '~/proyectos',
      },
      -- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
      -- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
      -- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
      -- workspaces_file = "path/to/file",          -- Path to workspaces json file
      -- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
    }
  end,
}
