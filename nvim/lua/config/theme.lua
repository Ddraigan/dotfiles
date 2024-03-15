local M = {}

---@class Palette
M.colours = {
	bg = "#282A36",
	fg = "#F8F8F2",
	transparent_bg = nil,

	black = "#191A21",
	cyan = "#8BE9FD",
	green = "#50fa7b",
	orange = "#FFB86C",
	pink = "#FF79C6",
	purple = "#BD93F9",
	red = "#FF5555",
	white = "#ABB2BF",
	yellow = "#F1FA8C",

	bright_blue = "#D6ACFF",
	bright_cyan = "#A4FFFF",
	bright_green = "#69FF94",
	bright_magenta = "#FF92DF",
	bright_red = "#FF6E6E",
	bright_white = "#FFFFFF",
	bright_yellow = "#FFFFA5",

	comment = "#6272A4",
	selection = "#44475A",
	menu = "#21222C",
	visual = "#3E4452",
	gutter_fg = "#4B5263",
	nontext = "#3B4048",
}

-- Can name to colours to switch pallete
---@type Palette
M.soft = {
	bg = "#292A35", --
	fg = "#F6F6F5",
	transparent_bg = nil,
	-- ANSI
	black = "#1C1C1C", -- ANSI 0
	cyan = "#A7DFEF",
	green = "#87E58E",
	orange = "#FDC38E",
	pink = "#E48CC1",
	purple = "#BAA0E8", -- used as ANSI 4 (blue)
	white = "#F6F6F5", -- ANSI 7, 'selection' used for ANSI 8
	red = "#DD6E6B",
	yellow = "#E8EDA2",
	-- indexes 9-15
	bright_blue = "#D0B5F3",
	bright_cyan = "#BCF4F5",
	bright_green = "#97EDA2",
	bright_magenta = "#E7A1D7",
	bright_red = "#E1837F",
	bright_white = "#FFFFFF", -- index 15
	bright_yellow = "#F6F6B6",

	comment = "#70747f",
	selection = "#7C7F8A",
	menu = "#21222C",
	visual = "#3E4452",
	gutter_fg = "#4B5263",
	nontext = "#3B4048",
}

M.icons = {
	diagnostics = {
		error = "",
		warn = "",
		hint = "󰌵",
		info = "",
		other = "",
	},
	cmp = {
		Text = " ",
		Method = "󰆧",
		Function = "ƒ ",
		Constructor = " ",
		Field = "󰜢 ",
		Variable = " ",
		Constant = " ",
		Class = " ",
		Interface = "󰜰 ",
		Struct = " ",
		Enum = "了 ",
		EnumMember = " ",
		Module = "",
		Property = " ",
		Unit = " ",
		Value = "󰎠 ",
		Keyword = "󰌆 ",
		Snippet = " ",
		File = " ",
		Folder = " ",
		Color = " ",
	},
	mason = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗",
	},
}

local colours = M.colours
M.lualine = function()
	return {
		normal = {
			a = { fg = colours.black, bg = colours.purple, gui = "bold" },
			b = { fg = colours.purple, bg = colours.transparent_bg },
			c = { fg = colours.white, bg = colours.transparent_bg },
		},
		command = {
			a = { fg = colours.black, bg = colours.cyan, gui = "bold" },
			b = { fg = colours.cyan, bg = colours.bg },
		},
		visual = {
			a = { fg = colours.black, bg = colours.pink, gui = "bold" },
			b = { fg = colours.pink, bg = colours.bg },
		},
		inactive = {
			a = { fg = colours.white, bg = colours.visual, gui = "bold" },
			b = { fg = colours.black, bg = colours.white },
		},
		replace = {
			a = { fg = colours.black, bg = colours.yellow, gui = "bold" },
			b = { fg = colours.yellow, bg = colours.bg },
			c = { fg = colours.white, bg = colours.bg },
		},
		insert = {
			a = { fg = colours.black, bg = colours.green, gui = "bold" },
			b = { fg = colours.green, bg = colours.bg },
			c = { fg = colours.white, bg = colours.bg },
		},
	}
end

return M
