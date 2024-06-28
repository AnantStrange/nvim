return{
	"catppuccin/nvim",
	lazy = false,
    enabled = true,
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "catppuccin-mocha"
	end
}
