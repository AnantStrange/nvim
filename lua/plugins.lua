return {
    {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    {
        "tpope/vim-fugitive",
        cmd = "G"
    },
    {
        "theprimeagen/harpoon",
        keys = {
            { "<C-e>",     "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon Quick Menu" },
            { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>",        desc = "Harpoon Add File" },
        },
        config = function()
            -- Key mappings for Harpoon
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon Quick Menu" })
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Navigate to Harpoon File 1" })
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Navigate to Harpoon File 2" })
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Navigate to Harpoon File 3" })
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Navigate to Harpoon File 4" })
            vim.keymap.set("n", "<A-i>", ui.nav_prev, { desc = "Navigate to Previous Harpoon File" })
            vim.keymap.set("n", "<A-o>", ui.nav_next, { desc = "Navigate to Next Harpoon File" })
        end,
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
        "rcarriga/nvim-notify"
    },
    {
        'mrded/nvim-lsp-notify',
        event = { "LspAttach" },
        dependencies = { 'rcarriga/nvim-notify' },
    },
    {
        'akinsho/toggleterm.nvim',
        cmd = { "ToggleTerm" },
        config = true,
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
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "mechatroner/rainbow_csv",
        ft = "csv",
    },
}
