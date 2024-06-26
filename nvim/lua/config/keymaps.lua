vim.g.mapleader = " " -- Set <space> as leader key

local M = {}

M.general = {
  n = {
    -- Center buffer while navigating
    ["<C-u>"] = { "<C-u>zz" },
    ["<C-d>"] = { "<C-d>zz" },
    ["{"] = { "{zz" },
    ["}"] = { "}zz" },
    ["N"] = { "Nzz" },
    ["n"] = { "nzz" },
    ["G"] = { "Gzz" },
    ["gg"] = { "ggzz" },
    ["<C-i>"] = { "<C-i>zz" },
    ["<C-o>"] = { "<C-o>zz" },
    ["%"] = { "%zz" },
    ["*"] = { "*zz" },
    ["#"] = { "#zz" },
    ["L"] = { "$" },
    ["H"] = { "^" },

    -- Tmux Remaps
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "window up" },

    -- Better save and quit
    ["<leader>w"] = { "<cmd> w! <CR>", "Save" },
    ["<leader>qa"] = { "<cmd> confirm qa <CR>", "Quit All" },
    ["<leader>qq"] = { "<cmd> q <CR>", "Quit" },

    -- Telescope Plugin
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "[Telescope]: Find Files" },
    ["<leader>fs"] = { "<cmd> Telescope live_grep <CR>", "[Telescope]: Find String" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "[Telescope]: Find Buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "[Telescope]: Help Tags" },

    -- Trouble Plugin
    ["<leader>tt"] = { "<cmd> TroubleToggle <CR>", "[Trouble]: Toggle Menu" },
    ["<leader>tw"] = { "<cmd> TroubleToggle workspace_diagnostics <CR>", "[Trouble]: Workspace Diagnostics" },
    ["<leader>td"] = { "<cmd> TroubleToggle document_diagnostics <CR>", "[Trouble]: Document Diagnostics" },
    ["<leader>tq"] = { "<cmd> TroubleToggle quickfix <CR>", "[Trouble]: Quickfix" },
    ["<leader>tl"] = { "<cmd> TroubleToggle loclist <CR>", "[Trouble]: Logistics" },
    ["<leader>tr"] = { "<cmd> TroubleToggle lsp_references <CR>", "[Trouble]: References" },
    ["<leader>to"] = { "<cmd> TodoTrouble <CR>", "[Trouble]: Todo List" },
    ["<leader>tn"] = {
      "<cmd> lua require('trouble').next({skip_groups = true, jump = true}) <CR>",
      "[Trouble]: Next Diagnostic",
    },
    ["<leader>tp"] = {
      "<cmd> lua require('trouble').previous({skip_groups = true, jump = true}) <CR>",
      "[Trouble]: Next Diagnostic",
    },

    -- Noice Plugin
    ["<leader>fn"] = { "<cmd> NoiceTelescope <CR>", "[Telescope/Noice]: Notifcations" },

    -- Harpoon2 Plugin
    ["<leader>ha"] = { "<cmd> lua require('harpoon'):list():append() <CR>", "[Harpoon]: Add File" },
    ["<leader>hd"] = { "<cmd> lua require('harpoon'):list():remove() <CR>", "[Harpoon]: Remove File" },
    ["<leader>hh"] = {
      "<cmd> lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) <CR>",
      "[Harpoon]: Toggle Menu",
    },
    ["<leader>hc"] = { "<cmd> lua require('harpoon'):list():clear() <CR>", "[Harpoon]: Clear List" },
    ["<leader>hn"] = { "<cmd> lua require('harpoon'):list():next() <CR>", "[Harpoon]: Nav Next" },
    ["<leader>hp"] = { "<cmd> lua require('harpoon'):list():prev() <CR>", "[Harpoon]: Nav Prev" },

    -- Dap Plugin
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "[DAP]: Toggle Breakpoint" },
    ["<leader>dc"] = { "<cmd> DapContinue <CR>", "[DAP]: Continue" },
    ["<leader>do"] = { "<cmd> DapStepOver <CR>", "[DAP]: Step Over" },
    ["<leader>dO"] = { "<cmd> DapStepOut <CR>", "[DAP]: Step Out" },
    ["<leader>di"] = { "<cmd> DapStepInto <CR>", "[DAP]: Step Into" },
    ["<leader>dt"] = { "<cmd> DapTerminate <CR>", "[DAP]: Terminate" },
    ["<leader>dv"] = { "<cmd> lua require('dapui').toggle() <CR>", "[DAP]: Toggle Ui" },

    -- Neotest Plugin
    ["<leader>nt"] = { "<cmd> lua require('neotest').run.run() <CR>", "[NeoTest]: Run Nearest Test" },

    -- Vim Split
    ["<leader>sh"] = { "<cmd> split <CR>", "[Vim]: Split Horizontal" },
    ["<leader>sv"] = { "<cmd> vsplit <CR>", "[Vim]: Split Vertical" },
    ["<leader>sc"] = { "<C-w>c", "[Vim]: Split Close" },

    -- Structural Search and Replace Plugin
    ["<leader>sr"] = { "<cmd> lua require('ssr').open() <CR>", "[SSR]: Structural Search and Replace" },

    -- Nvim-Tree Plugin
    -- ["<leader>-"] = { "<cmd> NvimTreeToggle <CR>", "[Nvim-Tree]: Toggle Tree" },

    -- Oil Plugin
    ["<leader>-"] = {
      function()
        require("oil").toggle_float()
      end,
      "Toggle Oil",
    },
    -- Lsp_Lines
    ["<leader>ll"] = {
      function()
        require("lsp_lines").toggle()
        if vim.diagnostic.config().virtual_text then
          vim.diagnostic.config({ virtual_text = false })
        else
          vim.diagnostic.config({
            virtual_text = {
              prefix = require("config.theme").icons.diagnostics.prefix,
            },
          })
        end
      end,
      "Toggle LSP Lines",
    },
  },
  i = {
    -- LuaSnip Plugn
    ["<C-k>"] = {
      function()
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
      "[LuaSnip]: Expand or Jump",
    },
    ["<C-j>"] = {
      function()
        local ls = require("luasnip")
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      "[LuaSnip]: Jump",
    },
    ["<C-l>"] = {
      function()
        local ls = require("luasnip")
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      "[LuaSnip]: Change Choice",
    },
  },
  x = {
    -- Pasting does not ovride your clipboard
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Don't Copy Replaced Text", opts = { silent = true } },

    -- Structural Search and Replace Plugin
    ["<leader>sr"] = { "<cmd> lua require('ssr').open() <CR>", "[SSR]: Structural Search and Replace" },
  },
}

