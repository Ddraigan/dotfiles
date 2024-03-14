return {
	"mrcjkb/rustaceanvim",
	event = "BufReadPost",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	ft = { "rust" },
	opts = function(_)
		local on_attach = require("config.utils").on_attach
		local capabilities = require("config.utils").capabilities()

		local ok, mason_registry = pcall(require, "mason-registry")
		local adapter ---@type any
		if ok then
			-- rust tools configuration for debugging support
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = ""
			if vim.loop.os_uname().sysname:find("Windows") then
				liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
			elseif vim.fn.has("mac") == 1 then
				liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			else
				liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			end
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
		end

		return {
			capabilities = capabilities,
			server = {
				cmd = function()
					local mason_registry = require("mason-registry")
					local package = mason_registry.get_package("rust-analyzer")
					local install_dir = package:get_install_path()
					-- find out where the binary is in the install dir, and append it to the install dir
					local ra_bin = install_dir .. "/" .. "rust-analyzer.exe" -- this may need tweaking
					return { ra_bin }                         -- you can add additional args like `'--logfile', '/path/to/logfile'` to the list
				end,
				auto_attach = true,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
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
			dap = {
				adapter = adapter,
			},
		}
	end,
	config = function(_, opts)
		vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
	end,
}
