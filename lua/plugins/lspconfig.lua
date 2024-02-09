return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.emmet_ls.setup({
            -- on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "react", "php" },
            init_options = {
                html = {
                    options = {
                        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                        ["bem.enabled"] = true,
                        ["jsx.enabled"] = true,
                    },
                },
            },
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        lspconfig.intelephense.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Enable (omnifunc) completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
            end,
            settings = {
                intelephense = {
                    stubs = {
                        "memcached",
                        "random",
                        "mt_rand",
                        "bcmath",
                        "bz2",
                        "calendar",
                        "Core",
                        "curl",
                        "date",
                        "dba",
                        "dom",
                        "enchant",
                        "fileinfo",
                        "filter",
                        "ftp",
                        "gd",
                        "gettext",
                        "hash",
                        "iconv",
                        "imap",
                        "intl",
                        "json",
                        "ldap",
                        "libxml",
                        "mbstring",
                        "mcrypt",
                        "mysql",
                        "mysqli",
                        "password",
                        "pcntl",
                        "pcre",
                        "PDO",
                        "pdo_mysql",
                        "Phar",
                        "readline",
                        "recode",
                        "Reflection",
                        "regex",
                        "session",
                        "SimpleXML",
                        "soap",
                        "sockets",
                        "sodium",
                        "SPL",
                        "standard",
                        "superglobals",
                        "sysvsem",
                        "sysvshm",
                        "tokenizer",
                        "xml",
                        "xdebug",
                        "xmlreader",
                        "xmlwriter",
                        "yaml",
                        "zip",
                        "zlib",
                        "wordpress",
                        "woocommerce",
                    },
                    files = {
                        maxSize = 5000000,
                    },
                    format = {
                        braces = "k&r",
                    },
                },
            },
        })

        lspconfig.tsserver.setup({
            capabilities = capabilities,
        })

        require("lspconfig").rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                    diagnostics = {
                        enable = true,
                    },
                },
            },
        })

        for _, server in pairs(lspconfig) do
            if type(server) == "table" and type(server.setup) == "function" then
                server.setup({
                    capabilities = capabilities,
                })
            end
        end
    end,
}
