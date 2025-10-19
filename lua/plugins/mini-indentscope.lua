return {
    "echasnovski/mini.indentscope",
    dependencies = {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│", highlight = "IblIndent" },
            scope = { enabled = true },
        },
    },
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local indentscope = require("mini.indentscope")

        indentscope.setup({
            draw = {
                delay = 100,
                animation = indentscope.gen_animation.quadratic({
                    easing = "out",
                    duration = 20,
                    unit = "step",
                }),
                priority = 2,
            },
            mappings = {
                object_scope = "ii",
                object_scope_with_border = "ai",
                goto_top = "[i",
                goto_bottom = "]i",
            },
            options = {
                border = "both",
                indent_at_cursor = true,
                try_as_border = true,
            },
            symbol = "│",
        })

        -- Disable in special buffers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "dashboard",
                "snacks_dashboard",
                "lazy",
                "mason",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
}
