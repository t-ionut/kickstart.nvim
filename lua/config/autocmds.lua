-- See `:help lua-guide-autocommands`
local augroup = function(name) return vim.api.nvim_create_augroup('user-' .. name, { clear = true }) end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup 'highlight-yank',
  callback = function() vim.hl.on_yank() end,
})
