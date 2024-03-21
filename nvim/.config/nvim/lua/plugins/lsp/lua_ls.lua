local lspconfig = require("lspconfig")

---@diagnostic disable-next-line: missing-parameter
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you are using
                version = "LuaJIT",
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" }
            },
            workspace = {
                library = {
                    -- Make the server aware of Neovim runtime files
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.stdpath("config") .. "/lua"
                },
                checkThirdParty = false
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = {
                enable = false
            },
        }
    }
})
