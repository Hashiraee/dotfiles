local Plugin = { "lervag/vimtex" }

function Plugin.config()
    -- LaTeX files and VimTeX settings.
    vim.opt.textwidth = 80
    vim.opt.spelllang = "en_us"

    -- VimTeX settings
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_quickfix_mode = 0

    -- PDF reader setings
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
    vim.g.vimtex_view_general_options = "-r @line @pdf @tex"

    -- VimTex Compiler settings
    vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        options = {
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode",
        },
    }

    -- Skim options
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    vim.g.vimtex_view_skim_reading_bar = 1

    -- Mapping for correction
    vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { noremap = true, silent = true })

    -- Mappings for compiling
    vim.keymap.set("n", "<Leader>vs", "<Cmd>w<CR><Cmd>VimtexCompile<CR>", { noremap = true, silent = true })

    -- VimTex setting for viewing
    vim.keymap.set("n", "<leader>vv", "<Cmd>VimtexView<CR>", { noremap = true, silent = true })

    -- Focus back to terminal
    local function TexFocusVim()
        vim.api.nvim_command("silent !open -a wezterm")
    end

    local vimtex_group = vim.api.nvim_create_augroup("vimtex_group", { clear = true, })
    vim.api.nvim_create_autocmd("User", {
        group = vimtex_group,
        pattern = { "VimtexEventViewReverse" },
        callback = TexFocusVim,
    })
end

return Plugin
