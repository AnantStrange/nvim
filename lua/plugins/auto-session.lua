return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            -- auto_session_root_dir = "~/.local/share/nvim_session/",
            auto_save_enabled = true,
            auto_restore_enabled = true,
            post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
            end,
        })
    end,
}
