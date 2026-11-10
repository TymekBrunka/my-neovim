return {
  {
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup({
        path = vim.fn.stdpath("data") .. "/workspaces",
      })
    end,
  },
}
