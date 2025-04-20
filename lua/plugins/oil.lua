return {
    "stevearc/oil.nvim",
    lazy = false,
    priority = 1000, -- Load before everything else
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Oil" },
    opts = {
        -- default_file_explorer = false,
        default_file_explorer = true,
        delete_to_trash = true,
        watch_for_changes = true,
        skip_confirm_for_simple_edits = true,
        columns = {
            -- "icon",
            -- "permissions",
            -- "size",
            -- "mtime",
        },
        view_options = {
            show_hidden = true,
            case_insensitive = true,
        },
        keymaps = {
            ["<C-p>"] = { "actions.preview", opts = { split = "belowright" } }
        }
    },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    }
}
