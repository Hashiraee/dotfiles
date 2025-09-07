local Plugin = { "saghen/blink.cmp" }

Plugin.event = "InsertEnter"

Plugin.version = "1.*"

Plugin.opts = {
    keymap = {
        preset = "enter",
        ['<C-d>'] = { 'scroll_documentation_down' , 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up' , 'fallback' },
    },

    completion = {
        documentation = {
            auto_show = true
        },
        menu = {
            scrollbar = false,
        },
        list = {
            selection = {
                preselect = false
            },
        },
    },

    sources = {
        default = { "lsp", "path", "snippets" },
    },

    signature = {
        enabled = true
    },

    cmdline = {
        enabled = false
    }
}

return Plugin
