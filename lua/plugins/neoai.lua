local openai_config = function()
  local OPENAI_API_KEY = require("config.env").OPENAI_API_KEY
  require("neoai").setup({
    preset = "openai",
    api = {
      model = "o4-mini",
      api_key = OPENAI_API_KEY,
      max_completion_tokens = 4096 * 2,
      addition_kwargs = {},
    },
    chat = {
      database_path = vim.fn.stdpath("data") .. "/neoai.db",
    },
  })
end

local groq_config = function()
  local OPENAI_API_KEY = require("config.env").OPENAI_API_KEY
  local GROQ_API_KEY = require("config.env").GROQ_API_KEY
  require("neoai").setup({
    preset = "groq",
    api = {
      model = "deepseek-r1-distill-llama-70b",
      api_key = GROQ_API_KEY,
      max_completion_tokens = 4096 * 2,
      addition_kwargs = {},
    },
  })
end

return {
  {
    dir = "/media/phonemt/linux_data/unix_dev/neovim-plugins/neoai.nvim/neoai.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = openai_config,
  },
}
