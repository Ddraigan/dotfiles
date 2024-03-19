local colours = require("config.theme").colours

vim.api.nvim_set_hl(0, "FloatBorder", { bg = colours.bg, fg = colours.cyan })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = colours.bg })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colours.bg })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = colours.bg })
