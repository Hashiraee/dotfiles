-- Active indent guide and indent text objects.
local Plugin = { "echasnovski/mini.indentscope" }

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
    symbol = "│",
    options = { try_as_border = true },
}

function Plugin.init()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
        callback = function()
            vim.b.miniindentscope_disable = true
        end,
    })
end

function Plugin.config()
    require("mini.indentscope").setup(Plugin.opts)
end

return Plugin
