return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
            'rafi/neoconf-venom.nvim',
        },
        config = function(_, opts)
            require('venom').setup()
        end,
    },
    {
        'rafi/neoconf-venom.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'folke/neoconf.nvim' },
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = 'none',

                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<Tab>'] = { 'select_and_accept', 'fallback' },

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = true }
            },
            signature = { enabled = true },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    'exact',
                    -- defaults
                    'score',
                    'sort_text',
                },
            }
        },
        opts_extend = { "sources.default" }
    },
    'folke/neodev.nvim', -- new
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup()
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

                vim.keymap.set('t', '<C-x>', [[<Cmd>ToggleTerm<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
            vim.keymap.set('', '<C-x>', function()
                vim.cmd("ToggleTerm")
            end, {})
        end,
    },
}
