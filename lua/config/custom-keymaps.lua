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
vim.keymap.set("n", "gt", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition()
end, { desc = "Goto Definition (New Tab)" })

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

-- Diff / Compare files
vim.keymap.set("n", "<leader>df", function()
    require("telescope.builtin").find_files({
        prompt_title = "Select file to diff with",
        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                if selection then
                    vim.cmd("vsplit " .. vim.fn.fnameescape(selection.path or selection.filename))
                    vim.cmd("diffthis")
                    vim.cmd("wincmd p")
                    vim.cmd("diffthis")
                end
            end)
            return true
        end,
    })
end, { desc = "Diff with file (picker)" })
vim.keymap.set("n", "<leader>dt", ":diffthis<CR>", { desc = "Diff this window", silent = true })
vim.keymap.set("n", "<leader>dD", ":diffoff!<CR>", { desc = "Diff off", silent = true })

-- nvim navbuddy
vim.keymap.set("n", "<leader>ss", ":Navbuddy<cr>", { desc = "Lsp symbols Nav", silent = true })
