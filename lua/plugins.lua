return {
    {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    {
        "hrsh7th/cmp-path",
        event = "VeryLazy",
    },
    {
        "preservim/tagbar",
        keys = {
            { "<leader>t", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" },
        },
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        -- enabled = false,
        ft = 'markdown',
        config = function()
            require('render-markdown').setup({
                heading = {
                    width = 'block',
                }
            })
        end
    },
    {
        "SmiteshP/nvim-navbuddy",
        keys = "Navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
    },
    {
        "mechatroner/rainbow_csv",
        ft = "csv",
    },
}
