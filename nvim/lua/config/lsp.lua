local M = {}
local mason_lspconfig = require("mason-lspconfig")
local signs = require("config.theme").icons.diagnostics

--- Gets list of lsps for mason to install
---@return table
M.get_lsps_for_mason = function()
  local mason_lsps = M.language_servers.mason
  if vim.fn.has("win32") == 1 then
    return require("config.utils").merge_tables(mason_lsps.base, mason_lsps.windows)
  end
  print(M.get_lsps_for_mason())
  return mason_lsps.base
end

local highlights = function()
  local hl
  for type, _ in pairs(signs) do
    hl = "DiagnosticSign" .. require("config.utils").firstToUpper(type)
  end
  return hl
end

M.language_servers = {
  exclude_configs = {
    ["ts_ls"] = true,
    ["rust_analyzer"] = true,
  },
  system = {
    nix = {
      "nixd",
      "lua-ls",
    },
  },
  mason = {
    base = {
      -- you can turn off/on auto_update per tool
      -- LSPs
      "astro-language-server",
      "yaml-language-server",
      "html-lsp",
      "emmet-ls",
      "css-lsp",
      "json-lsp",
      "clangd",
      "typescript-language-server",
      "tailwindcss-language-server",

      -- Formatters
      "prettierd",
      "prettier",
      "alejandra",

      -- DAPs
      "codelldb",
    },
    windows = {
      "lua-language-server",
      "rust_analyzer",
      "stylua",
      "nil",
    },
  },
}

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
local installed_servers = mason_lspconfig.get_installed_servers()
local unconfigured_servers = { "nixd", "lua_ls" }

for _, server in ipairs(installed_servers) do
  if not M.language_servers.exclude_configs[server] then
    table.insert(unconfigured_servers, server)
  end
end

vim.lsp.enable(unconfigured_servers)

-- Diagnostic Config
vim.diagnostic.config(M.diagnostic_config)

return M
