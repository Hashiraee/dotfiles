---@diagnostic disable: undefined-global
-- LaTex environments
local tex = {}
tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

return {
    s(
    {
        trig = "h1",
        snippetType = "autosnippet",
    },
    {
        t({ "\\section{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s(
    {
        trig = "h2",
        snippetType = "autosnippet",
    },
    {
        t({ "\\subsection{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s(
    {
        trig = "h3",
        snippetType = "autosnippet",
    },
    {
        t({ "\\subsubsection{" }), i(1), t({ "}" }),
    },
    {
        condition = tex.in_text and conds.line_begin
    }),


    s(
    {
        trig = "mk",
        snippetType = "autosnippet",
    },
    {
        t({ "$" }), i(1), t({"$"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "dm",
        snippetType = "autosnippet",
    },
    {
        t({ "\\begin{equation*}", "\t" }),
        i(1),
        t({ "", "\\end{equation*}" }),
    },
    {
        condition = tex.in_text
    }),


    s(
    {
        trig = "beg",
        snippetType = "autosnippet",
    },
    {
        t({"\\begin{",}), i(1), t({"}", "\t"}),
        i(2),
        t({"", "\\end{"}), rep(1), t({"}"}),
        i(0),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s(
    {
        trig = "...",
        snippetType = "autosnippet",
    },
    {
        t({"\\dots"}),
    },
    {
        condition = tex.in_text
    }),


    s(
    {
        trig = "table",
        snippetType = "autosnippet",
    },
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


    s(
    {
        trig = "fig",
        snippetType = "autosnippet",
    },
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


    s(
    {
        trig = "dfig",
        snippetType = "autosnippet",
    },
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


    s(
    {
        trig = "enum",
        snippetType = "autosnippet",
    },
    {
        t({ "\\begin{enumerate}[noitemsep]", "\t\\item " }),
        i(1),
        t({ "", "\\end{enumerate}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s(
    {
        trig = "item",
        snippetType = "autosnippet",
    },
    {
        t({ "\\begin{itemize}[noitemsep]", "\t\\item " }),
        i(1),
        t({ "", "\\end{itemize}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s(
    {
        trig = "tcol",
        snippetType = "autosnippet",
    },
    {
        t({ "\\begin{tcolorbox}", "\t" }),
        i(1),
        t({ "", "\\end{tcolorbox}" }),
    },
    {
        condition = tex.in_text and conds.line_begin,
    }),


    s(
    {
        trig = "align",
        snippetType = "autosnippet",
    },
    {
        t({ "\\begin{align*}", "\t" }),
        i(1),
        t({ "", "\\end{align*}" }),
        i(0),
    },
    {
        condition = conds.line_begin and tex.in_text,
    }),
}
