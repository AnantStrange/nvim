require("set")
require("lazy-setup")
require("remap")
vim.notify = require("notify")

vim.cmd[[ autocmd FileType * setlocal formatoptions=tcroql ]]
vim.cmd[[ autocmd ExitPre * SessionSave ]]



