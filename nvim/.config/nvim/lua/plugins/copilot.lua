local Plugin = { "zbirenbaum/copilot.lua" }

Plugin.event = "InsertEnter"

function Plugin.config()
    local copilot = require("copilot")
    copilot.setup({
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
            make = true,
            sh = true,
            javascript = true,
            typescript = true,
            javascriptreact = true,
            typescriptreact = true,
            rust = true,
            markdown = true,
            yaml = true,
            go = true,
            terraform = true,
            dockerfile = true,
            ["*"] = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = false,
            debounce = 100,
            keymap = {
                accept = "<C-y>",
                accept_line = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = false,
            },
        },
    })

    local function toggle_copilot_auto_trigger()
        require("copilot.suggestion").toggle_auto_trigger()
        if vim.b.copilot_suggestion_auto_trigger then
            vim.notify("Suggestion auto trigger enabled", vim.log.levels.INFO, { title = "Copilot" })
        else
            vim.notify("Suggestion auto trigger disabled", vim.log.levels.INFO, { title = "Copilot" })
        end
    end

    -- Copilot keymaps
    vim.keymap.set("n", "<Leader>co", "<cmd>lua require('copilot.panel').open()<cr>")
    vim.keymap.set("n", "<Leader>ct", toggle_copilot_auto_trigger)
end

return Plugin
