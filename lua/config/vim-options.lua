vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.smartindent = true
vim.opt.autoindent = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- line, column
vim.opt.cursorline = true

-- -- encoding
-- vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"

-- learder
vim.g.mapleader = " "

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 99 -- prevents folds from being closed by default

-- Terminal and color settings for bold text support
vim.opt.termguicolors = true
