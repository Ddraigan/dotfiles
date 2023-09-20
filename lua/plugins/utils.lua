return {
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	-- Icons, everything uses this one :)
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"ahmedkhalf/project.nvim",
		name = "project_nvim",
		event = "VeryLazy",
		opts = {
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			show_hidden = false,
		},
	},
	-- Toml support
	{
		"Saecki/crates.nvim",
		dependencies = { "simrat39/rust-tools.nvim", "nvim-lua/plenary.nvim" },
		event = { "BufRead Cargo.toml" },
		config = function ()
			local null_ls = require("null-ls")
			require("Saecki/crates.nvim").setup({
				null_ls = {
					enabled = true,
					name = "crates",
				}
			})
		end
	},
	-- emmet
	{
		"mattn/emmet-vim",
		event = "VeryLazy",
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
			vim.o.timeoutlen = 300
		end,
		opts = {}
	}
}
