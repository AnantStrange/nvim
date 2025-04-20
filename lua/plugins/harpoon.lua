return {
    "ThePrimeagen/harpoon",
    -- event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        --
        -- vim.keymap.set("n", "<A-u>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<A-i>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<A-o>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<A-p>", function() harpoon:list():select(4) end)
        --
        -- -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end },
        { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
        { "<A-u>",     function() require("harpoon"):list():select(1) end },
        { "<A-i>",     function() require("harpoon"):list():select(2) end },
        { "<A-o>",     function() require("harpoon"):list():select(3) end },
        { "<A-p>",     function() require("harpoon"):list():select(4) end },
        { "<C-S-P>",   function() require("harpoon"):list():prev() end },
        { "<C-S-P>",   function() require("harpoon"):list():next() end },
    },
}
