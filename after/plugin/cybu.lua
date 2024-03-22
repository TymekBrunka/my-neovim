local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end
cybu.setup({
    position = {
        relative_to = "win",          -- win, editor, cursor
        anchor = "topcenter",         -- topleft, topcenter, topright,
                                    -- centerleft, center, centerright,
                                    -- bottomleft, bottomcenter, bottomright
        vertical_offset = 1,         -- vertical offset from anchor in lines
        horizontal_offset = 0,        -- vertical offset from anchor in columns
        max_win_height = 5,           -- height of cybu window in lines
        max_win_width = 0.8,          -- integer for absolute in columns
    },
    style = {
        border = "rounded",
        hide_buffer_id = false,
        highlights = {                -- see highlights via :highlight
            current_buffer = "TablineSel",       -- current / selected buffer
            adjacent_buffers = "Tabline",  -- buffers not in focus
            background = "CybuBackground",      -- window background
            border = "CybuBorder",              -- border of the window
        },
    }
})
vim.keymap.set("n", "<S-Up>", "<Plug>(CybuPrev)")
vim.keymap.set("n", "<S-Down>", "<Plug>(CybuNext)")
vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
vim.keymap.set({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")