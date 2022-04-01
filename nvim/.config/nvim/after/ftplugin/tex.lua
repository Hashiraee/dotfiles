-- Stuff for LaTeX files and VimTeX settings.
vim.cmd[[
syntax enable
set spell

let g:vimtex_compiler_latexmk={
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-lualatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u 

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
]]
