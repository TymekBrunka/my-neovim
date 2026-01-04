plug.install_many {
  {
    "mg979/vim-visual-multi"     --if removed, lualine wont work bc i made it depend on it in after/plugins/lualine.lua
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        map_cr = true
      }
    end
  },
  {
    "sustech-data/wildfire.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup({
        surrounds = {
          { "(", ")" },
          { "{", "}" },
          { "<", ">" },
          { "[", "]" },
        },
        -- keymaps = {
        -- 	init_selection = "<CR>",
        -- 	node_incremental = "<CR>",
        -- 	node_decremental = "<BS>",
        -- },
        -- filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
      })
    end,
  },
}
