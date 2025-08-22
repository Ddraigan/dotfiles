return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- ft = "toml",
    config = function()
      require("crates").setup({
        popup = {
          keys = {
            hide = { "q", "<esc>" },
            open_url = { "<cr>" },
            select = { "<cr>" },
            select_alt = { "s" },
            toggle_feature = { "<cr>" },
            copy_value = { "yy" },
            goto_item = { "gd", "K", "<C-LeftMouse>" },
            jump_forward = { "<c-i>" },
            jump_back = { "<c-o>", "<C-RightMouse>" },
          },
        },
        completion = {
          blink = {
            use_custom_kind = true,
            kind_text = {
              version = "Version",
              feature = "Feature",
            },
            kind_highlight = {
              version = "BlinkCmpKindVersion",
              feature = "BlinkCmpKindFeature",
            },
            kind_icon = {
              version = " ",
              feature = " ",
            },
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
