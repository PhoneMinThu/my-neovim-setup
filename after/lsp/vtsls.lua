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

local ts_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Register vtsls
vim.lsp.config("vtsls", {
    settings = {
        vtsls = {
            tsserver = { globalPlugins = { vue_plugin } },
        },
    },
    filetypes = { "vue" },
    capabilities = capabilities,
})

-- Register ts_ls as fallback
vim.lsp.config("ts_ls", {
    init_options = { plugins = { vue_plugin } },
    filetypes = ts_filetypes,
    capabilities = capabilities,
})

-- ✅ Enable once after startup (not during autoload)
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.lsp.enable({ "vtsls", "ts_ls" })
    end,
})
