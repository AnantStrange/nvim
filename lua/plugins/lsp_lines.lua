return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    -- enabled = false,
    event = { "LspAttach" },
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
            float = {
                focusable = true,
                style = "rounded",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = false,
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

        vim.keymap.set("n", "<leader>id", require("lsp_lines").toggle, { desc = "Inline Diagnostics" })
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
    end,
}
