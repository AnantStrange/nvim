-- Normal mode	n
-- Visual mode	v
-- Visual block mode x
-- Select mode	s
-- Insert mode	i
-- Command-line mode	c
-- Operator-pending mode	o
-- Terminal mode	t

local set = vim.keymap.set

set("n", "<leader>l", ":Lazy<CR>", { remap = true, silent = true })
set("n", "<leader>m", ":Mason<CR>", { remap = true, silent = true })

-- Visual mode line movement
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '>-2<CR>gv=gv")

-- Normal mode enhancements
set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")

set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Comment or uncomment the current line in normal mode
set("n", "<leader>c", "gcc", { remap = true, silent = true })
set("v", "<leader>c", "gc", { remap = true, silent = true })

-- Paste without yanking
set("x", "<leader>p", '"_dP')

-- Quick open new lines
set("n", "<leader>o", "o<esc>k")
set("n", "<leader>O", "O<esc>j")

-- Save and quit
set("n", "<leader>w", ":silent w<CR>", { silent = true })
set("n", "<leader>q", ":silent q!<CR>", { silent = true })
set("n", "<leader>Q", ":silent qa<CR>", { silent = true })

-- Clipboard operations
set({ "n", "v", "x" }, "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y')

-- Search and replace
set("n", "<leader>s", ":%s/")
set("v", "<leader>s", ":s/")

-- Insert mode enhancements
-- vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')
set("i", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    if col >= 1 then
        local char_pair = line:sub(col, col + 1)
        if char_pair == "{}" or char_pair == "[]" then
            return "<CR><Esc>O"
        end
    end
    return "<CR>"
end, { expr = true, noremap = true })


-- LSP related mappings
set("n", "K", vim.lsp.buf.hover)
set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
set("n", "<leader>d", vim.diagnostic.open_float)
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)
set("n", "<leader>vca", vim.lsp.buf.code_action)
set("n", "<leader>vr", vim.lsp.buf.references)
set("n", "<leader>r", vim.lsp.buf.rename)
set("i", "<C-h>", vim.lsp.buf.signature_help)
set("n", "<C-h>", vim.lsp.buf.signature_help)
set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
set("n", "<leader>gi", vim.lsp.buf.implementation)

-- Quick movement
set({ "n", "v", "x" }, "<C-j>", "5j")
set({ "n", "v", "x" }, "<C-k>", "5k")

-- Window management
set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
set("n", "<leader><leader>", ":vsplit<CR>", { noremap = true, silent = true })
set("n", "<leader>L", ":vertical resize +5<CR>", { noremap = true, silent = true })
set("n", "<leader>H", ":vertical resize -5<CR>", { noremap = true, silent = true })
set("n", "<leader>K", ":resize +5<CR>", { noremap = true, silent = true })
set("n", "<leader>J", ":resize -5<CR>", { noremap = true, silent = true })
-- set("n", "<leader>z", ":resize 999<CR>", { noremap = true, silent = true })

-- Folding
-- set({ "v", "x" }, "<leader>f", ":'<,'>normal! zf<CR>", { noremap = true, silent = true })
-- set("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })

-- LspInfo
set("n", "<leader>i", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
set("n", "<leader>al", "<cmd>LspLog<CR>", { noremap = true, silent = true })

set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
set("t", "<C-d>", "<C-d>", { noremap = true })
set('t', '<C-z>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
set({ "n", "v", "x" }, "<leader>j", "<Cmd>ToggleTerm size=20<CR>")
set({ "n", "v", "x" }, "<leader>J", "<Cmd>ToggleTerm direction=vertical size=70<CR>", { noremap = true, silent = true })
-- set({ "n", "i", "v", "x" }, "<leader>k", "<Cmd>TermSelect<CR>")


set("t","<M-h>","<cmd>TmuxNavigateLeft<cr>")
set("t","<M-j>","<cmd>TmuxNavigateDown<cr>")
set("t","<M-k>","<cmd>TmuxNavigateUp<cr>")
set("t","<M-l>","<cmd>TmuxNavigateRight<cr>")
set("t","<M-\\>","<cmd>TmuxNavigatePrevious<cr>")
-- set("t","<C-/>",Snacks.terminal.toggle)

-- Buffer Commands
vim.keymap.set("n", "<C-A-j>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-k>", ":bnext<CR>", { noremap = true, silent = true })
