local function tabbufmove(num)
    local buf = vim.fn.bufnr()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.tabnext(num)
    -- vim.cmd.sbuf { buf, mods = { vertical = true } }
    vim.cmd("vs")
    vim.cmd("buffer " .. buf)
    vim.api.nvim_win_close(win, true)
end

local function makeTabIfNotExists(gex)
    if vim.fn.tabpagenr('$') < gex then
        for j = 1, gex - vim.fn.tabpagenr(), 1 do
            vim.cmd("tabnew")
        end
    end
end

local current_tab = vim.fn.tabpagenr('$')

vim.keymap.set({ 't', 'n' }, '<C-Left>', function()
    if current_tab < 2 then return end
    current_tab = vim.fn.tabpagenr() - 1
    -- makeTabIfNotExists(current_tab)
    vim.cmd('tabn ' .. current_tab)
end, {})

vim.keymap.set({ 't', 'n' }, '<C-Right>', function()
    current_tab = vim.fn.tabpagenr() + 1
    makeTabIfNotExists(current_tab)
    vim.cmd('tabn ' .. current_tab)
end, {})

-- for current_tab, i in ipairs({
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
--[ adds moving windows between tabs]
vim.keymap.set({ 't', 'n' }, '<C-S-Left>', function()
    if current_tab < 2 then return end
    current_tab = vim.fn.tabpagenr() - 1
    -- makeTabIfNotExists(current_tab)
    tabbufmove(current_tab)
end, {})

vim.keymap.set({ 't', 'n' }, '<C-S-Right>', function()
    current_tab = vim.fn.tabpagenr() + 1
    makeTabIfNotExists(current_tab)
    tabbufmove(current_tab)
end, {})
