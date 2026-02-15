local function save_codecompanion_chat()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local chat_dir = vim.fn.stdpath("data") .. "/codecompanion_chats"
  vim.fn.mkdir(chat_dir, "p")
  local filename = chat_dir .. "/chat_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
  local file = io.open(filename, "w")
  if file then
    for _, line in ipairs(lines) do
      file:write(line .. "\n")
    end
    file:close()
    print("Chat saved to " .. filename)
  else
    print("Error: Could not save chat.")
  end
end

return {
  {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    cmd = "Copilot",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
      --enabled=false,
      init = function()
        vim.g.copilot_nes_debounce = 500
        vim.keymap.set("n", "<tab>", function()
          local bufnr = vim.api.nvim_get_current_buf()
          local state = vim.b[bufnr].nes_state
          if state then
            -- Try to jump to the start of the suggestion edit.
            -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
            local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
              or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
            return nil
          else
            -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
            return "<C-i>"
          end
        end, { desc = "Accept Copilot NES suggestion", expr = true })

        vim.keymap.set("n", "<esc>", function()
          local ok, copilot_nes = pcall(require, "copilot-lsp.nes")
          if ok and copilot_nes.clear() then
            return
          end
          -- fallback to other functionality
        end, { desc = "Clear Copilot suggestion or fallback" })
      end,
    },
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- Disable ghost text since we're using cmp
        panel = { enabled = false }, -- Disable copilot panel
        nes = {
          enabled = false, -- requires copilot-lsp as a dependency
          auto_trigger = false,
          -- keymap = {
          --   accept_and_goto = "<leader>n",
          --   accept = "<leader>i",
          --   dismiss = "<C-e>",
          -- },
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    -- cmd = { "CodeCompanionChat", "CodeCompanionAction", "CodeCompanionHistory" },
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "ravitemer/codecompanion-history.nvim",
      {
        "Davidyz/VectorCode",
        enabled = false,
        version = "*",
        lazy = true,
        cmd = { "VectorCode" },
        build = "uv tool upgrade vectorcode",
      },
    },
    keys = {
      { "<leader>ch", "<cmd>CodeCompanionHistory<cr>", desc = "toggle chat history window(copilot)", noremap = true },
      { "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle chat window(copilot)", noremap = true },
      { "<leader>a", "<cmd>CodeCompanionAction<cr>", desc = "toggle codecompanion action window", noremap = true },
      {
        "ga",
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "add selection to chat context(copilot)",
        noremap = true,
        mode = "v",
      },
    },
    config = function()
      local opts = {
        memory = {
          opts = {
            chat = {
              enabled = true,
            },
          },
        },
        strategies = {
          chat = {
            adapter = "copilot",
            opts = {
              completion_provider = "cmp",
            },
          },
          inline = { adapter = "copilot" },
          agent = { adapter = "copilot" },
        },
        adapters = {
          http = {
            -- copilot = "copilot",
            deepseek = function()
              return require("codecompanion.adapters").extend("deepseek", {
                env = {
                  api_key = os.getenv("DEEPSEEK_API_KEY"),
                },
              })
            end,
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = "copilot",
                ---Model for generating titles (defaults to current chat model)
                model = nil, -- "gpt-4o"
                ---Number of user prompts after which to refresh the title (0 to disable)
                refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                ---Maximum number of times to refresh the title (default: 3)
                max_refreshes = 3,
                format_title = function(original_title)
                  -- this can be a custom function that applies some custom
                  -- formatting to the title.
                  return original_title
                end,
              },
              keymap = "gh",
              save_chat_keymap = "sc",
              auto_save = true,
            },
          },
          vectorcode = {
            enabled = false,
            opts = {
              add_tool = true,
              add_slash_command = true,
              tool_opts = {},
            },
          },
          -- mcphub = {
          --   callback = "mcphub.extensions.codecompanion",
          --   opts = {
          --     show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
          --     make_vars = true, -- make chat #variables from MCP server resources
          --     make_slash_commands = true, -- make /slash_commands from MCP server prompts
          --   },
          -- },
          spinner = {},
        },

        display = {
          chat = {
            icons = {
              pinned_buffer = "📌 ",
              watched_buffer = "👀 ",
              chat_context = "📎️ ",
            },
            auto_scroll = true,
            -- intro_message = "AI will take your job soon.",
            show_header_separator = false,
            separator = "─", -- The separator between the different messages in the chat buffer
            -- show_settings = true,
            show_references = true,
            start_in_insert_mode = false,
            window = {
              relative = "editor",
              position = "right",
              width = 120,
              opts = {
                signcolumn = "yes",
              },
            },
          },
          action_palette = {
            width = 95,
            height = 20,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "default",
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
              title = "CodeCompanion actions", -- The title of the action palette
            },
          },
        },
      }
      require("codecompanion").setup(opts)
      vim.api.nvim_create_user_command("CodeCompanionChatSave", save_codecompanion_chat, {})
      vim.cmd([[ cab cch CodeCompanionHistory ]])
    end,
  },
}
