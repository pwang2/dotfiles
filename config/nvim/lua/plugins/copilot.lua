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
        strategies = {
          chat = {
            tools = {
              ["mcp"] = {
                -- Prevent mcphub from loading before needed
                callback = function()
                  return require("mcphub.extensions.codecompanion")
                end,
                description = "Call tools and resources from the MCP Servers",
              },
            },
            keymaps = {
              send = { modes = { n = "<C-s>", i = "<C-s>" } },
              close = { modes = { n = "<C-c>", i = "<C-c>" } },
            },
          },
        },
        display = {
          chat = {
            icons = {
              pinned_buffer = " ",
              watched_buffer = "👀 ",
            },
            show_settings = true,
            start_in_insert_mode = true,
            window = {
              layout = "float", -- float|vertical|horizontal|buffer
              border = "single",
              height = 0.8,
              relative = "editor",
              position = "right",
              width = 120,
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
