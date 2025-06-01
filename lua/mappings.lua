vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>")

vim.keymap.set("n", "<leader>p", "<CMD>:ProjectMgr<CR>")

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

require("tab-keybinds")
