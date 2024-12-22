local Plugin = { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }

Plugin.dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" }
}

function Plugin.config()
    local treesitter = require("nvim-treesitter.configs")
    ---@diagnostic disable-next-line: missing-fields
    treesitter.setup({
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "regex",
            "yaml",
            "bash",
            "python",
            "go",
            "rust",
            "javascript",
            "typescript",
            "terraform",
            "hcl",
            "bicep",
        },

        auto_install = false,

        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                }
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },
        },
    })
end

return Plugin
