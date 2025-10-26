---@diagnostic disable: deprecated
return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
        local conform = require("conform")

        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                vue = { "prettierd", "prettier" },
                css = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
                rust = { "rustfmt" },
            },
            formatters = {},
            format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
        })

        -- Manual format shortcut
        vim.keymap.set({ "n", "v" }, "<M-F>", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format file with Conform" })
    end,
}
