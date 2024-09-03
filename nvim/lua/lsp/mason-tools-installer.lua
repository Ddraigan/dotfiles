return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- you can turn off/on auto_update per tool
      { "astro-language-server" },
      { "rnix-lsp" },
      { "lua-language-server" },
      { "yaml-language-server" },
      { "stylua" },
      { "html-lsp" },
      { "emmet-ls" },
      { "rust_analyzer" },
      { "css-lsp" },
      { "json-lsp" },
      { "prettierd" },
      { "clangd" },
      -- { "eslint_d" },
      -- { "eslint-lsp" },
      { "codelldb" },
      { "tsserver" },
      { "tailwindcss-language-server" },
    },
    auto_update = true,
  },
  config = function(_, opts)
    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
