return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
	},
	cmd = "Telescope",
	init = function()
		local nnoremap = require("keymap").nnoremap

		nnoremap("<leader>fp", "<cmd>Telescope projects<CR>")
		nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
		nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
		nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")
		nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
		-- Open with trouble, doesn't work yet
		-- nnoremap("<leader>ft", "<cmd>Trouble open_with_trouble<CR>")
	end,
	opts = {
		defaults = {
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
			mappings = {
				n = {
					["<leader>ft"] = function() require("trouble.providers.telescope").open_with_trouble() end,
				}
			},
			file_ignore_patterns = { "node_modules", "git" },
		},
	},
}
