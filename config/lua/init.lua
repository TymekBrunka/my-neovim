vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("opts")

vim.keymap.set('n', '<A-h>', '<C-w>h', {})
vim.keymap.set('n', '<A-j>', '<C-w>j', {})
vim.keymap.set('n', '<A-k>', '<C-w>k', {})
vim.keymap.set('n', '<A-l>', '<C-w>l', {})
vim.keymap.set('n', '<A-q>', '<C-w>q', {})
vim.keymap.set('n', '<A-<>', '<C-w><', {})
vim.keymap.set('n', '<A->>', '<C-w>>', {})

local pinner = require("pinner")
pinner.setup()

vim.keymap.set("", "mm", function() pinner.pin() end, { desc = "Pin buffer" })
vim.keymap.set("", "mr", function() pinner.unpin_buf() end, { desc = "Pin buffer" })

for i = 1, 9 do
  vim.keymap.set("", string.format("<A-%d>", i), function() pinner.nav_to_pin(i) end,
    { desc = string.format("Navigate to pin #%d", i) })
end

local bufman = require("bufmanager")

vim.keymap.set("", "<leader>fr", function() bufman.toggle_centered_float() end, { desc = "Open buffer manager" })

require("lazy_nvim")
vim.opt.rtp:prepend(config_dir .. "/config") -- just in case i'd need to do something after loading plugins bc lazy_nvim seems to remove my custom runtimepath

-- local bufman = require("bufmanager")

require("language_servers")
