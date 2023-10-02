return {
	-- Git DiffView
	{ "sindrets/diffview.nvim" },

	-- Git from command line support
	{ "tpope/vim-fugitive", cmd = "Git" }, -- :Git to use git in nvim
	--  { 'tpope/vim-rhubarb', event = "VeryLazy" },

	-- Git Diff and signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		dependencies = {
			{ "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
		},
		config = true,
	},
}
