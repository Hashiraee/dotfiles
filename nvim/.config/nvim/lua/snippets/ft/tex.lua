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


local tex = {}
tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
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


    s("beg",
    {
        t({"\\begin{",}), i(1), t({"}", "\t"}),
        i(2),
        t({"", "\\end{"}), rep(1), t({"}"}),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),

    s("...",
    {
        t({"\\dots"}),
    },
    {
        condition = tex.in_text
    }),


    s("table",
    {
        t({"\\begin{table}["}), i(1, "Hhtpb"), t({"]", ""}),
        t({"    \\centering", ""}),
        t({"    \\caption{"}), i(2, "caption"), t({"}", ""}),
        t({"    \\label{"}), i(3, "label"), t({"}", ""}),
        t({"    \\begin{tabular}{"}), i(4, "columns"), t({"}", ""}),
        t({"        \\hline", ""}),
        t({"\t    "}), i(5), t({"", ""}),
        t({"        \\hline", ""}),
        t({"    \\end{tabular}", ""}),
        t({"\\end{table}"}),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),

    s("fig",
    {
        t({"\\begin{figure}["}), i(1, "Hhtpb"), t({"]", ""}),
        t({"    \\centering", ""}),
        t({"    \\includegraphics[width=0.8\\textwidth]{"}), i(2, "figure"), t({"}", ""}),
        t({"    \\caption{"}), i(3, "caption"), t({"}", ""}),
        t({"    \\label{fig:"}), i(4, "label"), t({"}", ""}),
        t({"\\end{figure}"}),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s("enum",
    {
        t({ "\\begin{enumerate}", "\t\\item " }),
		i(1),
		t({ "", "\\end{enumerate}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s("item",
    {
        t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		t({ "", "\\end{itemize}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s("=>",
    {
        t({ "\\implies" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s("=<",
    {
        t({ "\\impliedby" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s("iff",
    {
        t({ "\\iff" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s("mk",
    {
        t({ "$" }), i(1), t({"$"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s("dm",
    {
        t({ "\\[", "\t" }), i(1), t({"\\] "}), i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),
},
{
    type = "autosnippets",
    key = "all_auto",
})

ls.add_snippets("tex", {

    s("desc",
    {
        t({ "\\begin{description}", "\t\\item[" }), i(1, "arg"), t({"] "}),
        i(2),
		t({ "", "\\end{description}" }),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),

    s("pac",
    {
        t({"\\usepackage["}), i(1, "options"), t({"]{"}),
        i(2, "package"), t({"}"}), i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),
},
{
    key = "tex",
})
