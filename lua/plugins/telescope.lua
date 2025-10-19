return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-ui-select.nvim",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        event = "VeryLazy",
        config = function()
            local telescope = require("telescope")
            local multigrep = require("config.telescope.multigrep")
            local builtin = require("telescope.builtin")

            telescope.setup({
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    fzf = {},
                },
            })

            telescope.load_extension("ui-select")
            telescope.load_extension("fzf")

            --- find
            vim.keymap.set("n", "<leader>ff", function()
                builtin.find_files({})
            end, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fa", function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, { desc = "Find Files (Hidden)" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
            vim.keymap.set("n", "<leader>fg", multigrep.live_multigrep, { desc = "Multi Live Grep" })
            vim.keymap.set("n", "<leader>fG", function()
                multigrep.live_multigrep({
                    hidden = true,
                })
            end, { desc = "Multi Live Grep" })
            vim.keymap.set("n", "<leader>fp", function()
                builtin.find_files({
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
                })
            end, { desc = "Find Source" })
            vim.keymap.set("n", "<leader>fz", function()
                builtin.current_buffer_fuzzy_find()
            end, { desc = "Buffers lines" })

            --- search
            vim.keymap.set("n", "<leader>sj", function()
                builtin.jumplist({
                    show_line = false,
                    trim_text = false,
                })
            end, { desc = "Jumps" })
            vim.keymap.set("n", "<leader>sd", function()
                builtin.diagnostics()
            end, { desc = "Diagnostics" })
            vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Commands" })
            vim.keymap.set("n", "<leader>sC", builtin.command_history, { desc = "Command Histories" })

            -- lsp
            vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "References" })
            vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
            vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Goto Type Definitions" })
            vim.keymap.set("n", "<leader>ss", function()
                builtin.lsp_document_symbols({})
            end, { desc = "Document Symbols" })
            vim.keymap.set("n", "<leader>sS", function()
                builtin.lsp_workspace_symbols({})
            end, { desc = "Workspace Symbols" })

            -- notification
            vim.keymap.set("n", "<leader>no", ":Telescope notify<cr>", { desc = "Notification History" })
        end,
    },
}
