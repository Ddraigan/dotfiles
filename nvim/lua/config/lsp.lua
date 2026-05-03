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

local tw_template = vim.lsp.config["tailwindcss"]
if not tw_template then
  tw_template = { filetypes = {}, settings = {} }
end

local my_overrides = {
  filetypes = vim.list_extend(vim.deepcopy(tw_template.filetypes or {}), { "rust" }),
  init_options = {
    userLanguages = {
      rust = "html",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { 'class:\\s*"([^"]*)"', '([^"]*)' },
          { 'class\\s*=\\s*"([^"]*)"', '([^"]*)' },
        },
      },
      includeLanguages = {
        rust = "html",
      },
    },
  },
  root_markers = { "Cargo.toml", "tailwind.config.js", "package.json", ".git" },
}

local final_config = vim.tbl_deep_extend("force", tw_template, my_overrides)

vim.lsp.config("tailwindcss", final_config)

vim.lsp.enable(servers)

return M
