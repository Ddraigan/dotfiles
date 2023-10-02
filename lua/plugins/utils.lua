return {
	--[[ {
		"kdheepak/lazygit.nvim",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	}, ]]
	{
		"numToStr/Comment.nvim",
		config = true,
		keys = {
			{ "gcc", mode = "n", desc = "[Comment]: Toggle Current Line" },
			--	{ "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "[Comment]: Toggle Linewise (Visual)" },
			{ "gbc", mode = "n", desc = "[Comment]: Toggle Current Block" },
			--	{ "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "[Comment]: Toggle Blockwise (Visual)" },
		},
	},
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},
	-- Icons, everything uses this one :)
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			require("nvim-web-devicons").setup({
				override_by_extension = {
					astro = {
						icon = "",
						color = "#EF8547",
						name = "astro",
					},
				},
			})
		end,
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
	-- Additional Lua configuration
	{
		"folke/neodev.nvim",
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
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
