-- See `:help option-list`
local o = vim.o

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false -- shown in the statusline instead

-- Sync clipboard with the OS. Scheduled because it can slow down startup.
vim.schedule(function() o.clipboard = 'unnamedplus' end)

o.breakindent = true
o.undofile = true

-- Case-insensitive search unless \C or a capital letter is used
o.ignorecase = true
o.smartcase = true

o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300

o.splitright = true
o.splitbelow = true

o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.inccommand = 'split' -- live preview of :s
o.cursorline = true
o.scrolloff = 10
o.confirm = true -- ask to save instead of failing on :q with unsaved changes

-- Disable remote-plugin providers. Nothing here uses them, and probing for python3 through
-- pyenv shims costs ~3s every time a Python file is opened. See `:help provider`
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Mason-installed servers/tools, available without loading mason.nvim at startup
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin:' .. vim.env.PATH

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}
