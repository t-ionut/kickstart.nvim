local prettier = { 'prettierd', 'prettier', stop_after_first = true }

---@module 'lazy'
---@type LazySpec
return {
  { -- Formatting, with format-on-save
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      { '<leader>f', function() require('conform').format { async = true, lsp_format = 'fallback' } end, mode = '', desc = '[F]ormat buffer' },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- No standardized style for these, so don't format them on save
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 3000, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_organize_imports', 'ruff_format' },
        htmldjango = { 'djlint' },
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        yaml = prettier,
        css = prettier,
        markdown = prettier,
        html = prettier,
        sh = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        hcl = { 'terraform_fmt' },
        xml = { 'xmllint' },
      },
    },
  },
}
