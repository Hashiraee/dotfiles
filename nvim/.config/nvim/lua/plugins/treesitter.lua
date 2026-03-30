-- Highlight, edit, and navigate code.
local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.branch = "main"

Plugin.build = ":TSUpdate"

Plugin.lazy = false

Plugin.dependencies = {
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
            min_window_height = 20,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
    },
}

function Plugin.config(_, opts)
    require("nvim-treesitter").setup(opts)

    -- Textobjects
    require("nvim-treesitter-textobjects").setup({
        select = {
            lookahead = true,
        },
        move = {
            set_jumps = true,
        },
    })

    -- Select
    vim.keymap.set({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end)

    -- Move
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[F", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end)

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
