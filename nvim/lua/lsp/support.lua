return {
  -- Toml support
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- ft = "toml",
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
          crates = {
            enabled = true,
            min_chars = 3,
            max_results = 8,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
  {
    "mattn/emmet-vim",
  },
  {
    "wuelnerdotexe/vim-astro",
    ft = "astro",
    config = function()
      vim.cmd([[let g:astro_typescript = 'enable']])
    end,
  },

  { "NoahTheDuke/vim-just", ft = "just" },
  { "IndianBoy42/tree-sitter-just", ft = "just" },
}
