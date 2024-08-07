vim.g.tmux_navigator_no_mappings = 1
vim.g.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.g.undotree_SetFocusWhenToggle = 1

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.linebreak = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.softwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- vim.opt.signcolumn = 'yes'
vim.opt.timeoutlen = 400

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.treesitter.language.register("css", "tcss")
vim.filetype.add({
    extension = {
        tcss = "tcss",
    }
})
