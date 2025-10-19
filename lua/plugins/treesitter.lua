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
            fold = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-n>",    -- Start selection at the current node
                    node_incremental = "<C-n>",  -- Expand to the next parent node
                    scope_incremental = "<C-s>", -- Expand to the next sibling scope
                    node_decremental = "<C-r>",  -- Contract to the previous child node
                },
            },
        })
    end,
}
