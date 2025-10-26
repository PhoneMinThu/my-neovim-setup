return {

    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            python = { "ruff" },
            vue = { "eslint" },
            javascript = { "eslint" },
            javascriptreact = { "eslint" },
            typescript = { "eslint" },
            typescriptreact = { "eslint" },

            rust = { "clippy" },
        }

        -- Global Diagnostic UI settings
        vim.diagnostic.config({
            virtual_text = true,
            signs = false,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- float diagnostic
        vim.o.updatetime = 250
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, {
                    focus = false,
                    border = "rounded",
                    scope = "cursor",
                })
            end,
        })

        -- Auto lint on save
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
