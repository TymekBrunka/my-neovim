local highlights = require("neo-tree.ui.highlights")

require("neo-tree").setup({
    filesystem = {
        -- filtered_items = {
        --     always_show_by_pattern = { "." }
        -- },
        window = {
            mappings = {
                ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            }
        },
        components = {
            icon = function(config, node, state)
                local icon = config.default or " "
                local padding = config.padding or " "
                local highlight = config.highlight or highlights.FILE_ICON

                local success, web_devicons = pcall(require, "nvim-web-devicons")
                local _, luahl = web_devicons.get_icon("", "lua")

                if node.type == "directory" then
                    highlight = highlights.DIRECTORY_ICON
                    if node.name == "src" then
                        highlight = highlights.GIT_MODIFIED
                        icon = "|󰅪"
                    elseif node.name == ".config" or node.name == "config" then
                        highlight = highlights.GIT_MODIFIED
                        icon = "|"
                    elseif node.name == "lua" then
                        highlight = luahl
                        icon = "|"
                    elseif node.name == "build" then
                        highlight = highlights.GIT_DELETED
                        icon = "|󰣪"
                    else
                        if node:is_expanded() then
                            icon = config.folder_open or "-"
                            icon = '|' .. icon
                        else
                            icon = config.folder_closed or "+"
                            icon = '|' .. icon
                        end

                        local parent = vim.fs.basename(vim.fs.dirname(node.path)) or ""

                        -- [parent name checks]
                        if node.name == "plugin" and parent == "after" then
                            highlight = luahl
                            icon = "|"
                        end
                        -- [children (directories) checks]
                        for name, type in vim.fs.dir(node.path) do
                            if type == "directory" then
                                if name == "lua" or name == "plugin" then
                                    highlight = luahl
                                    icon = "|"
                                end
                            end
                        end
                    end
                elseif node.type == "file" then
                    if success then
                        local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                        icon = devicon or icon
                        if node.name == "meson.build" then
                            icon = "󰣪"
                        elseif node.name == "config.h" or node.name == "config.def.h" then
                            icon = ""
                        end
                        icon = ' ' .. icon
                        highlight = hl or highlight
                    end
                end

                return {
                    text = icon .. padding,
                    highlight = highlight,
                }
            end,
        }
    }
})
