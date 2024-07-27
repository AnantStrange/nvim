require("set")
require("lazy-setup")
require("remap")


vim.cmd[[ autocmd FileType * setlocal formatoptions=tcroql ]]
vim.cmd[[ autocmd ExitPre * SessionSave ]]



