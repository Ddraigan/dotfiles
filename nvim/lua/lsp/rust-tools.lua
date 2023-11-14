return {
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						require("config.utils").on_attach()
						-- Hover actions
						vim.keymap.set(
							"n",
							"<C-k>",
							rt.hover_actions.hover_actions,
							{ buffer = bufnr, desc = "[Rust]: Hover Actions" }
						)
						-- Code action groups
						vim.keymap.set(
							"n",
							"<Leader>cr",
							rt.code_action_group.code_action_group,
							{ buffer = bufnr, desc = "[Rust]: Code Action Groups" }
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
