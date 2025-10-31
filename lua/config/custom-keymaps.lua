-- Resize splits using arrow keys with Ctrl
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "Decrease height" })

-- tab keymap
vim.api.nvim_set_keymap("n", "<c-l>", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-h>", ":tabprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })

-- LSP Keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- lsp -> split window
-- vim.keymap.set("n", "gv", function()
--     vim.cmd("vsplit")
--     vim.lsp.buf.definition()
-- end, { desc = "Goto Definition (VSplit)" })
--
-- vim.keymap.set("n", "gs", function()
--     vim.cmd("split")
--     vim.lsp.buf.definition()
-- end, { desc = "Goto Definition (Split)" })

-- gitsigns
vim.keymap.set("n", "<leader>gh", ":Gitsigns<CR>", { desc = "gitsigns" })

-- nvim navbuddy
vim.keymap.set("n", "<leader>ss", ":Navbuddy<cr>", { desc = "Lsp symbols Nav" })
