return {
	"numToStr/Comment.nvim",
	config = true,
	keys = {
		{ "gcc", mode = "n", desc = "[Comment]: Toggle Current Line" },
		{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
		{ "gc", mode = "x", desc = "[Comment]: Toggle Linewise (Visual)" },
		{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
		{ "gbc", mode = "n", desc = "[Comment]: Toggle Current Block" },
		{ "gb", mode = "x", desc = "[Comment]: Toggle Blockwise (Visual)" },
	},
}
