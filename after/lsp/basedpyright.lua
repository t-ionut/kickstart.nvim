---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      -- Imports are organized by ruff
      disableOrganizeImports = true,
      analysis = {
        -- 'recommended' (the default) is very noisy on Django code
        typeCheckingMode = 'standard',
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
}
