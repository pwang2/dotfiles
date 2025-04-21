return {
  {
    "github/copilot.vim",
    enabled = true,
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   init = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.g.copilot_tab_fallback = ""
  --   end,
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
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
        -- adapters = {
        --   copilot = function()
        --     return require("codecompanion.adapters").extend("copilot", {
        --       -- Add any additional configuration options here
        --       -- For example, you can set the adapter to use a specific model
        --       schema = {
        --         model = {
        --           default = "gpt-4o",
        --         },
        --         reasoning_effort = {
        --           default = "medium",
        --         },
        --       },
        --     })
        --   end,
        -- },
        --
        strategies = {
          chat = {
            tools = {
              ["mcp"] = {
                callback = function()
                  return require("mcphub.extensions.codecompanion")
                end,
                description = "Call tools and resources from the MCP Servers",
              },
            },
            keymaps = {
              -- send = { modes = { n = "<CR>", i = "<C-s>" } },
              -- close = { modes = { n = "<C-c>", i = "<C-c>" } },
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
            show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
            -- separator = "─", -- The separator between the different messages in the chat buffer
            show_settings = false,
            start_in_insert_mode = false,
            window = {
              layout = "float", -- float|vertical|horizontal|buffer
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
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
