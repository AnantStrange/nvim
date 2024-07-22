return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilies())
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "bashls",
                    "clangd",
                    "cssls",
                    "eslint",
                    "intelephense",
                    "pyright",
                    "bashls",
                    "gopls",
                    "intelephense",
                    "rust_analyzer",
                    "taplo",
                },
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
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
                end,

                ["intelephense"] = function()
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
                end,

                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                        cmd = { "gopls" },
                        filetypes = { "go", "gomod" },
                        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                        settings = {
                            gopls = {
                                completeUnimported = true,
                                usePlaceholders = true,
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                            },
                        },
                    })
                end,

                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup({
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
                end,

                ["pylsp"] = function()
                    local venv_path = os.getenv("VIRTUAL_ENV")
                    local py_path = nil
                    if venv_path ~= nil then
                        py_path = venv_path .. "/bin/python3"
                    else
                        py_path = vim.g.python3_host_prog
                    end

                    lspconfig.pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    -- formatter options
                                    black = { enabled = true },
                                    autopep8 = { enabled = false },
                                    yapf = { enabled = false },

                                    -- rope(refactoring tool) configuration
                                    -- slowing down my system, better not to use
                                    rope_autoimport = {
                                        enabled = true,
                                        completions = { enabled = true },
                                        code_actions = { enabled = true },
                                    },
                                    rope_completion = { enabled = true },

                                    -- linter options
                                    pylint = { enabled = false, executable = "pylint" },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                    mccabe = { enabled = false },
                                    -- flake8 = { enabled = true },
                                    flake8 = { enabled = false, maxLineLength = 121, ignore = { "F401", "W503" } },
                                    -- we can use 'setup.cfg' or .flake8, which is a config file for flake8
                                    -- at project root, first we will look for 'setup.cfg' or .flake8
                                    -- and if not found then it follows these inline settings.

                                    -- type checker
                                    -- mypy = { enabled = true },
                                    -- not working(working in mac at present in astronvim v4 didn't check on linux yet)
                                    -- with this new way of configuring pylsp in neovim(AstroNvim)
                                    -- i.e. pylsp = { settings = { pylsp = { plugins = "settings for pylsp" } } }
                                    -- way of configuration
                                    pylsp_mypy = {
                                        enabled = true,
                                        -- this will make mypy to use the virtual environment(if activated before runing AstroNvim)
                                        -- if not activated then it will use the system python(more specifically /usr/bin/python3)
                                        -- overrides = extra_args(),
                                        overrides = { "--python-executable", py_path, true },
                                        report_progress = true,
                                        live_mode = true,
                                    },
                                    -- auto-completion options
                                    jedi_completion = { fuzzy = true },
                                    -- import sorting
                                    pyls_isort = { enabled = true },
                                },
                            },
                        },
                        flags = {
                            debounce_text_changes = 200,
                        },
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },
}
