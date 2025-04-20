return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        -- enabled = false,
        -- event = "VeryLazy",
        lazy = false,
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- null_ls.builtins.formatting.stylua,
                    -- null_ls.builtins.formatting.gofumpt,
                    -- null_ls.builtins.formatting.goimports_reviser,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.
                    -- null_ls.builtins.formatting.black,
                    -- null_ls.builtins.formatting.isort,
                    -- null_ls.builtins.diagnostics.mypy,
                }
            })
        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
    enabled = false,
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
                    "emmet-ls emmet_ls",
                    "eslint_d",
                    "prettierd",
                    "shellcheck",
                    "typescript-language-server",
                },
            })
        end,
    }
}
