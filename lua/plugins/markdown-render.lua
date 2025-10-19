return {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        require("render-markdown").setup({
            completions = { lsp = { enabled = true } },
        })
    end,
}
