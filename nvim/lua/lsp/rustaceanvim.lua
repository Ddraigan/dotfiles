return {
  "mrcjkb/rustaceanvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  ft = { "rust" },
  opts = {
    capabilities = function()
      require("config.utils").capabilities()
    end,
    server = {
      auto_attach = true,
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", "<cmd> RustLsp hover actions <CR>", { buffer = bufnr, desc = "[Rust]: Hover Actions" })
        -- vim.keymap.set(
        -- 	"n",
        -- 	"<leader>la",
        -- 	"<cmd> RustLsp codeAction <CR>",
        -- 	{ buffer = bufnr, desc = "[Rust]: Code Actions" }
        -- )
        vim.keymap.set(
          "n",
          "<leader>le",
          "<cmd> RustLsp explainError <CR>",
          { buffer = bufnr, desc = "[Rust]: Explain Errors" }
        )
        vim.keymap.set(
          "n",
          "<leader>lj",
          "<cmd> RustLsp joinLines <CR>",
          { buffer = bufnr, desc = "[Rust]: Join Lines" }
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
  },
  config = function(_, opts)
    -- Set Options
    vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})

    local has_mason, mason_registry = pcall(require, "mason-registry")

    if has_mason then
      -- Find RustAnalyzer binary path in mason registry
      local get_bin = function()
        local ra_package = mason_registry.get_package("rust-analyzer")
        local install_dir = ra_package:get_install_path()
        -- find out where the binary is in the install dir, and append it to the install dir
        local ra_bin = install_dir .. "/" .. "rust-analyzer"
        print(ra_bin)
        return { ra_bin } -- you can add additional args like `'--logfile', '/path/to/logfile'` to the list
      end

      -- Set the RustAnalyzer binary to the mason one
      if vim.fn.has("win32") then
        vim.g.rustaceanvim = vim.tbl_deep_extend("force", opts, { server = { cmd = get_bin() } })
      end
    end

    -- Figure out where to get adapter from and which one to use
    if has_mason then
      local adapter ---@type any
      -- rust tools configuration for debugging support
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = ""
      if vim.fn.has("win32") then
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      elseif vim.fn.has("mac") == 1 then
        liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      else
        liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      end
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)

      -- Set the adapter once found
      -- vim.g.rustaceanvim = vim.tbl_deep_extend("keep", { dap = { adapter = adapter } }, opts)
    end
  end,
}
