if vim.g.neovide then
    return {}
end

return {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
        vim.cmd("colorscheme onedark")
    end,
}
