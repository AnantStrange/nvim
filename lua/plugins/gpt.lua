return {
    -- "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"
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("chatgpt").setup({
            api_key = "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",
            endpoint = "https://api.openai.com/v1/chat/completions",
            model = 'text-davinci-003',
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
