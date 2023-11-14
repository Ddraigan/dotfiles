return {
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
		config = function()
			local rt = require("rust-tools")
			local on_attach = require("config.utils").on_attach
			local capabilities = require("config.utils").capabilities()

			rt.setup({
				server = {
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						-- Hover actions
						vim.keymap.set(
							"n",
							"K",
							rt.hover_actions.hover_actions,
							{ buffer = bufnr, desc = "[Rust]: Hover Actions" }
						)
					end,
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				tools = {
					reload_workspace_from_cargo_toml = true,
					runnables = {
						use_telescope = true,
					},
				},
			})
		end,
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"rouge8/neotest-rust",
		},
		opts = {
			adapters = {
				["neotest-rust"] = {},
			},
		},
	},
}
