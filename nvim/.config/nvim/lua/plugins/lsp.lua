local diagnostic_icons = {
    ERROR = "",
    WARN = "",
    HINT = "",
    INFO = "",
}

local methods = vim.lsp.protocol.Methods

local Plugin = {}

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Navigation keymaps from old config
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

    -- Diagnostics navigation from new config
    vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump { count = -1 }
    end, opts)
    vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump { count = 1 }
    end, opts)
    vim.keymap.set('n', '[e', function()
        vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
    end, opts)
    vim.keymap.set('n', ']e', function()
        vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
    end, opts)

    -- Diagnostics lists
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
    vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)

    if client:supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('Hashiraee/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Define the diagnostic signs using the old config's icons
for severity, icon in pairs(diagnostic_icons) do
    local hl = 'DiagnosticSign' .. severity:sub(1, 1) .. severity:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration from old config
vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        },
        linehl = {},
    },

    -- Virtual Text - disabled as per old config
    virtual_text = false,

    -- Diagnostic window style from old config
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
}

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
        focusable = true,
        border = "rounded",
    }
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
    return signature_help {
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
        focusable = true,
        border = "rounded",
    }
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ':t:r')
            end)
            :totable()
        vim.lsp.enable(server_configs)
    end,
})

return Plugin
