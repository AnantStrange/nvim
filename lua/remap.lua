-- Normal mode	n
-- Visual mode	v
-- Visual block mode x
-- Select mode	s
-- Insert mode	i
-- Command-line mode	c
-- Operator-pending mode	o
-- Terminal mode	t

-- Filetype specific autocommands
vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
        end
        -- Edit new file
        bind("f", "%")
    end,
})

local function start_lsp_client_for_buf(bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local lspconfig = require("lspconfig")

    -- Define LSP clients for each filetype
    local lsp_clients = {
        python = { "pyright", "pylsp" },
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

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
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
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", ":Oil<CR>")

-- Visual mode line movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Normal mode enhancements
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Commenting
-- vim.keymap.set("n", "<leader>c", ":CommentToggle<CR>")
-- vim.keymap.set("v", "<leader>c", ":CommentToggle<CR>")
-- Comment or uncomment the current line in normal mode
vim.keymap.set("n", "<leader>c", "gcc", { remap = true, silent = true })
vim.keymap.set("v", "<leader>c", "gc", { remap = true, silent = true })

-- Paste without yanking
vim.keymap.set("x", "<leader>p", '"_dP')

-- Quick open new lines
vim.keymap.set("n", "<leader>o", "o<esc>k")
vim.keymap.set("n", "<leader>O", "O<esc>j")

-- Git integration
vim.keymap.set("n", "<leader>G", ":G<CR>")
vim.keymap.set("n", "<leader>gp", ":G push<CR>")

-- Save and quit
vim.keymap.set("n", "<leader>w", ":silent w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":silent q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":silent qa<CR>", { silent = true })

-- Clipboard operations
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Search and replace
vim.keymap.set("n", "<leader>s", ":%s/")
vim.keymap.set("v", "<leader>s", ":s/")

local function insert_shebang_and_make_executable()
    local filetype = vim.bo.filetype
    local shebang_added = false

    if filetype == 'python' then
        vim.cmd('normal! ggO#!/usr/bin/env python3')
        shebang_added = true
    elseif filetype == 'sh' then
        vim.cmd('normal! ggO#!/usr/bin/env sh')
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

vim.keymap.set('n', '<leader>x', insert_shebang_and_make_executable, { silent = true })


-- Insert mode enhancements
vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')

-- LSP related mappings
vim.keymap.set("n", "gd", vim.lsp.buf.declaration)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)

-- Quick movement
vim.keymap.set({ "n", "v", "x" }, "<C-j>", "5j")
vim.keymap.set({ "n", "v", "x" }, "<C-k>", "5k")

-- Window management
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>L", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>H", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>K", ":resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>J", ":resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>z", ":resize 999<CR>", { noremap = true, silent = true })

-- File renaming
vim.keymap.set("n", "<leader>R", [[:lua RenameCurrentFile()<CR>]], { noremap = true, silent = true })

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
vim.keymap.set({ "v", "x" }, "<leader>f", ":'<,'>normal! zf<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })

-- Plugin-specific mappings
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set("t", "<C-d>", "<C-d>", { noremap = true })
vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, { noremap = true })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Disable Copilot tab mapping
vim.g.copilot_no_tab_map = true

-- LspInfo
vim.keymap.set("n", "<leader>i", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>al", "<cmd>LspLog<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>z", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-z>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<leader>j", "<Cmd>ToggleTerm size=20<CR>")
vim.keymap.set({ "n", "i", "v", "x" }, "<leader>J", "<Cmd>ToggleTerm direction=vertical size=70<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<leader>k", "<Cmd>TermSelect<CR>")
