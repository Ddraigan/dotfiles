return {
	"glepnir/dashboard-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom", --  theme is doom and hyper default is hyper
			disable_move = false, --  default is false disable move keymap for hyper
			shortcut_type = "letter", --  shorcut type 'letter' or 'number'
			change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
			config = {
				header = {
					"                                                       ",
					"                                                       ",
					"                                                       ",
					" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"                                                       ",
					"                                                       ",
					"                                                       ",
					"                                                       ",
				},
				center = {
					{
						icon = "󰈞  ",
						desc = "Find  File                              ",
						action = "Leaderf file --popup",
						key = "<Leader> f f",
					},
					{
						icon = "󰈢  ",
						desc = "Recently opened files                   ",
						action = "Leaderf mru --popup",
						key = "<leader> something something",
					},
					{
						icon = "󰈬  ",
						desc = "Live Grep                            ",
						action = "Leaderf rg --popup",
						key = "<Leader> f g",
					},
					{
						icon = "  ",
						desc = "Open Nvim config                        ",
						action = "tabnew $MYVIMRC | tcd %:p:h",
						key = "<Leader> something something",
					},
					{
						icon = "  ",
						desc = "New file                                ",
						action = "enew",
						key = "e",
					},
					{
						icon = "󰗼  ",
						desc = "Quit Nvim                               ",
						-- desc = "Quit Nvim                               ",
						action = "qa",
						key = "q",
					},
				},
			},
			hide = {
				statusline = true, -- hide statusline default is true
				tabline = false, -- hide the tabline
				winbar = false, -- hide winbar
			},
			preview = {},
		})
	end,
}
