require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "typescript", "python", "javascript", "html", "css", "html", "php", "blade" },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
