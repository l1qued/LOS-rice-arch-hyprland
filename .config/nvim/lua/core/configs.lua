vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
	virtual_text = true, -- Показывать текст ошибок рядом с кодом
	signs = true, -- Показывать знаки (например, "E" в гаттере)
	underline = true, -- Подсвечивать проблемные строки
	float = { -- Настройки всплывающих окон
		show_header = true,
		source = "always", -- Показывать источник ошибки (например, none-ls)
		border = "single",
	},
})
