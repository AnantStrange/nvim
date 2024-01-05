local set = vim.opt

set.autoindent = true
set.shiftwidth = 4
set.textwidth=0
set.wrapmargin = 0
set.wrap = false
set.linebreak = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.softwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 600




