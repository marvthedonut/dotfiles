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
	}
}	
