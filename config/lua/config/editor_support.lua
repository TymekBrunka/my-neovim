plug.install_many {
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },
  {
    "folke/which-key.nvim",
    -- config = function()
    --     vim.keymap.set("", "<leader><CR>", "<CMD>:W<CR>")
    -- end
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require("todo-comments")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      todo_comments.setup()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup {
        indent = { char = "󰞘", },
        -- scope = {
        --     highlight = highlight
        -- }
      }
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
      vim.keymap.set('', '<C-x>', '<CMD>ToggleTerm direction=float<CR>', {
        desc = "ToggleTerm"
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local tsconfig = require('nvim-treesitter.config')
      tsconfig.setup {
        install_dir = config_dir .. '/parsers',
        ensure_installed = { 'vim', 'vimdoc', 'lua', 'cpp', 'c', 'markdown', 'html', 'css', 'javascript' },
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }

      vim.api.nvim_create_autocmd('FileType', {
        -- pattern = { '*' },
        pattern = { '*' }, --adds small delay when loading filetype with installed parser (either bc of fetching or )
        callback = function(args)
          pcall(function()
            vim.treesitter.start(args.buf)
          end)
          vim.bo[args.buf].syntax = 'ON' -- only if additional legacy syntax is needed
        end,
      })
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
      }
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- config is in separate file
      vim.keymap.set("n", "<leader>e", "<CMD>:Neotree toggle<CR>", {
        desc = "Toggle file tree"
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set("", "<C-s>", "<CMD>:Telescope find_files<CR>", {
        desc = "Find files"
      })
      vim.keymap.set("", "<leader>d", "<CMD>:Telescope buffers<CR>", {
        desc = "Buffer selector"
      })
    end,
  },
  {
    "charludo/projectmgr.nvim",
    config = function()
      vim.keymap.set("n", "<leader>p", "<CMD>:ProjectMgr<CR>", {
        desc = "Open project manager"
      })
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
