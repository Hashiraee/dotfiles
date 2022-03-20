local packer

local present, _ = pcall(require, "packerinit")
if present then
    packer = require "packer"
else
    return false
end

local use = packer.use
return packer.startup(
    function()
        use
        {
            "wbthomason/packer.nvim",
        }


        -- Impatient nvim, reduce start-up
        use
        {
            "lewis6991/impatient.nvim",
        }


        -- Colorschemes
        use
        {
            "catppuccin/nvim",
        }


        -- Treesitter
        use
        {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("plugins/treesitter")
            end
        }

        use
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
        }


        -- Telescope
        use
        {
            "nvim-lua/plenary.nvim",
        }

        use
        {
            "nvim-telescope/telescope.nvim",
            after = "plenary.nvim",
            config = function()
                require("plugins/telescope")
            end
        }

        use
        {
            "nvim-telescope/telescope-ui-select.nvim",
            after = "telescope.nvim",
        }

        use
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            cmd = "Telescope"
        }


        -- Lsp and Lsp installer
        use
        {
            "neovim/nvim-lspconfig",
        }

        use
        {
            "williamboman/nvim-lsp-installer",
        }


        -- Autocomplete plugins (cmp)
        use
        {
            "hrsh7th/nvim-cmp",
            config = function()
                require("plugins/cmp")
            end
        }

        use
        {
            "hrsh7th/cmp-nvim-lua",
        }

        use
        {
            "hrsh7th/cmp-nvim-lsp",
        }

        use
        {
            "saadparwaiz1/cmp_luasnip",
            after = "nvim-cmp",
        }

        -- Luasnip
        use
        {
            "L3MON4D3/LuaSnip",
            after = "nvim-cmp",
            config = function()
                require("plugins/snippets")
            end
        }

        -- Lspkind
        use
        {
            "onsails/lspkind-nvim",
        }

        -- Autopairs
        use
        {
            "windwp/nvim-autopairs",
            config = function()
                require("plugins/autopairs")
            end
        }


        -- Nvim File Tree
        use
        {
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("plugins/nvimtree")
            end,
        }

        use
        {
            "kyazdani42/nvim-web-devicons",
        }


        -- Toggle Terminal
        use
        {
            "akinsho/nvim-toggleterm.lua",
            config = function()
                require("plugins/toggleterm")
            end
        }


        -- Smooth scrolling
        use
        {
            "karb94/neoscroll.nvim",
            event = "WinScrolled",
            config = function()
                require("plugins/others").neoscroll()
            end
        }


        -- Bufferline (tabs)
        use
        {
            "akinsho/bufferline.nvim",
            config = function()
                require("plugins/bufferline")
            end
        }


        -- Status line
        use
        {
            "feline-nvim/feline.nvim",
            config = function()
                require("plugins/statusline")
            end
        }


        -- Git signs
        use
        {
            "lewis6991/gitsigns.nvim",
            after = "plenary.nvim",
            config = function()
                require("plugins/gitsigns")
            end
        }


        -- Comment plugin
        use
        {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }


        -- LaTeX (vimtex)
        use
        {
            "lervag/vimtex",
            ft = "tex",
        }


        -- Spellsitter
        use
        {
            "lewis6991/spellsitter.nvim",
            config = function()
                require("spellsitter").setup()
            end
        }


        -- Use indentlines
        use
        {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("plugins/indent-blankline")
            end
        }


    end
)
