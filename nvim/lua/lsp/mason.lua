return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = function()
    local icons = require("config.theme").icons.mason
    return {
      ui = {
        icons = icons,
      },
      npm = {
        use_pnpm = true,
      },
    }
  end,
}
