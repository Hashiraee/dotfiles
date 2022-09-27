---@diagnostic disable: missing-parameter
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
    return
end

local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
    return
end

autopairs.setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/hashira/snippets" })

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ["<CR>"] = cmp.mapping.confirm
        {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },

        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,

        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },

    formatting = {
        format = lspkind.cmp_format {
            mode = 'symbol_text',
            menu = {
                buffer = "(Buf)",
                nvim_lsp = "(LSP)",
                nvim_lua = "(API)",
                path = "(Path)",
                luasnip = "(Snip)",
                gh_issues = "(Issues)",
            },
        },
    },

    sources = cmp.config.sources {
        { name = "luasnip" },
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "nvim_lua" },
        { name = "buffer", max_item_count = 10 },
        { name = "path" },
        { name = "gh_issues" },
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
    },

    style = {
        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
    },

    window = {
        completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
        },

        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
        },
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path', keyword_length = 1, max_item_count = 10, }
    }, {
        { name = 'cmdline', keyword_length = 1, max_item_count = 10, }
    }),
})
