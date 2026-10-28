-- General editing helpers
---@module 'lazy'
---@type LazySpec
return {
  { 'NMAC427/guess-indent.nvim', event = { 'BufReadPre', 'BufNewFile' }, opts = {} },

  { -- Shows pending keybinds
    'folke/which-key.nvim',
    event = 'VeryLazy',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>r', group = '[R]un tests' },
        { '<leader>a', group = '[A]I / Claude Code', mode = { 'n', 'v' } },
        { '<leader>c', group = '[C]ode' },
        { '<leader>b', group = '[B]uffer' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  { -- Highlight TODO/NOTE/FIX etc. in comments
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },

  { -- Jump anywhere on screen with a 2-char search + label. `gs` jump, `gS` treesitter select
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@module 'flash'
    ---@type Flash.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {},
    keys = {
      { 'gs', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash jump' },
      { 'gS', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter select' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter search' },
      { '<c-s>', mode = 'c', function() require('flash').toggle() end, desc = 'Toggle flash search' },
    },
  },

  { -- Small independent modules
    'nvim-mini/mini.nvim',
    lazy = false,
    priority = 900,
    config = function()
      -- Icons for every plugin; also stands in for nvim-web-devicons
      require('mini.icons').setup { style = vim.g.have_nerd_font and 'glyph' or 'ascii' }
      MiniIcons.mock_nvim_web_devicons()

      -- Around/Inside textobjects, e.g. va) yinq ci'
      require('mini.ai').setup { n_lines = 500 }

      -- Surround: saiw) sd' sr)'
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },
}
