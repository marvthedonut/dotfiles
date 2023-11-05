return {
    {
	"numToStr/Comment.nvim",
	config = function()
	    require("Comment").setup()
	end
    },
    {
	"navarasu/onedark.nvim",
	priority=1000,
	config = function()
	    require("onedark").setup {
		transparent = true,
	    }
	    vim.cmd("colorscheme onedark")
	end
    },
    {
		"nvim-lualine/lualine.nvim",
		dependencies = {
		"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("lualine").setup({
				icons_enabled = true,
				theme = "onedark",
			})
		end
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",

		"folke/neodev.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = 'make',
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'nvim-treesitter/nvim-treesitter',
		buildy = ':TSUpdate',
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function ()
			require("gitsigns").setup()
		end
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		brach = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
}
