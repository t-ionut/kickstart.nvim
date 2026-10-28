-- Debugging via the Debug Adapter Protocol. See `:help dap.txt` and `:help dap-view`
-- Python uses debugpy, JS/TS (Node and Chrome) uses vscode-js-debug; both are installed by Mason.
-- A project's .vscode/launch.json is picked up automatically as well.

local js_filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

---@module 'lazy'
---@type LazySpec
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'igorlfs/nvim-dap-view', version = '1.*', opts = { winbar = { controls = { enabled = true } }, auto_toggle = true } },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
      'mfussenegger/nvim-dap-python',
      'mason-org/mason.nvim', -- puts the Mason-installed adapters on PATH
    },
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<leader>dc', function() require('dap').continue() end, desc = '[D]ebug: Start/[C]ontinue' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '[D]ebug: Toggle [B]reakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = '[D]ebug: Conditional [B]reakpoint' },
      { '<leader>do', function() require('dap').step_over() end, desc = '[D]ebug: Step [O]ver' },
      { '<leader>di', function() require('dap').step_into() end, desc = '[D]ebug: Step [I]nto' },
      { '<leader>dO', function() require('dap').step_out() end, desc = '[D]ebug: Step [O]ut' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = '[D]ebug: Run to [C]ursor' },
      { '<leader>dl', function() require('dap').run_last() end, desc = '[D]ebug: Run [L]ast' },
      { '<leader>dt', function() require('dap').terminate() end, desc = '[D]ebug: [T]erminate' },
      { '<leader>dv', '<cmd>DapViewToggle<CR>', desc = '[D]ebug: Toggle [V]iew' },
      { '<leader>dw', '<cmd>DapViewWatch<CR>', desc = '[D]ebug: [W]atch expression', mode = { 'n', 'x' } },
      { '<leader>de', function() require('dap.ui.widgets').hover() end, desc = '[D]ebug: [E]valuate under cursor', mode = { 'n', 'x' } },
    },
    config = function()
      local dap = require 'dap'

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticOk', linehl = 'Visual' })

      -- Python: dap-python picks up the active virtualenv (venv-selector / VIRTUAL_ENV / LSP)
      require('dap-python').setup 'debugpy-adapter'
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django: runserver',
        program = '${workspaceFolder}/manage.py',
        args = { 'runserver', '--noreload' },
        django = true,
        justMyCode = false,
      })

      -- JavaScript / TypeScript (Node + browser)
      for _, adapter in ipairs { 'pwa-node', 'pwa-chrome' } do
        dap.adapters[adapter] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = { command = 'js-debug-adapter', args = { '${port}' } },
        }
      end
      for _, ft in ipairs(js_filetypes) do
        dap.configurations[ft] = {
          { type = 'pwa-node', request = 'launch', name = 'Node: launch file', program = '${file}', cwd = '${workspaceFolder}' },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Node: attach to process',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Chrome: launch localhost',
            url = function() return vim.fn.input('URL: ', 'http://localhost:3000') end,
            webRoot = '${workspaceFolder}',
          },
        }
      end
    end,
  },
}
