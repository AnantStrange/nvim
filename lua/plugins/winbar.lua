return {
    {
        "ramilito/winbar.nvim",
        event = "VeryLazy",
        opts = {
            icons = false,
            diagnostics = true,
            buf_modified = true,
            buf_modified_symbol = "M",
            dim_inactive = {
                enabled = false,
                highlight = "WinbarNC",
                icons = true,     -- whether to dim the icons
                name = true,      -- whether to dim the name
            }
        }
    },
}
