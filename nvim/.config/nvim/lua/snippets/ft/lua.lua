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
local rep = require("luasnip.extras").rep
local conds = require("luasnip.extras.expand_conditions")
local r = ls.restore_node

local lua = {}

ls.add_snippets("lua",
{
    --[[ s(
    {
        trig = "Some", wordTrig = false,
    },
    {
        t({"Something"}),
    },
    {}), ]]


    --[[ s(
    {
        trig = "%d", regTrig = true,
    },
    {
        t({"A Number"}),
    },
    {}), ]]


    --[[ s(
	{ trig = "a%d", regTrig = true },
		f(function(_, snip)
			return "Triggered with " .. snip.trigger .. "."
		end, {}
        )
	), ]]


    --[[ s(
		{ trig = "b(%d)", regTrig = true },
		f(function(_, snip)
			return "Captured Text: " .. snip.captures[1] .. "."
		end, {}
        )
	), ]]


	--[[ s({ trig = "c(%d+)", regTrig = true }, {
		t("will only expand for even numbers"),
	}, {
		condition = function(line_to_cursor, matched_trigger, captures)
			return tonumber(captures[1]) % 2 == 0
		end,
	}), ]]

},
{
    type = "autosnippets",
    key = "all_auto",
})


ls.add_snippets("lua",
{

},
{
    key = "lua",
})
