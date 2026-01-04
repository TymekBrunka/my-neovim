plug.install_many {
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        style = 'warmer'
      }
      require('onedark').load()
    end
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require('noice').setup {
        -- add any options here
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,                -- use a classic bottom cmdline for search
          command_palette = false,              -- position the cmdline and popupmenu together
          long_message_to_split = true,         -- long messages will be sent to a split
          inc_rename = false,                   -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,               -- add a border to hover docs and signature help
        },

        cmdline = {
          enabled = false,
        },
        messages = {
          enabled = false,
        }
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup()
    end
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
}
