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
        trig = "=>",
        snippetType = "autosnippet",
    },
    {
        t({ "\\implies" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s(
    {
        trig = "=<",
        snippetType = "autosnippet",
    },
    {
        t({ "\\impliedby" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s(
    {
        trig = "iff",
        snippetType = "autosnippet",
    },
    {
        t({ "\\iff" }),
    },
    {
        condition = tex.in_mathzone,
    }),


    s(
    {
        trig = "//",
        snippetType = "autosnippet",
    },
    {
        t({"\\frac{"}), i(1), t({"}{"}), i(2), t({"}"}),
        i(0),
    },
    {
        condition = tex.in_mathzone,
    }),


    s(
    {
        trig = "tbf",
        snippetType = "autosnippet",
    },
    {
        t({"\\textbf{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "ubf",
        snippetType = "autosnippet",
    },
    {
        t({"\\underline{\\textbf{"}), i(1), t({"}}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "undl",
        snippetType = "autosnippet",
    },
    {
        t({"\\underline{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "tital",
        snippetType = "autosnippet",
    },
    {
        t({"\\textit{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_text,
    }),


    s(
    {
        trig = "//",
        snippetType = "autosnippet",
    },
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


    s(
    {
        trig = "==",
        snippetType = "autosnippet",
    },
    {
        t({"& = "}), i(1), t({" \\\\"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "===",
        snippetType = "autosnippet",
    },
    {
        t({"$\\equiv$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s(
    {
        trig = "!=",
        snippetType = "autosnippet",
    },
    {
        t({"\\neq"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "!=",
        snippetType = "autosnippet",
    },
    {
        t({"$\\neq$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s(
    {
        trig = "->",
        snippetType = "autosnippet",
    },
    {
        t({"$\\rightarrow$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s(
    {
        trig = "=>",
        snippetType = "autosnippet",
    },
    {
        t({"$\\implies$"}), i(0),
    },
    {
        condition = tex.in_text
    }),


    s(
	{
        trig = "bull",
        snippetType = "autosnippet",
    },
    {
        t({"\\bullet"}), i(0),
    },
    {
        condition = tex.in_math
    }),

    s(
	{
        trig = "ceil",
        snippetType = "autosnippet",
    },
    {
        t({"\\left\\lceil "}), i(1), t({" \\right\\rceil"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "floor",
        snippetType = "autosnippet",
    },
    {
        t({"\\left\\lfloor "}), i(1), t({" \\right\\rfloor"}),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "norm",
        snippetType = "autosnippet",
    },
    {
        t({"\\|"}), i(1, "arg"), t("\\|"), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lr)",
        snippetType = "autosnippet",
    },
    {
        t({"\\left( "}), i(1), t({" \\right)"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lr|",
        snippetType = "autosnippet",
    },
    {
        t({"\\left| "}), i(1), t({" \\right|"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lr{",
        snippetType = "autosnippet",
    },
    {
        t({"\\left{ "}), i(1), t({" \\right"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lr[",
        snippetType = "autosnippet",
    },
    {
        t({"\\left[ "}), i(1), t({" \\right"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lr<",
        snippetType = "autosnippet",
    },
    {
        t({"\\left< "}), i(1), t({" \\right>"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "bar",
        snippetType = "autosnippet",
    },
    {
        t({"\\bar{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "hat",
        snippetType = "autosnippet",
    },
    {
        t({"\\hat{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "til",
        snippetType = "autosnippet",
    },
    {
        t({"\\tilde{"}), i(1), t({"}"}), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "sum",
        snippetType = "autosnippet",
    },
    {
        t({"\\sum_{"}), i(1, "t"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "T"), t({"} "}), i(4, "arg"),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "lim",
        snippetType = "autosnippet",
    },
    {
        t({"\\lim_{"}), i(1, "i"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "\\infty"), t({"} "}), i(4, "arg")
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "prod",
        snippetType = "autosnippet",
    },
    {
        t({"\\prod_{"}), i(1, "i"), t({" = "}), i(2, "0"), t({"}^{"}), i(3, "\\infty"), t({"} "}), i(4, "arg"),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "part",
        snippetType = "autosnippet",
    },
    {
        t({"\\frac{\\partial "}), i(1, "F"), t({"}{\\partial "}), i(2, "x"), t("}"), i(0),
    },
    {
        condition = tex.in_mathzone
    }),


    s(
	{
        trig = "sq",
        snippetType = "autosnippet",
    },
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
        snippetType = "autosnippet",
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
        snippetType = "autosnippet",
    },
    {
        t({"^{3}"})
    },
    {
        condition = tex.in_mathzone
    }),


    s(
    {
        trig = "tp",
        wordTrig = false,
        snippetType = "autosnippet",
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
        snippetType = "autosnippet",
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
        snippetType = "autosnippet",
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
        snippetType = "autosnippet",
    },
    {
        t({"$"}), t({"_{"}), i(1, "index"), t({"}$"}), i(0),
    },
    {
        condition = tex.in_text
    }),
}
