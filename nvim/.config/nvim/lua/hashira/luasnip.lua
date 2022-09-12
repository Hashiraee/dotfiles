---@diagnostic disable: unused-local
local status, ls = pcall(require, "luasnip")
if not status then
    return
end

local colors = require("catppuccin.palettes.mocha")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
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

require("luasnip.loaders.from_lua").load({})

ls.config.set_config({
    history = true,
    update_events = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged,InsertLeave",
    enable_autosnippets = true,

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", colors.peach } },
            },
        },
    },

    ext_base_prio = 300,
    ext_prio_increase = 1,
})


-- Keymappings for snippets
local opts = { noremap = true, silent = true }
vim.keymap.set({ "i", "s"}, "<C-j>",
    function()
        if ls.jumpable(1) then
            ls.jump(1)
        end
    end,
opts)

vim.keymap.set({ "i", "s"}, "<C-k>",
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end,
opts)


vim.keymap.set({ "i", "s"}, "<C-l>",
    function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end,
opts)


vim.keymap.set({ "i", "s"}, "<C-h>",
    function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end,
opts)
