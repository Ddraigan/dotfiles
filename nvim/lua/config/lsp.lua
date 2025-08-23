local mason_lspconfig = require("mason-lspconfig")

local installed_servers = mason_lspconfig.get_installed_servers()
local unconfigured_servers = { "nixd", "lua_ls" }
for _, server in ipairs(installed_servers) do
  if not string.find(server, "ts_ls") and not string.find(server, "rust_analyzer") then
    table.insert(unconfigured_servers, server)
  end
end

vim.lsp.enable(unconfigured_servers)

-- Diagnostics
local signs = require("config.theme").icons.diagnostics

local firstToUpper = function(str)
  return (str:gsub("^%l", string.upper))
end

local highlights = function ()
  local hl
for type, _ in pairs(signs) do
   hl = "DiagnosticSign" .. firstToUpper(type)
end
  return hl
end

vim.diagnostic.config({
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
})
