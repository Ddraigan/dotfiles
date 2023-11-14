return {
	-- Toml support
	{
		"Saecki/crates.nvim",
		dependencies = { "simrat39/rust-tools.nvim", "nvim-lua/plenary.nvim" },
		ft = "toml",
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates",
				},
			})
		end,
	},
	{
		"mattn/emmet-vim",
	},
	{
		"wuelnerdotexe/vim-astro",
		ft = "astro",
		config = function()
			vim.cmd([[let g:astro_typescript = 'enable']])
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{ "NoahTheDuke/vim-just", ft = "just" },
	{ "IndianBoy42/tree-sitter-just", ft = "just" },
}
