return {
  {
    "navarasu/onedark.nvim",
    priority = 5555,
    config = function()
      require("onedark").setup({
        style = "warmer",
      })
      require("onedark").load()
    end,
  },
}
