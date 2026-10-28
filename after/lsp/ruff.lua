---@type vim.lsp.Config
return {
  on_attach = function(client)
    -- Leave hover to basedpyright
    client.server_capabilities.hoverProvider = false
  end,
}
