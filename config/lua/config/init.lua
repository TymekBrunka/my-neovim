vim.g.mapleader = " "
require("config.opts")
require("config.navigation_keybinds")
require("config.plug")
plug.install("dstein64/vim-startuptime") --for diagnostics
require("config.visuals")
require("config.editor_support")
require("config.rainbow_delimiters")
require("config.neotree")
require("config.text_editing")
require("config.lsp")
require("config.debugging")
