return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = config_dir .. "/treesitter/site",
        ensure_installed = { "markdown", "html", "css" },
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })

      vim.api.nvim_create_autocmd("FileType", {
        -- pattern = { '*' },
        pattern = { "*" }, --adds small delay when loading filetype with installed parser (either bc of fetching or )
        callback = function(args)
          pcall(function()
            vim.treesitter.start(args.buf)
          end)
          vim.bo[args.buf].syntax = "ON" -- only if additional legacy syntax is needed
        end,
      })
    end,
  },
}
