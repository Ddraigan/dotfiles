local M = {}

M.dump = function(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

-- M.capabilities = function ()
--   local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
--   capabilities.textDocument.completion.completionItem = {
--     documentationFormat = { "markdown", "plaintext" },
--     snippetSupport = true,
--     preselectSupport = true,
--     insertReplaceSupport = true,
--     labelDetailsSupport = true,
--     deprecatedSupport = true,
--     commitCharactersSupport = true,
--     tagSupport = { valueSet = { 1 } },
--     resolveSupport = {
--       properties = {
--         "documentation",
--         "detail",
--         "additionalTextEdits",
--       },
--     },
--   }
--
--   return capabilities
-- end

M.capabilities = function()
  local nvim_capabilites = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("blink.cmp").get_lsp_capabilities(nvim_capabilites)
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  return capabilities
end

M.toggle_virtual_lines = function()
  if not vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = false,
    })
  else
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = require("config.lsp").diagnostic_config.virtual_text,
    })
  end
end

--- Merges two tables
---@param t1 table
---@param t2 table
---@return table
M.merge_tables = function(t1, t2)
  local result = {}
  for _, v in ipairs(t1) do
    table.insert(result, v)
  end
  for _, v in ipairs(t2) do
    table.insert(result, v)
  end
  return result
end

M.firstToUpper = function(str)
  return (str:gsub("^%l", string.upper))
end

---@return boolean
M.is_nixos = function()
  if os.getenv("NIX_PATH") then
    return true
  end
  return false
end

return M
