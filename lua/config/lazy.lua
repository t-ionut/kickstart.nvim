-- Bootstrap lazy.nvim. See `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- Every file in lua/plugins/ returns a spec (or a list of specs) and is imported automatically.
require('lazy').setup {
  spec = { { import = 'plugins' } },
  install = { colorscheme = { 'tokyonight-night' } },
  rocks = { enabled = false }, -- no plugin here needs luarocks
  change_detection = { notify = false },
  ui = {
    -- Nerd Font icons by default, unicode fallback otherwise
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
