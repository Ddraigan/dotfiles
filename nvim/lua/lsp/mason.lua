return {
  {
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
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      return {
        ensure_installed = require("config.lsp-config").get_mason_servers(),
        auto_update = true,
      }
    end,
    config = function(_, opts)
      local mason_tool_installer = require("mason-tool-installer")
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
}
