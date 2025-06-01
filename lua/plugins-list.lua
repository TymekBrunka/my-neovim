return {
    --[colorschemes]
    require("plugins-lists.colorschemes"),
    --[real plugins]
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
    --[lsp]
    require("plugins-lists.lsp_etc"),
    require("plugins-lists.generic_must_haves"),
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    --[qol plugins]
    {
        "mg979/vim-visual-multi" --if removed, lualine wont work bc i made it depend on it in after/plugins/lualine.lua
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
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup {
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,          -- #RGB hex codes
                    RRGGBB = true,       -- #RRGGBB hex codes
                    names = true,        -- "Name" codes like Blue or blue
                    RRGGBBAA = true,     -- #RRGGBBAA hex codes
                    AARRGGBB = true,     -- 0xAARRGGBB hex codes
                    rgb_fn = true,       -- CSS rgb() and rgba() functions
                    hsl_fn = true,       -- CSS hsl() and hsla() functions
                    css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false,                                -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            }
        end
    },
    "HiPhish/rainbow-delimiters.nvim",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local bufferline = require('bufferline');
            require("bufferline").setup {
                options = {
                    style_preset = {
                        -- bufferline.style_preset.minimal,
                        bufferline.style_preset.no_bold,
                    },
                    -- tab_size = 16,
                    mode = "tabs",
                    separator_style = "slant",
                    enforce_regular_tabs = true,
                    offsets = {
                        filetype = "neo-tree",
                    },
                    numbers = function(opts)
                        return string.format('%s', opts.ordinal)
                    end,
                },
            }
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    { "lukas-reineke/indent-blankline.nvim",      main = "ibl",  opts = {} },
    --[project manager]
    {
        'charludo/projectmgr.nvim',
        lazy = false, -- important!
    },
    --[buffer quickswitch]
    {
        "ghillb/cybu.nvim",                                                    --buffer quick switch
        branch = "main",                                                       -- timely updates
        -- branch = "v1.x", -- won't receive breaking changes
        requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    },
    {
        'tzachar/local-highlight.nvim',
        config = function()
            require('local-highlight').setup()
        end
    },
    --[SUStech overpowered selection manager]
    --enter to increase selection and backspace to decrease
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
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
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup()
            vim.keymap.set("", "<leader><leader>z", ":ZenMode<CR>", {})
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "cshuaimin/ssr.nvim", --select and replace with variables and multiline support
        module = "ssr",
        -- Calling setup is optional.
        config = function()
            require("ssr").setup {
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                },
            }
            vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
        end
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
    {
        "j-morano/buffer_manager.nvim",
        config = function()
            require("buffer_manager").setup({
                -- highlight = 'TabLineSel:BufferManagerBorder',
                -- win_extra_options = {
                --     winhighlight = 'TabLine:BufferManagerNormal',
                -- },
            })
            vim.keymap.set("", "<A-c>", function()
                require("buffer_manager.ui").toggle_quick_menu()
            end, {})

            local bmui = require("buffer_manager.ui")
            local keys = '1234567890'
            for i = 1, #keys do
                local key = keys:sub(i, i)
                vim.keymap.set(
                    '',
                    string.format('<A-%s>', key),
                    function() bmui.nav_file(i) end,
                    { noremap = true }
                )
            end
        end,
    },
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
    {
        'arnamak/stay-centered.nvim',
        opts = {
            -- The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:
            -- :lua print(vim.bo.filetype)
            skip_filetypes = {},
            -- Set to false to disable by default
            enabled = true,
            -- allows scrolling to move the cursor without centering, default recommended
            allow_scroll_move = true,
            -- temporarily disables plugin on left-mouse down, allows natural mouse selection
            -- try disabling if plugin causes lag, function uses vim.on_key
            disable_on_mouse = true,
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                -- command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
}
