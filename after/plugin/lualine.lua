function vm_active()
    return not ((vim.b.VM_Selection == vim.empty_dict()) or (vim.b.VM_Selection == nil) or (next(vim.b.VM_Selection) == nil))
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
        return "" .. vminfo["status"] .. " " .. vminfo["ratio"]
    else
        return ""
    end
end

--disable vim-visual-multi statusline rendering for no flickering
vim.cmd("\
let g:VM_set_statusline = 2\
")

local colors = {
    bg       = '#232A2E',
    bg1      = '#343F44',
    grey2    = '#9DA9A0',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#A7C080',
    orange   = '#E69875',
    violet   = '#D699B6',
    magenta  = '#c678dd',
    blue     = '#7FBBB3',
    red      = '#E67E80',
    red_dim  = '#514045',
}

function separate()
    return "|"
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = {
            normal = { a = { fg = colors.red, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
            insert = { a = { fg = colors.green, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
            visual = { a = { fg = colors.violet, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
            inactive = { a = { fg = colors.bg, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
            replace = { a = { fg = colors.orange, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
            command = { a = { fg = colors.yellow, bg = colors.bg }, b = { bg = colors.red_dim }, c = { bg = colors.bg1, fg = colors.grey2 } },
        },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
            {
                function()
                    return '▊'
                end,
                color = { fg = colors.blue },      -- Sets highlighting of component
                padding = { left = 0, right = 0 }, -- We don't need space before this
            },
            {
                function()
                    return ''
                end,
                -- color = { fg = colors.magenta },
            },
            {
                'mode',
                padding = { left = 0, right = 2 }, -- We don't need space before this
            },
            { vvmulti },
            -- { separate, color = { fg = colors.fg }, padding = { left = 0, right = 0 } }
        },
        lualine_b = {
            {
                'branch',
                color = { fg = colors.violet }
            },
            { separate, color = { fg = colors.fg }, padding = { left = 0, right = 0 } },
            'diff',
            { separate, color = { fg = colors.fg }, padding = { left = 0, right = 0 } },
            'diagnostics'
        },
        lualine_c = { 'filename' },
        lualine_x = {
            'encoding',
            { separate, color = { fg = colors.fg }, padding = { left = 0, right = 0 } },
            'fileformat',
            { separate, color = { fg = colors.fg }, padding = { left = 0, right = 0 } },
            'filetype'
        },
        lualine_y = {
            {
                'progress',
                color = { fg = colors.blue, bg = colors.bg }
            }
        },
        lualine_z = {
            {
                'location',
                color = { fg = colors.green, bg = colors.bg }
            }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
