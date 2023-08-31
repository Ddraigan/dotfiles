return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
	{
	    "nvim-treesitter/nvim-treesitter-context",
	    name = "treesitter-context",
	    config = true,
	},
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
	require("nvim-treesitter.configs").setup({
	    ensure_installed = { "lua", "rust", "javascript", "typescript", "tsx", "vim", "vimdoc", "regex", "bash", "markdown_inline" },
	    sync_install = false,
	    auto_install = true,
	    highlight = {
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
	})
    end,
}
