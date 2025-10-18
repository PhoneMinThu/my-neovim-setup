return {
    "rcarriga/nvim-notify",
    config = function()
        -- Override vim.notify
        vim.notify = require("notify")
    end,
}
