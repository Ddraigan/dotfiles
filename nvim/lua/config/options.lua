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
vim.opt.smartindent = false
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

local augroup = vim.api.nvim_create_augroup
local autocommand = vim.api.nvim_create_autocmd

autocommand("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("dd-autos", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

autocommand("BufEnter", {
  desc = "Disable New Line Continuing Comment",
  group = augroup("dd-autos", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

autocommand("FileType", {
  group = augroup("dd-treesitter", { clear = true }),
  callback = function(args)
    local buf = args.buf
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)

    if lang and pcall(vim.treesitter.start, buf, lang) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldlevel = 99
    end
  end,
})

autocommand("BufWinEnter", {
  group = augroup("dd-better-help", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].filetype == "help" then
      vim.cmd("only")

      vim.keymap.set("n", "q", ":buffer #<CR>", {
        buffer = args.buf,
        silent = true,
      })
    end
  end,
})
