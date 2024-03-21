local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.event = "VeryLazy"

Plugin.dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" }
}

Plugin.opts = {
    ensure_installed = {
        "lua",
        "vim",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "javascript",
        "typescript",
        "latex",
    },

    highlight = {
        enable = true,
        disable = { "latex" },
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

}

function Plugin.config(_, opts)
    require("nvim-treesitter.configs").setup(opts)
end

return Plugin
