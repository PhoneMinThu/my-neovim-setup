-- after/lsp/vue_ls.lua
-- Vue language server setup (safe, non-recursive)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("vue_ls", {
    filetypes = { "vue" },
    capabilities = capabilities,
})
vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.lsp.enable({ "vue_ls" })
    end,
})
