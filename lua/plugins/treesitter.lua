return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",

        "html",
        "css",
        "javascript",
        "python",
    },

    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            -- ✅ Add this section for folding
            fold = {
                enable = true,
            },
        })
    end,
}
