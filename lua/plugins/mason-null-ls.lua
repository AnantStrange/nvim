return {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        require("mason-null-ls").setup({
            handlers = {
                function() end, -- disables automatic setup of all null-ls sources
            },
            ensure_installed = {
                "bash-language-server",
                -- "black",
                "clang-format",
                "emmet-ls emmet_ls",
                "eslint_d",
                "intelephense",
                "prettierd",
                -- "rustfmt",
                "shellcheck",
                "stylua",
                "typescript-language-server",
                "vim-language-server",
                -- "python-lsp-server",
            },
        })
    end,
}
