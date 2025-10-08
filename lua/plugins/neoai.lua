local OPENAI_API_KEY = require("config.env").OPENAI_API_KEY

return {
    dir = "/media/phonemt/linux_data/unix_dev/neovim-plugins/neoai.nvim/neoai.nvim/neoai.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter", -- optional, recommended for TreeSitterQuery
    },
    config = function()
        require("neoai").setup({
            preset = "openai",
            api = {
                main = {
                    api_key = OPENAI_API_KEY,
                    model = "o4-mini",
                    max_completion_tokens = 8000,
                    additional_kwargs = {
                        reasoning_effort = "medium",
                    },
                },
                small = {
                    api_key = OPENAI_API_KEY,
                    model = "gpt-4.1-mini-2025-04-14",
                    max_completion_tokens = 8000,
                },
            },
            chat = {
                database_path = vim.fn.stdpath("data") .. "/neoai.db",
            },
        })
    end,
}
