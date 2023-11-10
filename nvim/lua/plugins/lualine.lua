return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		opt = true,
	},
	event = "BufWinEnter",
	config = function()
		local custom_theme = require("config.theme").lualine()
		local custom_fname = require("lualine.components.filename"):extend()
		local highlight = require("lualine.highlight")
		local colours = require("config.theme").colours
		local default_status_colors = { saved = colours.green, modified = colours.cyan }

		function custom_fname:init(options)
			custom_fname.super.init(self, options)
			self.status_colors = {
				saved = highlight.create_component_highlight_group(
					{ fg = default_status_colors.saved },
					"filename_status_saved",
					self.options
				),
				modified = highlight.create_component_highlight_group(
					{ fg = default_status_colors.modified },
					"filename_status_modified",
					self.options
				),
			}
			if self.options.color == nil then
				self.options.color = ""
			end
		end

		function custom_fname:update_status()
			local data = custom_fname.super.update_status(self)
			data = highlight.component_format_highlight(
				vim.bo.modified and self.status_colors.modified or self.status_colors.saved
			) .. data
			return data
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "branch" }, "diff", "diagnostics" },
				lualine_c = { custom_fname },
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_y = {
					"encoding",
					"filetype",
					"fileformat",
				},
				lualine_z = {
					"location",
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
