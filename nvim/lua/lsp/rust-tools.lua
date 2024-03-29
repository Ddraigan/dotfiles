return {
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = { "rust" },
	-- 	dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
	-- 	config = function()
	-- 		local rt = require("rust-tools")
	-- 		local on_attach = require("config.utils").on_attach
	-- 		local capabilities = require("config.utils").capabilities()
	--
	-- 		local ok, mason_registry = pcall(require, "mason-registry")
	-- 		local adapter ---@type any
	-- 		if ok then
	-- 			-- rust tools configuration for debugging support
	-- 			local codelldb = mason_registry.get_package("codelldb")
	-- 			local extension_path = codelldb:get_install_path() .. "/extension/"
	-- 			local codelldb_path = extension_path .. "adapter/codelldb"
	-- 			local liblldb_path = ""
	-- 			if vim.loop.os_uname().sysname:find("Windows") then
	-- 				liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	-- 			elseif vim.fn.has("mac") == 1 then
	-- 				liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
	-- 			else
	-- 				liblldb_path = extension_path .. "lldb/lib/liblldb.so"
	-- 			end
	-- 			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
	-- 		end
	--
	-- 		rt.setup({
	-- 			server = {
	-- 				capabilities = capabilities,
	-- 				on_attach = function(client, bufnr)
	-- 					on_attach(client, bufnr)
	-- 					-- Hover actions
	-- 					vim.keymap.set(
	-- 						"n",
	-- 						"K",
	-- 						rt.hover_actions.hover_actions,
	-- 						{ buffer = bufnr, desc = "[Rust]: Hover Actions" }
	-- 					)
	-- 					-- vim.keymap.set(
	-- 					-- 	"n",
	-- 					-- 	"<leader>la",
	-- 					-- 	rt.code_action_group.code_action_group, -- supports rust-analyzer's grouping
	-- 					-- 	{ buffer = bufnr, desc = "[Rust]: Code Actions" }
	-- 					-- )
	-- 				end,
	-- 				settings = {
	-- 					["rust-analyzer"] = {
	-- 						check = {
	-- 							-- allTargets = false,
	-- 							-- targets = { "aarch64-unknown-none" },
	-- 						},
	-- 						checkOnSave = {
	-- 							allTargets = false,
	-- 						},
	-- 						cargo = {
	-- 							-- target = "aarch64-unknown-none",
	-- 							allFeatures = true,
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			tools = {
	-- 				reload_workspace_from_cargo_toml = true,
	-- 				runnables = {
	-- 					use_telescope = true,
	-- 				},
	-- 				on_initialized = function()
	-- 					vim.cmd([[
	-- 					augroup RustLSP
	-- 					autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
	-- 					autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
	-- 					autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
	-- 					augroup END
	-- 					]])
	-- 				end,
	-- 				inlay_hints = {
	-- 					auto = false,
	-- 				},
	-- 			},
	-- 			dap = {
	-- 				adapter = adapter,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
