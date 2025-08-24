local config = {
    function()
        local OPENAI_API_KEY = require("config.env").OPENAI_API_KEY
        require("neoai").setup({
            preset = "openai",
            api = {
                model = "o4-mini",
                api_key = OPENAI_API_KEY,
                max_completion_tokens = 4096 * 2,
                api_call_delay = 5000,
                additional_kwargs = {
                    reasoning_effort = "medium",
                },
            },
            chat = {
                database_path = vim.fn.stdpath("data") .. "/neoai.db",
            },
        })
    end,
    function()
        local GROQ_API_KEY = require("config.env").GROQ_API_KEY
        require("neoai").setup({
            preset = "groq",
            api = {
                model = "openai/gpt-oss-20b",
                api_key = GROQ_API_KEY,
                max_completion_tokens = 8192,
                api_call_delay = 5000,
                additional_kwargs = {
                    reasoning_effort = "medium",
                },
            },
            chat = {
                database_path = vim.fn.stdpath("data") .. "/neoai.db",
            },
        })
    end,
}
return {
    {
        -- dir = "/media/phonemt/linux_data/unix_dev/neovim-plugins/neoai.nvim/neoai.nvim",
        "nvim-neoai/neoai.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        config = config[1],
    },
}
