return {
	-- Easy surrounding bois changing, adding, deleting. e.g; '' to "" with cs'"
	"kylechui/nvim-surround",
	event = "BufReadPre",
<<<<<<< HEAD
	conifg = function()
=======
	config = function()
>>>>>>> d87e908c227a45bff47a08180d0f65134d63a472
		require("nvim-surround").setup({})
	end,
}
