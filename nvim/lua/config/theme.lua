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

M.lualine = function()
	local colors = M.colours

	local normal = {
		a = { fg = colors.black, bg = colors.purple, gui = "bold" },
		b = { fg = colors.purple, bg = colors.transparent_bg },
		c = { fg = colors.white, bg = colors.transparent_bg },
	}

	local command = {
		a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
		b = { fg = colors.cyan, bg = colors.bg },
	}

	local visual = {
		a = { fg = colors.black, bg = colors.pink, gui = "bold" },
		b = { fg = colors.pink, bg = colors.bg },
	}

	local inactive = {
		a = { fg = colors.white, bg = colors.visual, gui = "bold" },
		b = { fg = colors.black, bg = colors.white },
	}

	local replace = {
		a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
		b = { fg = colors.yellow, bg = colors.bg },
		c = { fg = colors.white, bg = colors.bg },
	}

	local insert = {
		a = { fg = colors.black, bg = colors.green, gui = "bold" },
		b = { fg = colors.green, bg = colors.bg },
		c = { fg = colors.white, bg = colors.bg },
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
