local Plugin = { "neovim/nvim-lspconfig" }

Plugin.dependencies = {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason-lspconfig.nvim", lazy = true },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = { border = "none" }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "basedpyright",
                    "ts_ls",
                    "gopls",
                    "terraformls",
                },
                automatic_installation = false
            })
        end
    },
}

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.config = function()
    -- Sings and Diagnostics settings
    local function setup_signs()
        local signs = {
            { name = "DiagnosticSignError", text = "", texthl = "DiagnosticSignError" },
            { name = "DiagnosticSignWarn", text = "", texthl = "DiagnosticSignWarn" },
            { name = "DiagnosticSignHint", text = "", texthl = "DiagnosticSignHint" },
            { name = "DiagnosticSignInfo", text = "", texthl = "DiagnosticSignInfo" },
        }
        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, {
                texthl = sign.texthl,
                text = sign.text,
                numhl = "",
            })
        end
    end

    -- Setup diagnostic signs
    setup_signs()

    -- Diagnostics settings
    vim.diagnostic.config({
        virtual_text = false,

        -- Diagnostic window style
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = true,
            header = "",
            prefix = "",
        },

        underline = false,
        update_in_insert = false,
        severity_sort = true,
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


    -- Keymaps configuration
    local function setup_keymaps(args)
        local opts = { buffer = args.buf, noremap = true, silent = true }

        -- Navigation
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
        vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)

        -- Workspace management
        vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

        -- Code navigation and modification
        vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)

        -- Formatting
        vim.keymap.set("n", "<Leader>==", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)
    end

    -- Document highlight setup
    local function setup_document_highlight(args, client)
        if client.supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("LspDocumentHighlight" .. args.buf, { clear = true })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = args.buf,
                callback = vim.lsp.buf.document_highlight,
                group = group,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = args.buf,
                callback = vim.lsp.buf.clear_references,
                group = group,
            })

            vim.api.nvim_create_autocmd("BufDelete", {
                buffer = args.buf,
                callback = function() vim.api.nvim_clear_autocmds({ group = group }) end,
            })
        end
    end

    -- LSP attach configuration
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end

            setup_keymaps(args)
            setup_document_highlight(args, client)
        end,
    })

    -- Configure LSP
    local lspconfig = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
    )

    -- Setup LSP servers
    require("mason-lspconfig").setup_handlers({
        function(server)
            lspconfig[server].setup({
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
            require("plugins.lsp.lua_ls")
        end,
        ["basedpyright"] = function()
            require("plugins.lsp.basedpyright")
        end,
        ["terraformls"] = function()
            require("plugins.lsp.terraformls")
        end
    })
end

return Plugin
