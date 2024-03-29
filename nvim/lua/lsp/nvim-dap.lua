return {
	{
		"mfussenegger/nvim-dap",
		init = function()
			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })

			-- Visual
			-- UfoFoldedEllipsis
			sign("DapStopped", {
				text = "→",
				texthl = "NeogitDiffAddHighlight",
				linehl = "NeogitDiffAddHighlight",
				numhl = "NeogitDiffAddHighlight",
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- vim.api.nvim_create_user_command("DapUiClose", function()
			-- 	dapui.close()
			-- end, {})

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
