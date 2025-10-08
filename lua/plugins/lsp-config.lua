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

            local param = unpack(result)
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
        lazy = false,
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
        lazy = false,
        opts = {},
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ruff",
                    "rust_analyzer",
                    "ts_ls",
                    "html",
                    "vtsls",
                    "vue_ls",
                    "clangd",
                    "cssls",
                    "tailwindcss",
                    "jdtls",
                    "postgres_lsp",
                    "jsonls",
                    "yamlls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
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
            vim.lsp.config("ruff", {
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

            -- Vue
            vim.lsp.config("vtsls", vtsls_config)
            vim.lsp.config("vue_ls", vue_ls_config)

            -- Java
            vim.lsp.config("jdtls", {
                capabilities = capabilities,
            })

            -- JSON, YAML
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
            })
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
            })

            -- Enable all LSP servers
            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "ruff",
                "rust_analyzer",
                "ts_ls",
                "html",
                "vtsls",
                "vue_ls",
                "clangd",
                "cssls",
                "tailwindcss",
                "jdtls",
                "postgres_lsp",
                "jsonls",
                "yamlls",
            })

            -- Manual LSP configurations
            local lspconfig = require("lspconfig")
            local configs = require("lspconfig.configs")

            -- Configure postgres_lsp manually (using postgrestools)
            if not configs.postgres_lsp then
                configs.postgres_lsp = {
                    default_config = {
                        cmd = {
                            vim.fn.stdpath("data") .. "/mason/bin/postgrestools",
                            "lsp-proxy",
                            "--config-path=" .. vim.fn.stdpath("config") .. "/postgrestools.jsonc",
                        },
                        filetypes = { "sql", "pgsql" },
                        root_dir = lspconfig.util.root_pattern(".git", "postgrestools.jsonc"),
                        settings = {},
                    },
                    docs = {
                        description = "PostgreSQL LSP server using postgrestools",
                    },
                }
            end

            lspconfig.postgres_lsp.setup({
                capabilities = capabilities,
            })

            -- Configure sqruff manually since it's not in mason
            if not configs.sqruff then
                configs.sqruff = {
                    default_config = {
                        cmd = { "sqruff", "lsp" },
                        filetypes = { "sql" },
                        root_dir = lspconfig.util.root_pattern(".sqruff", ".git"),
                        settings = {},
                    },
                    docs = {
                        description = "Fast SQL linter and formatter",
                    },
                }
            end

            lspconfig.sqruff.setup({
                capabilities = capabilities,
            })

            -- Global Diagnostic UI settings
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- LSP Keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
            vim.keymap.set("n", "gv", function()
                vim.cmd("vsplit")
                vim.lsp.buf.definition()
            end, { desc = "Goto Definition (VSplit)" })

            vim.keymap.set("n", "gs", function()
                vim.cmd("split")
                vim.lsp.buf.definition()
            end, { desc = "Goto Definition (Split)" })
        end,
    },
}
