return {
	"mrcjkb/rustaceanvim",
	event = "BufReadPost",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = function()
			local on_attach = require("config.utils").on_attach
			local capabilities = require("config.utils").capabilities()
			return {
				capabilities = capabilities,
				server = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						vim.keymap.set(
							"n",
							"K",
							"<cmd> RustLsp hover actions <CR>",
							{ buffer = bufnr, desc = "[Rust]: Hover Actions" }
						)
						vim.keymap.set(
							"n",
							"<leader>la",
							"<cmd> RustLsp codeAction <CR>",
							{ buffer = bufnr, desc = "[Rust]: Code Actions" }
						)
						vim.keymap.set(
							"n",
							"<leader>le",
							"<cmd> RustLsp explainError <CR>",
							{ buffer = bufnr, desc = "[Rust]: Explain Errors" }
						)
						vim.keymap.set(
							"n",
							"<leader>lj",
							"<cmd> RustLsp joinLines <CR>",
							{ buffer = bufnr, desc = "[Rust]: Join Lines" }
						)
					end,
					settings = {
						-- ["rust-analyzer"] = {},
					},
				},
			}
		end
	end,
}
