flash_drive_config = false
config_dir = vim.fn.expand('<sfile>:p:h')
vim.opt.rtp:prepend(config_dir .. "/config")
require("config")
