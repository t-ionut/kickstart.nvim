---@module 'lazy'
---@type LazySpec
return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000, -- load before every other start plugin
  ---@module 'tokyonight'
  ---@type tokyonight.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    styles = { comments = { italic = false } },
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
