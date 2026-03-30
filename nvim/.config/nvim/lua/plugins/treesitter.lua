-- Highlight, edit, and navigate code.
local Plugin = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                max_lines = 3,
                multiline_threshold = 1,
                min_window_height = 20,
            },
        },
    },
}

function Plugin.config(_, opts)
    require("nvim-treesitter").setup(opts)

    -- Make sure that the following are installed:
    require("nvim-treesitter").install({
        "bash",
        "bicep",
        "c_sharp",
        "c",
        "go",
        "hcl",
        "javascript",
        "lua",
        "markdown_inline",
        "markdown",
        "python",
        "query",
        "regex",
        "rust",
        "terraform",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
    })
end

return Plugin
