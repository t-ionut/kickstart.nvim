-- snacks.nvim: picker, file explorer, lazygit, notifications, terminal and other small utilities.
-- See `:help snacks.nvim` and `:help snacks-picker`
local function pick(source, opts)
  return function() Snacks.picker[source](opts) end
end

---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true }, -- disable heavy features on huge files
      quickfile = { enabled = true }, -- render `nvim somefile` before plugins load
      input = { enabled = true }, -- vim.ui.input
      notifier = { enabled = true, timeout = 3000 },
      indent = { enabled = true, animate = { enabled = false } },
      explorer = { enabled = true, replace_netrw = true },
      picker = {
        enabled = true,
        ui_select = true, -- vim.ui.select (code actions, etc.)
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true, layout = { layout = { position = 'right' } } },
        },
      },
      lazygit = { enabled = true },
      terminal = { enabled = true },
    },
    keys = {
      -- Search
      { '<leader><leader>', pick 'buffers', desc = '[ ] Find existing buffers' },
      { '<leader>sf', pick 'files', desc = '[S]earch [F]iles' },
      { '<leader>st', pick 'grep', desc = '[S]earch [T]ext by grep' },
      { '<leader>sw', pick 'grep_word', desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
      { '<leader>s/', pick 'grep_buffers', desc = '[S]earch [/] in Open Files' },
      { '<leader>/', pick 'lines', desc = '[/] Fuzzily search in current buffer' },
      { '<leader>s.', pick 'recent', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sr', pick 'resume', desc = '[S]earch [R]esume' },
      { '<leader>ss', function() Snacks.picker() end, desc = '[S]earch [S]elect picker' },
      { '<leader>sd', pick 'diagnostics', desc = '[S]earch [D]iagnostics' },
      { '<leader>sD', pick 'diagnostics_buffer', desc = '[S]earch buffer [D]iagnostics' },
      { '<leader>sh', pick 'help', desc = '[S]earch [H]elp' },
      { '<leader>sk', pick 'keymaps', desc = '[S]earch [K]eymaps' },
      { '<leader>sc', pick 'commands', desc = '[S]earch [C]ommands' },
      { '<leader>su', pick 'undo', desc = '[S]earch [U]ndo history' },
      { '<leader>sq', pick 'qflist', desc = '[S]earch [Q]uickfix list' },
      { '<leader>sj', pick 'jumps', desc = '[S]earch [J]umps' },
      { '<leader>sm', pick 'marks', desc = '[S]earch [M]arks' },
      { '<leader>s"', pick 'registers', desc = '[S]earch registers' },
      { '<leader>sp', pick 'lazy', desc = '[S]earch [P]lugin specs' },
      { '<leader>sN', pick 'notifications', desc = '[S]earch [N]otification history' },
      { '<leader>sn', pick('files', { cwd = vim.fn.stdpath 'config' }), desc = '[S]earch [N]eovim files' },
      { '<leader>sg', pick 'git_branches', desc = '[S]earch [G]it branches' },

      -- Explorer
      { '<leader>tn', function() Snacks.explorer() end, desc = '[T]oggle file explorer' },
      { '<leader>e', function() Snacks.explorer.reveal() end, desc = '[E]xplorer: reveal current file' },

      -- Git
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazy[g]it' },
      { '<leader>gs', pick 'git_status', desc = 'Git [s]tatus' },
      { '<leader>gl', pick 'git_log', desc = 'Git [l]og' },
      { '<leader>gL', pick 'git_log_line', desc = 'Git [L]og for line' },
      { '<leader>gf', pick 'git_log_file', desc = 'Git log for [f]ile' },
      { '<leader>gb', pick 'git_branches', desc = 'Git [b]ranches' },
      { '<leader>gS', pick 'git_stash', desc = 'Git [S]tash' },
      { '<leader>gp', pick 'gh_pr', desc = 'GitHub [p]ull requests' },
      { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git [B]rowse (open in GitHub)', mode = { 'n', 'v' } },

      -- Buffers, files, terminal, notifications
      { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
      { '<leader>cR', function() Snacks.rename.rename_file() end, desc = '[R]ename file (updates imports)' },
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle terminal', mode = { 'n', 't' } },
      { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss notifications' },
      {
        '<leader>?',
        function()
          Snacks.win {
            file = vim.fn.stdpath 'config' .. '/cheatsheet.md',
            width = 0.7,
            height = 0.85,
            border = 'rounded',
            title = ' Cheat sheet ',
            bo = { modifiable = false },
            wo = { spell = false, wrap = false, conceallevel = 2, signcolumn = 'no', statuscolumn = ' ' },
          }
        end,
        desc = 'Open keymap cheat sheet',
      },
    },
    init = function()
      -- LSP pickers, set per buffer when a server attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-snacks-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, source, desc) vim.keymap.set('n', keys, pick(source), { buffer = event.buf, desc = desc }) end
          map('grr', 'lsp_references', '[G]oto [R]eferences')
          map('gri', 'lsp_implementations', '[G]oto [I]mplementation')
          map('grd', 'lsp_definitions', '[G]oto [D]efinition')
          map('grt', 'lsp_type_definitions', '[G]oto [T]ype Definition')
          map('grc', 'lsp_incoming_calls', '[G]oto incoming [C]alls')
          map('gO', 'lsp_symbols', 'Open Document Symbols')
          map('gW', 'lsp_workspace_symbols', 'Open Workspace Symbols')
        end,
      })
    end,
  },
}
