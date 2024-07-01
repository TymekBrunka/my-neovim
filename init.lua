vim.g.mapleader = " "
--[ Lazy.nvim ]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local custom_config_path = vim.fn.expand('<sfile>:p:h')
vim.o.runtimepath = custom_config_path .. ',' .. vim.o.runtimepath

local lazypath = custom_config_path .. "/lazy"
-- local lazypath = "~/.config/nvim/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
require("mappings")
require("opts")
