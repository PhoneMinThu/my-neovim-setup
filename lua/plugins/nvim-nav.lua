return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
    config = function()
        vim.keymap.set("n", "<leader>sn", ":Navbuddy<cr>", { desc = "Lsp symbols Nav" })
    end
}
