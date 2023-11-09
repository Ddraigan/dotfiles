return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	config = function(_)
		local color = require("colorizer")

		color.setup({
			filetypes = {
				"*", -- Highlight all files, but customize some others.
				css = { css = true },
			},
			user_default_options = {
				css = true,
				tailwind = true,
			},
		})

		vim.defer_fn(function()
			require("colorizer").attach_to_buffer(0)
		end, 0)
	end,
}
