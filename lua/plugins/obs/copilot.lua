return {
    "github/copilot.vim",
    enabled = false,
    config = function()
        vim.keyap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
}
