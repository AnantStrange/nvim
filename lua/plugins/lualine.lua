return{
    'nvim-lualine/lualine.nvim',
    enabled = false,
    event = "VeryLazy",
    -- dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        require("lualine").setup()
    end
}

