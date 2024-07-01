vim.keymap.set("n", "<leader>e", function()
    vim.cmd("Neotree toggle")
end, {})

vim.keymap.set("n", "<leader>p", function()
    vim.cmd("ProjectMgr")
end, {})

vim.keymap.set("n", "<Leader><CR>",
    "<CMD>:W<CR>"
)

vim.keymap.set('n', '<A-h>', '<C-w>h', {})
vim.keymap.set('n', '<A-j>', '<C-w>j', {})
vim.keymap.set('n', '<A-k>', '<C-w>k', {})
vim.keymap.set('n', '<A-l>', '<C-w>l', {})
vim.keymap.set('n', '<A-q>', '<C-w>q', {})
vim.keymap.set('n', '<A-<>', '<C-w><', {})
vim.keymap.set('n', '<A->>', '<C-w>>', {})
