return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('vectorcode').setup(
        ---@type VectorCode.Opts
        {
          cli_cmds = {
            vectorcode = 'vectorcode',
          },
          ---@type VectorCode.RegisterOpts
          async_opts = {
            debounce = 10,
            events = { 'BufWritePost', 'InsertEnter', 'BufReadPost' },
            exclude_this = true,
            n_query = 1,
            notify = false,
            query_cb = require('vectorcode.utils').make_surrounding_lines_cb(-1),
            run_on_register = false,
          },
          async_backend = 'default', -- or "lsp"
          exclude_this = true,
          n_query = 1,
          notify = true,
          timeout_ms = 5000,
          on_setup = {
            update = false, -- set to true to enable update when `setup` is called.
            lsp = false,
          },
          sync_log_env_var = false,
        }
      )
      local has_vc, vectorcode_config = pcall(require, 'vectorcode.config')
      local vectorcode_cacher = nil
      if has_vc then
        vectorcode_cacher = vectorcode_config.get_cacher_backend()
      end

      -- roughly equate to 2000 tokens for LLM
      local RAG_Context_Window_Size = 8000

      require('minuet').setup {
        -- Your configuration options here
        --        virtualtext = {
        --          auto_trigger_ft = {},
        --          keymap = {
        --            -- accept whole completion
        --            accept = '<A-A>',
        --            -- accept one line
        --            accept_line = '<A-a>',
        --            -- accept n lines (prompts for number)
        --            -- e.g. "A-z 2 CR" will accept 2 lines
        --            accept_n_lines = '<A-z>',
        --            -- Cycle to prev completion item, or manually invoke completion
        --            prev = '<A-[>',
        --            -- Cycle to next completion item, or manually invoke completion
        --            next = '<A-]>',
        --            dismiss = '<A-e>',
        --          },
        --        },
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 1024,
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'wildfly',
            end_point = 'http://wildfly:9999/v1/completions',
            model = 'zeta-2',
            optional = {
              max_tokens = 1024,
              top_p = 0.9,
            },
          },
          -- Llama.cpp does not support the `suffix` option in FIM completion.
          -- Therefore, we must disable it and manually populate the special
          -- tokens required for FIM completion.
          template = {
            prompt = function(pref, suff, _)
              local prompt_message = ''
              if has_vc then
                for _, file in ipairs(vectorcode_cacher.query_from_cache(0)) do
                  prompt_message = prompt_message .. '<|file_sep|>' .. file.path .. '\n' .. file.document
                end
              end

              prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)
              return '<|fim_prefix|>' .. pref .. '<|fim_suffix|>' .. suff .. '<|fim_middle|>'
            end,
            suffix = false,
          },
        },
      }
    end,
  },
}
