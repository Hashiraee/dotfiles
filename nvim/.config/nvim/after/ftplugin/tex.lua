-- LaTeX files and VimTeX settings.

-- Syntax settings
vim.cmd('syntax enable')
vim.opt.textwidth = 80

-- Spell setting
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- VimTeX settings
vim.g.tex_flavor = 'latex'
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    options = {
        '-lualatex',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

-- Mapping for correction
vim.keymap.set('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc><Cmd>w<Cr><Cmd>VimtexCompile<Cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', '<Cmd>w<Cr><Cmd>VimtexCompile<Cr>', { noremap = true, silent = true })
