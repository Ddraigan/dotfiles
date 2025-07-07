return {
  "mrcjkb/rustaceanvim",
  -- event = "BufReadPost",
  lazy = false, -- Lazy plugin naturally
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  -- ft = { "rust" },
  opts = function()
    local has_mason = pcall(require, "mason-registry")
    local adapter ---@type any

    -- Figure out where to get adapter from and which one to use
    if has_mason then -- OBSELETE
      -- Dap Binarys
      local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension")
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path ---@type string

      if vim.fn.has("win32") == 1 then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      elseif vim.fn.has("mac") == 1 then
        liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      else
        liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      end
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
    end

    return {
      capabilities = function()
        require("config.utils").capabilities()
      end,
      server = {
        cmd = { vim.fn.exepath("rust-analyzer") },
        auto_attach = true,
        on_attach = function(_, bufnr)
          vim.keymap.set(
            "n",
            "K",
            "<cmd> RustLsp hover actions <CR>",
            { buffer = bufnr, desc = "[Rust]: Hover Actions" }
          )
          -- vim.keymap.set(
          -- 	"n",
          -- 	"<leader>la",
          -- 	"<cmd> RustLsp codeAction <CR>",
          -- 	{ buffer = bufnr, desc = "[Rust]: Code Actions" }
          -- )
          vim.keymap.set(
            "n",
            "<leader>lre",
            "<cmd> RustLsp explainError <CR>",
            { buffer = bufnr, desc = "[Rust]: Explain Errors" }
          )
          vim.keymap.set(
            "n",
            "<leader>lrj",
            "<cmd> RustLsp joinLines <CR>",
            { buffer = bufnr, desc = "[Rust]: Join Lines" }
          )
          vim.keymap.set(
            "n",
            "<leader>lrd>",
            "<cmd> RustLsp renderDiagnostic",
            { buffer = bufnr, desc = "[Rust]: Render Diagnostic as if cargo build" }
          )
        end,
        settings = {
          ["rust-analyzer"] = {
            -- cargo = { features = "all" },
            -- checkOnSave = true,
            -- check = { command = "clippy", features = "all" },
            -- procMacro = { enable = true },
          },
        },
      },
      tools = {
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "  <-- ",
          only_current_line = false,
          other_hints_prefix = "  --> ",
        },
      },
      dap = {
        adapter = adapter,
      },
    }
  end,
  config = function(_, opts)
    -- Set Options
    vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
  end,
}
