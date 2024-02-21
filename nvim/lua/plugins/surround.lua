return {
	-- Easy surrounding bois changing, adding, deleting. e.g; '' to "" with cs'"
	"tpope/vim-surround",
	event = "BufReadPre",
	conifg = function()
		require("nvim-surround").setup({})
	end,
}
