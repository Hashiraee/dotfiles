local Plugin = { "saghen/blink.cmp" }

Plugin.event = "InsertEnter"

Plugin.version = "1.*"

Plugin.opts = {
    keymap = {
        preset = "none",
        ['<C-\\>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev',  'snippet_backward', 'fallback' },

        ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },

        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
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
