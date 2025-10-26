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
                    -- vue/ts/js
                    "vtsls",
                    "ts_ls",
                    "vue_ls",

                    -- lua
                    "lua_ls",

                    -- python
                    "pyright",

                    -- web
                    "html",
                    "cssls",
                    "tailwindcss",

                    -- c/cpp
                    "clangd",

                    -- rust
                    "rust_analyzer",

                    -- database
                    "sqlls",
                    "postgres_lsp",

                    -- serial data
                    "jsonls",
                    "yamlls",

                    -- docker
                    "docker_compose_language_service",
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

            -- Web
            -- HTML
            vim.lsp.config("html", {
                capabilities = capabilities,
            })

            -- CSS
            vim.lsp.config("cssls", {
                capabilities = capabilities,
            })
            -- Tailwind
            vim.lsp.config("tailwindcss", {
                capabilities = capabilities,
            })

            -- C/CPP
            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
            })

            -- Database
            -- SQL
            vim.lsp.config("sqlls", {
                capabilities = capabilities,
            })
            -- PostgresSQL
            vim.lsp.config("postgres_lsp", {
                capabilities = capabilities,
            })

            -- JSON, YAML
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
            })
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
            })

            -- Docker
            vim.lsp.config("docker_compose_language_service", {
                capabilities = capabilities,
            })
            vim.lsp.config("docker_language_server", {
                capabilities = capabilities,
            })

            -- markdown
            vim.lsp.config("markdown_oxide", {
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

            -- attach dartls
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dart",
                callback = function()
                    vim.lsp.start(vim.lsp.config("dartls"))
                end,
            })

            -- Configure postgres_lsp manually (using postgrestools)
            vim.lsp.enable({
                -- lua
                "lua_ls",

                -- python
                "pyright",

                -- web
                "html",
                "cssls",
                "tailwindcss",

                -- dart
                "dartls",

                -- c/cpp
                "clangd",

                -- rust
                "rust_analyzer",

                -- database
                "sqlls",
                "postgres_lsp",

                -- serial data
                "jsonls",
                "yamlls",

                -- docker
                "docker_compose_language_service",
                "docker_language_server",

                -- markdown
                "markdown_oxide",
            })
        end,
    },
}
