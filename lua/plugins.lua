return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>G", "<cmd>G<cr>", desc = "Git Fugitive" }, -- Trigger fugitive on <leader>G
        },
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
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim", --diagnotics inline
        event = "VeryLazy",
    },
    { "hrsh7th/cmp-path", event = "VeryLazy" },
    {
        "preservim/tagbar",
        keys = {
            { "<leader>t", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" },
        },
    },
}
