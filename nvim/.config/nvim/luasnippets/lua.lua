---@diagnostic disable: unused-local
local status, ls = pcall(require, "luasnip")
if not status then
    return
end


-- Options
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


-- Make snippets tables
local snippets, autosnippets = {}, {}


-- Some renames
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opts = { noremap = true, silent = true, buffer = true }
local file_pattern = "*.lua"
local group = augroup("Lua Snippets", { clear = true })


-- Snippets
local one = s(
    {
        trig = "autotrigger"
    },
    {
        t("autosnippet"),
    }
)
table.insert(autosnippets, one)

local two = s(
    {
        trig = "localreq"
    },
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
    }
)
table.insert(autosnippets, two)

-- Escape curly braces: {{}}
local three = s(
    {
        trig = "localfn"
    },
    fmt(
        [[
            local {} = function({})
                {}
            end{}
        ]],
        {
            i(1, ""),
            i(2, ""),
            i(3, ""),
            i(0, ""),
        }
    ),
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, three)


local four = s(
    {
        trig = "cnexample",
        hidden = false,
    },
    {
        fmt(
            [[
                local {} = function({})
                    {}
                end{}
            ]],
            {
                i(1, "var_name"),

                c(2,
                    {
                        t(""),
                        i(1, "args")
                    }
                ),

                i(3, "-- TODO: function"),
                i(0),
            }
        ),
    },
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, four)


local five = s(
    {
        trig = "fnexample",
        regTrig = true,
        hidden = false,
    },
    {
        f(
            function()
                return "my string"
            end
        )
    },
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, five)


-- Capture groups: (%d%d) -> add parentheses
local six = s(
    {
        trig = "fn2example(%d)(%d)",
        regTrig = true,
        hidden = false,
    },
    {
        f(
            function(_, snip)
                return snip.captures[1] .. snip.captures[2]
            end
        )
    },
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, six)


local seven = s(
    {
        trig = "y(%d)(%d)",
        regTrig = true,
        hidden = false,
    },
    {
        f(
            function(_, snip)
                return "y_{" .. snip.captures[1] .. snip.captures[2] .. "}"
            end
        )
    },
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, seven)


local eight = s(
    {
        trig = "x(%d)(%d)",
        regTrig = true,
        hidden = false,
    },
    {
        i(1, "uppercase"),
        f(
            function(arg, snip)
                return arg[1][1]:upper() .. arg[2][1]:lower()
            end,
            {
                1, 2
            }
        ),
        i(2, "LOWERCASE")
    },
    {
        condition = conds.line_begin,
    }
)
table.insert(autosnippets, eight)


-- Dynamic Nodes
-- local nine = s(
--     {
--         trig = "for([%w_]+)",
--         regtrig = true,
--         hidden = false,
--     },
--     {
--         fmt(
--             [[
--                 for (let {} = 0; , {} < {}; {}++) {{
--                     {}
--                 }}
--                 {}
--             ]],
--             {
--                 d(1,
--                     function(_, snip)
--                         -- sn contains another node
--                         return sn(1, i(1, snip.captures[1]))
--                     end
--                 ),
--
--                 rep(1),
--
--                 c(2,
--                     {
--                         i(1, "num"),
--                         sn(1,
--                             {
--                                 i(1, "arr"),
--                                 t(".length")
--                             }
--                         )
--                     }
--                 ),
--
--                 rep(1),
--                 i(3, "// TODO:"),
--                 i(4)
--             }
--         )
--     },
--     {
--         condition = conds.line_begin
--     }
-- )
-- table.insert(snippets, nine)


-- Return snippets
return snippets, autosnippets
