local custom_config_path = vim.fn.expand('<sfile>:p:h')
-- vim.g.config_folder = custom_config_path
vim.o.runtimepath = custom_config_path .. ',' .. vim.o.runtimepath
vim.g.lazy_plugins_path = custom_config_path .. "/lazy_plugins"
local conf = custom_config_path .. "/lazy_plugins"
print(conf)

require("lazy").setup({
    root = conf,
    spec = {
        { import = "plugins-list" },
    },
})
