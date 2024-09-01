vim.keymap.set("", "<leader>nn", "<CMD>:Neorg keybind norg core.dirman.new.note<CR>")
vim.keymap.set("", "<leader>nt", "<CMD>:Neorg tangle current-file<CR>")
vim.keymap.set("", "<leader><leader>n", "<CMD>:Neorg keybind norg core.integrations.telescope.find_norg_files<CR>")
vim.keymap.set("", "<leader>nb", "<CMD>:Neorg keybind norg core.integrations.telescope.find_backlinks<CR>")
vim.keymap.set("", "<leader>nm", "<CMD>:ZenMode<CR><CMD>:Neorg presenter start<CR>")
-- vim.keymap.set("", "<leader>nb", "<CMD>:Neorg export to-file ~/neorg-previewer.md<CR><CMD>:vs ~/neorg-previewer.md<CR><CMD>:MarkdownPreview<CR><C-w>h<C-w>|<C-w>l") --open norg preview with md preview tool
vim.keymap.set("", "<leader>x", "<CMD>:Neorg exec cursor<CR>")

function compile_norg_and_create_autocmd(opt)
    if opt == "file" then
        vim.cmd("Neorg export to-file ~/neorg-previewer.md")
    else
        vim.cmd("Neorg export directory " ..
            vim.fn.expand("~/") .. "notes markdown " .. vim.fn.expand("~/") .. "/notes/exported-to-prew/")
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local bufwinid = vim.api.nvim_get_current_win()
    if opt == "file" then
        vim.cmd("vsplit ~/neorg-previewer.md")
    else
        vim.cmd("vsplit ~/notes/exported-to-prew/" .. vim.fn.expand("%:t:r") .. ".md")
    end
    vim.cmd("MarkdownPreview")
    local winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(winid, 0) -- Set width to 80 columns
    -- vim.api.nvim_win_set_height(winid, 0)  -- Set height to 20 rows

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        callback = function()
            if vim.api.nvim_win_is_valid(winid) and vim.api.nvim_win_is_valid(bufwinid) then
                if opt == "file" then
                    vim.cmd("Neorg export to-file ~/neorg-previewer.md")
                else
                    vim.cmd("Neorg export directory " ..
                        vim.fn.expand("~/") .. "notes markdown " .. vim.fn.expand("~/") .. "/notes/exported-to-prew/")
                end
                vim.api.nvim_set_current_win(winid)
                vim.cmd("e")
                vim.api.nvim_win_set_cursor(winid, { 1, 1 })
                -- vim.api.nvim_input('j') --tried to make it seem for window that im editing
                vim.api.nvim_win_set_width(winid, 0) -- Set width to 80 columns
                vim.api.nvim_set_current_win(bufwinid)
            else
                vim.api.nvim_exec("autocmd! BufWritePost <buffer=" .. bufnr .. ">", true)
            end
        end,
    })
end

vim.keymap.set('', '<leader>cc', function()
    compile_norg_and_create_autocmd("file")
end, {})
-- vim.keymap.set('', '<leader>c', function()
--     vim.cmd("Neorg export to-file ~/neorg-previewer.md")
--
--     local bufnr = vim.api.nvim_get_current_buf()
--     vim.cmd("badd ~/neorg-previewer.md")
--     vim.cmd("b ~/neorg-previewer.md")
--     local prewbufnr = vim.api.nvim_get_current_buf()
--     vim.fn['Vim_Markdown_Preview']()
--     -- vim.api.nvim_win_set_height(winid, 0)  -- Set height to 20 rows
--
--     vim.api.nvim_create_autocmd("BufWritePost", {
--         buffer = bufnr,
--         callback = function()
--             if vim.api.nvim_buf_is_valid(prewbufnr) then
--                 vim.cmd("Neorg export to-file ~/neorg-previewer.md")
--                 vim.cmd("b " .. prewbufnr)
--                 vim.cmd("e")
--                 vim.fn['Vim_Markdown_Preview_Local']()
--                 vim.cmd("b " .. bufnr)
--             else
--                 vim.api.nvim_exec("autocmd! BufWritePost <buffer=" .. bufnr .. ">", true)
--             end
--         end,
--     })
-- end, {})

local neorg_callbacks = require("neorg.core.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)
