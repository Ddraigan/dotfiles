return {
	-- Toml support
	{
		"Saecki/crates.nvim",
		dependencies = { "simrat39/rust-tools.nvim", "nvim-lua/plenary.nvim" },
		ft = "toml",
		--[[ config = function()
			require("Saecki/crates.nvim").setup({
				null_ls = {
					enabled = true,
					name = "crates",
				}
			})
		end ]]
	},
	-- emmet
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
	{ "NoahTheDuke/vim-just", ft = "just" },
	{ "IndianBoy42/tree-sitter-just", ft = "just" },
}
