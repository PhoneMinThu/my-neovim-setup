-- Resize splits using arrow keys with Ctrl
vim.keymap.set("n", "<M-S-Left>", "<C-w><", { desc = "Decrease width" })
vim.keymap.set("n", "<M-S-Right>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<M-S-Up>", "<C-w>+", { desc = "Increase height" })
vim.keymap.set("n", "<M-S-Down>", "<C-w>-", { desc = "Decrease height" })

-- tab keymap
vim.api.nvim_set_keymap("n", "<c-l>", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-h>", ":tabprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
