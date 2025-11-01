local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- require("none-ls.diagnostics.eslint_d"),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.pint.with({
			filetypes = { "php" },
		}),
		null_ls.builtins.formatting.phpcsfixer.with({
			filetypes = { "php" },
		}),
		null_ls.builtins.diagnostics.ltrs,
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"css",
				"javascriptreact",
				"javascript",
				"typescript",
				"typescriptreact",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
			},
		}),
		null_ls.builtins.formatting.black.with({
			filetypes = { "python" },
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
					-- vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
