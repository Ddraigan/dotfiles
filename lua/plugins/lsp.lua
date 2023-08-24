return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{'williamboman/mason.nvim'},           -- Optional
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
	},

	config = function()
		local lsp = require('lsp-zero').preset({})

		lsp.ensure_installed({
			"tsserver",
			"eslint",
			"rust_analyzer",
		})

		local cmp = require("cmp")
		local cmp_select = {behavior = cmp.SelectBehavior.Select}
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
			["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		})

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings
		})

		lsp.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			-- lsp.default_keymaps({buffer = bufnr})
			local opts = {buffer = bufnr, remap = false}

			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_referencs, opts)
		end)

		-- (Optional) Configure lua language server for neovim
		require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

		lsp.setup()
	end
}
