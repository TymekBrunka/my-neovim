function vm_active()
    return not(( vim.b.VM_Selection == vim.empty_dict() ) or ( vim.b.VM_Selection == nil ) or ( next(vim.b.VM_Selection) == nil ))
end

-- function fmt_vm_active()
--     if vm_active() then
--         return ""
--     else
--         return ""
--     end
-- end

function vvmulti()
    if vm_active() then
        local vminfo = vim.api.nvim_call_function('VMInfos', {})
        return "" .. " " .. vminfo["status"] .. " " .. vminfo["ratio"]
    else
        return ""
    end
end

--disable vim-visual-multi statusline rendering for no flickering
vim.cmd("\
let g:VM_set_statusline = 2\
")

require('lualine').setup {
    options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
        statusline = {},
        winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
    }
    },
    sections = {
    lualine_a = {
        {'mode', separator = ""},
        {vvmulti}
    },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
    },
    inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
