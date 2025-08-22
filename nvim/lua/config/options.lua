-- Stop Lag
vim.g.nofsync = true

vim.filetype.add({
  extension = {
    astro = "astro",
    mdx = "markdown.mdx",
  },
})

  -- Blink seems to handle this well enough
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Gotta fuck with telescope first, new vim feature
-- vim.o.winborder = "rounded"

vim.opt.nu = true
vim.opt.relativenumber = true -- Relative line numbers
-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Keep sign column on all times
vim.opt.signcolumn = "yes"

vim.g.have_nerd_font = true

-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- Save undo history
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Syncs clipboard between os and nvim
vim.o.clipboard = "unnamedplus"


-- Diagnostics
local signs = require("config.theme").icons.diagnostics

vim.diagnostic.config({
  virtual_text = {
    prefix = signs.prefix,
  },
  severity_sort = true,
})

local firstToUpper = function (str)
  return (str:gsub("^%l", string.upper))
end

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. firstToUpper(type)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
