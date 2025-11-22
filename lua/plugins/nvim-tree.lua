return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
        end

        local nvim_tree = require("nvim-tree")

        nvim_tree.setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
            },
            renderer = {
                group_empty = true,
            },
            git = {
                enable = true,
                ignore = true, -- ignore files listed in .gitignore
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            filters = {
                dotfiles = false, -- hide dotfiles if you want
                custom = { "node_modules", ".venv" }, -- exclude these from the tree
            },
            filesystem_watchers = {
                enable = true, -- keep file watching
                debounce_delay = 50,
                ignore_dirs = { "node_modules", ".venv" }, -- ⬅️ new in recent versions
            },
            on_attach = on_attach,
        })

        -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { desc = "Toggle NvimTree", silent = true })
        vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", { desc = "Find file in NvimTree", silent = true })
    end,
}
