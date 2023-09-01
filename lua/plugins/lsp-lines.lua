return {
	"litao91/lsp_lines",
	config = function ()
		require("lsp_lines").setup()

		vim.diagnostic.config({
			virtual_text = false,
		})

	end
}
