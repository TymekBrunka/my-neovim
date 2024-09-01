require('lspconfig.configs').c3 = {
    default_config = {
        cmd = { "c3-lsp" },
        filetypes = { 'c3' },
        root_dir = require('lspconfig').util.root_pattern("go.mod"),
        settings = {},
    },
}

require("lspconfig").c3.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function() return vim.loop.cwd() end
}
