---@diagnostic disable: deprecated
local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
}

local vtsls_config = {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

-- If you are not on most recent `nvim-lspconfig` or you want to override
local vue_ls_config = {
    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
            if #clients == 0 then
                vim.notify(
                    "Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
                    vim.log.levels.ERROR
                )
                return
            end
            local ts_client = clients[1]

            ---@diagnostic disable-next-line: deprecated
            local param = unpack(result)
            ---@diagnostic disable-next-line: deprecated
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
                title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                command = "typescript.tsserverRequest",
                arguments = {
                    command,
                    payload,
                },
            }, { bufnr = context.bufnr }, function(_, r)
                local response = r and r.body
                -- TODO: handle error or response nil here, e.g. logging
                -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
                local response_data = { { id, response } }

                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify("tsserver/response", response_data)
            end)
        end
    end,
}

-- Plugin Setup
return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- lua
                    "lua_ls",

                    -- python
                    "pyright",
                    "ruff",

                    -- rust
                    "rust_analyzer",

                    -- ts/js
                    "ts_ls",
                    "eslint",

                    -- web
                    "html",
                    "cssls",
                    "tailwindcss",

                    -- c/cpp
                    "clangd",

                    -- data
                    "sqlls",
                    "postgres_lsp",

                    -- serial data
                    "jsonls",
                    "yamlls",

                    -- docker
                    "docker_language_server",

                    -- markdown
                    "markdown_oxide",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })

            -- Python
            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                        },
                    },
                },
                capabilities = capabilities,
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
            })

            -- TypeScript/JavaScript (fallback if not using vtsls for some projects)
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
            })

            -- CPP
            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })

            -- HTML
            vim.lsp.config("html", {
                capabilities = capabilities,
            })

            -- CSS
            vim.lsp.config("cssls", {
                capabilities = capabilities,
            })
            vim.lsp.config("tailwindcss", {
                capabilities = capabilities,
            })

            -- dart
            vim.lsp.config("dartls", {
                cmd = { "dart", "language-server", "--protocol=lsp" },
                filetypes = { "dart" },
                root_markers = { "pubspec.yaml" },
                settings = {
                    dart = {
                        completeFunctionCalls = true,
                        showTodos = true,
                        analysisExcludedFolders = {
                            vim.fn.expand("$HOME/.pub-cache"),
                            vim.fn.expand("$HOME/flutter"),
                        },
                    },
                },
            })

            -- flutter
            vim.lsp.config("dartls", {
                cmd = { "flutter", "language-server", "--protocol=lsp" },
                filetypes = { "dart" },
                root_markers = { "pubspec.yaml" },
                settings = {
                    dart = {
                        completeFunctionCalls = true,
                        showTodos = true,
                        analysisExcludedFolders = {
                            vim.fn.expand("$HOME/.pub-cache"),
                            vim.fn.expand("$HOME/flutter"),
                        },
                    },
                },
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dart",
                callback = function()
                    vim.lsp.start(vim.lsp.config("dartls"))
                end,
            })

            -- JSON, YAML
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
            })
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
            })

            -- SQL
            vim.lsp.config("sqlls", {
                capabilities = capabilities,
            })

            -- PostgresSQL
            vim.lsp.config("postgres_lsp", {
                capabilities = capabilities,
            })

            -- Configure postgres_lsp manually (using postgrestools)
            vim.lsp.enable({
                -- lua
                "lua_ls",

                -- python
                "pyright",
                "ruff",

                -- rust
                "rust_analyzer",

                -- ts/js
                "ts_ls",
                "eslint",

                -- web
                "html",
                "cssls",
                "tailwindcss",

                -- dart
                "dartls",

                -- c/cpp
                "clangd",

                -- data
                "sqlls",
                "postgres_lsp",

                -- serial data
                "jsonls",
                "yamlls",

                -- docker
                "docker_language_server",

                -- markdown
                "markdown_oxide",
            })

            vim.lsp.config("vtsls", vtsls_config)
            vim.lsp.config("vue_ls", vue_ls_config)
            vim.lsp.enable({ "vtsls", "vue_ls" })

            -- Global Diagnostic UI settings
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
}
