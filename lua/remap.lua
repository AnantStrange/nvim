-- Normal mode	n
-- Visual mode	v
-- Visual block mode x
-- Select mode	s
-- Insert mode	i
-- Command-line mode	c
-- Operator-pending mode	o
-- Terminal mode	t

local keymap = vim.keymap

-- Filetype specific autocommands
vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs)
            keymap.set("n", lhs, rhs, { remap = true, buffer = true })
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
-- keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap.set("n", "<leader>pv", ":Oil<CR>")

-- Visual mode line movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Normal mode enhancements
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Commenting
-- keymap.set("n", "<leader>c", ":CommentToggle<CR>")
-- keymap.set("v", "<leader>c", ":CommentToggle<CR>")
-- Comment or uncomment the current line in normal mode
keymap.set("n", "<leader>c", "gcc", { remap = true, silent = true })
keymap.set("v", "<leader>c", "gc", { remap = true, silent = true })

-- Paste without yanking
keymap.set("x", "<leader>p", '"_dP')

-- Quick open new lines
keymap.set("n", "<leader>o", "o<esc>k")
keymap.set("n", "<leader>O", "O<esc>j")

-- Git integration
keymap.set("n", "<leader>G", ":G<CR>")
keymap.set("n", "<leader>gp", ":G push<CR>")

-- Save and quit
keymap.set("n", "<leader>w", ":silent w<CR>", { silent = true })
keymap.set("n", "<leader>q", ":silent q!<CR>", { silent = true })
keymap.set("n", "<leader>Q", ":silent qa<CR>", { silent = true })

-- Clipboard operations
keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- Search and replace
keymap.set("n", "<leader>s", ":%s/")
keymap.set("v", "<leader>s", ":s/")

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

keymap.set('n', '<leader>x', insert_shebang_and_make_executable, { silent = true })


-- Insert mode enhancements
vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')

-- LSP related mappings
keymap.set("n", "gd", vim.lsp.buf.declaration)
keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
keymap.set("n", "<leader>d", vim.diagnostic.open_float)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
keymap.set("n", "<leader>vr", vim.lsp.buf.references)
keymap.set("n", "<leader>r", vim.lsp.buf.rename)
keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)

-- Quick movement
keymap.set({ "n", "v", "x" }, "<C-j>", "5j")
keymap.set({ "n", "v", "x" }, "<C-k>", "5k")

-- Window management
keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader><leader>", ":vsplit<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>L", ":vertical resize +5<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>H", ":vertical resize -5<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>K", ":resize +5<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>J", ":resize -5<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>z", ":resize 999<CR>", { noremap = true, silent = true })

-- File renaming
keymap.set("n", "<leader>R", [[:lua RenameCurrentFile()<CR>]], { noremap = true, silent = true })

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
keymap.set({ "v", "x" }, "<leader>f", ":'<,'>normal! zf<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })

-- Plugin-specific mappings
keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })
keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
keymap.set("t", "<C-d>", "<C-d>", { noremap = true })
keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, { noremap = true })
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Disable Copilot tab mapping
vim.g.copilot_no_tab_map = true

-- LspInfo
keymap.set("n", "<leader>i", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>al", "<cmd>LspLog<CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>z", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
keymap.set('t', '<C-z>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { noremap = true, silent = true })
keymap.set('t', '<M-h>', '<Cmd>TmuxNavigateLeft<CR>', { noremap = true})
keymap.set({ "n", "v", "x" }, "<leader>j", "<Cmd>ToggleTerm size=20<CR>")
keymap.set({ "n", "v", "x" }, "<leader>J", "<Cmd>ToggleTerm direction=vertical size=70<CR>", { noremap = true, silent = true })
keymap.set({ "n", "i", "v", "x" }, "<leader>k", "<Cmd>TermSelect<CR>")
keymap.set("n", "<leader>m", "<Cmd>Mason<CR>")


-- Vertical split on the right and create a new file
vim.api.nvim_set_keymap('n', '<leader>vn', ':botright vnew | :call inputsave() | :let fname = input("New file name: ") | :call inputrestore() | :execute "file " . fname<CR>', { noremap = true, silent = false })

-- Horizontal split at the bottom and create a new file
vim.api.nvim_set_keymap('n', '<leader>sn', ':botright new | :call inputsave() | :let fname = input("New file name: ") | :call inputrestore() | :execute "file " . fname<CR>', { noremap = true, silent = false })



