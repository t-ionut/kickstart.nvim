-- Language servers. Per-server settings live in after/lsp/<name>.lua, which Neovim merges on top
-- of the defaults shipped by nvim-lspconfig. See `:help lsp-config`.

-- Servers to enable (lspconfig names). Mason installs them automatically.
local servers = {
  -- Python / Django
  'basedpyright',
  'ruff',
  -- TypeScript / React
  'vtsls',
  'eslint',
  'tailwindcss', -- only attaches in projects with a Tailwind config
  -- Data & infra
  'jsonls',
  'yamlls',
  'taplo',
  'dockerls',
  'docker_compose_language_service',
  'helm_ls',
  'terraformls',
  'bashls',
  'nginx_language_server',
  -- Lua
  'lua_ls',
}

-- Formatters, linters and debug adapters for Mason to install (Mason package names)
local tools = {
  'stylua',
  'prettierd',
  'shfmt',
  'shellcheck',
  'djlint',
  'hadolint',
  'tflint',
  'actionlint',
}

---@module 'lazy'
---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', cmd = 'Mason', opts = {} },
      'mason-org/mason-lspconfig.nvim', -- maps lspconfig names (e.g. `vtsls`) to Mason package names
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- LSP progress
      'b0o/SchemaStore.nvim', -- JSON/YAML schemas, used in after/lsp/{jsonls,yamlls}.lua
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode) vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Highlight references of the word under the cursor while it rests there
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local group = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      require('mason-lspconfig').setup { automatic_enable = false }
      require('mason-tool-installer').setup { ensure_installed = vim.list_extend(vim.deepcopy(servers), tools) }

      vim.lsp.enable(servers)
    end,
  },

  { -- Configures lua_ls for editing this config (Neovim runtime + plugin types), lazily
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@module 'lazydev'
    ---@type lazydev.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- Pick the Python virtualenv (pyenv, uv, poetry, .venv) the LSP and debugger should use
    'linux-cultist/venv-selector.nvim',
    ft = 'python',
    cmd = 'VenvSelect',
    keys = { { '<leader>cv', '<cmd>VenvSelect<CR>', desc = 'Select Python [V]env' } },
    opts = {},
  },
}
