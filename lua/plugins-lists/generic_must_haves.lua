return {
    "folke/which-key.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'vim', 'vimdoc', 'lua', 'cpp', 'c', 'markdown', 'html', 'css', 'javascript' },
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            }
        end
    },
}
