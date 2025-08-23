return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    return {
      ensure_installed = require("config.lsp").get_lsps_for_mason(),
      auto_update = true,
    }
  end,
  config = function(_, opts)
    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
