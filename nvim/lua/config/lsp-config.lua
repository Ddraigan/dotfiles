local M = {}

local utils = require("config.utils")

M.exclude_configs = {
  ["ts_ls"] = true,
  ["rust_analyzer"] = true,
}

M.system = {
  nix = {
    "lua_ls",
    "haskell-language-server",
    "hls",
    "clangd",
  },
}

M.mason = {
  base = {
    -- LSPs
    "astro-language-server",
    "yaml-language-server",
    "html-lsp",
    "emmet-ls",
    "css-lsp",
    "json-lsp",
    "typescript-language-server",
    "tailwindcss-language-server",
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
    "clangd",
    "rnix-lsp",
  },
}

--- Gets list of lsps for mason to install
---@return table
M.get_mason_servers = function()
  if vim.fn.has("win32") == 1 then
    return utils.merge_tables(M.mason.base, M.mason.windows)
  end
  return M.mason.base
end

local signs = require("config.theme").icons.diagnostics

--- Generates Diagnostic Highlights from given icon table
---@return table
M.generate_diagnostic_highlights = function()
  local hl
  for type, _ in pairs(signs) do
    hl = "DiagnosticSign" .. utils.firstToUpper(type)
  end
  return hl

  -- local highlights = {}
  --
  --   for type, _ in pairs(signs) do
  --     -- Construct the string and insert it into the table
  --     local hl_name = "DiagnosticSign" .. utils.firstToUpper(type)
  --     table.insert(highlights, hl_name)
  --   end
  --
  --   return highlights
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

---@class CustomLspOverrides : vim.lsp.Config
---@field filetypes_include? string[] List of additional filetypes to append to defaults

---Extends a default LSP configuration with custom overrides.
---This helper merges standard filetypes with user-provided ones and applies
---deep merging for settings and init_options.
---
---@param server string The name of the LSP server (e.g., "tailwindcss")
---@param overrides CustomLspOverrides Table of overrides to apply to the default config
M.overide_default_lsp_config = function(server, overrides)
  ---@type vim.lsp.Config
  local default_config = vim.lsp.config[server] or { filetypes = {}, settings = {} }

  if overrides.filetypes_include then
    overrides.filetypes = vim.list_extend(vim.deepcopy(default_config.filetypes or {}), overrides.filetypes_include)
    overrides.filetypes_include = nil
  end

  local final_config = vim.tbl_deep_extend("force", default_config, overrides)

  vim.lsp.config(server, final_config)
end

return M
