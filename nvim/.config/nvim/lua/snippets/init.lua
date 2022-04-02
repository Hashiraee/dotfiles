---@diagnostic disable: unused-local
local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Issue with luasnip...")
    return
end


local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")


ls.config.set_config(
{
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged, InsertLeave",
	enable_autosnippets = true,

	ext_opts =
    {
		[types.choiceNode] =
        {
			active =
            {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
})


local function copy(args)
	return args[1]
end


ls.add_snippets("all", {}, {})


ls.add_snippets("all",
{
	s("autotrig",
    {
		t("autotriggered!"),
	}, {
        condition = conds.line_begin,
    }),

},
{
	type = "autosnippets",
	key = "all_auto",
})


ls.add_snippets("lua",
{
	s("req",
    {
		t("local "),
        i(1, "arg"),
		t(" = require(\""),
        rep(1),
        t("\")"),
        i(0),
	},
    {
        condition = conds.line_begin,
    }),
},
{
	type = "autosnippets",
	key = "all_auto",
})


ls.add_snippets("rust",
{
    s(
        "allow",
        fmt(
            [[
                #![allow({})]{}
            ]],
            {
                i(1, "args"),
                i(0),
            }
        )
    ),

    s(
        "allowduu",
        fmt(
            [[
                #![allow(dead_code, unused_imports, unused_variables)]{}
            ]],
            { i(0) }
        )
    ),

    s(
        "derive",
        fmt(
            [[
                #[derive({})]{}
            ]],
            {
                i(1, "args"),
                i(0),
            }
        )
    ),

    s(
        "derivedebug",
        fmt(
            [[
                #[derive(Debug)]{}
            ]],
            { i(0) }
        )
    ),

    s(
        "assert",
        fmt(
            [[
                assert_eq!({}, {});{}
            ]],
            { i(1, "left"), i(2, "right"), i(0) }
        )
    ),
},
{}
)


ls.add_snippets("tex",
{},
{})

require("snippets.ft.tex")

ls.filetype_extend("lua", {})

-- see DOC.md/LUA SNIPPETS LOADER for some details.
require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "rust", "tex" } })

-- Keymappings for snippets
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("i", "<C-j>", "<cmd>lua require('luasnip').jump(1)<CR>", opts)
map("s", "<C-j>", "<cmd>lua require('luasnip').jump(1)<CR>", opts)
map("i", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
map("s", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
map("n", "<Leader>gl", "<cmd>source ~/.dotfiles/nvim/.config/nvim/lua/snippets/init.lua<CR>", opts)
