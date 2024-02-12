-- Utilities for other plugins
local Plugins = {
    { "kyazdani42/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
}

return Plugins
