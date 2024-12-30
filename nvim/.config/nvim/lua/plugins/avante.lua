local Plugin = { "yetone/avante.nvim" }

Plugin.dependencies = {
    { "stevearc/dressing.nvim" },
    { "MunifTanjim/nui.nvim" },
    { "zbirenbaum/copilot.lua" },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
    },
}

Plugin.event = "VeryLazy"

Plugin.lazy = false

Plugin.version = false

Plugin.build = "make"

function Plugin.config()
    local avante = require("avante")
    avante.setup({
        auto_suggestions_provider = "copilot",

        -- Copilot
        provider = "copilot",
        copilot = {
            endpoint = "https://api.githubcopilot.com",
            model = "claude-3.5-sonnet",
            temperature = 0.6,
            max_tokens = 4096,
        },

        -- Anthropic
        -- provider = "claude",
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
            temperature = 0.6,
            max_tokens = 8192,
        },

        -- Azure
        -- provider = "azure",
        azure = {
            endpoint = "https://<DEPLOYMENT_NAME>.openai.azure.com",
            deployment = "o1-2024-12-17",
            api_version = "2024-12-01-preview",
            temperature = 0,
            max_tokens = 8192,
        },

        -- Google AI Studio
        -- provider = "gemini",
        gemini = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
            model = "gemini-1.5-flash-latest",
            temperature = 0,
            max_tokens = 4096,
        },

        -- Google Vertex AI
        -- provider = "vertex",
        vertex = {
            endpoint =
            "https://<LOCATION>-aiplatform.googleapis.com/v1/projects/<PROJECT_ID>/locations/<LOCATION>/publishers/google/models",
            model = "gemini-1.5-flash-latest",
            temperature = 0,
            max_tokens = 4096,
        },

        -- Disable dual_boost mode
        dual_boost = {
            enabled = false,
        },

        -- History context size
        history = {
            max_tokens = 65536,
        },

        -- Disable hints
        hints = {
            enabled = false,
        },

        windows = {
            position = "right",
            wrap = true,
            width = 35,
            sidebar_header = {
                enabled = true,
                align = "center",
                rounded = false,
            },
            input = {
                prefix = "> ",
                height = 16,
            },
            edit = {
                border = "rounded",
                start_insert = true,
            },
            ask = {
                floating = false,
                start_insert = false,
                border = "rounded",
                focus_on_apply = "ours",
            },
        },
    })
end

return Plugin
