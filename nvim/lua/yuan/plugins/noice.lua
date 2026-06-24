return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            -- vim.notify 交給 snacks.notifier 處理，noice 只負責 cmdline / messages UI。
            notify = { enabled = false },
        })
        end,
}
