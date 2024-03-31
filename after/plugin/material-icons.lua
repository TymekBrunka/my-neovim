--[[ local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_ok then
	return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
if not material_icon_ok then
	return
end

require("nvim-material-icon").set_icon ({
    sh = {
        icon = "",
        color = "#88dd66",
        cterm_color = "52",
        name = "sh"
    },
    pdf = {
        icon = "",
        color = "#dd8866",
        cterm_color = "d1",
        name = "pdf"
    }
})

web_devicons.setup({
	override = material_icon.get_icons(),
}) ]]
