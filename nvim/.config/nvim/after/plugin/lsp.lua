local luadev_status, neodev = pcall(require, "neodev")
if not luadev_status then
    return
end

neodev.setup {}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

local mason_lspconfig_status, _ = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

mason.setup {}

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = false,
    underline = false,
    severity_sort = true,

    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)

-- Diagnostics keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, opts)

-- For hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

-- For signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- Highlight words under cursor.
local function lsp_document_highlight(client)
    if client.server_capabilities.documentHighlightProvider then
        local document_highlight_group = vim.api.nvim_create_augroup(
            'LspDocumentHighlight', { clear = true }
        )

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
            group = document_highlight_group,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
            group = document_highlight_group,
        })
    end
end

-- Keymappings
local function lsp_keymaps(bufnr)
    local attach_opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, attach_opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, attach_opts)

    -- Workspace stuff
    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, attach_opts)

    -- Code actions and formatting
    vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, attach_opts)
    vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, attach_opts)
    vim.keymap.set('n', '<Leader>ls', vim.lsp.buf.signature_help, attach_opts)
end

-- Add mappings and highlighting on attach.
local on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_document_highlight(client)

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

-- Nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { "rust_analyzer", "sumneko_lua", "texlab", "pyright", "r_language_server" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup {
    ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Configuration for Lua
local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },

            diagnostics = {
                globals = { 'vim' },
            },

            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },

            telemetry = { enable = false, },
        },
    },
}
