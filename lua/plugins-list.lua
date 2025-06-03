return {
    --[colorschemes]
    require("plugins-lists.colorschemes"),
    require("plugins-lists.pickers"),
    --[real plugins]
    --[lsp]
    require("plugins-lists.lsp_etc"),
    require("plugins-lists.debugging"),
    require("plugins-lists.generic_must_haves"),
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    },
    -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    --[qol plugins]
    require("plugins-lists.code_editing"),
    require("plugins-lists.visuals"),
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    --[project manager]
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup()
            vim.keymap.set("", "<leader><leader>z", ":ZenMode<CR>", {})
        end,
    },
    -- {
    --     'AckslD/muren.nvim',
    --     config = function()
    --         require('muren').setup()
    --         vim.keymap.set("", ";", function()
    --             vim.cmd("MurenToggle")
    --         end, {})
    --     end,
    -- },
    {
        "AckslD/nvim-FeMaco.lua", --edit md codeblocks in floating window
        config = function()
            require("femaco").setup()
            vim.keymap.set("", "<C-e>", "<cmd>FeMaco<CR>", {})
        end,
    },
    "alec-gibson/nvim-tetris",
    --[ neorg ]--
    -- { 'altermo/nwm', branch = 'x11', opts = {} }, --nvim window manager
    -- "JamshedVesuna/vim-markdown-preview",
    -- {
    --     'kevinhwang91/nvim-ufo', --folding plugin
    --     dependencies = {
    --         'kevinhwang91/promise-async'
    --     }
    -- },
}
