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
    {
        "ggandor/leap.nvim", --plugin for jumping in code
        config = function()
            -- require('leap').create_default_mappings()
            vim.keymap.set('', 's', '<Plug>(leap)')
            -- vim.keymap.set('', 'S', '<Plug>(leap-from-window)')
            vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
            vim.api.nvim_set_hl(0, 'LeapMatch', {
                -- For light themes, set to 'black' or similar.
                fg = '#aaaadd',
                bold = true,
                nocombine = true,
            })

            vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
                fg = '#a6d18a', bold = true, nocombine = true,
            })
            vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
                fg = '#8ad1a6', bold = true, nocombine = true,
            })
            -- Try it without this setting first, you might find you don't even miss it.
            require('leap').opts.highlight_unlabeled_phase_one_targets = true
        end
    },
}
