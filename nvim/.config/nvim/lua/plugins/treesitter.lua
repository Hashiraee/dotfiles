local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

ts_config.setup {
    ensure_installed = {
        "bash",
        "lua",
        "python",
        "rust",
        "go",
        "latex",
    },

    highlight = {
        enable = true,
        use_languagetree = true
    },

    autopairs = {
        enable = true,
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}
