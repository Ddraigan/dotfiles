return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function(_)
		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				-- you can turn off/on auto_update per tool
				{ "astro-language-server" },
				{ "lua-language-server" },
				{ "stylua" },
				{ "html-lsp" },
				{ "emmet-ls" },
				{ "rust_analyzer" },
				{ "css-lsp" },
				{ "json-lsp" },
				{ "prettier" },
				{ "typescript-language-server" },
				{ "eslint_d" },
				{ "eslint-lsp" },
				{ "codelldb" },
				{ "tsserver" },
				{ "tailwindcss-language-server" },
			},
			auto_update = true,
		})
		mason_tool_installer.run_on_start()
	end,
}
