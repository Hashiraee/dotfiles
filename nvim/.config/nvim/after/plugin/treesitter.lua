local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup {
    ensure_installed = { 'lua', 'rust', 'go', 'python' },

    highlight = { enable = true },

    indent = {
        enable = true,
        disable = { "python" },
    },

    incremental_selection = {
        enable = false,
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },

        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist

            goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = '@class.outer',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']C'] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[C'] = '@class.outer',
            },
        },

        swap = {
            enable = true,
            swap_next = {
                -- ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                -- ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}
