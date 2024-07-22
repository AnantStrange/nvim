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

-- vim.keymap.set("n", "<leader>o", "ji")
-- vim.keymap.set("n", "<leader>O", "ki")
vim.keymap.set("n", "<leader>o", "o<esc>k")
vim.keymap.set("n", "<leader>O", "O<esc>j")

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

-- vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gd", vim.lsp.buf.declaration)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references)
-- vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename )
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename )
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({async=true})
end)

vim.keymap.set("n", "<leader>gi",vim.lsp.buf.implementation)

vim.keymap.set("n", "<C-j>","5j")
vim.keymap.set("n", "<C-k>","5k")


vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>L", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>H", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>K", ":resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>J", ":resize -5<CR>", { noremap = true, silent = true })

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
vim.keymap.set("n", "<A-i>", ui.nav_prev)
vim.keymap.set("n", "<A-o>", ui.nav_next)

vim.keymap.set("n", "<leader>gp", ":G push<CR>")
vim.keymap.set("n", "<leader>z", ":resize 999<CR>", { noremap = true, silent = true })

-- Map <leader>R to rename the current file
vim.keymap.set("n", "<leader>R", [[:lua RenameCurrentFile()<CR>]], { noremap = true, silent = true })

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

-- vim.keymap.set("v", "<leader>f", ":fold<CR>", { noremap = true, silent = true })
vim.keymap.set({"v", "x"}, "<leader>f", ":'<,'>normal! zf<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>F", ":foldopen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set("t", "<C-d>", "<C-d>", { noremap = true })
vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, { noremap = true, })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.g.copilot_no_tab_map = true
