local M = {
	"litao91/lsp_lines",
}

M.config = function ()
	require("lsp_lines").setup({
		vim.keymap.set("n", "<leader>ll", ":lua require('lsp_lines').toggle()<CR>", { noremap = true, desc = "Toggle LSP Lines", silent = true }), -- Toggle lsp lines
		vim.diagnostic.config({
			virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines
		})
	})
end

return M
