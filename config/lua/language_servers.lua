local function def_lsp(name)
  vim.lsp.config[name] = require("lsp." .. name)
  vim.lsp.enable({ name })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end
vim.lsp.config("*", {
  capabilities = capabilities,
})

def_lsp("clangd")
def_lsp("lua_ls")

vim.keymap.set("", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("", "K", vim.lsp.buf.hover, { desc = "(hover)" })
vim.keymap.set("", "<leader>ff", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })
