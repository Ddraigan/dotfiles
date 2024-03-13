vim.g.mapleader = " " -- Set <space> as leader key
vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

local M = {}

M.general = {
	n = {
		-- Tmux Remaps
		["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "window up" },

		-- Better save and quit
		["<leader>w"] = { "<cmd> w! <CR>", "Save" },
		["<leader>qa"] = { "<cmd> confirm qa <CR>", "Quit All" },
		["<leader>qq"] = { "<cmd> q <CR>", "Quit" },

		-- Telescope Plugin
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "[Telescope]: Find Files" },
		["<leader>fs"] = { "<cmd> Telescope live_grep <CR>", "[Telescope]: Find String" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "[Telescope]: Find Buffers" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "[Telescope]: Help Tags" },
		["<leader>fd"] = { "<cmd> Telescope diagnostics <CR>", "[Telescope]: Open Diagnostics" },

		-- Noice Plugin
		["<leader>fn"] = { "<cmd> NoiceTelescope <CR>", "[Telescope/Noice]: Notifcations" },

		-- Trouble Plugin
		["<leader>tt"] = { "<cmd> TroubleToggle <CR>", "[Trouble]: Toggle Menu" },
		["<leader>tw"] = { "<cmd> TroubleToggle workspace_diagnostics <CR>", "[Trouble]: Workspace Diagnostics" },
		["<leader>td"] = { "<cmd> TroubleToggle document_diagnostics <CR>", "[Trouble]: Document Diagnostics" },
		["<leader>tq"] = { "<cmd> TroubleToggle quickfix <CR>", "[Trouble]: Quickfix" },
		["<leader>tl"] = { "<cmd> TroubleToggle loclist <CR>", "[Trouble]: Logistics" },
		["<leader>tr"] = { "<cmd> TroubleToggle lsp_references <CR>", "[Trouble]: References" },
		["<leader>to"] = { "<cmd> TodoTrouble <CR>", "[Trouble]: Todo List" },

		-- Harpoon2 Plugin
		["<leader>ha"] = { "<cmd> lua require('harpoon'):list():append() <CR>", "[Harpoon]: Add File" },
		["<leader>hh"] = {
			"<cmd> lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) <CR>",
			"[Harpoon]: Toggle Menu",
		},
		["<leader>hn"] = { "<cmd> lua require('harpoon'):list():next() <CR>", "[Harpoon]: Nav Next" },
		["<leader>hp"] = { "<cmd> lua require('harpoon'):list():prev() <CR>", "[Harpoon]: Nav Prev" },

		-- Dap Plugin
		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "[DAP]: Toggle Breakpoint" },
		["<leader>dv"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"[DAP]: Open Debugger Sidebar",
		},

		-- Neotest Plugin
		["<leader>nt"] = { "<cmd> lua require('neotest').run.run() <CR>", "[NeoTest]: Run Nearest Test" },

		-- Vim Split
		["<leader>sh"] = { "<cmd> split <CR>", "[Vim]: Split Horizontal" },
		["<leader>sv"] = { "<cmd> vsplit <CR>", "[Vim]: Split Vertical" },
		["<leader>sc"] = { "<C-w>c", "[Vim]: Split Close" },

		-- Nvim-Tree Plugin
		["<leader>-"] = { "<cmd> NvimTreeToggle <CR>", "[Nvim-Tree]: Toggle Tree" },

		-- Lsp_Lines
		["<leader>ll"] = {
			function()
				require("lsp_lines").toggle()
				if vim.diagnostic.config().virtual_text then
					vim.diagnostic.config({
						virtual_text = false,
					})
				else
					vim.diagnostic.config({
						virtual_text = true,
					})
				end
			end,
			"Toggle LSP Lines",
		},
	},
	i = {
		-- LuaSnip Plugn
		["<C-k>"] = {
			function()
				local ls = require("luasnip")
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end,
			"[LuaSnip]: Expand or Jump",
		},

		["<C-j>"] = {
			function()
				local ls = require("luasnip")
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end,
			"[LuaSnip]: Jump",
		},

		["<C-l>"] = {
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			"[LuaSnip]: Change Choice",
		},
	},
	x = {
		-- Pasting does not ovride your clipboard
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

M.setmaps = function(maps)
	for mode, values in pairs(maps) do
		for keybind, mapping_info in pairs(values) do
			local opts = {
				desc = mapping_info[2],
			}
			vim.keymap.set(mode, keybind, mapping_info[1], opts)
		end
	end
end

M.setmaps(M.general)

-- -- Creates simpler lua mapping syntax
-- local function bind(op, outer_opts)
-- 	outer_opts = outer_opts or { noremap = true }
-- 	return function(lhs, rhs, opts)
-- 		opts = vim.tbl_extend("force", outer_opts, opts or {})
-- 		vim.keymap.set(op, lhs, rhs, opts)
-- 	end
-- end
--
-- M.nmap = bind("n", { noremap = false })
-- M.nnoremap = bind("n")
-- M.vnoremap = bind("v")
-- M.xnoremap = bind("x")
-- M.tnoremap = bind("t")
-- M.inoremap = bind("i")
