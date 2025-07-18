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

local function setup_debug_ui()
  local dap = require("dap")
  local dapui = require("dapui")
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
end

local function setup_debug_sign()
  local sign_define = vim.fn.sign_define
  sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign_define("DapBreakpointCondition", { text = "🛑", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign_define("DapLogPoint", { text = "🔷", texthl = "DapLogPoint", linehl = "", numhl = "" })
  sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
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
        build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv dist out",
      },
    },
    opts = {},
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP Toggle Breakpoint",
      },
      {
        "<F8>",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "DAP Run to Cursor",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },
      {
        "<S-F10>",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },
      {
        "<leader>ev",
        function()
          require("dapui").eval()
        end,
        desc = "DAPUI Eval",
        mode = "v",
      },
      {
        "<leader>wa",
        function()
          require("dapui").elements.watches.add()
        end,
        desc = "DAPUI Add Watch",
        mode = "v",
      },
    },
    config = function()
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      setup_debug_ui()
      setup_debug_sign()

      -- https://github.com/mxsdev/nvim-dap-vscode-js
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = {
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
        },
        log_file_path = vim.fn.stdpath("cache") .. "/dap_vscode_js.log",
        log_file_level = 0,
        log_console_level = vim.log.levels.ERROR,
      })

      local dap = require("dap")
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
          args = function()
            local args = {}
            local file = io.open(vim.fn.getcwd() .. "/args.txt", "r")
            if file then
              for line in file:lines() do
                table.insert(args, line)
              end
              file:close()
            end
            return args
          end,
        },
        {
          name = "Attach to process",
          type = "rust", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
          request = "attach",
          pid = require("dap.utils").pick_process,
          args = {},
        },
      }
      require("dap-python").setup("python3")

      -- Find all .dll files in bin/Debug recursively
      local function find_dlls()
        local results = {}
        local function scan(dir)
          local handle = vim.uv.fs_scandir(dir)
          if not handle then
            return
          end
          while true do
            local name, typ = vim.uv.fs_scandir_next(handle)
            if not name then
              break
            end
            local path = dir .. "/" .. name
            if typ == "file" and name:match("%.dll$") then
              table.insert(results, path)
            elseif typ == "directory" then
              scan(path)
            end
          end
        end
        scan(vim.fn.getcwd() .. "/bin/Debug")
        return results
      end

      -- Build the project before debugging
      local function build_project()
        vim.fn.jobstart({ "dotnet", "build" }, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_exit = function(_, code)
            if code ~= 0 then
              vim.schedule(function()
                vim.notify("dotnet build failed", vim.log.levels.ERROR)
              end)
            end
          end,
        })
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            build_project()
            local dlls = find_dlls()
            if #dlls == 0 then
              error("No .dll files found in bin/Debug")
            end
            local co = coroutine.running()
            vim.ui.select(dlls, { prompt = "Select DLL to debug:" }, function(choice)
              coroutine.resume(co, choice)
            end)
            return coroutine.yield()
          end,
          args = {}, -- Add args if needed
          env = {}, -- Add env vars if needed
        },
      }

      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
      }

      --convert keymap above to which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", desc = "DAP Hover" },
        { "<leader>de", "<cmd>lua require('dapui').eval()<CR>", desc = "DAP Eval" },
        { "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", desc = "DAP Toggle UI" },
        { "<leader>dp", "<cmd>lua require('dap.ui.widgets').preview()<CR>", desc = "DAP Preview" },
        { "<leader>df", "<cmd>lua require('dap.ui.widgets').frames()<CR>", desc = "DAP Frames" },
        { "<leader>ds", "<cmd>lua require('dap.ui.widgets').scopes()<CR>", desc = "DAP Scopes" },
      })
    end,
  },
}
