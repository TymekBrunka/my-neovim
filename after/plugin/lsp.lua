require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "css-lsp", "tsserver", "html", "pyright", "clangd" }
})

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

function MasonLspPackages() --get all mason lsp's and return config for every single one of them
    -- local registry = require("mason-registry")
    local servers = require("mason-lspconfig").get_installed_servers()
    local lsp = {}
    for _, ls in pairs(servers) do
        lsp[ls] = function()
            require("lspconfig")[ls].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    end
    return lsp
end

local lsp = {

    ["lua_ls"] = function()
        require('neodev').setup({
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            lspconfig = true,
            setup_jsonls = true,
        })
        require("lspconfig").lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            }
        }
    end,

    ["tsserver"] = function()
        require("lspconfig")["tsserver"].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function() return vim.loop.cwd() end
        }
    end,

    --Civitasv/cmake-tools.nvim required and this is setup for clangd + cmake
    ["clangd"] = function()
        require("lspconfig").clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function() return vim.loop.cwd() end,

            settings = {
                clangd = {
                    indentSize = 4,
                    indentWidth = 4,
                    tabSize = 4,
                }
            },

            on_new_config = function(new_config, new_cwd)
                local status, cmake = pcall(require, "cmake-tools")
                if status then
                    cmake.clangd_on_new_config(new_config)
                end
            end,
        }
    end,
}

local lsps = MasonLspPackages()
for k, v in pairs(lsp) do --merge lsp table and lsp autoconfig
    -- print(k)
    lsps[k] = v
end


for k, v in pairs(lsps) do --merge lsp table and lsp autoconfig
    -- print("lsp: " .. k)
end

require("mason-lspconfig").setup_handlers(lsps) --setup lsp's
