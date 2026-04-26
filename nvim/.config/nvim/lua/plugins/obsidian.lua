local Plugin = { "obsidian-nvim/obsidian.nvim" }

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "MeanderingProgrammer/render-markdown.nvim" },
}

Plugin.lazy = false

Plugin.opts = {
    legacy_commands = false,
    workspaces = {
        {
            name = "notes",
            path = "~/Workspace/github.com/Hashiraee/notes",
        },
    },
}

function Plugin.config()
    local obsidian = require("obsidian")
    obsidian.setup(Plugin.opts)
end

return Plugin
