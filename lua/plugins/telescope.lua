return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
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

            vim.keymap.set("n", "<leader>fz", function()
                builtin.find_files({})
            end, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fZ", function()
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
        end,
    },
}
