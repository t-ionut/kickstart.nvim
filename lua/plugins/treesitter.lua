---@module 'lazy'
---@type LazySpec
return {
  { -- Highlight, edit, and navigate code. See `:help nvim-treesitter-intro`
    'nvim-treesitter/nvim-treesitter',
    lazy = false, -- the `main` branch does not support lazy-loading
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

      ---@param buf integer
      ---@param language string
      local function try_attach(buf, language)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)
        -- Fall back to Vim's indentexpr when there is no indent query
        if vim.treesitter.query.get(language, 'indent') ~= nil then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available = ts.get_available()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
        callback = function(args)
          local buf, language = args.buf, vim.treesitter.language.get_lang(args.match)
          if not language then return end

          if vim.tbl_contains(ts.get_installed 'parsers', language) then
            try_attach(buf, language)
          elseif vim.tbl_contains(available, language) then
            -- Auto-install missing parsers, then attach
            ts.install(language):await(function() try_attach(buf, language) end)
          else
            try_attach(buf, language)
          end
        end,
      })
    end,
  },

  { 'nvim-treesitter/nvim-treesitter-context', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
}
