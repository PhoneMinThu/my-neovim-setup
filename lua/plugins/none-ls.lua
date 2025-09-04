return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    event = "VeryLazy",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- lua
                null_ls.builtins.formatting.stylua,

                -- javascript, typescript
                null_ls.builtins.formatting.prettierd,
            },
        })
        vim.keymap.set("n", "<M-F>", vim.lsp.buf.format, {})
    end,
}
