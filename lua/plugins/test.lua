-- Run tests from the editor: pytest (incl. pytest-django), vitest and jest. See `:help neotest`
---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
    },
    keys = {
      { '<leader>rr', function() require('neotest').run.run() end, desc = '[R]un nearest test' },
      { '<leader>rf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = '[R]un [F]ile' },
      { '<leader>rA', function() require('neotest').run.run(vim.uv.cwd()) end, desc = '[R]un [A]ll tests' },
      { '<leader>rl', function() require('neotest').run.run_last() end, desc = '[R]un [L]ast' },
      { '<leader>rd', function() require('neotest').run.run { strategy = 'dap' } end, desc = '[R]un nearest with [D]ebugger' },
      { '<leader>rx', function() require('neotest').run.stop() end, desc = 'Stop test run' },
      { '<leader>rs', function() require('neotest').summary.toggle() end, desc = 'Toggle test [S]ummary' },
      { '<leader>ro', function() require('neotest').output.open { enter = true, auto_close = true } end, desc = 'Show test [O]utput' },
      { '<leader>rO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle test [O]utput panel' },
      { '<leader>rw', function() require('neotest').watch.toggle(vim.fn.expand '%') end, desc = 'Toggle [W]atch file' },
      { ']t', function() require('neotest').jump.next { status = 'failed' } end, desc = 'Next failed test' },
      { '[t', function() require('neotest').jump.prev { status = 'failed' } end, desc = 'Previous failed test' },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            runner = 'pytest',
            dap = { justMyCode = false },
          },
          require 'neotest-vitest' {
            filter_dir = function(name) return name ~= 'node_modules' end,
          },
          require 'neotest-jest' {},
        },
        status = { virtual_text = true },
        output = { open_on_run = false },
      }
    end,
  },
}
