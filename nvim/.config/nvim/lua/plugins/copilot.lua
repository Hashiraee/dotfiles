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
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
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
    vim.keymap.set("n", "<leader>co", "<cmd>lua require('copilot.panel').open()<cr>")

    vim.keymap.set("n", "<leader>ct", function()
        require('copilot.suggestion').toggle_auto_trigger()
        if vim.b.copilot_suggestion_auto_trigger then
            vim.notify("suggestion auto trigger enabled", "info", { title = "Copilot" })
        else
            vim.notify("suggestion auto trigger disabled", "info", { title = "Copilot" })
        end
    end)
end

return Plugin
