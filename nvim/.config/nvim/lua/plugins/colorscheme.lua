local Themes = {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            local rose_pine = require("rose-pine")
            ---@diagnostic disable-next-line: missing-fields
            rose_pine.setup({
                variant = "main",
                extend_background_behind_borders = true,
                styles = {
                    transparency = true,
                },
            })

            vim.cmd.colorscheme("rose-pine")
        end
    },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         local catppuccin = require("catppuccin")
    --         catppuccin.setup({
    --             flavour = "mocha",
    --             transparent_background = false,
    --         })
    --
    --         vim.cmd.colorscheme("catppuccin")
    --     end
    -- },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
        priority = 1000,
        config = function()
            local nightfox = require("nightfox")
            nightfox.setup({
                options = {
                    transparent = false,
                },
            })

            -- vim.cmd.colorscheme("terafox")
        end
    },
}

return Themes
