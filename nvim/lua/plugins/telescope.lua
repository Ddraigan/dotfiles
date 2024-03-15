return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
		"wesleimp/telescope-windowizer.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- "ThePrimeagen/harpoon",
	},
	cmd = "Telescope",
	config = function()
		local opts = {
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
					},
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
				file_ignore_patterns = { "node_modules" },
				preview = {
					mime_hook = function(filepath, bufnr, opts)
						local is_image = function(filepath)
							local image_extensions = { "png", "jpg" } -- Supported image formats
							local split_path = vim.split(filepath:lower(), ".", { plain = true })
							local extension = split_path[#split_path]
							return vim.tbl_contains(image_extensions, extension)
						end
						if is_image(filepath) then
							local term = vim.api.nvim_open_term(bufnr, {})
							local function send_output(_, data, _)
								for _, d in ipairs(data) do
									vim.api.nvim_chan_send(term, d .. "\r\n")
								end
							end
							vim.fn.jobstart({
								"catimg",
								filepath, -- Terminal image viewer command
							}, { on_stdout = send_output, stdout_buffered = true, pty = true })
						else
							require("telescope.previewers.utils").set_preview_message(
								bufnr,
								opts.winid,
								"Binary cannot be previewed"
							)
						end
					end,
				},
			},
			pickers = {
				lsp_references = {
					path_display = { "truncate" },
				},
			},
			extensions = {
				windowizer = {
					find_cmd = "fd", -- find command. Available options [ find | fd | rg ] (defaults to "fd")
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			},
		}

		local colours = require("config.theme").colours
		local TelescopeColor = {
			TelescopeMatching = { fg = colours.pink },
			TelescopeSelection = { fg = colours.cyan, bg = colours.selection, bold = true },

			TelescopePromptPrefix = { bg = colours.transparent_bg },
			TelescopePromptNormal = { bg = colours.transparent_bg },
			TelescopeResultsNormal = { bg = colours.transparent_bg },
			TelescopePreviewNormal = { bg = colours.transparent_bg },
			TelescopePromptBorder = { bg = colours.transparent_bg, fg = colours.comment },
			TelescopeResultsBorder = { bg = colours.transparent_bg, fg = colours.comment },
			TelescopePreviewBorder = { bg = colours.transparent_bg, fg = colours.comment },
			TelescopePromptTitle = { bg = colours.transparent_bg, fg = colours.comment },
			TelescopeResultsTitle = { fg = colours.cyan },
			TelescopePreviewTitle = { bg = colours.transparent_bg, fg = colours.cyan },
		}

		for hl, col in pairs(TelescopeColor) do
			vim.api.nvim_set_hl(0, hl, col)
		end

		require("telescope").setup(opts)
		require("telescope").load_extension("windowizer")
		require("telescope").load_extension("fzf")

		-- require("telescope").load_extension("harpoon")
	end,
}
