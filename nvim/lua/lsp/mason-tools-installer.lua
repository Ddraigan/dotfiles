return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    local all_os = {
      -- you can turn off/on auto_update per tool

      -- LSPs
      { "astro-language-server" },
      { "yaml-language-server" },
      { "html-lsp" },
      { "emmet-ls" },
      { "css-lsp" },
      { "json-lsp" },
      { "clangd" },
      { "ts_ls" },
      { "tailwindcss-language-server" },
      -- { "eslint-lsp" },

      -- Formatters
      { "prettierd" },
      { "prettier" },
      { "alejandra" },
      -- { "eslint_d" },

      -- DAPs
      { "codelldb" },
    }

    local windows_only = {
      { "lua-language-server" },
      { "rust_analyzer" },
      { "stylua" },
      { "nil" }, -- Not actual enemy but I use nixd on nix system
    }

    if vim.fn.has("win32") == 1 then
      for _, lsp in ipairs(windows_only) do
        table.insert(all_os, lsp)
      end
    end

    return {
      ensure_installed = all_os,
      auto_update = true,
    }
  end,
  config = function(_, opts)
    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup(opts)
    mason_tool_installer.run_on_start()
  end,
}
