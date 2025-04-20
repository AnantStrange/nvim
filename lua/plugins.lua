return {
    {
        "preservim/tagbar",
        cmd = "TagbarToggle",
        keys = {
            { "<leader>t", ":TagbarToggle<cr>", desc = "Toggle Tagbar" },
        },
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>u", ":UndotreeToggle<cr>", desc = "Toggle Tagbar" },
        },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        -- enabled = false,
        ft = 'markdown',
        opts = {
            heading = {
                width = 'block',
            }
        }
    },
    {
        "SmiteshP/nvim-navbuddy",
        cmd = "Navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
            { "<leader>n", "<Cmd>Navbuddy<CR>", desc = "Toggle Navbuddy" },
        },
    },
    {
        "mechatroner/rainbow_csv",
        ft = "csv",
    },
    {
        -- CSS - HEX visual Color
        "norcalli/nvim-colorizer.lua",
        cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        -- enabled = false,
        config = function()
            require("gitsigns").setup()
        end,
        keys = {
            {"]c", "<Cmd>Gitsigns next_hunk<CR>"},
            {"[c", "<Cmd>Gitsigns prev_hunk<CR>"},
            {"<leader>hp", "<Cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk diff", mode = {"n","v","x"}},
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
        event = "VeryLazy",
    },
}
