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
	selection = "#7C7F8A",
	comment = "#70747f",
	orange = "#FDC38E",
	-- ANSI
	black = "#1C1C1C", -- ANSI 0
	red = "#DD6E6B",
	green = "#87E58E",
	yellow = "#E8EDA2",
	purple = "#BAA0E8", -- used as ANSI 4 (blue)
	pink = "#E48CC1",
	cyan = "#A7DFEF",
	white = "#F6F6F5", -- ANSI 7, 'selection' used for ANSI 8
	-- indexes 9-15
	bright_red = "#E1837F",
	bright_green = "#97EDA2",
	bright_yellow = "#F6F6B6",
	bright_blue = "#D0B5F3",
	bright_magenta = "#E7A1D7",
	bright_cyan = "#BCF4F5",
	bright_white = "#FFFFFF", -- index 15

	menu = "#21222C",
	visual = "#3E4452",
	gutter_fg = "#4B5263",
	nontext = "#3B4048",
}

M.icons = {
	diagnostics = {
		-- icons / text used for a diagnostic
		error = "",
		warn = "",
		hint = "󰌵",
		info = "",
		other = "",
	},
}

M.lualine = function()
	local colours = M.colours

	local normal = {
		a = { fg = colours.black, bg = colours.purple, gui = "bold" },
		b = { fg = colours.purple, bg = colours.transparent_bg },
		c = { fg = colours.white, bg = colours.transparent_bg },
	}

	local command = {
		a = { fg = colours.black, bg = colours.cyan, gui = "bold" },
		b = { fg = colours.cyan, bg = colours.bg },
	}

	local visual = {
		a = { fg = colours.black, bg = colours.pink, gui = "bold" },
		b = { fg = colours.pink, bg = colours.bg },
	}

	local inactive = {
		a = { fg = colours.white, bg = colours.visual, gui = "bold" },
		b = { fg = colours.black, bg = colours.white },
	}

	local replace = {
		a = { fg = colours.black, bg = colours.yellow, gui = "bold" },
		b = { fg = colours.yellow, bg = colours.bg },
		c = { fg = colours.white, bg = colours.bg },
	}

	local insert = {
		a = { fg = colours.black, bg = colours.green, gui = "bold" },
		b = { fg = colours.green, bg = colours.bg },
		c = { fg = colours.white, bg = colours.bg },
	}

	return {
		normal = normal,
		command = command,
		visual = visual,
		inactive = inactive,
		replace = replace,
		insert = insert,
	}
end

return M
