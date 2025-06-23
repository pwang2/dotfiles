return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    -- need to be loaded first or the code completion will not work properly
    lazy = false,
    config = function()
      local opts = { expr = true, silent = true, noremap = true }
      vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', opts)
      vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Dismiss()", opts)
      vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Next()", opts)
      vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Previous()", opts)
    end,
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_integration_id = "vscode-chat"
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "ravitemer/mcphub.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    keys = {
      {
        "<leader>c",
        "<cmd>CodeCompanionChat copilot toggle<cr>",
        desc = "toggle chat window(copilot)",
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
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = os.getenv("DEEPSEEK_API_KEY"),
              },
            })
          end,
        },
        extensions = {
          history = {
            enabled = true,
          },
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

        display = {
          chat = {
            icons = {
              pinned_buffer = "📌 ",
              watched_buffer = "👀 ",
            },
            auto_scroll = false,
            intro_message = "AI will take your job soon.",
            show_header_separator = false,
            separator = "─", -- The separator between the different messages in the chat buffer
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
