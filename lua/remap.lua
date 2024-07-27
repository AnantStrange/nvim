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
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Search and replace
vim.keymap.set("n", "<leader>s", ":%s/")
vim.keymap.set("v", "<leader>s", ":s/")

-- Make file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x % > /dev/null 2>&1<CR>", { silent = true })


-- Insert mode enhancements
vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')

-- LSP related mappings
vim.keymap.set("n", "gd", vim.lsp.buf.declaration)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)

-- Quick movement
vim.keymap.set("n", "<C-j>", "5j")
vim.keymap.set("n", "<C-k>", "5k")

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
