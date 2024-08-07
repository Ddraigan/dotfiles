return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local colours = require("config.theme").colours
    local dracula_colours = require("config.theme").dracula_soft

    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = { "italic" },
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = function()
        return {
          ["@type.builtin"] = { fg = colours.sky },
          ["@keyword.function"] = { fg = colours.red },
          ["@keyword.return"] = { fg = colours.red },
          ["@property"] = { fg = colours.mauve },
          ["@function.builtin"] = { fg = colours.green },
          ["@function.method"] = { fg = colours.green },
          ["@function.macro"] = { fg = colours.teal },
          Keyword = { fg = colours.red },
          String = { fg = colours.yellow },
          Type = { fg = colours.sky },
          Function = { fg = dracula_colours.bright_green },
          Operator = { fg = colours.red },
          Hint = { fg = colours.sapphire },
          GitSignsChange = { fg = colours.sapphire },
        }
      end,
      default_integrations = true,
      integrations = {
        cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        gitsigns = true,
        harpoon = true,
        lsp_trouble = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        noice = true,
        notify = true,
        nvimtree = false,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
