-- Additional Lua configuration
return {
	"folke/neodev.nvim",
	config = function()
		require("neodev").setup({
			library = {
				plugins = true,
				types = true,
			},
		})
	end,
}
