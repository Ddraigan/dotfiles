local M = {}

M.exclude_configs = {
  ["ts_ls"] = true,
  ["rust_analyzer"] = true,
}

M.system = {
  nix = {
    -- "nixd",
    "lua_ls",
    "haskell-language-server",
    "hls",
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
    "qmlls",
    "nil",

    -- Formatters
    "prettierd",
    "prettier",
    "alejandra",
    "fourmolu",

    -- DAPs
    "codelldb",
  },
  windows = {
    "lua_ls",
    "rust_analyzer",
    "stylua",
    -- "nil",
  },
}

--- Gets list of lsps for mason to install
---@return table
M.get_lsps_for_mason = function()
  if vim.fn.has("win32") == 1 then
    return vim.tbl_extend("keep", M.mason.base, M.mason.windows)
  end
  return M.mason.base
end

local signs = require("config.theme").icons.diagnostics

--- Generates Diagnostic Highlights from given icon table
---@return table
M.generate_diagnostic_highlights = function()
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
    linehl = M.generate_diagnostic_highlights(),
    numhl = M.generate_diagnostic_highlights(),
  },
  severity_sort = true,
}

return M
