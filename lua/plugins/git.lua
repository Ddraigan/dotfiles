return {
	-- Git from command line support
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

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
