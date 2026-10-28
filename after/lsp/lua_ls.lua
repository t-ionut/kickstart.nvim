---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
      format = { enable = false }, -- stylua formats Lua
      hint = { enable = true },
    },
  },
}
