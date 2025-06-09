return {
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
    { "lukas-reineke/indent-blankline.nvim",      main = "ibl",  opts = {} },
    -- {
    --     'tzachar/local-highlight.nvim',
    --     config = function()
    --         require('local-highlight').setup()
    --     end
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
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = false,      -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },

            cmdline = {
                enabled = false,
            },
            messages = {
                enabled = false,
            }
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
    {
        'nacro90/numb.nvim',
        config = function()
            require('numb').setup()
        end,
    },
    "lewis6991/gitsigns.nvim",
}
