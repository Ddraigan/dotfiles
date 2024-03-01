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
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
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

	{
		"kosayoda/nvim-lightbulb",
		event = "BufReadPre",
		config = function()
			require("nvim-lightbulb").setup({
				sign = { enabled = false },
				virtual_text = { enabled = true, text = "󰌵" },
				autocmd = { enabled = true },
				action_kinds = { "quickfix", "refactor.rewrite" },
			})
		end,
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
}
