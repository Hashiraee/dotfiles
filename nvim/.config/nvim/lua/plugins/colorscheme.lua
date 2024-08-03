local Themes = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            local catppuccin = require("catppuccin")
            catppuccin.setup({
                flavour = "mocha",
                transparent_background = false,
            })

            -- Setting the colorscheme
            -- vim.cmd.colorscheme("catppuccin")
        end
    },
    -- {
    --     "EdenEast/nightfox.nvim",
    --     name = "nightfox",
    --     priority = 1000,
    --     config = function()
    --         local nightfox = require("nightfox")
    --         nightfox.setup({
    --             options = {
    --                 transparent = false,
    --             },
    --         })
    --
    --         -- Setting the colorscheme
    --         -- vim.cmd.colorscheme("terafox")
    --     end
    -- },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            local rose_pine = require("rose-pine")
            rose_pine.setup({
                variant = "main",
                extend_background_behind_borders = true,
                styles = {
                    transparency = true,
                },
            })

            -- Setting the colorscheme
            vim.cmd.colorscheme("rose-pine")
        end
    },
}

return Themes
