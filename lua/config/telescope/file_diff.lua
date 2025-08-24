-- File: lua/user/file_diff.lua
local M = {}

local function pick_file(prompt_title, callback)
    local ok, telescope = pcall(require, "telescope.builtin")
    if not ok then
        vim.notify("Telescope is not installed", vim.log.levels.ERROR)
        return
    end

    telescope.find_files({
        prompt_title = prompt_title,
        attach_mappings = function(_, map)
            map("i", "<CR>", function(bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(bufnr)
                callback(entry.path)
            end)
            return true
        end,
    })
end

function M.pick_and_diff()
    pick_file("Pick First File", function(file1)
        pick_file("Pick Second File", function(file2)
            if not file1 or not file2 then
                vim.notify("Both files must be selected", vim.log.levels.WARN)
                return
            end
            vim.cmd("tabnew " .. vim.fn.fnameescape(file1))
            vim.cmd("vert diffsplit " .. vim.fn.fnameescape(file2))
        end)
    end)
end

function M.exit()
    vim.cmd("windo diffoff")
end

return M
