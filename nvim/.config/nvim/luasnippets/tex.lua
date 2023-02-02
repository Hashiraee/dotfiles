---@diagnostic disable: unused-local
local status, ls = pcall(require, "luasnip")
if not status then
    return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local lse = require("luasnip.extras")
local l = lse.lambda
local rep = lse.rep
local p = lse.partial
local m = lse.match
local n = lse.nonempty
local dl = lse.dynamic_lambda

local lsef = require("luasnip.extras.fmt")
local fmt = lsef.fmt
local fmta = lsef.fmta

local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")


-- Some renames
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opts = { noremap = true, silent = true, buffer = true }
local file_pattern = "*.tex"
local group = augroup("Latex Snippets", { clear = true })


-- LaTex environments
local tex = {}
tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end


-- Snippets
ls.add_snippets("tex", {

    s("h1",
    {
        t({ "\\section{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s("h2",
    {
        t({ "\\subsection{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s("h3",
    {
        t({ "\\subsubsection{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s("dm",
    {
        t({ "\\begin{equation*}", "\t" }),
        i(1),
        t({ "", "\\end{equation*}" }),
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
        t({"    \\label{"}), i(3, "label"), t({"}", ""}),
        t({"    \\begin{tabular}{"}), i(4, "columns"), t({"}", ""}),
        t({"        \\hline", ""}),
        t({"\t    "}), i(5), t({"", ""}),
        t({"        \\hline", ""}),
        t({"    \\end{tabular}", ""}),
        t({"    \\caption{"}), i(2, "caption"), t({"}", ""}),
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
        t({"    \\includegraphics[width=0.8\\textwidth]{"}), i(2, "figure.png"), t({"}", ""}),
        t({"    \\caption{"}), i(3, "caption"), t({"}", ""}),
        t({"    \\label{fig:"}), i(4, "label"), t({"}", ""}),
        t({"\\end{figure}"}),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s("dfig",
    {
        t({"\\begin{figure}["}), i(1, "Hhtpb"), t({"]", ""}),
        t({"    \\centering", ""}),
        t({"    \\begin{minipage}{0.5\\textwidth}", ""}),
        t({"        \\centering", ""}),
        t({"        \\includegraphics[width=1\\linewidth]{"}), i(2, "figure_1.png"), t({"}", ""}),
        t({"        \\captionof{figure}{"}), i(3, "caption_1"), t({"}", ""}),
        t({"        \\label{fig:"}), i(4, "label_1"), t({"}", ""}),
        t({"    \\end{minipage}%", ""}),
        t({"    \\begin{minipage}{0.5\\textwidth}", ""}),
        t({"        \\centering", ""}),
        t({"        \\includegraphics[width=1\\linewidth]{"}), i(5, "figure_2.png"), t({"}", ""}),
        t({"        \\captionof{figure}{"}), i(6, "caption_2"), t({"}", ""}),
        t({"        \\label{fig:"}), i(7, "label_2"), t({"}", ""}),
        t({"    \\end{minipage}", ""}),
        t({"    \\caption*{"}), i(8, "caption_both"), t({"}", ""}),
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


    s("tcol",
    {
        t({ "\\begin{tcolorbox}", "\t" }),
		i(1),
		t({ "", "\\end{tcolorbox}" }),
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


    s("tbf",
    {
        t({"\\textbf{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s("ubf",
    {
        t({"\\underline{\\textbf{"}), i(1), t({"}}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s("undl",
    {
        t({"\\underline{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s("tital",
    {
        t({"\\textit{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s("//",
    {
        t({"$\\frac{"}), i(1), t({"}{"}), i(2), t({"}$"}),
        i(0),
    },
    {
        condition = tex.in_text,
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
        t({"& = "}), i(1), t({" \\\\"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("===",
    {
        t({"$\\equiv$"}), i(0),
    },
    {
        condition = tex.in_text
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


    s("->",
    {
        t({"$\\rightarrow$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s("=>",
    {
        t({"$\\implies$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s("bull",
    {
        t({"\\bullet"}), i(0),
    },
    {
        condition = tex.in_math
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


    s("lr)",
    {
        t({"\\left( "}), i(1), t({" \\right)"}), i(0),
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


    s("til",
    {
        t({"\\tilde{"}), i(1), t({"}"}), i(0),
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
        trig = "--",
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
        wordTrig = false,
    },
    {
        t({"$"}), t({"_{"}), i(1, "index"), t({"}$"}), i(0),
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
    s({ trig = "Xii", wordTrig = false }, { t({"X_{i}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xnn", wordTrig = false }, { t({"x_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "Xnn", wordTrig = false }, { t({"X_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "xtt", wordTrig = false }, { t({"x_{t}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "Xtt", wordTrig = false }, { t({"X_{t}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "yii", wordTrig = false }, { t({"y_{i}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "Yii", wordTrig = false }, { t({"Y_{i}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ynn", wordTrig = false }, { t({"y_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "Ynn", wordTrig = false }, { t({"Y_{n}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "ytt", wordTrig = false }, { t({"y_{t}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "Ytt", wordTrig = false }, { t({"Y_{t}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "ett", wordTrig = false }, { t({"\\epsilon_{t}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "eii", wordTrig = false }, { t({"\\epsilon_{i}"}) }, { condition = tex.in_mathzone }),

    s({ trig = "utt", wordTrig = false }, { t({"u_{t}"}) }, { condition = tex.in_mathzone }),
    s({ trig = "uii", wordTrig = false }, { t({"u_{i}"}) }, { condition = tex.in_mathzone }),

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


    s(";a",
    {
        t({"\\alpha"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";b",
    {
        t({"\\beta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";g",
    {
        t({"\\gamma"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";G",
    {
        t({"\\Gamma"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";d",
    {
        t({"\\delta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";D",
    {
        t({"\\Delta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";e",
    {
        t({"\\epsilon"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";z",
    {
        t({"\\zeta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";h",
    {
        t({"\\eta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";o",
    {
        t({"\\theta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";O",
    {
        t({"\\Theta"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";k",
    {
        t({"\\kappa"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";l",
    {
        t({"\\lambda"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";L",
    {
        t({"\\Lambda"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";u",
    {
        t({"\\mu"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";n",
    {
        t({"\\nu"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";x",
    {
        t({"\\xi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";X",
    {
        t({"\\Xi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";i",
    {
        t({"\\pi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";I",
    {
        t({"\\Pi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";r",
    {
        t({"\\rho"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";s",
    {
        t({"\\sigma"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";S",
    {
        t({"\\Sigma"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";t",
    {
        t({"\\tau"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";y",
    {
        t({"\\upsilon"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";f",
    {
        t({"\\phi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";F",
    {
        t({"\\Phi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";c",
    {
        t({"\\chi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";p",
    {
        t({"\\psi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";P",
    {
        t({"\\Psi"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";w",
    {
        t({"\\omega"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(";W",
    {
        t({"\\Omega"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s("tht",
    {
        t({"_{T + h | T}"}),
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
        trig = "inv",
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
        trig = "\'",
        wordTrig = false,
    },
    {
        t({"^{\\prime}"}),
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


    s("sim",
    {
        t({"\\sim"}),
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
        trig = "tsub",
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
        trig = "ttt",
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


    s("expec",
    {
        t({ "\\mathds{E}\\left[ " }),
		i(1),
		t({" \\right]"}),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("var",
    {
        t({ "\\mathds{V}ar\\left[ " }),
		i(1),
		t({" \\right]"}),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("cov",
    {
        t({ "\\mathds{C}ov\\left[ " }),
		i(1),
		t({" \\right]"}),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("prob",
    {
        t({ "\\mathds{P}[ " }),
		i(1),
		t({ " ]" }),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("pr1",
    {
        t({ "\\mathds{P}\\left[ Y_{i} = 1 | X_{i} \\right]" }),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("pr0",
    {
        t({ "\\mathds{P}\\left[ Y_{i} = 0 | X_{i} \\right]" }),
        i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s("uuu",
    {
        t({ "\\mu" }),
    },
    {
        condition = tex.in_mathzone
    }),


    s("mutt",
    {
        t({ "\\mu_{t}" }),
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
        trig = "([0-9])cm",
        regTrig = true,
    },
    f(
        function(_, snip)
            return "\\vspace{0." .. snip.captures[1] .. "cm}"
        end, {}
    ),
    {
        condition = tex.in_text and conds.line_begin
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


    s(
    {
        trig = "([A-Za-z])til",
        regTrig = true,
    },
    f(
        function(_, snip)
            return "\\tilde{" .. snip.captures[1] .. "}"
        end, {}
    ),
    {
        condition = tex.in_mathzone
    }),


    -- s(
    -- {
    --     trig = "(%w)(,)(%w);e",
    --     regTrig = true,
    -- },
    -- f(
    --     function(_, snip)
    --         return "\\epsilon_{" .. snip.captures[1] .. snip.captures[2] .. snip.captures[3] .. "}"
    --     end, {}
    -- ),
    -- {
    --     condition = tex.in_mathzone
    -- }),


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
