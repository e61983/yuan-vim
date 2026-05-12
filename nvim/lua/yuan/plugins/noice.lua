return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    config = function()
        require("notify").setup( {
            background_colour = "NotifyBackground",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 2, -- info
            minimum_width = 50,
            render = "minimal",
            stages = "fade",
            time_formats = {
                notification = "%T",
                notification_history = "%FT%T"
            },
            timeout = 1000,
            top_down = false
        })
        require("noice").setup({
            messages = {
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
            },
        })
        end,
}
