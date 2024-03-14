-- Stop Lag
vim.g.nofsync = true

vim.filetype.add({
	extension = {
		astro = "astro",
		mdx = "markdown.mdx",
	},
})

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	severity_sort = true,
})

vim.opt.nu = true
-- Relative line numbers
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- Save undo history
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.o.clipboard = "unnamedplus"

local signs = require("config.theme").icons.diagnostics
local firstToUpper = function(str)
	return (str:gsub("^%l", string.upper))
end

for type, icon in pairs(signs) do
	-- if not string.find(type, "other") then
	local hl = "DiagnosticSign" .. firstToUpper(type)
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	-- end
end

-- Only needed for Lightbulb Plugin
-- vim.fn.sign_define("LightBulbSign", { text = signs.hint, texthl = "", linehl = "", numhl = "" })
