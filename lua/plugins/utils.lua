return {
	{
		"numToStr/Comment.nvim",
		config = true,
	},

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Icons, everything uses this one :)
	"nvim-tree/nvim-web-devicons",

	{
		"ahmedkhalf/project.nvim",
		name = "project_nvim",
		opts = {
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			show_hidden = false,
		},
	},

	-- Toml support
	"Saecki/crates.nvim",

	-- Additional Lua configuration
	"folke/neodev.nvim",

	-- Vim command hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
		}
	}
}
