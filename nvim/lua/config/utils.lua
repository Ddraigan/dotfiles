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

local function opts(desc, bufnr)
	return { desc = "[LSP]: " .. desc, buffer = bufnr, noremap = true, silent = true }
end

M.on_attach = function(client, bufnr)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration", bufnr))
	vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <CR>", opts("Go To Definition", bufnr))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover", bufnr))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go To Implementation", bufnr))
	vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <CR>", opts("Go To References", bufnr))
	vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts("Go To Next Diagnostic", bufnr))
	vim.keymap.set("n", "<leader>lr", ":IncRename ", opts("Rename", bufnr))
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions", bufnr))
	--[[ vim.keymap.set("n", "<space>fM", function()
					vim.lsp.buf.format({ async = true })
				end, opts("Format", bufnr)) ]]
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
