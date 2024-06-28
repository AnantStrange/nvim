local util = require "formatter.util"

local function prettier()
    return {
        exe = "prettier",
        args = {
            "--write",
            "--config-precedence",
            "prefer-file",
            "--single-quote",
            "--no-bracket-spacing",
            "--prose-wrap",
            "always",
            "--arrow-parens",
            "always",
            "--trailing-comma",
            "all",
            "--no-semi",
            "--end-of-line",
            "lf",
            "--print-width",
            vim.bo.textwidth,
            "--stdin-filepath",
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
        },
        stdin = true,
    }
end

return {
    'mhartington/formatter.nvim',
    event = "VeryLazy",

    config = function()
        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                javascript = { prettier },
                php = { prettier },
                typescript = { prettier },
                javascriptreact = { prettier },
                typescriptreact = { prettier },
                vue = { prettier },
                ["javascript.jsx"] = { prettier },
                ["typescript.tsx"] = { prettier },
                markdown = { prettier },
                css = { prettier },
                json = { prettier },
                jsonc = { prettier },
                scss = { prettier },
                less = { prettier },
                yaml = { prettier },
                graphql = { prettier },
                html = { prettier },
                reason = {
                    function()
                        return {
                            exe = "refmt",
                            stdin = true,
                        }
                    end,
                },
                lua = {
                    require("formatter.filetypes.lua").stylua,

                    function()
                        if util.get_current_buffer_file_name() == "special.lua" then
                            return nil
                        end

                        return {
                            exe = "stylua",
                            args = {
                                "--search-parent-directories",
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--",
                                "-",
                            },
                            stdin = true,
                        }
                    end,
                },
                go = {
                    function()
                        return {
                            exe = "gofmt",
                            args = { "-s", "-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                            stdin = false,
                        }
                    end,
                },
                c = {
                    function()
                        return {
                            exe = "clang-format",
                            args = { "-i", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),"-style='{IndentWidth: 4,BasedOnStyle: Google}'" },
                            stdin = false,
                        }
                    end,
                },
                cpp = {
                    function()
                        return {
                            exe = "clang-format",
                            args = { "-i", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),"-style='{IndentWidth: 4,BasedOnStyle: Google}'" },
                            stdin = false,
                        }
                    end,
                },
                rust = {
                    function()
                        return {
                            exe = "rustfmt",
                            args = { "--emit=stdout", "--edition=2018", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                            stdin = false,
                        }
                    end,
                },
            },
        })
    end

}
