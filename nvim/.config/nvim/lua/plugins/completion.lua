local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.dependencies = {
    -- Sources
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "onsails/lspkind.nvim" },

    -- Snippets
    { "L3MON4D3/LuaSnip" },
}

Plugin.event = "InsertEnter"

function Plugin.config()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },

        sources = {
            { name = "nvim_lsp", max_item_count = 20 },
            { name = "nvim_lua", max_item_count = 10 },
            { name = "buffer",   max_item_count = 10 },
            { name = "luasnip" },
            { name = "path" },
        },

        completion = {
            get_trigger_characters = function(trigger_characters)
                return vim.tbl_filter(function(char)
                    return char ~= " "
                end, trigger_characters)
            end
        },

        window = {
            completion = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
                scrollbar = false,
            },

            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
            },
        },

        ---@diagnostic disable-next-line: missing-fields
        formatting = {
            format = lspkind.cmp_format {
                mode = "symbol_text",
                max_width = 50,
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

        experimental = {
            ghost_text = false,
        },

        mapping = {
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),

            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            ["<C-Space>"] = cmp.mapping.complete(),

            ["<C-e"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),

            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),

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
    })
end

return Plugin
