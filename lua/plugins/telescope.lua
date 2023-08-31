return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
		"wesleimp/telescope-windowizer.nvim",
	--	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", config = function() require("telescope").load_extension("fzf") end, },
	},
	cmd = "Telescope",
	opts = {
		defaults = {
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<a-t>"] = function(...)
						return require("trouble.providers.telescope").open_selected_with_trouble(...)
					end,
				},
				n = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<a-t>"] = function(...)
						return require("trouble.providers.telescope").open_selected_with_trouble(...)
					end,
				}
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			layout_config = {
				horizontal = {
					preview_width = 0.5,
					results_width = 0.8,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 50,
			},
			file_ignore_patterns = { "node_modules", ".git" },
		},
		extensions = {
			windowizer = {
				find_cmd = "fd" -- find command. Available options [ find | fd | rg ] (defaults to "fd")
			},
		},
	},
}
