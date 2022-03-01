return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                -- Setting up lua path
                path = vim.split(package.path, ";"),
            },

            diagnostics = {
                globals = {"vim"},
            },

            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}
