return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
    --[buffer quickswitch]
    {
        "ghillb/cybu.nvim",                                                    --buffer quick switch
        branch = "main",                                                       -- timely updates
        -- branch = "v1.x", -- won't receive breaking changes
        requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
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
        'charludo/projectmgr.nvim',
        lazy = false, -- important!
    },
}
