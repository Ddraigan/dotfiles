return {
	"yamatsum/nvim-cursorline",
	event = { "CursorMoved", "CursorHold" },
	config = function()
		vim.api.nvim_set_hl(0, "CursorLine", { bg = require("config.theme").colours.menu })
		require("nvim-cursorline").setup({
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
		})
	end,
}
