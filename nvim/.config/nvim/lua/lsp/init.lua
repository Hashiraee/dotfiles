local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("Something wrong with lsp configuration...")
    return
end

require("lsp/lsp-installer")
require("lsp/handlers").setup()
