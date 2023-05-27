local Plugins = {

    -- Tokyonight
    {
        "folke/tokyonight.nvim",
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
        end
    }
}

return Plugins
