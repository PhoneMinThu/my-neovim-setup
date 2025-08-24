return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  ---@module 'render-markdown'
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type render.md.UserConfig
  opts = {},
  event = "VeryLazy",
  config = function()
    require("render-markdown").setup({
      completions = { lsp = { enabled = true } },
    })
  end,
}
