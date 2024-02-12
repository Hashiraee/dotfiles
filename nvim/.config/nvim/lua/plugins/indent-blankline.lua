local Plugin = { "lukas-reineke/indent-blankline.nvim", main = "ibl" }

Plugin.name = "indent_blankline"

Plugin.event = { "BufReadPost", "BufNewFile" }

function Plugin.config()
    local indent = require("ibl")

    indent.setup({
        scope = {
            enabled = false,
            char = "│",
            show_start = false,
            show_end = false,
            include = {
                node_type = {
                    lua = { "return_statement", "table_constructor" },
                },
            },
        },

        exclude = {
            filetypes = { "help", "alpha", "dashboard", "lazy", "mason", "NvimTree", "qf", "noice" },
        },

        indent = {
            char = "│",
            smart_indent_cap = true,
        },

        whitespace = {
            remove_blankline_trail = false,
        },
    })
end

return Plugin
