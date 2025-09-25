return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    config = function()
      -- Keymaps for molten
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize molten" })
      vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator" })
      vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line" })
      vim.keymap.set("x", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual" })
      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
      vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>", { desc = "Delete cell" })
      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
      vim.keymap.set("n", "<localleader>os", ":MoltenShowOutput<CR>", { desc = "Show output" })
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- or "ueberzug" if using that terminal
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
    },
  },
}