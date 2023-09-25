return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- mason-lspconfig
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls", -- Lua LSP
				"css-lsp", -- CSS LSP
				"json-lsp", -- JSON LSP
				"rust_analyzer", -- Rust LSP
				"codelldb", -- Rust Debug
				"astro-ls", --Astro LSP
			},
			-- auto installation
			automatic_installation = true,
		})

		-- mason-tool-installer
		mason_tool_installer.setup({
			ensure_installed = {
				-- you can turn off/on auto_update per tool
				{ "astro-language-server" },
				{ "bash-language-server" },
				{ "lua-language-server" },
				{ "vim-language-server" },
				{ "stylua" },
				{ "editorconfig-checker" },
				{ "html-lsp" },
				{ "emmet-ls" },
				{ "css-lsp" },
				{ "json-lsp" },
				{ "prettier" },
				{ "typescript-language-server" },
				{ "eslint_d" },
				{ "eslint-lsp" },
				{ "codelldb" },
				{ "tailwindcss-language-server" },
			},

			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5, -- at least 5 hours between attempts to install/update
		})
	end,
}
