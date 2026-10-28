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

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}
