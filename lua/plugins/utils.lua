return {
	{
		"numToStr/Comment.nvim",
		config = true,
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			--	{ "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			--	{ "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
	},
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	{
		{
			"wuelnerdotexe/vim-astro",
			config = function()
				vim.cmd([[let g:astro_typescript = 'enable']])
			end,
		},
	},
	-- Icons, everything uses this one :)
	{
		"nvim-tree/nvim-web-devicons",
	},
	--[[ {
		"ahmedkhalf/project.nvim",
		name = "project_nvim",
		event = "VeryLazy",
		opts = {
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			show_hidden = false,
		},
	}, ]]
	-- Toml support
	{
		"Saecki/crates.nvim",
		dependencies = { "simrat39/rust-tools.nvim", "nvim-lua/plenary.nvim" },
		ft = { "toml" },
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
	-- Additional Lua configuration
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
	},
	-- Vim command hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
	{ "NoahTheDuke/vim-just", ft = "just" },
	{ "IndianBoy42/tree-sitter-just", ft = "just" },
}
