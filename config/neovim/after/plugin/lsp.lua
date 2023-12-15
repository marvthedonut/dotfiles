local on_attach = function(_, bufnr)

	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap('<leader>r', vim.lsp.buf.rename)
	bufmap('<leader>a', vim.lsp.buf.code_action)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)


	bufmap('K', vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		"tsserver",
	},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup {
				on_attach = on_attach,
				capabilties = capabilities,
			}
		end,

		["lua_ls"] = function()
			require("neodev").setup()
			require("lspconfig").lua_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false }
				},
			}
		end,
		["tsserver"] = function()
			require("lspconfig").tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "typescript" },
				cmd = { "typescript-language-server", "--stdio" },
				settings = {
					completions = {
						completeFunctionCalls = true
					}
				}
			})
		end,
		["pylsp"] = function()
			require("lspconfig").pylsp.setup({})
		end,
		["bashls"] = function()
			require("lspconfig").bashls.setup({})
		end,
		["clangd"] = function()
			require("lspconfig").clangd.setup({})
		end
	}
})
