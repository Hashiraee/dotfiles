local Plugin = { "neovim/nvim-lspconfig" }
local settings = {}

Plugin.dependencies = {
    { "folke/neodev.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason-lspconfig.nvim", lazy = true },

    -- Mason settings
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "LspInstall", "LspUnInstall" },
        config = function()
            require("mason").setup({
                ui = { border = "none" }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "texlab",
                }
            })
        end
    },
}

Plugin.cmd = "LspInfo"

Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
    local sign = function(opts)
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
    end

    -- Signs
    sign({ name = "DiagnosticSignError", text = "" })
    sign({ name = "DiagnosticSignWarn", text = "" })
    sign({ name = "DiagnosticSignHint", text = "" })
    sign({ name = "DiagnosticSignInfo", text = "" })

    -- Diagnostics settings
    vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,

        -- Diagnostic window style
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    -- Hover settings
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    -- Signature help
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
    )

    -- Diagnostics keymaps
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
    vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)
end

function settings.on_attach(client, bufnr)
    local attach_opts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, attach_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, attach_opts)

    -- Workspace stuff
    vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, attach_opts)

    -- Code actions and formatting
    vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, attach_opts)
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, attach_opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, attach_opts)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(0, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    -- Highlight word under cursor.
    if client.supports_method("textDocument/documentHighlight") then
        local document_highlight_group = vim.api.nvim_create_augroup(
            "LspDocumentHighlight" .. bufnr, { clear = true }
        )

        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
            group = document_highlight_group,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
            group = document_highlight_group,
        })

        -- Clean up autocommands when the buffer is closed or the LSP client detaches
        vim.api.nvim_create_autocmd("BufDelete", {
            buffer = bufnr,
            callback = function()
                vim.api.nvim_clear_autocmds({ group = document_highlight_group })
            end,
        })
    end
end

function Plugin.config()
    -- Setting up neodev
    require("neodev").setup({})
    local lspconfig = require("lspconfig")
    local lsp_defaults = lspconfig.util.default_config

    lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
    )

    local lsp_group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        desc = "LSP actions",
        callback = function(event)
            local client_id = event.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local bufnr = event.buf
            settings.on_attach(client, bufnr)
        end
    })

    require("mason-lspconfig").setup_handlers({
        function(server)
            lspconfig[server].setup({})
        end,
        ["lua_ls"] = function()
            require("plugins.lsp.lua_ls")
        end,
        ["pyright"] = function()
            require("plugins.lsp.pyright")
        end,
        ["tsserver"] = function()
            require("plugins.lsp.tsserver")
        end,
    })
end

return Plugin
