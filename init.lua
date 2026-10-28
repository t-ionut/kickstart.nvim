-- Entry point. Core settings live in lua/config, plugin specs in lua/plugins (one file per area).
-- Leader must be set before lazy.nvim loads any plugin.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
