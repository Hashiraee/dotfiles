local Plugin = { "lewis6991/gitsigns.nvim", config = true }

Plugin.name = "gitsigns"
Plugin.event = { "BufReadPre", "BufNewFile" }

return Plugin
