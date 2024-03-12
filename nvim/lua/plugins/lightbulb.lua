return {
	"kosayoda/nvim-lightbulb",
	event = "BufReadPre",
	config = function()
		require("nvim-lightbulb").setup({
			sign = { enabled = false },
			virtual_text = { enabled = true, text = require("config.theme").icons.diagnostics.hint },
			autocmd = { enabled = true },
			action_kinds = { "quickfix" },
		})
	end,
}
