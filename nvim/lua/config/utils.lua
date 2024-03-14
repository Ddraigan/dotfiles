local M = {}

M.dump = function(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function opts(desc, buf)
	return { desc = "[LSP]: " .. desc, buffer = buf, noremap = true, silent = true }
end

local augroupFormat = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local buffer = ev.buf

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration", buffer))
		vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <CR>", opts("Go To Definition", buffer))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation", buffer))
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Documentation", buffer))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go To Implementation", buffer))
		vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <CR>", opts("Go To References", buffer))
		vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts("Go To Next Diagnostic", buffer))
		vim.keymap.set("n", "<leader>lr", ":IncRename ", opts("Rename", buffer))
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions", buffer))
		-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts("", bufnr))
		-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts("", bufnr))
		-- vim.keymap.set("n", "<space>wl", function()
		-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts("", bufnr))
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, buffer)
		vim.keymap.set("n", "<space>fm", function()
			vim.lsp.buf.format({ async = true })
		end, buffer)
	end,
})

M.on_attach = function(client, bufnr)
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration", bufnr))
	-- vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <CR>", opts("Go To Definition", bufnr))
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation", bufnr))
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Documentation", bufnr))
	-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go To Implementation", bufnr))
	-- vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <CR>", opts("Go To References", bufnr))
	-- vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts("Go To Next Diagnostic", bufnr))
	-- vim.keymap.set("n", "<leader>lr", ":IncRename ", opts("Rename", bufnr))
	-- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions", bufnr))
	--
	-- -- if client.server_capabilities.inlayHintProvider then
	-- -- 	vim.g.inlay_hints_visible = true
	-- -- 	vim.lsp.inlay_hint.enable(bufnr, true)
	-- -- end
	--
	-- if client.supports_method("textDocument/formatting") then
	-- 	vim.keymap.set("n", "<Leader>fm", function()
	-- 		vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	-- 	end, { buffer = bufnr, desc = "[LSP]: Format" })
	--
	-- 	vim.api.nvim_clear_autocmds({ group = augroupFormat, buffer = bufnr })
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		group = augroupFormat,
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			vim.lsp.buf.format({ async = false })
	-- 		end,
	-- 		desc = "[LSP]: Format On Save",
	-- 	})
	-- end

	if client.supports_method("textDocument/rangeFormatting") then
		vim.keymap.set("x", "<Leader>fm", function()
			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
		end, { buffer = bufnr, desc = "[LSP]: Range Format" })
	end

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<leader>lh", function()
			local current_setting = vim.lsp.inlay_hint.is_enabled(bufnr)
			vim.lsp.inlay_hint.enable(bufnr, not current_setting)
		end, opts("Toggle Inlay Hints"))
	end
end

M.capabilities = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}

	return capabilities
end

return M
