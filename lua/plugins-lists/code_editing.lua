return {
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
}
