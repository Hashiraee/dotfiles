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
    -- Diagnostics settings
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            },
        },

        -- Virtual Text
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

        jump = {
            float = true,
        }
    })

    -- Keymaps configuration
    local function setup_keymaps(args)
        local opts = { buffer = args.buf, noremap = true, silent = true }

        -- Navigation
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)

        -- Workspace management
        vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

        -- Code navigation and modification
        vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts)

        -- Formatting
        vim.keymap.set("n", "<Leader>==", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- Diagnostics
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)
    end

    -- Document highlight setup
    local function setup_document_highlight(args, client)
        if client:supports_method("textDocument/documentHighlight") then
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
        -- ["basedpyright"] = function()
        --     require("plugins.lsp.basedpyright")
        -- end,
        ["pyright"] = function()
            require("plugins.lsp.pyright")
        end,
        ["terraformls"] = function()
            require("plugins.lsp.terraformls")
        end
    })
end

return Plugin
