return {
	"rcarriga/nvim-notify",
	event = "BufReadPre",
	keys = {
		{
			"<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss all Notifications",
		},
	},
	opts = {
		timeout = 10000,
		stages = "fade_in_slide_out",
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
}
