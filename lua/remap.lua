-- Normal mode	n
-- Visual mode	v
-- Visual block mode x
-- Select mode	s
-- Insert mode	i
-- Command-line mode	c
-- Operator-pending mode	o
-- Terminal mode	t

local set = vim.keymap.set

-- Filetype specific autocommands
vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs)
            set("n", lhs, rhs, { remap = true, buffer = true })
        end
        -- Edit new file
        bind("f", "%")
    end,
})

local function start_lsp_client_for_buf(bufnr)
    local filetype = vim.bo[bufnr].filetype
    local lspconfig = require("lspconfig")

    -- Define LSP clients for each filetype
    local lsp_clients = {
        -- python = { "pyright", "pylsp" },
        python = { "pylsp" },
        lua = { "lua_ls" },
        -- Add other filetypes and their LSP clients here
    }

    -- Start LSP clients for the detected filetype
    if lsp_clients[filetype] then
        for _, lsp in ipairs(lsp_clients[filetype]) do
            if lspconfig[lsp] then
                lspconfig[lsp].setup({})
                vim.cmd("LspStart " .. lsp)
            end
        end
    end
end

vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        start_lsp_client_for_buf(bufnr)
    end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        start_lsp_client_for_buf(bufnr)
    end
})



-- General key mappings
-- set("n", "<leader>pv", vim.cmd.Ex)
set("n", "<leader>pv", ":Oil<CR>")

-- Visual mode line movement
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '>-2<CR>gv=gv")

-- Normal mode enhancements
set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Commenting
-- set("n", "<leader>c", ":CommentToggle<CR>")
-- set("v", "<leader>c", ":CommentToggle<CR>")
-- Comment or uncomment the current line in normal mode
set("n", "<leader>c", "gcc", { remap = true, silent = true })
set("v", "<leader>c", "gc", { remap = true, silent = true })

-- Paste without yanking
set("x", "<leader>p", '"_dP')

-- Quick open new lines
set("n", "<leader>o", "o<esc>k")
set("n", "<leader>O", "O<esc>j")

-- Git integration
set("n", "<leader>G", ":G<CR>")
set("n", "<leader>gp", ":G push<CR>")

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

local function insert_shebang_and_make_executable()
    local filetype = vim.bo.filetype
    local shebang_added = false

    if filetype == 'python' then
        vim.cmd('normal! ggO#! /usr/bin/env python3')
        shebang_added = true
    elseif filetype == 'sh' then
        vim.cmd('normal! ggO#! /usr/bin/env sh')
        shebang_added = true
    end

    if shebang_added then
        -- Add a blank line after the shebang
        vim.cmd('normal! o')
        -- Return cursor to the original position
        vim.cmd('normal! gg')
    end

    -- Make the file executable
    vim.cmd('silent !chmod +x %')
end

set('n', '<leader>x', insert_shebang_and_make_executable, { silent = true })


-- Insert mode enhancements
vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')

-- LSP related mappings
set("n", "gd", vim.lsp.buf.declaration)
set("n", "K", vim.lsp.buf.hover)
set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
set("n", "<leader>d", vim.diagnostic.open_float)
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)
set("n", "<leader>vca", vim.lsp.buf.code_action)
set("n", "<leader>vr", vim.lsp.buf.references)
set("n", "<leader>r", vim.lsp.buf.rename)
set("i", "<C-h>", vim.lsp.buf.signature_help)
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

-- File renaming
set("n", "<leader>R", [[:lua RenameCurrentFile()<CR>]], { noremap = true, silent = true })

function RenameCurrentFile()
    local current_name = vim.fn.expand("%:p")
    local new_name = vim.fn.input("New file name: ", current_name)
    if new_name ~= "" and new_name ~= current_name then
        vim.fn.system("mv " .. vim.fn.shellescape(current_name) .. " " .. vim.fn.shellescape(new_name))
        vim.cmd("e " .. new_name)
    else
        print("Invalid file name or same as the current name. Rename aborted.")
    end
end

-- Folding
set({ "v", "x" }, "<leader>f", ":'<,'>normal! zf<CR>", { noremap = true, silent = true })
set("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })

-- Plugin-specific mappings
set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })
set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
set("t", "<C-d>", "<C-d>", { noremap = true })
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Disable Copilot tab mapping
vim.g.copilot_no_tab_map = true

-- LspInfo
set("n", "<leader>i", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
set("n", "<leader>al", "<cmd>LspLog<CR>", { noremap = true, silent = true })

-- set("n", "<leader>z", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })
set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
set('t', '<C-z>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
set('t', '<M-h>', '<Cmd>TmuxNavigateLeft<CR>', { noremap = true})
set({ "n", "v", "x" }, "<leader>j", "<Cmd>ToggleTerm size=20<CR>")
set({ "n", "v", "x" }, "<leader>J", "<Cmd>ToggleTerm direction=vertical size=70<CR>", { noremap = true, silent = true })
set({ "n", "i", "v", "x" }, "<leader>k", "<Cmd>TermSelect<CR>")
set("n", "<leader>m", "<Cmd>Mason<CR>")


-- Vertical split on the right and create a new file
vim.api.nvim_set_keymap('n', '<leader>vn', ':botright vnew | :call inputsave() | :let fname = input("New file name: ") | :call inputrestore() | :execute "file " . fname<CR>', { noremap = true, silent = false })

-- Horizontal split at the bottom and create a new file
vim.api.nvim_set_keymap('n', '<leader>sn', ':botright new | :call inputsave() | :let fname = input("New file name: ") | :call inputrestore() | :execute "file " . fname<CR>', { noremap = true, silent = false })


set("n", "<leader>z", "<Cmd>WindowsMaximize<CR>")

