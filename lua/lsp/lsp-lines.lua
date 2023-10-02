return {
	"litao91/lsp_lines",
	config = function()
		local lines = require("lsp_lines")
		lines.setup({
			vim.keymap.set("n", "<leader>ll", function()
				lines.toggle()
				if vim.diagnostic.config().virtual_text then
					vim.diagnostic.config({
						virtual_text = false,
					})
				else
					vim.diagnostic.config({
						virtual_text = true,
					})
				end
			end, { noremap = true, desc = "Toggle LSP Lines", silent = true }), -- Toggle lsp lines
			vim.diagnostic.config({
				virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines
			}),
		})
	end,
}
