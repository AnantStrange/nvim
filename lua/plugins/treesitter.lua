return{
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
	config = function()

		local config = require("nvim-treesitter.configs")
		config.setup({
			-- ensure_installed = {"lua","javascript","c","cpp","rust","python","json","bash","css","diff","make","php"},
			sync_install = true,
			auto_install = true,
			highlight = {enable = true},
			indent = {enable = true},
		})
	end
}
