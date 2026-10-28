local inlay_hints = {
  parameterNames = { enabled = 'literals' },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = false },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}

---@type vim.lsp.Config
return {
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true, -- use the project's TypeScript version
      experimental = { completion = { enableServerSideFuzzyMatch = true } },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      inlayHints = inlay_hints,
    },
    javascript = {
      updateImportsOnFileMove = { enabled = 'always' },
      inlayHints = inlay_hints,
    },
  },
}
