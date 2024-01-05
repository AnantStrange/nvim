return{

    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()

        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
            float = {
                focusable = false,
                style = "rounded",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = false,
        })

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, {border = 'rounded'}
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {border = 'rounded'}
        )

        vim.keymap.set("n", "<leader>id", require("lsp_lines").toggle, { desc = "Inline Diagnostics" })
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)




    end

}


