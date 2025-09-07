local Plugin = { "saghen/blink.cmp" }

Plugin.event = "InsertEnter"

Plugin.version = "1.*"

Plugin.dependencies = {
    "folke/lazydev.nvim"
}

Plugin.opts = {
    keymap = {
        preset = "default"
    },

    completion = {
        documentation = {
            auto_show = true
        },
        menu = {
            scrollbar = false
        },
    },

    sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
    },

    signature = {
        enabled = false
    }
}

return Plugin
