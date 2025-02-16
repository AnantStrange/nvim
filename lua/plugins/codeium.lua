return {
    'Exafunction/codeium.vim',
    lazy = false,
    enabled = false,
    config = function()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
}
