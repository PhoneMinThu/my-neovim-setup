return {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    config = function()
        require("window-picker").setup({
            hint = "statusline-winbar", -- default to floating big letter
            selection_chars = "FJDKSLA;CMRUEIWOQP",
            show_prompt = true,
            prompt_message = "Pick window: ",
            filter_rules = {
                autoselect_one = true,
                include_current_win = true, -- ✅ now includes current window
                include_unfocusable_windows = false,
                bo = {
                    filetype = { "notify", "snacks_notif" },
                    buftype = {},
                },
            },
            highlights = {
                enabled = true,
                statusline = {
                    focused = { fg = "#ededed", bg = "#1d5940", bold = true },
                    unfocused = { fg = "#ededed", bg = "#3d516f", bold = true },
                },
                winbar = {
                    focused = { fg = "#ededed", bg = "#1d5940", bold = true },
                    unfocused = { fg = "#ededed", bg = "#3d516f", bold = true },
                },
            },
        })

        -- Move current buffer to picked window
        vim.keymap.set("n", "<leader>wp", function()
            local ok, picker = pcall(require, "window-picker")
            if not ok then
                return
            end
            local picked = picker.pick_window()
            if picked then
                vim.api.nvim_win_set_buf(picked, vim.api.nvim_get_current_buf())
            end
        end, { desc = "Move buffer to picked window" })

        -- Jump to picked window
        vim.keymap.set("n", "<leader>ww", function()
            local ok, picker = pcall(require, "window-picker")
            if not ok then
                return
            end
            local picked = picker.pick_window()
            if picked then
                vim.api.nvim_set_current_win(picked)
            end
        end, { desc = "Jump to picked window" })

        -- Close picked window
        vim.keymap.set("n", "<leader>wc", function()
            local window_picker = require("window-picker")
            local win_id = window_picker.pick_window()

            if win_id then
                vim.api.nvim_win_close(win_id, true)
            end
        end, { desc = "Close window with picker" })
        vim.keymap.set("n", "<leader>ws", function()
            local ok, picker = pcall(require, "window-picker")
            if not ok then
                return
            end

            local current_win = vim.api.nvim_get_current_win()
            local target_win = picker.pick_window()

            if not target_win or target_win == current_win then
                return
            end

            -- Get buffer numbers
            local current_buf = vim.api.nvim_win_get_buf(current_win)
            local target_buf = vim.api.nvim_win_get_buf(target_win)

            -- Swap them
            vim.api.nvim_win_set_buf(current_win, target_buf)
            vim.api.nvim_win_set_buf(target_win, current_buf)
        end, { desc = "Swap current buffer with picked window" })
    end,
}
