return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", lazy = false },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({ cwd = vim.fn.argv()[1], file_ignore_patterns = { "*.gif" } })
			end)
			vim.keymap.set("n", "<C-p>", function()
				builtin.git_files({ cwd = vim.fn.argv()[1] })
			end)
			vim.keymap.set("n", "<leader>ps", function()
				builtin.live_grep()
			end)
			vim.keymap.set("n", "<leader>fd", function()
				builtin.diagnostics({ bufnr = 0 })
			end)
			-- vim.keymap.set("n","<leader>fd",function() builtin.diagnostics() end)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
