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

vim.opt.nu = true

-- Relative line numbers
vim.opt.relativenumber = true

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
vim.diagnostic.config({
    virtual_text = {
        prefix = require("config.theme").icons.diagnostics.prefix,
    },
    severity_sort = true,
})

local signs = require("config.theme").icons.diagnostics

local firstToUpper = function (str)
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
