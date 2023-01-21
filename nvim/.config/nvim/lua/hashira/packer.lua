---@diagnostic disable: missing-parameter
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({ function(use)

    -- Packer
    use { "wbthomason/packer.nvim" }

    -- Impatient nvim, reduce start-up
    use { "lewis6991/impatient.nvim" }

    -- Common utilities
    use { "nvim-lua/plenary.nvim" }

    -- Colorschemes
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Nerd icons
    use { "kyazdani42/nvim-web-devicons" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }


    -- Telescope
    use { "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-file-browser.nvim" }


    -- Lsp and Lsp installer
    use { "neovim/nvim-lspconfig" }
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }

    -- Null ls
    use { "jose-elias-alvarez/null-ls.nvim" }

    -- Autocomplete plugins (cmp)
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lua" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-cmdline" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "windwp/nvim-autopairs" }
    use { "onsails/lspkind-nvim" }
    use { "L3MON4D3/LuaSnip" }


    -- Toggle Terminal
    use { "akinsho/toggleterm.nvim" }

    -- Status line
    use { "feline-nvim/feline.nvim" }

    -- Indentlines
    use { "lukas-reineke/indent-blankline.nvim" }

    -- Git signs
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }

    -- Harpoon
    use {
        "ThePrimeagen/harpoon",
        config = function()
            require("harpoon").setup()
        end
    }

    -- Comment plugin
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }

    -- Lua dev
    use { "folke/neodev.nvim" }

    -- LaTeX (vimtex)
    use { "lervag/vimtex", ft = "tex" }


    if packer_bootstrap then
        require("packer").sync()
    end
end,

    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end
        }
    }
})
