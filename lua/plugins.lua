require("lazy").setup({
	--[colorschemes]
	"sainnhe/sonokai",
	"ellisonleao/gruvbox.nvim",
	"navarasu/onedark.nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin"
	},
	--[real plugins]
	"folke/which-key.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		  	"nvim-lua/plenary.nvim",
		  	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		  	"MunifTanjim/nui.nvim",-- Optional image support in preview window: See `# Preview Mo
		},
	},
	--[lsp]
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
	'folke/neodev.nvim', -- new
	--[code completion]
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            
            'hrsh7th/cmp-nvim-lsp',
            
        },
    },
	--[other must haves]
	{ 'numToStr/Comment.nvim', opts = {} },
	{
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
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
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' } 
    },
	{
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
	--[qol plugins]
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*",  -- Use the latest tagged version
		opts = {},  -- This causes the plugin setup function to be called
		keys = {
			{"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
			{"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>"},
			{"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
			{"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>"},
			{"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
			{"<Leader>a", "<Cmd>MultipleCursorsAddBySearch<CR>", mode = {"n", "x"}},
			{"<Leader>A", "<Cmd>MultipleCursorsAddBySearchV<CR>", mode = {"n", "x"}},
		},
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
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = true, -- "Name" codes like Blue or blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false, -- Enable tailwind colors
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
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	--[project manager]
	{
		'charludo/projectmgr.nvim',
		lazy = false, -- important!
	},
	--[buffer quickswitch]
	{
		"ghillb/cybu.nvim",
		branch = "main", -- timely updates
		-- branch = "v1.x", -- won't receive breaking changes
		requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"}, -- optional for icon support
	},
	{
		'tzachar/local-highlight.nvim',
		config = function()
		  	require('local-highlight').setup()
		end
	},
		--[SUStech overpowered selection manager]
		{
			"sustech-data/wildfire.nvim",
			event = "VeryLazy",
			dependencies = { "nvim-treesitter/nvim-treesitter"},
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
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup()
			vim.keymap.set("", "<leader>zz", ":TZAtaraxis<CR>", {})
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
		  	"nvim-lua/plenary.nvim",
		},
  	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"sidebar-nvim/sidebar.nvim",
		opts = {
			sections = { "datetime", "buffers", "git", "diagnostics" },
		}
	},
	--[modern which-key]
	{
		"Cassin01/wf.nvim",
		config = function()
			require("wf").setup()
		end,
	},
	{
		"cshuaimin/ssr.nvim",
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
	"sindrets/winshift.nvim",
	{
		'AckslD/muren.nvim',
		config = function()
			require('muren').setup()
			vim.keymap.set("", ";", function()
				vim.cmd("MurenToggle")
			end, {})
		end,
	},
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup()
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

                vim.keymap.set('t', '<C-`>', [[<Cmd>ToggleTerm<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
            vim.keymap.set('', '<C-`>', function()
                vim.cmd("ToggleTerm")
            end, {})
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            -- require('leap').create_default_mappings()
            vim.keymap.set('', 's', '<Plug>(leap)')
            vim.keymap.set('', 'S', '<Plug>(leap-from-window)')
            vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
            vim.api.nvim_set_hl(0, 'LeapMatch', {
              -- For light themes, set to 'black' or similar.
              fg = '#aaaadd', bold = true, nocombine = true,
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
    }
})
