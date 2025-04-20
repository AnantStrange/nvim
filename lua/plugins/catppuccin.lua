return {
    "catppuccin/nvim",
    lazy = false,
    -- event = "VeryLazy",
    -- enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
        transparent_background = true,
        -- transparent_background = false,
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme "catppuccin-mocha"
    end
}
