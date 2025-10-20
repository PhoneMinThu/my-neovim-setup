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
            local themes = require("telescope.themes")

            telescope.setup({
                defaults = {
                    -- 8 border chars: top, right, bottom, left, top-left, top-right, bottom-right, bottom-left
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    layout_config = {
                        prompt_position = "top",
                        width = 0.8,
                        height = 0.8,
                    },
                    sorting_strategy = "ascending",
                },
                pickers = {
                    find_files = themes.get_ivy({
                        layout_config = {
                            height = 0.5,
                            prompt_position = "top",
                            anchor = "N",
                            width = 0.8,
                        },
                        border = true,
                    }),
                },
                extensions = {
                    ["ui-select"] = themes.get_dropdown({ border = true }),
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
            end, { desc = "Find Files" })

            -- multigrep
            vim.keymap.set("n", "<leader>fg", multigrep.live_multigrep, { desc = "Multi Live Grep" })
            vim.keymap.set("n", "<leader>fG", function()
                multigrep.live_multigrep({ hidden = true })
            end, { desc = "Multi Live Grep" })
            -- notification
            vim.keymap.set("n", "<leader>no", ":Telescope notify<cr>", { desc = "Notification History" })
        end,
    },
}
