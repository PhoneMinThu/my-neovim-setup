return {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- Flutter setup
        local flutter_tool = require("flutter-tools")

        flutter_tool.setup(
            {
                ui = {
                    border = "rounded",
                    notification_style = "plugin",
                },
                decorations = {
                    statusline = {
                        app_version = true,
                        device = true,
                    },
                },
                debugger = { -- requires nvim-dap
                    enabled = true,
                },
                lsp = {
                    color = { enabled = true },
                    on_attach = function(_, bufnr)
                        local opts = { buffer = bufnr, noremap = true, silent = true }
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    end,
                },
            }
        )
        vim.keymap.set("n", "<leader><C-f>", function()
            flutter_tool.setup_project(vim.fn.getcwd())
        end, { desc = "Flutter Setup", silent = true })
    end
}
