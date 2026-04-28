---@type vim.lsp.Config
return {
  cmd = { "tailwind-language-server" },
  filetypes = {
    "rust",
  },
  init_options = {
    userLanguages = {
      rust = "html",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class:\\s*"(.*)"',
        },
      },
      includeLanguages = {
        rust = "html",
      },
    },
  },
}
