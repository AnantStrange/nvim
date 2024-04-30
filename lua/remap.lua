vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
        end

        -- edit new file
        bind("f", "%")
    end,
})

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>c", ":CommentToggle<CR>")
vim.keymap.set("v", "<leader>c", ":CommentToggle<CR>")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>o", "ji")
vim.keymap.set("n", "<leader>O", "ki")

vim.keymap.set("n", "<leader>G", ":G<CR>")

vim.keymap.set("n", "<leader>w", ":silent w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":silent q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":silent qa<CR>", { silent = true })

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>s", ":%s/")
vim.keymap.set("v", "<leader>s", ":s/")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>,{silent = true}")

vim.cmd('inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"')

vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end)
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.declaration()
end)
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
end)
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
end)
vim.keymap.set("n", "<leader>vr", function()
    vim.lsp.buf.references()
end)
vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
end)
vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end)
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
end)
vim.keymap.set("n", "<leader>gi", function()
    vim.lsp.buf.implementation()
end)

-- vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>", ":vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>L", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>H", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>K", ":resize +5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>J", ":resize -5<CR>", { noremap = true, silent = true })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
    ui.nav_file(4)
end)
vim.keymap.set("n", "<A-i>", function()
    ui.nav_prev()
end)
vim.keymap.set("n", "<A-o>", function()
    ui.nav_next()
end)

vim.keymap.set("n", "<leader>gp", ":G push<CR>")
vim.api.nvim_set_keymap("n", "<leader>z", ":resize 999<CR>", { noremap = true, silent = true })

-- Map <leader>R to rename the current file
vim.api.nvim_set_keymap("n", "<leader>R", [[:lua RenameCurrentFile()<CR>]], { noremap = true, silent = true })

-- Function to rename the current file
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

vim.api.nvim_set_keymap("v", "<leader>f", ":fold<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.api.nvim_set_keymap("t", "<C-d>", "<C-d>", { noremap = true })

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, { noremap = true, })
