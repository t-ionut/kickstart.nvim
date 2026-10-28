-- Core keymaps that don't depend on any plugin. Plugin keymaps live with their plugin spec.
-- Buffer navigation uses the built-in `[b` / `]b` (Neovim 0.11+).
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>jq', '<cmd>%!jq "."<CR>', { desc = '[J][Q] Format JSON using jq' })

-- Exit terminal mode (default is <C-\><C-n>)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window focus with CTRL+hjkl. See `:help wincmd`
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
