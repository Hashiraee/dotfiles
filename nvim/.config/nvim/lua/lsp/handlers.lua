local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
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

    -- Diagnostics keymaps
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

-- Highlight words under cursor.
local function lsp_document_highlight(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],

        false)
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
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, attach_opts)

    -- Code actions and formatting
    vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, attach_opts)
    vim.keymap.set('n', '<Leader>==', vim.lsp.buf.formatting, attach_opts)
end

-- Add mappings and highlighting on attach.
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_document_highlight(client)
end

-- Add lsp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add lsp completion from cmp
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    print("Something wrong with cmp_lsp in handlers...")
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
