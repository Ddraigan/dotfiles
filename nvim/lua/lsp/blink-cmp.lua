return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "moyiz/blink-emoji.nvim",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Preset bindings -
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    keymap = {
      preset = "default",
      ["<C-e>"] = { "hide", "show" },
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = require("config.theme").icons.cmp,
    },
    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      menu = {
        min_width = 30,
        max_height = 15,
        border = "shadow",
        draw = {
          -- align_to = "cursor", -- I want align to original cursor location
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name", width = { fill = true } },
          },
          components = {
            source_name = {
              text = function(ctx)
                return string.format("[%s]", ctx.source_name)
              end,
            },
          },
        },
      },
    },

    cmdline = {
      enabled = true,
      -- use 'inherit' to inherit mappings from top level `keymap` config
      keymap = { preset = "cmdline" },
      sources = { "buffer", "cmdline" },

      completion = {
        menu = {
          auto_show = true,
        },
        ghost_text = { enabled = true },
      },
    },
    signature = { enabled = true },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji" },
      providers = {
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
