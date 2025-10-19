return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
        { "<leader>a", desc = "NeoAI" },
        { "<leader>c", desc = "LSP" },
        { "<leader>d", desc = "Debug" },
        { "<leader>f", desc = "Find/Telescope" },
        { "<leader>g", desc = "Git" },
        { "<leader>n", desc = "Notifications" },
        { "<leader>s", desc = "Search" },
        { "<leader>w", desc = "Windows" },
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>a", desc = "NeoAI" },
            { "<leader>c", desc = "LSP" },
            { "<leader>d", desc = "Debug" },
            { "<leader>f", desc = "Find/Telescope" },
            { "<leader>g", desc = "Git" },
            { "<leader>n", desc = "Notifications" },
            { "<leader>s", desc = "Search" },
            { "<leader>t", desc = "Tab/Terminal" },
            { "<leader>u", desc = "Toggle" },
            { "<leader>w", desc = "Windows" },
        })
    end,
}
