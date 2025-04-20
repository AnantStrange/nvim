return {
    'saghen/blink.cmp',
    event = "VeryLazy",
    version = '*',
    dependencies = {
        "jdrupal-dev/css-vars.nvim",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'none',
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<C-e>"] = { "cancel", "fallback" },
            ['<C-y>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            ["<C-space>"] = { "accept", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                auto_show = true,
            },
        },
        cmdline = {
            completion = { menu = { auto_show = true } },
            keymap = {
                preset = 'none',
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<C-space>"] = { "accept", "fallback" },
            },
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            -- default = { 'lsp', 'path', 'snippets', 'buffer' },
            default = { 'lsp', 'path', 'snippets', "omni", "lazydev"},
            -- default = { 'lsp', 'path', 'snippets', "omni" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    -- score_offset = 100,
                },
                css_vars = {
                    name = "css-vars",
                    module = "css-vars.blink",
                    opts = {
                        -- WARNING: The search is not optimized to look for variables in JS files.
                        -- If you change the search_extensions you might get false positives and weird completion results.
                        search_extensions = { ".js", ".ts", ".jsx", ".tsx" }
                    }
                },
            },
        }
    },
    opts_extend = { "sources.default","css_vars" }
}
