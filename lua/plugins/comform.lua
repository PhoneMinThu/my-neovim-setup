return {
    "stevearc/conform.nvim",
    opts = {},

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = {
                    exe = "ruff",
                    args = { "--fix", "--stdin-filename", "%:p" },
                    stdin = true,
                },
                vue = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd,
                },
                javascript = { "prettier" },
                typescript = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
            },
            stop_after_first = true,
        })

        vim.keymap.set({ "n", "v" }, "<M-F>", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Format file with Conform" })
    end,
}
