-- AI integration
-- Claude Code: runs the `claude` CLI in a split and connects it to Neovim like the VS Code extension,
-- so Claude sees your selection/open files and proposes edits as native diffs you accept or deny.
-- Copilot inline suggestions: opt-in via `vim.g.enable_copilot` in init.lua (see lua/plugins/lsp.lua).
---@module 'lazy'
---@type LazySpec
return {
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    cmd = {
      'ClaudeCode',
      'ClaudeCodeFocus',
      'ClaudeCodeSelectModel',
      'ClaudeCodeAdd',
      'ClaudeCodeSend',
      'ClaudeCodeTreeAdd',
      'ClaudeCodeStatus',
      'ClaudeCodeStart',
      'ClaudeCodeStop',
      'ClaudeCodeOpen',
      'ClaudeCodeClose',
      'ClaudeCodeDiffAccept',
      'ClaudeCodeDiffDeny',
      'ClaudeCodeCloseAllDiffs',
    },
    keys = {
      { '<leader>ac', '<cmd>ClaudeCode<CR>', desc = 'Toggle [C]laude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<CR>', desc = '[F]ocus Claude' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<CR>', desc = '[R]esume Claude session' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<CR>', desc = '[C]ontinue last Claude session' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<CR>', desc = 'Select Claude [m]odel' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<CR>', desc = 'Add current [b]uffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<CR>', mode = 'v', desc = '[S]end selection to Claude' },
      { '<leader>as', '<cmd>ClaudeCodeTreeAdd<CR>', desc = 'Add file from explorer', ft = { 'snacks_picker_list' } },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<CR>', desc = '[A]ccept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<CR>', desc = '[D]eny diff' },
    },
    opts = {
      terminal = { split_side = 'right', split_width_percentage = 0.4 },
    },
  },
}
