---@diagnostic disable: unused-local
local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Issue with luasnip in snippets.lua")
    return
end
local types = require("luasnip.util.types")

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local d = ls.dynamic_node
local r = require("luasnip.extras").rep

local events = require("luasnip.util.events")

local parse = ls.parser.parse_snippet
local node = ls.snippet_node


ls.snippets = {
    lua = {
        s("req", fmt("local {} = require('{}')", { i(1, "arg"), r(1)})),
    },

    rust = {
        s(
            "cfgtest",
            fmt(
                [[
                    #[cfg(test)]
                    mod tests {{
                        use super::*;
                        
                        {}
                    }}
                ]],
                {
                    i(0),
                }
            )
        ),

        s(
            "test",
            fmt(
                [[
                    #[test]
                    fn {}() {{
                        {}
                    }}
                ]],
                {
                    i(1, "test_case"),
                    i(0),
                }
            )
        ),

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
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("i", "<c-j>", "<cmd>lua require('luasnip').jump(1)<CR>", opts)
map("s", "<c-j>", "<cmd>lua require('luasnip').jump(1)<CR>", opts)
map("i", "<c-k>", "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
map("s", "<c-k>", "<cmd>lua require('luasnip').jump(-1)<CR>", opts)

map("n", "<Leader>gl", "<cmd>source ~/.dotfiles/nvim/.config/nvim/lua/plugins/snippets.lua<CR>", opts)
