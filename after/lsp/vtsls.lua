---@diagnostic disable: deprecated
-- after/lsp/vtsls.lua
-- TypeScript / JavaScript setup with Vue plugin and safe LSP enable

local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Register vtsls
vim.lsp.config("vtsls", {
    settings = {
        vtsls = {
            tsserver = { globalPlugins = { vue_plugin } },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    capabilities = capabilities,
})

-- ✅ Enable once after startup (not during autoload)
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.lsp.enable({ "vtsls" })
    end,
})
