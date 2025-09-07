local Plugin = { "saghen/blink.cmp" }

Plugin.event = "InsertEnter"

Plugin.version = "1.*"

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
        default = { "lsp", "path", "snippets" },
    },

    signature = {
        enabled = false
    }
}

return Plugin
