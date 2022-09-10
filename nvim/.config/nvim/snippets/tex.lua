---@diagnostic disable: unused-local
--[[ local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
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
        t({ "\\begin{enumerate}[noitemsep]", "\t\\item " }),
		i(1),
		t({ "", "\\end{enumerate}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s("item",
    {
        t({ "\\begin{itemize}[noitemsep]", "\t\\item " }),
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


    s("align",
    {
        t({ "\\begin{align*}", "\t" }),
        i(1),
		t({ "", "\\end{align*}" }),
        i(0),
    },
    {
        condition = conds.line_begin and tex.in_text,
    }),


    s("//",
    {
        t({"\\frac{"}), i(1), t({"}{"}), i(2), t({"}"}),
        i(0),
    },
    {
        condition = tex.in_mathzone,
    }),


    s("tfrac",
    {
        t({"$\\frac{"}), i(1), t({"}{"}), i(2), t({"}$"}),
        i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "([A-Za-z])(%d)",
        regTrig = true,
    },
    f(
        function(_, snip)
            return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
        end, {}
    ),
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "([A-Za-z])_(%d%d)",
        regTrig = true,
    },
    f(
        function(_, snip)
            return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
        end, {}
    ),
    {
        condition = tex.in_mathzone,
    }),


    s("==",
    {
        t({"&= "}), i(1), t({" \\\\"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("!=",
    {
        t({"\\neq"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("!=",
    {
        t({"$\\neq$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s("ceil",
    {
        t({"\\left\\lceil "}), i(1), t({" \\right\\rceil"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("floor",
    {
        t({"\\left\\lfloor "}), i(1), t({" \\right\\rfloor"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("norm",
    {
        t({"\\|"}), i(1, "arg"), t("\\|"), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lr(",
    {
        t({"\\left( "}), i(1), t({" \\right"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lr|",
    {
        t({"\\left| "}), i(1), t({" \\right|"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lr{",
    {
        t({"\\left{ "}), i(1), t({" \\right"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lr[",
    {
        t({"\\left[ "}), i(1), t({" \\right"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lr<",
    {
        t({"\\left< "}), i(1), t({" \\right>"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("bar",
    {
        t({"\\bar{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("hat",
    {
        t({"\\hat{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("sum",
    {
        t({"\\sum_{"}), i(1, "t"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "T"), t({"} "}), i(4, "arg"),
    },
    {
        condition = tex.in_mathzone
    }),


    s("lim",
    {
        t({"\\lim_{"}), i(1, "i"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "\\infty"), t({"} "}), i(4, "arg")
    },
    {
        condition = tex.in_mathzone
    }),


    s("prod",
    {
        t({"\\prod_{"}), i(1, "i"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "\\infty"), t({"} "}), i(4, "arg"),
    },
    {
        condition = tex.in_mathzone
    }),


    s("part",
    {
        t({"\\frac{\\partial "}), i(1, "F"), t({"}{\\partial "}), i(2, "x"), t("}"), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("sq",
    {
        t({"\\sqrt{"}), i(1, "arg"), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "sr",
        wordTrig = false,
    },
    {
        t({"^{2}"})
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "cb",
        wordTrig = false,
    },
    {
        t({"^{3}"})
    },
    {
        condition = tex.in_mathzone
    }),


    -- Raised To the Power of...
    s(
    {
        trig = "tp",
        wordTrig = false,
    },
    {
        t({"^{"}), i(1, "power"), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "__",
        wordTrig = false,
    },
    {
        t({"_{"}), i(1, "index"), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "__",
        wordTrig = true,
    },
    {
        t({"$"}), i(1, "value"), t({"_{"}), i(2, "index"), t({"}$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s("iii",
    {
        t({"\\infty"})
    },
    {
        condition = tex.in_mathzone or tex.in_text
    }),


    s("<=",
    {
        t({"\\le"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(">=",
    {
        t({"\\ge"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("EE",
    {
        t({"\\exits"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("AA",
    {
        t({"\\forall"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s({ trig = "xii", wordTrig = false }, { t({"x_{i}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xjj", wordTrig = false }, { t({"x_{j}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xkk", wordTrig = false }, { t({"x_{k}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xmm", wordTrig = false }, { t({"x_{m}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xnn", wordTrig = false }, { t({"x_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xtt", wordTrig = false }, { t({"x_{t}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "yii", wordTrig = false }, { t({"y_{i}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "yjj", wordTrig = false }, { t({"y_{j}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ykk", wordTrig = false }, { t({"y_{k}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ymm", wordTrig = false }, { t({"y_{m}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ynn", wordTrig = false }, { t({"y_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ytt", wordTrig = false }, { t({"y_{t}"}) }, { condition = tex.in_mathzone }),


    s({ trig = "xp1", wordTrig = false }, { t({"x_{t+1}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xp2", wordTrig = false }, { t({"x_{t+2}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xpp", wordTrig = false }, { t({"x_{t+p}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xpr", wordTrig = false }, { t({"x_{t+r}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "xm1", wordTrig = false }, { t({"x_{t-1}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xm2", wordTrig = false }, { t({"x_{t-2}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xmp", wordTrig = false }, { t({"x_{t-p}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xmr", wordTrig = false }, { t({"x_{t-r}"}) }, { condition = tex.in_mathzone }),


    s({ trig = "yp1", wordTrig = false }, { t({"y_{t+1}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "yp2", wordTrig = false }, { t({"y_{t+2}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ypp", wordTrig = false }, { t({"y_{t+p}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ypr", wordTrig = false }, { t({"y_{t+r}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "ym1", wordTrig = false }, { t({"y_{t-1}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ym2", wordTrig = false }, { t({"y_{t-2}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ymp", wordTrig = false }, { t({"y_{t-p}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ymr", wordTrig = false }, { t({"y_{t-r}"}) }, { condition = tex.in_mathzone }),


    s("epsi",
    {
        t({"\\epsilon_{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("alp",
    {
        t({"\\alpha"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("thet",
    {
        t({"\\theta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("nu",
    {
        t({"\\nu"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("phi",
    {
        t({"\\phi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("xx",
    {
        t({"\\times"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "**",
        wordTrig = false,
    },
    {
        t({"\\cdot"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("dint",
    {
        t({"\\int_{"}), i(1, "-\\infty"), t({"}^{"}), i(2, "\\infty"), t({"} "}), i(3, "arg"), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "->",
        wordTrig = false,
    },
    {
        t({"\\to"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "<->",
        wordTrig = false,
    },
    {
        t({"\\leftrightarrow"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "!>",
        wordTrig = false,
    },
    {
        t({"\\mapsto"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "invs",
        wordTrig = false,
    },
    {
        t({"^{-1}"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "compl",
        wordTrig = false,
    },
    {
        t({"^{c}"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(">>",
    {
        t({"\\gg"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("<<",
    {
        t({"\\ll"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("~~",
    {
        t({"\\sim"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("||",
    {
        t({"\\mid"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("cc",
    {
        t({"\\subset"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("notin",
    {
        t({"\\not\\in"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("inn",
    {
        t({"\\in"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("NN", { t({"\\N"}) }, { condition = tex.in_mathzone }),
    s("RR", { t({"\\R"}) }, { condition = tex.in_mathzone }),
    s("ZZ", { t({"\\Z"}) }, { condition = tex.in_mathzone }),
    s("QQ", { t({"\\Q"}) }, { condition = tex.in_mathzone }),
    s("OO", { t({"\\O"}) }, { condition = tex.in_mathzone }),


    s("<!",
    {
        t({"\\triangleleft"})
    },
    {
        condition = tex.in_mathzone
    }),


    s("<>",
    {
        t({"\\diamond"})
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "tsubs",
        wordTrig = false,
    },
    {
        t({"_{\\text{"}), i(1, "text"), t({"}}"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "itt",
        wordTrig = true,
    },
    {
        t({"\\text{"}), i(1, "text"), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("cases",
    {
        t({ "\\begin{cases}", "\t" }),
		i(1),
		t({ "", "\\end{cases}" }),
    },
    {
        condition = tex.in_mathzone
    }),


    s("exp",
    {
        t({ "\\mathbb{E}\\left[ " }),
		i(1),
		t({" \\right]"}),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("ph1",
    {
        t({ "\\phi_{1}" }),
    },
    {
        condition = tex.in_mathzone
    }),


    s("mu",
    {
        t({ "\\mu" }),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "([A-Za-z])bar",
        regTrig = true,
    },
    f(
        function(_, snip)
            return "\\bar{" .. snip.captures[1] .. "}"
        end, {}
    ),
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "([A-Za-z])hat",
        regTrig = true,
    },
    f(
        function(_, snip)
            return "\\hat{" .. snip.captures[1] .. "}"
        end, {}
    ),
    {
        condition = tex.in_mathzone
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
}) ]]
