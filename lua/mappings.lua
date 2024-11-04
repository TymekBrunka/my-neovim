vim.keymap.set("n", "<leader>e", function()
    vim.cmd("Neotree toggle")
end, {})

vim.keymap.set("n", "<leader>p", function()
    vim.cmd("ProjectMgr")
end, {})

vim.keymap.set("n", "<Leader><CR>",
    "<CMD>:W<CR>"
)

vim.keymap.set('n', '<A-Left>', '<C-w>h', {})
vim.keymap.set('n', '<A-Down>', '<C-w>j', {})
vim.keymap.set('n', '<A-Up>', '<C-w>k', {})
vim.keymap.set('n', '<A-Right>', '<C-w>l', {})
vim.keymap.set('n', '<A-q>', '<C-w>q', {})
vim.keymap.set('n', '<A-<>', '<C-w><', {})
vim.keymap.set('n', '<A->>', '<C-w>>', {})

local function tabbufmove(num)
    local buf = vim.fn.bufnr()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.tabnext(num)
    -- vim.cmd.sbuf { buf, mods = { vertical = true } }
    vim.cmd("vs")
    vim.cmd("buffer "..buf)
    vim.api.nvim_win_close(win, true)
end

local function makeTabIfNotExists(gex)
    if vim.fn.tabpagenr('$') < gex then
        for j = 1, gex - vim.fn.tabpagenr("$"), 1 do
            vim.cmd("tabnew")
        end
    end
end
for i = 1, 9, 1 do
    vim.keymap.set({ 't', 'n' }, '<A-a><A-' .. i ..'>', function()
        makeTabIfNotExists(i)
        vim.cmd('tabn ' .. i)
    end, {})
    vim.keymap.set({ 't', 'n' }, '<A-s><A-' .. i ..'>', function()
        makeTabIfNotExists(i)
        vim.cmd('tabn ' .. i)
    end, {})
end

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
for k = 1, 9, 1 do
    --[ adds moving windows between tabs]
    vim.keymap.set({ 't', 'n' }, '<A-A><A-S-' .. k .. '>', function()
        makeTabIfNotExists(k)
        tabbufmove(k)
    end, {})
    vim.keymap.set({ 't', 'n' }, '<A-S><A-S-' .. k .. '>', function()
        makeTabIfNotExists(k)
        tabbufmove(k)
    end, {})
end
