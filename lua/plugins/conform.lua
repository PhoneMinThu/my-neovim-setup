return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- lua
                lua = { "stylua" },

                -- python
                python = {
                    exe = "ruff",
                    args = { "format", "%:p" },
                    stdin = true,
                },

                -- web
                vue = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                javascript = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                typescript = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                javascriptreact = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                typescriptreact = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                css = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                html = {
                    exe = "prettier",
                    args = { "--stdin-filepath", "%:p" },
                    stdin = true,
                    cwd = vim.fn.getcwd(),
                },
                markdown = { "prettier" },

                -- lowlevel
                rust = { "rustfmt" },
            },
            stop_after_first = true,
        })

        vim.keymap.set({ "n", "v" }, "<M-F>", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Format file with Conform" })
    end,
}
