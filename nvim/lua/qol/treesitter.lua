return {
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "astro",
        "nix",
      },
      auto_install = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = { enable = true, max_lines = 3 },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
          include_surrounding_whitespace = false,
        },
      })
    end,
  },
}
