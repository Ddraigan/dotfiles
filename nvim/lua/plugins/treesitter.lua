return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			name = "treesitter-context",
			config = true,
		},
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
	},
	cmd = { "Treesitter" },
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		-- the mdx filetype will use the markdown parser and queries.
		vim.treesitter.language.register("markdown", "mdx")
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"rust",
				"javascript",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
				"regex",
				"bash",
				"markdown_inline",
				"astro",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select outer part of a Function" },
						["if"] = { query = "@function.inner", desc = "Select inner part of a Function" },
						["ac"] = { query = "@class.outer", desc = "Select inner part of a Class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a Class" },
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language Scope" },
					},
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
