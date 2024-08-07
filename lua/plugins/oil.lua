return {
	"stevearc/oil.nvim",
	opts = {},
    -- enabled = false,
    event = "VeryLazy",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
            default_file_explorer = false,
            -- default_file_explorer = true,
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
            }
		})
	end,
}
