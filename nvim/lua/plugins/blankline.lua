return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = false,
	main = "ibl",
	config = function()
		-- local colour = require("config.theme").colours
		-- local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		-- 	vim.api.nvim_set_hl(0, "BrightGreen", { fg = colour.bright_green })
		-- end)
		require("ibl").setup({
			scope = { enabled = true },
			-- indent = { highlight = "BrightGreen" },
		})
	end,
}
