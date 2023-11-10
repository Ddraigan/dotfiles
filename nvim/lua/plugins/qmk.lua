return {
	"codethread/qmk.nvim",
	event = "VeryLazy",
	config = function()
		local qmk = require("qmk")
		qmk.setup({
			name = "LAYOUT",
			layout = { -- create a visual representation the final layout
				"x x x x x x _ _ _ _ _ _ x x x x x x",
				"x x x x x x _ _ _ _ _ _ x x x x x x",
				"x x x x x x x x _ _ x x x x x x x x",
				"_ _ _ x x x x x _ _ x x x x x _ _ _",
			},
		})
	end,
}
