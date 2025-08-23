local M = {}
local mason_lspconfig = require("mason-lspconfig")
local signs = require("config.theme").icons.diagnostics
local utils = require("config.utils")
local lsps = require("config.language_servers")

local highlights = function()
  local hl
  for type, _ in pairs(signs) do
    hl = "DiagnosticSign" .. require("config.utils").firstToUpper(type)
  end
  return hl
end

M.diagnostic_config = {
  virtual_text = {
    prefix = signs.prefix,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.error,
      [vim.diagnostic.severity.WARN] = signs.warn,
      [vim.diagnostic.severity.INFO] = signs.info,
      [vim.diagnostic.severity.HINT] = signs.hint,
    },
    linehl = highlights(),
    numhl = highlights(),
  },
  severity_sort = true,
}

-- LSP Config
local mason_servers = mason_lspconfig.get_installed_servers()
local nix_servers = lsps.system.nix

local all_servers = utils.is_nixos() and utils.merge_tables(mason_servers, nix_servers) or mason_servers

local servers = {}
for _, server in ipairs(all_servers) do
  if not lsps.exclude_configs[server] then
    table.insert(servers, server)
  end
end

vim.lsp.enable(servers)

-- Diagnostic Config
vim.diagnostic.config(M.diagnostic_config)

return M