-- Harpoon Switch between buffers
for i = 1, 5, 1 do
  M.general.n[string.format("<leader>%s", i)] = {
    string.format("<cmd> lua require('harpoon'):list():select(%s) <CR>", i),
    string.format("[Harpoon]: Go To Buffer %s", i),
  }
end

M.setmaps = function(maps)
  for mode, values in pairs(maps) do
    for keybind, mapping_info in pairs(values) do
      local opts = {
        desc = mapping_info[2],
      }
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

M.setmaps(M.general)

local augroup = vim.api.nvim_create_augroup
local autocommand = vim.api.nvim_create_autocmd

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
autocommand("LspAttach", {
  group = augroup("dd-lsp-attach", { clear = false }),
  callback = function(args)
    -- local augroupFormat = augroup("dd-formatting", { clear = false })
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buffer = args.buf

    local function opts(desc, buf)
      return { desc = "[LSP]: " .. desc, buffer = buf, noremap = true, silent = true }
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration", buffer))
    vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <CR>", opts("Go To Definition", buffer))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation", buffer))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Documentation", buffer))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go To Implementation", buffer))
    vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <CR>", opts("Go To References", buffer))
    vim.keymap.set("n", "<leader>lr", ":IncRename ", opts("Rename", buffer))
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions", buffer))
    vim.keymap.set("n", "<Leader>lf", function()
      require("conform").format({ buffer, lsp_fallback = true })
    end, { desc = "[LSP/Conform]: Format" })
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts("", bufnr))
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("", bufnr))
    -- vim.keymap.set("n", "<space>wl", function()
    -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts("", bufnr))

    -- if client.supports_method("textDocument/formatting") then
    --   vim.keymap.set("n", "<Leader>lf", function ()
    --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    --   end, { buffer = buffer, desc = "[LSP]: Format" })
    --
    --   vim.api.nvim_clear_autocmds({ group = augroupFormat, buffer = buffer })
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = augroupFormat,
    --     buffer = buffer,
    --     callback = function ()
    --       vim.lsp.buf.format({ async = false })
    --     end,
    --     desc = "[LSP]: Format On Save",
    --   })
    -- end
    --
    -- if client.supports_method("textDocument/rangeFormatting") then
    --   vim.keymap.set("x", "<Leader>lf", function ()
    --     vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
    --   end, { buffer = buffer, desc = "[LSP]: Range Format" })
    -- end

    ---@diagnostic disable-next-line: need-check-nil
    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<leader>lh", function()
        -- local current_setting = vim.lsp.inlay_hint.is_enabled(buffer)
        vim.lsp.inlay_hint.enable(buffer, not vim.lsp.inlay_hint.is_enabled())
      end, opts("Toggle Inlay Hints"))
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = buffer,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = buffer,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

autocommand("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("dd-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocommand("BufEnter", {
  desc = "Disable New Line Continuing Comment",
  group = augroup("dd-comment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- -- Creates simpler lua mapping syntax
-- local function bind(op, outer_opts)
-- 	outer_opts = outer_opts or { noremap = true }
-- 	return function(lhs, rhs, opts)
-- 		opts = vim.tbl_extend("force", outer_opts, opts or {})
-- 		vim.keymap.set(op, lhs, rhs, opts)
-- 	end
-- end
--
-- M.nmap = bind("n", { noremap = false })
-- M.nnoremap = bind("n")
-- M.vnoremap = bind("v")
-- M.xnoremap = bind("x")
-- M.tnoremap = bind("t")
-- M.inoremap = bind("i")
