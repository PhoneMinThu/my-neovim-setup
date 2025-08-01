return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove" },
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd.Git()
        end,
        desc = "Git status",
      },
      {
        "<leader>gd",
        function()
          vim.cmd.Gdiffsplit()
        end,
        desc = "Git diff",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map("n", "<leader>gi", function()
            gitsigns.preview_hunk_inline()
          end, { desc = "Preview hunk" })

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Prev hunk" })

          -- Toggles
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
          map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle git word diff" })

          -- Text object
          map({ "o", "x" }, "ih", gitsigns.select_hunk)
        end,
      })
    end,
  },
}
