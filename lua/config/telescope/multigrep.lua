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

			local args = { "rg" }

			if opts.hidden then
				table.insert(args, "-u")
				table.insert(args, "-u")
			end

			-- Extract search term
			local search_term = prompt:match("^%S+")
			if search_term then
				table.insert(args, search_term)
			end

			-- Extract --include list
			local include_raw = prompt:match("%-%-include=%[(.-)%]")
			if include_raw then
				for _, pat in ipairs(vim.split(include_raw, ",")) do
					pat = vim.trim(pat)
					if pat ~= "" then
						table.insert(args, "-g")
						table.insert(args, pat)
					end
				end
			end

			-- Extract --exclude list
			local exclude_raw = prompt:match("%-%-exclude=%[(.-)%]")
			if exclude_raw then
				for _, pat in ipairs(vim.split(exclude_raw, ",")) do
					pat = vim.trim(pat)
					if pat ~= "" then
						table.insert(args, "-g")
						table.insert(args, "!" .. pat)
					end
				end
			end

			-- Add ripgrep flags
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
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
