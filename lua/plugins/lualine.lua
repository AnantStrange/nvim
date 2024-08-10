return {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    -- dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        require("lualine").setup({
            sections = { lualine_c = { require("auto-session.lib").current_session_name } },
        })
    end,
}
