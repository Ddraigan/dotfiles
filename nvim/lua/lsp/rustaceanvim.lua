return {
	"mrcjkb/rustaceanvim",
	event = "BufReadPost",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	ft = { "rust" },
	opts = function(_)
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
					-- vim.keymap.set(
					-- 	"n",
					-- 	"<leader>la",
					-- 	"<cmd> RustLsp codeAction <CR>",
					-- 	{ buffer = bufnr, desc = "[Rust]: Code Actions" }
					-- )
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
			tools = {
				inlay_hints = {
					auto = true,
					show_parameter_hints = true,
					parameter_hints_prefix = "  <-- ",
					only_current_line = false,
					other_hints_prefix = "  --> ",
				},
			},
		}
	end,
	config = function(_, opts)
		vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
	end,
}
