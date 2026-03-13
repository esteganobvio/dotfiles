return {
  {
    'BlinkResearchLabs/blink-edit.nvim',
    config = function()
      require('blink-edit').setup {
        llm = {
          provider = 'sweep',
          backend = 'openai',
          url = 'http://wildfly:9999',
          model = 'sweep',
        },
      }
    end,
  },
}
