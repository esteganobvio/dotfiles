return {
  'esteganobvio/neovim-tasks',
  branch = 'feat/mise-module',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  cmd = 'Task',
  config = function()
    require('tasks').setup({
      default_params = {
        cargo = {
          dap = {
            config = 'rust',
            name = 'codelldb',
          },
        },
        npm = {
          cmd = 'npm',
          working_directory = vim.loop.cwd(),
        },
        make = {
          cmd = 'make',
          args = {
            all = { '-j10', 'all' },
            build = {},
            clean = { 'clean' },
          },
        },
      },
      quickfix = {
        pos = 'botright',
        height = 12,
      },
    })
  end,
  keys = {
    { '<leader>ts', '<cmd>Task start auto<cr>', desc = 'Task start (auto)' },
    { '<leader>tc', '<cmd>Task cancel<cr>', desc = 'Task cancel' },
    {
      '<leader>tl',
      function()
        local utils = require('tasks.utils')
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local conf = require('telescope.config').values
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        local entries = {}
        for _, name in ipairs(utils.get_module_names()) do
          local ok, mod = pcall(require, 'tasks.module.' .. name)
          if ok and mod.condition() then
            for task_name, _ in pairs(mod.tasks) do
              table.insert(entries, { module = name, task = task_name })
            end
          end
        end

        pickers
          .new({}, {
            prompt_title = 'Tasks',
            finder = finders.new_table({
              results = entries,
              entry_maker = function(entry)
                local display = entry.module .. ' :: ' .. entry.task
                return { value = entry, display = display, ordinal = display }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(bufnr)
              actions.select_default:replace(function()
                actions.close(bufnr)
                local sel = action_state.get_selected_entry().value
                require('tasks').start(sel.module, sel.task)
              end)
              return true
            end,
          })
          :find()
      end,
      desc = 'Task list (telescope)',
    },
  },
}
