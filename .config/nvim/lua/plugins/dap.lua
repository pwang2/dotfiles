local function split_string(str, delimiter)
	local segments = {}
	for segment in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(segments, segment)
	end
	return segments
end

-- Function to get the last segment
local function get_last_segment(str, delimiter)
	local segments = split_string(str, delimiter)
	return segments[#segments] -- Return the last segment
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
		opts = {},
		keys = {
			{ "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>" },
			{ "<leader>g", "<cmd>lua require('dap').continue()<cr>" },
			{ "<leader>cc", "<cmd>lua require('dap').run_to_cursor()<cr>" },
			{ "<leader>si", "<cmd>lua require('dap').step_into()<cr>" },
			{ "<leader>so", "<cmd>lua require('dap').step_over()<cr>" },
			{ "<leader>sO", "<cmd>lua require('dap').step_out()<cr>" },
			{ "<leader>ev", "<cmd>lua require('dapui').eval()<cr>", mode = "v" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("dap-python").setup("python3")
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

			dap.adapters.lldb = {
				type = "server",
				port = 13000,
				executable = {
					command = vim.fn.exepath("codelldb"),
					args = { "--port", "13000" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						local exe_name = get_last_segment(vim.fn.getcwd(), "/")
						-- return vim.fn.input(
						-- 	"Path to executable: ",
						-- 	vim.fn.getcwd() .. "/target/debug/" .. exe_name,
						-- 	"file"
						-- )
						return vim.fn.getcwd() .. "/target/debug/" .. exe_name
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
		end,
	},
}
