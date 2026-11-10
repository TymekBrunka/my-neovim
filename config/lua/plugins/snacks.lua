return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      terminal = {
        enabled = false,
        win = { style = "terminal" },
      },
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = {
        enabled = false,
        win = {
          list = {
            keys = {
              ["<BS>"] = "explorer_up",
              ["l"] = "confirm",
              ["h"] = "explorer_close", -- close directory
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open", -- open with system application
              ["P"] = "toggle_preview",
              ["y"] = { "explorer_yank", mode = { "n", "x" } },
              ["p"] = "explorer_paste",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["<leader>/"] = "picker_grep",
              ["<c-t>"] = "terminal",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
              ["]g"] = "explorer_git_next",
              ["[g"] = "explorer_git_prev",
              ["]d"] = "explorer_diagnostic_next",
              ["[d"] = "explorer_diagnostic_prev",
              ["]w"] = "explorer_warn_next",
              ["[w"] = "explorer_warn_prev",
              ["]e"] = "explorer_error_next",
              ["[e"] = "explorer_error_prev",
            },
          },
        },
      },
      indent = {
        enabled = true,
        animate = {
          enabled = false
        }
      },
      input = { enabled = false },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        mode = { "n", "t" },
        desc = "Toggle Terminal"
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File tree",
      },
      {
        "<leader>f/",
        function()
          Snacks.picker.files()
        end,
        desc = "File picker",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.lines()
        end,
        desc = "Search in file",
      },
      {
        "<leader>fi",
        function()
          Snacks.picker.icons()
        end,
        desc = "Pick icon",
      },
      {
        "gi",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Open jump list picker",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Notifs", function()
        Snacks.picker.notifications()
      end, { desc = "Show Notifications" })

      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "VeryLazy",
      --   callback = function()
      --     -- Setup some globals for debugging (lazy-loaded)
      --     _G.dd = function(...)
      --       Snacks.debug.inspect(...)
      --     end
      --     _G.bt = function()
      --       Snacks.debug.backtrace()
      --     end
      --
      --     -- Override print to use snacks for `:=` command
      --     if vim.fn.has("nvim-0.11") == 1 then
      --       vim._print = function(_, ...)
      --         dd(...)
      --       end
      --     else
      --       vim.print = _G.dd
      --     end
      --   end,
      -- })
    end,
  },
}
