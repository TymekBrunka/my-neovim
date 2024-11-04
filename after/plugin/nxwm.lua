-- require 'nxwm'.setup
-- {
--     --What happens when a new x-window is created
--     on_win_open = function(buf, xwin)
--         vim.cmd.vsplit()
--         vim.api.nvim_set_current_buf(buf)
--     end,
--     --Configuration to pass to window
--     --`conf` is global config
--     on_win_get_conf = function(conf, xwin) return conf end,
--     --How to handle when multiple windows in the same tabpage has the x-window-buffer open
--     on_multiple_win_open = function(vwins, buf, xwin)
--         for k, vwin in ipairs(vwins) do
--             if k ~= 1 then
--                 local scratchbuf = vim.api.nvim_create_buf(false, true)
--                 vim.bo[scratchbuf].bufhidden = 'wipe'
--                 vim.api.nvim_win_set_buf(vwin, scratchbuf)
--             end
--         end
--     end,
--     --Whether to be more verbose
--     verbal = false,
--     --Whether to show float windows above x-windows (depending on z-index)
--     floatover = true,
--     --Map to unfocus a window (multiple key mappings is not (yet) supported)
--     unfocus_map = '<D-s>',
--     --Create your own mappings
--     --IMPORTANT: the x-window needs to be focused for such mappings to work
--     maps = {
--         -- {'<C-A-del>',function () vim.cmd'quitall!' end},
--         --Or you could also have lhs as a table
--         -- {{mods={'control','mod1'},key='Delete'},function () vim.cmd'quitall!' end},
--
--         -- {'<C-Q>',function () vim.cmd'quitall!' end},
--         -- {'<C-CR>',function () vim.fn.jobstart("alacritty") end},
--     },
--     --Window-opt: auto focus x-window when entering x-window-buffer
--     autofocus = false,
--     --Window-opt: try-delete x-window if no vim-window shows buffer (similar to `bufhidden=wipe`)
--     delhidden = true,
--     --Window-opt: when click on x-window, goto that buffer (may not focus x-window)
--     clickgoto = true,
--     --Window-opt: offset the window this many x pixels (useful if terminal has padding)
--     xoffset = 0,
--     --Window-opt: offset the window this many y pixels (useful if terminal has padding)
--     yoffset = 0,
-- }
--
-- local function tabbufmove(num)
--     local buf = vim.fn.bufnr()
--     local win = vim.api.nvim_get_current_win()
--     vim.cmd.tabnext(num)
--     -- vim.cmd.sbuf { buf, mods = { vertical = true } }
--     vim.cmd("vs")
--     vim.cmd("buffer "..buf)
--     vim.api.nvim_win_close(win, true)
-- end
--
-- local function makeTabIfNotExists(gex)
--     if vim.fn.tabpagenr('$') < gex then
--         for j = 1, gex - vim.fn.tabpagenr("$"), 1 do
--             vim.cmd("tabnew")
--         end
--     end
-- end
--
-- vim.keymap.set({ 't', 'n' }, "<D-CR>", function() vim.fn.jobstart("kitty") end)
-- vim.keymap.set({ 't', 'n' }, "<D-d>", function() vim.fn.jobstart("rofi -show drun") end)
-- vim.keymap.set({ 't', 'n' }, "<D-Q>", function() vim.cmd 'qa!' end)
-- for i = 1, 9, 1 do
--     vim.keymap.set({ 't', 'n' }, '<D-' .. i .. '>', function()
--         makeTabIfNotExists(i)
--         vim.cmd('tabn ' .. i)
--     end, {})
-- end
--
-- for k, i in ipairs({
--     '!',
--     '@',
--     '#',
--     '$',
--     '%',
--     '^',
--     '&',
--     '*',
--     '(',
--     ')',
-- }) do
--     --[ adds moving windows between tabs]
--     vim.keymap.set({ 't', 'n' }, '<S-D-' .. i .. '>', function()
--         makeTabIfNotExists(k)
--         tabbufmove(k)
--     end, {})
-- end
-- vim.keymap.set({ 't', 'n' }, '<D-Left>', '<C-w>h', {})
-- vim.keymap.set({ 't', 'n' }, '<D-Down>', '<C-w>j', {})
-- vim.keymap.set({ 't', 'n' }, '<D-Up>', '<C-w>k', {})
-- vim.keymap.set({ 't', 'n' }, '<D-Right>', '<C-w>l', {})
-- vim.keymap.set({ 't', 'n' }, '<D-q>', '<C-w>q', {})
-- vim.keymap.set({ 't', 'n' }, '<D-<>', '<C-w><', {})
-- vim.keymap.set({ 't', 'n' }, '<D->>', '<C-w>>', {})
