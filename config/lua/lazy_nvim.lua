-- Bootstrap lazy.nvim
local lazypath = config_dir .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  root = config_dir .. "/plugins-list",
  lockfile = config_dir .. "/lazy_lock.json",
  state = config_dir .. "/lazy/lazy_state.json",
  rocks = {
    root = config_dir .. "/plugins-rocks",
  },

  spec = {
    require("plugins.onedark"),
    require("plugins.snacks"),
    require("plugins.nvim-treesitter"),
    require("plugins.workspaces"),
    require("plugins.todo-comments"),
    require("plugins.lazydev"),
    require("plugins.blink_cmp"),
    require("plugins.trouble"),
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    {
      'Wansmer/treesj',
      keys = { '<space>m', '<space>j', '<space>s' },
      dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
      config = function()
        require('treesj').setup({ --[[ your config ]] })
      end,
    },
    {
      "kylechui/nvim-surround",
      version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
      -- config = function()
      --     require("nvim-surround").setup({
      --         -- Put your configuration here
      --     })
      -- end
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
    "mg979/vim-visual-multi",
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
