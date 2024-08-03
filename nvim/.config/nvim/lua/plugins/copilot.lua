local Plugin = { "zbirenbaum/copilot.lua" }

Plugin.event = "InsertEnter"

Plugin.cmd = "Copilot"

Plugin.opts = {
    panel = {
        enabled = true,
        auto_refresh = true,
        layout = {
            position = "bottom",
            ratio = 0.4,
        },
    },
    filetypes = {
        lua = true,
        python = true,
        rust = true,
        make = true,
        sh = true,
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        tex = true,
        ["*"] = false,
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 100,
        keymap = {
        accept = "<C-y>",
        accept_line = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = false,
        },
    },
}

function Plugin.init()
    vim.keymap.set("n", "<Leader>co", "<cmd>lua require('copilot.panel').open()<cr>")

    vim.keymap.set("n", "<Leader>ct", function()
        require('copilot.suggestion').toggle_auto_trigger()
        if vim.b.copilot_suggestion_auto_trigger then
            vim.notify("suggestion auto trigger enabled", vim.log.levels.INFO, { title = "Copilot" })
        else
            vim.notify("suggestion auto trigger disabled", vim.log.levels.INFO, { title = "Copilot" })
        end
    end)
end

return Plugin
