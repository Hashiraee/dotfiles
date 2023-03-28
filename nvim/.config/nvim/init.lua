local load = function(mod)
    package.loaded[mod] = nil
    require(mod)
end

load("config.options")
load("config.lazy")
load("config.keymaps")
load("config.autocmds")

vim.cmd.colorscheme("catppuccin")
