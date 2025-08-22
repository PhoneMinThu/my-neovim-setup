return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          [[
█▀█ █░█ █▀█ █▄░█ █▀▀   █▀▄▀█ ▀█▀
█▀▀ █▀█ █▄█ █░▀█ ██▄   █░▀░█ ░█░
          ]],
          [[╭─────────────────╮]],
          [[│ ╔═══╗     ╔═══╗ │]],
          [[│ ║   ║─────║   ║ │]],
          [[│ ╚═══╝     ╚═══╝ │]],
          [[│   │        │   │]],
          [[│ ╔═══╗     ╔═══╗ │]],
          [[│ ║\\\║─────║   ║ │]],
          [[│ ╚═══╝     ╚═══╝ │]],
          [[╰─────────────────╯]],
          [[                   ]],
        }, "\n"),
      },
      sections = {
        -- System Stats
        {
          section = "header",
        },
        -- Other sections
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
      },
    },
    bigfile = { enabled = true },
    explorer = { enabled = true },
    rename = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>no",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },

    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "grr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        -- Enhanced LSP symbols picker that auto-selects the current symbol
        local current_line = vim.api.nvim_win_get_cursor(0)[1]

        local picker = Snacks.picker.lsp_symbols({
          -- Custom callback to position cursor at nearest symbol after finder loads
          on_show = function(self)
            -- Use vim.defer_fn to ensure the finder has loaded the items
            vim.defer_fn(function()
              -- Safety checks
              if not self or not self.list then
                return
              end

              local items = self.list.items or {}
              if #items == 0 then
                return
              end

              -- Find closest symbol to current cursor position
              local closest_idx = 1
              local min_distance = math.huge

              for i, item in ipairs(items) do
                -- LSP symbols have line number in various fields
                local item_line = item.lnum
                  or (item.pos and item.pos[1])
                  or (item.location and item.location.range and item.location.range.start.line + 1)
                if item_line then
                  local distance = math.abs(item_line - current_line)
                  if distance < min_distance then
                    min_distance = distance
                    closest_idx = i
                  end
                end
              end

              -- Move to the closest symbol (absolute positioning, with rendering)
              if self.list.move then
                self.list:move(closest_idx, true, true)
              end
            end, 100) -- Increased delay to ensure items are fully loaded
          end,
        })

        return picker
      end,
      desc = "LSP Symbols (Auto-positioned)",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },

    -- Other
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
      mode = { "n", "v" },
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>tt",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },

    -- Search
    {
      "<leader>ff",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffers lines",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,

  dependencies = {
    "nvim-web-devicons",
  },
}
