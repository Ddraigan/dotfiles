local M = {}

-- Creates simpler lua mapping syntax
local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
	opts = vim.tbl_extend("force", outer_opts, opts or {})
	vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.tnoremap = bind("t")
M.inoremap = bind("i")

M.general = {
    n = {
	-- Tmux Remaps
	["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
	["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
	["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
	["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

	-- Better save and quit
	["<leader>w"] = { "<cmd> w!<CR>", "Save" },
	["<leader>qa"] = { "<cmd> confirm qa<CR>", "Quit All" },
	["<leader>qq"] = { "<cmd> q<CR>", "Quit" },

	-- Lsp 
	["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },

	-- Telescope Plugin
	['<leader>fp'] = {"<cmd>Telescope projects<cr>", "Find Projects"},
	['<leader>ff'] = {"<cmd>Telescope find_files<cr>", "Find Files"},
	['<leader>fg'] = {"<cmd>Telescope live_grep<cr>", "Live grep"},
	['<leader>fb'] = {"<cmd>Telescope buffers<cr>", "Find Buffers"},
	['<leader>fh'] = {"<cmd>Telescope help_tags<cr>", "Help Tags"},
	['<leader>sd'] = {"<cmd>Telescope diagnostics<cr>", "Open Diagnostics"},

	-- Trouble Plugin
	["<leader>tt"] = { "<cmd>TroubleToggle<CR>", "Open Trouble" },
	["<leader>tw"] = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
	["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
	["<leader>tq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
	["<leader>tl"] = { "<cmd>TroubleToggle loclist<cr>", "Logistics" },
	["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References with Trouble" },
    }
}

return M
