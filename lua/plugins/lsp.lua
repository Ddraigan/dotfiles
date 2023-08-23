return {
{
  -- RUST LSP
  "simrat39/rust-tools.nvim",
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    require("rust-tools").setup({
      -- rust-tools options
      tools = {
        autoSetHints = true,
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> "
        }
      },
      -- all the opts to send to nvim-lspconfig
      -- these override the defaults set by rust-tools.nvim
      --
      -- REFERENCE:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      -- https://rust-analyzer.github.io/manual.html#configuration
      -- https://rust-analyzer.github.io/manual.html#features
      --
      -- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
      --       <section> should be an object.
      --       <property> should be a primitive.
      server = {
        on_attach = function(client, bufnr)
          require("shared/lsp")(client, bufnr)
          require("illuminate").on_attach(client)

          local bufopts = {
            noremap = true,
            silent = true,
            buffer = bufnr
          }
          vim.keymap.set('n', '<leader><leader>rr',
            "<Cmd>RustRunnables<CR>", bufopts)
          vim.keymap.set('n', 'K', "<Cmd>RustHoverActions<CR>",
            bufopts)
        end,
        ["rust-analyzer"] = {
          assist = {
            importEnforceGranularity = true,
            importPrefix = "create"
          },
          cargo = { allFeatures = true },
          checkOnSave = {
            -- default: `cargo check`
            command = "clippy",
            allFeatures = true
          }
        },
        inlayHints = {
          -- NOT SURE THIS IS VALID/WORKS 😬
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          }
        }
      }
    })
  end
}, {
  -- LSP INLAY HINTS
  -- rust-tools already provides this feature, but gopls doesn't
  "lvimuser/lsp-inlayhints.nvim",
  dependencies = "neovim/nvim-lspconfig"
}, {
  -- LSP SERVER MANAGEMENT
  "williamboman/mason.nvim",
  dependencies = "nvim-lspconfig",
  config = true
}, {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "mason.nvim" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")

    -- NOTE: sumneko_lua -> lua_ls
    -- https://github.com/williamboman/mason-lspconfig.nvim/pull/148
    mason_lspconfig.setup({
      ensure_installed = {
        "bashls", "eslint", "gopls", "jsonls", "marksman", "pylsp",
        "rust_analyzer", "lua_ls", "tflint",
        "tsserver", "yamlls"
      }
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        -- Skip gopls and rust_analyzer as we manually configure them.
        -- Otherwise the following `setup()` would override our config.
        if server_name ~= "gopls" and server_name ~= "rust_analyzer" then
          -- Unfortunately had to if/else so I could configure 'settings' for yamlls.
          if server_name == "yamlls" then
            require("lspconfig")[server_name].setup({
              on_attach = function(client, bufnr)
                require("shared/lsp")(client, bufnr)
                require("illuminate").on_attach(client)
              end,
              settings = {
                yaml = {
                  keyOrdering = false                       -- Disable alphabetical ordering of keys
                }
              }
            })
          else
            require("lspconfig")[server_name].setup({
              on_attach = function(client, bufnr)
                require("shared/lsp")(client, bufnr)
                require("illuminate").on_attach(client)
              end
            })
          end
        end
      end
    })
  end
}, {
  -- LSP PROGRESS STATUS
  "j-hui/fidget.nvim",
  config = true
}, {
  -- LSP DIAGNOSTICS
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup()

    local bufopts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader><leader>lc", "<Cmd>TroubleClose<CR>",
      bufopts)
    vim.keymap.set("n", "<leader><leader>li",
      "<Cmd>TroubleToggle document_diagnostics<CR>",
      bufopts)
    vim.keymap.set("n", "<leader><leader>lw",
      "<Cmd>TroubleToggle workspace_diagnostics<CR>",
      bufopts)
    vim.keymap.set("n", "<leader><leader>lr",
      "<Cmd>TroubleToggle lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<leader><leader>lq",
      "<Cmd>TroubleToggle quickfix<CR>", bufopts)
    vim.keymap.set("n", "<leader><leader>ll",
      "<Cmd>TroubleToggle loclist<CR>", bufopts)
  end
}, {
  -- LSP VIRTUAL TEXT
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",       -- See also: https://github.com/Maan2003/lsp_lines.nvim
  config = function()
    require("lsp_lines").setup()

    -- disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({ virtual_text = false })
  end
}, {
  -- CODE ACTION LIGHTBULB
  "kosayoda/nvim-lightbulb",
  config = function()
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      pattern = "*",
      command = "lua require('nvim-lightbulb').update_lightbulb()"
    })
  end
}, {
  -- ADD MISSING DIAGNOSTICS HIGHLIGHT GROUPS
  "folke/lsp-colors.nvim",
  config = true
}, {
  -- CODE ACTIONS POPUP
  "weilbith/nvim-code-action-menu",
  config = function()
    vim.keymap.set("n", "<leader><leader>la", "<Cmd>CodeActionMenu<CR>",
      { noremap = true, desc = "code action menu" })
    vim.g.code_action_menu_window_border = "single"
  end
}, {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig", "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim"
  },
  keys = {
    {
      "<leader>lt",
      function() require("nvim-navbuddy").open() end,
      desc = "Navigate symbols via Navbuddy tree",
      mode = "n",
      noremap = true,
      silent = true
    }
  },
  config = function()
    local navbuddy = require("nvim-navbuddy")
    local actions = require("nvim-navbuddy.actions")
    navbuddy.setup({
      mappings = {
        ["<Down>"] = actions.next_sibling(),               -- down
        ["<Up>"] = actions.previous_sibling(),             -- up
        ["<Left>"] = actions.parent(),                     -- Move to left panel
        ["<Right>"] = actions.children()                   -- Move to right panel
      }
    })
  end
}
}
