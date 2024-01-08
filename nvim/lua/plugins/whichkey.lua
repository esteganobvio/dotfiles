return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require('which-key')
    local which_key = {
      setup = {
        plugins = {
          marks = true,
          registers = true,
          presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
          spelling = { enabled = true, suggestions = 20 },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        window = {
          border = "none",     -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
        show_help = true,
      },
      opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      },
      vopts = {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      },
      -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
      -- see https://neovim.io/doc/user/map.html#:map-cmd
      vmappings = {},
      mappings = {
        ["c"] = { ":BufferClose!<CR>", "Close Buffer" },
        --i = {
        --	name = "ChatGPT",
        --	e = {
        --		function()
        --      chatgpt.edit_with_instructions()
        --    end,
        --    "Edit with instructions",
        --	},
        --},
        n = {
          name = "NvimTree",
          n = { ":NvimTreeToggle<CR>", "Toggle" },
          r = { ":NvimTreeRefresh<CR>", "Refresh" },
          f = { ":NvimTreeFindFile<CR>", "Find File" },
        },
        b = {
          name = "Buffers",
          l = { ":Telescope buffers<CR>", "List Buffers" },
          b = { ":b#<cr>", "Previous" },
          d = { ":bd<cr>", "Delete" },
          f = { ":Telescope buffers <cr>", "Find" },
          n = { ":bn<cr>", "Next" },
          p = { ":bp<cr>", "Previous" },
        },
        p = {
          name = "Plugins",
          i = { ":Lazy install<cr>", "Install" },
          s = { ":Lazy sync<cr>", "Sync" },
          S = { ":Lazy show<cr>", "Show" },
          u = { ":Lazy update<cr>", "Update" },
        },
        l = {
          name = "LSP",
          a = { ":Telescope lsp_code_actions<cr>", "Code Action" },
          d = {
            ":Telescope lsp_document_diagnostics<cr>",
            "Document Diagnostics",
          },
          w = {
            ":Telescope diagnostics<cr>",
            "Workspace Diagnostics",
          },
          f = { ":lua vim.lsp.buf.format{async=true}<cr>", "Format" },
          i = { ":LspInfo<cr>", "Info" },
          I = { ":Mason<cr>", "Installer Info" },
          r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
        },
        s = {
          name = "Search",
          b = { ":Telescope git_branches <cr>", "Checkout branch" },
          c = { ":Telescope colorscheme <cr>", "Colorscheme" },
          C = { ":Telescope commands <cr>", "Commands" },
          f = { ":Telescope find_files <cr>", "Find File" },
          g = { ":Telescope git_files <cr>", "Find Git File" },
          h = { ":Telescope help_tags <cr>", "Find Help" },
          j = { ":Telescope jumplist <cr>", "Jumplist" },
          k = { ":Telescope keymaps <cr>", "Keymaps" },
          M = { ":Telescope man_pages <cr>", "Man Pages" },
          r = { ":Telescope oldfiles <cr>", "Open Recent File" },
          R = { ":Telescope registers <cr>", "Registers" },
          t = { ":Telescope live_grep <cr>", "Text" },
          n = { ":Telescope live_grep search_dirs={os.getenv('NOTES')} <cr>", "Notes" },
          p = {
            ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview",
          },
        },
        T = {
          name = "Treesitter",
          i = { ":TSConfigInfo<cr>", "Info" },
        },
        t = {
          name = "Diagnostics",
          t = { "<cmd>TroubleToggle<cr>", "trouble" },
          w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
          d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
          q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
          l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
          r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
        },
        g = {
          name = "+Git",
          s = { "<cmd>G<cr>", "Status" },
          c = { "<cmd>G commit<cr>", "Commit" },
          w = {
            name = "Worktrees",
            c = { ":lua require('telescope).extensions.git_worktree.create_git_worktree()<cr>", "Create Worktree" },
            l = { ":lua require('telescope).extensions.git_worktree.git_worktrees()<cr>", "List Worktrees" },
          },
        },
      },
    }
    function Map_key(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = vim.tbl_extend("force", options, opts)
      end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    Map_key("n", "H", ":bp<CR>")
    Map_key("n", "L", ":bn<CR>")

    Map_key("n", "<tab>", ":tabnext<CR>")
    Map_key("n", "<S-tab>", ":tabprevious<CR>")

    Map_key("n", "<C-h>", ":wincmd h<CR>")
    Map_key("n", "<C-j>", ":wincmd j<CR>")
    Map_key("n", "<C-k>", ":wincmd k<CR>")
    Map_key("n", "<C-l>", ":wincmd l<CR>")

    Map_key("c", "W!", "w !sudo tee % >/dev/null")

    wk.setup(which_key.setup)
    local opts = which_key.opts
    local vopts = which_key.vopts
    local mappings = which_key.mappings
    local vmappings = which_key.vmappings
    wk.register(mappings, opts)
    wk.register(vmappings, vopts)
    if which_key.on_config_done then
      which_key.on_config_done(wk)
    end
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
