---@diagnostic disable: duplicate-set-field
local Plugin = { "stevearc/dressing.nvim" }

Plugin.lazy = true

function Plugin.init()
    vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
    end
    vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
    end
end


return Plugin
