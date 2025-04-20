return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    -- lazy = false,
    dependencies = { "catppuccin/nvim" }, -- Ensure Catppuccin loads first
    event = "VeryLazy",
    -- dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            -- component_separators = { left = '', right = '' },
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = true,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            }
        },
        sections = {
            lualine_a = { 'filename' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { "buffers" },
            lualine_d = { "tabs" },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
}
