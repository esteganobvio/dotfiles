return {
  'https://codeberg.org/esteganobvio/llm-commit',
  config = function()
    require('llm-commit').setup {
      url = 'http://wildfly:9999/v1/chat/completions', -- Default
      model = 'gemma-4', -- Optional
    }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gitcommit',
      callback = function()
        vim.keymap.set('n', '<leader>gm', '<cmd>LLMCommit<cr>', { buffer = true, desc = 'Generate commit message' })
      end,
    })
  end,
}
