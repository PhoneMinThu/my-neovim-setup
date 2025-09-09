local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

M.live_multigrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()
    opts.hidden = opts.hidden or false

    local prompt_title = "Multi Grep"

    if opts.hidden then
        prompt_title = prompt_title .. " [Hidden]"
    end

    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end

            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end

            if opts.hidden then
                table.insert(args, "-u")
                table.insert(args, "-u")
            end

            ---@diagnostic disable-next-line: deprecated
            return vim.tbl_flatten({
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            })
        end,

        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    pickers
        .new(opts, {
            debounce = 100,
            prompt_title = prompt_title,
            finder = finder,
            previewer = conf.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),

            -- 🔹 Live highlight hook
            on_input_filter_cb = function(prompt)
                local search_term = prompt:match("^%S+")
                if search_term and search_term ~= "" then
                    vim.fn.setreg("/", search_term)
                    vim.opt.hlsearch = true
                end
                return { prompt = prompt }
            end,
        })
        :find()
end

return M
