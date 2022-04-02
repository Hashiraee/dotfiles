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

local tex = {}
tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end

ls.add_snippets("tex",
{
    s("dm",
    {
        t({ "\\[", "\t" }),
        i(1),
        t({ "", "\\]" }),
    }, 
    {
        condition = tex.in_text
    }),

    s("ls",
    {
        t({"\\begin{itemize}",
        "\t\\item "}), i(1), d(2, rec_ls, {}),
        t({"", "\\end{itemize}"}), i(0)
    },
    {
        condition = tex.in_text
    }),
},
{
    type = "autosnippets",
    key = "all_auto",
})
