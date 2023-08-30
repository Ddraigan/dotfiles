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

	-- Trouble Plugin
	["<leader>xx"] = { "<cmd>TroubleToggle<CR>", "Open Trouble" },
	["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
	["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
	["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
	["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Logistics" },
	["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
    }
}

return M
