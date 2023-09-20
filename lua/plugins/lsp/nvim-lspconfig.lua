return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "litao91/lsp_lines" },
		{ "ray-x/lsp_signature.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local on_attach = function()
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "Go To Declaration", silent = true, buffer = 0 })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "Go To Definition", silent = true, buffer = 0 })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "Hover", silent = true, buffer = 0 })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, desc = "Go To Implementation", silent = true, buffer = 0 })
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { noremap = true, desc = "Rename", silent = true, buffer = 0 })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, desc = "Go To References", silent = true, buffer = 0 })
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, { noremap = true, desc = "Format", silent = true, buffer = 0 })
			vim.keymap.set("n", "<space>df", vim.diagnostic.goto_next, { noremap = true, desc = "Go To Next Diagnostic", silent = true, buffer = 0 })
		end

		local servers = { "lua_ls", "pyright", "html", "tsserver", "rust_analyzer" }
		for _, lsp in pairs(servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end

		-- rust_analyzer
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			-- Server-specific settings. See `:help lspconfig-setup`
			settings = {
				["rust-analyzer"] = {},
			},
		})
		-- configure emmet language server
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})
		-- Lua LS
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		-- Tailwind
		-- Support for tailwind auto completion
		-- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})
	end
}
