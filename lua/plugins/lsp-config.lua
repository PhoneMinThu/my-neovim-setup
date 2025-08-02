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
      { "mason-org/mason.nvim", opts = {} },
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

          -- javascript, typescript
          "ts_ls",
          "eslint",

          -- html
          "html",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- python
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
            },
          },
        },
        capabilities = capabilities,
      })
      lspconfig.ruff.setup({})

      -- typescript, javascript
      lspconfig.ts_ls.setup({})

      -- html
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Keymaps for LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

      vim.keymap.set("n", "gv", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
      end, { desc = "Go to Defination Vertical split" })

      vim.keymap.set("n", "gs", function()
        vim.cmd("split")
        vim.lsp.buf.definition()
      end, { desc = "Go to Defination Vertical split" })
    end,
  },
}
