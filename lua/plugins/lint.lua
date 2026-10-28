-- Linters for files that have no LSP doing the job. Python (ruff), TS (eslint) and shell
-- (bashls + shellcheck) are covered by language servers. See `:help lint`
---@module 'lazy'
---@type LazySpec
return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        dockerfile = { 'hadolint' },
        terraform = { 'tflint' },
        htmldjango = { 'djlint' },
      }

      local function is_github_workflow(buf) return vim.api.nvim_buf_get_name(buf):match '/%.github/workflows/[^/]+%.ya?ml$' ~= nil end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('user-lint', { clear = true }),
        callback = function(args)
          -- Only lint modifiable buffers, so popups like hover windows stay clean
          if not vim.bo[args.buf].modifiable then return end
          lint.try_lint()
          if is_github_workflow(args.buf) then lint.try_lint 'actionlint' end
        end,
      })
    end,
  },
}
