-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Downloading folke/lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  print("Succesfully downloaded lazy.nvim.")
end
vim.opt.runtimepath:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  require "utils".error("Error downloading lazy.nvim")
  return
end

lazy.setup("plugins", {
  defaults = { lazy = true },
  dev = {
    path = "~/Sources/nvim",
    -- this is a blanket dev for all matching plugins since it
    -- doesn't check for the existence of the directory we now
    -- use the 'dev' property individually instead
    -- patterns = { "ibhagwan" },
  },
  install = { colorscheme = { "dracula" } },
  checker = { enabled = false },
      performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                -- "netrw",
                -- "netrwPlugin",
                -- "netrwSettings",
                -- "netrwFileHandlers",
                "gzip",
                "zip",
                "zipPlugin",
                "tar",
                "tarPlugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "matchit",
            },
        },
	},
  ui = {
    custom_keys = {
      ["<localleader>l"] = false,
      ["<localleader>t"] = false,
    },
  },
  debug = false,
})
