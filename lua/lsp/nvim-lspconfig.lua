return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "litao91/lsp_lines" },
		{ "ray-x/lsp_signature.nvim" },
		--	{ "simrat39/rust-tools.nvim" },
		{ "folke/neodev.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local function opts(desc, bufnr)
			return { desc = "[LSP]: " .. desc, buffer = bufnr, noremap = true, silent = true }
		end

		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration", bufnr))
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go To Definition", bufnr))
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover", bufnr))
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go To Implementation", bufnr))
			vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts("Code Action", bufnr))
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename", bufnr))
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go To References", bufnr))
			vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts("Go To Next Diagnostic", bufnr))
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions", bufnr))
			--[[ vim.keymap.set("n", "<space>fM", function()
					vim.lsp.buf.format({ async = true })
				end, opts("Format", bufnr)) ]]
		end

		local servers = { "html", "eslint", "cssls", "marksman" }
		for _, lsp in pairs(servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach(),
			})
		end

		require("typescript-tools").setup({
			capabilities = capabilities,
			on_attach = on_attach(),
		})

		lspconfig.astro.setup({
			--[[ init_options = {
				typescript = {
					-- needs to be installed in ~ by using `pnpm i typescript`. NOTE: do not use -g flag!
					serverPath = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/typescript/lib/typescript.js",
				},
			}, ]]
		})

		lspconfig.lua_ls.setup({
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
			on_attach = on_attach(),
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
			on_attach = on_attach(),
		})
	end,
}
