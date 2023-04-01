local Plugin = { "nvim-tree/nvim-tree.lua" }

Plugin.name = "nvim-tree"

Plugin.lazy = true

Plugin.event = "VeryLazy"

Plugin.cmd = { "NvimTreeToggle" }

Plugin.opts = {
    hijack_cursor = false,

    view = {
        width = 35,
    },

    --[[ on_attach = function(bufnr)
        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {buffer = bufnr, desc = desc})
        end

        -- :help nvim-tree.api
        local api = require("nvim-tree.api")
        map("L", api.node.open.edit, "Expand folder or go to file")
        map("H", api.node.navigate.parent_close, "Close parent folder")
        map("gh", api.tree.toggle_hidden_filter, "Toggle hidden files")
    end ]]
}

function Plugin.init()
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
end

return Plugin
