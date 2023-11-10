return {
	"Mofiqul/dracula.nvim",
	lazy = false,
	config = function()
		local dracula = require("dracula")
		local colours = require("config.theme").colours
		dracula.setup({
			-- customize dracula color palette
			colors = colours,
			-- show the '~' characters after the end of buffers
			show_end_of_buffer = true, -- default false
			-- use transparent background
			transparent_bg = true, -- default false
			lualine_bg_color = colours.bg, -- default nil
			-- set italic comment
			italic_comment = true, -- default false
			-- overrides the default highlights with table see `:h synIDattr`
			-- You can use overrides as table like this
			-- overrides = {
			--   NonText = { fg = "white" }, -- set NonText fg to white
			--   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
			--   Nothing = {} -- clear highlight of Nothing
			-- },
			--[[ overrides = function(colors)
				return {
					NonText = { fg = colors.white },
				}
			end, ]]
			-- Or you can also use it like a function to get color from theme
			-- overrides = function (colors)
			--   return {
			--     NonText = { fg = colors.white }, -- set NonText fg to white of theme
			--   }
			-- end,
		})

		vim.cmd.colorscheme("dracula")
	end,
}
