local function insert_shebang_and_make_executable()
    local filetype = vim.bo.filetype
    local shebang_added = false

    if filetype == 'python' then
        vim.cmd('normal! ggO#! /usr/bin/env python3')
        shebang_added = true
    elseif filetype == 'sh' then
        vim.cmd('normal! ggO#! /usr/bin/env sh')
        shebang_added = true
    elseif filetype == 'r' then
        vim.cmd('normal! ggO#! /usr/bin/env Rscript')
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions = "tcroql"
    end,
})

vim.api.nvim_create_autocmd("ExitPre", {
    pattern = "*",
    callback = function()
        if vim.fn.exists(":SessionSave") == 2 then
            vim.cmd("SessionSave")
        end
    end,
})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    float = {
        focusable = true,
        style = "rounded",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})


