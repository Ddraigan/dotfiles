-- Stop Lag
vim.g.nofsync = true

--[[ vim.filetype.add({
	extension = {
		astro = "astro",
	},
}) ]]

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Disable virtual_text since it's redundant due to lsp_lines
vim.diagnostic.config({ virtual_text = false })

vim.opt.nu = true
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

vim.fn.sign_define("LightBulbSign", { text = "󰌵", texthl = "", linehl = "", numhl = "" })
