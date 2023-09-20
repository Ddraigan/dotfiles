local M = {
	"norcalli/nvim-colorizer.lua",
}

M.config = function()
	local color = require("colorizer")

	color.setup({
		"html",
		"javascript",
		"typescript",
		"css",
		"yaml",
		css = { css = true },
	})
end

return M
