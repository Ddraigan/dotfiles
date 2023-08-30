return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
	-- add any options here
    },
    dependencies = {
	-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	"MunifTanjim/nui.nvim",
	-- OPTIONAL:
	--   `nvim-notify` is only needed, if you want to use the notification view.
	--   If not available, we use `mini` as the fallback
	"rcarriga/nvim-notify",
    },
    commands = {
	history = {
	    -- options for the message history that you get with `:Noice`
	    view = "split",
	    opts = { enter = true, format = "details" },
	    filter = {
		any = {
		    { event = "notify" },
		    { error = true },
		    { warning = true },
		    { event = "msg_show", kind = { "" } },
		    { event = "lsp", kind = "message" },
		},
	    },
	},
	-- :Noice last
	last = {
	    view = "popup",
	    opts = { enter = true, format = "details" },
	    filter = {
		any = {
		    { event = "notify" },
		    { error = true },
		    { warning = true },
		    { event = "msg_show", kind = { "" } },
		    { event = "lsp", kind = "message" },
		},
	    },
	    filter_opts = { count = 1 },
	},
	-- :Noice errors
	errors = {
	    -- options for the message history that you get with `:Noice`
	    view = "popup",
	    opts = { enter = true, format = "details" },
	    filter = { error = true },
	    filter_opts = { reverse = true },
	},
    },
}
