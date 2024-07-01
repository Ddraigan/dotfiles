return {
  "mrcjkb/rustaceanvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  ft = { "rust" },
  opts = function()
    local has_mason, mason_registry = pcall(require, "mason-registry")
    local adapter ---@type any
    local rust_analyzer_binary ---@type table

    -- Figure out where to get adapter from and which one to use
    if has_mason then
      -- Dap Binarys
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = ""

      -- Find RustAnalyzer binary path in mason registry
      local ra_package = mason_registry.get_package("rust-analyzer")
      local install_dir = ra_package:get_install_path()

      if vim.fn.has("win32") == 1 then
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        rust_analyzer_binary = { install_dir .. "/" .. "rust-analyzer" }
      elseif vim.fn.has("mac") == 1 then
        liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      else
        liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        rust_analyzer_binary = { install_dir .. "/" .. "rust-analyzer-x86_64-unknown-linux-gnu" }
      end
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
    end

    return {
      capabilities = function()
        require("config.utils").capabilities()
      end,
      ---@type RustaceanLspClientOpts
      server = {
        cmd = rust_analyzer_binary,
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
      ---@type RustaceanToolsOpts
      tools = {
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "  <-- ",
          only_current_line = false,
          other_hints_prefix = "  --> ",
        },
      },
      ---@type RustaceanDapOpts
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
