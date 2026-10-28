-- Entry point. Core settings live in lua/config, plugin specs in lua/plugins (one file per area).
-- Leader must be set before lazy.nvim loads any plugin.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Opt-in GitHub Copilot inline suggestions (needs a Copilot subscription; run :LspCopilotSignIn once)
vim.g.enable_copilot = false

require 'config.options'
require 'config.filetypes'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
