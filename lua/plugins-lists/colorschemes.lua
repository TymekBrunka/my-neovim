return {
    "sainnhe/sonokai",
    "sainnhe/gruvbox-material",
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = 'warm'
            }
            require('onedark').load()
        end
    },
}
