return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      name = "treesitter-context",
      config = true,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- the mdx filetype will use the markdown parser and queries.
    vim.treesitter.language.register("markdown", "mdx")
    require("nvim-treesitter").setup({
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
        "morkdown",
        "markdown_inline",
        "astro",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Outer Function" },
            ["if"] = { query = "@function.inner", desc = "Inner Function" },
            ["ac"] = { query = "@class.outer", desc = "Outer Class" },
            ["ic"] = { query = "@class.inner", desc = "Inner Class" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language Scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
