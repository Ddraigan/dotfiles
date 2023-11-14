return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "litao91/lsp_lines" },
		{ "folke/neodev.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local on_attach = require("config.utils").on_attach
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local installed_servers = mason_lspconfig.get_installed_servers()
		local unconfigured_servers = {}
		for _, server in ipairs(installed_servers) do
			if not string.find(server, "tsserver") then
				table.insert(unconfigured_servers, server)
			end
		end

		for _, lsp in pairs(unconfigured_servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		require("typescript-tools").setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.astro.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			--[[ init_options = {
				typescript = {
					-- needs to be installed in ~ by using `pnpm i typescript`. NOTE: do not use -g flag!
					serverPath = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/typescript/lib/typescript.js",
				},
			}, ]]
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								},
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							},
						},
					})

					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end,
		})

		-- configure emmet language server
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"astro",
			},
		})
		-- Tailwind
		-- Support for tailwind auto completion
		-- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
