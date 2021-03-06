local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    print("Something wrong with lsp-installer...")
    return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("lsp/handlers").on_attach,
        capabilities = require("lsp/handlers").capabilities,
    }

    if server.name == "sumneko_lua" then
        local sumneko_opts = require("lsp/settings/sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end


    if server.name == "rust_analyzer" then
        local rust_opts = require("lsp/settings/rust_analyzer")
        opts = vim.tbl_deep_extend("force", rust_opts, opts)
    end

    server:setup(opts)
end)
