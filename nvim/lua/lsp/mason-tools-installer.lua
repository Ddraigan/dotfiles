return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    local nix_friendly_lsp = {
      -- you can turn off/on auto_update per tool
      { "astro-language-server" },
      { "nil" },
      { "alejandra" },
      { "yaml-language-server" },
      { "stylua" },
      { "html-lsp" },
      { "emmet-ls" },
      { "css-lsp" },
      { "json-lsp" },
      { "prettierd" },
      { "clangd" },
      -- { "eslint_d" },
      -- { "eslint-lsp" },
      { "codelldb" },
      { "ts_ls" },
      { "tailwindcss-language-server" },
    }

    local nix_enemy_lsp = {
      { "lua-language-server" },
      { "rust_analyzer" },
    }

    if vim.fn.has("win32") == 1 then
      for _, lsp in ipairs(nix_enemy_lsp) do
        table.insert(nix_friendly_lsp, lsp)
      end
    end

    return {
      ensure_installed = nix_friendly_lsp,
      auto_update = true,
    }
  end,
  config = function(_, opts)
    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
