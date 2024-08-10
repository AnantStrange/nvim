return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>pf", function()
                builtin.find_files({ cwd = vim.fn.argv()[1], file_ignore_patterns = { "*.gif" } })
            end)
            vim.keymap.set("n", "<C-p>", function()
                builtin.git_files({ cwd = vim.fn.argv()[1] })
            end)
            vim.keymap.set("n", "<leader>ps", function()
                builtin.live_grep()
            end)
            vim.keymap.set("n", "<leader>fd", function()
                builtin.diagnostics({ bufnr = 0 })
            end)
            -- vim.keymap.set("n","<leader>fd",function() builtin.diagnostics() end)
            --     vim.keymap.set("n", "s", function()
            --         builtin.find_files({
            --             cwd = vim.fn.argv()[1], -- Set current working directory to current buffer's directory
            --             file_ignore_patterns = { "*.gif" }, -- Ignore .gif files
            --         }, {
            --             on_complete = function(selection)
            --                 if selection then
            --                     print("Selected file path: " .. selection.path)

            --                     -- vim.cmd("vsplit " .. selection.path)
            --                     -- vim.api.nvim_command("wincmd l")
            --                 end
            --             end,
            --         })
            --     end, { silent = false })
        end,
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
                defaults = {
                    mappings = {
                        i = {
                            -- Add a custom mapping for opening selected file in a new split to the right
                            ["<C-s>"] = function(bufnr)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(bufnr)
                                vim.cmd("botright vnew " .. entry.path)
                            end,

                            ["<C-d>"] = function(bufnr)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(bufnr)
                                vim.cmd("belowright split " .. entry.path)
                            end,

                            ["<C-u>"] = function(bufnr)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(bufnr)
                                vim.cmd("aboveleft split " .. entry.path)
                            end,
                        },
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
