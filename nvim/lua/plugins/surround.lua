return {
	-- Easy surrounding bois changing, adding, deleting. e.g; '' to "" with cs'"
	"kylechui/nvim-surround",
	event = "BufReadPre",
	config = function()
		require("nvim-surround").setup({})
	end,
}
