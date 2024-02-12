---@diagnostic disable: unused-local
local Plugin = { "L3MON4D3/LuaSnip" }

Plugin.event = "InsertEnter"

function Plugin.config()
    local ls = require("luasnip")

    ---@diagnostic disable-next-line: assign-type-mismatch
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/snippets/" })

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

    ls.config.set_config({
        history = false,
        update_events = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged,InsertLeave",
        enable_autosnippets = true,

        -- Event on which to check for exiting a snippet's region
        region_check_events = "InsertEnter",
        ext_base_prio = 300,
        ext_prio_increase = 1,
    })

    -- Keymappings for snippets
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ "i", "s" }, "<C-n>",
        function()
            if ls.jumpable(1) then
                ls.jump(1)
            end
        end, opts)

    vim.keymap.set({ "i", "s" }, "<C-p>",
        function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, opts)

    -- vim.keymap.set({"i", "s" }, "<>",
    --     function()
    --         if ls.choice_active() then
    --             ls.change_choice(1)
    --         end
    --     end, opts)

    -- vim.keymap.set({ "i", "s" }, "<>",
    --     function()
    --         if ls.choice_active() then
    --             ls.change_choice(-1)
    --         end
    --     end, opts)
end

return Plugin
