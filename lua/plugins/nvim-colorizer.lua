return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	config = function()
		local color = require("colorizer")

		color.setup({
			--	"html",
			--	"javascript",
			--	"typescript",
			--	"css",
			--	"yaml",
			"*",
			css = { css = true },
		})

		vim.defer_fn(function()
			require("colorizer").attach_to_buffer(0)
		end, 0)
	end,
}
