local Plugin = { "obsidian-nvim/obsidian.nvim" }

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- { "MeanderingProgrammer/render-markdown.nvim" },
}

Plugin.lazy = false

Plugin.opts = {
    legacy_commands = false,
    ui = {
        enable = false,
    },
    workspaces = {
        {
            name = "notes",
            path = "~/Workspace/github.com/Hashiraee/notes",
        },
    },
    daily_notes = {
        folder = "daily",
    },
}

function Plugin.config()
    local obsidian = require("obsidian")
    obsidian.setup(Plugin.opts)

    -- Keymaps
    vim.keymap.set("n", "<leader>of", "<cmd>Obsidian quick_switch<cr>")
    vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>")
    vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<cr>")
    vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>")
    vim.keymap.set("n", "<leader>on", "<cmd>Obsidian tomorrow<cr>")
    vim.keymap.set("n", "<leader>op", "<cmd>Obsidian yesterday<cr>")
end

return Plugin
