return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        -- Override vim.notify
        vim.notify = require("notify")
    end,
}
