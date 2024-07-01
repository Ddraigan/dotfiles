return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "ryo33/nvim-cmp-rust",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    local kind_icons = require("config.theme").icons.cmp

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<S-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "crates" },
        { name = "buffer" },
        { name = "path" },
        { name = "lazydev", group_index = 0 },
      }),
      formatting = {
        expandable_indicator = true,
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[NvimAPI]",
            path = "[Path]",
          })[entry.source.name]

          vim_item.max_width = 35
          return vim_item
        end,
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    local compare = require("cmp.config.compare")
    cmp.setup.filetype({ "rust" }, {
      sorting = {
        priority_weight = 2,
        comparators = {
          -- deprioritize `.box`, `.mut`, etc.
          require("cmp-rust").deprioritize_postfix,
          -- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
          require("cmp-rust").deprioritize_borrow,
          -- deprioritize `Deref::deref` and `DerefMut::deref_mut`
          require("cmp-rust").deprioritize_deref,
          -- deprioritize `Into::into`, `Clone::clone`, etc.
          require("cmp-rust").deprioritize_common_traits,
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.locality,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
    })
  end,
}
