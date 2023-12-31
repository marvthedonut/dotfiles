require('nvim-treesitter.configs').setup {
	ensure_installed = { "vim", 'vimdoc', 'lua', 'cpp', 'python', "bash", "rasi", "typescript" },
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
}

