---@diagnostic disable: undefined-doc-name, undefined-global
return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,

    ---@type snacks.Config
    opts = {
        picker = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        scope = { enabled = true },
    },
    keys = {
        -- important
        { "<leader>/",  function() Snacks.picker.grep() end,                  desc = "Grep" },
        { "<leader>fl", function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
        { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
        { "grr",        function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
        { "<leader>sS", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
        { "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- utils
        { "<leader>:",  function() Snacks.picker.command_history() end,       desc = "Command History" },
        { '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,        desc = "Search History" },
        { "<leader>sC", function() Snacks.picker.commands() end,              desc = "Commands" },
        { "<leader>fh", function() Snacks.picker.help() end,                  desc = "Help Pages" },
        { "<leader>fk", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
    },
}
