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

require("luasnip.loaders.from_lua").load({paths="~/.config/nvim/lua/snippets"})

cmp.setup {

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping =
    {
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
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
            max_width = 50,
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

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
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
            scrollbar = '║',
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
            autocomplete = {
                require('cmp.types').cmp.TriggerEvent.InsertEnter,
                require('cmp.types').cmp.TriggerEvent.TextChanged,
            },
        },

        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
            scrollbar = '║',
        },
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}
