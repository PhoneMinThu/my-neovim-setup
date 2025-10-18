return {
  {
    "echasnovski/mini.indentscope",
    version = false, -- Use main branch for latest features
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        -- Draw options
        draw = {
          -- Delay (in ms) between event and start of drawing scope indicator
          delay = 100,

          -- Animation rule for scope's first drawing. A function which, given
          -- next and total step numbers, returns wait time (in ms). See
          -- |MiniIndentscope.gen_animation| for builtin options. To disable
          -- animation, use `require('mini.indentscope').gen_animation.none()`.
          animation = require("mini.indentscope").gen_animation.linear({
            easing = "out",
            duration = 50,
            unit = "total",
          }),

          -- Symbol priority. Increase to display on top of more symbols.
          priority = 2,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = "ii",
          object_scope_with_border = "ai",

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = "[i",
          goto_bottom = "]i",
        },

        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller
          -- indent to categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = "both",

          -- Whether to use cursor column when computing reference
          -- indent. Useful to see incremental scopes with aligned code.
          indent_at_cursor = false,

          -- Try to compute scope based on locals instead of
          -- whitespace. Can be helpful in languages with meaningful whitespace.
          try_as_border = true,
        },

        -- Which character to use for drawing scope indicator
        symbol = "|",
      })
    end,
  },
}
