return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    local ts_config = require 'nvim-treesitter.config'
    treesitter.setup()

    local installed = {}
    for _, lang in ipairs(ts_config.get_installed 'parsers') do
      installed[lang] = true
    end

    local function enable(buf, lang)
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
          return
        end

        if installed[lang] then
          enable(ev.buf, lang)
          return
        end

        -- get_available() loads the (large) parser table, so only consult it
        -- for filetypes we have not seen installed.
        if not vim.list_contains(ts_config.get_available(), lang) then
          return
        end

        treesitter.install(lang):await(function(err)
          if err then
            return
          end
          installed[lang] = true
          vim.schedule(function()
            enable(ev.buf, lang)
          end)
        end)
      end,
    })
  end,
}
