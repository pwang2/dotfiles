local function split_string(str, delimiter)
	local segments = {}
	for segment in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(segments, segment)
	end
	return segments
end

local function get_last_segment(str, delimiter)
	local segments = split_string(str, delimiter)
	return segments[#segments] -- Return the last segment
end

local function dap_continue()
	if vim.fn.filereadable(".vscode/launch.json") then
		require("dap.ext.vscode").load_launchjs(nil, { ["pwa-chrome"] = { "vue", "javascript", "typescript" } })
	end
	require("dap").continue()
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			"mxsdev/nvim-dap-vscode-js",
			{
				-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
				"microsoft/vscode-js-debug",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
		},
		opts = {},
		keys = {
			{ "<F5>", dap_continue, desc = "DAP Continue" },
			{ "<leader>g", dap_continue, desc = "DAP Continue" },

			{ "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>" },
			{ "<F9>", "<cmd>lua require('dap').toggle_breakpoint()<cr>" },
			{ "<leader>cc", "<cmd>lua require('dap').run_to_cursor()<cr>" },
			{ "<F8>", "<cmd>lua require('dap').run_to_cursor()<cr>" },
			{ "<F10>", "<cmd>lua require('dap').step_over()<cr>" },
			{ "<F11>", "<cmd>lua require('dap').step_into()<cr>" },
			{ "<S-F10>", "<cmd>lua require('dap').step_out()<cr>" },
			{ "<leader>ev", "<cmd>lua require('dapui').eval()<cr>", mode = "v" },
			{ "<leader>wa", "<cmd>lua require('dapui').elements.watches.add()<cr>", mode = "v" },

			{ "<leader>j", "<cmd>lua require('dap').step_over()<cr>" },
			{ "<leader>k", "<cmd>lua require('dap').step_into()<cr>" },
			{ "<leader>l", "<cmd>lua require('dap').step_out()<cr>" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			require("dap-python").setup("python3")

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

			local sign_define = vim.fn.sign_define
			sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign_define(
				"DapBreakpointCondition",
				{ text = "🛑", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			sign_define("DapLogPoint", { text = "🔷", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			-- https://github.com/mxsdev/nvim-dap-vscode-js
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				-- Path of node executable. Defaults to $NODE_PATH, and then "node"
				node_path = "node",
				-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				-- debugger_cmd = { "js-debug-adapter" },
				-- which adapters to register in nvim-dap
				adapters = {
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
				},
				-- Path for file logging
				log_file_path = vim.fn.stdpath("cache") .. "/dap_vscode_js.log",
				-- Logging level for output to file. Set to false to disable file logging.
				log_file_level = 0,
				-- Logging level for output to console. Set to false to disable console output.
				log_console_level = vim.log.levels.ERROR,
			})

			require("dap.ext.vscode").load_launchjs(nil, { ["pwa-chrome"] = { "vue", "javascript", "typescript" } })

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
						return vim.fn.input("Executable:", vim.fn.getcwd() .. "/target/debug/" .. exe_name, "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
		end,
	},
}
