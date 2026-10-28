---@module 'lazy'
---@type LazySpec
return {
  { -- Git signs in the gutter, hunk actions and inline blame
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end

        -- Navigation (falls back to the built-in motion in diff mode)
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Jump to next git [c]hange')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Jump to previous git [c]hange')

        -- Actions
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'git [s]tage hunk')
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'git [r]eset hunk')
        map('n', '<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer, 'git [S]tage buffer')
        map('n', '<leader>hR', gitsigns.reset_buffer, 'git [R]eset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'git preview hunk [i]nline')
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, 'git [b]lame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
        map('n', '<leader>hD', function() gitsigns.diffthis '@' end, 'git [D]iff against last commit')
        map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, 'git hunks of repo to [Q]uickfix')
        map('n', '<leader>hq', gitsigns.setqflist, 'git hunks of buffer to [q]uickfix')

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git show [b]lame line')
        map('n', '<leader>bl', gitsigns.toggle_current_line_blame, 'Toggle git [B][L]ame')
        map('n', '<leader>tw', gitsigns.toggle_word_diff, '[T]oggle git [w]ord diff')

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'git [h]unk')
      end,
    },
  },

  { -- Side-by-side diffs, merge conflict resolution (3-way) and file/branch history
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      {
        '<leader>gd',
        function()
          if require('diffview.lib').get_current_view() then
            vim.cmd.DiffviewClose()
          else
            vim.cmd.DiffviewOpen()
          end
        end,
        desc = 'Toggle git [d]iff view (changes / merge conflicts)',
      },
      { '<leader>gD', '<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>', desc = 'Git [D]iff branch vs default (PR review)' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'Git file [h]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = 'Git branch [H]istory' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = 'diff3_mixed' } },
    },
  },
}
