
return {
    { 'numToStr/Comment.nvim', opts = {} },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end
    },

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },

  -- Toggle Term
    -- Added this plugin.
    {
        'akinsho/toggleterm.nvim',
        tag = "*",
        config = true
    },

    "airblade/vim-gitgutter",
    "theprimeagen/harpoon",
    "theprimeagen/refactoring.nvim",
    "bluz71/vim-nightfly-guicolors",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    'folke/neodev.nvim', 
    "tpope/vim-surround",
    "szw/vim-maximizer",
    "mbbill/undotree",


  "christoomey/vim-tmux-navigator", 

  { "mg979/vim-visual-multi" },
-- Language Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },

--    {
--        'hrsh7th/nvim-cmp',
--        dependencies = {
--            'L3MON4D3/LuaSnip',
--            'saadparwaiz1/cmp_luasnip',
    --            'rafamadriz/friendly-snippets',
    --      'hrsh7th/cmp-nvim-lsp',      
       -- },
   -- },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },


    { 
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' } 
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },


    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = 'gruvbox-materiail',
                --theme = 'onedark',
            })
        end,
    }

}
