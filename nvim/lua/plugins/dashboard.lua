return {
  "glepnir/dashboard-nvim",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          -- {
          --   desc = " Apps",
          --   group = "DiagnosticHint",
          --   action = "Telescope app",
          --   key = "a",
          -- },
          {
            desc = "Last Session",
            group = "DiagnosticWarn",
            action = 'lua require("persistence").load()',
            key = "n",
          },
          {
            desc = " dotfiles",
            group = "Number",
            -- action = "e $MYVIMRC | tcd %:p:h",
            action = function()
              vim.cmd("Telescope find_files cwd=" .. vim.fn.stdpath("config"))
            end,
            key = "d",
          },
          {
            desc = " Quit",
            group = "DiagnosticError",
            action = "q",
            key = "q",
          },
        },
        footer = {},
      },
    })
    -- 	require("dashboard").setup({
    -- 		theme = "doom", --  theme is doom and hyper default is hyper
    -- 		disable_move = false, --  default is false disable move keymap for hyper
    -- 		shortcut_type = "letter", --  shorcut type 'letter' or 'number'
    -- 		change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
    -- 		config = {
    -- 			header = {
    -- 				"                                                       ",
    -- 				"                                                       ",
    -- 				"                                                       ",
    -- 				" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    -- 				" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    -- 				" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    -- 				" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    -- 				" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    -- 				" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    -- 				"                                                       ",
    -- 				"                                                       ",
    -- 				"                                                       ",
    -- 				"                                                       ",
    -- 			},
    -- 			center = {
    -- 				{
    -- 					icon = "  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Last Session                                ",
    -- 					desc_hl = "String",
    -- 					action = "lua require('persistence').load()",
    -- 					key = "n",
    -- 					key_hl = "Number",
    -- 				},
    -- 				{
    -- 					icon = "󰈞  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Find File           ",
    -- 					desc_hl = "String",
    -- 					key = "f",
    -- 					key_hl = "Number",
    -- 					action = "Telescope find_files",
    -- 				},
    -- 				{
    -- 					icon = "󰈢  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Recently opened files                   ",
    -- 					desc_hl = "String",
    -- 					action = "Telescope oldfiles",
    -- 					key = "r",
    -- 					key_hl = "Number",
    -- 				},
    -- 				{
    -- 					icon = "󰈬  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Live Grep                            ",
    -- 					desc_hl = "String",
    -- 					action = "Telescope live_grep",
    -- 					key = "g",
    -- 					key_hl = "Number",
    -- 				},
    -- 				{
    -- 					icon = "  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Open Nvim config                        ",
    -- 					desc_hl = "String",
    -- 					action = "tabnew $MYVIMRC | tcd %:p:h",
    -- 					key = "c",
    -- 					key_hl = "Number",
    -- 				},
    -- 				{
    -- 					icon = "󰗼  ",
    -- 					icon_hl = "Title",
    -- 					desc = "Quit Nvim                               ",
    -- 					desc_hl = "String",
    -- 					action = "qa",
    -- 					key = "q",
    -- 					key_hl = "Number",
    -- 				},
    -- 			},
    -- 		},
    -- 		hide = {
    -- 			statusline = true, -- hide statusline default is true
    -- 			tabline = false, -- hide the tabline
    -- 			winbar = false, -- hide winbar
    -- 		},
    -- 		preview = {},
    -- 	})
  end,
}
