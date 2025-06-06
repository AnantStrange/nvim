return {
    "anuvyklack/windows.nvim",
    event = "VeryLazy",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim"
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        vim.keymap.set("n", "<leader>z", "<Cmd>WindowsMaximize<CR>")
        require('windows').setup()
    end
}
