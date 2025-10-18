return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "dracula",
                disabled_filetypes = { -- Filetypes to disable lualine for.
                    statusline = { "NvimTree" }, -- only ignores the ft for statusline.
                    winbar = {}, -- only ignores the ft for winbar.
                },
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
            },
        })
    end,
}
