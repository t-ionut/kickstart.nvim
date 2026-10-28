---@type vim.lsp.Config
return {
  before_init = function(_, config)
    config.settings.yaml.schemas = vim.tbl_extend('force', require('schemastore').yaml.schemas(), {
      kubernetes = { 'k8s/**/*.yaml', 'kubernetes/**/*.yaml', 'deploy/k8s/**/*.yaml', '*.k8s.yaml' },
    })
  end,
  settings = {
    yaml = {
      -- Disable the built-in store, SchemaStore.nvim provides the schemas
      schemaStore = { enable = false, url = '' },
      keyOrdering = false,
      format = { enable = false }, -- prettierd formats YAML
    },
    redhat = { telemetry = { enabled = false } },
  },
}
