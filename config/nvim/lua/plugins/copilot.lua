return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    -- need to be loaded first or the code completion will not work properly
    lazy = false,
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_integration_id = "vscode-chat"
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionAction" },
    dependencies = {
      "ravitemer/mcphub.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>c",
        "<cmd>CodeCompanionChat toggle<cr>",
        desc = "toggle chat window",
        noremap = true,
      },
      {
        "<leader>a",
        "<cmd>CodeCompanionAction<cr>",
        desc = "toggle codecompanion action window",
        noremap = true,
      },
    },
    config = function()
      require("codecompanion").setup({
        opts = {
          log_level = "DEBUG", -- or "TRACE"
        },
        extensions = {
          vectorcode = {
            opts = {
              add_tool = true,
              add_slash_command = true,
              tool_opts = {},
            },
          },
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
              make_vars = true, -- make chat #variables from MCP server resources
              make_slash_commands = true, -- make /slash_commands from MCP server prompts
            },
          },
        },

        strategies = {
          chat = {
            roles = {
              ---The header name for the LLM's messages
              ---@type string|fun(adapter: CodeCompanion.Adapter): string
              llm = function(adapter)
                return adapter.formatted_name
              end,

              ---The header name for your messages
              ---@type string
              user = "Peng",
            },
            slash_commands = {
              ["file"] = {
                -- Location to the slash command in CodeCompanion
                callback = "strategies.chat.slash_commands.file",
                description = "Select a file using Telescope",
                opts = {
                  provider = "telescope", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                  contains_code = true,
                },
              },
            },
            tools = {},
          },
        },
        display = {
          chat = {
            icons = {
              pinned_buffer = "📌 ",
              watched_buffer = "👀 ",
            },
            auto_scroll = false,
            intro_message = "AI will take your job soon.",
            show_header_separator = false,
            -- separator = "─", -- The separator between the different messages in the chat buffer
            show_settings = false,
            show_references = true,
            start_in_insert_mode = false,
            window = {
              -- layout = "float", -- float|vertical|horizontal|buffer
              height = 0.8,
              relative = "editor",
              position = "right",
              width = 120,
              border = {
                { "╭", "Comment" },
                { "─", "Comment" },
                { "╮", "Comment" },
                { "│", "Comment" },
                { "╯", "Comment" },
                { "─", "Comment" },
                { "╰", "Comment" },
                { "│", "Comment" },
              },
              opts = {
                signcolumn = "yes",
              },
            },
          },
          action_palette = {
            prompt = "Prompt",
            provider = "default",
          },
        },
      })
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

      vim.api.nvim_create_user_command("CodeCompanionChatSave", save_codecompanion_chat, {})
    end,
  },
}
