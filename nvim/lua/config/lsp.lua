local M = {}
local mason_lspconfig = require("mason-lspconfig")
local utils = require("config.utils")
local lsp_config = require("config.lsp-config")

-- Diagnostic Config
vim.diagnostic.config(lsp_config.diagnostic_config)

-- LSP Config
local mason_servers = mason_lspconfig.get_installed_servers()
local nix_servers = lsp_config.system.nix

local all_servers = utils.is_nixos() and utils.merge_tables(mason_servers, nix_servers) or mason_servers

local servers = {}
for _, server in ipairs(all_servers) do
  if not lsp_config.exclude_configs[server] then
    table.insert(servers, server)
  end
end

vim.lsp.enable(servers)

return M
