return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "bashls",
                "clangd",
                "intelephense",
                "pyright",
                "gopls",
                "rust_analyzer",
                "biome",
            },
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        event = "VeryLazy",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local on_attach = function(client, bufnr)
                Snacks.notifier.notify("LSP server attached: " .. client.name, "info", { title = "LSP Notification" })
            end

            require("mason-lspconfig").setup_handlers({
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        cmd = { 'clangd', '--fallback-style=webkit' },
                    })
                end,

                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
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

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim', 'Snacks' }
                                }

                            }
                        }
                    })
                end,

                ["intelephense"] = function()
                    lspconfig.intelephense.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
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
                    -- Snacks.notifier.notify("GO LSP configuration is being applied!")
                    lspconfig.gopls.setup({
                        on_attach = on_attach,
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

                ["pylsp"] = function()
                    -- Snacks.notifier.notify("Python LSP is being executed!")
                    local venv_path = os.getenv("VIRTUAL_ENV")
                    local python_path = nil
                    local site_packages_path = nil

                    -- Not equal to nil
                    if venv_path ~= nil then
                        -- Determine the path to the Python executable
                        python_path = venv_path .. "/bin/python"

                        -- Extract Python version from the executable path
                        local handle = io.popen(python_path ..
                            " -c 'import sys; print(sys.version_info.major, sys.version_info.minor)'")
                        local version_output = handle:read("*a")
                        handle:close()

                        -- Parse version output
                        local major_version, minor_version = version_output:match("(%d+) (%d+)")
                        major_version = tonumber(major_version)
                        minor_version = tonumber(minor_version)

                        -- Construct the site-packages path
                        site_packages_path = venv_path ..
                            "/lib/python" .. major_version .. "." .. minor_version .. "/site-packages"
                        -- Check if site_packages_path is valid before setting PYTHONPATH
                        -- print("site_packages_path :" .. site_packages_path)
                        if site_packages_path and site_packages_path ~= "" then
                            vim.fn.setenv("PYTHONPATH", site_packages_path)
                        else
                            -- print("Invalid site-packages path: " .. tostring(site_packages_path))
                        end
                    else
                        python_path = vim.g.python3_host_prog
                        -- print("Virtual environment not found. Using system Python: " .. python_path)
                        -- Fallback or handle non-virtual environment scenario
                    end

                    lspconfig.pylsp.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
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
                                    flake8 = { enabled = true, maxLineLength = 121, ignore = { "F401", "W503", "E501", "E231", "E303", "E225", "E302" } },
                                    -- we can use 'setup.cfg' or .flake8, which is a config file for flake8
                                    -- at project root, first we will look for 'setup.cfg' or .flake8
                                    -- and if not found then it follows these inline settings.

                                    pylsp_mypy = {
                                        enabled = true,
                                        -- this will make mypy to use the virtual environment(if activated before runing AstroNvim)
                                        -- if not activated then it will use the system python(more specifically /usr/bin/python3)
                                        -- overrides = extra_args(),
                                        overrides = { "--python-executable", python_path, true },
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
        end
    },
}
