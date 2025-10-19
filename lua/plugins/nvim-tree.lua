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
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            on_attach = on_attach,
        })

        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { desc = "Toggle NvimTree", silent = true })
    end,
}
