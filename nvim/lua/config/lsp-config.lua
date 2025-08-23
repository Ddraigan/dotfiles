local M = {}

M.exclude_configs = {
  ["ts_ls"] = true,
  ["rust_analyzer"] = true,
}

M.system = {
  nix = {
    "nixd",
    "lua_ls",
  },
}

M.mason = {
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
    "lua_ls",
    "rust_analyzer",
    "stylua",
    "nil",
  },
}

--- Gets list of lsps for mason to install
---@return table
M.get_lsps_for_mason = function()
  local mason_lsps = M.mason
  if vim.fn.has("win32") == 1 then
    M.merge_tables(mason_lsps.base, mason_lsps.windows)
  end
  return mason_lsps.base
end

local signs = require("config.theme").icons.diagnostics

M.get_diagnostic_highlights = function ()
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
    linehl = M.get_diagnostic_highlights(),
    numhl = M.get_diagnostic_highlights(),
  },
  severity_sort = true,
}

return M
